Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A8B437455
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515934; cv=none; b=DZByxLFiolaD4RqcsXeqCEJimz/Xa10uEUjJCyer31JZyqsMJGU+4VnBt/Xyl26iWpRBhEVVzUTpMVjw1X/I2ngNssHnU114G7OF9qwezhIkbnt6fk6P+vMNPjGnh9hPvsScKrpQIiDRKXTBoNbSML7X9L/uTqNKglvC5+k/Q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515934; c=relaxed/simple;
	bh=gM5aVmSJ7CIIzfZbL8mSiovO0zilJD/+4+GX6TJ/rVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfJ4qvKNdKiZTp57seomPEo1vJEYBbkiDuauYCuIOg8c4BsY+//Vr0etJn/E6mPaGVGwpGcyCnmhDbBomszqB54hK2dZap/NuTU3ONSOO1VdJYqeqftn8x/n2xyUpbLWqtpvHw5yDMhdSzqVs7SFBkhRsN02Jp/yIW4MDyKK3pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP3Qpkdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP3Qpkdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C19E1F00AC4;
	Fri, 31 Jul 2026 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515932;
	bh=yE1f+RrfYZ362efNgxVmDPK6FeOu0iXPnmR2Av9himg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iP3QpkdgeExe71ACHN371CP7iAFuSZpd43yGyl0T0jxZ7zoigDQKy0YGsg8ZXo7L7
	 cKze/nQWrMkR3igcqUlSHcn6zhe5Tj8fr3SQzqYqu85tIYjwiT2b5kAd0/dukfje9M
	 tfn66ppqhMBsBx56y3vElgo5F+JI74fiV7kZMlyr2a9c1q0BAfKgpb3BxIo2TQMNop
	 NZ6JmYz9iQHl2G7ibD5CQZiwYa3F5e5Rp1+CbVP92o+7NW3LMI03UuGdSXbZFrA4bj
	 2KTZmRBbR9peprh46ORAIO6+CDf07mqeJhvUjAXrqnuvE+rYpC0iHgdobIi0BcKda8
	 pGfdVZ7SCkK8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Dave Airlie <airlied@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/displayid: fix Tiled Display Topology ID size
Date: Fri, 31 Jul 2026 12:38:50 -0400
Message-ID: <20260731163850.837687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072926-unblended-mobilize-c8f5@gregkh>
References: <2026072926-unblended-mobilize-c8f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 90c0486a82e27393f9eaf3bb350f51a0bd38cb6b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_connector.c | 12 ++++++------
 include/drm/drm_connector.h     |  6 +++---
 include/drm/drm_displayid.h     |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fff2038e9803..208e5a152ab7 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2594,7 +2594,7 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
 /**
  * drm_mode_get_tile_group - get a reference to an existing tile group
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Use the unique bytes to get a reference to an existing tile group.
  *
@@ -2602,14 +2602,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
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
@@ -2624,7 +2624,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
 /**
  * drm_mode_create_tile_group - create a tile group from a displayid description
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Create a tile group for the unique monitor, and get a unique
  * identifier for the tile group.
@@ -2633,7 +2633,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
  * new tile group or NULL.
  */
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8])
+						  const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int ret;
@@ -2643,7 +2643,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 		return NULL;
 
 	kref_init(&tg->refcount);
-	memcpy(tg->group_data, topology, 8);
+	memcpy(tg->group_data, topology_id, sizeof(tg->group_data));
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1f43d7c6724a..9551018b7975 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1728,13 +1728,13 @@ struct drm_tile_group {
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
 
diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index ec64d141f578..51ab3fff1b51 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -75,7 +75,7 @@ struct displayid_tiled_block {
 	u8 topo[3];
 	u8 tile_size[4];
 	u8 tile_pixel_bezel[5];
-	u8 topology_id[8];
+	u8 topology_id[9];
 } __packed;
 
 struct displayid_detailed_timings_1 {
-- 
2.53.0

