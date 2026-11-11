Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372735;
	b=UnUCtRMK3exyRd1/2D3K7zL94bpX2JWaa+u/dLQKONDC1zJBE2BRs2mm7Qm1ME38lk0E
	 zRBthfKITQFDDsu8dXKXkSgcYMeplGEj/X93GPhDyKARf5oMdGAHa+H9tSEiwro0rN58t
	 Wo8Y6Rr7YiS7gcN1IGia56JOuAoXBgXHGNVKpXsb9428dJh9L4uZ1hkqhg6x5+kiwhlWx
	 RI7UgznOCRHjy6/BSX+A61w12M4oQx/yvzGVEhLsLU2Wkag5CRNHDB0jvFjG/U2AyJA+u
	 Q9MMcFgibbqYXa0jnLrZmbl6GDFD9XXnP55bAASfJkPzD59C8EfnANGVE/1zW8kuAhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372735;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WdIuwYAkaT/6hQVflAFIDy69chyQOc7ERwvWPEP7Fsg=;
	b=2XigGIKR58ON3Ra1eRYtYX6ld8fgEl1f4nxsW0DeDxP1ZYnFKLVvzvBD6z6txLETPUp0
	 Vm0gcjFBptbsGsmCY6hYrHXoXFtZS0l+7w4oUn/8I1aycxCuNFxw+CYuDFn4qUUn3c590
	 R7FIIwA7OfVYb2Ya0ADB0daexVSs0M6GExCEfyadCTRFDBrbT8fTbciHsdjfxUpawufhU
	 yEx8v1dwGTdMaggiqc+o9aOkx9YG8BARupBHtuFhov98IucNB9sfHeh9Li73vGIzJmbLR
	 om7y/MILSno/Ga0dt8w+Ti9Z1xIR+iEFt0z7GVWLeqwyT7RTrdNg4doeF5NtlGQov2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB4vRTw4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC3606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jB4vRTw4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C86A1F00A03;
	Wed, 11 Nov 2026 04:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372735;
	bh=WdIuwYAkaT/6hQVflAFIDy69chyQOc7ERwvWPEP7Fsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jB4vRTw4dY6/HE7/6TU6hc6J8R/MA6K76m0EJuDc0G2sHdA7+rqLOe+nbjL24IbfU
	 NXUEg/fD4XeeTfehdnE82tcIxrXi5fSRNTDHS5kD8WKUOai4TU3YIlPCWGuD2DV+/h
	 jsraFMsFezhI0MZ31MC1GZnzqNl6ySvudIAvossI27NBWZ1q3KIa/dIApOInUB9HKD
	 qx+/VkofkwO4IQM3AeKIbOxa0grfvK/I6c9o1Psdmuwh/9EZhWfsEXV2TDBJxPNR1f
	 bsYZjJnNEVp1h7QaMQ8UQhetu8oRTvWbjy8aYxeSAB60YAf1Gqs03U4cUzUwyoaZX5
	 VARvsxcMS8qVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 10 Nov 2026 23:52:12 -0500
Message-ID: <20261111044945.1160231-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111044945.1160231-1-sashal@kernel.org>
References: <20261107053955-failed-6.6-08a44bde821d@kernel.org>
 <20261111044945.1160231-1-sashal@kernel.org>
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
index 5a196a756aaf4..d39f93aefcbf3 100644
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
 	hlink = snd_hdac_ext_bus_get_hlink_by_name(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-- 
2.53.0

