Received: from mail.sms-medipool.de (mail.sms-medipool.de [178.63.14.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAC175A6A;
	Wed, 10 Jun 2026 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.14.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114289; cv=none; b=ImcGJyYRJ14AjI2sYGMPagqlUBZYRyIgf155KuDs5I1QUHP88aFG2nKzKEs2VKQLPBa277U0/uE68qoAs1hhLu++7EtMBSpbkcRFaBTIpHxpWiMumsEjVa0UE9+KAl4Sl27OOsjwrBwB5WbF1KzmnUsnLpkzBYx8vsPvEJlm5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114289; c=relaxed/simple;
	bh=ihUlkXSiWA5fqy0pE0DcLIch1Zf7ZM2UeRQXu1e/d1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlhW0lUi7EI3PpJDLBwyNYhRfvsF0pxm0pkxFiRsf78euot2PHfse5vTgU0Sud7QwLA7A4X0bvl7lDCAa33w9GSF7DIz7G/WZoK4u0Fz23m3mhWeEw7Yj6+Sotea3gXIFgMLpoH9sHtHb9bkx59lQN4H20TAdCGCMk0EoAm9Ldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de; spf=pass smtp.mailfrom=sms-medipool.de; dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b=u+eNISFm; arc=none smtp.client-ip=178.63.14.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sms-medipool.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sms-medipool.de header.i=@sms-medipool.de header.b="u+eNISFm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sms-medipool.de;
	s=mail; t=1781113715;
	bh=7CkiQSdVEazQZCCPmgIysSgNdiIAqqWLAFnaduLrUlg=;
	h=From:To:Cc:Subject:Date:From;
	b=u+eNISFmHGseP8N+lfeibs4IRYOJCPuvlX1FeO0BU6PbGObJFXmnV2mJwPYcNMuw3
	 4pctoaVwys5K27CEBi6CQ80Bp6qhLLXEw40ZtrucMja7EZGwd1Io5ghMEsU9H5fyIv
	 zAY+nnGh2cUIvoZ13e+lqL6VhFhlEf3Q9M2wFagLkcVhrY11PnKUmFjtRFle6f+ZnM
	 yMRCEa3WPUDOpXHZ/FhQ5PN1uZIKHqObmgWlZHEESJ3OmDo+suaijYoYfWL5/YJY2n
	 HIKJc6XGBmCF8xrwLJGF7otWSDL3rydezOV5/AicL9oLdMIgyavIAnQOpio/DaW4yJ
	 YQyND8mkrVMfQ==
Received: from mail.stoss-medica.de (mail.stoss-medica.de [213.147.17.40])
	by mail.sms-medipool.de (Postfix) with ESMTPS id C8F3811D51;
	Wed, 10 Jun 2026 19:48:35 +0200 (CEST)
Received: from NUC16-Linux.sb.golima.de ([95.88.98.111])
	by mail.stoss-medica.de (Kerio Connect 10.0.8 patch 2) with ESMTP;
	Wed, 10 Jun 2026 19:48:34 +0200
From: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
To: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	stable@vger.kernel.org,
	alexander.kaplan@sms-medipool.de
Subject: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
Date: Wed, 10 Jun 2026 19:48:34 +0200
Message-ID: <20260610174834.6301-1-alexander.kaplan@sms-medipool.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Panther Lake the keep-alive engine poisons the display side of the
audio path for multichannel PCM.
Once KAE has been active in the running display power cycle, the first
6 or 8 channel stream on that pin plays silent and wedges the pin.
All subsequent streams stay silent regardless of their format.
Only a display power domain cycle recovers the pin, in practice a
reboot or one suspend cycle.

The wedge sits behind the audio converter.
Sample counters in the display audio register block keep running during
the silent playback while the output stays dead.
The wedge survives clearing the KAE bit ahead of the stream id
programming, fully quiescing the converter (KAE bit, stream id and
format cleared before the multichannel setup), a complete codec and
controller reset through a driver rebind with the keep-alive kept off,
and powering down the audio well for ten minutes.
The sequence is harmless when the keep-alive was never enabled in the
running display power cycle, which isolates the KAE hardware as the
trigger.

Easy reproducer on a sink whose LPCM capability is limited to
2 channels:
speaker-test -c2 plays, one speaker-test -c6 run plays silent and every
following speaker-test -c2 stays silent until reboot.
With enable_silent_stream=0 the same sequence plays normally.

This is the failure class already known from commit 6ab6f98fcdc9
("ALSA: hda/hdmi: disable KAE for Intel DG2").
Handle Panther Lake like DG2 and fall back to the older i915 silent
stream method, which uses the regular stream path instead of the
keep-alive engine.
Like on DG2 this keeps the codec powered while the silent stream runs.

Cc: stable@vger.kernel.org
Fixes: e9481d9b83f8 ("ALSA: hda: add HDMI codec ID for Intel PTL")
Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
---
Found and verified on an ASUS NUC 16 Pro (Panther Lake H, codec
0x80862822) driving an LG TV through a Synaptics VMM7100 DP-to-HDMI
protocol converter, kernel 7.1-rc7.
The poisoning is independent of the sink and of the video mode.

This may also fix the silent Dolby TrueHD passthrough on Battlemage
reported in
https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7515.
Battlemage uses the same keep-alive code path and TrueHD passthrough
is the same first-multichannel-stream pattern, but I could not test
that hardware.

Workaround for affected systems without this patch:
snd_hda_codec_intelhdmi.enable_silent_stream=0.

 sound/hda/codecs/hdmi/intelhdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
index 6a7882544a..52997caae9 100644
--- a/sound/hda/codecs/hdmi/intelhdmi.c
+++ b/sound/hda/codecs/hdmi/intelhdmi.c
@@ -791,7 +791,7 @@ static const struct hda_device_id snd_hda_id_intelhdmi[] = {
 	HDA_CODEC_ID_MODEL(0x8086281e, "Battlemage HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x8086281f, "Raptor Lake P HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862820, "Lunar Lake HDMI",	MODEL_ADLP),
-	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_ADLP),
+	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_TGL),
 	HDA_CODEC_ID_MODEL(0x80862823, "Wildcat Lake HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862824, "Nova Lake HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862882, "Valleyview2 HDMI",	MODEL_BYT),
-- 
2.54.0


