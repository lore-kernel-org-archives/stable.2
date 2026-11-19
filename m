Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077868;
	b=bHLz7AV+WGGhU4iT4xLpL6y6nOygEdmi8Cbu088qQgSjeLMIwuLfk80JJUv6jGvL/gFw
	 jf4w+57eMQVyVuGcYjFg6VaVA+KEQPksa8TwqoLV3VpPkMkjEYeMqQ0MIZj2sb9uCyhQ+
	 cCkJMRwrsXXJm0Im5MWSmpA+Y/GqEahy88mCokLCMH3acOPgW/TdwGAVBAsVP1FdgTmF0
	 kzeAnXupkq1FxFwWtKdp7GV050FBxMqiAmgtP67nEdbGa3jvxKiLW9oBPo95dXXgIEZ2d
	 w7yKLACH0d+vm8FQR2lQtI47fC6FOheej19cgTVgoPP84zlIhxZQqtxObP3nkmZpuWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077868;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=q4NGyillcyoqnay5MXZUaXZNKCEgxlMjgB2VdLSJAjE=;
	b=3CZeF1oTMh4yip19+KSO15suaIGvdGzLbXEKC0AUV7WOPKVwD/xIMj7KX9yfgdnqRvgF
	 33PMw25/E4OaAYVa9kdhBjKbO++F46/4ZN5ZGequcS/nTznAAz0XBrGhPDIdfD6Rn7Vxp
	 Wp+bm388nxtM/jbVMT9XX7POHdZIL58Hae5KzCsYvwWGir2DnXMJOKbJlUVWfol3MttU4
	 w6nEoJ/Ex0lZBet2nDje1dzmgoAmcYfFPJzKyIm+tgE/Znb78sdf33/fTlHj30eNncZZW
	 HqCLWUeEXPXIP7AuOHmhVxhKQn3aGo1vYjqLKZ9P+m7n4hmH5TsiwGwKtH9ayB9XlTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Bs9eBu14;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3271606A324;
	Thu, 19 Nov 2026 08:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3271606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=Bs9eBu14
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q4NGyillcyoqnay5MXZUaXZNKCEgxlMjgB2VdLSJAjE=;
	b=Bs9eBu14YapuxyW5ZIt4BnZMGw/jUENlfyObiYOW04qus9jxOI75myDiytgeY7dVryy5DzhP2
	ilUjN8GYRYF4M407qOKx6ntBAC3omZzJkiXq55WHKg66LZcJM6QmlO291QaXShOjTqDjf39Gqdr
	LpZcwJxctM94eDLDVQICiqM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jVX7L4fJvz1T4Gf;
	Thu, 19 Nov 2026 16:43:42 +0800 (CST)
Received: from kwepemo200015.china.huawei.com (unknown [7.202.195.27])
	by mail.maildlp.com (Postfix) with ESMTPS id BCFF54056E;
	Thu, 19 Nov 2026 16:44:23 +0800 (CST)
Received: from huawei.com (10.67.174.69) by kwepemo200015.china.huawei.com
 (7.202.195.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 19 Nov
 2026 16:44:22 +0800
From: Chen Yuxi <chenyuxi19@huawei.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>,
	<daniel.baluta@nxp.com>, <kai.vehmanen@linux.intel.com>,
	<pierre-louis.bossart@linux.dev>, <Vijendar.Mukunda@amd.com>,
	<ranjani.sridharan@linux.intel.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<sound-open-firmware@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<yeweihua4@huawei.com>
Subject: [PATCH] ASoC: SOF: Intel: hda: Fix NULL deref in hw_params and hw_free
Date: Thu, 19 Nov 2026 08:25:06 +0000
Message-ID: <20261119082506.2485543-1-chenyuxi19@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo200015.china.huawei.com (7.202.195.27)

When the topology and the machine driver DAI links do not match,
the DAI widget may be missing and hda_dai_get_ops() returns NULL.
However, in hda_dai_hw_params_data() and hda_dai_hw_free(), the sdev
pointer is obtained by dereferencing the DAI widget at declaration
time, before the ops check, so a NULL widget is dereferenced before
the intended error path can run.

Move both sdev assignments after the ops check. Also use dai->dev
instead of sdev->dev for the error message in hda_dai_hw_params_data(),
since sdev cannot be obtained when the DAI widget is missing.

Fixes: de8e2d5d8024 ("ASoC: SOF: Intel: hda-dai: remove use of cpu_dai->component drvdata")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Yuxi <chenyuxi19@huawei.com>
---
 sound/soc/sof/intel/hda-dai.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 7d920d43ef2a..987a4deeee28 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -223,13 +223,15 @@ static int __maybe_unused hda_dai_hw_free(struct snd_pcm_substream *substream,
 {
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, cpu_dai);
 	struct hdac_ext_stream *hext_stream;
-	struct snd_sof_dev *sdev = dai_to_sdev(substream, cpu_dai);
+	struct snd_sof_dev *sdev;
 
 	if (!ops) {
 		dev_err(cpu_dai->dev, "DAI widget ops not set\n");
 		return -EINVAL;
 	}
 
+	sdev = dai_to_sdev(substream, cpu_dai);
+
 	hext_stream = ops->get_hext_stream(sdev, cpu_dai, substream);
 	if (!hext_stream)
 		return 0;
@@ -246,14 +248,16 @@ static int __maybe_unused hda_dai_hw_params_data(struct snd_pcm_substream *subst
 	struct snd_soc_dapm_widget *w = snd_soc_dai_get_widget(dai, substream->stream);
 	const struct hda_dai_widget_dma_ops *ops = hda_dai_get_ops(substream, dai);
 	struct hdac_ext_stream *hext_stream;
-	struct snd_sof_dev *sdev = widget_to_sdev(w);
+	struct snd_sof_dev *sdev;
 	int ret;
 
 	if (!ops) {
-		dev_err(sdev->dev, "DAI widget ops not set\n");
+		dev_err(dai->dev, "DAI widget ops not set\n");
 		return -EINVAL;
 	}
 
+	sdev = widget_to_sdev(w);
+
 	hext_stream = ops->get_hext_stream(sdev, dai, substream);
 	if (hext_stream && hext_stream->link_prepared)
 		return 0;
-- 
2.34.1

