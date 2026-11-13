Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541370;
	b=F8xx1LMHk3Ff3p7HD9W8nRGX7CcYzfYCXEYjSqf+QMXt2lK2eh8O3MxgdvTDxUjcCkQE
	 mkueTVXG7rupkwtfVWptop7YEvIJViBHdHJZdftnmaqvtfXg599UHeW7kwwgHWo8OVFJE
	 ssV2LUUJCMHYqCTXzgGaOZ6WWW+7+nq6PHIWM9xuZEOqNaKsU2uRREdY1Nzh+OWax+vv/
	 ggJGqQS2MMmI5PgmXSxd1kRDoVtpX3bG8EhbfKp/2SB9fP3odf1tW2ULAguiwcbGJnQI0
	 AVyyKmGkei8BzVdN87zpqmWNQAuCthM4n1cssj+50AxOz/yD6rsfFEZpWzz7F9L9BUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541370;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4epO2zqt5s3xT548pgtIvTabx+c/QomR0Yl1lJSYRv4=;
	b=0pZOQq0mkwBacYdgZpD6vPKpci8BHracsgiCDV15JUepn7UoqST1K1Kud3SsZY4aVDs8
	 aIUikPYlNXvQ8G0jz7aEBbD/yijRqs0G1YJOqDuuYkd5MexvnOl7LhvswrEjfNXLGc1Pt
	 orc0Aq9fVaH0riSZD72qdyuB6s4JPfmIRwE+0Tb0Zs8/znhsiROveegjPVt3tSf3YqCIJ
	 eqaz+dlpPiUxGQ2kVOjtOaewmr9TBhzM/y1JhV5KqQCgQ8Vw+P9kFShhdIF47ZWtATubE
	 CANFv5F1QBnOZmhwTd4Fb9FoZGeNkbdV64bV9TAkNK+ai0FoWhaNvoV6ZAGsO/V5oqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVe1R7lG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2710606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVe1R7lG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC91D1F000C4;
	Fri, 13 Nov 2026 03:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794541370;
	bh=4epO2zqt5s3xT548pgtIvTabx+c/QomR0Yl1lJSYRv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVe1R7lGuotyd+M1dTSPWpi+aj1rMHLC6YWwSoJGPuS6Ac9tWYyQE/2nsuk9Vu7jT
	 XCd56hI9wJjGyfchLSJ5ASUB7SaTa4TEy1leAygX+puq67/bEQR6csj1jWoycTYyvn
	 YUdIZvfp+s8yZR1l87ARgl3Gp2kBxdo26/UTA4hW+uiNrk4I4MoCVgYj2w4xPA4m/W
	 u1kNO/MjZU8pbACZgqSqkgAb3NZGhG5ZDz5omEHcZABJf0vjUHAXZTPush6jZ8J+S5
	 FyEK/QvrIr9Td/b5jQ/dFeh4chhltaqwxK+gs0jX4gLlhDxVbJ2HF+CigYo2RlgGBD
	 8mOE/AV03wpMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Melissa Wen <mwen@igalia.com>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR
Date: Thu, 12 Nov 2026 22:42:48 -0500
Message-ID: <20261113034225.1053767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200955-failed-6.12-81f923b06580@kernel.org>
References: <20261109200955-failed-6.12-81f923b06580@kernel.org>
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
[ sashal: inlined the upstream dm_dp_in_hdr_mode() condition in the existing update_freesync_state_on_stream() function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 305a9fe006de4..f1d492d9f8db8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8817,6 +8817,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
 		      acrtc->crtc_id);
 }
 
+#define DP_HDR_SDP_EOTF_IDX 2
+
 static void update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -8832,6 +8834,8 @@ static void update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func app_tf;
+	const struct dc_info_packet *hdr;
 
 	if (!new_stream)
 		return;
@@ -8883,12 +8887,18 @@ static void update_freesync_state_on_stream(
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

