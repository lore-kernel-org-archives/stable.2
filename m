Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425938;
	b=rQ4Hu1iMMzYR/oRJiHAKiI6ndBbs9IqrrNETROsHhI9ftvL/czjKMSlkbciPY4g3i8Kx
	 7zrOo+jkF2g+dofX6kRRcnv9EIsIgUv91FLtx+DttBWnoevLhHFFV6HD8MmuuuZPYZDF6
	 sW5XdeAv1INfWsrUYyVtvNCtq1Wq9fQru0zi9Z3x6GzQlK1djctl5tS9gehkJFa3gBua0
	 9QmSsC5nh2G39ATjmB0CbKIBL6QMICU6UmdENLj/odzKeohqvo2ujztp4sDv+e/IhmrLr
	 YMAV0nknc0Wmk0GNQYK9vooWkkgsrA8HjAsyP/nW2qrAtD5x90A6dJHX7M4z0nCtTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4JqkBVlqlT6zql2Ej4ZT/ypP9S8JNfWS9Hj6hqOmf0Q=;
	b=t/2wFA3niS59TTj8oKjwGop3k11MzhmaR2c+5mW83ebXILO17Cm3AZAFaTsE44wsz7qM
	 Q8fM+5bh5h3YU0JmpOSRGEVYXwuizUEquXrkfLGEk2DBMa3j7JJakkZvrim+59p156e/4
	 6Vl4Ic99VSbIqqjolFxQUOKvDhn9ZJrYvuYLsrXzTyeqCAqe4l1l96alK4oRoiVmf6aet
	 1tzYEVEnezIWXUsjkGMqOPhhNsF1Obzhp8Q+Ns3YWB5/jzgtpMxDEzIuSlCUwmm7DX6bp
	 WicP3B0EXgc1Z3fb9m3bCh35LOi8EdUuGYn0BS0MWDxlSb4xYOpKQ4QDixM6faj94lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOkFmr0a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A9606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOkFmr0a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47D11F00A05;
	Wed, 11 Nov 2026 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425938;
	bh=4JqkBVlqlT6zql2Ej4ZT/ypP9S8JNfWS9Hj6hqOmf0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XOkFmr0aFLAXY0Qx6rTn6o3l61pn3dB9n53KZcTcBpJgnrD+nnWrmE/RDtmxWpB4o
	 l933m+C5J4hvg57UlipvqMW8jrPU0Vu/4Gt1l5v36PUuZpkc8+NhkUGgJcuxllpmTG
	 UH4Z8Odgh/OGJfrXoqcVqR59CaIrVTFVHhVtqxSjskukhl1yYg36XPYUlRpib+MxAJ
	 VZG0Qb5vFg/e5pTeccp03eP0metuWNOhTPa4rC1iyNghwN3yIrHw3haQw80qaYQwZ/
	 dF3gGC3OqxNO9cMqdfOPOmc+VOmn3FRlR7dAfE7TJvww815l1OePfmUMuQBjbUAYMD
	 ynatUAJm5QHQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vinod Koul <vkoul@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ASoC/soundwire: Intel: reset the PCMSyCM registers in hda_sdw_bpt_close
Date: Wed, 11 Nov 2026 14:38:55 -0500
Message-ID: <20261111193828.3993519-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200245-failed-6.18-348bc756d912@kernel.org>
References: <20261109200245-failed-6.18-348bc756d912@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 992eb0dfbc4f594d60ae57974efa835bfac34d1e ]

Resetting the PCMSyCM registers is required for Intel SoundWire stream. The
same procedure is done in sdw_hda_dai_hw_params() for the normal
SoundWire stream, too.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Acked-by: Vinod Koul <vkoul@kernel.org>
Link: https://patch.msgid.link/20260730012518.2180906-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 348bc756d912 ("ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel_ace2x.c   |  4 +++-
 include/sound/hda-sdw-bpt.h       |  5 +++--
 sound/soc/sof/intel/hda-sdw-bpt.c | 31 ++++++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index f0e0a79b30b0e..c1ea420bc11ff 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -192,6 +192,7 @@ static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *
 		__func__, str_read_write(command), ret);
 
 	ret1 = hda_sdw_bpt_close(cdns->dev->parent, /* PCI device */
+				 sdw->instance,
 				 sdw->bpt_ctx.bpt_tx_stream, &sdw->bpt_ctx.dmab_tx_bdl,
 				 sdw->bpt_ctx.bpt_rx_stream, &sdw->bpt_ctx.dmab_rx_bdl);
 	if (ret1 < 0)
