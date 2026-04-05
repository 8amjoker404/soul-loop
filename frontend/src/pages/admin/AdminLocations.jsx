import React, { useEffect, useMemo, useState } from "react";
import { toast } from "react-hot-toast";
import { motion, AnimatePresence } from "framer-motion";
import {
  Map,
  Plus,
  Save,
  Search,
  RefreshCw,
  Image as ImageIcon,
  Link2,
  Trash2,
  GitBranch,
  Layers3,
  ArrowDownCircle,
  X,
  ChevronDown,
  Eye
} from "lucide-react";
import PortalLines from "../../components/auth/PortalLines";
import {
  getAdminLocations,
  createAdminLocation,
  updateAdminLocation,
  getLocationConnectors,
  createLocationConnector,
  deleteLocationConnector,
  getWorldMapStructure,
  createShortcutConnector
} from "../../api/adminLocations";
import styles from "./AdminLocations.module.css";

const initialLocationForm = {
  location_id: "",
  description_seed: "",
  danger_level: "",
  region_name: "",
  level_depth: "",
  image: null
};

const initialEditForm = {
  description_seed: "",
  danger_level: "",
  region_name: "",
  level_depth: "",
  image: null
};

const initialConnectorForm = {
  from_location: "",
  to_location: "",
  direction: "",
  min_level_req: 1
};

const initialShortcutForm = {
  from_0: "",
  to_3: ""
};

const DIRECTION_OPTIONS = [
  "UP",
  "DOWN",
  "NORTH",
  "SOUTH",
  "EAST",
  "WEST",
  "LEFT",
  "RIGHT"
];

const dangerOptions = [
  "SAFE",
  "LOW",
  "MEDIUM",
  "HIGH",
  "EXTREME",
  "DEADLY"
];

const CustomSelect = ({
  label,
  name,
  value,
  onChange,
  options = [],
  placeholder = "Choose option",
  valueKey = "value",
  labelKey = "label",
  disabled = false
}) => {
  return (
    <div className={styles.fieldGroup}>
      {label ? <label>{label}</label> : null}

      <div className={styles.selectWrap}>
        <select
          name={name}
          value={value}
          onChange={onChange}
          className={styles.customSelect}
          disabled={disabled}
        >
          <option value="">{placeholder}</option>
          {options.map((option, index) => {
            const optionValue =
              typeof option === "string" ? option : option[valueKey];
            const optionLabel =
              typeof option === "string" ? option : option[labelKey];

            return (
              <option key={`${optionValue}-${index}`} value={optionValue}>
                {optionLabel}
              </option>
            );
          })}
        </select>

        <ChevronDown size={16} className={styles.selectIcon} />
      </div>
    </div>
  );
};

