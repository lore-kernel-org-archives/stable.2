Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794543035;
	b=kuFVeXEm+Q0d093jaPws6+asxsx6ojhuXd0BMqZ4cpA/8PHFh3I8N4gmAaKV6OnV/YZR
	 CwYtPvazAlkzB3QA7dxdNPcmENWZF+djtHWyMJydoZ/XKaoPBr6I7A9e9R2OJ/JfiihlN
	 9lJQCjMox1S4EUGCf+t8aLZAs2WyqgCADPeH0XPE4ax8kULFdCW64YazoM/ABIIBsoJAx
	 NdPeZca3ygasUDRofRyxpcmZ0Hb0IXrFSt1CsmqDweU0J/000AdOIHQ5pWYwTH2U7tK95
	 BEkQVl08Yx8H66ubCuITLdO3ZlOzCkoCYMTYIqEaI82EYgPZPJzY+Hhxrd0W+zgCTDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543035;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=on3EcKPOoXjp9xxw0marZwiD1755g1vyuv3zIkguhFg=;
	b=XTKi9dUoFpJOGFBouvuKnhH14iyOBwvsgJNpAqPmgR/kWjWzsXPxcp7yKgm84YKxTnxs
	 41ow990LVp1DZTkDI5nSOTWY2/3xGWj1bVW1xjgpHe4O7GorjCTU0vwXiXIo2AszaQrg+
	 /5koGB5kb97/cdGx3Bz8khsZ7HETEUj+WSGFBiQW0Rhii6wusfr8MidkarukkP5S7s35h
	 lQdEDQGeVCD5Y/sVYoZRubvseYSM+9rvED2ZqoK6xMbZPzZycAK6fe/fbP8nrabmv57uY
	 sbdtBnDHWsSpJ0HhOelZAHrXYdFxTyXRLp6z7yA09hXiK9Bzy+wZF58FaXemUyoPJVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AajkbTpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4635606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AajkbTpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EA1F000C4;
	Fri, 13 Nov 2026 04:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794543035;
	bh=on3EcKPOoXjp9xxw0marZwiD1755g1vyuv3zIkguhFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AajkbTpyPwaiSZ2/h8A7lyUNPY+4PhuExukX6IV1v4HW+pQMeR9JMzUkOXpuGnoNi
	 IJWYZSDDFM8mSTmzrL5GkXOUqs8NXuu6UobT5bm6JnBzzcQ0raNr6e4HaFVN8YQGjJ
	 90ZAmMHmr908izmGXU8VFTb3AumGUSLhRUHCslKtpDXYtKJkspJg5ed1a9TgHcmCG8
	 FFmReCp8HG2xfXNsa/ixA9fbeLsyFRE/SEjGTLvQoJ8JcTm7WwhtCW1mpoxx2kfFb9
	 Ggroeu14B0KIr3Zar+foDFrYn6ITdSDTLbCIvhvV0ytbEvz5isl/DzYax5kWYbRHGm
	 lgT5S9PNPu6MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melissa Wen <mwen@igalia.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
Date: Thu, 12 Nov 2026 23:10:33 -0500
Message-ID: <20261113041008.1079148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201426-failed-6.6-81f923b06580@kernel.org>
References: <20261109201426-failed-6.6-81f923b06580@kernel.org>
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
[ sashal: inlined dm_dp_in_hdr_mode() logic in the existing update_freesync_state_on_stream() function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d79f39dd21ac5..67fd21a32cebf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7893,6 +7893,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 		      acrtc->crtc_id);
 }
 
+#define DP_HDR_SDP_EOTF_IDX 2
+
 static void update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -7908,6 +7910,8 @@ static void update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func app_tf;
+	const struct dc_info_packet *hdr;
 
 	if (!new_stream)
 		return;
@@ -7959,12 +7963,18 @@ static void update_freesync_state_on_stream(
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