@@ -226,7 +227,8 @@ static void intel_ace2x_bpt_close_stream(struct sdw_intel *sdw, struct sdw_slave
 	struct sdw_cdns *cdns = &sdw->cdns;
 	int ret;
 
-	ret = hda_sdw_bpt_close(cdns->dev->parent /* PCI device */, sdw->bpt_ctx.bpt_tx_stream,
+	ret = hda_sdw_bpt_close(cdns->dev->parent /* PCI device */, sdw->instance,
+				sdw->bpt_ctx.bpt_tx_stream,
 				&sdw->bpt_ctx.dmab_tx_bdl, sdw->bpt_ctx.bpt_rx_stream,
 				&sdw->bpt_ctx.dmab_rx_bdl);
 	if (ret < 0)
diff --git a/include/sound/hda-sdw-bpt.h b/include/sound/hda-sdw-bpt.h
index f649549b75d52..330cda50f100c 100644
--- a/include/sound/hda-sdw-bpt.h
+++ b/include/sound/hda-sdw-bpt.h
@@ -27,7 +27,7 @@ int hda_sdw_bpt_send_async(struct device *dev, struct hdac_ext_stream *bpt_tx_st
 int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
 		     struct hdac_ext_stream *bpt_rx_stream);
 
-int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *bpt_tx_stream,
 		      struct snd_dma_buffer *dmab_tx_bdl, struct hdac_ext_stream *bpt_rx_stream,
 		      struct snd_dma_buffer *dmab_rx_bdl);
 #else
@@ -56,7 +56,8 @@ static inline int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *b
 	return -EOPNOTSUPP;
 }
 
-static inline int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+static inline int hda_sdw_bpt_close(struct device *dev, int link_id,
+				    struct hdac_ext_stream *bpt_tx_stream,
 				    struct snd_dma_buffer *dmab_tx_bdl,
 				    struct hdac_ext_stream *bpt_rx_stream,
 				    struct snd_dma_buffer *dmab_rx_bdl)
diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
index ff5abccf0d88b..4e5c99413c750 100644
--- a/sound/soc/sof/intel/hda-sdw-bpt.c
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -297,7 +297,8 @@ int hda_sdw_bpt_open(struct device *dev, int link_id, struct hdac_ext_stream **b
 		__func__, ret);
 
 close:
-	ret1 = hda_sdw_bpt_close(dev, *bpt_tx_stream, dmab_tx_bdl, *bpt_rx_stream, dmab_rx_bdl);
+	ret1 = hda_sdw_bpt_close(dev, link_id, *bpt_tx_stream, dmab_tx_bdl,
+				 *bpt_rx_stream, dmab_rx_bdl);
 	if (ret1 < 0)
 		dev_err(dev, "%s: hda_sdw_bpt_close failed: %d\n",
 			__func__, ret1);
@@ -422,14 +423,38 @@ int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
 }
 EXPORT_SYMBOL_NS(hda_sdw_bpt_wait, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
 
-int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *bpt_tx_stream,
 		      struct snd_dma_buffer *dmab_tx_bdl, struct hdac_ext_stream *bpt_rx_stream,
 		      struct snd_dma_buffer *dmab_rx_bdl)
 {
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
 	int ret;
 	int ret1;
 
-	ret = hda_sdw_bpt_dma_deprepare(dev, bpt_rx_stream, dmab_rx_bdl);
+	/*
+	 * In the case of SoundWire we need to reset the PCMSyCM registers.
+	 * Need to continue depreparing the DMA buffers even if this fails.
+	 */
+	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id,
+					     0, /* PDI0 */
+					     0, 0, SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret < 0)
+		dev_err(dev, "%s: hdac_bus_eml_sdw_map_stream_ch failed %d for PDI0\n",
+			__func__, ret);
+
+	ret1 = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id,
+					      1, /* PDI1 */
+					      0, 0, SNDRV_PCM_STREAM_CAPTURE);
+	if (ret1 < 0) {
+		dev_err(dev, "%s: hdac_bus_eml_sdw_map_stream_ch failed %d for PDI1\n",
+			__func__, ret1);
+		if (!ret)
+			ret = ret1;
+	}
+
+	ret1 = hda_sdw_bpt_dma_deprepare(dev, bpt_rx_stream, dmab_rx_bdl);
+	if (!ret)
+		ret = ret1;
 
 	ret1 = hda_sdw_bpt_dma_deprepare(dev, bpt_tx_stream, dmab_tx_bdl);
 	if (!ret)
-- 
2.53.0

