Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592992;
	b=HKSTNAxktUQaxPAXshw8OolLjc+MoOgxKslnnpAJWfyg7lgB/eHTzhx0kQmPxjLwnhYr
	 8QbfCJ+R52b4n9dMk4DLOY8UA3yHf2apA1wTMFmNovJYk5un7mfAS71IIPmXYfEnt1vWL
	 j5gi5Vv4vkLKZ996M+0k7VVo9Z8/ktozisLXdOTEkXqe+xES70FVK8F9i+ABipGz47xbQ
	 7tY/iElgNVQW3WS/wTxlB5O8lVrQj4/54K5w1Aoe/7Hv1FkOAZd8NYRKQYI/6LvTNFi4Q
	 1MG2UyUyJKooaJGyiA4z8Adw2FXPcemSPiMxBUF7Qn8OuoejHnrOgQsXpGgaoindC9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592992;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=LMgHAxZUjx+GcXgbx49HgZZ7eFBy/Mde5Pjuy5P0rGM=;
	b=VhGAr0nkTlt05LUJx/0A/hYpaSc8ywDxuQ79cuzUqT+IV/kG3569QGhifDlfl3IeEIKQ
	 CeZG3kHm+0pTS3L9MggNxYY390+OwSJlXTo2EF2/BsRlUkdATx+i2xA7p0BD3PC+BjmU4
	 EAGfJ7ZlzUY6FxciSWDPbSvdtWKoQGI+JUBNacksU9O+WzbJCz9qb3raTaeZzOtailsxI
	 NqFVCmlcFDyN8iWxQlemafu+U9n2ZfJ0YxVsVW2NqeRj6iBOx2b1JzJrrQbzYlDFMorn8
	 CUkecm3DVSXTeiUMwCyoLW8trDzY0JWTB5Lnj+sVlGJfVGxa2piMt8OoXa4Fye25kaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=O7KQc7CG;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A76606B209;
	Fri, 13 Nov 2026 18:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A76606B209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=O7KQc7CG
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qf2lNmz5B101;
	Sat, 14 Nov 2026 02:03:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592990;
	bh=icYKhfhdcwIXKbzgoXwze8yh1MA7wUSjzTJN3Dj5o2w=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=O7KQc7CG00On+Iay0XNtuTHkyA8Q9+0HmqJCf11R9sjv+usQ7ijgjhK7o4QbHZKQs
	 Q7Rf3rspU8eiNBdMFRy/bfo5y1k/VXOS+ENcgrYe7a3lQEehKOBB+Jqxf1kPD9KWKw
	 jCiPDLFxsQVL6nneZngru0LWpqUAaGtZCBoozfVtXKWet4tx8C3kz6CJig01iUbyIv
	 T8Ra46Xa8ZKLnGv0aMemOMpf4eSifqmeh+yIqAhhcQGThtmqPLing1qlKWkkd97P7x
	 MQWZbsbJGiLEYRzIgzS4afjU53oZwQmELJkXl+64s4C9eLjPZAlK7IJ76WidesRz+t
	 qNcx0XOxqdkAA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6ADI32bb099905;
	Sat, 14 Nov 2026 02:03:02 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:06 +0800 (CST)
X-Zmail-TransId: 2afa6af750da82d-3b74d
X-Mailer: Zmail v1.0
Message-ID: <20261114020306493hfnP1MhCdl3ivDDSL9eWL@zte.com.cn>
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: 20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn
Date: Sat, 14 Nov 2026 02:03:06 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAxLzVdIGF0YTogcGF0YV9peHA0eHhfY2Y6IGF2b2lkIHJlY3Vyc2l2ZSBsb2NraW5nIGluIHRoZSBQSU8gY2FsbGJhY2s=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI32bb099905
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:03:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750DE.000/4jR4qf2lNmz5B101

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
 
-- 
2.27.0
