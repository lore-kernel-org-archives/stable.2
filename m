Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75752C21D9
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999980; cv=none; b=Sn5+B/S9X1Pt/vnzQBRg9yZIlUMz85f3RRMhOx/5/Fk80LscLlO0M0jeOmgzWtzQ0Q1nBKAzePIcqMgvccPcYjy9lcvHdp6gkmjUUCUpxaGLy1SG6sJkKMITalgdJyz80cLLXwoEmxvF2hrBkCo07vYfXBQCzFCIFZaeZqLEH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999980; c=relaxed/simple;
	bh=XaBZ0Uxy0N/ztScRmHxN01k9h2JU+z+4CnZSXRdRcLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9+LOm65eOZwN0VYgZguvtYlgGGYnNAAw2vztzGCWVBZ4VDdb03Y+P161WRzGDPPlhwJR/PqjTVuq5+xUI+RjYr7laSLm/JdEWHyeJfLkYZ6257kFyKh86Zjlxs0/+QS7Ei1/B4mk0nCX/kWDDkqdn3AKdFjF6IkYkEvoNGkDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZISH/kdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZISH/kdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B221F00A3D;
	Tue, 14 Jul 2026 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999979;
	bh=3JLF8CLFHTOvxETxUClAq2SQYVxkEUpx2ElS2Ixu9hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZISH/kdE2qYikkz61lOCjuySv/elKwOT8EjzRxQn367jDYzGGYHCqy6DFgKjJvpzh
	 A275n+GrmTpP6Iq2kjY+nWY6zLkwJipWUhdsuNjRxlIiPjLZ9FBUZlCE9zIq4rkMdB
	 St3TqtUp4Pf5c9aT2gtiPbCutyyMQ4C1g6CnIVy+N4uziSEpVjY6GUQT9GawvNtSIb
	 2reQiFATS4hB5mXFb63dxj9K+3ZdQjjVJ5GLBRz9myNnMyDaPt74zQBbEoLUn7hrZQ
	 kN0o0jQWzTYwyo3fpA/3qNtW8n3/RDIvy0T7gemPNwnBiFRHAswxo6HCeL8udeDGxW
	 gZitvS3NPLjCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ALSA: hda/tas2781: Cancel async firmware request at unbind
Date: Mon, 13 Jul 2026 23:32:56 -0400
Message-ID: <20260714033256.2396704-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714033256.2396704-1-sashal@kernel.org>
References: <2026071331-subarctic-arrival-f0d8@gregkh>
 <20260714033256.2396704-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit 5367e2ad14f0ae9350a7aaf2e77c87de39a43ae9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 3 +++
 sound/hda/codecs/side-codecs/tas2781_hda_spi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 67240ce184e1a7..dd1b0cc63ad6cd 100644
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
index 0e4f3553f27381..d243baff95a727 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -750,6 +750,9 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_priv->dev, tas_priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_priv);
-- 
2.53.0

