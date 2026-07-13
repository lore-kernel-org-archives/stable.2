Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3A1E5714
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976023; cv=none; b=RWCQzY2eoxoAMpbkxXN2fPgW7r3dWUaTQx/k2Chy1fDDXFsHIfGE0T3wDi2LbhakKtdcMYfukKuUMGYGljUmR34PbCwN2tLboIFsACJJTsoEZjEMFnMO74ZsVI0AX1fsuOJxqwR0f6xf5hCLmsYqgzU9+Re+OA7vhImvhbtGMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976023; c=relaxed/simple;
	bh=BfSD06FMAAtPpAY3b7+FFO6zazcH5oBdA1e84WOsq/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0WcqwQFNR7ZMp7OZg7u3fO8xJQbOGqk5bUWFGCVAmFY63+BreswdOM3lbDf6FFgKkAOhB00/xZrvT/MwgyinJ3Ky8zH9wKrTDo74o0LmmIQ8+jSwZw7erBOOj7je9GjJU8CuYEsY4Fbnj+UTdqdRdgdjk4sScA9thAFx7JdOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVklmcXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVklmcXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C251F000E9;
	Mon, 13 Jul 2026 20:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976022;
	bh=T0kgOlEEXt0Z+lA+Sm8yIgmzE4QdZRrIVhoUGvgV+a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVklmcXqYvGKwJRHVvxCp70IAEjUWhNMVRFHzzplklPafHEGi3G7VBZG6rYgt+eCr
	 /6E/b2kgN+uk+rfWQRyM/4/W7pY75WTiUQ+JGliFgaW37K6E99H2xzzpm6AtfeZhBs
	 4l+IGl1cugeRoxP5JPKrPVJTfu39evMxfbkohtsBVI3PoMkidgQO0AULA9QXhCWdl9
	 XVsRv8lqL21jxiwYh5YdITAt3amuLfMNKkhnN2l/exsDHZlRjLsSy4ftr7/T3BydhZ
	 QLPhA31a8rGiVj4+Pgn0RZ+MegviD5AOUZXJlsS5+WDIyAHx7i5saBtbPjjDgJ4TlN
	 ZbjnKeyEBU3Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Dongdong <zhaodongdong@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: aoa: check snd_ctl_new1() return value
Date: Mon, 13 Jul 2026 16:53:39 -0400
Message-ID: <20260713205339.2148895-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071359-swung-cycle-429d@gregkh>
References: <2026071359-swung-cycle-429d@gregkh>
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
index 850dc8c53e9b55..d6da0c3f1740d7 100644
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

