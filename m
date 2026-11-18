Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011424;
	b=ZjJc2NYL9eW9wU01aeB1E3jANSXCHN4+qsFXbh1lVYM/ckxtK5c4uAyo/hYfhC8DQVA6
	 kqiKIEgssYASkXT9OuI1EimrNL/m7dq9rJc4JPOEL9+ivXEaKHTPw6CNY5pFD1DSDRFXC
	 XnIIYfLeUXop38Vl2SaVGc5oSs2963goQWLX+ing+L9naIpcKJ4hls5/2K01RXHbcZ8Ab
	 ATK1fc5rei8LmKPMe2LIPDhHXuQPq+uNof9IOISNIUxvFXw/L3mLyFCiYg8+PwWyjsZ3v
	 Yzz9AsRpgnD+ySZxsUw4cjz0Yr3mBOzUcc4voOzdivyTxs+EZKO3iETNT4bkYYHzkpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011424;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=RCukRNDLx3/I3Pshhbw7Ce7hhf06g8ZCl++kIq5lbxQ=;
	b=z5tSNdMrPG+Le3q/tYfn+NWMgi08+/TbKbl23vohGxuFUz7PkSJn842+HQuWPA3VR1RN
	 8Ohrl8nQSMKMIg3ZAMaC9W/yf181AxIaHHgNp1avSUpINyZvOQ4zeD7gAYsOexSTl1NWv
	 8FAop+qtMmO+we3Rn65Ctpc0i6fTW+JXTacCscIKw1cyz7j8kSYVBQuwyGZda2y3I+nke
	 e04tZCPnhKe7G0eOfVcJUZ4RbMHISJ/sF9981KA5qy2qA3jCb0AjKM+UX3tjsP7OLu+H9
	 lglT75z5uv8eedPi1pgamI/3z30Z6ShY7KkjY+up7JdWj+GCULYQYOqH9T+87N+fPIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TqX8OfAn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC2606A339;
	Wed, 18 Nov 2026 14:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8BC2606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=TqX8OfAn
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d78a8;
	Wed, 18 Nov 2026 22:16:48 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Fix potential DMA buffer leaks on teardown
Date: Wed, 18 Nov 2026 22:16:47 +0800
Message-ID: <20261118-324f82bd41-slimbus-qcom-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1ef04736703a1kunm0a20ccee1a0ebc
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHR4eVk0aGUNMTh1CSR8dS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=TqX8OfAnt416xWVUeNpWnRlldgTe8PmesPbVBmB1gmpFfoMeOB7F8m4yZjY44IRxi6D5URlFnnCmvFAnWjVn5cTi7bCctELuiynMC6sQuTXVn9W1dPPvCSfSPjulIyEH8rqS3M/ZxgLW9gu8GzTcYUAFaEcjRmWbkppfEDskYUA=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=RCukRNDLx3/I3Pshhbw7Ce7hhf06g8ZCl++kIq5lbxQ=;
	h=date:mime-version:subject:message-id:from;

DMA teardown terminates transfers and releases the channels but leaves
the coherent message buffers allocated. A subsequent initialization
overwrites their addresses, and removal loses them permanently.

Free the buffers after terminating DMA. Clear channels released during
initialization failure so teardown cannot free the same resources again.

This issue was found by our static analysis tool under development.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index eb983b6d1815..e604f4e2b762 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -706,9 +706,12 @@ static int qcom_slim_ngd_init_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	return 0;
 
 rx_post_err:
+	dmaengine_terminate_sync(ctrl->dma_rx_channel);
 	dma_free_coherent(dev, size, ctrl->rx_base, ctrl->rx_phys_base);
+	ctrl->rx_base = NULL;
 rel_rx:
 	dma_release_channel(ctrl->dma_rx_channel);
+	ctrl->dma_rx_channel = NULL;
 	return ret;
 }
 
@@ -743,6 +746,7 @@ static int qcom_slim_ngd_init_tx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	return 0;
 rel_tx:
 	dma_release_channel(ctrl->dma_tx_channel);
+	ctrl->dma_tx_channel = NULL;
 	return ret;
 }
 
@@ -1210,11 +1214,19 @@ static int qcom_slim_ngd_exit_dma(struct qcom_slim_ngd_ctrl *ctrl)
 {
 	if (ctrl->dma_rx_channel) {
 		dmaengine_terminate_sync(ctrl->dma_rx_channel);
+		dma_free_coherent(ctrl->dev,
+				  QCOM_SLIM_NGD_DESC_NUM * SLIM_MSGQ_BUF_LEN,
+				  ctrl->rx_base, ctrl->rx_phys_base);
+		ctrl->rx_base = NULL;
 		dma_release_channel(ctrl->dma_rx_channel);
 	}
 
 	if (ctrl->dma_tx_channel) {
 		dmaengine_terminate_sync(ctrl->dma_tx_channel);
+		dma_free_coherent(ctrl->dev,
+				  (QCOM_SLIM_NGD_DESC_NUM + 1) * SLIM_MSGQ_BUF_LEN,
+				  ctrl->tx_base, ctrl->tx_phys_base);
+		ctrl->tx_base = NULL;
 		dma_release_channel(ctrl->dma_tx_channel);
 	}
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

