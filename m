Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEC3B637A;
	Thu,  9 Jul 2026 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626721; cv=pass; b=HTSjrJVGsROwBzAJ4UqJfCnKqN8z00lbXWIc/iZKYtmKWD0hBgaGDT/ZWAZ4Yx15OiZ4WwEa4d62BpdtDYHT8Ozdt/dTLbKmV8dA9WGz99zGLF0HMj/xYD0iSDuL1aCNFdV6bByzu4mmZ2V2LvgegmgFQ4lrjX3Tde68VMucZcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626721; c=relaxed/simple;
	bh=ebpGG836PmusZecO7LnPvUfVniZBvWWA1eFqFhq3J1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJdepyfR/x/sGHqIOjW6J9v4Lg1IjCLB36Wvlg8AfRNshycqKwCbvsDX4nPbh7+w4EJS6wNfo3EUtZhxdYPwNm2rQEtMleBQxuhH0j7jDXoMmuacb/+PWaI22+I713GjqC1uYP0sQjjZmfn6XYgKP1fysO8z3U1eJdiJElFYOvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=cmyvmiN9; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auditcode.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b="cmyvmiN9"
ARC-Seal: i=1; a=rsa-sha256; t=1783626695; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dGC/5qQQg76/cBCEv5alux4cW7kfITvX5r5J69GpuVCxIw90zXoBZWrtxyxkxODqQwfYsP81yLc8tOISzo2D624EOA/0+5lBxyfAoNu/BfNp6UwgadfzZSVXXq6Gh7bo63TUBVqGhPCuOzWGNR21bEushpwmNgx/Us2g6R8ne4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783626695; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=grSJmTjL5O5mtakZeIBBIORMnMNgQk7qWEhuTIaVKSA=; 
	b=Z1H0EVVRyfSgG92F+mmk5VbO1lHNNT++wbSl4XqZvaCs5o/u/uBhHcYXPXdpuZXbxu09uDcf59N8zQWI1SwpsHIXQj7QPByywaQNH+qSKfNq09PMh0uMjkudxTYaq9S2KQtshSvTNKDLbS4LyrB85CiLVvny+uiDk6ZoiSA0ySQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783626695;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=grSJmTjL5O5mtakZeIBBIORMnMNgQk7qWEhuTIaVKSA=;
	b=cmyvmiN9M8V1wubBkMpYEZN3fSN0duaLBb+MyVqlVYe29WY6w5anx/un5m0JBbGu
	K6I7/KVkg4DQXsfD86J3XtYs0PFqNvQ2Wp4VUqAUlyZ0sl1LCXqjf/XmPqzmedhWO/S
	qJ58jXrtaFkpO1Xwj5RKljT0v1lfR/yd5Fil6P+Q=
Received: by mx.zoho.eu with SMTPS id 178362669266466.1759267435757;
	Thu, 9 Jul 2026 21:51:32 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com,
	melissa.srw@gmail.com,
	simona@ffwll.ch
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	luca.ceresoli@bootlin.com,
	harry.wentland@amd.com,
	jose.exposito89@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/vkms: Fix UAF between connector configfs rmdir and .detect
Date: Thu,  9 Jul 2026 21:51:29 +0200
Message-ID: <20260709195129.50856-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709150637.45052-1-security@auditcode.ai>
References: <20260709150637.45052-1-security@auditcode.ai>
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
allow_link() callbacks, all of which refuse the operation with -EBUSY
while the device is enabled, connector_release() has no such guard, and
in fact cannot be given one: release() runs after configfs has already
committed to removing the directory, so it cannot fail the rmdir(2)
syscall with -EBUSY. A connector's configfs directory can therefore be
removed, and its vkms_config_connector freed, at any time while the
device is live and its DRM connector is still being probed.

vkms_connector_detect() is reached from userspace by writing "detect"
to /sys/class/drm/<card>-<conn>/status (drm_sysfs status_store() ->
drm_helper_probe_single_connector_modes() -> .detect), which runs under
drm_device.mode_config.mutex. Nothing prevents this from running at the
same time as the configfs rmdir above, since the two paths take
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

