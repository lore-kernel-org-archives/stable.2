Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279972;
	b=4sfOCyeDXkMs0tWfc6ua/OPQX443Bwcu1jlwNNDPBoJGxn14dMrwjS6Xa6b99RbPVsEn
	 Vzml2gxpYqmSMkNA1M+Avk7Ar7EQbBr6oT08XpHUuXnPk7sDwG5oGaFbyNaiQiDOQZiRj
	 RtQabkfZVDQuSsN5IHDhNgO0re/ZKogHO8ovz9NCJaTr2pw5t8Wyu0mod/v9/1h9SQfKC
	 fcr4UxCd2izh+h0Zg74lUOnc6pQa3itcI4FpwwZcKqRusFDaL+yR7BxMF98M6bqNKTDCE
	 Yp+KVtXKGJoE2oP8ml6+6D+1U2RBMlXtAbyLmLBPpSSAGBvQjwLmpyS7B91i1SKxs7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tQLRzDw4bvXr9ZRnrhDdzQH9SFs0wSZAanziz/iGjrs=;
	b=JqZ98wKv+62BUJXTi7fM1ci8B8UcpiNkQTtfhGWZzZ0MSDQB76b6fCoD6e890aOZoinf
	 mvRg226O9VlJF9ogX1355OAG1E1tGkHOFPMaf7OW0Q7U/Y4ojVT8fkOE5KuKADEKyq6wm
	 CR6E+B0aqEzq6AOW7cIJZkIP/olu8SQ2X116iGwapSQR3IK1WG55bVonnS9lu9QUM7XdZ
	 zsxVAq8ce7me2WlK6qeI9Ft957P0NST/Y0ZkB0D2JMB8Yv9gXdI1nNLL5S7z/DmC4iW8F
	 QbN7vTOPh5XxNGPXyONmxRaMGTZ4CS0fNePB5hGfOofARqQeApT21xc022H6Wlyxdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QF6Cop8L;
	arc=none smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5B60A2608
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79F5B60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QF6Cop8L
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-490d838b425so841188fac.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794279971; x=1794884771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQLRzDw4bvXr9ZRnrhDdzQH9SFs0wSZAanziz/iGjrs=;
        b=QF6Cop8LNly7XYUHJuMhHwcfiT7U9lwvwQt0TcT+ptRcGB5T9VPK6WriONXxboB4Ht
         WX7lmBFZak799sF9mbU7e8zlZu9ZNVAIONWV22NewD7d1tl2fLniikx439Ou31GpzJ4E
         ATYeedgm1TtVXc9iA3/9QsNmbCTDJXzuLYVcBTm03rNbXJo4Yy4NA9j/Eczc4QfWpaJo
         59vRgWFoh5F5z+vbqXwNdWGz2a0RxZiKUrF095A9ox/a0WMxFfvnHCb7epxy0EN7IEku
         0ZQTWxByb0WIMa0XWvYkHFG4bCIViWlb6qiVq9x3kCskxgwOiys23uf5VMcOCQFo2tVe
         MsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794279971; x=1794884771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQLRzDw4bvXr9ZRnrhDdzQH9SFs0wSZAanziz/iGjrs=;
        b=FOzx9bobaFy4Tjn6c5bilgtosZlWW/q88SpT7S6aO4PPqTyTGDqM+AKeiR3RhEdj23
         3tIB3mjymdIBYm00puRki0Rpwsxo/1+GkNKre0Abg/bTDecz0WWE7RpeCqrDvjC9Ayj4
         EcTMyeKtJqE/STOtE0vyFZHhBoExXjkIl38fB7eATJQ+V8ZIkE3yM7pqBfzVjFBt3fgH
         v3yyt3ZCtX+1QnP1/PFwYBL9denQZglNIbxgIT/LgnTInFnq5f1Z40VYsmhElw//OGZn
         mZl/QeS5NrKvczGRFzb9Ayh01zaVx4q3qP5fCmd3lpcH5yIFZqH6sBvTUM8mH86TQOp6
         EiJQ==
X-Forwarded-Encrypted: i=1; AL+hErH8nz8Coajr3VJy7JUddSlW8wB/EPk5SHOxpbcfkPXpYbtbBB1qxmtINe1dEfLPCvUreBCh9DI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7YQawLRqTvo3E0bHH5y8jZCvwScEtpXZmcXH1ffski0nGsP0g
	NHRF9LI36avqvHPEavPg1TOgLUXnUHiPXqtEhc/vxd0p9IlWVKwwkCp0
X-Gm-Gg: AYBFou0B2sn5LcNQnZXyrMI2FLqhB7qH7dOXHfeUCV3NdIvNxU67NMkoTykXdFcE48H
	D/1P77fPNPzmF3f6aS41WoM5sRfFDdZ4TVCuhbETrueDxqRJs5OQg+uCwMH6H7CCx9MCVrsVggY
	eavgkk6bc3ShVofOEwJrR9UqO8HVjPXwyJ+u3uMWyBSw1SiEr+6LaNRp3oKqi13h+qFTLmYd55h
	NWYdfmHKLQdYPEjkDHtylDzvNk1H2lk3J0eVwI/0KCQSerOnz87nF3vSdxgT3ZM6+7TJbldVAh/
	6w6uu7DZM67MN0U1+y8gOKO+py0ORxbx9KyyOsQUtoUI/qyMhHoLwNfs1HwNLgHXk/vnj4jjbjA
	+9+dkGfAiInUiBz+7X7z+Db6fQAsDtUgWfOPuENruCzIZ1WHLVBWs8tOWfWo0pf0hV/XiNuy6Z2
	b5ODLlHKunedNf7kfvk1EymXigJT/J9ozEIxsSNa6c38iqee89LgBGNJUCBoJZ32TpGy4uVNDVm
	3ihiHkZcSwDL6k+lF7QyxRJn7aVwa16ko/oPS6wt1ViPc1OMpKD/9lhQOA/LSZtxSOaNANsf6zt
	i+Ty4aNgnu2S1x8K6n9r6LKiPDwj5h4zV71++GsGeKqPo/5sKypx581ANTmBIIkgH7qsXIg4Y4U
	+50y1gf7IOLutuX82eA1EvbPMxc9c+eaqLqR0SgDOFpMIsTtwwPzKPhqFVYUZ5ar/z3tX9P98pN
	0NRqSSg+RyuLiiZEw7nwtpCc5mcmQC/qz9R8tzfbGGPpQ16mzwfd/n
X-Received: by 2002:a05:6870:b3d4:b0:448:a3d6:c2d2 with SMTP id 586e51a60fabf-4ae225894aemr852134fac.10.1794279971434;
        Mon, 09 Nov 2026 19:06:11 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fcdc93sm683389fac.10.2026.11.09.19.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:06:10 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 09 Nov 2026 20:06:01 -0700
Subject: [PATCH v2 2/3] dmaengine: dw-axi-dmac: retain descriptors when
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
Message-Id: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-2-64adc48df793@gmail.com>
References: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
In-Reply-To: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
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
index 457ab9c47ceb..281d7c79246e 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -1187,21 +1187,24 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	int ret;
 	LIST_HEAD(head);
 
+	spin_lock_irqsave(&chan->vc.lock, flags);
+
 	axi_chan_disable(chan);
 
 	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan, enabled, !enabled,
 				       1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);
-	if (ret == -ETIMEDOUT)
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

