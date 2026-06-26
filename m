Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A63E5EC9;
	Fri, 26 Jun 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476316; cv=none; b=Rt/H2lyIg4M0ZWCAKkLYz7EMB3/uAW47kzS/kNJQzXT8I7fA+TI8ny8hcgV6sGP0617ES/jiF7sf0cK7A6nnkKD29ReEkN1MtxK+moqlwPk2S0QLWS/cPKGkRxBGrty5gTmSnqTtr8oralp3xOhVcaNz1XmSEIMTLpAZK4o+TRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476316; c=relaxed/simple;
	bh=o6Q2eIS9pDEgn2VocqHd66JeSMLwlQBezNr3n/ezLLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxVM8TqU416wMXpc5OOroXdISKUQ6+EPMa0COEBDWt1kMVGWjpmzRFgcfSgOm3VS/pCn86ZGcjnuC2UsmKX52L1GyilTrjtDTB2htLI1Nt6iX88bbwzD9AiM4u8UcNqdxL1Hik9/85JrdonmQbQJbu+KnhSwJmz50OtiDD8QuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowACnMwcTbj5qSbNnFQ--.22821S2;
	Fri, 26 Jun 2026 20:18:29 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: dma-buf: fence_chains_init: error unwind path leaks   enable_sw_signaling reference
Date: Fri, 26 Jun 2026 20:18:25 +0800
Message-Id: <20260626121825.35310-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnMwcTbj5qSbNnFQ--.22821S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKw18XF17GFyUXw45Ary8Grg_yoW8Jryrpa
	93Kr1UKr98K3WxZayDAF1DtFyFkr4rXry8WF4jka4Sv3s8ZFyUXr4vy3y2qF98Cr97GFZ8
	J345Cry5WF1rAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMqcUUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcKA2o+ThJiEgAAs6

dma_fence_enable_sw_signaling acquires an extra reference on each chain
  fence. The error unwind loop calls dma_fence_put only once per
  chain/fence without first signaling the fence to trigger the callback
  that releases the signaling reference. This prevents the chain fence kref
  from reaching 0, permanently leaking the chain and its contained fence.

Cc: stable@vger.kernel.org
Fixes: dc2f7e67a28a ("dma-buf: Exercise dma-fence-chain under selftests")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/dma-buf/st-dma-fence-chain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index 821023dd34df..7dc18e294387 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -152,7 +152,10 @@ static int fence_chains_init(struct fence_chains *fc, unsigned int count,
 
 unwind:
 	for (i = 0; i < count; i++) {
-		dma_fence_put(fc->fences[i]);
+		if (fc->fences[i]) {
+			dma_fence_signal(fc->fences[i]);
+			dma_fence_put(fc->fences[i]);
+		}
 		dma_fence_put(fc->chains[i]);
 	}
 	kvfree(fc->fences);
-- 
2.39.5 (Apple Git-154)

