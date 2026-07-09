Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671A846F;
	Thu,  9 Jul 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609624; cv=pass; b=EJY58WUMLdQbfca9YiYxsdpRAyj/NFpn00GDKjtzgG4sCL1DpEskGQU4YKF76kBAgV8EGcdDZ0tGffCYS4sxeDGlf6OwBpvHtb3wQqT2Yx0sfWbFfWKF3BryCyCb3XVENUwpAoiczRtcmjOuPvhZ+Kj4qUTvq0EW5GdjRQZTkyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609624; c=relaxed/simple;
	bh=V7XMv4IW+dxzgNl+HpT8HkBZtpxwKoRqfnvm+UlugAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JadVZOW2idtSXnqLy2gRnLS2A12OO6yBgP+SHPi175r9iGhDvategWL5A7+QSj+qv//i5VzdMs7zWH8Ua1cMgf9W81coWOA8mxh1ZT3O68o3SDTp2j5MgEWZdsKdD/2duGIl76YOk4Z7h/STmK9QUVwffPeTv7FGmdz5HEYfBB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=OiSOxZG5; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="OiSOxZG5"
ARC-Seal: i=1; a=rsa-sha256; t=1783609602; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bxMhCSndrTPbiXutp3JpcTB6DJT8HS8+yBm3kTPGhXMKmgPqgQykrsCXQjBYtdPNM11PwsK3/O9alfKscl28TW0i2a6JP8KplfGkcsq78XrTtDAl8DYrIYQL8e4wCxkF1OrE1u9V3LpNFJECvmiV7VxWbSAum8rQY0sUqvkYH7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783609602; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dU/tfwOeO64+A6gpR2HzOKHj6gjiaxXJHW6wL6osLFU=; 
	b=CFieQ7KBfqf7OAhr9aRDH6UkS4v1w1T4bHEIAG4+UFRbo543W+RXmsPNMSvWduS7DhKolOiXFjPCCUwCIXWb6utc990KdZHn9uHx0ZGTWrxT1XWR4PyXcsYx2UXbzgjagdL+ACW1A6XufynC0s65o+5m38kD/4BpM7od5xAhHlI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783609602;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dU/tfwOeO64+A6gpR2HzOKHj6gjiaxXJHW6wL6osLFU=;
	b=OiSOxZG5qLZvgxyt5xAEycldbqS7ChfQ5MvBCYChuM2WxCZHG4nBV9dQ4tbRerTH
	EAHZ2za4PgajoT3Fq4+KGDmx8+0nOnYl/0mb4tRxcIEgUx7VNpm5ZSD3CMX4G+o/ykl
	umyCwRL9l4UzGq4JJ1ih1gK2E736JeQc48HubXeE=
Received: by mx.zoho.eu with SMTPS id 1783609599393109.58392450467716;
	Thu, 9 Jul 2026 17:06:39 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/vkms: Fix UAF between connector configfs rmdir and .detect
Date: Thu,  9 Jul 2026 17:06:37 +0200
Message-ID: <20260709150637.45052-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

vkms_connector_detect() walks config->connectors via
vkms_config_for_each_connector(), which expands to a plain
list_for_each_entry() over vkms_config::connectors with no lock and no
RCU protection.

Concurrently, rmdir'ing a connector's configfs directory calls
connector_release(), which takes the configfs device mutex
(connector->dev->lock) and calls vkms_config_destroy_connector(),
which does:

	list_del(&connector_cfg->link);
	kfree(connector_cfg);

Unlike make_crtc_group()/make_plane_group()/make_encoder_group()/
make_connector_group() and the possible_crtcs/possible_encoders
allow_link() callbacks -- all of which refuse the operation with
-EBUSY while the device is enabled -- connector_release() has no such
guard, and in fact cannot be given one: release() runs after configfs
has already committed to removing the directory, so it cannot fail the
rmdir(2) syscall with -EBUSY. A connector's configfs directory can
therefore be removed, and its vkms_config_connector freed, at any time
while the device is live and its DRM connector is still being probed.

