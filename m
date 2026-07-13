Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492636F8FE
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948343; cv=none; b=r+x2ep6u7niPKYm7rN+S0LHw6LvO0nApgtPPhk8paBIW0inXGEU0EcJBzRA/air9VkBe9C4kehLHeFzxWz804KGbwDhk8IM8vWiRPk8p/CUJrlN2ZpL04Ruq6FF81ry6hGDrza8xlqALCdAJ8tZrbzpaBOLwzUDAqMsRqokBr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948343; c=relaxed/simple;
	bh=ycDq7zQaet65dDcvI8nILlxsGEzqXGd0HeiMhlwRQDQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lC08E+42f7qZSDcpDSOp9MklFzyk6oi1TJwb7KsQMkGYMHeyfmVzZUhyEgwpHuOpNJ5nG6MIj/PQbZCONgfqZr3sxP5RTMRN9s605iYhvmo2TyHOGUDmi2c9d50hMxBWK8NNTIZKnh6uxoJTlrWCsmx2dirHdEvOfM919+yrTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w2mivSWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w2mivSWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F271F00A3A;
	Mon, 13 Jul 2026 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783948341;
	bh=8i6OToKmLv1nF9eoDsqh93XCGc9P3ouJJB5gfg/ZuzM=;
	h=Subject:To:Cc:From:Date;
	b=w2mivSWIUIVveP29vSkKDE+WHWBSBzkbh/3+PleoIZfeIQJyU1bxFN522k+qjLyxe
	 ZUQZx2S0/EzP8rVtSXXbni7WsDCwNrqSBcSVKd7pgAzkFBJdkai1QxBz9y4jFnMSE0
	 owXBmvWLbG+GP2helkXY7T7IHSW1SXymjWfuQV8c=
Subject: FAILED: patch "[PATCH] ALSA: hda/cs35l41: Fix firmware load work teardown" failed to apply to 6.12-stable tree
To: cassiogabrielcontato@gmail.com,sbinding@opensource.cirrus.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:59:58 +0200
Message-ID: <2026071358-headfirst-radiantly-f108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b65020d5398f499c09498c9786dba6d67ae57664
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071358-headfirst-radiantly-f108@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b65020d5398f499c09498c9786dba6d67ae57664 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 11 May 2026 01:29:34 -0300
Subject: [PATCH] ALSA: hda/cs35l41: Fix firmware load work teardown
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index acfccc848f82..64a5bd895fd1 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1325,6 +1325,43 @@ static int cs35l41_fw_type_ctl_info(struct snd_kcontrol *kcontrol, struct snd_ct
 	return snd_ctl_enum_info(uinfo, 1, ARRAY_SIZE(cs35l41_hda_fw_ids), cs35l41_hda_fw_ids);
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
@@ -1360,32 +1397,23 @@ static int cs35l41_create_controls(struct cs35l41_hda *cs35l41)
 	scnprintf(mute_override_ctl_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "%s Forced Mute Status",
 		  cs35l41->amp_name);
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_type_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_type_ctl.name, ret);
-		return ret;
-	}
+	ret = cs35l41_add_control(cs35l41, &fw_type_ctl, &cs35l41->fw_type_ctl);
+	if (ret)
+		goto err;
 
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_type_ctl.name);
+	ret = cs35l41_add_control(cs35l41, &fw_load_ctl, &cs35l41->fw_load_ctl);
+	if (ret)
+		goto err;
 
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&fw_load_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", fw_load_ctl.name, ret);
-		return ret;
-	}
-
-	dev_dbg(cs35l41->dev, "Added Control %s\n", fw_load_ctl.name);
-
-	ret = snd_ctl_add(cs35l41->codec->card, snd_ctl_new1(&mute_override_ctl, cs35l41));
-	if (ret) {
-		dev_err(cs35l41->dev, "Failed to add KControl %s = %d\n", mute_override_ctl.name,
-			ret);
-		return ret;
-	}
-
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
@@ -1522,6 +1550,10 @@ static void cs35l41_hda_unbind(struct device *dev, struct device *master, void *
 		device_link_remove(&cs35l41->codec->core.dev, cs35l41->dev);
 		unlock_system_sleep(sleep_flags);
 		memset(comp, 0, sizeof(*comp));
+
+		cs35l41_remove_controls(cs35l41);
+		cancel_work_sync(&cs35l41->fw_load_work);
+		cs35l41->codec = NULL;
 	}
 }
 
@@ -2060,6 +2092,7 @@ void cs35l41_hda_remove(struct device *dev)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 
 	component_del(cs35l41->dev, &cs35l41_hda_comp_ops);
+	cancel_work_sync(&cs35l41->fw_load_work);
 
 	pm_runtime_get_sync(cs35l41->dev);
 	pm_runtime_dont_use_autosuspend(cs35l41->dev);
diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.h b/sound/hda/codecs/side-codecs/cs35l41_hda.h
index 7d003c598e93..56ec07c0bb74 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.h
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.h
@@ -57,6 +57,8 @@ enum control_bus {
 	SPI
 };
 
+struct snd_kcontrol;
+
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
@@ -75,6 +77,9 @@ struct cs35l41_hda {
 	int speaker_id;
 	struct mutex fw_mutex;
 	struct work_struct fw_load_work;
+	struct snd_kcontrol *fw_type_ctl;
+	struct snd_kcontrol *fw_load_ctl;
+	struct snd_kcontrol *mute_override_ctl;
 
 	struct regmap_irq_chip_data *irq_data;
 	bool firmware_running;

