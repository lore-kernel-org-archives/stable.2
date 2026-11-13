Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592997;
	b=Ynj+zsZQZOCfarnCoiGzlSSWW1N9MZTg/S7evNZ8lYFdfjSUO4vafQrHg5txafGtYo/M
	 VAM42FMQ6/FChUGEycuscccmpO8IuHKUnNMCZzfzF+PGW60JFdvU9+c0fwzRVNBwEfeTP
	 OYJ6/37mjdl82O782cFhpjY3V8F1nzZxR+1yLb75dJwhYa06oN/QHPAFiuNSNpfD1U9fr
	 feOE8yC2y39nB1I+QYBdsa6rqTa005mpsgroPNigyo2D1rKE1UYSw+ucQylJo8sSxjPMp
	 MQLV4VikmAVCF/4uh0PknEcZQ2QvsJVYyZm4p+HR8ZT7b+l/4B2RWWg1rzM/E4/a4Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592997;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=k5D54WsDGMT2OB4qO734bVhB1y+HZSzTF0xhy9fZEcc=;
	b=194bl/4R77xwrpr2JaNLOgFp1VJJn0UrwOVe4h9OTHtOjXLU/0TuQcEGkalT8Ikqjmq8
	 UEsbdzQ/g/R6OnsarLD+H53TPZAMQ3U3YShTwRFMSIJ+5qpvM8sqghTCvGVPu0pTS6mLa
	 xjj6+QgtisChqCTJtebwvvoy1MdkJQzFIjXP/ak2NtDCQ4LFbmaV7fXebW/9e1UHW1sui
	 /2/1+xACnmkc1hk76hYMB4nF9GRcOqw7U9CDxcA3Ho8bqaMFsNckY6TM4wDNFtDQ87UzZ
	 g4vIVRabJwu7MF9jV/l3oAk7nQIJUp/tHvz0LRSQjPoi5rN6YpcJiJaOMvLP6/nG5jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=1GX1gN51;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB9606B201;
	Fri, 13 Nov 2026 18:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34EB9606B201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=1GX1gN51
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4ql2bdCz51Sn9;
	Sat, 14 Nov 2026 02:03:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592995;
	bh=1y+M3Vl3cjWi9Fg1t0h+wajy2hJKGDRlKOFzjDVVD9I=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=1GX1gN51Mvl+0bMhLOR8s9zLd7YjeFm14wUhksdJgFshcQXW1aNkHwHoJNLywSF3x
	 wxO5ATP8c6RBUxwPb+lPhBQmAz/xnz5Vx6vlqNIDODW/ZR1g8v2YABzyDzU2GEVokN
	 eUHBx3e/uVQVFR0+p8rmkfI0L7xeACK3h6UJ34YALlQNXm0elSmLCmcpI27jRZupeE
	 6O9KMe3wcZWbA/yIi2q8fgsQDSBtvUFPaI3RAV5C4VjOE0j2wK0ljSL1XWieO7jg3y
	 IdqBLHfH1Epovr8xU4/R+gNf2aLXaJx6WGup17t9eOAJBX1ybr0kh7nCGrRyTu0dJY
	 z6LdAosz+oHrA==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6ADI36Rc099932;
	Sat, 14 Nov 2026 02:03:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:08 +0800 (CST)
X-Zmail-TransId: 2afb6af750dc465-1a3a6
X-Mailer: Zmail v1.0
Message-ID: <20261114020308683js-X-SJAOfZRKfymSA1ks@zte.com.cn>
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: 20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn
Date: Sat, 14 Nov 2026 02:03:08 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAyLzVdIGF0YTogcGF0YV9idWRkaGE6IHByb3BhZ2F0ZSBob3N0IGFjdGl2YXRpb24gZXJyb3Jz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI36Rc099932
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:03:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750E3.000/4jR4ql2bdCz51Sn9

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
-- 
2.27.0
