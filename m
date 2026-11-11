Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371519;
	b=wd0NK+M0oyxdyBLhxAe8VLvOM/7Ed2NVG4vaHeRdRLAGWEqpGsODdY5rMWgJIj2sZyLk
	 Wsm2eByCMiaK2o95IQ/9frvGsW7skc8IY+9j7eUZS/BWiH7gLonCMx7XU9/hMrfDmWUIE
	 ska7JuXZK9iSBXIARbppNMZmhzekIGHBDuU2DSTOSETIiFFLd5owtGmGw7cJrZic2GVW9
	 KGfpRIbEKGhw82JeMROaU2/y66cjKVwjUu950E60HzRI3oeMurufkE62G7HDHMP3XN5MO
	 B9+ff0KckpTEngTnbgLFiRZUtVGP+S/rIztOk+YMMWqR6mRMhnWByuHESK2762K0Kvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=W9Sm0TbTcPgkjxXBjoFHT7TET/WrIHl8HJrxC0ryqpI=;
	b=JSeBpig7CUS2rdCOpyiTFY+QwvoXFsfqSdzCNiT+XFEqUwEN3RvMvNEARxdiasE0k1PF
	 XpJkLvHU9T4J9qjM+LB1mnjFBpHFkll6DxChZrwzL401fPxbRL3aYN5mwnKBfSbvj/oK6
	 54Y5ovg750FQX7QNbwtOhwBMccy+RqLZxOk9GLFZDS31DPLkisiYI9r7d+EntNBU+EPmu
	 2w7kdms38NFVhc3brWcSqzw8JCIPnWnzIkStFp6gVH+ESdP3g+VlTY9nyafwePODtnhiq
	 d7JcF56PfrnEVtaakaTQ35zcHZDx5vVo6htKph6RNlZs0GZUsOx0S0DOw6TUt9IIMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbpAEEaY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E30606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbpAEEaY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791831F0093C;
	Wed, 11 Nov 2026 04:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371519;
	bh=W9Sm0TbTcPgkjxXBjoFHT7TET/WrIHl8HJrxC0ryqpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EbpAEEaY3XAuH11ZtpPb1+F6CaKXPLHsTmA8mlC8g7zFclfkPKhKC7/E+cemAHUkC
	 9hmoSDBNt3IG8iP1Utf5+k6bH7KyUBMN1RT7RaxR/jdxCGiN0Daj8jZAk0cKG7a6/S
	 DcMwQPRjD886DZ6Rv6rNNkxzBLbg7eq+kpgrWmZKmDWKBoLzx6G0BRAapAKwwGisSt
	 RbEk3OGEqkgoUt+H4c/44kWZVJNnBvDzlBPt4gchk488TzsFmPuYpOaamGV59jazq0
	 RIfKmY9PXY+ygFDwu7GxiPck3YYpE+mr/VIeeB09sUBwhFJuY8hoTFy4PASUPEuBSE
	 VCWFlyDd7UJMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ASoC: hdac_hda: Restore the codec device type on unbind
Date: Tue, 10 Nov 2026 23:31:56 -0500
Message-ID: <20261111043037.1105746-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111043037.1105746-1-sashal@kernel.org>
References: <20261107051515-failed-6.18-08a44bde821d@kernel.org>
 <20261111043037.1105746-1-sashal@kernel.org>
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
index e63b616afa79f..ca2d3130cc4c5 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -636,6 +636,13 @@ static const struct snd_soc_component_driver hdac_hda_hdmi_codec = {
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
@@ -653,6 +660,11 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
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

