Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B5D245012
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091032; cv=none; b=t/OLQsDZjoacGJZaLrRao51mjAd9ijk80/CnAK3HqrhTqVqTLdQ/lzNcgROJpgXwdyU0bgGFo4mRhbcu4I2YeN+jClxo/A583j822T0k/OWchxr7HstaqmfN/MoIW3GXvUZX0OSe26ZEsHjXTy88NlgPQ+s6IeCQsPJgqAv7HnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091032; c=relaxed/simple;
	bh=pn37Y98xOIr6R/h+V9od70aqSemqtoWIS6kNKpWY800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jixbjmtyNL6AH3HcBygGZBqvMn/UI3PnOedxEN0nN9xOKndpB9V9B+ocfdDzUNluz7UUNtrRVvMVtJQGHLJKlLveHGdJ/1nlevw1rjt9Iqp/AbkC67Kh3tkNeWofGgIYCHaiimA1LpKf01hIEQyCnCU1R268uxbfrmIv//6xkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6Ixr4K9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Ixr4K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C959E1F000FF;
	Fri, 11 Sep 2026 01:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091030;
	bh=PbpykEPkv8dB81+Lx7oKWEdYiLSfg0G8CODkHKDLb3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6Ixr4K9wqYwLN5kvm0cYIVrxGAKqvQTvL1P5SmS90igbK2w2DM4z2JrB9em6mLq6
	 XiK38S7IyN40MzcgGSc5Cbt/d7/hv+5w8KffowKxzVmiLNIk+m0KIkMzmXWhzAjspP
	 7Ph/uMkO/cuX61bgxDnObMGd32rGPzBSnVOhfRwEOUsskVJB0K92ApzFceb0uBiVow
	 2OYE+aIFc+6mDWnILhG+yWGX3dO+ofl6JI06U8wwbh3l/5rvTREESgBS+CDq5HDbz4
	 Zc29mxYMPnfoD/e3WLRp+shlKQDtgkrkHhHfGHTJJFkFR5ylgE1vlmJFbq7jVUrAjP
	 /HryQOZ14jRtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: hdac_hda: improve error logs
Date: Thu, 10 Sep 2026 21:43:47 -0400
Message-ID: <20260911014348.4149148-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090904-opposite-unpadded-c0c6@gregkh>
References: <2026090904-opposite-unpadded-c0c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit ea5fee227ff3dae209062ac9544906debe1e9ac1 ]

We have a couple of duplicate logs and missing information, add
__func__ consistently and make sure useful error codes are logged.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240325221925.206507-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

[Backport to 6.6: omit the firmware-patch-loader logging hunk, since
this tree lacks the ASoC HDA patch loader introduced by 842a62a75e709.
Keep the logging changes in existing functions, including the component
registration error context required by 6ad4892c4f5cb437a928a02f5b7d37d496aa9268.
Retain the stable stream-format API and do not add patch-loader support.]

Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 42 ++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 21a00c86a1398..8ed645a3f2a9b 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -224,7 +224,8 @@ static int hdac_hda_dai_hw_params(struct snd_pcm_substream *substream,
 						 0);
 	if (!format_val) {
 		dev_err(dai->dev,
-			"invalid format_val, rate=%d, ch=%d, format=%d, maxbps=%d\n",
+			"%s: invalid format_val, rate=%d, ch=%d, format=%d, maxbps=%d\n",
+			__func__,
 			params_rate(params), params_channels(params),
 			params_format(params), maxbps);
 
@@ -260,14 +261,12 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct hda_pcm_stream *hda_stream;
 	struct hdac_hda_priv *hda_pvt;
-	struct hdac_device *hdev;
 	unsigned int format_val;
 	struct hda_pcm *pcm;
 	unsigned int stream;
 	int ret = 0;
 
 	hda_pvt = snd_soc_component_get_drvdata(component);
-	hdev = &hda_pvt->codec->core;
 	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
 	if (!pcm)
 		return -EINVAL;
@@ -280,7 +279,7 @@ static int hdac_hda_dai_prepare(struct snd_pcm_substream *substream,
 	ret = snd_hda_codec_prepare(hda_pvt->codec, hda_stream,
 				    stream, format_val, substream);
 	if (ret < 0)
-		dev_err(&hdev->dev, "codec prepare failed %d\n", ret);
+		dev_err(dai->dev, "%s: failed %d\n", __func__, ret);
 
 	return ret;
 }
@@ -292,6 +291,7 @@ static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
 	struct hdac_hda_priv *hda_pvt;
 	struct hda_pcm_stream *hda_stream;
 	struct hda_pcm *pcm;
+	int ret;
 
 	hda_pvt = snd_soc_component_get_drvdata(component);
 	pcm = snd_soc_find_pcm_from_dai(hda_pvt, dai);
@@ -302,7 +302,11 @@ static int hdac_hda_dai_open(struct snd_pcm_substream *substream,
 
 	hda_stream = &pcm->stream[substream->stream];
 
-	return hda_stream->ops.open(hda_stream, hda_pvt->codec, substream);
+	ret = hda_stream->ops.open(hda_stream, hda_pvt->codec, substream);
+	if (ret < 0)
+		dev_err(dai->dev, "%s: failed %d\n", __func__, ret);
+
+	return ret;
 }
 
 static void hdac_hda_dai_close(struct snd_pcm_substream *substream,
@@ -361,7 +365,7 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 		pcm_name = "HDMI 3";
 		break;
 	default:
-		dev_err(&hcodec->core.dev, "invalid dai id %d\n", dai->id);
+		dev_err(dai->dev, "%s: invalid dai id %d\n", __func__, dai->id);
 		return NULL;
 	}
 
@@ -375,7 +379,7 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 		}
 	}
 