vkms_connector_detect() is reached from userspace by writing "detect"
to /sys/class/drm/<card>-<conn>/status (drm_sysfs status_store() ->
drm_helper_probe_single_connector_modes() -> .detect), which runs under
drm_device.mode_config.mutex. Nothing prevents this from running at
the same time as the configfs rmdir above, since the two paths take
entirely different locks (configfs connector->dev->lock vs. DRM's
mode_config.mutex) over the same vkms_config_connector object. Both
sides require local root/CAP_SYS_ADMIN: the vkms configfs tree is
root-owned (0755) and the connector's sysfs status attribute is
root-writable by default, so this is a local-root race, not an
unprivileged-user or remote issue.

The result is a classic race-into-use-after-free: the unlocked iterator
dereferences connector_cfg->connector or follows connector_cfg->link
into memory that connector_release() has already kfree()'d, or reads
connector_cfg->status out of freed memory. This reproduces as a KASAN
slab-use-after-free in vkms_connector_detect() under a detect-hammer
vs. connector-rmdir stress loop.

A tempting minimal fix is to have vkms_connector_detect() take the
same configfs device lock (connector->dev->lock) that
connector_release() already holds while unlinking/freeing. That would
deadlock: vkms_destroy() (reached from device_enabled_store() while
connector->dev->lock is held) calls drm_dev_unregister() and
drm_atomic_helper_shutdown(), both of which take
drm_device.mode_config.mutex internally. That establishes lock order
configfs-lock -> mode_config.mutex on the teardown path, while
vkms_connector_detect() always runs already holding
mode_config.mutex -- so having it additionally acquire the configfs
lock would order it mode_config.mutex -> configfs-lock, the exact
reverse (ABBA).

Fix the race with RCU instead, decoupling the free side from the read
side without introducing a new lock-ordering constraint:

  - vkms_config_create_connector() links with list_add_tail_rcu()
    instead of list_add_tail().
  - vkms_config_destroy_connector() unlinks with list_del_rcu() instead
    of list_del(), and defers the actual free with kfree_rcu() instead
    of kfree(). xa_destroy() of connector_cfg->possible_encoders still
    runs synchronously, which is safe because no RCU reader (i.e.
    vkms_connector_detect()) ever touches that field.
  - A new vkms_config_for_each_connector_rcu() iterator
    (list_for_each_entry_rcu()) is added alongside the existing
    vkms_config_for_each_connector() for the other (non-concurrent,
    configfs-lock-serialized) call sites, and used only in
    vkms_connector_detect(), wrapped in rcu_read_lock()/
    rcu_read_unlock().

This is the same pattern DRM core already uses to let connector
iteration (drm_connector_list_iter) survive concurrent connector
teardown without holding mode_config.mutex across the whole walk;
here it is applied locally to vkms's own configfs connector list,
matching the existing "protect the config lists, use RCU when a
reader can't take the writer's lock" discipline already present in
the file.

No other vkms_config_for_each_connector() call site (vkms_output.c,
vkms_config.c is_valid()/debugfs helpers) races a concurrent free:
they all run either at device-build time (single-threaded) or already
under connector->dev->lock, so they are left untouched to keep the fix
minimal and scoped to the reported sink.

Verified on a v6.19 KASAN-instrumented build: a detect-hammer vs.
connector-rmdir stress loop reliably tripped a "KASAN: slab-use-after-
free in vkms_connector_detect" report before this patch; with the fix
applied, the same stress loop no longer produces any KASAN report.

Fixes: 466f43885ac0 ("drm/vkms: Allow to update the connector status")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/gpu/drm/vkms/vkms_config.c    | 24 +++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_config.h    | 22 ++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c | 16 +++++++++++++++-
 3 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5a654d6dead8..fc402cf48775 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 #include <linux/slab.h>
 
 #include <drm/drm_print.h>
@@ -599,7 +601,12 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->status = connector_status_connected;
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
-	list_add_tail(&connector_cfg->link, &config->connectors);
+	/*
+	 * Paired with vkms_config_for_each_connector_rcu() in
+	 * vkms_connector_detect(), which may walk this list without holding
+	 * the configfs device lock.
+	 */
+	list_add_tail_rcu(&connector_cfg->link, &config->connectors);
 
 	return connector_cfg;
 }
