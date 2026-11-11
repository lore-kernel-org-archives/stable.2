Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371901;
	b=KQTRl0hTPRrfF6JPCExaZUhSxK440i78RXa3MLbjdymZtyUjsxPXxH3U45+N7ju5LiPz
	 pIOOdhLMG2JKPtCUN1K4sRnfHGDI9VXYyxRyTbr/T2WMoesvK0Aw6ZudPWobv7A5U4mkB
	 h73u44IWeZD5rXOvLxXzkhM0aJGCSJhMmK8VsW1WwWho9NburF9D2u8+hgMxX/Ho0kuo6
	 RU3QF0W2NTzw/WrvKWFXOyk5qKW29akZBZglnOH+mrQ3sMQIOwpScYCSggjdGETmBW52x
	 iGSb9WKjGYjSE8o6RscY5CcxjjMrR+sDEkREfV42m8BDsM7P6DRZedhIqdtbITFFKMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371901;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2djxXmFbyue220ouuRMgPys8D9fRziFw4Uik3ZCZbFQ=;
	b=Z4P9mDu51HV1Fldwe/ZRYVFpQn0uC7N2963WJ8G3sapm6eF7nEeLY7i+ly0ST3xeSsax
	 zVJGGSXCmIoMWFrZ2nfcr5/fdKPxXsGi5DRwpz/HAS1K1a2atisIS/Y+x6bCFE+2a7sRX
	 9uOViwUuTNFrJzfvctKCmyTCTc8kGUDNDg69PsJmIxFHUe4Ja6wBRnsbGJxFiiKjMeddB
	 qrcE8mK8QaYKWcEHs1iG/F4eD7bP/loFwDxemLeG4KeQwh1f+naSvZtadXPrzOnkzSRqp
	 9Uc7bBGuapWAKw9ymjpeGgLv1HJSdGbYkIZpEOzpNyzDiUdzQ2SWgbOzlah1ptWjciw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGqrDj7M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD46606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGqrDj7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA21F00A03;
	Wed, 11 Nov 2026 04:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371901;
	bh=2djxXmFbyue220ouuRMgPys8D9fRziFw4Uik3ZCZbFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DGqrDj7M+zss82ltwEh4VQGK5f9cqVRIywULuO+Lm5Sv3Am/DkVR9hOXdu8u6uGQL
	 NsphF9lkz55+d+teNDDLUCQojGsZXG3JQHhDE/4xf4y6iQ9JZc3Am6vjW4bzkHxv6e
	 K3q/2GC+VM1x/4fCtXONoKA17wdkFpAVSPJKKSvkbZqL3OA7Uy5TKfFYOSNQieHKEe
	 nC6R5+V9hn98fRcWoRLNwW/fRMuD6UtcllyFh7NaSMEgD1FeONg+nAg72qw5kdOg4e
	 9VecrUqCm7mayIgxHOKbjG+HwDOrLw8JjbLFhqVp9/5FmOTCkZo5BF5ubn8crX/8dg
	 x4gFtqXI4NuCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 10 Nov 2026 23:38:19 -0500
Message-ID: <20261111043626.1123671-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111043626.1123671-1-sashal@kernel.org>
References: <20261107052707-failed-6.12-08a44bde821d@kernel.org>
 <20261111043626.1123671-1-sashal@kernel.org>
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
index 26c2cc1d6a18c..fc5067edd5302 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -635,6 +635,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
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
@@ -652,6 +659,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
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

