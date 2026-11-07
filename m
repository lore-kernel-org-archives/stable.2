Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045796;
	b=NGEpwH5SdFfPivtvDEXHXx2Nybe/LZWtyRasaRhiIgNiA//5qDXMAaYu5JXiHM9tSM8r
	 82k2ccGGra3anUYJg/WbxaLcSudI2ag3DpCuvW72ShpIsKojNF/D9bRbeYB6+aHC0G9xd
	 LAOdGPo8RNGvPTAVYnNWaGkab3w3mSZCP7vhTEfugUiiYvo93UFJ4wjrEmxFMlCqzPUhv
	 NjviSNurLylkPIOvyXAMPHISmcjFl7AsKMNLyvDhRfPPzncMjJqzL0OC4BdLfC8vX4xOO
	 FC/QF3CPdmOMvz06X/3NhS9x/HYRBce6QkHsVzPBTPa8EaDoVf2p8vrXwNFFhcOfAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XRuGdrMmH1oQ13WQsXtuEpoaHgaYltffJM4G9I2DUoA=;
	b=NsuJ/fXqH8WhQHawtx/QvBif0Ms3sdtYSYFLC6w5nERXFdzOrtp132Z5GApVtS5+uYA3
	 XdaYFgDxaoc/DEER1vvo1856oty05qVbpig0ZwRe32oe+WOKek9pkA26MNp0tOmqMsK/8
	 RhWuTtITHMwnjbXxPzz99F1INHCv8qsVh2aBcWAt0TqJXUOEz08VzpLbsKrzK/kA50fhK
	 xfUzpCMJRmvWoOJ3gVHqlrvF0wsC/dpVEIac3qhyhsJXUuyilFLySPywSKNCi9mTsCGyb
	 FmfOEOcyacP3VuEwJwolxDO145bsPW9BDSs8hjIE7MpjQ/LLZSnYa8dCG9J7ZhkLyHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmAiAwWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmAiAwWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C731F0089F;
	Sat,  7 Nov 2026 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045795;
	bh=XRuGdrMmH1oQ13WQsXtuEpoaHgaYltffJM4G9I2DUoA=;
	h=From:To:Cc:Subject:Date;
	b=LmAiAwWGOJVOG8W7h6DyWN/Q/febki7dTbOd/B+Qjk6UvQXtybV9zWCneQhn+z6uQ
	 ahzbkXSJj5LRhJNE783e027u6LtTFjcCTDKsnBKWaqxnHK31q2u267CDmZQ8NZfhXM
	 NHafLe6Rd6D3njBnwM17xmCc/Ae8n27F51zUG/3W7q6a0MUZ3NTE1ddWVEarKKKszT
	 6MWBr3Sj/ssR+OdRgzCqUHh13nJKQcbVZGuALN/l8AceC5L+5vWTypiBkzEZfWV/Ms
	 VxnYlzybGqFIxpembr3FSB9Tq+dD54y6ILfwDXzzBiD3f/C8OOuiOaE+v/8xLuhKTx
	 Qri4LnmWz1lhw==
From: Sasha Levin <sashal@kernel.org>
To: imre.deak@intel.com,
	luciano.coelho@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915/dp_mst: Fix configuring TUs for a disconnected stream" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:14 -0500
Message-ID: <20261107050314-failed-7.3-ee00f8fbb2b2@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ee00f8fbb2b202002ab90834e02e9ba372773a36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050314-failed-7.3-ee00f8fbb2b2@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ee00f8fbb2b202002ab90834e02e9ba372773a36 Mon Sep 17 00:00:00 2001
From: Imre Deak <imre.deak@intel.com>
Date: Mon, 7 Sep 2026 20:44:13 +0300
Subject: [PATCH] drm/i915/dp_mst: Fix configuring TUs for a disconnected
 stream

During an atomic commit after all the MST stream CRTC state is computed
the driver ensures that the sum of TUs of all the streams on a given MST
topology link is within limits (63 for 8b10 and 64 for 128b132b). For a
disconnected stream the DRM MST core's BW verification doesn't ensure
this, because the topology state it uses for this is destroyed as soon
as the stream (i.e. MST connector/port) is disconnected. The driver
should keep the link state valid even for such disconnected streams, as
userspace may disable them one-by-one only in a deferred way. Ensure the
link's sum of TUs stays within limits in this case by simply reusing the
maximum link BPP limit from the stream's (i.e. CRTC's) old state.

The disconnection can happen either via the whole topology getting
disconnected or via only the given stream's port getting disconnected.
Check for both of these conditions separately, as a connector gets
unregistered after a link disconnect event only in a deferred way.

Cc: stable@vger.kernel.org # v6.10+
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16073
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16384
Reviewed-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20260907174413.741851-2-imre.deak@intel.com
---
 drivers/gpu/drm/i915/display/intel_dp_mst.c  | 21 ++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_mst.h  |  2 ++
 drivers/gpu/drm/i915/display/intel_link_bw.c |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 20766b6c0bcfa..0c362784afe4a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -2172,6 +2172,27 @@ bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 	return false;
 }
 
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc)
+{
+	struct intel_connector *connector;
+
+	connector = get_connector_in_state_for_crtc(state, crtc);
+	if (!connector)
+		return false;
+
+	if (!connector->mst.dp)
+		return false;
+
+	if (!connector->mst.dp->mst.mgr.mst_state)
+		return true;
+
+	if (drm_connector_is_unregistered(&connector->base))
+		return true;
+
+	return false;
+}
+
 /**
  * intel_dp_mst_prepare_probe - Prepare an MST link for topology probing
  * @intel_dp: DP port object
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.h b/drivers/gpu/drm/i915/display/intel_dp_mst.h
index ab09b487c6bb5..8ce89242c05c9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.h
@@ -28,6 +28,8 @@ int intel_dp_mst_atomic_check_link(struct intel_atomic_state *state,
 				   struct intel_link_bw_limits *limits);
 bool intel_dp_mst_crtc_needs_modeset(struct intel_atomic_state *state,
 				     struct intel_crtc *crtc);
+bool intel_dp_mst_stream_disconnected(struct intel_atomic_state *state,
+				      const struct intel_crtc *crtc);
 void intel_dp_mst_prepare_probe(struct intel_dp *intel_dp);
 bool intel_dp_mst_verify_dpcd_state(struct intel_dp *intel_dp);
 
diff --git a/drivers/gpu/drm/i915/display/intel_link_bw.c b/drivers/gpu/drm/i915/display/intel_link_bw.c
index b47474a3e9fec..e71e76d6fd3e0 100644
--- a/drivers/gpu/drm/i915/display/intel_link_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_link_bw.c
@@ -64,7 +64,8 @@ void intel_link_bw_init_limits(struct intel_atomic_state *state,
 			intel_atomic_get_new_crtc_state(state, crtc);
 		int forced_bpp_x16 = get_forced_link_bpp_x16(state, crtc);
 
-		if (state->base.duplicated && crtc_state) {
+		if ((state->base.duplicated && crtc_state) ||
+		    intel_dp_mst_stream_disconnected(state, crtc)) {
 			limits->max_bpp_x16[pipe] = crtc_state->max_link_bpp_x16;
 			if (intel_dsc_enabled_on_link(crtc_state))
 				limits->link_dsc_pipes |= BIT(pipe);
-- 
2.53.0




