Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492763;
	b=fFer39XhbvW8SKosYR1P35XwX78p7SOaoselp2UE3vFWKA0rUWi1PdCTAbTkpeOm+1DV
	 9HfZYZGLIeDMxZPRZQKX8288uvNWWlrbYZFCS37aFFSiccXCBC3+WefTQPvC7tWv1BFoN
	 FBVX5XynsnDsgpFgXI436ZJuuvtyA9BqV4Y8J8I2Vd5IBEU7OvJ0PkaG/ir2qiHPLltjY
	 pE8uxMhG7SeCISGt+uV8vQNM42g3Tjm+KXpnqWVI6R7H7GQdX2fDDdRumkEh79rg7qM7O
	 /OCZNd1kNk4RW3wI8EBJ4GrkJeNQ5+Nwq5uIoVF9Mhf+uLrRzv18UXZzCc5kaZiN1rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492763;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=DQjqSi+Xbxrb5HSA0kVI58RICRHKxQ0697TM5mRBuQw=;
	b=k15iM05XW2+vSidupBCO4s/W6bBpy1k/r2IL2/VwCSfpkYDUjObI0t0/C+/4xoQ+lPGL
	 HvhWIM6MlFk+t7mqFKbT6L1vC/vQeuX8nmR98+gEgZf1vYkYWOoe577w37eyjQTryEFGL
	 7WqxDajQEuy8Wi5FJEpEjT/SO5Xv8+dRZSbTF9sbGX7aigL/C54e3xiXEhmTZehXH0lo5
	 Asdff1W926Pd1kysEsuCD7LQ6wEpQmshNJ4dxbRWYa90ucAgy+u39e/nQt3KuntL2xInP
	 ZCc2P96kdRow0RkXZgi57CM1eqL7I1Mhz0xt2Zk22SiXF8aaN7Uf0iMMF2Am0uc5wVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uwHUFoGs;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF86606A330;
	Thu, 12 Nov 2026 14:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF86606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=uwHUFoGs
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMm930yTz8Xrrb;
	Thu, 12 Nov 2026 22:12:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492761;
	bh=0SDmI7iviDUDT7G5PYw9YL4mSSSdAXLAzz7lgbCxVXI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=uwHUFoGsZJr21KwLNY5h6EzkDcqW1p6guVP2O1Rs1HLL0+pgxVZaJKNAek525H9Rr
	 MbSMPTji6buTprgnQ29zHcvtjjn43Ij6aXj7qmdko+1v2RtQhrEcw5cVWc/MxFDzeZ
	 sqXncwxqZjGKTPQwBEbM6Me8I1MDsKnzuqXMWjsbaMobGMa0Zh+i6oPUj8sBtI2BR7
	 E/pyRH30QsWOoXlbUQQcCawcQWW+XqSceXAMERILb1bx1xV0Xj4U8lO7f+5aLMITkZ
	 9WZDOwWnqRw3paF9qiMspEBGOszXM3XQpAqoOdoWlTRfhxuGeZZ8F96j1V2IgbNlqk
	 ZuBVgoED5Nmsg==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ACECXx2055513;
	Thu, 12 Nov 2026 22:12:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:36 +0800 (CST)
X-Zmail-TransId: 2afc6af5c954ce8-e4457
X-Mailer: Zmail v1.0
Message-ID: <202611122212364902sIN_-yPAlYiDRPpXApnj@zte.com.cn>
In-Reply-To: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
References: 20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn
Date: Thu, 12 Nov 2026 22:12:36 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gYXRhOiBwYXRhX2l4cDR4eF9jZjogYXZvaWQgcmVjdXJzaXZlIGxvY2tpbmcgaW4gdGhlIFBJTyBjYWxsYmFjaw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACECXx2055513
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:12:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C959.000/4jQMm930yTz8Xrrb

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ixp4xx_mmio_data_xfer() takes ap->lock, but the SFF state machine
already holds that lock when it invokes ->sff_data_xfer(), both
from interrupt context and from the PIO work item. The first data
transfer, including IDENTIFY during probe, therefore recursively
takes the same spinlock and can hang the CPU.

Use the lock held by the caller while switching the expansion bus
width and transferring data. Assert that the lock is held rather
than acquiring it again.

Fixes: 47adef20e67d ("pata: ixp4xx: Rewrite to use device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.4.0-rc1-next-20261105 under QEMU/KVM (x86_64, 2 vCPUs),
with lockdep, DEBUG_SPINLOCK and KASAN. Both kernels carry the same
TEST-ONLY harness: a synthetic ATA host and RAM-backed registers feed
the original SFF state machine and IXP4xx PIO callback. Only this fix
differs between the two kernels.

The unpatched kernel reports recursive locking of host->lock from
ixp4xx_mmio_data_xfer() and stops in the first SFF transfer. With the
fix, SFF calls with in_wq=0 and in_wq=1 each transfer 512 bytes and
restore the 8-bit bus timing. Separate 513-byte read/write checks also
pass, including the trailing byte and buffer sentinel. The patched
guest shuts down normally without lockdep or KASAN reports. This
tests the callback and SFF interaction, not IXP4xx hardware, probe,
interrupt delivery or PIO worker scheduling.

 drivers/ata/pata_ixp4xx_cf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 80f6a91acf..6ea671d218 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -131,11 +131,10 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
 	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
 	struct ixp4xx_pata *ixpp = ap->host->private_data;
-	unsigned long flags;
 
 	ata_dev_dbg(adev, "%s %d bytes\n", (rw == READ) ? "READ" : "WRITE",
 		    buflen);
-	spin_lock_irqsave(ap->lock, flags);
+	lockdep_assert_held(ap->lock);
 
 	/* set the expansion bus in 16bit mode and restore
 	 * 8 bit mode after the transaction.
@@ -169,8 +168,6 @@ static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
 	ixp4xx_set_8bit_timing(ixpp, adev->pio_mode);
 	udelay(5);
 
-	spin_unlock_irqrestore(ap->lock, flags);
-
 	return words << 1;
 }
