Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFED3B8945
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123808; cv=none; b=Aq6KvY1u3+5YHkf5Er1d5SOQylIt3dlKTesrBIQGhlIA9BKHt2Tjt8BJk7ucJmHq1M+6BQdf/WABt+1ALUISp/UVx/2HNB/8zMV8Q8tZGIB6ai0LiIRwJG9+oXB2WZYz03286UYSVoUJGBYJuSL8Fkja3rcpWeu515uCDze+/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123808; c=relaxed/simple;
	bh=gr4Rz6Bworzn8hA+6xnvvKYvi9ZlXTRbj/oq03CQCao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4UkowQLwr8ycaj0kFtbrjFARJqJbVXLHwBzg+9DejVyeWhvb0wVM/aGGXdS6EGe2UOzxq023uTQJAFBmInilK1x7vF4nsmua5slRZLrToDB4/Xjd5wowE5IaGXRi6CFYLOhuMUuoryC77Ke7qCx/hnQFgRFNOY/dNqFdPqD8po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifZ/6cC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifZ/6cC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE41F00898;
	Fri, 11 Sep 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123806;
	bh=fCxVAEgbmBwpPFf7NGQPyoAZ5RfHWlILZmF/RNCt9Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifZ/6cC1xpIAD5s/bQiTVYnc9EFpFV4Himrp2T3Kf+XgLZjCkfFG/I1hQAArFLtsm
	 B5MS6EPe1mvspz71T3uqyV9hzPvtQnp89blMRWkfDvjaXLwpvt3J8YQUSIqeNGWd2F
	 vIMYB1xyHH5+iq18bmNhHCt5HNo3TIF6KUT5Rxm1FIL9oOwNtLhpd5KvtiEEgs70Vp
	 EkFX1sqC+f787VN1GTXkWtWfHYZ0bNAMUzrb66cHtLqtotEzl1kHvTNI73JUM8qeKj
	 mlS8divt9OIGcFd7r7cuobZs4tVoiDhqBPEf0ZICQ7QDb1X7wQnp2gv9aR3CaTVsfa
	 4BmQuaFUHFnMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] ASoC: SOF: Intel: Introduce HDA codec init and exit routines
Date: Fri, 11 Sep 2026 06:50:00 -0400
Message-ID: <20260911105003.268248-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911105003.268248-1-sashal@kernel.org>
References: <2026090904-payphone-halved-2f01@gregkh>
 <20260911105003.268248-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 829c67319806009abfe3b0b82b3b8b153a2c5e32 ]

Preliminary step in making snd_hda_codec_device_init() the only
constructor for struct hda_codec instances. To do that, existing usage
of hdac_ext equivalents has to be dropped.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20220816111727.3218543-3-cezary.rojewski@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 6ad4892c4f5c ("ASoC: hdac_hda: Fix hlink refcount leak on component registration failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index aed8440ef525a..efb3ffc9fad83 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -109,6 +109,36 @@ EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 #define is_generic_config(x)	0
 #endif
 
+static void hda_codec_device_exit(struct device *dev)
+{
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
+}
+
+static __maybe_unused struct hda_codec *
+hda_codec_device_init(struct hdac_bus *bus, int addr, int type)
+{
+	struct hda_codec *codec;
+	int ret;
+
+	codec = snd_hda_codec_device_init(to_hda_bus(bus), addr, "ehdaudio%dD%d", bus->idx, addr);
+	if (IS_ERR(codec)) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return codec;
+	}
+
+	codec->core.type = type;
+	codec->core.dev.release = hda_codec_device_exit;
+
+	ret = snd_hdac_device_register(&codec->core);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_hdac_device_exit(&codec->core);
+		return ERR_PTR(ret);
+	}
+
+	return codec;
+}
+
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 			   bool hda_codec_use_common_hdmi)
-- 
2.53.0

