Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352557;
	b=yZX9GHyG8nWxg2eZS89dGB6ZdJYBU+dYvL4scadYHWUWB/cBLHRj2nt8if/uyp8lu09V
	 HmHrFcBAG4oawNp6sJst9pElHbh1cSl3WzBDyX3tVx8y/+Ahf45p6PQ3ABsugOGiQUkUJ
	 u+tPEUinfkPHS5coyVGQwh07WfUceedDfoLf9Mj9PEtSO6lBCVodXdHmq5Fe98+BoAPor
	 3obAlGfoEuZwFZlgl5AD2STSgy80xLpUZRh7tdZYlHSrO9qiE8J+qwtq14X8VVqmBanjY
	 llTEVUXOdjpqfT22W6HbHam5DgQ1z90PPSESwbTk6CKTX4jRhw8iWeNoiqDBvh3sVog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JiKzuvuqhyxa+6Gq9VBdifGkJlEkKIKFqGhwsRZ7ez8=;
	b=CzkOglRjG66FVigtF2Ouzr4sK05AWw0sG8XEOnoFGov6VJg+bk9FHwfo9t+ZlRS+wblX
	 WGbDafXdgYa+uQq8TNI7A4iDawiiKAZMeba5QmZApoqVVZVbQEIeqbQrKKypImiSrzyg5
	 xSfr8V+/uUOiVjMOo27mS+ATvma8UbSCd7yJNVsTBEYkXW1on6QcbSHQRaPTMUhi83JTJ
	 HgOvInDJYuCzwf23p+lZmFIQhTmBvGmV0R22wfiQJHFVzbYx/nwdW/I6SqGWMXegmSxNG
	 lyN/684TO4RG9xE0XHyMnVQEYdFtaJVo55JLMp+1jvz72qjFM9T9VJs58qDZab00UDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="deMdbiQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=deMdbiQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A839B1F0093C;
	Tue, 10 Nov 2026 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352556;
	bh=JiKzuvuqhyxa+6Gq9VBdifGkJlEkKIKFqGhwsRZ7ez8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=deMdbiQ/1zSTx7AU7HS8jiGzlF/1hOSOrCxFjxDnMyNsMKslaPWTIZOZbbLi+TQYM
	 Wkgg3QmQFdOveuzUoNSDWm7RSKRRFB9JgIMfWYYiS6DWLIrh3/pRck3p7fzbGiz0rO
	 ZrT5P5cCup8SpzwxxsL4lgcZsORsbXXj/UoHnkg2liFnLfvmls4SWUtkpTvygn/6IX
	 KkaDWD0hSe/RKoP67qBucYMw6tVDvII1A4raTlBHusyu3bp8tfxTDZ0TDtSGdzc02+
	 FahKEkgAoGx2Yq2xndiLfAYvszf95YUU3jkhY3cFNTUCMsvNRgUnJsE6rn0vClKRGj
	 /+MMyWnlwihbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda/hdmi: clamp num_cvts against cvt_nids[] in hdmi_read_pin_conn
Date: Tue, 10 Nov 2026 18:15:54 -0500
Message-ID: <20261110231340.98293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054527-failed-6.1-6cf3ab38b0d5@kernel.org>
References: <20261107054527-failed-6.1-6cf3ab38b0d5@kernel.org>
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
[ sashal: adapted the patch to the older HDMI codec source layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 83ba6dfd28c3b..4948a1bf8c0ec 100644
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

