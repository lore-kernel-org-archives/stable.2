Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3741378D;
	Mon, 14 Sep 2026 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382792; cv=none; b=tO5NRlOMwOCoUXmMlnGRknEtSyuhvnYKO8qNB6wUYPCTZdiVsVY/jfCXlE6yg8/4qkbL+Lq4NdsaIZxpcwPEt4kcxXK7QY3IYwxuRRvFl+I+EVCSFjdIb4Da7tnL1ZFhvcBtS/M2cYlRGPilNousLACCtb3tJhP1Bq0CPHlY7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382792; c=relaxed/simple;
	bh=PZuSGw/Ymu7WjLMEku7ELyyKyZJ7PytmyFoNcs5hVcw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PmxcIZ6LjjMVRmZ4VN8qejfSxBE+PwdBnb78LayiBRAAbfCeXOGa7s4+1FNuKYC2ogkhhT/kE9l3xoi2CgFHbuP1pJaT13J+NX5gxGNiEr49O2ZrkDypsJoUmPUzSNGULkEx33N5ohUaUtPbbOwa0j96SpFNsJEGxUhiRYhu8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 82c9ceb8b02911f19a56ed5b684f684d-20260914
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a4b47acc-e02b-400a-ab9c-ea5094c1ec1c,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.19,REQID:a4b47acc-e02b-400a-ab9c-ea5094c1ec1c,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:7db8b62,CLOUDID:f008fbf9ccd15f380d4ae6ca61bfb65b,BulkI
	D:260914184619FTH1BCPW,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
	C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 82c9ceb8b02911f19a56ed5b684f684d-20260914
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 116968193; Mon, 14 Sep 2026 18:46:15 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: derek.fang@realtek.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type
Date: Mon, 14 Sep 2026 18:45:51 +0800
Message-Id: <20260914104551.377880-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stream_config is not initialized before being passed to
sdw_stream_add_slave().  The type field may contain garbage and is
later copied to stream->type by sdw_config_stream().

Zero-initialize stream_config so type defaults to SDW_STREAM_PCM.

While at it, use snd_sdw_params_to_config() helper instead of
open-coding the same logic.

Fixes: 2b7aecd58528 ("ASoC: rt1017: Add RT1017 SDCA amplifier driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 sound/soc/codecs/rt1017-sdca-sdw.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt1017-sdca-sdw.c b/sound/soc/codecs/rt1017-sdca-sdw.c
index caf75e5657ef..01cc2511a7d0 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.c
+++ b/sound/soc/codecs/rt1017-sdca-sdw.c
@@ -15,6 +15,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/sdw.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>

@@ -573,11 +574,10 @@ static int rt1017_sdca_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct rt1017_sdca_priv *rt1017 = snd_soc_component_get_drvdata(component);
-	struct sdw_stream_config stream_config;
+	struct sdw_stream_config stream_config = {0};
 	struct sdw_port_config port_config;
-	enum sdw_data_direction direction;
 	struct sdw_stream_runtime *sdw_stream;
-	int retval, port, num_channels, ch_mask;
+	int retval, port;
 	unsigned int sampling_rate;

 	dev_dbg(dai->dev, "%s %s", __func__, dai->name);
@@ -591,28 +591,17 @@ static int rt1017_sdca_pcm_hw_params(struct snd_pcm_substream *substream,

 	/* SoundWire specific configuration */
 	/* port 1 for playback */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		direction = SDW_DATA_DIR_RX;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		port = 1;
-	} else {
-		direction = SDW_DATA_DIR_TX;
+	else
 		port = 2;
-	}
-
-	num_channels = params_channels(params);
-	ch_mask = (1 << num_channels) - 1;
-
-	stream_config.frame_rate = params_rate(params);
-	stream_config.ch_count = num_channels;
-	stream_config.bps = snd_pcm_format_width(params_format(params));
-	stream_config.direction = direction;

-	port_config.ch_mask = ch_mask;
+	snd_sdw_params_to_config(substream, params, &stream_config, &port_config);
 	port_config.num = port;

 	dev_dbg(dai->dev, "frame_rate %d, ch_count %d, bps %d, direction %d, ch_mask %d, port: %d\n",
-		params_rate(params), num_channels, snd_pcm_format_width(params_format(params)),
-		direction, ch_mask, port);
+		stream_config.frame_rate, stream_config.ch_count, stream_config.bps,
+		stream_config.direction, port_config.ch_mask, port);

 	retval = sdw_stream_add_slave(rt1017->sdw_slave, &stream_config,
 				&port_config, 1, sdw_stream);
--
2.25.1

