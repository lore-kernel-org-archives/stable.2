Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43D1EEA31
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991781; cv=none; b=plU55Y9lldCgt/LTF+Ae2H0EzUMDCb012ks7hH0cNttJgnyfup/vpABcdFbr/bLXJ9TCpssQcqsjPQmXtc1kThShaTqE1+HvEOfom2r9djs45ZlvZltfdBxMlAS4cXvT8PAPNOr071H+pU2Z7mJr5SGw0btNllLUjiS2dlfFgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991781; c=relaxed/simple;
	bh=StH0vzlI/EjLkJlwsWWI3V1nF1jOBllaXKp2w58gWyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iclN1nNHyw2MAsLipARhYlooSRfXcayG6tGoTOHsiN1+YCIRYFITbGDkg5SKFpz++OK/JfxI18TYhSgtlmqnK15g5rmANrWcQVc68HWdNpxnQV2jGOGlYw6klMG0/eo1WgIeSBOUlmczDsmUQwAzAwe4NUWy4HldAV/xeLe0IQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGlXC4Nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGlXC4Nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489351F000E9;
	Tue, 14 Jul 2026 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991780;
	bh=jdgOtrLuBpm1HuaiqGcPtTwl8Auh6SAN5ZFBB7VpTZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGlXC4Nb043aGNXMncmxE9hSTkolcT+3tzHf/E7c/2Sm6jRFcWT3Qaq37jfZmiegS
	 5KGwVOKnlgLapGqhtWqGSaZOZrWlLTeDSb1JWF9lstgsIIKoS66+xyhtE6xVRD8HBh
	 8uAIgmAclnT/cBafp5VagxNkF6mYmdekOCiE7W4S1EkYt6TuZWAqK+f3kWlwcHCWuS
	 +MfG7dLRzojKnnf75M8ezJQD6TJuV0FC7WYdkrYK9Tjy7uaQF4qR17p79C8FUnwbTW
	 No5QSRWdf4TK8kbBKaqnGEyG4IpHuxWgfdBxsDcxe/AuLHDzsC7JThnyQyff2fpa25
	 QXM3zRMqvR+qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 21:16:17 -0400
Message-ID: <20260714011617.2188420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071300-unstitch-evident-5dde@gregkh>
References: <2026071300-unstitch-evident-5dde@gregkh>
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

