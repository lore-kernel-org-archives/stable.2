Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695037A82F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994954; cv=none; b=g1iEYiEXjjNHk/XrBYsxg0XDSQRBZgHzr99qJbtSl7zAyHsztf7d0ue/CytzLJubCQu5Xz/DE5Z2BhcUE8ATvaHtVsce+r+TB0Rq3WKg6W1sM4VvEo0kzC/Z0kgm9MIXh9U7qbU8CpXDzBPBHOuYvlmerwR9xfchYwRo2CR5prY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994954; c=relaxed/simple;
	bh=StH0vzlI/EjLkJlwsWWI3V1nF1jOBllaXKp2w58gWyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSMdGtvGFWy3Qe5bHlF2iHJ0+FNNrDTzC9Dw4jLlMqB7NDXgvZ4vJSzGHMQjifJqAzhP3uCJebbiF0WuJ8BYC6if7gbh/Wu1M0xuLLYBcxmMAo/34ILc2dCwKSytTxEHyTtaSHBPZ2CY3FADp2F9XrUF1p5Ah1MuDJIERXDwYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyEuNjv7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyEuNjv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE241F00A3A;
	Tue, 14 Jul 2026 02:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783994953;
	bh=jdgOtrLuBpm1HuaiqGcPtTwl8Auh6SAN5ZFBB7VpTZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KyEuNjv70SeMN1x3rpBwvQ7dmssz0cE6wP5lWh0gFPre+7d8pXlHb0ytK1CGkdjhg
	 +eFBUUSqfhfmT9jZh7EvNWMOXWtGmCLEpsmqdoi1eL1SgcdzLWvT3AnNneq1R8Cvt+
	 YKyWWNcoRh6UPKxeu2yISrkfoND7cljiflOSqcmS7wrDqicjH8xzfDBvL2yLsKeLMg
	 J8P1+5huYEOF+YbZ8q08UdilGz4z72B45qUlfJT2TStsP53r/2Pl4XqmIZ+5R8KcA6
	 f3v63Crqivn4Po2J+nhZwEi/HgGbAd6hIdfI/+NRbqN67YVQkjUXe6hI1qHLF07KmL
	 cnVfSEiQg3rpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 22:09:11 -0400
Message-ID: <20260714020911.2355950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071300-ripping-haunt-9cde@gregkh>
References: <2026071300-ripping-haunt-9cde@gregkh>
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
index ec4ef18555bc90..58b60fdc4c52ba 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -947,6 +947,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strscpy(ctl->id.name,
 					"Headphone Switch", sizeof(ctl->id.name));
@@ -961,6 +963,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
 						"Headphone Detect Autoswitch",
@@ -968,6 +972,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
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

