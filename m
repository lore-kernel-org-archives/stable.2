Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F343DEC8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123806; cv=none; b=JOQgCN/Xjkdyzd+9nn82+N0QYbU5G22xpPzJ9nZuVlG5UAR9ZO3ZAvztqjHVwi/kQMp0aSGqYEEhs9pmQaLtkC8FVWpZPUnUsSCQJTid2SjnQDl3TcpdLa80fEyYrgK3eZDgeXt0+ssmzbE7RHNMlPbNOfqm2vQeLSdGdLvdF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123806; c=relaxed/simple;
	bh=jCEMLC9B99j4yBsbbwZ85OQXdNKNd8Z6Vqer6fBDcNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfvsCrRMboVTKgxkfGCqX8mH9s3yUn5UUt1ZbyQPyVnVMvtxA+e8VbxEjUtySIcXS3//kO4zcrhPwCS74jN+T3SyZOjFXRuukZEribzxkRa75y6rATkyn2yXjEYxoXbEWnV90ow52xyBe3v2pX5orV1iRauraNmJCx/70hzg/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7/eI2pS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7/eI2pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F93C1F000FF;
	Fri, 11 Sep 2026 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123804;
	bh=VPAXBPpgTYl4B7EEkp9wyp1bgqK7tZUQhs+HwDdRFjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7/eI2pSKaa5AYu8k/W9HhPg6q8hTrv8UhQgefHbVv1dsfLDGDPjnmFEziTbNlm3e
	 iuApqnnjGXkpPcFXsAt7pVKGRAnEpixRpNbFpxmfYdxDXW1qLJmMJlTPubj8YUHcKj
	 qutdiYoC8ZXMsuM6AUvzp6Evg4gNDl0LwLuf5HgdFBMd9lyQvz4Tljyhz/uHSuW9LK
	 Wn11JNQGWv7/kJaisHxMma2mNlFr/3R6VmVgGbvZoN522U+yNHQklEM4rCrkLq+Onn
	 JwYfUrniTOV1ztSUJNB2afJJy5ZgDAFvlpBmvePgG78lL/e7bn2yEhsX1FYC03GeGz
	 gm2yY5PO92Aiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/5] ALSA: hda: Update and expose snd_hda_codec_device_init()
Date: Fri, 11 Sep 2026 06:49:58 -0400
Message-ID: <20260911105003.268248-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-payphone-halved-2f01@gregkh>
References: <2026090904-payphone-halved-2f01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 595511a3ab80d9ec6649bbf22a99bee169026fd1 ]

With few changes, snd_hda_codec_device_init() can be re-used by ASoC
drivers. While at it, provide kernel doc for the exposed function.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://lore.kernel.org/r/20220214101404.4074026-3-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/hda_codec.h |  3 +++
 sound/pci/hda/hda_codec.c | 45 +++++++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index cf530e9fb5f5c..26db94d573f75 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -305,6 +305,9 @@ struct hda_codec {
 /*
  * constructors
  */
+__printf(3, 4) struct hda_codec *
+snd_hda_codec_device_init(struct hda_bus *bus, unsigned int codec_addr,
+			  const char *fmt, ...);
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp);
 int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index fc4a64a83ff2f..88480a41c6206 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -868,36 +868,48 @@ static void snd_hda_codec_dev_release(struct device *dev)
 
 #define DEV_NAME_LEN 31
 
-static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
-			unsigned int codec_addr, struct hda_codec **codecp)
+/**
+ * snd_hda_codec_device_init - allocate HDA codec device
+ * @bus: codec's parent bus
+ * @codec_addr: the codec address on the parent bus
+ * @fmt: format string for the device's name
+ *
+ * Returns newly allocated codec device or ERR_PTR() on failure.
+ */
+struct hda_codec *
+snd_hda_codec_device_init(struct hda_bus *bus, unsigned int codec_addr,
+			  const char *fmt, ...)
 {
+	va_list vargs;
 	char name[DEV_NAME_LEN];
 	struct hda_codec *codec;
 	int err;
 
-	dev_dbg(card->dev, "%s: entry\n", __func__);
-
 	if (snd_BUG_ON(!bus))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	if (snd_BUG_ON(codec_addr > HDA_MAX_CODEC_ADDRESS))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	codec = kzalloc(sizeof(*codec), GFP_KERNEL);
 	if (!codec)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	va_start(vargs, fmt);
+	vsprintf(name, fmt, vargs);
+	va_end(vargs);
 
-	sprintf(name, "hdaudioC%dD%d", card->number, codec_addr);
 	err = snd_hdac_device_init(&codec->core, &bus->core, name, codec_addr);
 	if (err < 0) {
 		kfree(codec);
-		return err;
+		return ERR_PTR(err);
 	}
 
+	codec->bus = bus;
 	codec->core.type = HDA_DEV_LEGACY;
-	*codecp = codec;
 
-	return err;
+	return codec;
 }
+EXPORT_SYMBOL_GPL(snd_hda_codec_device_init);
 
 /**
  * snd_hda_codec_new - create a HDA codec
@@ -911,11 +923,13 @@ static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
 int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 		      unsigned int codec_addr, struct hda_codec **codecp)
 {
-	int ret;
+	struct hda_codec *codec;
 
-	ret = snd_hda_codec_device_init(bus, card, codec_addr, codecp);
-	if (ret < 0)
-		return ret;
+	codec = snd_hda_codec_device_init(bus, codec_addr, "hdaudioC%dD%d",
+					  card->number, codec_addr);
+	if (IS_ERR(codec))
+		return PTR_ERR(codec);
+	*codecp = codec;
 
 	return snd_hda_codec_device_new(bus, card, codec_addr, *codecp);
 }
@@ -942,7 +956,6 @@ int snd_hda_codec_device_new(struct hda_bus *bus, struct snd_card *card,
 	codec->core.dev.release = snd_hda_codec_dev_release;
 	codec->core.exec_verb = codec_exec_verb;
 
-	codec->bus = bus;
 	codec->card = card;
 	codec->addr = codec_addr;
 	mutex_init(&codec->spdif_mutex);
-- 
2.53.0

