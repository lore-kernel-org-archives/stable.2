Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529A356772
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975171; cv=none; b=pRsmcgcWOmglQEu+GIRzERD4Mn+l2nVW21uxRT08vNUvCUncpBuFXBzN1cH5XN2ezFUy3o5/2ZwQc3DWATPRjGPkPf7+kCwacakdVXoJ2rscC0yHK4PdlKY4EW0A209kx45H+YEez+CyFzJrTrqu4lhalDNvWxlozx/NK+E/WV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975171; c=relaxed/simple;
	bh=QxTlfGWAMSCW4MV03u+LwyKoteoJ2MtXxOttGn/k/FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gL5Z7dRGf3eVbgsv0owcL/hAixcY2x1bJ8RPTDgkSPFKATSOW8OH46UvkfSKnHkl0K0THywKNdXUi3zLRRIgMOjcSjXKAQcZ7XyFs3VtsSNbEO81comKG507Wtg7XIpUFFM1LyQkrMfOzdOHxrbryZHrJfF6XKptjvalqXZRaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckkO8ksQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckkO8ksQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221751F000E9;
	Mon, 13 Jul 2026 20:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975169;
	bh=64uuml4Q1dTgYnsk3Thz6+3awGttCcYagDKuUk0/qDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ckkO8ksQzg8hAbFxT24sCcMYdLtEayyyHpA880K3Ex07J8ZEjufYEH9GX/DWecLTF
	 WxSCxvaBYMbXNt7+4eYeNS/xapvUNpB7XtKXRrCoYIBRsJrlTmQ6LQ/HCasgTPuQ7w
	 6pu1ecqKvmZReYuNDo/eehLha9AFZdO4MjSH5rhEudnNl3S2LfaFZ7wGbGeG1rX4Lp
	 wc/qevPAjT0GH5smmxiBlXpUZ5WvoTVTufTsFMQ38lZK+RPd0TgiMQ4Pa4zJbWA1mr
	 srzDN2Eiz0n4J5q+AJv4LOe/96Ssv8ZHq3sYwvn/zHW1ON9RUYOra3ShkY1Ll07EO3
	 FqSJbXgrV04xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/cs35l41: Fix firmware load work teardown
Date: Mon, 13 Jul 2026 16:39:27 -0400
Message-ID: <20260713203927.2143760-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071358-headfirst-radiantly-f108@gregkh>
References: <2026071358-headfirst-radiantly-f108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit b65020d5398f499c09498c9786dba6d67ae57664 ]

cs35l41_hda creates ALSA controls whose private data points at the
cs35l41_hda object. The firmware load control can also queue
fw_load_work.

Those controls are not removed on component unbind, and device remove
only cancels fw_load_work through cs35l41_remove_dsp(). That helper is
skipped when halo_initialized is false. With firmware_autostart
disabled, a firmware load can be requested before the DSP has been
initialized. If the component or device is removed before the queued
work runs, the worker can run after teardown and dereference driver
state that is no longer valid.

Track the created controls and remove them on unbind so no new control
callback can reach the driver data or queue more work. Then cancel
fw_load_work to drain any request that was already queued. Also cancel
the work unconditionally during device remove before runtime PM teardown.

Fixes: 47ceabd99a28 ("ALSA: hda: cs35l41: Support Firmware switching and reloading")
Fixes: 4c870513fbb0 ("ALSA: hda: cs35l41: Add read-only ALSA control for forced mute")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260511-alsa-hda-cs35l41-fw-work-teardown-v1-1-1184e9bc4f25@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda.c | 77 ++++++++++++++++++++++++++-----------
 sound/pci/hda/cs35l41_hda.h |  5 +++
 2 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 42c576d9f1179b..099b8e9582b841 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1293,6 +1293,43 @@ static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ct
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(hda_cs_dsp_fw_ids), hda_cs_dsp_fw_ids);
 }
 
+static void cs35l41_remove_controls(struct cs35l41_hda *cs35l41)
+{
+	if (!cs35l41->codec)
+		return;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->mute_override_ctl);
+	cs35l41->mute_override_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_load_ctl);
+	cs35l41->fw_load_ctl = NULL;
+
+	snd_ctl_remove(cs35l41->codec->card, cs35l41->fw_type_ctl);
+	cs35l41->fw_type_ctl = NULL;
+}
+
+static int cs35l41_add_control(struct cs35l41_hda *cs35l41,
+			       struct snd_kcontrol_new *ctl,
+			       struct snd_kcontrol **kctl)
+{
+	int ret;
+
+	*kctl = snd_ctl_new1(ctl, cs35l41);
+	if (!*kctl)
+		return -ENOMEM;
+
+	ret = snd_ctl_add(cs35l41->codec->card, *kctl);
+	if (ret) {
+		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", ctl->name, ret);
+		*kctl = NULL;
+		return ret;
+	}
+
+	dev_dbg(cs35l41->dev, "Added Control %s\n", ctl->name);
+
+	return 0;
+}
+
 static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 {
 	char fw_type_ctl_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
@@ -1328,32 +1365,23 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
 		  cs35l41->amp_name);
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_type_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
-
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_load_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_load_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &fw_type_ctl, &cs35l41->fw_type_ctl);
+	if (ret)
+		goto err;
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
-			ret);
-		return ret;
-	}
+	ret = cs35l41_add_control(cs35l41, &fw_load_ctl, &cs35l41->fw_load_ctl);
+	if (ret)
+		goto err;
 
-	dev_dbg(cs35l41->dev, "Added Control %s\n", mute_override_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &mute_override_ctl, &cs35l41->mute_override_ctl);
+	if (ret)
+		goto err;
 
 	return 0;
+
+err:
+	cs35l41_remove_controls(cs35l41);
+	return ret;
 }
 
 static bool cs35l41_dsm_supported(acpi_handle handle, unsigned int commands)
@@ -1491,6 +1519,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 		memset(comp, 0, sizeof(*comp));
+
+		cs35l41_remove_controls(cs35l41);
+		cancel_work_sync(&cs35l41->fw_load_work);
+		cs35l41->codec = NULL;
 	}
 }
 
@@ -2030,6 +2062,7 @@ void cs35l41_hda_remove(struct device *dev)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+	cancel_work_sync(&cs35l41->fw_load_work);
 
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index c730b335158944..65aed476fd8025 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -56,6 +56,8 @@ enum control_bus {
 	SPI
 };
 
+struct snd_kcontrol;
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -74,6 +76,9 @@ struct cs35l41_hda {
 	int speaker_id;
 	struct mutex fw_mutex;
 	struct work_struct fw_load_work;
+	struct snd_kcontrol *fw_type_ctl;
+	struct snd_kcontrol *fw_load_ctl;
+	struct snd_kcontrol *mute_override_ctl;
 
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;
-- 
2.53.0

