Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732850;
	b=bWbEKaMdssLsrl1SQ0ThUeLkLxd5ZNEVdPOM+E/WSx3pgQQ9gSTH4hRPUHGQ11yr/Wq4
	 Hf/C/9TKCQO4OOAbwAxmttYqTAQfYWokj1Q4S87EN9FGvDNAaSKWYKMP7Ct8fXGi8+iDn
	 shGinnOtRBGzrlbP3u6FvwTjPXBdC3hd28LRl84nGWmaQg1cIW7/cYkU1GRGgsjJVDpur
	 iguPGDo6tzYaW2750w+EpcLh1wHtVgbOL0EWVv7Po/SIfI4vzQfWegW9UW7A+o7/jTI4m
	 SKYlNDfGPh3pO9/NVR8dhhBmvFq4q2gHC4FEmQHYjEckikDIgmAI5O+rHRkSVXok3VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732850;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=uk97Gt0Jv+LwDSOVzveSlW80YqNEq2rrsDMgaor32B0=;
	b=HdYY4Ff7B3+wLS4zNriZ+fp+idgNewutPgML6oVbr3zFvB/XG2KOaqAITa79ykSbCLNZ
	 K9Af5XMCavbT7nh97ScyWd7RXEwp0Xf7K+ztSeT91hsC0wm1aVokcq5VSDewDdUiirokJ
	 ONkpmTQVqHsUXsHJLXnIjN6LDYtem9l/iTQFatILpeyugC55nzIcn8tZy2UhaU8V3N4rO
	 qcS9lZYZTHExR/d/XxY+vgxXa6+Nu5O9zQ93ruSkaja5FOQSrn53EpcNiTjtJTE1QCuj+
	 sF2sNnNUpUvq+aoz9nnG59z3f5al6VUE/qXg4gSKjPG18KEHglmTBUaHznpsUlToBSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC7606EE82;
	Tue,  3 Nov 2026 19:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AC7606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykT1z91z8Xrr9;
	Wed, 04 Nov 2026 03:07:29 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7Nir024435;
	Wed, 4 Nov 2026 03:07:23 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:27 +0800 (CST)
X-Zmail-TransId: 2af96aea30ef5c7-d6b09
X-Mailer: Zmail v1.0
Message-ID: <20261104030727274tgEBQGKcKOwkQ_xIxqIhN@zte.com.cn>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: 20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:27 +0800 (CST)
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
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IGJvdW5kIHRoZSB0cmFkZHIgYW5kIHRyc3ZjaWQgY29uZmlnZnMgd3JpdGVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3J7Nir024435
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30F1.000/4jJykT1z91z8Xrr9

nvmet_addr_traddr_store() and nvmet_addr_trsvcid_store() reject a write
only when count is larger than NVMF_TRADDR_SIZE (256) respectively
NVMF_TRSVCID_SIZE (32).  A write of exactly that many characters is
accepted, and the following

	sscanf(page, "%s\n", port->disc_addr.traddr)

has no field width.  configfs terminates the buffer at page[count], so
the scan writes 256 characters plus the trailing NUL, i.e. 257 bytes,
into traddr[256].  The extra byte lands in the following tsas field of
the discovery log entry, silently clearing the first TSAS byte (the
RDMA queue type, or the TLS section type for TCP).  trsvcid has the
same off-by-one with a 32-byte write; there the extra byte lands in
the reserved bytes that follow trsvcid.

Limit the scans to one byte less than the destination arrays.  The
count checks can stay as they are so that a normal newline-terminated
write is still accepted.

Fixes: 9ba2a5cb8896 ("nvmet: filter newlines from user input")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with configfs; no RDMA
device is needed to set the port attributes.

Writing exactly NVMF_TRADDR_SIZE (256) characters to addr_traddr makes
the unterminated sscanf() store 257 bytes, so the trailing NUL clears
the first TSAS byte of the discovery entry:

  unpatched                            patched
  addr_tsas 'connected' -> ''          addr_tsas stays 'connected'
  addr_traddr read returns 257 bytes   read returns 256 bytes

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..8a6968b014c6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -150,7 +150,7 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
+	if (sscanf(page, "%255s", port->disc_addr.traddr) != 1)
 		return -EINVAL;
 	return count;
 }
@@ -242,7 +242,7 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
+	if (sscanf(page, "%31s", port->disc_addr.trsvcid) != 1)
 		return -EINVAL;
 	return count;
 }
