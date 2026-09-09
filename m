Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CA53ECF6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952693; cv=none; b=cYb4yzSPHBGDcPD9/jRDkRkOjnVtjHJFX+kEiwdphRDUstVVWFi9jEwqH8c6ZYl5zNB6ucfO/BM0WMsSXi+v8pqWYvaUj7GQjE7b9oVAFE12W44U/AR2zX8nMWzoC3rDk3Odh/+hmDKVaGwMhz0rYKYuu+CbIPxeCbpBDI6xKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952693; c=relaxed/simple;
	bh=JqKgIEfUe+Sdm7YH5HTOxxpyI7pV+QKtbuZz9mNo2Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJRWCxKBpj5x9HXRLvn0F1ecP3zEQWi1mtNVPAcVoBOlpPF7mWaCuEqloJF4AC46WN8gae31WkYfvCrenMKr8FZsudpjUfXtBR/nagepRJS3FQUxNR7oJNpKDXVwz4iO/6g4jsHXd8qIM/V/D8Pf1wnwTHDxFemixwPAW1YVbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/uGctHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/uGctHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7911F00A3D;
	Wed,  9 Sep 2026 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952687;
	bh=saA0uXadJT1YAxqNBrBiQthw9NeEDNgNdzaY4GCSegQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U/uGctHlnvEQglUe1j+2fL9Whwk1DOIKb07MdwG0iSGAek5ob2cBiTZdnx9H/mpyT
	 2oCFF2gEzOvRrlTi23wBfWUup+NGLpd9sQ7HAI8RYZoHGeSwDsKsibXgn6z+SGe6i6
	 aJTWTTnACNK1ZVpgWLXpcBtgO8pc1DBNaTObJG//Wgvm9nc5A22yS7uIUYt6JL1lgq
	 wcsl41BBXbDWmBDgwpKTKju8Y/TrJf+Bi8/82QvTp0pBU9wx/mXoaHODetLnpo3JHh
	 ZgtRLsOVpRB3qZHjXJk9KwnZK630nTp5e9/Lj5haNioABTspqKMDhkt4zsXhgIMnvw
	 bNRcgJMRjJn6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] driver core: platform: reorder functions
Date: Wed,  9 Sep 2026 07:17:59 -0400
Message-ID: <20260909111805.1804682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-humbling-ninth-d3ad@gregkh>
References: <2026090322-humbling-ninth-d3ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e21d740a3fe5ad2db7b5f5c2331fe2b713b1edba ]

This way all callbacks and structures used to initialize
platform_bus_type are defined just before platform_bus_type and in the
same order. Also move platform_drv_probe_fail just before it's only
user.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20201119124611.2573057-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c | 293 ++++++++++++++++++++--------------------
 1 file changed, 147 insertions(+), 146 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 647066229fec3..fa023cf80dc48 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -772,11 +772,6 @@ static int platform_drv_probe(struct device *_dev)
 	return ret;
 }
 
-static int platform_drv_probe_fail(struct device *_dev)
-{
-	return -ENXIO;
-}
-
 static int platform_drv_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -827,6 +822,11 @@ void platform_driver_unregister(struct platform_driver *drv)
 }
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
+static int platform_drv_probe_fail(struct device *_dev)
+{
+	return -ENXIO;
+}
+
 /**
  * __platform_driver_probe - register driver for non-hotpluggable device
  * @drv: platform driver structure
@@ -1017,109 +1017,6 @@ void platform_unregister_drivers(struct platform_driver * const *drivers,
 }
 EXPORT_SYMBOL_GPL(platform_unregister_drivers);
 
-/* modalias support enables more hands-off userspace setup:
- * (a) environment variable lets new-style hotplug events work once system is
- *     fully running:  "modprobe $MODALIAS"
- * (b) sysfs attribute lets new-style coldplug recover from hotplug events
- *     mishandled before system is fully running:  "modprobe $(cat modalias)"
- */
-static ssize_t modalias_show(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int len;
-
-	len = of_device_modalias(dev, buf, PAGE_SIZE);
-	if (len != -ENODEV)
-		return len;
-
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
-	if (len != -ENODEV)
-		return len;
-
-	return sysfs_emit(buf, "platform:%s\n", pdev->name);
-}
-static DEVICE_ATTR_RO(modalias);
-
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
-static ssize_t numa_node_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
-}
-static DEVICE_ATTR_RO(numa_node);
-
-static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
-		int n)
-{
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
-
-	if (a == &dev_attr_numa_node.attr &&
-			dev_to_node(dev) == NUMA_NO_NODE)
-		return 0;
-
-	return a->mode;
-}
-
-static struct attribute *platform_dev_attrs[] = {
-	&dev_attr_modalias.attr,
-	&dev_attr_numa_node.attr,
-	&dev_attr_driver_override.attr,
-	NULL,
-};
-
-static struct attribute_group platform_dev_group = {
-	.attrs = platform_dev_attrs,
-	.is_visible = platform_dev_attrs_visible,
-};
-__ATTRIBUTE_GROUPS(platform_dev);
-
-static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	struct platform_device	*pdev = to_platform_device(dev);
-	int rc;
-
-	/* Some devices have extra OF data and an OF-style MODALIAS */
-	rc = of_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	rc = acpi_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
-	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
-			pdev->name);
-	return 0;
-}
-
 static const struct platform_device_id *platform_match_id(
 			const struct platform_device_id *id,
 			struct platform_device *pdev)
