Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732846;
	b=3zOjVjOJFICk78wHMa/u4lWDc5VmpZ3pdvy2t7NCbB790v8eNEwTCwQBBClbjPpDP/pW
	 7fGSokFsTJn2bNOZeI2MoGKT/SiX/tm+7l3/XEvS6ILoWMF9loa1niOJrLWfYRfhmKgpT
	 6YlClV4hXPCErRHNWt3c6J9xAfDcuRz6UlLc5YqWSBsdM8lQDEyWHZSUQI/tjiWhnLHnC
	 CoLSkgb8dVbIUKfKuy4X6f17cuiJ/R3igGgOnBEnp8FSEMX6SYK6/G6yqU93dkjbZmMLH
	 nkvJPi+wbs10u0Vbk3/7wtiym7ogVm47xq/JsTAGQQAMSGm0LqH+oP3gFI3dt/Pg8SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732846;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Iy1bK4+jBfc9gJ5+O/X5fpt1iKIpv9Dc2QHfUpTN6oY=;
	b=4kZY6z9s4RMCS1NyJ5P1UPBqOKxd3yCvrBdLrnCm06CcoT6dF2XQ86Ttd54aL0MNxqA3
	 G0/3vfTdOyS8rdekNteQv/NcaVx5tLrT4yvr4pb9MQrJj8xQ0ukMdfWqieV84ucCobX0y
	 U7JKgdCV5rBVC1a0t3NdLerbpvqUJpgI0PYgUv4hiH+gVvyx0CHQrYsNPcaPRlNZ1qdkM
	 tSC5JWKWBRJSJEJcSDhsETlcxKGqWkgBtPUOIDXZbJq1y3aC1pTneK6TwpB0Q9cu8zafM
	 BFELIG1s1jqAXAp9ezRqyRBG+Ux9Dj0kQN6X/2sTV67PPAQ+LGZARKa1biCXmurCluQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2C606A332;
	Tue,  3 Nov 2026 19:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF2C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykL5mHxz5B0rZ;
	Wed, 04 Nov 2026 03:07:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7Aad024105;
	Wed, 4 Nov 2026 03:07:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:12 +0800 (CST)
X-Zmail-TransId: 2afa6aea30e0aa3-d9fe2
X-Mailer: Zmail v1.0
Message-ID: <20261104030712986Mq-di1Oh8Kl1WqW3R0TQW@zte.com.cn>
In-Reply-To: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
References: 20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:12 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHBjaS1lcGY6IGZpeCBzdWJzeXNucW4gY29uZmlnZnMgYnVmZmVyIG92ZXJmbG93?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A3J7Aad024105
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EA.001/4jJykL5mHxz5B0rZ

nvmet_pci_epf_subsysnqn_store() passes the length of the configfs write
to strscpy() as the destination size:

	strscpy(nvme_epf->subsysnqn, page, len);

The third argument of strscpy() is the size of the destination buffer,
not the length of the source string.  The destination is
subsysnqn[NVMF_NQN_SIZE], i.e. 223 bytes, while a configfs attribute
store can carry up to 4095 bytes.  A longer NQN therefore overflows
subsysnqn into the following mdts_kb field and past the nvmet_pci_epf
object, corrupting the heap.

Using the write length also silently dropped the last byte of the value:
configfs terminates the buffer after the trailing newline that echo(1)
writes, so a normal write stored the right NQN while a write without a
newline lost its last character.

Take the length of the value up to the newline, reject a value that does
not fit and copy the NQN explicitly.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with configfs and
nvmet-pci-epf; the attribute store does not need a PCI endpoint
controller.

Writing 230 bytes to the subsysnqn attribute of an nvmet_pci_epf
instance runs past subsysnqn[NVMF_NQN_SIZE] (223) and overwrites the
following mdts_kb field:

  unpatched                            patched
  write accepted                       write rejected (-EINVAL)
  mdts_kb 512 -> 4276545 (0x414141)    mdts_kb stays 512

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a8df176c1a57..38c210cac961 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2531,15 +2531,18 @@ static ssize_t nvmet_pci_epf_subsysnqn_store(struct config_item *item,
 {
 	struct config_group *group = to_config_group(item);
 	struct nvmet_pci_epf *nvme_epf = to_nvme_epf(group);
+	size_t nqn_len;
 
 	/* Do not allow setting this when the function is already started. */
 	if (nvme_epf->ctrl.tctrl)
 		return -EBUSY;
 
-	if (!len)
+	nqn_len = strcspn(page, "\n");
+	if (!nqn_len || nqn_len >= sizeof(nvme_epf->subsysnqn))
 		return -EINVAL;
 
-	strscpy(nvme_epf->subsysnqn, page, len);
+	memcpy(nvme_epf->subsysnqn, page, nqn_len);
+	nvme_epf->subsysnqn[nqn_len] = '\0';
 
 	return len;
 }
