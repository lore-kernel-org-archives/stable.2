Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1A48FF83
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577387; cv=none; b=j/7GbuH6aADcSHLAylK87eNj6G28vLvzmwqR9G8gm2RDJ2EGNKe5EHPUJ5xQiSHyXfmnJL6k/3ssduH7OykRhSxJP/pSLG7xFsx7Rd2ac69xRaDRGr8JNlWJg9Baj3LaKVJC2z0sa3Iw/WbWOIwSseth7ZyoDP4N4t9tZrayHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577387; c=relaxed/simple;
	bh=OVTAp+6XZ2J/qX8pJR6/T07c5n9APXt+ppIoweLHw2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxRBxWZr8IfW2Ji9DmZfxl6r/O0wiHjqDqQNvb5waDI0i/RW/q374VRHJsw7yvYuDR7uRww1F1C7bejoNAmM/Ki1q6G0ITYfD8Z33hc3GK8+9xGxzVzBYSyKab7+bSvWaKAgWP8gUDYWa7y441idSKnmjIumuqmSWzzXF558JRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS5Y8FVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS5Y8FVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1951F000FF;
	Wed, 16 Sep 2026 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577378;
	bh=tbnPyr/slvdJ3aAR0fUz65Y2d7iCx6WNE3W1FccsBDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mS5Y8FVgUzVbf4Vgc1gkbtOAXjRENlBdrVnVCEnduV4GWjA2WseMqr0MhqyVwlRz7
	 p83p66dMlzkRzBRBPi5CIFxtDOWL1mzoOQpQn88fqBHMbXNmB3111DUIpPXy/lVxe1
	 JK5C/1z4Jzu1qgD/DgXhvkI8vovNAcXMKF7tXOQKiCWopUYUwmeuzufmlgpCSlvD2W
	 4ZOhvdZewYYygsyoYaXFhwVNFr6ltIJyF+tTUQdVDrT2kcp4OywbyoQQw4I3Y742s3
	 tgt0mMCx/7VTDzgT44v4E9SgeL7eQsf1Aumt3E7cUi3H3tK3wHlzMCYkWta+Xqv676
	 W8DPjxcA+YXaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ALSA: usx2y: Avoid self-killing
Date: Wed, 16 Sep 2026 12:49:32 -0400
Message-ID: <20260916164936.551732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091646-junkman-leverage-0c14@gregkh>
References: <2026091646-junkman-leverage-0c14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a11aa8537e13dd1082c85b102b98afc2a156a815 ]

The initialization os usx2y driver is multi-staged, and the PCM and
other device creations are done after the DSP is loaded and
initialized.  Upon the initialization, when an error happens, the
driver tries to call snd_card_free().  But this is dangerous, and in
general, the driver cannot kill itself during its operation.
Hence better to drop the snd_card_free() call from there.

Link: https://lore.kernel.org/r/20210517131545.27252-6-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 8f5ef203abda ("ALSA: usbusx2y: validate URB actual_length in interrupt callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usX2Yhwdep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index eeafe580d0382..0a4da61861ded 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -222,7 +222,6 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_create_alsa_devices(hw->card);
 		if (err) {
 			snd_printk(KERN_ERR "usx2y_create_alsa_devices error %i\n", err);
-			snd_card_free(hw->card);
 			return err;
 		}
 		priv->chip_status |= USX2Y_STAT_CHIP_INIT;
-- 
2.53.0

