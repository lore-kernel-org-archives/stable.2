Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492764;
	b=oQQHs5791FKE93TYl+kZ8MDb9TVEHdpysvGUi5DhJvMb58uit0eNxtXiWOSH10lt8cq1
	 +D4yFKUAvsFMj0jKh/qVkoI0jEeXrQZ3oOj6SZpZG3eyctbnpxNjSwSk8xOiI7hvZ9eBi
	 GnHCrMKh9Sr0tp18bZqTHaVsWhmEGODQJ97uSVeJN3fAp/x/aldKolzHjzvUjafYOEFPe
	 GX6lZnhoMeQLMjmhtGVfCr/xS7QzqIKzIHqI7VMTXPnedHKi3S+pdFRoUZDux4rLpxFBc
	 1TlIQdNd8vnkVcUuFtUtP2yuFkCBX3s7Hrc3NB+5WLeypAayl4SU0Ginv/ig0E/AxeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492764;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=RUZjJUHHv2iy/7DFNVFMMu1yIHP96EHSskrQhBrcTQ0=;
	b=cuDqFvYKcaWGxnuDfMIxMTnHBclAMDxAA4SQx89XkopW8jTex+pjUOMCbIZNo0csoxyU
	 ZKpvbBrgSTRCGWszpOA4NVsQwz8rb54oqr89f7y7jwlFjY0cgGi9RNcBj0fJhLgtCRzyU
	 nic+GgyNSKi9+IQIYZ5esr8iRv+TOym3JOxkTzlI3f5mPwmo0WVuYDRlauOKrkXDhomWi
	 e8usxn4AXfc9ep7n3/wF03oMl70LEzdxfm77bmcEWtd5WIJqe8LCqHcgD8cWnd6JW4sgT
	 EfRGEA+MHFDOot5eKsSr6y9kDkIAWJAW6aQYl9DgiUI599uRGbu3LfiHaZTj/nnYIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gVZWatGu;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FB606A321;
	Thu, 12 Nov 2026 14:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 459FB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gVZWatGu
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jQMm52bNdz5B17p;
	Thu, 12 Nov 2026 22:12:37 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492757;
	bh=M7cFEbdv2p/YipPkXLYND5rwtPv5UPjqr7RkmKYDB/s=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=gVZWatGum/h5cCs7q+zUiJTl/SIRdGkKzbehdEl02WBiNosPAJqm4UV4IrtU3hexr
	 RhgDzt7WFSPWefYATlBzoD15Yb+dVQRDlxLKm7WcR1IDkIwPqbE3tdNbVOdAgoX3Ht
	 YjIBUodWKixnBE884FyOlMf1lPehPRXvpHxHNgoU34MHZ+hZJHe5EmXFNBOghXhuzt
	 4LbTwtFqy73ap702zbvR1nDYx2iINlpcKV6f+jNbS9I3YP4xXunxQ6EiQDNX/iflMP
	 s9JCzRDv5L8Jx/sVKfbZr9+e6V7loqZCQ9v7OgXmpJcclK+Z0ljTyK6n1wTc+TcZNJ
	 jZBVGjPLoLISA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ACECZKM063333;
	Thu, 12 Nov 2026 22:12:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:38 +0800 (CST)
X-Zmail-TransId: 2afa6af5c95620c-0395c
X-Mailer: Zmail v1.0
Message-ID: <20261112221238816WqGtG-DYdZIrGF_rlEkK2@zte.com.cn>
In-Reply-To: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
References: 20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn
Date: Thu, 12 Nov 2026 22:12:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gYXRhOiBwYXRhX2J1ZGRoYTogcHJvcGFnYXRlIGhvc3QgYWN0aXZhdGlvbiBlcnJvcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ACECZKM063333
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:12:37 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C955.000/4jQMm52bNdz5B17p

From: Shao Mingyin <shao.mingyin@zte.com.cn>

pata_buddha_probe() returns success even if ata_host_activate()
fails to start the host, request its IRQ or register its ports.
This leaves a Buddha or Catweasel device bound without usable ATA
ports and allows the remove callback to detach an unregistered host.

Return the activation error so that the driver core rejects the
binding and releases the resources allocated during probe.

Fixes: 12ce6b0d21c2 ("ata/pata_buddha: Probe via modalias instead of initcall")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.4.0-rc1-next-20261105 under QEMU/TCG (m68k virt), with
SLUB debugging. Both kernels use the same TEST-ONLY harness, which
registers synthetic Buddha and Catweasel devices on the real Zorro
bus and calls the original probe. RAM represents board registers;
dummy port methods and invalid IRQ/SCSI parameters exercise the real
ata_host_activate() failure paths. Only this fix differs.

In 20 scenarios per kernel, all 16 activation failures incorrectly
bind the device and retain its managed resources on the unpatched
kernel. With the fix, probe preserves -ENOMEM/-EBUSY/-EINVAL, leaves
the device unbound and releases the MMIO region and devres immediately.
Four successful controls still register and detach normally.

A guard records and skips unsafe detach of unregistered hosts on the
unpatched kernel; no crash is claimed. AutoConfig hardware discovery,
physical IRQ/PIO, disk I/O and the manual X-Surf path were not tested.

 drivers/ata/pata_buddha.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index 5a580ef4fb..bc8719e5d5 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -238,10 +238,8 @@ static int pata_buddha_probe(struct zorro_dev *z,
 			      ctl ? board + buddha_bases[i] + ctl : 0);
 	}
 
-	ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
-			  IRQF_SHARED, &pata_buddha_sht);
-
-	return 0;
+	return ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+				 IRQF_SHARED, &pata_buddha_sht);
 }
 
 static void pata_buddha_remove(struct zorro_dev *z)
