Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F730C345
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000770; cv=none; b=jsrxGPEuYkIbEjAm0xhRmAe+Pk7WKwAEr8hEn5NV/v5VdLAIDtf+SLHMaqa/2coHxe6dcEqefVmtNGzGVXqJdymsB4q5uuTrCr1rnrNfoibiMRBH/hYghrGoldcJW7vW8IfOeD0pWjdBMTnEH+MwssSandLN+eMdVLWeTzR7q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000770; c=relaxed/simple;
	bh=dOIXqLzBtSxy2qJIrgonAcgd/FeiJxv/lEsDBeOpcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6vnFAtOEnmgoAoqik190PxlVAI5SwWjfwm35ZSsKkMIP40e/9pY4BzlPaI1L18QzrWshJob7arJa0eFoBEEgJRWps0e3bm65y0oud8WNS1swMpo0vb9YUzgPKGwc9l1mHtoASOclCd6atC1YdJu7uvCRFg+5ez/wxTu3z1DjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfPWsVw5; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfPWsVw5"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-53397554beaso2006011cf.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 21:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791000768; x=1791605568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc2suPktwUV0lHyZwCLOmemG0HWTqvkRtCzdgjiCcCo=;
        b=MfPWsVw552kdpSET7H05u7VK5wF8VaN5nFh/7wOKOzRwfkWzv6kQ7CQ58YH+xoyT6Y
         o6ol6OVJ4dTCa2eqLB3AHkyCRG1n22kAP8cmbOURfGewAIDsri0G9Uxl0BKyoy8WVkVI
         Wb6IEU8VpZQ07zOIJPQ+JXsYOCF3p7BN3XbxgdDaEoye4jlsdxs9XaizNKpO6iBrFh7P
         x0YgMXqJv/zDWqhYkx2rOnkO4IMeWT0WMQI4x90WZyAl5FLOD7jfnO2f+aBsVS2Q8sK2
         L18nbKp6Y/P7u6x/6sWSLEWGwyBoVSq+EMMGtuTQNEeoDCae1+MSODuEcOBzYArl9JNV
         5oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791000768; x=1791605568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc2suPktwUV0lHyZwCLOmemG0HWTqvkRtCzdgjiCcCo=;
        b=Va3++/qBvUJhwkFl7443BXr2p79GZwK99LnSpoP0+2S79WY4zpo3ZDfDKEKqs8H42E
         U8FeU0Z1V/y9D+Hv0CVxdBV8lxJFBr3EIuzgHoSSzxdKCqolSxlT34JMcf+15B53Ncj8
         uJKqW1kb9ROwFnC15IuIJ130OnQwWPV0ApVcV3aRbIhtjj2NAkys4vxIpZEMZSAlnwrj
         /01K35pXowTPaD1hv2rNHVVT4S9HxkIt1TUXi6sr7PPDC7m7bHTuT3w5z44/y+AzQLOl
         eyhb9Qkh59rvH5MmpQDGcR0zE0wflef0nhA2ZDKl+Co4KbqA7XsBDz3QFrN3byso/WgW
         GKZA==
X-Forwarded-Encrypted: i=1; AKwUvBxdEVaiQqLVUfyZgV3k9+6BW9WQ2Li1Xxl4iEITmJv3yM9+gO+xaE8NGM+C7G00BB/Ecz78JO0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8RV+BK1ZDukeDjiMljTSWNSm9vW5SMdmWIKY3xmfbGGnY7TB1
	TPl991yQTZfS0wxQiSb2Vryltb6ihmWcVgcFKM+BlGElj96ND458nz4=
X-Gm-Gg: AYBFou3HK2LLfePnHPpKgr6qgHuE4yTESHW2janaskMSSpzC5BQ3rr/4YY/pfOk84fJ
	+iWssgE3U4j3FCPxjwi6bSZ7gtLOSPe+xVcjLJ/P5OmEeQ7aU9OdMy2pr7R+BLVsYbZ4njEurCz
	VOlsBvwkc+EfUA0JwIsrmB8dCSGjGDhDIBntQJJ7D68BP4Ymv49IgmezsPKdRzxlgzEXigbPy6o
	LDzbUj12e95FDiB4ZIH6eNHR2DfTgzTpNzne+OBoYplBzejy5qOVlcsLIjYao+yT8xAvBLEpHjh
	TIJsN+5LDvc1nfOWaXfxszZSIPUMhIsm5aqLx/xfxZ3STVibv8S9GAcq5oG1/Ruh+pMC5U4Z3u5
	sgrEbTznZnJVgJ0LviUneXBmrhcdbySMO3jPQ/8DoOd5RaYa2fUdsAVdNP85mdItDCSlWeOtw+T
	Tga2K7f60ngCVUP5xqeKgJdbdrGZN56mzBOzaLto6AwgPmEedsZSausUvahD6Xl/vSeJRjXyKva
	YL3m75VTIXP/KQQS9XW1oMux6siFvX9PozynWhL5ik89zkEmv5YHWxdsXRd5uVJY1O6VvAr0kqo
	NgMJjS/vIGubaNGGJk+S3eU45JR6
X-Received: by 2002:ac8:7e85:0:b0:531:172f:79e8 with SMTP id d75a77b69052e-53511f1965emr23644131cf.57.1791000767676;
        Fri, 02 Oct 2026 21:12:47 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a5b6d6sm42699391cf.9.2026.10.02.21.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 21:12:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: nixge: stop IRQ producers before draining DMA error tasklet
Date: Sat,  3 Oct 2026 00:12:42 -0400
Message-ID: <20261003041242.650599-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX and RX interrupt handlers can schedule dma_err_tasklet. Killing
it before freeing the IRQs leaves a window for an interrupt handler to
schedule it again, so the tasklet can access descriptors and TX skb
state after nixge_stop() releases them.

Keep the initial DMA channel stop while the completion IRQ handlers are
still installed. Then free both IRQs to stop and synchronize the tasklet
producers before draining error recovery.

A tasklet queued before the IRQs are freed can restart both channels.
Stop them again after tasklet_kill() returns so error recovery cannot
undo the final stop before the descriptors are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested nixge.o on net commit
6dc989ea46b96ce170840174b4a38c4a387fb005 with x86_64 allyesconfig
and allmodconfig, both with W=1. No hardware testing was performed.

 drivers/net/ethernet/ni/nixge.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99dd7..7bba6f8e64fe 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -920,6 +920,7 @@ static int nixge_stop(struct net_device *ndev)
 		phy_disconnect(ndev->phydev);
 	}
 
+	/* Stop DMA while the completion IRQ handlers are still installed. */
 	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
 	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
@@ -927,11 +928,20 @@ static int nixge_stop(struct net_device *ndev)
 	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
 
-	tasklet_kill(&priv->dma_err_tasklet);
-
+	/* Remove both producers before draining the error tasklet. */
 	free_irq(priv->tx_irq, ndev);
 	free_irq(priv->rx_irq, ndev);
 
+	tasklet_kill(&priv->dma_err_tasklet);
+
+	/* Error recovery may have restarted DMA, so stop both channels again. */
+	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
+			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
+	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
+			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
+
 	nixge_hw_dma_bd_release(ndev);
 
 	return 0;
-- 
2.53.0