A tempting minimal fix is to have vkms_connector_detect() take the same
configfs device lock (connector->dev->lock) that connector_release()
already holds while unlinking/freeing. That would deadlock:
vkms_destroy() (reached from device_enabled_store() while
connector->dev->lock is held) calls drm_dev_unregister() and
drm_atomic_helper_shutdown(), both of which take
drm_device.mode_config.mutex internally. That establishes lock order
configfs-lock -> mode_config.mutex on the teardown path, while
vkms_connector_detect() always runs already holding mode_config.mutex,
so having it additionally acquire the configfs lock would order it
mode_config.mutex -> configfs-lock, the exact reverse (ABBA).

Fix the race with RCU instead, decoupling the free side from the read
side without introducing a new lock-ordering constraint:

  - vkms_config_create_connector() links with list_add_tail_rcu()
    instead of list_add_tail().
  - vkms_config_destroy_connector() unlinks with list_del_rcu() before
    it destroys the object, then defers the free with kfree_rcu()
    instead of kfree(). It unlinks first so the object is removed from
    the list before it is reclaimed; xa_destroy() of
    connector_cfg->possible_encoders then runs synchronously between the
    unlink and the deferred free, which is safe because no RCU reader
    (i.e. vkms_connector_detect()) ever dereferences that field.
  - A new vkms_config_for_each_connector_rcu() iterator
    (list_for_each_entry_rcu()) is added alongside the existing
    vkms_config_for_each_connector() for the other (non-concurrent,
    configfs-lock-serialized) call sites, and used only in
    vkms_connector_detect(), wrapped in rcu_read_lock()/
    rcu_read_unlock().

This is the same pattern DRM core already uses to let connector
iteration (drm_connector_list_iter) survive concurrent connector
teardown without holding mode_config.mutex across the whole walk; here
it is applied locally to vkms's own configfs connector list, matching
the existing "protect the config lists, use RCU when a reader can't
take the writer's lock" discipline already present in the file.

This patch is scoped to the .detect sink. vkms_config_show(), the read
handler for the "vkms_config" debugfs file, also walks the plane, CRTC,
encoder and connector config lists without any lock or RCU protection,
and is subject to a separate, pre-existing use-after-free against a
concurrent configfs rmdir. Fixing it properly requires RCU-converting
the plane, CRTC and encoder teardown paths too:
vkms_config_destroy_plane(), vkms_config_destroy_crtc() and
vkms_config_destroy_encoder() still free their objects non-RCU (plain
list_del() + kfree()), so the RCU conversion done here for connectors
alone is not enough to make that debugfs walk safe. That is left as a
separate follow-up and is not addressed here.

Verified on a v6.19 KASAN-instrumented build: a detect-hammer vs.
connector-rmdir stress loop reliably tripped a "KASAN: slab-use-after-
free in vkms_connector_detect" report before this patch; with the fix
applied, the same stress loop no longer produces any KASAN report.

Fixes: 466f43885ac0 ("drm/vkms: Allow to update the connector status")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
v2: address sashiko-bot review of v1
(https://lore.kernel.org/dri-devel/20260709150637.45052-1-security@auditcode.ai/):
reorder vkms_config_destroy_connector() to unlink (list_del_rcu) before
destroying components (xa_destroy) for remove-before-reclaim ordering; drop the
v1 claim that vkms_config_show() is safe -- it is a separate pre-existing
lockless-traversal issue, noted as out of scope. No change to the RCU .detect fix.
 drivers/gpu/drm/vkms/vkms_config.c    | 28 ++++++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_config.h    | 22 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c | 16 ++++++++++++++-
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 5a654d6dead8..a44e0567f8a3 100644
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
@@ -607,9 +614,24 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 {
+	/*
+	 * connector_release() (vkms_configfs.c) can free a connector while
+	 * vkms_connector_detect() is concurrently walking the connectors list
+	 * under its own RCU read-side critical section (it cannot take the
+	 * configfs device lock: it already runs under
+	 * drm_device.mode_config.mutex, and vkms_destroy() takes the two
+	 * locks in the opposite order, so plain locking here would deadlock).
+	 *
+	 * Unlink from the list before destroying the object's components, so
+	 * the object is removed before it is reclaimed. After list_del_rcu()
+	 * no new reader can reach it, and the only RCU reader
+	 * (vkms_connector_detect()) never dereferences possible_encoders, so
+	 * tearing that down next is safe. Defer the free to after a grace
+	 * period so concurrent readers never touch freed memory.
+	 */
+	list_del_rcu(&connector_cfg->link);
 	xa_destroy(&connector_cfg->possible_encoders);
-	list_del(&connector_cfg->link);
-	kfree(connector_cfg);
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

