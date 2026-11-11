Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356017;
	b=CzFj0fayn2zDxY05/O7KDvAWsGRFIDc6c9j+a/MSzca9tbXlT+C1aa4TwgwVKmv/V/xx
	 8xvoJqZvR9ezgfqZM/X95mQqovN9rUenEMl3VpIyRuFTs5rixdpCSeva43Le5XiW47A86
	 sc8XvQdQyRQzRDl+Uxa08OPMXQKNEGbZ1TIf/l9Fx/7B97ka6utThVDeltjoCjOCQZM0O
	 kAm2s7uUQ87WYoQVIYiboBoSYmJQZ/XOjIYnvujY54Jx566tnCrbzN4gIqAfitLCsWq0h
	 jUDe9QqGMio13SAhCB7BoOZqoSlvnXVUZDs9joHkeScHBpZR0r08FEpWIWa4IqF1rqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356017;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Na64IEnlM9Z7y6GG+w1TeljxUnNrxZ3gLwUvMVOc9ng=;
	b=xcSyogzZkEOZ3EK15OOLCd3Druy8MNbK+S6DkY02zxZjSrOiD9NEeRrMexyzjSwLsmC/
	 Mj1RvZBsMJTBaRSdeDbESVOzTeQZ75qSAXFoY8SvUu6qqJdGZS5PCl8+fAEnMJQZHhqqg
	 B7W1tDQpKQ+nj257j7xMs+IqVvSl3/behIekxluG7i9f9r4qwW+brPBt2XFbvS4pgnJFI
	 So800YhxdJ14SFnW2YLvu19xjQf9pEWDzVcnRyg1gYAThUSvtojF8QP+XtFpLEhTdd5tb
	 wSoXYw1TGchVnzeZaJNEGwnZE+zhoyVOHmo3IW+RdmpJrqS/jAjVkpVsUJNAu/0cGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbERyudi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4F4606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbERyudi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E201F0089F;
	Wed, 11 Nov 2026 00:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356016;
	bh=Na64IEnlM9Z7y6GG+w1TeljxUnNrxZ3gLwUvMVOc9ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbERyudiBnOMvhaEk10ktelWcay7aRqUHiPEhPMHICCDClgJM5oKf14xZKbdT/DyR
	 2uTYKHJ6NAx9wi1RQjtn1O74Rgs06setJdkWHZYln6dagNCLPkiX26KvCfzRWhCXCr
	 wCXidRWcf/hRnwGGZgtTO/FS4R3SkRe9Tr4Lb0guJG71he5/+2FsPskVZyKgUXbpq0
	 1yPxiRHcuftTrea5lrEiYSSDHP0qIDP+v05Uc1/wdP3LGhJbeQkeNe39/p/wG/r/Ag
	 ynQKFlyUrF8zr6eCMyAoqPGkJuJQrPhH7vfyDqeZfr7SN89qwAXw9zAypgIHoDqIvW
	 7AQoToKKADi9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Tue, 10 Nov 2026 19:13:35 -0500
Message-ID: <20261111001314.128146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061940-failed-5.10-6cf3ab38b0d5@kernel.org>
References: <20261107061940-failed-5.10-6cf3ab38b0d5@kernel.org>
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
[ sashal: adapted the patch to the older HDMI codec source location ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 77192df4d95fd..66ac580190024 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1341,7 +1341,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
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

