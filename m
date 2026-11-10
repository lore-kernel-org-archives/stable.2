Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352227;
	b=k3NluNysfbShwzmULUBdfrBiDvIHM19n/2lrE6o2VesTl0JPFXL+l2sgVx+De3XHIOyu
	 nCYb/hExetLoXRAoyI7/lnH/YcVxdqmpvg2xP1Jg1dvPsMQXJxe52tB01eopjfjzQ8EQv
	 cPa4TW7kQjGG9LRiNJ0FOsMk+p15dttrpxcx2cxZR/p1wOhOnHu8zU5pArspgFLhEY0Rg
	 anyihR2UD90MIf9X5P29h/aSMsQym2Uk2ylxCU+n4cV9Spfn3LNfgkEE3Znco2a+UuSoV
	 Wa3RtZD5sg/9ZPN5T+WMDrbuJpNKIOCXy2jjFFWBYZoEdHY3dPPzzXhE3TdDBuUhw5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lePL0iZFaAO88EQjqdEFaCXprrwH9BB8JKk7jS7jytI=;
	b=O6p1ho66774aFi6SFTIALfJVNdF3+ecR5blRhS2+LOCmdLmfVP72baywlDyRbi2qydu/
	 m1FmhRsG/nPhXNwn9+zVafi+O9fibd9kZrHz8pdwTBorwg+dcbKoWQ8MBXgfXUat6qJt0
	 nNA7oKlGuRZPSpnw0Lgt5tWuIA5ED8du+fKsSVlZeUoKW6RQkRhXqs62Mfi24C1pmx/tv
	 RSh59gfEqoobRNwOHOi+8tR7TSLmGHZY/qgdU2nx173wnF/LPxt0nMxWoCPSoZjNd1iUb
	 TCyiJqjf9N1TDqK2p2ESjgMPu3SH+nLqhQixDzhKoIKUBv47oJsZJxzF7+y/IDt7cFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND0bXJl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C26606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ND0bXJl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650C61F0093C;
	Tue, 10 Nov 2026 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352226;
	bh=lePL0iZFaAO88EQjqdEFaCXprrwH9BB8JKk7jS7jytI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ND0bXJl33vlrRBa3aQvfZpXCIon1+vmq510F9PvsZLKI255aAC9a88odCVHiTFa2d
	 XNlRTJDlsVHJgNbCsayaPvsodZkrotlIUCrjaK2Wrt2hs+trOC1OE8xTuWjJWR/Qif
	 Edi0KHyg//D38xU4wAkC9Opis9+pIQcvg6Ln4pQiPHj1WN+TdWt1FRgBvOd4hjkCuP
	 asc6CiZOVOeqttm93/1KDXso6tD/VbBUXsgbNlkdskv0mpaqggCo23Cl2tzL7d1I80
	 9mwjW3xb8AfJTV02XC/kc8gcO0RAePwtisqUIKMRZJVDfVRJ816idkmEONCG4IzR5u
	 grtTkkWnSqyng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Tue, 10 Nov 2026 18:10:24 -0500
Message-ID: <20261110230953.74481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053244-failed-6.6-6cf3ab38b0d5@kernel.org>
References: <20261107053244-failed-6.6-6cf3ab38b0d5@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 6cf3ab38b0d53d41f00fe594b2986849bdf994ae ]

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
[ sashal: adapted the patch to the older HDMI driver source layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c2b00b6768ac5..7900cdca0a096 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1355,7 +1355,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
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

