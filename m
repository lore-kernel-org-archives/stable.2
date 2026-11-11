Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366920;
	b=zHoMLGWg25YEje/MXzuvX4vc8lP6PtPGrzlip27xTkzc847/rA9zhyUNBOgg3VyfErsG
	 givRufnYxfSRXrEewDGRrF++Z1U613QMioR0Kyi2ejgbqoE4++CJ4NZef1htmdQfX87AH
	 N0jTKpjeUjR9qtJzc1Vp5fJBCGwUM+r+ZE6WxqogeeXuSxWt8BkhFHyqU53WzU8sM6wXk
	 jhi7t9RzR5O74/+zurswAt8zwWhGDCRoxTFHe60Js7cN3bLRxq5c44JVnBDL+r+4eQ19M
	 gK5AZ0OyKeNe1Nd8ojZg+L0tI+PO3Sr0iIqtRcCqxY+W5u8MMSAZ236IGi/lpQ4o5vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=l0vi1fNrlrZmz7yWWkSVUxeGDZ97UBQBJwEIiwWZ240=;
	b=aiaDhKgHk4l0JGKqPp5YC16eJ852u7wKgs/j1z+Att0iahiNfp1hohxNxPRBdiDSAPxn
	 I7gvjYE5cOnAjRYfJyerDiO2Qy/jqqG/CQHtwDvMvmM0A59S4JKSkRREYWTKIngRctk1b
	 BsmD0TzEOoO4nOXG7dtgwpTHptXNjPvRNJnUxfjzK1IBMrvjJrQaUz9BtIV280Z1wsBwo
	 KIuTYbaJVlRy8atTCwKvDf7WB31gjhfYEIwlUBs75Ew4eKhjGSkSzrIYUdxKUHX6wZSaO
	 zXwsfoW+qbs5fkcvW5w3M19xycMv/Jb0cEmhauKPSAElGLaLaS2zTnPNgatwGaGIKHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmZtCQDX;
	arc=none smtp.remote-ip=209.85.167.178
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1E606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC1E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CmZtCQDX
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-55e02e89f78so863131b6e.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794366919; x=1794971719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l0vi1fNrlrZmz7yWWkSVUxeGDZ97UBQBJwEIiwWZ240=;
        b=CmZtCQDXkGsqoS/pnOdPykmsrEPZQfGaN5/EURbzXqNcLUwkPNpE2vX3tqlgkFrr91
         BFPEZ45ujN+xknq/WcbB+2JG2Xa06edZGeljUaOGN2j0g4W6yWyjTrWHmHNFMbaZ/cBV
         OIek6MgIRXBQEfP4fuW8GkihzxSvIWgua0zsWL5Z8BaywI4T0UM8vnUj6PJ5HdTuywuQ
         n/raSjacbgakZsSpfr617CrrBCwCyCswkkV9NcpgzBPtZcpI/3o2O5eMkUI0zVtKIgEa
         KM8ouVY3Q2oIivQdsxN8TAiieS64S38bt7P08MOHy3k82KgnQSTAvx9zRDwB4QuaOZKW
         /58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794366919; x=1794971719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0vi1fNrlrZmz7yWWkSVUxeGDZ97UBQBJwEIiwWZ240=;
        b=YAvDpiF4iQ7q5Psg70JvlumqmXy6Vs8W4xSka5P+YlC+Jp2/uL5T0QXBgDgFjGaRM5
         GeWEaDcOKj3BIC9QszZ3v5SuIt87ZqKrEO9VK2Dc970PFzzwXmuA2CU0S1y6aQu6vh6+
         SFUTxEw0u4F+6MtGlKMtmE2z+5UWWPi4Dhc55TG19Rw8HPgh0IQv2XVxxcuyOQh8ctag
         sX+Z1oXTkNqoE6xDDT1z9mYqSHa2uAh0CDqO3jbAorFM8YOh4Mdn6Pt8crbiadm0AdNc
         LdpiRTRAAnN0z1cT8H6rZ66IDw2DVw9gL3+kJ6SAAm+SnSHnwVT+bT3XNMzFz01Sj29K
         kQlg==
