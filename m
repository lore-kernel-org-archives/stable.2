Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134E34C83C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975161; cv=none; b=iY9e8e1pZNJEXTi3WBId8a3WtowdLmUGEdSFrk6Rb+LAXzGCm4igj1IHn3ggCXsLYZcKE0OZ59yOzl+s0z2CWwvPe17FQtbxjEkzZZtK9lBL2aw0MZl/bVUimzTVicLqIFaRQZh8BLhvyQJFljd49dhjKZAWCJDAez60FXC6QZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975161; c=relaxed/simple;
	bh=8u/VwwgWSZWo7BFK+0CzrFlkyj6GR0JCOXVg8z0NCQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEgNssJWklW6MPUL04BENwqvwYfM0Rx96fw8Vh/J0PLh89skCt/sVRRWJdh96Uf8KrA1Dnm1TOVt8yRb44kSbSgKwfebDS9klJ+gJ6w2/bMQPtlriMWxhcZVll3sCfCW+qH6xCSW7TtRERPzri567c/Gm5GkbqFRu/d4uTKCk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJPqLlZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJPqLlZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF61F000E9;
	Mon, 13 Jul 2026 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975160;
	bh=v0ek1sE3/TrnSiCATwqnHDDUeDTvbTZ67w4EOq6gjL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJPqLlZAqiMYFHz2gkWGtElni+zd7Cnprg1CLSplmrAnS0bdLCywEsgkKuLj2nGCm
	 gMPosw+RkD60XlMnsNFTuAve9IgN+2Am6t9qv27oLlrykTNE1P+qNxkolyxH0aPaki
	 1M//h+b+yCRjKvKZC+KqfqbKP5UT/D626Byp1N05rOLcDSdM7dUN/Ta+31GgUvGym1
	 ee3GtqUiEy72HIXh3/u4iLtVssMgUTsXephyilrjU4sy0gVSX0wPlXx0KGDG9x1VKo
	 r2G/Ccn3zeEhQrXDiVHJacTU2RqX9KRu373hmdHMTXyxzcunF1QbOIj7rxrK2+myce
	 O/jq0OOfmO6Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 16:39:17 -0400
Message-ID: <20260713203917.2143472-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071359-cadmium-shredder-d102@gregkh>
References: <2026071359-cadmium-shredder-d102@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Dongdong <zhaodongdong@kylinos.cn>

[ Upstream commit 8df560fefe6fed6a20b7e06720eeaeccec349ac0 ]

snd_ctl_new1() can return NULL when memory allocation fails. In
layout.c, the function does not check the return value before
dereferencing ctl->id.name or passing to aoa_snd_ctl_add(), which can
lead to a NULL pointer dereference.

Add NULL checks after snd_ctl_new1() calls and return early if any
fails.

Assisted-by: Opencode:DeepSeek-V4-Flash
Cc: stable@vger.kernel.org
Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
Link: https://patch.msgid.link/tencent_35F3A25FEEBF190A2E15ED787754C57E3708@qq.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/aoa/fabrics/layout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index e68b4cb4df296a..a161dd913d7ed2 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -948,6 +948,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name,
 					"Headphone Switch", sizeof(ctl->id.name));
@@ -962,6 +964,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch",
@@ -969,6 +973,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detected",
-- 
2.53.0