-	dev_err(&hcodec->core.dev, "didn't find PCM for DAI %s\n", dai->name);
+	dev_err(dai->dev, "%s: didn't find PCM for DAI %s\n", __func__, dai->name);
 	return NULL;
 }
 
@@ -405,7 +409,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-		dev_err(&hdev->dev, "hdac link not found\n");
+		dev_err(&hdev->dev, "%s: hdac link not found\n", __func__);
 		return -EIO;
 	}
 
@@ -423,7 +427,7 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	ret = snd_hda_codec_device_new(hcodec->bus, component->card->snd_card,
 				       hdev->addr, hcodec, true);
 	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to create hda codec %d\n", ret);
+		dev_err(&hdev->dev, "%s: failed to create hda codec %d\n", __func__, ret);
 		goto error_no_pm;
 	}
 	/*
@@ -443,13 +447,13 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 
 	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
 	if (ret < 0) {
-		dev_err(&hdev->dev, "name failed %s\n", hcodec->preset->name);
+		dev_err(&hdev->dev, "%s: name failed %s\n", __func__, hcodec->preset->name);
 		goto error_pm;
 	}
 
 	ret = snd_hdac_regmap_init(&hcodec->core);
 	if (ret < 0) {
-		dev_err(&hdev->dev, "regmap init failed\n");
+		dev_err(&hdev->dev, "%s: regmap init failed\n", __func__);
 		goto error_pm;
 	}
 
@@ -457,16 +461,16 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	if (patch) {
 		ret = patch(hcodec);
 		if (ret < 0) {
-			dev_err(&hdev->dev, "patch failed %d\n", ret);
+			dev_err(&hdev->dev, "%s: patch failed %d\n", __func__, ret);
 			goto error_regmap;
 		}
 	} else {
-		dev_dbg(&hdev->dev, "no patch file found\n");
+		dev_dbg(&hdev->dev, "%s: no patch file found\n", __func__);
 	}
 
 	ret = snd_hda_codec_parse_pcms(hcodec);
 	if (ret < 0) {
-		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
+		dev_err(&hdev->dev, "%s: unable to map pcms to dai %d\n", __func__, ret);
 		goto error_patch;
 	}
 
@@ -474,8 +478,8 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 	if (!is_hdmi_codec(hcodec)) {
 		ret = snd_hda_codec_build_controls(hcodec);
 		if (ret < 0) {
-			dev_err(&hdev->dev, "unable to create controls %d\n",
-				ret);
+			dev_err(&hdev->dev, "%s: unable to create controls %d\n",
+				__func__, ret);
 			goto error_patch;
 		}
 	}
@@ -521,7 +525,7 @@ static void hdac_hda_codec_remove(struct snd_soc_component *component)
 
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-		dev_err(&hdev->dev, "hdac link not found\n");
+		dev_err(&hdev->dev, "%s: hdac link not found\n", __func__);
 		return;
 	}
 
@@ -597,7 +601,7 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 	/* hold the ref while we probe */
 	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
 	if (!hlink) {
-		dev_err(&hdev->dev, "hdac link not found\n");
+		dev_err(&hdev->dev, "%s: hdac link not found\n", __func__);
 		return -EIO;
 	}
 	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
@@ -613,7 +617,7 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 						ARRAY_SIZE(hdac_hda_dais));
 
 	if (ret < 0) {
-		dev_err(&hdev->dev, "failed to register HDA codec %d\n", ret);
+		dev_err(&hdev->dev, "%s: failed to register HDA codec %d\n", __func__, ret);
 		return ret;
 	}
 
-- 
2.53.0

