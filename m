Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048329;
	b=YBzmu+HI176thErpmOzbTbp7hkmkmTBRDyP4HSh5I/GZY5JaX2necZykUhpbP5pxezGZ
	 G7RDUg+K0o6kPSy1JtwYtLHayiJz7DGU9i7+X8bsxP/gIRpGsqMRZk5zhq5TtEcHur8GD
	 S7FDVEhChP3Lg/f0S5P00LlagTVDNY5Q1zfdspdmet8DWRmlpaxLChThUu/196a7+GVSg
	 Tj7RIkL6fUHGMYDmVq/AdAIoxlPy70ZhkcUQCRAFcR/FiUhSRBlWQhilB0KeBAHtuCNCl
	 sRkOfuuDBPdzeudxk2DpMccmwEippULtArTMckfCm4MjJA6VuSXukxemsN3qx+4xrDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YGLwsgAyQG5rs1uAIIYiurJKbVnvqTpm037va/2lstY=;
	b=sjNqqhjh4OuHDBjdnRzFmBJNWhLet+/jL+Rrc+ljQ1lXCHCBhPawmhD2EVd4xbGft+AF
	 cgP4/gQxkto8T0s9/Iy/u7QFAetS61Ds0R5r09Qf3T9YlZYgLx8FE//63MxvlCHOCmbBs
	 kwiJhT+tF+zBQdMvzdgepSQgfce2PRQRSFLrH4unAAm2/f+PiRgDQKfdE7MvddUOV7SKC
	 PTPcGc7LbyOgV8rxXNU8OqM5k7JmqMhW+XgOKn7poLG624xDym5H+pot+KUNx2pxlDRW1
	 n9cmgcCkMvxfx9WQQnswvXwMM/xrz6sM3oman1GZ5MJ45kkpu7kRwqhfq/x5zcGPXbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyISgh4g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B708606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dyISgh4g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3E31F008A1;
	Sat,  7 Nov 2026 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048329;
	bh=YGLwsgAyQG5rs1uAIIYiurJKbVnvqTpm037va/2lstY=;
	h=From:To:Cc:Subject:Date;
	b=dyISgh4gMtJqiIDofJ31MEV5hjpvPOeHUTrgeHkVmrkZrFL93he5DxUwrxEqRxa49
	 cRZbUuMLs1Z0w6Q3tf1lVfAeGOJvw0StAz1oSlTRV40++pF1yYvphaHEBZpSD3qM0d
	 IVymKkcys63fRAbpOOjXxaFEfwixYtShZ4O5i41jbn7diNoZw8vZbUCXAx3kKrnpqe
	 A0T77NreTmVkkg4IS4L4lk4hd6suKM+i4qtoS787g0UOpuh5NwmfO0LxswlgRtOUPK
	 iiaidL53z8LpoynYNcrBekgN9peOzLICQyr3g8ap/K8g5geylJAEn1ZHkYmfKdA1ak
	 rJqwtDk3RS/Vw==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:27 -0500
Message-ID: <20261107054527-failed-6.1-6cf3ab38b0d5@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6cf3ab38b0d53d41f00fe594b2986849bdf994ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054527-failed-6.1-6cf3ab38b0d5@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6cf3ab38b0d53d41f00fe594b2986849bdf994ae Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 8 Oct 2026 11:51:22 +0300
Subject: [PATCH] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in
 hdmi_read_pin_conn

hdmi_add_cvt() stores each converter's NID into the fixed-size
spec->cvt_nids[] array (used only by the Intel Haswell pin-connection
fixup), but only when spec->num_cvts is still within
ARRAY_SIZE(cvt_nids); the num_cvts counter itself is incremented
unconditionally regardless of whether the store happened. A codec
that reports more converters than cvt_nids[] can hold therefore ends
up with num_cvts > ARRAY_SIZE(cvt_nids).

hdmi_read_pin_conn(), on the intel_hsw_fixup path, copies num_cvts
elements from cvt_nids[] with memcpy(), so once num_cvts exceeds the
array size this reads past cvt_nids[] and writes the resulting
garbage NIDs into per_pin->mux_nids[].

Clamp the copy length to the actual size of cvt_nids[] instead of
trusting num_cvts, which is also used unbounded as the size of the
separate, dynamically-sized spec->cvts array and must not be
truncated at the source.

Fixes: bce0d2a80e42 ("ALSA: hda - Allow unlimited pins and converters in patch_hdmi.c")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261008085122.9442-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/hdmi/hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
index a8aac0b36c73f..355fd3e731836 100644
--- a/sound/hda/codecs/hdmi/hdmi.c
+++ b/sound/hda/codecs/hdmi/hdmi.c
@@ -983,7 +983,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	snd_hda_set_dev_select(codec, pin_nid, dev_id);
 
 	if (spec->intel_hsw_fixup) {
-		conns = spec->num_cvts;
+		/* spec->cvt_nids[] only has ARRAY_SIZE(spec->cvt_nids) slots */
+		conns = min_t(int, spec->num_cvts, ARRAY_SIZE(spec->cvt_nids));
 		memcpy(per_pin->mux_nids, spec->cvt_nids,
 		       sizeof(hda_nid_t) * conns);
 	} else {
-- 
2.53.0