X-Forwarded-Encrypted: i=1; AL+hErHpLqMxrZDVC3lMjph2gVLMx6q5dHSJBbrA1shzxIjmmaZMHgyB5VLXi4Ohma/cukfHntAJF9Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+u+81vPWTmra+t1TSOi9Z29N365NEqLZAWy2CsLJu8d8v3PRSn
	Qt9IOTW4P+YFfyRJ0I5m0MVLiL6drVHi6duzHC7rcGQeM0BuqXZoEHzR
X-Gm-Gg: AYBFou1AkL7yQxWdNUdm1P6o8SpxlHQiH/s8+0ww0tgJnda9+ro1jdJBNRCivMJkmWi
	scLcQmRRHYzAK8zdYxkComWC91s3o7Kw8igbOV9un8Nceeld7M6cDRhSb+R3MAACFxjYh/J2AQK
	DLWE5UQBpY2pDaPZcTUpvA1Nif0MqVYyZEjUw8EEn5ldyq7A6usj/UQJxWkOwUQUgvHq8VD/xyl
	NTd+sSFhsBWcbcYE+f9lpkLChENnT2H1wQHjIAfIvO2CKEiJt6ETWZLihRnQlcCJ5cpvRC+LuUg
	iVp+B592mAN7gq2nKaVlTrASo5JS3sLVqPI3+/StJiHQGYyjLWxR/048BTOleIFWneKFmmll1p3
	BCbRj/MWCsSTVWVPUd4CoIhyUEJZcQP0a2ZWERbrhFQd9S/N0njI71afr5bDJzWyCAcmdAsqmap
	srjaPQ0QD7c266fqgSe//xaGQYpOnzwNIvfxMKZdyRThJrgI3HqWQ3UZmThoVCNhZ/Pt0baAU/n
	eBG5R60palRTS8CgHswJbw8BkR1Dv+gd4SJ+YhHCt2COVcHKlnu72ehtiWlDOgm0kzT+E8zVsak
	U2QlK815vHQuc9bpEvwGZxENiLvK+4ibns0bwUz2HZNHGSufbO5WDJFTeJVQ9dEKPGegG2agwfR
	Yt6R+wK3oWyhqGiiojIsb+5+jH9nvu89Nxld1od8eKjMEIr0RMxNDo+sx86+BURVMyKEL2tblp1
	YMKKE+PDrJ6p4KJ1pFWuhsXFnPzg37uHzMbF2hAIp1yq4CFW1t6yw=
X-Received: by 2002:a05:6808:5198:b0:4f6:2ccb:c2a with SMTP id 5614622812f47-56b9861e983mr995316b6e.68.1794366919240;
        Tue, 10 Nov 2026 19:15:19 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5690504fdb5sm3999345b6e.3.2026.11.10.19.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:15:18 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 10 Nov 2026 20:15:13 -0700
Subject: [PATCH v3 2/4] dmaengine: dw-axi-dmac: retain descriptors when
 termination times out
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-2-35fdfba8b61d@gmail.com>
References: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
In-Reply-To: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Sergey Khimich <serghox@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sia Jee Heng <jee.heng.sia@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

dma_chan_terminate_all() warns when the channel enable bit does not clear,
but then frees the descriptors and returns success. Its synchronize
callback only drains virtual-channel callbacks, so terminate_sync() can
also report success while hardware still accesses the transfer.

Return the polling error before detaching descriptors or changing the
peripheral routing. This keeps the transfer resources available while
the channel remains enabled and lets the caller retry termination without
treating the timeout as a successful stop.

Hold the channel lock across disabling, polling and descriptor detachment
so an interrupt handler cannot restart the channel between the stop check
and cleanup.

Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 2c2435c36ab7..a9a87589324d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1187,22 +1187,25 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
 					enabled, !enabled,
 					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
-	if (ret)
+	if (ret) {
+		spin_unlock_irqrestore(&chan->vc.lock, flags);
 		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
+		return ret;
+	}
 
 	if (chan->direction != DMA_MEM_TO_MEM)
 		dw_axi_dma_set_hw_channel(chan, false);
 	if (chan->direction == DMA_MEM_TO_DEV)
 		dw_axi_dma_set_byte_halfword(chan, false);
 
-	spin_lock_irqsave(&chan->vc.lock, flags);
-
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	chan->cyclic = false;

-- 
2.53.0

