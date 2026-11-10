Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352774;
	b=VAbCmbRJiL6h7kjrB7HSMgPimMx59WXzgcutbY0IZBk75fpGurKLzVf553ooZkFRmczp
	 MRAKCievcQMMmchqBzZQBHrhooeQKocgXJNU3zi3Pso/lgjIlg3YrEc0b3iEd+BpPatC1
	 WghFqyOBg8PndH214l+y2G20yVakx41rVLsaDyqRNTmY+Tb+fOmBrDh77f7gWa6bX0anl
	 qBrX1pxosWbvvJZBh/dwXmlxdr/niXCCcIQ0nKdaciTEWahfA1cdGFfbNYt23kqTqp5NG
	 8taxy09Plx4GuUCT+P3O+ksePOmH3i5wo81dRU/ZHKQ4+LXG7JV2NnKI0rCmsHuFaXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bQ4kZ/KPSS+s48DyxbKoIFAqjLFHyu8DSLapd93lBvU=;
	b=Vc04bvB0iuW1vUOphLhZCKS7tyQj0dKdKmtgcypZQmMlmdAbDtiZ0kOh+MNGYH9D7EfB
	 U/EALonx/kxFi3L065UqMHp8l1zCgykEpev7XCGlzIdhQ28R64iwSLltqfJWxhauW5dSX
	 ymcTnRbLwpLSt3cRQMBCXlKg8VYYT0EUl/TOq6T7LbsCNuV/qAX+k9JT/j7nSSODXACDL
	 j2CTmz+BTzCAdzG7NtOxooi4VzMtZcU5vIbQOaDFEPkRScU0bIx+xXrNWwJibMb08kOmY
	 GwIZYZb9TTYqseEkjVDKfaQ6z30hnyo6NjDRy/rPKn3WAdxkVi2BW0G+uGcrC4P/I2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk3gdv0b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098A2606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fk3gdv0b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5BA1F0093C;
	Tue, 10 Nov 2026 23:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352773;
	bh=bQ4kZ/KPSS+s48DyxbKoIFAqjLFHyu8DSLapd93lBvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fk3gdv0b5xhBHovEHlb98ZlFuj1PtdUqfV+HUMaMzSQr5pF0TJ0EA/J+KaC+cs5sc
	 BelW/bjoYAUmcgdbnojOjXqgpBBR1NT8Pyf1dAWQsyFeb8e9G8fw3qCaWiYdevdps7
	 S1kqZQBGa1ipIlnDLrg/n2bi/oq9iPYK+l00bPDGSInfw8PAPLsQuc2iPmQjDDFeLm
	 vpUtVfQD11kMGPIpOC5r/ZSN8vaupY3ZryjyYERWsImLtiRBnJa8SW8rkLrwVcWkPS
	 dcYZPHJpIS2lO807IKyY7XCOMWBUAo9szkzUk0aQtKo5b4oJHoIM6wO6E6UuB6IBzy
	 ljcqMeTFe/KDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Tue, 10 Nov 2026 18:19:31 -0500
Message-ID: <20261110231836.115252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060255-failed-5.15-6cf3ab38b0d5@kernel.org>
References: <20261107060255-failed-5.15-6cf3ab38b0d5@kernel.org>
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
[ sashal: adjusted the target file to match the older HDMI codec source layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 51a22ed7325dc..9e3366d115a18 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1342,7 +1342,8 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
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