@@ -608,8 +615,19 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 {
 	xa_destroy(&connector_cfg->possible_encoders);
-	list_del(&connector_cfg->link);
-	kfree(connector_cfg);
+
+	/*
+	 * connector_release() (vkms_configfs.c) can free a connector while
+	 * vkms_connector_detect() is concurrently walking the connectors list
+	 * under its own RCU read-side critical section (it cannot take the
+	 * configfs device lock: it already runs under
+	 * drm_device.mode_config.mutex, and vkms_destroy() takes the two
+	 * locks in the opposite order, so plain locking here would deadlock).
+	 * Unlink with the RCU-safe primitive and defer the free to after a
+	 * grace period so concurrent readers never dereference freed memory.
+	 */
+	list_del_rcu(&connector_cfg->link);
+	kfree_rcu(connector_cfg, rcu);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8f7f286a4bdd..127076a9280b 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONFIG_H_
 
 #include <linux/list.h>
+#include <linux/rculist.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
@@ -108,6 +109,9 @@ struct vkms_config_encoder {
  *             It can be used to store a temporary reference to a VKMS connector
  *             during device creation. This pointer is not managed by the
  *             configuration and must be managed by other means.
+ * @rcu: Used to free the connector configuration after a grace period, so that
+ *       vkms_config_for_each_connector_rcu() readers (e.g. .detect) can safely
+ *       run concurrently with configfs teardown (see vkms_config_destroy_connector()).
  */
 struct vkms_config_connector {
 	struct list_head link;
@@ -118,6 +122,8 @@ struct vkms_config_connector {
 
 	/* Internal usage */
 	struct vkms_connector *connector;
+
+	struct rcu_head rcu;
 };
 
 /**
@@ -152,6 +158,22 @@ struct vkms_config_connector {
 #define vkms_config_for_each_connector(config, connector_cfg) \
 	list_for_each_entry((connector_cfg), &(config)->connectors, link)
 
+/**
+ * vkms_config_for_each_connector_rcu - RCU-safe iteration over the vkms_config
+ * connectors
+ * @config: &struct vkms_config pointer
+ * @connector_cfg: &struct vkms_config_connector pointer used as cursor
+ *
+ * Unlike vkms_config_for_each_connector(), this may be used without holding
+ * the configfs device lock, from contexts (such as &drm_connector_funcs.detect)
+ * that must not block on it. Callers must wrap the iteration in
+ * rcu_read_lock() / rcu_read_unlock(); see vkms_config_destroy_connector(),
+ * which pairs with this by unlinking with list_del_rcu() and freeing with
+ * kfree_rcu().
+ */
+#define vkms_config_for_each_connector_rcu(config, connector_cfg) \
+	list_for_each_entry_rcu((connector_cfg), &(config)->connectors, link)
+
 /**
  * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
  * possible CRTCs
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b0a6b212d3f4..c43948de2b01 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <linux/rcupdate.h>
+
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
@@ -26,10 +28,22 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 	 */
 	status = connector->status;
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+	/*
+	 * configfs can free connector_cfg concurrently (connector_release() ->
+	 * vkms_config_destroy_connector(), on an rmdir of the connector's
+	 * configfs directory) without taking drm_device.mode_config.mutex,
+	 * which this .detect callback is always called under. Walk the RCU-
+	 * protected list instead of taking the configfs device lock here: the
+	 * two locks are already nested in the opposite order by
+	 * vkms_destroy(), so acquiring the configfs lock from under
+	 * mode_config.mutex would deadlock.
+	 */
+	rcu_read_lock();
+	vkms_config_for_each_connector_rcu(vkmsdev->config, connector_cfg) {
 		if (connector_cfg->connector == vkms_connector)
 			status = vkms_config_connector_get_status(connector_cfg);
 	}
+	rcu_read_unlock();
 
 	return status;
 }
-- 
2.50.1 (Apple Git-155)

