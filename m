Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B812EA468
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001944; cv=none; b=uME76SB43qDvW2CQhTKt/eGPZkAhQE9CS0TvaKPG8wnKCqO/+jSmn+zHKNFMVXk2W/XoQyw8UAHSFPIb4urVZQxakkUqIf5DaZWhj0sUzyl3FAEork7KlRS55js76coibMOPpQM4+HrUhRelyxdyYHIa0gHzjy6+RC0+RHdmQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001944; c=relaxed/simple;
	bh=DeA4PE9MBHCP1GyRtldNpkHvK9XZ91PdbPhaLmz8EjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhsgnmC+jH5BOD7wlsdZXizJcn/ysxh2nWvEr+5W6CNWSra8J/WxjID4eZyl6LsFUHJ0d71AuOg0qB8p79PvDlXxQkJCm5AIhK3o/KGls2UvQyrJG9QNKo0cxHVkry+LnpETHKk5ujBnMNPU+/isU07NeNzkCUANosF6nFvRFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXqoYm5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXqoYm5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729B61F00A3D;
	Tue, 14 Jul 2026 04:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784001943;
	bh=CLRHg9pLZ+kQC3xvInb/FfriQKa9y8b+QHp52HFtgxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fXqoYm5xbA056CqD7Wa/lqOMYr+rmyIsvj2M7our4PvEHn4Ze3eWcVSM0au5C69Ml
	 TlpnFisqsmpX2VjZxe+3qfvHSxnvPN1JBZuVtBX+kMstj9ETNYqTAdb2lqcHVnSUX7
	 LfZslexSX7GJWlgpa+P2oJhP0vuJHsv96JFIvBO9obDMENsVTKVjQQBgElC9EM/Wcl
	 aAf+X4tEa00bGcQKmhaqJNP0mxFM6mIc+Pl1NUrZoEnt37oeu+eYgDyhiEMJrhhJub
	 ILrc0ZG9FefYW2poMUaAPSJbB53WPOI1ELirtULhayzBDDQ/bp8TZAAzFQAx/G1ZVN
	 E2+LqE1CJ5YRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: hda/tas2781: Cancel async firmware request at unbind
Date: Tue, 14 Jul 2026 00:05:39 -0400
Message-ID: <20260714040539.2433035-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714040539.2433035-1-sashal@kernel.org>
References: <2026071331-spooky-nuzzle-36ff@gregkh>
 <20260714040539.2433035-1-sashal@kernel.org>
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
index 624a822341bb71..ebfc08b5fb283c 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -616,6 +616,9 @@ static void tas2781_hda_unbind(struct device *dev,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_hda->priv->dev, tas_hda->priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_hda->priv);
diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
index a64f2c899d50cd..ab2a2472d7bdc7 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_spi.c
@@ -753,6 +753,9 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 		comp->playback_hook = NULL;
 	}
 
+	request_firmware_nowait_cancel(tas_priv->dev, tas_priv,
+				       tasdev_fw_ready);
+
 	tas2781_hda_remove_controls(tas_hda);
 
 	tasdevice_config_info_remove(tas_priv);
-- 
2.53.0

