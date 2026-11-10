Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272739;
	b=qpTdglLen4XFYv1JpBgNEUPzFaXJ8QwDvjdIfcO9lwuLMEARhu6ewdDJTnw+gpD4B5EM
	 twayZMtrrd214Q5znIkFUeYrYeIQhJFs6vsMGxxk1wVrhO6qP10mn15WQEoxSQF1d8gZD
	 OdIOKHYYNZ7PBD0oeWu4PX0zHOanwTg9K777wZ6BGASiwYOAzs1cRihWkQ1mqzca/XM/0
	 kXJDBNY1uR25Bg3qOmSWXpVQv+W8iOdmPj8+TfqAWPLBjTCk/aNEdT3xTy5q8dBRjTH/S
	 FWZCafkXVE1S+KjIhDPsV33iLY+z4Qxmy7tieDXPIYGWdcTBsQPb7yPV3v1bM5wgxUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272739;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=htPi6/zEcd5ycHLExPFK7wk8vsCZ5PEs+JyS3O1ZR3o=;
	b=dWWhLA0En/TvcRDhRhjWCOf3te/MAZBPFOXhkyTuSq/AgKrADYjoOHqFi+cczKJpV/QO
	 m1AoOBdHJrckj7Ppg/ylyGijmxNC3Fq/7qHWvYrgqUEO8i8Z9MJT21gUCji8JnJZ2rLRr
	 taKvAzxmQpBPnK8jWaHnHYYuTkZ1G/RTsk3Go9ZNh/MMn4x+OWluCxBS8NDLusRLqaWXI
	 k+FegNdhzL4ZIuclDK43I5NS7VIwgqu+W6z+oviFOz37ir+4TPX5eQrxtisHeIRfb85V9
	 A3dnyaneYx0YqDvLTcIfw0G2p/dnLiHqU9kILKneGTkZmKWLymobSeMbQLTjwbJYepw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sn9BM8O0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sn9BM8O0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC931F0089F;
	Tue, 10 Nov 2026 01:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272739;
	bh=htPi6/zEcd5ycHLExPFK7wk8vsCZ5PEs+JyS3O1ZR3o=;
	h=From:To:Cc:Subject:Date;
	b=Sn9BM8O0NgFe/CAuGkGonDegGlbXYGs9ewjPWjBA1DxUvvcQJj/oU6MDUn6QISSNt
	 81g48ymUZ5haTR18jjr3n94qAONOsfpdYoSkz+BmBztdZc1COyqZyPvxQ6Q8FGVWhK
	 vmrgdt90ohvt/o3nH75kKw8r7UPidWz4KIVtgz4luwSnspI41EhwTWzp/4YwF1TcKA
	 quMMcYR2AKVfn+u7AH2znhz8pmgWL3l1KkTIj+rUeYbYqPaRCkxfP5t/xrchOgXigG
	 TNYVq88BhWrxQbf+YcTUFlC8iwhLVZB+5t9pTHM/h9Nk037tiirsphn1/fnQ4/O0O3
	 vGJsaGt/0lbIQ==
From: Sasha Levin <sashal@kernel.org>
To: mwen@igalia.com,
	pgriffais@valvesoftware.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP HDR" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:37 -0500
Message-ID: <20261109200537-failed-6.18-81f923b06580@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 81f923b065801c7d30042bcda31ccb9449b4f58b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200537-failed-6.18-81f923b06580@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 81f923b065801c7d30042bcda31ccb9449b4f58b Mon Sep 17 00:00:00 2001
From: Melissa Wen <mwen@igalia.com>
Date: Wed, 21 Oct 2026 14:29:25 +0200
Subject: [PATCH] drm/amd/display: Signal PQ EOTF in FreeSync infopacket for DP
 HDR

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
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 4620135437c5e..0be4506e9ae5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -173,6 +173,18 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_freesync_config_for_crtc);
 
+#define DP_HDR_SDP_EOTF_IDX 2
+
+static bool dm_dp_in_hdr_mode(const struct dc_stream_state *stream)
+{
+	const struct dc_info_packet *hdr = &stream->hdr_static_metadata;
+
+	if (!dc_is_dp_signal(stream->signal) || !hdr->valid)
+		return false;
+
+	return hdr->sb[DP_HDR_SDP_EOTF_IDX] == HDMI_EOTF_SMPTE_ST2084;
+}
+
 void amdgpu_dm_update_freesync_state_on_stream(
 	struct amdgpu_display_manager *dm,
 	struct dm_crtc_state *new_crtc_state,
@@ -189,6 +201,7 @@ void amdgpu_dm_update_freesync_state_on_stream(
 	bool pack_sdp_v1_3 = false;
 	struct amdgpu_dm_connector *aconn;
 	enum vrr_packet_type packet_type = PACKET_TYPE_VRR;
+	enum color_transfer_func app_tf;
 
 	if (!new_stream)
 		return;
@@ -240,12 +253,16 @@ void amdgpu_dm_update_freesync_state_on_stream(
 					&new_stream->adaptive_sync_infopacket);
 	}
 
+	app_tf = dm_dp_in_hdr_mode(new_stream) ?
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




