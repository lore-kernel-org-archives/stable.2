Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4EB421A1C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948640; cv=none; b=eWj6k8+0MwFZFqhd9EivwJPha7Um4aqrT3kKYt7tsNEkZQKzK7F8ykhsDk3+H05dKonuQLVsy6LkdOfwgSu9kaJksSsrIQjOsxWJi5ZAyBylf3VR8xa1tGFXXQVQ+3zdGjFKo+7PB28GSbrv8fGxz/x8wUSbtFOn3b1+ihnPzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948640; c=relaxed/simple;
	bh=CPK3N16uXy6gi3vvzp9OnbyZrbgsY65DniMmxRR2NTQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DMwz+juGEKJ4/u8LBS/QHAXv/nw1o2Tpo+x/GwEtCdWr3qSztr3SVBQi90a1tnzDXOxywQZFcCJGegL95NjoTlSnUgKfj4XTNaPTrOiyhhnf5ThzGvLe+6i6q9kTvSZUDzmeys+Sw9OLreIzKgFQM7wsMicM1aZYU7FjprKELmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wkAxEL3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wkAxEL3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A911F000E9;
	Mon, 13 Jul 2026 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948639;
	bh=U0DP4it3kWjv+PVRbE0icG0Ywunwq+OPXGO3OSfP97A=;
	h=Subject:To:Cc:From:Date;
	b=wkAxEL3SdiLgtxwL4Dx/dGQ9lvSAfHYY1/TH6is+o+AZd5hz4SfmOHuj+mzB6aZFp
	 55T0SICJrDaSpTpDo6O4T+AjLYfZJAB3hPvK74mHnUknu/Y1YFvCHUjGb8rhi8YDBX
	 PsJ4NBc6KL5i1hrwUDUScok5X66J2wdm8DlZCCz4=
Subject: FAILED: patch "[PATCH] ALSA: hda/tas2781: Cancel async firmware request at unbind" failed to apply to 6.18-stable tree
To: cassiogabrielcontato@gmail.com,dakr@kernel.org,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:03:31 +0200
Message-ID: <2026071331-spooky-nuzzle-36ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 5367e2ad14f0ae9350a7aaf2e77c87de39a43ae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071331-spooky-nuzzle-36ff@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5367e2ad14f0ae9350a7aaf2e77c87de39a43ae9 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 5 May 2026 08:18:17 -0300
Subject: [PATCH] ALSA: hda/tas2781: Cancel async firmware request at unbind
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TAS2781 HDA I2C and SPI queue RCA firmware loading from component
bind with request_firmware_nowait(). The firmware loader keeps the
callback module pinned and holds a device reference, but the callback
still uses driver-private HDA state.

Component unbind removes controls and DSP state immediately. Later
device removal tears down the TAS2781 private data, including
codec_lock. If the async firmware callback runs after unbind has
started, it can operate on state that is being torn down.

Cancel or synchronize the async firmware request before removing
controls and DSP state. A queued callback is cancelled, and an
already-running callback is allowed to finish before unbind continues.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260505-alsa-hda-tas2781-fw-callback-teardown-v4-2-e7c4bf930dc8@gmail.com

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 67240ce184e1..dd1b0cc63ad6 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -588,6 +588,9 @@ static void tas2781_hda_unbind(struct device *dev,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_hda->priv->dev, tas_hda->priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_hda->priv);
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index 560f2385212d..522b1bbc0bab 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -742,6 +742,9 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_priv->dev, tas_priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_priv);

