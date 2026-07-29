Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5B41D625
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322241; cv=none; b=KHrspchI8aPRAREdfrLOZRkKt8tIAPRtkCSwXMjbIi1ioSzIawPvLQGenDRCHyPIOBREV1FPrW21lqMJtkNTkXVolB1Gcmr5savt/b4uumkrp+qV791mYKgQmV4/Q0TpYXoXBk0OJk4Zv2UV34vbCDLuCdYk34LPwYvRa5LXC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322241; c=relaxed/simple;
	bh=o0LJ/n4QkoN6SfKrjMiRNq/RA0vaomnwj+WCRKN49Oo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hSj3B+RJT20ols5fzjMKAkAhwtLblBq8TZjo5/o9smXLm3D1T3Bp4aWrIIe8DmuK/rlLojIqXXcbBcRGSWGf0FV3DxmvrzhLDy497MjCeuMxFrKyBl6T7ofktb5O+iVnOJEyf8mYirUdTlven7Z7EC4dpbYkrA7kAaFDtirGv1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2NMw61b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2NMw61b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504701F000E9;
	Wed, 29 Jul 2026 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322239;
	bh=FnDBRTfaLQ1JPyxIRf8WSmbvNUib8OAhKSj7iV2yzBE=;
	h=Subject:To:Cc:From:Date;
	b=x2NMw61bHzWOFGazRJA/XFCpBzcYwglqPncbAhtHGvOsaq4spxVGuvD/1+k4cnSLH
	 Jj6OvIIRPMuJ0VD8uUfdHuXku2DkkLe1HJDgA/Ty6pZQSqdfzKPPpZ3dqtGM3ds+fg
	 IKxVaM7lzUtHhB/uhyNS4nQzAopTLn0gFqC17CFU=
Subject: FAILED: patch "[PATCH] drm/displayid: fix Tiled Display Topology ID size" failed to apply to 6.1-stable tree
To: jani.nikula@intel.com,airlied@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:50:26 +0200
Message-ID: <2026072926-sandbox-plexiglas-bd5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 90c0486a82e27393f9eaf3bb350f51a0bd38cb6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072926-sandbox-plexiglas-bd5e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90c0486a82e27393f9eaf3bb350f51a0bd38cb6b Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 10 Jun 2026 17:15:49 +0300
Subject: [PATCH] drm/displayid: fix Tiled Display Topology ID size

The Tiled Display Topology ID of a DisplayID Tiled Display Topology Data
Block consists of three fields:

- Tiled Display Manufacturer/Vendor ID Field (3 bytes)
- Tiled Display Product ID Code Field (2 bytes)
- Tiled Display Serial Number Field (4 bytes)

i.e. a total of 9 bytes, not 8.

The DisplayID Tiled Display Topology ID is used as the tile group
identifier.

Update both struct displayid_tiled_block topology_id member and struct
drm_tile_group group_data member to full 9 bytes.

The group data was missing the last byte of the serial number. I don't
know whether there are known bug reports that might be linked to this,
but it's plausible the last byte could be the differentiating part for
the tile groups, and fewer tile groups might have been created than
intended.

Fixes: b49b55bd4fba ("drm/displayid: add displayid defines and edid extension (v2)")
Fixes: 138f9ebb9755 ("drm: add tile_group support. (v3)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: stable@vger.kernel.org # v3.19+
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260610141549.555605-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 47dc53c4a738..29634757c06d 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3576,7 +3576,7 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
 /**
  * drm_mode_get_tile_group - get a reference to an existing tile group
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Use the unique bytes to get a reference to an existing tile group.
  *
@@ -3584,14 +3584,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
  * tile group or NULL if not found.
  */
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8])
+					       const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int id;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
 	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
-		if (!memcmp(tg->group_data, topology, 8)) {
+		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {
 			if (!kref_get_unless_zero(&tg->refcount))
 				tg = NULL;
 			mutex_unlock(&dev->mode_config.idr_mutex);
@@ -3606,7 +3606,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
 /**
  * drm_mode_create_tile_group - create a tile group from a displayid description
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Create a tile group for the unique monitor, and get a unique
  * identifier for the tile group.
@@ -3615,7 +3615,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
  * new tile group or NULL.
  */
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8])
+						  const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int ret;
@@ -3625,7 +3625,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 		return NULL;
 
 	kref_init(&tg->refcount);
-	memcpy(tg->group_data, topology, 8);
+	memcpy(tg->group_data, topology_id, sizeof(tg->group_data));
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73516..4590d6a3d821 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -109,7 +109,7 @@ struct displayid_tiled_block {
 	u8 topo[3];
 	u8 tile_size[4];
 	u8 tile_pixel_bezel[5];
-	u8 topology_id[8];
+	u8 topology_id[9];
 } __packed;
 
 struct displayid_detailed_timings_1 {
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae207..877b5ca87e95 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2608,13 +2608,13 @@ struct drm_tile_group {
 	struct kref refcount;
 	struct drm_device *dev;
 	int id;
-	u8 group_data[8];
+	u8 group_data[9];
 };
 
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8]);
+						  const char topology_id[9]);
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8]);
+					       const char topology_id[9]);
 void drm_mode_put_tile_group(struct drm_device *dev,
 			     struct drm_tile_group *tg);
 