@@ -1134,44 +1031,6 @@ static const struct platform_device_id *platform_match_id(
 	return NULL;
 }
 
-/**
- * platform_match - bind platform device to platform driver.
- * @dev: device.
- * @drv: driver.
- *
- * Platform device IDs are assumed to be encoded like this:
- * "<name><instance>", where <name> is a short description of the type of
- * device, like "pci" or "floppy", and <instance> is the enumerated
- * instance of the device, like '0' or '42'.  Driver IDs are simply
- * "<name>".  So, extract the <name> from the platform_device structure,
- * and compare it against the name of the driver. Return whether they match
- * or not.
- */
-static int platform_match(struct device *dev, struct device_driver *drv)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct platform_driver *pdrv = to_platform_driver(drv);
-
-	/* When driver_override is set, only bind to the matching driver */
-	if (pdev->driver_override)
-		return !strcmp(pdev->driver_override, drv->name);
-
-	/* Attempt an OF style match first */
-	if (of_driver_match_device(dev, drv))
-		return 1;
-
-	/* Then try ACPI style match */
-	if (acpi_driver_match_device(dev, drv))
-		return 1;
-
-	/* Then try to match against the id table */
-	if (pdrv->id_table)
-		return platform_match_id(pdrv->id_table, pdev) != NULL;
-
-	/* fall-back to driver name match */
-	return (strcmp(pdev->name, drv->name) == 0);
-}
-
 #ifdef CONFIG_PM_SLEEP
 
 static int platform_legacy_suspend(struct device *dev, pm_message_t mesg)
@@ -1316,6 +1175,148 @@ int platform_pm_restore(struct device *dev)
 
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
+/* modalias support enables more hands-off userspace setup:
+ * (a) environment variable lets new-style hotplug events work once system is
+ *     fully running:  "modprobe $MODALIAS"
+ * (b) sysfs attribute lets new-style coldplug recover from hotplug events
+ *     mishandled before system is fully running:  "modprobe $(cat modalias)"
+ */
+static ssize_t modalias_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int len;
+
+	len = of_device_modalias(dev, buf, PAGE_SIZE);
+	if (len != -ENODEV)
+		return len;
+
+	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
+	if (len != -ENODEV)
+		return len;
+
+	return sysfs_emit(buf, "platform:%s\n", pdev->name);
+}
+static DEVICE_ATTR_RO(modalias);
+
+static ssize_t numa_node_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", pdev->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
+
+	ret = driver_set_override(dev, &pdev->driver_override, buf, count);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(driver_override);
+
+static struct attribute *platform_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	&dev_attr_numa_node.attr,
+	&dev_attr_driver_override.attr,
+	NULL,
+};
+
+static umode_t platform_dev_attrs_visible(struct kobject *kobj, struct attribute *a,
+		int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+
+	if (a == &dev_attr_numa_node.attr &&
+			dev_to_node(dev) == NUMA_NO_NODE)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group platform_dev_group = {
+	.attrs = platform_dev_attrs,
+	.is_visible = platform_dev_attrs_visible,
+};
+__ATTRIBUTE_GROUPS(platform_dev);
+
+
+/**
+ * platform_match - bind platform device to platform driver.
+ * @dev: device.
+ * @drv: driver.
+ *
+ * Platform device IDs are assumed to be encoded like this:
+ * "<name><instance>", where <name> is a short description of the type of
+ * device, like "pci" or "floppy", and <instance> is the enumerated
+ * instance of the device, like '0' or '42'.  Driver IDs are simply
+ * "<name>".  So, extract the <name> from the platform_device structure,
+ * and compare it against the name of the driver. Return whether they match
+ * or not.
+ */
+static int platform_match(struct device *dev, struct device_driver *drv)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct platform_driver *pdrv = to_platform_driver(drv);
+
+	/* When driver_override is set, only bind to the matching driver */
+	if (pdev->driver_override)
+		return !strcmp(pdev->driver_override, drv->name);
+
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try ACPI style match */
+	if (acpi_driver_match_device(dev, drv))
+		return 1;
+
+	/* Then try to match against the id table */
+	if (pdrv->id_table)
+		return platform_match_id(pdrv->id_table, pdev) != NULL;
+
+	/* fall-back to driver name match */
+	return (strcmp(pdev->name, drv->name) == 0);
+}
+
+static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct platform_device	*pdev = to_platform_device(dev);
+	int rc;
+
+	/* Some devices have extra OF data and an OF-style MODALIAS */
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	rc = acpi_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
+	add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
+			pdev->name);
+	return 0;
+}
+
 int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
-- 
2.53.0

