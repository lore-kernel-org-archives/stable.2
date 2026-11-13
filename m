Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794540123;
	b=tF3FGWHmyYoO1xH6NrAqg3ymgR9Kk/b0IpkoaI5eLEwOpoSKH+WFCY1ID1uhUFFVIFbD
	 OiFkojNZMGinXA6tVmAizBSd3ZLV4LlnfGls3wElEybsNnGBL4LFxwIirv/TuvnFZJigv
	 M4vDCVXkE04MlOiQwWWJ6W3o/iLC7JhPpGifAzcsxmd0Y9r7Nq7D2rhc0NVfcXo11z7A8
	 QnroKlcIctirxvcirOqCPjlJYU/Vw/TwVmOp6lecf8OkowZlNZN86lSnXUI9++KEdLwPP
	 VU4y1sotjS7NWHrYVKLpTvscX8gQ+u0QwiZG1jOutDFt4mINUOiTSmIYTSVEs5wFwtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794540123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UHNyDIHUYCDCBtW7z+s/DC7oLTYyUMWyM/DD63A4vwo=;
	b=CiGC+ko3HVQQScisjFKVoSOX+ijFYUHHnY1uKYthwJoq901cvK4yMicqJWS/+DEBC9Oe
	 KePkeSjqGxRJqz8472T8Y+460rhCJnGDOlJdV487StMhdYmH49YL3oRY4lek9pomDBe2Z
	 tciUAzyjVTvzD0pB25hryVW/EZw28Gr6+rtLph6jZbgpv5V4r2K0xolN3egB48uxKM2vL
	 MzHqzhdN1RULwnrHYNnTw/6FkgiYUMtE74jKZ2nIR0/D91ufPI2FvnL6DbNNW9hTVOcyP
	 mglPjVjeZuaXJwN1h41BYmUD01qWWodzXeEFrtybd4Ssb0VWWQmIaXxb58YouHv2d5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfPnFo3G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AA606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfPnFo3G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC11F000C4;
	Fri, 13 Nov 2026 03:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794540122;
	bh=UHNyDIHUYCDCBtW7z+s/DC7oLTYyUMWyM/DD63A4vwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WfPnFo3GubYMS+DevKA4Sp/qAhKTj4xJw5e2+db5Zy7A6lEVFQaezRTYOtkFw4ynf
	 470+SfxKizhRyZpQNVXcJm1atdrgC7J41e+wmZx44MVoP4UrJmboX6dn6gx1EXa+fN
	 oztlJysmX1QxFYm+i1TZohCZQbAV27lbIHKn5KWGI9RycNTpbc43qxo5UOuiWXCVOH
	 sW32mZUx7yXkRKqbVRB/qzYNxKA2ifVtbIRXNF1+QVV4ZrK/a06r3KzlmGArVkGNLc
	 7ehcWT7BPvNfbdcWpQl1z/CvjW3PMz79MO6O9iK8vGhejfSm56c/5tq1SArFdiFvTx
	 MHcpeZqUEtOsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melissa Wen <mwen@igalia.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
Date: Thu, 12 Nov 2026 22:22:00 -0500
Message-ID: <20261113032138.981180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200537-failed-6.18-81f923b06580@kernel.org>
References: <20261109200537-failed-6.18-81f923b06580@kernel.org>
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

From: Melissa Wen <mwen@igalia.com>

[ Upstream commit 81f923b065801c7d30042bcda31ccb9449b4f58b ]

Commit c2791297013e ("drm/amd/display: Add color bit info to freesync
infoframe") created the app_tf interface for FreeSync HDR and commit
c21a764a98cb ("drm/amd/display: Send PQ bit in AMD VSIF") used it to set
PB9 bit 5 (PQ EOTF) in v2/v3 AMD Freesync infopacket. However, Linux
never made use of this interface: DM ignores what userspace sets
regarding HDR and always passes TRANSFER_FUNC_UNKNOWN as app_tf, so the
PQ bit is never set in the infopacket received by the eDP panel.

Check the EOTF in the HDR static metadata and set the PQ bit in Freesync
infopacket for DP accordingly. This fixes gray-washed HDR on KDE/GNOME
on Framework 13 Pro AI 9 HX 370 (DCN 3.5) and may fix similar issues on
other VRR-capable panels that advertise Replay in its AMD VSDB.

It doesn't affect color/EOTF bits on infopackets for SDR and native
HDMI.

Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3200
Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b318f3e13dd73781404670d3b3c6cf2177e0119c)
Cc: stable@vger.kernel.org
[ sashal: Inlined dm_dp_in_hdr_mode() checks into the existing static update_freesync_state_on_stream() function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a77b55ff9321f..9a360fab13978 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9440,6 +9440,8 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
+#define DP_HDR_SDP_EOTF_IDX 2
+
 static void update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -9455,6 +9457,8 @@ static void update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func app_tf;
+	const struct dc_info_packet *hdr;
 
 	if (!new_stream)
 		return;
@@ -9506,12 +9510,18 @@ static void update_freesync_state_on_stream(
 					&new_stream->adaptive_sync_infopacket);
 	}
 
+	hdr = &new_stream->hdr_static_metadata;
+	app_tf = dc_is_dp_signal(new_stream->signal) && hdr->valid &&
+		 hdr->sb[DP_HDR_SDP_EOTF_IDX] == HDMI_EOTF_SMPTE_ST2084 ?
+		 TRANSFER_FUNC_PQ2084 :
+		 TRANSFER_FUNC_UNKNOWN;
+
 	mod_freesync_build_vrr_infopacket(
 		dm->freesync_module,
 		new_stream,
 		&vrr_params,
 		packet_type,
-		TRANSFER_FUNC_UNKNOWN,
+		app_tf,
 		&vrr_infopacket,
 		pack_sdp_v1_3);
 
-- 
2.53.0

