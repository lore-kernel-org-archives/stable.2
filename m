Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B828030E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289331; cv=none; b=aGBgeWmRFKlySzosk7TxG1TM/SArVt7f+wQk0C+jTPuvhwtEWi0OnybreNP73+8FUhZvtDltX8b4TwZ9yCeFlzy7WEk7uMfKXOqRVlJr3lqQjfeUD8SvlN4OArf+5ikMe64I2yV+5QTpoumgI+FJz1FUkzPBxmri6EFfLUI2wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289331; c=relaxed/simple;
	bh=6yk6rSQ2xuCcPa8aOjqz85Jek3V1FUDJxgzFLY6FT1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CInuVd3TOaLKmsZTwyhnIX/Y1724pZsviptmsvZyk8ys95hX9Xhe1Cbt7skcUCbK2iCx+4NsQfJU6bYE091Wz/GXVyqvCYTgNBtx5V0bITXQzISfjTPBTgfs355cDVw2tsznqUDGllSaHSHYxfucUHK8RPD5QBrsNTaoUwqF9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PunsL07F; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PunsL07F"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53648215f9dso8209351cf.2
        for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289329; x=1792894129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZ0g9Te0u3jHEEDvVwqU4VmlgImgFGlZj72Jg2wM5+4=;
        b=PunsL07Fr0briGkYEPHDqObem6i+Uq794JwGRyICFpPoQrPu8DdWC4dqXxqcNn5mDW
         XEES1jpOPIUaA2DwsHHxqAwTAZniqphE+LCtASVsO+VUFvFSh7F+wXrHsh7McBq3mlAo
         XU5mfiGMEvmMn1pn/20a7hZsJ6aqflFvBDSNRIMroCSx8rx9xDADYnK0EXt+gzEsRS6J
         10Dwasu51xKCqpf/u8W2osl847MLecNRHmxWsad8vKEvcNhT9HFOa1Sc7YKpYRmJAV0r
         Kb9TO/18fZb5EjAfdsuvVjnnd3ep/bpCbqV3qk1kqHkVFhM9OBBr4LhbXKJYZMpgImsJ
         kc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289329; x=1792894129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZ0g9Te0u3jHEEDvVwqU4VmlgImgFGlZj72Jg2wM5+4=;
        b=fbVi7Vq31IaHbi7+1EzRU9Bt76Vlg1jq7WY35qbQ77YpiIuffAFx4hJyRMojtScolx
         KKubKDdKwcBTkKD60v/eDgnXl5IBUbQwHH1Ii4eSc4xD2bh9hQmZ5Hw4oVBkZDUCQZOF
         MsNYKlri5DW1a+Gu5W2yHH8uUBl4OW1PuNgipFDNa5G00vlACnHiXCncW9/wRcgLEgoG
         56lRL/fqIyaMsur5psUY6tnN6IVQHli51h+tEmcUjgWel5xig43RK3d8kuAD9gTTaT/8
         JmLOSMR5Yr6cmEkIGNJb1OH7G8j9rCIKd5cxeaDMrbOtoGD7819y/GEwv9gU69nRWq9N
         7Q6w==
X-Forwarded-Encrypted: i=1; AKwUvByy8Agvj3uoOY8oDaqq1a72CsmQbe2+XGmQbiwjpBAUKUDiB3I59DJJ7f7iksEaWikgWKV79MQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIagxNTQIFBSNVLDCkORKGWmfDHl5uHNCFRfEsStwSFV/owD53c
	YDeHvUdvd1JG5Bo8tM00G3lfqQZFhKqpH7ceb1Urg1Was6Uh2N07YcI=
X-Gm-Gg: AYBFou2M6Fc7PMyHj50lcxcxcMYkVnyoACik3v9WmBT/9f2s2bp28Ki3XuwXWeqZynU
	eoupHYThkdzJgsJVndNDfKXiErVhyvQET5X+DoT1I3dVF442XcyEEjGIMgaUgIHqKH+VuiBeyX0
	TnIdAFmoRp5yPLR6mW9X/t7x4aCHhjRcNbhFTCNgk3S4E5EDfJ4yjDKVKwXV3gK7veVAM5umcwK
	0Ufur6oE8IjFWhlx+A1CpwC247UV7r4UaLCJlNGEcTHvH02Jbq/rOMMY28t1Pq54edL+RIgYnQ3
	HKIc3Abj0ufZYBb5E4BPHWfon6PKLcbyUP92YJDYQyXhpT4P3P6XxbNKSDViXrUnU0ZVKJ+hWXY
	jpIN1JJRkEv9xAZfPPYkHUkKvOlm1uYFVQwdbVaCdXbrAwCb6SxnX1NA0nnPkSsWglX9xkCV5R6
	N0EsEnwxriMRgphFTqt6l4L+X7l/ChGYmNjdAB6wrrpMAckbdBjdF0nZYWUXUF3jbutwl7l2gWC
	eAsrcbbPCL0usw3RKIEhBREJLhVorD64b/rI/07FyZruBrsvADEAhmoctV90ueGWgm/652THerw
	CbjSy5oGNRIlentsYKJGh/dClm8p
X-Received: by 2002:a05:622a:1349:b0:536:3950:5d7d with SMTP id d75a77b69052e-53645faa64bmr63867181cf.16.1792289328931;
        Sat, 17 Oct 2026 19:08:48 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa68f8esm61731291cf.29.2026.10.17.19.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 19:08:47 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com,
	daniel.machon@microchip.com
Subject: [PATCH net v3 1/2] net: nixge: free IRQs before killing the DMA error tasklet
Date: Sat, 17 Oct 2026 22:08:39 -0400
Message-ID: <20261018020840.3851552-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018020840.3851552-1-mhun512@gmail.com>
References: <20261018020840.3851552-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX and RX IRQ handlers can schedule dma_err_tasklet. Killing the
tasklet before freeing the IRQs leaves a window for either handler to
schedule it again. The tasklet can then access descriptors and TX skb
state after nixge_stop() releases them.

Free both IRQs before tasklet_kill() so the IRQ handlers have finished
and cannot queue further error recovery when the tasklet is drained.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff..8697a76 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -927,11 +927,12 @@ static int nixge_stop(struct net_device *ndev)
 	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
 
-	tasklet_kill(&priv->dma_err_tasklet);
-
+	/* Remove both producers before draining the error tasklet. */
 	free_irq(priv->tx_irq, ndev);
 	free_irq(priv->rx_irq, ndev);
 
+	tasklet_kill(&priv->dma_err_tasklet);
+
 	nixge_hw_dma_bd_release(ndev);
 
 	return 0;
-- 
2.53.0

