Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69735364052;
	Tue, 15 Sep 2026 03:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444606; cv=none; b=qD4+DzR7GpFQ23FDZGB0/A2KpUWDPaOQv1rGlzy45IW+2TqUfHxLRTE17sGmm3cfa7l1aFzxPMeTofNdHONQFM4J/XXYlIlultzkzkseyKohV/k4+7sKhTdV2ECDU+ATy+A20NYKU37GhSCVhNdfkE+Xc541jwmDOLiK7JeSo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444606; c=relaxed/simple;
	bh=sQ/7p6mlglIOpYjoj97REr9pNyp85G66JLD/T43bnGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7UJi//qCXcKjKvb7GUQATY8GFXSPbGDWWS8xGZL6SKUqNnv4vvhtpXn70HoqgD/t5fqbZCIyPPOfqHi8+XpRpNG17RCftnESqZ6i90Ae1djG7xW1ogjMqE/kVd3XYY0XsT0VdkwSYjtZIeSA4eejW1s3bl2IICYIi56VJ9OWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADXrPDvwahqtt4HCA--.49278S2;
	Tue, 15 Sep 2026 11:56:31 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	geert+renesas@glider.be,
	laurent.pinchart+renesas@ideasonboard.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	vkoul@kernel.org,
	lkml@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] dmaengine: rcar-dmac: Fix runtime PM leak in error path of channel alloc
Date: Tue, 15 Sep 2026 03:56:02 +0000
Message-Id: <20260915035602.1724403-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXrPDvwahqtt4HCA--.49278S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18XFyfGr1xZw4ruFWfKrg_yoW8Gw4fpF
	4fJ3y7Aryjqr45GFs8tr4UZFy5u39rJ3y7Kayftas8ua1xGa42y34rX34jqa18CryDA3Wj
	y3yDJr1rCF1kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1go2UUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMLA2qowd0AVQAAsZ

rcar_dmac_alloc_chan_resources() ends with
"return pm_runtime_get_sync(chan->device->dev);".  Even when
pm_runtime_get_sync() fails, it leaves the device's runtime PM
usage count incremented, and the negative return value propagates
straight to the dmaengine core, which aborts the channel
allocation without ever calling device_free_chan_resources().  The
balanced pm_runtime_put() only happens later in
rcar_dmac_free_chan_resources(), so the reference is leaked
whenever resuming the device fails.

Use pm_runtime_resume_and_get() instead, which drops the reference
again on failure and returns 0 on success.

Fixes: 87244fe5abdf ("dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 44eab2d21d54..2d2baa36feea 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1068,7 +1068,7 @@ static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
 	if (ret < 0)
 		return -ENOMEM;
 
-	return pm_runtime_get_sync(chan->device->dev);
+	return pm_runtime_resume_and_get(chan->device->dev);
 }
 
 static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
-- 
2.34.1

