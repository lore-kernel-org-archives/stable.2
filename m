Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44032DB7B8
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222855; cv=none; b=uELYtEjCpJZHlElQeQ+vNztlUYm0E+rUhh6wNHywQ1Hq4hFUw8IvJ+ZPvmzxvTtH/84KpTnYsN65qzRPSqm+6gXQug0LbqvVS840P8mZO9oNMBUhBjhrhWA5Knk34cflnkI+iJmwe93TG/H4pRC+xs8MlJO0IoUCCo5iUiYCU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222855; c=relaxed/simple;
	bh=2GHIh1tci9KtlNnLBUBkkeYXgFZZdYO6jTQnlPC1dXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxHHVIu4lx5E17nWWlHH47hjAaxY3e1grSM+2lZkYJUQK04QuwfV08MY4Aj0fwtv8rRC8Qv0JaeIpARFNbW/ZVGpcmp0OF5msQAd2xR+3QciIsLJ9lmmmLOb5Y9tnYa2PVottAzr2E5HdCbNLWJ09htxrdYzXxEDIfyJvcpe0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqYL1ea7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqYL1ea7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE92F1F000FF;
	Sat, 12 Sep 2026 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222853;
	bh=M4U2pCAQncbf7ld6J/RRV2QjWqdySLlvb8xhqJ1CkUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqYL1ea7dtpNdXBsp86pflJCt0prSRLI29juqHFrbjTPJwpu9yPUvo063O+uxgAqj
	 ouFBCFHnU9DT3tsQaqEx3AWtOWZRBEj/v9vML4sEFJOnWUCDDfsZo+TiSZ3bcJFM2N
	 Q/AB65JWI8vfTpN/oHzw6UHxh1J7dD5xaoNa3nguKeVHRKHtypzifCV/lNgmtZXzA8
	 NP25Dz3eOBCZcoGgRYk1174J+5FfoEXynCA1nt2Xj0pxOtesM91kg5MEcoV7Zgf1Za
	 fmvcdjL14IEiXzE25BoqlKNzCIQEGdeNGIdW9AfPQd1TFtSwh929bHVo11sh5/Yj3G
	 7q9I8TQ44/6Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/edid: Break out reading block 0 of the EDID
Date: Sat, 12 Sep 2026 10:20:50 -0400
Message-ID: <20260912142051.2911653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090912-bulginess-yearning-759f@gregkh>
References: <2026090912-bulginess-yearning-759f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit bac9c29482248b00cccfdfef1f34175714d33370 ]

A future change wants to be able to read just block 0 of the EDID, so
break it out of drm_do_get_edid() into a sub-function.

This is intended to be a no-op change--just code movement.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20210914132020.v5.2.I62e76a034ac78c994d40a23cd4ec5aeee56fa77c@changeid
Stable-dep-of: e2a9e291275a ("drm/panel-edp: fix i2c adapter leak on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 63 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 49bb2d9d92435..67f2e706a2e16 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1914,6 +1914,44 @@ int drm_add_override_edid_modes(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_add_override_edid_modes);
 
+static struct edid *drm_do_get_edid_base_block(
+	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
+			      size_t len),
+	void *data, bool *edid_corrupt, int *null_edid_counter)
+{
+	int i;
+	void *edid;
+
+	edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (edid == NULL)
+		return NULL;
+
+	/* base block fetch */
+	for (i = 0; i < 4; i++) {
+		if (get_edid_block(data, edid, 0, EDID_LENGTH))
+			goto out;
+		if (drm_edid_block_valid(edid, 0, false, edid_corrupt))
+			break;
+		if (i == 0 && drm_edid_is_zero(edid, EDID_LENGTH)) {
+			if (null_edid_counter)
+				(*null_edid_counter)++;
+			goto carp;
+		}
+	}
+	if (i == 4)
+		goto carp;
+
+	return edid;
+
+carp:
+	kfree(edid);
+	return ERR_PTR(-EINVAL);
+
+out:
+	kfree(edid);
+	return NULL;
+}
+
 /**
  * drm_do_get_edid - get EDID data using a custom EDID block read function
  * @connector: connector we're probing
@@ -1947,25 +1985,16 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 	if (override)
 		return override;
 
-	if ((edid = kmalloc(EDID_LENGTH, GFP_KERNEL)) == NULL)
+	edid = (u8 *)drm_do_get_edid_base_block(get_edid_block, data,
+						&connector->edid_corrupt,
+						&connector->null_edid_counter);
+	if (IS_ERR_OR_NULL(edid)) {
+		if (IS_ERR(edid))
+			connector_bad_edid(connector, edid, 1);
 		return NULL;
-
-	/* base block fetch */
-	for (i = 0; i < 4; i++) {
-		if (get_edid_block(data, edid, 0, EDID_LENGTH))
-			goto out;
-		if (drm_edid_block_valid(edid, 0, false,
-					 &connector->edid_corrupt))
-			break;
-		if (i == 0 && drm_edid_is_zero(edid, EDID_LENGTH)) {
-			connector->null_edid_counter++;
-			goto carp;
-		}
 	}
-	if (i == 4)
-		goto carp;
 
-	/* if there's no extensions, we're done */
+	/* if there's no extensions or no connector, we're done */
 	valid_extensions = edid[0x7e];
 	if (valid_extensions == 0)
 		return (struct edid *)edid;
@@ -2019,8 +2048,6 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
 
 	return (struct edid *)edid;
 
-carp:
-	connector_bad_edid(connector, edid, 1);
 out:
 	kfree(edid);
 	return NULL;
-- 
2.53.0

