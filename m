Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743285;
	b=LvWqfs07aUVzAFrEVO2/ursd02crfnrFIaxa9iDo4WbiySD8Uoa9NkdLZu2BBo9lquon
	 FpbLLCutfLJ4zcxbFuK4dHlF2EUu9FdY7aWpWBUlBhmTb45aACif2YdfNZukeuqZRiZj6
	 wd6dWNUXgVHVMFy9/jA2V0pcFHR1cFB8ue3krMreo9hIk4L4lS5dxX1/KrhGb7W9lgNff
	 9+HcGkzo229P8B0lkO85FGqm2nTSFHAT8EAlg8btlFArXlHDTWY8wv1dC6tZ4S91TXSjB
	 JGZUKn1S/VuAy8IfEGHn9KkN0r92oGKL9lY4XRW0oWaD8FGuAIwoKcXzLfDOPLN0lQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743285;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=RSGFHyYWpUewuZZXOQ9+NLhMNYX1e2v1q94HRsLkv/I=;
	b=sNZf3c+Eq4j7Mrt7y7mFwQzGJD55sBU/tfAye+u80ylE4S1ZCPKPhodIMgP3AN/sPPo8
	 kRm8yPPkyt0C27mmtw/1i7CTYyDjIMEDuc0pT8O4FR63zXrlV2Le4eG4Hr3dIf+YPKPHO
	 a3tkNCFBUX4vleI1SxDuTk1oKblpmSFJ6ItQuMPTrxddzQMuwhWKGJSMOFotXNcFPKQ7j
	 J/XIv97FuM+1ZVKd4CvCYy5i6hFwdX4FaIraegO6fUCAigG+6D4X9TEBOBdZH3nvfkArQ
	 7/SYzyzPTFKG6k4tL9tLPCT1t2fk4LX6xlnr7SAQzyYikVviTKwwZ182DwxIESPI7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b="kkG/A9PH";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD1606A331;
	Sun, 15 Nov 2026 11:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDD1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=kkG/A9PH
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04e8;
	Sun, 15 Nov 2026 19:48:00 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Stephan Gerhold <stephan@gerhold.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v6 1/3] dmaengine: qcom: bam_dma: synchronize outstanding
 callbacks
Date: Sun, 15 Nov 2026 19:47:58 +0800
Message-ID: <179474327837.103840.1575327107966587170@seu.edu.cn>
In-Reply-To: <179474327647.103840.9539614513141118915@seu.edu.cn>
References: <179474327647.103840.9539614513141118915@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df09253303a1kunmbac61c98bf7a3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE9NVk8dSU0YH05PHU0dSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=kkG/A9PHgDeawJ4oiz1VEp+PzTQaa80rgIT7eX3N0oco6N5KT2KBYzQQ2ZLvQpvAIBLmQa7mToAERfjCiaAslMZPbG928Yg4AA3tLEsAEYNtntepp+pAAYIY/XlIA/DlVo4XZeeTlkGhKuiig539WC1k4fqsr46TjhuHMVZRbAw=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=RSGFHyYWpUewuZZXOQ9+NLhMNYX1e2v1q94HRsLkv/I=;
	h=date:mime-version:subject:message-id:from;

BAM uses virt-dma to invoke client callbacks from a tasklet, but
provides no device_synchronize callback. Its terminate callback removes
descriptors from the channel lists; it cannot wait for a callback
already spliced into the tasklet's local list. Likewise
vchan_free_chan_resources does not wait for that tasklet. A client using
dmaengine_terminate_sync can therefore release callback-owned data
before the callback returns.

Implement device_synchronize with vchan_synchronize. Clients must stop
publishing new descriptors before calling synchronous termination, as
the DMAEngine API requires. The BAM-DMUX client-side publication
boundary is handled separately in this series.

Found by the author's in-house static analysis tool.

Fixes: e7c0fe2a5c84 ("dmaengine: add Qualcomm BAM dma driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/dma/qcom/bam_dma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index e62e411..8cee883 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -784,6 +784,11 @@ static int bam_dma_terminate_all(struct dma_chan *chan)
 	return 0;
 }
 
+static void bam_dma_synchronize(struct dma_chan *chan)
+{
+	vchan_synchronize(&to_bam_chan(chan)->vc);
+}
+
 /**
  * bam_pause - Pause DMA channel
  * @chan: dma channel
@@ -1359,6 +1364,7 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->common.device_pause = bam_pause;
 	bdev->common.device_resume = bam_resume;
 	bdev->common.device_terminate_all = bam_dma_terminate_all;
+	bdev->common.device_synchronize = bam_dma_synchronize;
 	bdev->common.device_issue_pending = bam_issue_pending;
 	bdev->common.device_tx_status = bam_tx_status;
 	bdev->common.dev = bdev->dev;
-- 
2.50.1.windows.1
