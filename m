Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425939;
	b=QlC4BvIK7Vexr7WIJXCVliJZoGjVo+UL6N4GrLo8OJ/SjtN+ixmjvMIg8/dr0pEALQqw
	 eJAqeWHNHSrdLMuBf1o/kKMcTrtZnDVJ1RWEhnvQELdhv5khUY7aRYxVuhEn/IxMzbLcr
	 CR809Z1Mr7uTiBS4nm3Hk4jGG/AVgdH2KRHqzgeB0jC92IZgd3Zy2x6TWsbIiytBqbR/k
	 VA+FHvVWDV5auuQ05KyKtiPx/YBNKVU8cRTmjhuDMfts3FkbCh8yUSSHcsv0QHNBtEYg7
	 9ppG/pPNvbWym4RonUDHYk/7J3k/AOhPihhkbHRL9f6VlZfXtXFaAb1UFx2C3/nJkHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bM6xeXSR2S+XbY4Jlxj7S38yq++nh3unbmSJtyg5QMo=;
	b=GzIApA7LnvnjLWtKjCd/iBTgxxsOGRITPZ5MPZ2NrV20fx4NldFxEZLefft/NTXEdvaV
	 ZkzEmIqdveIMZJ73gKXbQzxx47qf1SeKxTYJcXWgbO3Q3UZIAylrwOveS6VWca59r5lAv
	 HLIWo3FHjUGnn0OEFNPRhKN4FpzQAk+GueHQko5JwVnG255uJXbr5HHgyxfjfGwkWjr34
	 38S+Xh8bvO6IPlPDJrewjm9sTpcneV6/RzY6bL15i+5PFn7CKqrdHMwklpDDuzDPAhciP
	 y4pe2ocS+Lkf5535d6f2uGowYN9ccu5LEVhI1v1cCjynohTs97k1t/o7XdTz8XRO1KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxICsCF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB45606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxICsCF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82A71F00A09;
	Wed, 11 Nov 2026 19:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794425939;
	bh=bM6xeXSR2S+XbY4Jlxj7S38yq++nh3unbmSJtyg5QMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FxICsCF9hXv/zAZk1d/kM/2LyFM6ke6o4Ken/UwiFQTt6A3kOGbOjFvhJUEkluhT7
	 QtetjaA989n69BFgnZbrUgu4hQTqcOfuVMLENmFX8U7dqv5JhgiAGcu8IQMdnyfH4U
	 uf8d9W6W4CnZZLj2qvTG+Ialv2yxSFPplVJB981WDmJ6Y5bH1+L3bQVwQT8Dxb8lLU
	 16Pq0Vrqg6NF6cUzKrO/Le64cYV1D3QaRRpb2lkckVQc4fHrxrWZSpMIF05uD27QqF
	 umnV23SKrTHWahc8E0mWlhJ/AdYOvMjhgiJUlAGGeW71vwBgHHCCtrZWPrwH9QFQr9
	 C1UAGMyy5yGHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams
Date: Wed, 11 Nov 2026 14:38:56 -0500
Message-ID: <20261111193828.3993519-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111193828.3993519-1-sashal@kernel.org>
References: <20261109200245-failed-6.18-348bc756d912@kernel.org>
 <20261111193828.3993519-1-sashal@kernel.org>
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

From: Lee Jones <lee@kernel.org>

[ Upstream commit 348bc756d912dd8f47fd36c167075717951a515e ]

When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
without calling hda_sdw_bpt_wait().  As a result,
hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
the DMA hardware is still running.

Disable any running TX or RX BPT DMA stream at the start of
hda_sdw_bpt_close() before unmapping channels and depreparing DMA
resources.

Fixes: 4c1ce9f37d8a ("soundwire: intel_ace2x: add BPT send_async/wait callbacks")
Closes: https://sashiko.dev/#/bug/linux-ff0012de-abdd-4796-875e-b1fbbf47235f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261030104840.3361217-6-lee@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-sdw-bpt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
index 4e5c99413c750..5eaa2e0563c16 100644
--- a/sound/soc/sof/intel/hda-sdw-bpt.c
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -431,6 +431,12 @@ int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *b
 	int ret;
 	int ret1;
 
+	if (bpt_rx_stream && hdac_stream(bpt_rx_stream)->running)
+		hda_sdw_bpt_dma_disable(dev, bpt_rx_stream);
+
+	if (bpt_tx_stream && hdac_stream(bpt_tx_stream)->running)
+		hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
+
 	/*
 	 * In the case of SoundWire we need to reset the PCMSyCM registers.
 	 * Need to continue depreparing the DMA buffers even if this fails.
-- 
2.53.0

