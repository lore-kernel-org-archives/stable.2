Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374021;
	b=FdQaZhHBXra9dNWDZJEMxAAbownUgkqtTziHrhfoyjaTfFcAQKV8y2KuSlR4vyeZHKqE
	 OSuxVbGDcIOWNtxUUc3qssM5RZhOm5bvGyFEbaf4lLdXbFeANPjhEK1jtt9UYoCfCutvk
	 iXBiW0kgrJmIDKqJx8U6Gzbw6JL576s77sumKLsb9sz/AzWZ2vsF3OdMUb4Mr3Eea0Jxw
	 U9SZZkrqGqEN38JFAtpW23aNsZfnGLxNbirRbKamLjDcahgCUsKq8tt/9a8zxaJLFCae9
	 WJ1HrSeAO00XajGcq3qfoNr1avNQrBMqQ1Wea84C8B24VHPItKxy2bPmvoJAFcqQiRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rVeLRKbk/9qvjK1YhhAaGgNm4pRn93gayungl31zkGU=;
	b=EfsD/tiE+dJiny6XIF0EaWBTKmPEZbKaSwTynd3TUVZyybAQESpQzYmW6if6fKrbzvtD
	 h/vSfAosX/a5TjP6HVtl6Szub/I+29ZXI7HZOsLNR6xlHO8uevmXNM2TMyBkkQO8owVXQ
	 y/yb3awmlNP97iOeClskMLAzEzm83qlIcF6UA7qBqPb3W1vMm3mHD4omMyLvu3ZYaNQ5W
	 xsc/0GvBCmUgjRd2SV9nbX+M6zbp1yfYAeSEifDSgLBLneHN93Lh9MPqXW4LiyfME0Spo
	 g57r6audKAcFyuQATFYyHkEAl4/szxWkIZDZdyiOwVrpNO/FRr55hVIzAU+Pb4QNLgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiTa2LEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C685606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WiTa2LEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17421F00A05;
	Wed, 11 Nov 2026 05:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374021;
	bh=rVeLRKbk/9qvjK1YhhAaGgNm4pRn93gayungl31zkGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WiTa2LEZIvn36t+QuQ9achlid8oFvWzXgUBUgZQJ3EEPer3+DHR82Iez6/gyRfyDy
	 jup09quTY0x/5kqGK+TdmEtAgl46JCR3eJaKjxqKiOebWNQD2TMBexThbgazM+e25u
	 /9VRlaOnoJJrHSSWnkSicUGFq3MPwD80p3u1R09+GfV8E+X6rQ+hU0dSYyS3wyLprD
	 MUKVvZzp6gMdMYAjp29bYd2c+b6wwAVmlI13/zznBzgJqDxumPSMd2hk15i+gV7qvy
	 rT5YplT6R2vTVbM1ktoRhIp/z243lTSzDVworCAWw/fC/pheQyZ+xdS4IYIEsZHEwa
	 Je0gX69b5O76A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Wed, 11 Nov 2026 00:13:35 -0500
Message-ID: <20261111051038.1204227-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111051038.1204227-1-sashal@kernel.org>
References: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
 <20261111051038.1204227-1-sashal@kernel.org>
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
index e1f53e8fb8295..8fd6849e0ddbb 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -604,6 +604,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
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
@@ -620,6 +627,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 		hda_pvt->need_display_power = true;
 	dev_set_drvdata(&hdev->dev, hda_pvt);
 
+	/* Allow the legacy codec driver to match again after unbind */
+	ret = devm_add_action(&hdev->dev, hdac_hda_restore_dev_type, hdev);
+	if (ret)
+		return ret;
+
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-- 
2.53.0