const AdminLocations = () => {
  const [locations, setLocations] = useState([]);
  const [connectors, setConnectors] = useState([]);
  const [mapStructure, setMapStructure] = useState([]);

  const [loadingLocations, setLoadingLocations] = useState(true);
  const [loadingConnectors, setLoadingConnectors] = useState(true);
  const [loadingMap, setLoadingMap] = useState(true);

  const [search, setSearch] = useState("");
  const [selectedLocationId, setSelectedLocationId] = useState("");

  const [locationForm, setLocationForm] = useState(initialLocationForm);
  const [editForm, setEditForm] = useState(initialEditForm);
  const [connectorForm, setConnectorForm] = useState(initialConnectorForm);
  const [shortcutForm, setShortcutForm] = useState(initialShortcutForm);

  const [creatingLocation, setCreatingLocation] = useState(false);
  const [updatingLocation, setUpdatingLocation] = useState(false);
  const [creatingConnector, setCreatingConnector] = useState(false);
  const [creatingShortcut, setCreatingShortcut] = useState(false);
  const [deletingConnectorId, setDeletingConnectorId] = useState(null);

  const [previewImage, setPreviewImage] = useState(null);

  const containerVariants = {
    hidden: { opacity: 0 },
    visible: {
      opacity: 1,
      transition: { staggerChildren: 0.08 }
    }
  };

  const itemVariants = {
    hidden: { y: 18, opacity: 0 },
    visible: { y: 0, opacity: 1 }
  };

  const loadLocations = async () => {
    try {
      setLoadingLocations(true);
      const data = await getAdminLocations();
      setLocations(data?.location_seeds || []);
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to retrieve locations");
    } finally {
      setLoadingLocations(false);
    }
  };

  const loadConnectors = async () => {
    try {
      setLoadingConnectors(true);
      const data = await getLocationConnectors();
      setConnectors(data?.world_paths || []);
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to retrieve connectors");
    } finally {
      setLoadingConnectors(false);
    }
  };

  const loadMapStructure = async () => {
    try {
      setLoadingMap(true);
      const data = await getWorldMapStructure();
      setMapStructure(data?.map_layout || []);
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to retrieve world structure");
    } finally {
      setLoadingMap(false);
    }
  };

  const refreshAll = async () => {
    await Promise.all([loadLocations(), loadConnectors(), loadMapStructure()]);
    toast.success("World data synchronized");
  };

  useEffect(() => {
    refreshAll();
  }, []);

  useEffect(() => {
    if (!selectedLocationId) {
      setEditForm(initialEditForm);
      return;
    }

    const found = locations.find(
      (item) => String(item.location_id) === String(selectedLocationId)
    );

    if (found) {
      setEditForm({
        description_seed: found.description_seed || "",
        danger_level: found.danger_level || "",
        region_name: found.region_name || "",
        level_depth: found.level_depth ?? "",
        image: null
      });
    }
  }, [selectedLocationId, locations]);

  useEffect(() => {
    const handleEscape = (e) => {
      if (e.key === "Escape") {
        setPreviewImage(null);
      }
    };

    window.addEventListener("keydown", handleEscape);
    return () => window.removeEventListener("keydown", handleEscape);
  }, []);

  const filteredLocations = useMemo(() => {
    const term = search.trim().toLowerCase();

    if (!term) return locations;

    return locations.filter((item) => {
      return (
        String(item.location_id || "").toLowerCase().includes(term) ||
        String(item.region_name || "").toLowerCase().includes(term) ||
        String(item.description_seed || "").toLowerCase().includes(term) ||
        String(item.danger_level || "").toLowerCase().includes(term)
      );
    });
  }, [locations, search]);

  const locationOptions = useMemo(() => {
    return locations.map((item) => ({
      value: item.location_id,
      label: `${item.location_id}${item.region_name ? ` • ${item.region_name}` : ""}`
    }));
  }, [locations]);

  const handleLocationFormChange = (e) => {
    const { name, value, files } = e.target;

    if (name === "image") {
      setLocationForm((prev) => ({
        ...prev,
        image: files?.[0] || null
      }));
      return;
    }

    setLocationForm((prev) => ({
      ...prev,
      [name]: value
    }));
  };

  const handleEditFormChange = (e) => {
    const { name, value, files } = e.target;

    if (name === "image") {
      setEditForm((prev) => ({
        ...prev,
        image: files?.[0] || null
      }));
      return;
    }

    setEditForm((prev) => ({
      ...prev,
      [name]: value
    }));
  };

  const handleConnectorFormChange = (e) => {
    const { name, value } = e.target;
    setConnectorForm((prev) => ({
      ...prev,
      [name]: value
    }));
  };

  const handleShortcutFormChange = (e) => {
    const { name, value } = e.target;
    setShortcutForm((prev) => ({
      ...prev,
      [name]: value
    }));
  };

  const handleCreateLocation = async (e) => {
    e.preventDefault();

    if (
      !locationForm.location_id ||
      !locationForm.description_seed ||
      !locationForm.danger_level
    ) {
      toast.error("Fill location ID, description seed, and danger level");
      return;
    }

    try {
      setCreatingLocation(true);
      const response = await createAdminLocation(locationForm);
      toast.success(response?.message || "Location created");
      setLocationForm(initialLocationForm);
      await loadLocations();
      await loadMapStructure();
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to create location");
    } finally {
      setCreatingLocation(false);
    }
  };

  const handleUpdateLocation = async (e) => {
    e.preventDefault();

    if (!selectedLocationId) {
      toast.error("Select a location to update");
      return;
    }

    try {
      setUpdatingLocation(true);
      const response = await updateAdminLocation(selectedLocationId, editForm);
      toast.success(response?.message || "Location updated");
      await loadLocations();
      await loadMapStructure();
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to update location");
    } finally {
      setUpdatingLocation(false);
    }
  };

  const handleCreateConnector = async (e) => {
    e.preventDefault();

    if (
      !connectorForm.from_location ||
      !connectorForm.to_location ||
      !connectorForm.direction
    ) {
      toast.error("Fill from location, to location, and direction");
      return;
    }

    try {
      setCreatingConnector(true);
      const response = await createLocationConnector({
        ...connectorForm,
        direction: String(connectorForm.direction).toUpperCase(),
        min_level_req: Number(connectorForm.min_level_req) || 1
      });
      toast.success(response?.message || "Connector created");
      setConnectorForm(initialConnectorForm);
      await loadConnectors();
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to create connector");
    } finally {
      setCreatingConnector(false);
    }
  };

  const handleDeleteConnector = async (connectorId) => {
    try {
      setDeletingConnectorId(connectorId);
      const response = await deleteLocationConnector(connectorId);
      toast.success(response?.message || "Connector removed");
      await loadConnectors();
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to delete connector");
    } finally {
      setDeletingConnectorId(null);
    }
  };

  const handleCreateShortcut = async (e) => {
    e.preventDefault();

    if (!shortcutForm.from_0 || !shortcutForm.to_3) {
      toast.error("Fill the depth 0 location and depth 3 location");
      return;
    }

    try {
      setCreatingShortcut(true);
      const response = await createShortcutConnector(shortcutForm);
      toast.success(response?.message || "Shortcut created");
      setShortcutForm(initialShortcutForm);
      await loadConnectors();
    } catch (error) {
      toast.error(error?.response?.data?.error || "Failed to create shortcut");
    } finally {
      setCreatingShortcut(false);
    }
  };

  return (
    <div className={styles.adminPage}>
      <PortalLines />
      <div className={styles.adminSmoke}></div>

      <motion.div
        className={styles.adminShell}
        initial="hidden"
        animate="visible"
        variants={containerVariants}
      >
        <div className={styles.glassPanel}>
          <header className={styles.header}>
            <div className={styles.headerTop}>
              <div>
                <p className={styles.accessLabel}>ACCESS: WORLD ARCHITECT</p>
                <h1 className={styles.rootTitle}>Zone Management</h1>
                <p className={styles.subText}>
                  Manage zone seeds, region depth, world connectors, shortcut paths,
                  and location image previews in one place.
                </p>
              </div>

              <button className={styles.refreshBtn} onClick={refreshAll} type="button">
                <RefreshCw size={16} />
                Reload World
              </button>
            </div>
          </header>

          <div className={styles.topBar}>
            <div className={styles.searchWrap}>
              <Search size={16} />
              <input
                type="text"
                placeholder="Search location, danger, region..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className={styles.searchInput}
              />
            </div>

            <div className={styles.topStats}>
              <div className={styles.topStat}>
                <Layers3 size={16} />
                <span>{locations.length} Zones</span>
              </div>
              <div className={styles.topStat}>
                <GitBranch size={16} />
                <span>{connectors.length} Paths</span>
              </div>
            </div>
          </div>

          <div className={styles.mainGrid}>
            <motion.div className={styles.leftColumn} variants={itemVariants}>
              <div className={styles.panelCard}>
                <div className={styles.panelHead}>
                  <Plus size={18} />
                  <h3>Manifest New Zone</h3>
                </div>

                <form className={styles.form} onSubmit={handleCreateLocation}>
                  <div className={styles.fieldGroup}>
                    <label>Location ID</label>
                    <input
                      type="text"
                      name="location_id"
                      value={locationForm.location_id}
                      onChange={handleLocationFormChange}
                      placeholder="e.g. elroe_upper"
                    />
                  </div>

                  <div className={styles.fieldGroup}>
                    <label>Description Seed</label>
                    <textarea
                      name="description_seed"
                      value={locationForm.description_seed}
                      onChange={handleLocationFormChange}
                      placeholder="Describe the zone..."
                      rows={4}
                    />
                  </div>

                  <div className={styles.twoCols}>
                    <CustomSelect
                      label="Danger Level"
                      name="danger_level"
                      value={locationForm.danger_level}
                      onChange={handleLocationFormChange}
                      options={dangerOptions}
                      placeholder="Choose danger"
                    />

                    <div className={styles.fieldGroup}>
                      <label>Region Name</label>
                      <input
                        type="text"
                        name="region_name"
                        value={locationForm.region_name}
                        onChange={handleLocationFormChange}
                        placeholder="e.g. elroe_labyrinth"
                      />
                    </div>
                  </div>

                  <div className={styles.twoCols}>
                    <div className={styles.fieldGroup}>
                      <label>Level Depth</label>
                      <input
                        type="number"
                        name="level_depth"
                        value={locationForm.level_depth}
                        onChange={handleLocationFormChange}
                        placeholder="0"
                      />
                    </div>

                    <div className={styles.fieldGroup}>
                      <label>Zone Image</label>
                      <label className={styles.fileInput}>
                        <ImageIcon size={16} />
                        <span>
                          {locationForm.image ? locationForm.image.name : "Choose image"}
                        </span>
                        <input
                          type="file"
                          name="image"
                          accept="image/*"
                          onChange={handleLocationFormChange}
                        />
                      </label>
                    </div>
                  </div>

                  <button
                    type="submit"
                    className={styles.actionBtn}
                    disabled={creatingLocation}
                  >
                    <Plus size={16} />
                    {creatingLocation ? "Manifesting..." : "Create Location"}
                  </button>
                </form>
              </div>

              <div className={styles.panelCard}>
                <div className={styles.panelHead}>
                  <Save size={18} />
                  <h3>Reconfigure Zone</h3>
                </div>

                <form className={styles.form} onSubmit={handleUpdateLocation}>
                  <CustomSelect
                    label="Select Location"
                    name="selectedLocationId"
                    value={selectedLocationId}
                    onChange={(e) => setSelectedLocationId(e.target.value)}
                    options={locationOptions}
                    placeholder="Choose location"
                  />

                  <div className={styles.fieldGroup}>
                    <label>Description Seed</label>
                    <textarea
                      name="description_seed"
                      value={editForm.description_seed}
                      onChange={handleEditFormChange}
                      placeholder="Update description..."
                      rows={4}
                    />
                  </div>

                  <div className={styles.twoCols}>
                    <CustomSelect
                      label="Danger Level"
                      name="danger_level"
                      value={editForm.danger_level}
                      onChange={handleEditFormChange}
                      options={dangerOptions}
                      placeholder="Choose danger"
                    />

                    <div className={styles.fieldGroup}>
                      <label>Region Name</label>
                      <input
                        type="text"
                        name="region_name"
                        value={editForm.region_name}
                        onChange={handleEditFormChange}
                        placeholder="region name"
                      />
                    </div>
                  </div>

                  <div className={styles.twoCols}>
                    <div className={styles.fieldGroup}>
                      <label>Level Depth</label>
                      <input
                        type="number"
                        name="level_depth"
                        value={editForm.level_depth}
                        onChange={handleEditFormChange}
                        placeholder="depth"
                      />
                    </div>

                    <div className={styles.fieldGroup}>
                      <label>Replace Image</label>
                      <label className={styles.fileInput}>
                        <ImageIcon size={16} />
                        <span>
                          {editForm.image ? editForm.image.name : "Choose image"}
                        </span>
                        <input
                          type="file"
                          name="image"
                          accept="image/*"
                          onChange={handleEditFormChange}
                        />
                      </label>
                    </div>
                  </div>

                  <button
                    type="submit"
                    className={styles.actionBtn}
                    disabled={updatingLocation}
                  >
                    <Save size={16} />
                    {updatingLocation ? "Updating..." : "Update Location"}
                  </button>
                </form>
              </div>

              <div className={styles.panelCard}>
                <div className={styles.panelHead}>
                  <Link2 size={18} />
                  <h3>Create Connector</h3>
                </div>

                <form className={styles.form} onSubmit={handleCreateConnector}>
                  <div className={styles.twoCols}>
                    <CustomSelect
                      label="From Location"
                      name="from_location"
                      value={connectorForm.from_location}
                      onChange={handleConnectorFormChange}
                      options={locationOptions}
                      placeholder="Choose start"
                    />

                    <CustomSelect
                      label="To Location"
                      name="to_location"
                      value={connectorForm.to_location}
                      onChange={handleConnectorFormChange}
                      options={locationOptions}
                      placeholder="Choose destination"
                    />
                  </div>

                  <div className={styles.twoCols}>
                    <CustomSelect
                      label="Direction"
                      name="direction"
                      value={connectorForm.direction}
                      onChange={handleConnectorFormChange}
                      options={DIRECTION_OPTIONS}
                      placeholder="Choose direction"
                    />

                    <div className={styles.fieldGroup}>
                      <label>Min Level Req</label>
                      <input
                        type="number"
                        name="min_level_req"
                        value={connectorForm.min_level_req}
                        onChange={handleConnectorFormChange}
                        placeholder="1"
                        min="1"
                      />
                    </div>
                  </div>

                  <button
                    type="submit"
                    className={styles.actionBtn}
                    disabled={creatingConnector}
                  >
                    <Link2 size={16} />
                    {creatingConnector ? "Linking..." : "Create Connector"}
                  </button>
                </form>
              </div>

              <div className={styles.panelCard}>
                <div className={styles.panelHead}>
                  <ArrowDownCircle size={18} />
                  <h3>Create Depth Shortcut</h3>
                </div>

                <form className={styles.form} onSubmit={handleCreateShortcut}>
                  <div className={styles.twoCols}>
                    <CustomSelect
                      label="From Depth 0"
                      name="from_0"
                      value={shortcutForm.from_0}
                      onChange={handleShortcutFormChange}
                      options={locations
                        .filter((item) => Number(item.level_depth) === 0)
                        .map((item) => ({
                          value: item.location_id,
                          label: item.location_id
                        }))}
                      placeholder="Choose depth 0"
                    />

                    <CustomSelect
                      label="To Depth 3"
                      name="to_3"
                      value={shortcutForm.to_3}
                      onChange={handleShortcutFormChange}
                      options={locations
                        .filter((item) => Number(item.level_depth) === 3)
                        .map((item) => ({
                          value: item.location_id,
                          label: item.location_id
                        }))}
                      placeholder="Choose depth 3"
                    />
                  </div>

                  <button
                    type="submit"
                    className={styles.actionBtn}
                    disabled={creatingShortcut}
                  >
                    <ArrowDownCircle size={16} />
                    {creatingShortcut ? "Opening..." : "Create Shortcut"}
                  </button>
                </form>
              </div>
            </motion.div>

            <motion.div className={styles.rightColumn} variants={itemVariants}>
              <div className={styles.fixedPanelCard}>
                <div className={styles.panelHead}>
                  <Map size={18} />
                  <h3>World Zones</h3>
                </div>

                <div className={styles.scrollBody}>
                  {loadingLocations ? (
                    <div className={styles.emptyState}>Loading zones...</div>
                  ) : filteredLocations.length === 0 ? (
                    <div className={styles.emptyState}>No locations found.</div>
                  ) : (
                    <div className={styles.locationList}>
                      {filteredLocations.map((item) => (
                        <div className={styles.locationCard} key={item.location_id}>
                          <div className={styles.locationTop}>
                            <div>
                              <h4>{item.location_id}</h4>
                              <p>{item.region_name || "Unknown Region"}</p>
                            </div>
                            <span className={styles.dangerBadge}>
                              {item.danger_level || "UNKNOWN"}
                            </span>
                          </div>

                          <p className={styles.locationDesc}>
                            {item.description_seed || "No description seed available."}
                          </p>

                          <div className={styles.locationMeta}>
                            <span>Depth: {item.level_depth ?? 0}</span>

                            {item.location_image ? (
                              <button
                                type="button"
                                className={styles.previewBtn}
                                onClick={() =>
                                  setPreviewImage({
                                    src: item.location_image,
                                    title: item.location_id
                                  })
                                }
                              >
                                <Eye size={14} />
                                Preview Image
                              </button>
                            ) : (
                              <span>No Image</span>
                            )}
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>

              <div className={styles.fixedPanelCard}>
                <div className={styles.panelHead}>
                  <GitBranch size={18} />
                  <h3>World Connectors</h3>
                </div>

                <div className={styles.scrollBody}>
                  {loadingConnectors ? (
                    <div className={styles.emptyState}>Loading connectors...</div>
                  ) : connectors.length === 0 ? (
                    <div className={styles.emptyState}>No world connectors yet.</div>
                  ) : (
                    <div className={styles.connectorList}>
                      {connectors.map((item) => (
                        <div className={styles.connectorCard} key={item.connector_id}>
                          <div className={styles.connectorTop}>
                            <div>
                              <h4>
                                {item.from_location} → {item.to_location}
                              </h4>
                              <p>
                                Direction: {item.direction} • Min Level: {item.min_level_req}
                              </p>
                            </div>

                            <button
                              type="button"
                              className={styles.deleteBtn}
                              onClick={() => handleDeleteConnector(item.connector_id)}
                              disabled={deletingConnectorId === item.connector_id}
                            >
                              <Trash2 size={15} />
                            </button>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>

              <div className={styles.fixedPanelCard}>
                <div className={styles.panelHead}>
                  <Layers3 size={18} />
                  <h3>World Structure</h3>
                </div>

                <div className={styles.scrollBody}>
                  {loadingMap ? (
                    <div className={styles.emptyState}>Loading structure...</div>
                  ) : mapStructure.length === 0 ? (
                    <div className={styles.emptyState}>No map structure found.</div>
                  ) : (
                    <div className={styles.structureList}>
                      {mapStructure.map((item, index) => (
                        <div
                          className={styles.structureRow}
                          key={`${item.location_id}-${index}`}
                        >
                          <div>
                            <h4>{item.location_id}</h4>
                            <p>{item.region_name}</p>
                          </div>
                          <div className={styles.structureMeta}>
                            <span>Depth {item.level_depth}</span>
                            <span>{item.danger_level}</span>
                          </div>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              </div>
            </motion.div>
          </div>
        </div>
      </motion.div>

      <AnimatePresence>
        {previewImage ? (
          <motion.div
            className={styles.modalOverlay}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setPreviewImage(null)}
          >
            <motion.div
              className={styles.modalCard}
              initial={{ scale: 0.94, opacity: 0, y: 18 }}
              animate={{ scale: 1, opacity: 1, y: 0 }}
              exit={{ scale: 0.96, opacity: 0, y: 14 }}
              transition={{ duration: 0.2 }}
              onClick={(e) => e.stopPropagation()}
            >
              <div className={styles.modalHeader}>
                <div>
                  <p className={styles.modalLabel}>ZONE IMAGE PREVIEW</p>
                  <h3>{previewImage.title}</h3>
                </div>

                <button
                  type="button"
                  className={styles.modalClose}
                  onClick={() => setPreviewImage(null)}
                >
                  <X size={18} />
                </button>
              </div>

              <div className={styles.modalImageWrap}>
                <img
                  src={previewImage.src}
                  alt={previewImage.title}
                  className={styles.modalImage}
                />
              </div>
            </motion.div>
          </motion.div>
        ) : null}
      </AnimatePresence>
    </div>
  );
};

export default AdminLocations;