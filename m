Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794637474;
	b=JDsXsHGj5aKAxDafAJI7YZcej0FZaNFMcM6wVPzbUoie6QBV2xEAyExuQBOeHFmyiCtb
	 uWoPAtDTxlPmeqgERt4BigK5PcW+2/nIdPzNCoExSWHyUV3CkliFUMgbt+zae1v8JGWoq
	 MkjN6SJze/CR15ksL3sJ8sYpTg6I++EePUmgcxs0G5d2LjHurgpj35sE19GU6I7C/qvMe
	 OfDeRGLToBFw4j9gOTAcS3DLRrS9enlrroY4nrEdGELS0r6Qnd6PsnPQpIWYSU/dFj/zt
	 9TwdQ5YrVI3kEPOc1pHDIay7KOm2DHMC2padbRx2IYnpgwVNKH8IrnpaFa4nBdjU4tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794637474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h9rOLP9hnYHI6KXsce+/vPC8CsvDGDJnkCxhR8LgTm4=;
	b=rEGZU7HtymiSKBreq0IkkAUcUcHpIoGIDXt9B5o978asBV2wmXm3ojpF2G6B97U5Nc+9
	 0G0nd3cEBXF9wvbUZ/qEX28lmooyFilKrfOcfu9VvwSS0bdndfcTSWGPh43oT/hUnJtBD
	 a9RhFS9gHn4zGnl3I9a/IG1zGRivdwNvVdCMXadeizvPaprrC1jWFc2DWIrofHBGMiHQM
	 OjfTHnJ8Yl/p16q7kJR/veotwYB4OTyxFME1oEAPlX17fvQu9i/ob6KWR+c2AdIggi9Rx
	 9YAcPAFHR0xN8wctHyzisIYNbLUfU4R0cmW3U7CxvDpo6O2ONNCwHUJv+1ajXzO2JeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD8rBjgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71614606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bD8rBjgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416B1F000C7;
	Sat, 14 Nov 2026 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794637474;
	bh=h9rOLP9hnYHI6KXsce+/vPC8CsvDGDJnkCxhR8LgTm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bD8rBjgvzYtL14raxGyq7oJXidfIAn1r1J8djRCKzLvdo6k5XKstVoskhMvXTWj15
	 jR/Q+sJfP1mJ+zctPg19Zoc7LaBvrrKcaK4ckSS39RLRcD6LpjraBsEhmyK8RxfKTC
	 It9ZtXCwXcwXSq0KukgtY/m1eYQohBBf2idslfGKEHob04N6d/V6LEXsU09Ko5JMBd
	 ei+CtJCtw8vrrIEtxL67Wm1519sZV93CWh4UVwkJ6+a90ln1/8q8MGdg0XOqj1TyM5
	 ISueMrB0rWiqE0DaGPttGz6rChT9SHFefFORg3TLIqpMSwmdhEAPuRIxWRA03GV1tS
	 hO6A0yuBnB6HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] drm/edid: parse display info has_audio similar to is_hdmi
Date: Sat, 14 Nov 2026 01:24:30 -0500
Message-ID: <20261114062408.3188357-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114062408.3188357-1-sashal@kernel.org>
References: <20261109201928-failed-6.1-0de95c96655c@kernel.org>
 <20261114062408.3188357-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 0374ffa507d8106202a956f5951226f1d9eac22e ]

Since we already iterate everything that's needed for determining audio,
reduce the need to call drm_detect_monitor_audio() by storing has_audio
to connector info.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/391a93b25c6bcbb39854aaa2813570cfb1580ed9.1685437500.git.jani.nikula@intel.com
Stable-dep-of: 0de95c96655c ("drm/amdgpu: Only enable HDMI audio if display supports it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c  | 6 ++++++
 include/drm/drm_connector.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 511021179ecbd..52bf6755f36ea 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6032,6 +6032,9 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			info->color_formats |= DRM_COLOR_FORMAT_YCBCR444;
 		if (edid_ext[3] & EDID_CEA_YCRCB422)
 			info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
+		if (edid_ext[3] & EDID_BASIC_AUDIO)
+			info->has_audio = true;
+
 	}
 	drm_edid_iter_end(&edid_iter);
 
@@ -6055,6 +6058,8 @@ static void drm_parse_cea_ext(struct drm_connector *connector,
 			drm_parse_hdr_metadata_block(connector, data);
 		else if (cea_db_tag(db) == CTA_DB_VIDEO)
 			parse_cta_vdb(connector, db);
+		else if (cea_db_tag(db) == CTA_DB_AUDIO)
+			info->has_audio = true;
 	}
 	cea_db_iter_end(&iter);
 }
@@ -6193,6 +6198,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->max_tmds_clock = 0;
 	info->dvi_dual = false;
 	info->is_hdmi = false;
+	info->has_audio = false;
 	info->has_hdmi_infoframe = false;
 	info->rgb_quant_range_selectable = false;
 	memset(&info->hdmi, 0, sizeof(info->hdmi));
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5dfde32447798..a34d169549934 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -597,6 +597,14 @@ struct drm_display_info {
 	 */
 	bool is_hdmi;
 
+	/**
+	 * @has_audio: True if the sink supports audio.
+	 *
+	 * This field shall be used instead of calling
+	 * drm_detect_monitor_audio() when possible.
+	 */
+	bool has_audio;
+
 	/**
 	 * @has_hdmi_infoframe: Does the sink support the HDMI infoframe?
 	 */
-- 
2.53.0

