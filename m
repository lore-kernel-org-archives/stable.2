Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163676;
	b=wN4hhzA3TQe6rZoydHdJhTPAdr1F+Asr0mxhP0/sRtfKNNUkOkUPEKAZKOTpPRLRtqr/
	 4LU7jUwDHg9i3uMzRsJhwJwREfz0MIua/QoMg9PM4zeXYixvTpkSid4a4oCq9ZL0kYRaH
	 jveGR0jypufPpycIV9Q+21OMn8tWOyOvZm/t+Yk4iaiqM5hI8Td7kNjTkqIAnMDNxEw3P
	 oxczcTmL0OR8WdFsd362Q4QD0fjB1YTj450vUL14aUQcsSaku9kCsbQSszIglqrGDoj4D
	 nGRZGeh5FJmbBpIrp6nT0JQ/x5DOJ0CkCT0rgcNU2r0SpwKwBq/KZqwyfzw+9nf7xlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163676;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=AC7iRAq5Yweq3ZZT8Va08ClThxzpcnLcDHG2orGA75g=;
	b=Zpx7GgD4iKeLMbIpW+8WW7RLVz71TA3ldgLjWD3VixxMYslh4k5AVhVvz8MG+GoWB55D
	 qDMLfxDshX0iMEp4f5PLowklrYJtuLeshvN3FqKu6lbWgd2xzXmzdoSvaCan8xVGBGYCa
	 y2Cuqlwjgffz9kTPHCVOhFFnJs2k+J/4XaRRsf0XS7wond1TieiBKnfyw9iV34H05drZD
	 rqydvuo2WWGMWbPvNOB+NqMbO89538JFr8pSW2gE5XWp2LEadQJ7xOe7z2cazZs0/1GOM
	 sZ1DbGfLQ6dju1TYq24d9P3I9tyR9v9ocTOdPznZwdRw9MKjXh37UcdovKFhmukgnOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FwunI5mN;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95B606A321;
	Wed, 28 Oct 2026 05:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF95B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FwunI5mN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=AC
	7iRAq5Yweq3ZZT8Va08ClThxzpcnLcDHG2orGA75g=; b=FwunI5mNOLfAXtRzaX
	jqp5pWL7x3tZqnQO/Y/hJbjJWj3fOE5sXYVp7CdzXpjiHgKiq6eeJD5qewDes6iq
	zxs3OGuw3lnnORKTtoliSr9vnq+5psmUKAivSWwvr8QoItekl3aaj3nTt1VOWcnk
	1Mduv2gaI/RaAYNDLqPj/qH+k=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S9;
	Wed, 28 Oct 2026 13:00:49 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Liupu Wang <wangliupu@loongson.cn>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/12] irqchip/loongarch-ir: validate MADT MSI-PIC entries
Date: Wed, 28 Oct 2026 13:00:34 +0800
Message-Id: <20261028050039.121080-8-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050039.121080-1-yaojiale02@163.com>
References: <20261028050039.121080-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S9
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4xZw13WFyfCw1UZrWrZrb_yoWDZwc_uF
	129a9rGrWjgr4UGw1xtry3Zry3tF48uFnY9r4Iyas8J3s5Zw13Zr17Z34fArZrKFW0vFn3
	GrZ8ZF4Syw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyCJPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQGTzWrhgYGZYQAA3h

The MSI-PIC callback reads the message address from a typed MADT record
without checking its size. Reject incomplete records before accessing
the field.

Fixes: 71619266e0a2 ("irqchip/loongarch-ir: Add IR (interrupt redirection) irqchip support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongarch-ir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongarch-ir.c b/drivers/irqchip/irq-loongarch-ir.c
index cb4ad34da058..111173fc4612 100644
--- a/drivers/irqchip/irq-loongarch-ir.c
+++ b/drivers/irqchip/irq-loongarch-ir.c
@@ -481,6 +481,9 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header, const
 {
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
 
+	if (BAD_MADT_ENTRY(pchmsi_entry, end))
+		return -EINVAL;
+
 	msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
 
 	return pch_msi_acpi_init_avec(redirect_domain);
-- 
2.34.1

