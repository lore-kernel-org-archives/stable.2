Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351759;
	b=aB7OdXQ7HldWhiBicCyp8QHOTmqiNoo3755YEhVLjQP9q4u54UZkVFepiAhr+i8KOej+
	 bFdAXqdoung0/l+u4MPnKYW2ttYeIOBeG8hdE2ecG3NQ2UiGC6Pj3dW53PUQlrYI9EePX
	 4mZrA7M6ykwVVwd5uaxeXF3k6oix2C6ULXQMlcUOuilDSr1z+hqGi+ri6v37V3/HCkdo2
	 FeCAuW61D1E4IXOHR1bTNdWy7EgUKvCmR9hzog+NtmyT6gf5mQVz0SW1f/s7H/mYO4OfI
	 axl8floEG8qG7sPiK/2dwZvgjqFYgEy5duakVuHn8r2H1a3+v5ZwBO2q3bIOLseJ3IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351759;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=48eLOC7LTmmauYF5yxydww4RI0CElgYRjgbJ2hZJRbY=;
	b=SJlE7hiQ1QD7Au28hxgKfIwUg95yvgoTqtLfFRRjmgJB5lr6lrF4yL/O+yzetMvaEFEM
	 8BHf1WiTQZvORE3ETRZdJ0krEmo6/Dm1orFW/Z4xU7PZ95HNergiX7CtghUB+ufIhzqQ+
	 rZCxPbuiewbQjFNa+2WO+afRBjCr6c3b577nkQg0a3V4E7UAdI12r++fDMRSaNZVD9chc
	 YEhSS1rp0RrkD52CvS4Aj42zEBoGOS26zOd9/w24a3No5P/aEX/tiW3O06+tBLHxQ83dU
	 5V13bzBKCALEX3QeMIkP+1qC5rcT1f9Bn4+dGyBx9uHcEyAbHY3vHcP8BFQLImTjDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3o3gOnY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86615606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3o3gOnY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E031B1F0093C;
	Tue, 10 Nov 2026 23:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351759;
	bh=48eLOC7LTmmauYF5yxydww4RI0CElgYRjgbJ2hZJRbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3o3gOnYE8K+ayI52O2KNLl51SCzdAGQVjH+g9PvZ6CU+v4Lk9+FrHYQofw9pynyh
	 9mJ8cwlK46jYRB+SUACps4/3ayPQHmZmA+q6jks/nQ5jeaZEpTOeZzkY0rbzgigUGd
	 ExQ29zOWqlLekYCSWqVCecUBJwODry6n2OKeJb5QOlcajlSR8twm1LhJvPBpYywZYk
	 drymQIFHaITaO0iAt9PsSWPILdtzuD0gp4vfKWsH4XqTau24D7QsYPRnkyz1p3VM7b
	 o3TwmpEdTESblgXcbvcpWe418g8NCMwN27Tg56vIN7Gvw/fFdUcdyw43B7WLnuNKnl
	 x2Kjw0PsrcNuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Tue, 10 Nov 2026 18:02:37 -0500
Message-ID: <20261110230110.16677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052013-failed-6.12-6cf3ab38b0d5@kernel.org>
References: <20261107052013-failed-6.12-6cf3ab38b0d5@kernel.org>
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
[ sashal: Applied the unchanged upstream hunk at the HDMI driver's older source location. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8b68386e1ac94..c097fc844b18b 100644
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

