Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0386F36A033
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998297; cv=none; b=rOiEiLK44YYfQXVRRuY00sGEntAzgkFwqvLEL4Nahjol8ROihx4CPbNRtwSuls/SvIYpDYAaiY+DUdAypG3u6yzC5UpVyvFJRR6bHR64TqNQCA/tfaOiwYuRMuIQdto1SS483dLmhmzShkT3lGqmbLI0lZa5Wu8miEjmMSDyrCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998297; c=relaxed/simple;
	bh=k1Kz+QDb8XQWmvah9PqPVMHvqd+gDZyaHAgPCqM7cxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLGRmQiHLC4p/olh0wvL2Zj2ssrLGkInJpRYJc/EVSJi8myvwR5/odXiWQMEdcnWYCDV+v39UAdVP0zQZz5i/519THkyYBLQjf+toFNbANo8rIIi/22AZBuG9R1tqFHjAbZlb3Zjx30XHOEydfoxgc5rkbFKItnyxaXMOaBA5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIkXqHW5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIkXqHW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B61F00A3D;
	Tue, 14 Jul 2026 03:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998295;
	bh=zXQW2PJWzU+uAmH0+uCVLjgBsvnWTOvkE6I/zhjKslY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIkXqHW5upZlPhpoBXbZAkRzSTJN9aIjXlPuRSbWlcljuzZdx5+kp2JeLf5AXyDUw
	 mD+Q8oOUkLcy0W7Kfal8i57KkERYTuZbzdoxA8bDJBvThX2412S+0Jje3mtbtiKEzE
	 kMvsllmx28XsMp0kE5h6IqRxkNqz6abS2iPva9X97t0IXjxdXTSTYCowcM74FfkCMY
	 1MAD3oFZhGtS4aKZq4BKL/ZZUSDe23Uwy5/C+vrSocaDarcCExWiFxlxXAHC19JlR5
	 Ku/p5bGanLl6kSrktS9SRm2diEjDaQ2y9DlE9NI90BWvzzkECXH39vk4TUjnGBm39V
	 aTjQDkWbIVJAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 23:04:53 -0400
Message-ID: <20260714030453.2382650-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071300-landmass-domain-9bfb@gregkh>
References: <2026071300-landmass-domain-9bfb@gregkh>
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
index d2e85b83f7ed06..125122dca6212b 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -947,6 +947,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (lineout == 1)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
+			if (!ctl)
+				return;
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 				strlcpy(ctl->id.name,
 					"Headphone Switch", sizeof(ctl->id.name));
@@ -961,6 +963,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 			if (ldev->have_lineout_detect) {
 				ctl = snd_ctl_new1(&lineout_detect_choice,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strlcpy(ctl->id.name,
 						"Headphone Detect Autoswitch",
@@ -968,6 +972,8 @@ static void layout_attached_codec(struct aoa_codec *codec)
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
+				if (!ctl)
+					return;
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strlcpy(ctl->id.name,
 						"Headphone Detected",
-- 
2.53.0

