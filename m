Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272567;
	b=AMnBdtdfVBVNoc3Ahxa4tWNdIXh7xUt5xF8gj0XY5tz8Fd3uQVQSlruLtAa5QIT4qCEq
	 77Tehry1srm/n1Y9NvNGWjHG15oL5r3i0kiKMsx7Il0HCOxGbl6tbdbEklt5Y3ULHLznm
	 v4jls+LeQQjUmOjOjTiibI2jmfL6MQwQuG65ag9VCZkFaqishT7NaE5P7pU4zZkIy78kd
	 cA88s3RKUYR6lj90DZEQOPu84VlG4jlZC0Gv4avOB7ANWTI9CkNb//kulr8yweeg9je/F
	 YoP6vNEwN8DJUZ9t3sy3HRb6/SLzx/cE5hnsAd3K5fEhz6C9vbyU01EaOQIiAxEQuGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YOfsErwe8Sv08inJHE0UAD8SzM+Q72hboB5bMYae3ZU=;
	b=35OEaoa+ZYBiaovDWX7GJuaMWKYtkgGg/KlhuwLelWstntCR64tc248aRU2kgeFi1aQl
	 gO3ybmGaAs7rIfL2CEfP/2RhmxWxroe9EnvmGaAluua2ChvqN68XEPiTSI6VYajE03v5t
	 l5/zjONTRmYqSMc5fO11qk2HluNKCiTcSQkU5SOFpPBRWLmogyANE+xvDzUR/A4ZJTOF2
	 WDdlweyHnxGfa1fJqfvjPpequsK6FAKIiHQxbxOJj59KHhnKvwiqqkOovKQooy0tEhmTU
	 ZYS0zeE9BEBhalx1cymVJ+I1RPW8eEZBUD6mjl2awE6L8A2SBsFeojExXdA1Lzk3/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyUce6fo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99934606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RyUce6fo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3191F0089F;
	Tue, 10 Nov 2026 01:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272567;
	bh=YOfsErwe8Sv08inJHE0UAD8SzM+Q72hboB5bMYae3ZU=;
	h=From:To:Cc:Subject:Date;
	b=RyUce6fouSEJmCaZrDzI56/hGarrd1dccGt4rG++wmjapqDeHcmBHfw1y5SONaqDq
	 YQO0DXSUm/pD83NYGEVYkQilmZfl0FLpfR4mZnMKOf5ngoF6O0f9ux8RUZK/Wv0K+V
	 qANm/+taJKpdPQ4rmS0+TYTTE8M3rzlmoYTnSUL2SGGLz0wz/Pfjbvgy1kTzqa40RN
	 ub9XbwvwvUmz5j76GCPqSTrLPryACzRp35s3IpZEKTA4gr6ULpyQ0RjxwE3FqEWG9Z
	 yeBprQZG/NUzNpxFVAU9ddmuMo2JCkYnoX90BscVva0XG3BF6V2y2IayYnFVUYdwJa
	 xokSjeQ2ov3MA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	peter.ujfalusi@linux.intel.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing BPT streams" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:45 -0500
Message-ID: <20261109200245-failed-6.18-348bc756d912@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 348bc756d912dd8f47fd36c167075717951a515e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200245-failed-6.18-348bc756d912@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 348bc756d912dd8f47fd36c167075717951a515e Mon Sep 17 00:00:00 2001
From: Lee Jones <lee@kernel.org>
Date: Fri, 30 Oct 2026 10:46:44 +0000
Subject: [PATCH] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA before closing
 BPT streams

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
---
 sound/soc/sof/intel/hda-sdw-bpt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
index ba9fbd662b859..9d97d86762514 100644
--- a/sound/soc/sof/intel/hda-sdw-bpt.c
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -456,6 +456,12 @@ int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *b
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




