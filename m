Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=pKZSyNEy813TkaL3HmUaH8qLMzrWqwB+55pR+FcHfpliYhDUODglhoOF0UMD6eSDgjX8
	 rqPf3yunkGrCJmCEXhEeBKtI/mdVeQKx/ksDT4sx8wJnbeAqmmSwTe4riOdtMwQAkS3rA
	 oJ0lPvhTEM3O96dtjbXpBH8R8XLeY0jhx3RYTyThdIrddvFpu2toZVv9MiLjyZaPaQpJY
	 cy/9rIL34Ohqa6qcD9xgWrRV2i9JHprS5Lqz7Od6ldL5LBO6F3PSuXo7nz19J1Op+unsd
	 XP/kSOquz9KfpF1PwXoIoI7J5eqo4uphRhynI4NFZIRlHGPfIAH9kHuJkc7Tf7sXx6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ymr+0yCui/4JCxO03GbrK6xdmJta7Ectz0jTg964RpU=;
	b=mWVF3Gl0tHAYXSZOdwI+9YWvhzNqccLNUuruiziyxzT4454kj3szn2L+m5TC86waqU2r
	 EvwsOw5Ced7HyywsOWk9qIDGUPvwyyXpxV1jiUrXNC2LuP4aUBGdhQwB2gcz8H7qdzmet
	 YWtv4CcQ98pMfBH2OkZIJHVPfceh9n3D05SGexAYrBh5kMMpDdE517akc9En1z8OgDxK6
	 EbIGmjxk/+qfEj1vG4+a2TcKwvxKjit5cMCpGo/9II9HXb+PG8BpB40rrWfT49d+yFvjj
	 oc7eEu5lc8mBwKe30xEp7PEvJ6D6o4BJr9xX0Vcw5bqSDtelGJMZVKVw0Ex/ynox6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oZffLyjd;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB5606A320;
	Wed, 28 Oct 2026 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5CB5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oZffLyjd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ym
	r+0yCui/4JCxO03GbrK6xdmJta7Ectz0jTg964RpU=; b=oZffLyjdgY/FBIc/5g
	9vihCjkkEGQHHBSvZsId5W+o45hv39GVpliQ/VgT3ke9WB0ZLg3ioaPrdUWxlQBr
	nMOfGHNIHY5g2KUQXDIY3NMKC3tT9J77Fmis5MjJYInXllyKcFMV8yxlc+bzKFj8
	HI2JHu0GoA/eTNGRnDkANByh4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S10;
	Wed, 28 Oct 2026 13:00:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Marc Zyngier <maz@kernel.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/12] irqchip/loongson-htvec: validate MADT BIO-PIC entries
Date: Wed, 28 Oct 2026 13:00:35 +0800
Message-Id: <20261028050039.121080-9-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S10
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DKFyxtr4rWryfKrW3Jrb_yoWDCrbEkr
	nFvrZ7try8uF48trySyr13ZFWaqw4093ZY9F4SqFy5X34rtr1rArnrAr4fWF47Gr1SvF93
	GrZ8CryFkr1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyCJPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AKTzWrhgYJWZgAA3U

The HT-vector cascade callback passes a typed BIO-PIC record to
initialization code without checking that the complete structure is
present. Reject truncated entries before dispatching them.

Fixes: 70f7b6c008b3 ("irqchip/loongson-htvec: Add ACPI init support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-htvec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 75e40ba6069d..725f30b7574b 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -269,6 +269,9 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
 
+	if (BAD_MADT_ENTRY(pchpic_entry, end))
+		return -EINVAL;
+
 	return pch_pic_acpi_init(htvec_priv->htvec_domain, pchpic_entry);
 }
 
-- 
2.34.1

