Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327067;
	b=5ljLOzgIrLFEtnMHCwL7ml/LO09zE946NaiPe6ACShffWg/MnIQR7IjWYqPyL1Ajx3nX
	 9vjvvGs5khnc5Ay1UgE5rRfF9DRn2S8QiloU37y6/0FeIvDL+QCWDKkj2BaS3T85HWr0G
	 VVKbcBZuWH124kPi+cr8f0oD7MB6oNYsTnVZB3CRFKPxPxxxU5Zdr4zUKzcQ1+uwR3Ww5
	 H+dfFx3f+TSxQuRrvjOoRhn7/UbgJ/NffLciQQ7ADi7Zzky5+j9/2TbKoC7SRQ8dP/8zp
	 cCKDf9qHnyT5TSwCMuvGU6iTSLYm7LaEI7CAKqOphd4jLI6nhdwgX7HWWX9JRtB2T2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PiMjIs0UNW1h9ZUVjrgbHLxkCCGQJdXg3AkqLB6RtuY=;
	b=pl1psKfGs2zXWaP4G+71JVkPHBQ/y5iV8+OkYZnF1/3sQvhjadX6rZ+55dzZy585mOXJ
	 uaZk9x1gHey3qCjw2cXUDPhNjWWTcHs0z1I9ckEfdfAx2jLKow9utm+CU+tH+k4pcxPrN
	 rxjmjZScv8EEmrrGZSVk1QB6OQ3b/oG214SCj7T7ihxZ5kOU98CMOBVZG99pPus2hk9rs
	 dq0SuYD4Gj3F5/kGGcYUU0pgaSRpjQinQRyxHCnxB3JtuCWUcStYKkYefftIii0jTeUi3
	 5yMcY62BG0BKpQQcWxtuC23iAzu0x+SjFvOduyUppaT02FRxNbiU/Sd0YOLxFWU7/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebkjCyAR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233B606D798
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ebkjCyAR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DA1F008A3;
	Tue, 10 Nov 2026 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327067;
	bh=PiMjIs0UNW1h9ZUVjrgbHLxkCCGQJdXg3AkqLB6RtuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ebkjCyARs+O/BPYsl3nY6hr8pWneZGa5cHG8uGwmbMATFiUUJRUyAHd1vMlSGEfwn
	 LWACl+oM5qqxavdvZaduzc6hH7czcFh7EOQZf/Pgjj6UvYXfLiTXWQq9QwsozzsAHQ
	 l/9Q0iXf8kEIdhnRZnZRst0/h9B5GQsBpjGAICHzOLbPHX+BJ06Hjdqf0Kee+uKthn
	 4Eu4MC5kJFAC2j+Z/PSdB+qEhcyViglPNQna6UKJFE9y21YXclH/3ADMvEBW9FTpA4
	 9ixAG6OJkBo9Cfs3F8CtAaPiDPlKya0UJfKyHPeRECqUO5yBokP8xCJw2/BcQnodDQ
	 25gKtFiSgVeEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make_ruc2021@163.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: hda: cs35l41: Fix ACPI device reference leak on probe failure
Date: Tue, 10 Nov 2026 11:11:04 -0500
Message-ID: <20261110161057.2400674-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161057.2400674-1-sashal@kernel.org>
References: <20261107051020-failed-6.18-8d70e364e866@kernel.org>
 <20261110161057.2400674-1-sashal@kernel.org>
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

From: Ma Ke <make_ruc2021@163.com>

[ Upstream commit 8d70e364e866bdfca81eee24d0688fac9472cfb9 ]

cs35l41_hda_probe() takes an acpi_device through
cs35l41_hda_read_acpi() and stores it in cs35l41->dacpi. Only the
failures that happen later reach the err: label, which is where that
reference and cs35l41->acpi_subsystem_id are released, so the early
return taken when cs35l41_hda_read_acpi() fails leaves both behind.

Keep the ownership in the caller instead of dropping the reference
inside cs35l41_hda_read_acpi(). That removes the need to work out
whether a given failure path has already released it, and with it the
double put that cs35l41_hda_parse_acpi() would otherwise cause when it
fails after having released the device itself.

cs35l41_hda_parse_acpi() and the !physdev path no longer put the
reference, and the early failure enters the existing err: cleanup tail
through a new err_acpi label.

The label sits between the reset of the codec and the gpio cleanup, so
an early failure also releases the reset and chip-select descriptors
that cs35l41_hda_parse_acpi() may already have taken, while still
skipping cs35l41_safe_reset() on a codec that was never brought up.

cs35l41->dacpi comes from devm_kzalloc() and is only assigned once the
ACPI device has been found, so the put is a no-op when the lookup
itself failed.

Found by code review.

Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
Link: https://patch.msgid.link/20261012084152.3740340-1-make_ruc2021@163.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/side-codecs/cs35l41_hda.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/cs35l41_hda.c b/sound/hda/codecs/side-codecs/cs35l41_hda.c
index a7fc4ba35e3a1..d9f687967be51 100644
--- a/sound/hda/codecs/side-codecs/cs35l41_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l41_hda.c
@@ -1921,7 +1921,6 @@ int cs35l41_hda_parse_acpi(struct cs35l41_hda *cs35l41, struct device *physdev,
 	hw_cfg->valid = false;
 	hw_cfg->gpio1.valid = false;
 	hw_cfg->gpio2.valid = false;
-	acpi_dev_put(cs35l41->dacpi);
 
 	return ret;
 }
@@ -1942,10 +1941,8 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->dacpi = adev;
 	struct device *physdev __free(put_device) =
 		get_device(acpi_get_first_physical_node(adev));
-	if (!physdev) {
-		acpi_dev_put(adev);
+	if (!physdev)
 		return -ENODEV;
-	}
 
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub))
@@ -2000,8 +1997,10 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	dev_set_drvdata(dev, cs35l41);
 
 	ret = cs35l41_hda_read_acpi(cs35l41, device_name, id);
-	if (ret)
-		return dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+	if (ret) {
+		dev_err_probe(cs35l41->dev, ret, "Platform not supported\n");
+		goto err_acpi;
+	}
 
 	if (IS_ERR(cs35l41->reset_gpio)) {
 		ret = PTR_ERR(cs35l41->reset_gpio);
@@ -2088,6 +2087,7 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 err:
 	if (cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type))
 		gpiod_set_value_cansleep(cs35l41->reset_gpio, 0);
+err_acpi:
 	gpiod_put(cs35l41->reset_gpio);
 	gpiod_put(cs35l41->cs_gpio);
 	acpi_dev_put(cs35l41->dacpi);
-- 
2.53.0

