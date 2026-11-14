Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637473;
	b=ijYtPFQ9KUg+dPSCIMtNUNTxk4KJGVmMvOhP501MV4KtKPGf4/9xjH6GjZnlflt2vgQ1
	 qA7n9LjD8KpNDeYHSbJmsjqQZhtIBbmnsMXwbFuvQ+6B9HOhYL9dzbEopK5jIjd2NI1bp
	 oAyuBPFGFzEK47qIW9Rlu05VVFEOUj0Mf09/KOGVF+8bMpx/OzmQX10s2hSz8OP9P9NMV
	 17GF0iJ+FNoFt50n965Gh4oDP6LPy7IAxAhCd5FpMprsH6zg+QrRbxbWuflz6ajpQjzQV
	 yXKD42+r3H1yvR5ARhrntIuM2cB62LQv7/URS8Xv3ciJC5C1qeNirrSIHRm/CVUJUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637473;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jcj0NvAeyvZ1su0GK5FoslQ2SRSimOqvkjDapLZVb8w=;
	b=QtVo+4Nr1tqCaJ3o1/90aBcvCt05LTqN+jDufbe3LGjpYLxsm1/oBtU1/Sc+t2JC7fG9
	 2bzqA0SJO+SagrzFK0OfvfkxZiKaqEZg/WTNi9wDBfOpOcYE3bA+EOgiBt+QS+zmyJQTY
	 joccloYvNp+lls3V0cZa2FkOJiomwNYj6gfCHAJkHPVHLT6tInwyfUbWBxMDmaIx6KXJ3
	 exnijr3bu0MeSanBaS6duZQieLbIu/9QzOVpDJ9SpZfccOZ/25ONySL2zS6LLlD5i8kWG
	 LvZKP0CPsn2DUCiTUVDB35Ic3pFwQpLy9AVgBkPwS9FfiLb+TJNXO1KF8kz+e4W4CYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyI81YGN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CF606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyI81YGN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0661F000C5;
	Sat, 14 Nov 2026 06:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794637473;
	bh=jcj0NvAeyvZ1su0GK5FoslQ2SRSimOqvkjDapLZVb8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyI81YGNNy2mmWQ3Mhqt2Oi2Wz3JLE6FWx5Ew6H2RiLlHjLxHgPgFBc2trXz6zDeN
	 0JP4ZNPNEaGkgKriNZ15txUSKODmXRaT1edAYKdVtPLoKS4JbWyTsumF0rllcjsQOC
	 Fc41FIVX75QOFN5bcNXwZY4CO0Dltjn+aL56+eILjOc0JE3ILpKBAOKOkVUYBt4f1N
	 gDWQnRteB+2EyDWdtZCmbUspOxqPeGVgl+1GRnZdrNH0sUyjo1utF5mdfwFkq3PJah
	 iDTiKDiUroO9WgILRI2D9fwWhsbZjfrLm41sbkF/HTPf5C65nfpuMh8TlVhjxJDVxU
	 8tmaaYXGaeaYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] drm/edid: parse VICs from CTA VDB early
Date: Sat, 14 Nov 2026 01:24:29 -0500
Message-ID: <20261114062408.3188357-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201928-failed-6.1-0de95c96655c@kernel.org>
References: <20261109201928-failed-6.1-0de95c96655c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit c3292ab5fbd7045f019418b2ce1977891419ad28 ]

A number of places need access to the VICs. Just parse them early for
easy access. Gracefully handle multiple CTA VDBs. It's unlikely to have
more than one, but the CTA-861 references "Video Data Block(s)", so err
on the safe side.

Start parsing them now, convert users in follow-up to have fewer moving
parts in one go.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/7989b2b37837be68953c5d20afd3e93762bfd626.1672826282.git.jani.nikula@intel.com
Stable-dep-of: 0de95c96655c ("drm/amdgpu: Only enable HDMI audio if display supports it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_connector.c |  1 +
 drivers/gpu/drm/drm_edid.c      | 36 +++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     | 10 +++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index e49e2b0da6590..ca4c543234bbc 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -564,6 +564,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	ida_free(&dev->mode_config.connector_ida, connector->index);
 
 	kfree(connector->display_info.bus_formats);
+	kfree(connector->display_info.vics);
 	drm_mode_object_unregister(dev, &connector->base);
 	kfree(connector->name);
 	connector->name = NULL;
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index b202bb197f316..511021179ecbd 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -5704,6 +5704,36 @@ drm_default_rgb_quant_range(const struct drm_display_mode *mode)
 }
 EXPORT_SYMBOL(drm_default_rgb_quant_range);
 
+/* CTA-861 Video Data Block (CTA VDB) */
+static void parse_cta_vdb(struct drm_connector *connector, const struct cea_db *db)
+{
+	struct drm_display_info *info = &connector->display_info;
+	int i, vic_index, len = cea_db_payload_len(db);
+	const u8 *svds = cea_db_data(db);
+	u8 *vics;
+
+	if (!len)
+		return;
+
+	/* Gracefully handle multiple VDBs, however unlikely that is */
+	vics = krealloc(info->vics, info->vics_len + len, GFP_KERNEL);
+	if (!vics)
+		return;
+
+	vic_index = info->vics_len;
+	info->vics_len += len;
+	info->vics = vics;
+
+	for (i = 0; i < len; i++) {
+		u8 vic = svd_to_vic(svds[i]);
+
+		if (!drm_valid_cea_vic(vic))
+			vic = 0;
+
+		info->vics[vic_index++] = vic;
+	}
+}
+
 static void drm_parse_vcdb(struct drm_connector *connector, const u8 *db)
 {
 	struct drm_display_info *info = &connector->display_info;
@@ -6023,6 +6053,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			drm_parse_vcdb(connector, data);
 		else if (cea_db_is_hdmi_hdr_metadata_block(db))
 			drm_parse_hdr_metadata_block(connector, data);
+		else if (cea_db_tag(db) == CTA_DB_VIDEO)
+			parse_cta_vdb(connector, db);
 	}
 	cea_db_iter_end(&iter);
 }
@@ -6176,6 +6208,10 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->mso_stream_count = 0;
 	info->mso_pixel_overlap = 0;
 	info->max_dsc_bpp = 0;
+
+	kfree(info->vics);
+	info->vics = NULL;
+	info->vics_len = 0;
 }
 
 static u32 update_display_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index b8ef80e6ce392..5dfde32447798 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -662,6 +662,16 @@ struct drm_display_info {
 	 * monitor's default value is used instead.
 	 */
 	u32 max_dsc_bpp;
+
+	/**
+	 * @vics: Array of vics_len VICs. Internal to EDID parsing.
+	 */
+	u8 *vics;
+
+	/**
+	 * @vics_len: Number of elements in vics. Internal to EDID parsing.
+	 */
+	int vics_len;
 };
 
 int drm_display_info_set_bus_formats(struct drm_display_info *info,
-- 
2.53.0

