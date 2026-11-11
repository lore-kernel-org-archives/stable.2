Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371004;
	b=sBOsj+lp4+/TrRTKv0BRUz2yY4+r2xoBum6IfCJ/Z32T37xbrWvpYlfS55VR1GQv7Roa
	 s4h1ZHU59xf0X2W0eC/C2dymvDN6Ukdhif6BeI97jqzJLVbSCpFAWh9eZKiyAVuYEOiXZ
	 CPINDpIaVqpasho+kwSRXdc8akaIV0QxI7blAv48f6gNpBRWGvbWD0wc+B8qKoRZK6sL5
	 06a5PQ5ZMqoGMxR9Nwt7QDvMEYyh9nwDT6+FeikLqzfVzcYojgl5ggzl+GgOAJINweeL2
	 4xmhg/E+M198zR4ZKfttSu7ribjXSG9kvoqj5SmiCW2Xc6f/RmP88BQiQWLdHS5Hi0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qISACkKJSz4xTKrSxyxt0qfphN6KfeTVhzb/4UksWd8=;
	b=RiqQay6MagSfwJtmjhf3uVx1K9RMLrj7h2WaXBXO/v5VuxanSa7zAxD3W5+Lp0DS+4rc
	 jprP2JNjJQoqbOv2xz0kjXlbUJE1L8PJRI0iIoPgybK7cmdsSG1Fe6RUeDmEIZ/u06eur
	 Jk5ojftAAdHef2+5VMHIf9saABWgRYGiLcUxlT/66PmqFOLJUb5oHqwKIq8Kncut5Qbow
	 sff3O6eqFzuSC6hUWQ9rzD9HaVBbAEwz+n8uyv8JUHi4mzU9IdwtkfzSJEtMLw3YVPqdL
	 5a3kD3qu29yuuFWdQg5GVh/5QOKGY0GlSjpTVvDYOczYdoqI/f5h6CoZtRYKvbpBAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmYsOkzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD69606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mmYsOkzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FF11F00A03;
	Wed, 11 Nov 2026 04:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371003;
	bh=qISACkKJSz4xTKrSxyxt0qfphN6KfeTVhzb/4UksWd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mmYsOkzBFnY4+gojiZi2X5aNcgwG41OFDAi3p5TfXXOvOC5tCdUmxb6xd3J9eDIy5
	 b6svNGvYKX2/tAyy3oI60gCcDQl9wHM1AJNg6v7P1c0w3PGz6zF7fBzZSOYS8huW1T
	 hOlBJn2xgXRKP6A6/5NKneyvwdvLypOUWtNObAP/6TUKsSM1BlSk277etAfrVaFH0X
	 zDNbMa6be5EZESjbFf84gcYcLJj12KajROHhSMxXoy26wkgHVPNL1J0emlCHWqMqvi
	 4/x1Lns0r2pr3jgZ2Dwe6SxehKGMiJH+1avMGCzeIqWaa3tL/vzH/VV51dD3wuc2rt
	 hIxUEJtt8g8ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 10 Nov 2026 23:23:21 -0500
Message-ID: <20261111042315.1087116-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111042315.1087116-1-sashal@kernel.org>
References: <20261107050552-failed-7.3-08a44bde821d@kernel.org>
 <20261111042315.1087116-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 08a44bde821d4fe22c0b6e63da04b3c59ac243a8 ]

hdac_hda_codec_probe() changes the type of the codec device to
HDA_DEV_ASOC to prevent snd_hda_codec_unregister() from unregistering
the device when the card is freed.

The type is never restored, and hda_bus_match() requires the device and
driver types to be equal. After unbinding the codec driver via sysfs the
HDA_DEV_LEGACY codec drivers no longer match the device and bind fails
with -ENODEV.

Restore HDA_DEV_LEGACY with a device managed action registered before
the component, so it runs after the component and the card are gone.

Fixes: b60ee2e281b6 ("ASoC: hdac_hda: overwrite hdev type to HDA_DEV_ASOC")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261027083840.28813-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 0604315a1f0f3..9e45b20940f2f 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -633,6 +633,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
 	.endianness		= 1,
 };
 
+static void hdac_hda_restore_dev_type(void *data)
+{
+	struct hdac_device *hdev = data;
+
+	hdev->type = HDA_DEV_LEGACY;
+}
+
 static int hdac_hda_dev_probe(struct hdac_device *hdev)
 {
 	struct hdac_hda_priv *hda_pvt;
@@ -650,6 +657,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		hda_pvt->need_display_power = true;
 	dev_set_drvdata(&hdev->dev, hda_pvt);
 
+	/* Allow the legacy codec driver to match again after unbind */
+	ret = devm_add_action(&hdev->dev, hdac_hda_restore_dev_type, hdev);
+	if (ret)
+		return ret;
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-- 
2.53.0

