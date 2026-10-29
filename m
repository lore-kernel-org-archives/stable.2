Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246016;
	b=04NWjLDJm0YPcxRCIJPxNfCRBCDbz+Xf9uCkLFAgzcsBi+S/D0cbuprLiH+tBVGougdK
	 jnz+qKtpNIMbpqeiD/fw8o0mUVaiKtSxGkmPyqVkDSgtbdaCyNmRAE7OtMLzcyV+Y77sy
	 1J8um2gsrSUFvj1sufGWobpAHl+542ctadM6hOnYA+nOoAJ7zhX0yCvgkH7Olj4LoUYVO
	 yfXtypZ/OkovbhWaYjn2Ksb2e2vV7bvAZtxbxWbaMFRbL4bdEFty5t9TYIqGgoRwuHd7d
	 IXl7OuDmfM1K8hh1/jseb+1Z1QOeGdWjhYk5RG77N+jIQ/rQsfvurut6yL/mq27XklQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246016;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0eL2bzd9HSLFKqzLgVouTcXW+mDlC5BCNips3rCkPwE=;
	b=WrdE+I4MXdgMLZSeExQdIb8j5REcqN9yEKAGvh1HRDdUpiCR1WxHGoB5+DsF9+L6iFNl
	 n8cKocmNBRs7jjURmat0NdkCLMNLqcSVk7AigmeHYf5d4hyD3JYU6NMWypjm6EG++znBl
	 woRpEvn0KekaIRQiWefV4qchkK/4YMILAQ6Ub2S5EgnQvOU669WqjgmjRuFXIKrnA06Kc
	 cQhWRWIruRmLPe9V24C6juu60TaM4oIYYhgKu8d5o29e0Y9WabG22mDOIKvv/Wk2cOq7E
	 lK0fVtROFKfizEiagY1Y8bbMgPHF4n/HOeYX8/hW/MVbidmmttz1MHqYmTU5P+DRdkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IqQKsNof;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49F606A32E;
	Thu, 29 Oct 2026 03:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE49F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IqQKsNof
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0e
	L2bzd9HSLFKqzLgVouTcXW+mDlC5BCNips3rCkPwE=; b=IqQKsNof3NMoHHLxd2
	1c9vUv7A3OSdVkHqs0pUy0MwvS29GJMCCe2BJy82hp/gbtgO0Fl2NGH+jrJNhLjC
	BUm6tWbCU5Hw4QKhbiq0jr5ss2wAH+WDbjUgT5+ir3KPSKDVomaYJiLjCK3JlMG7
	nitMT/sbH54H9ZxR4o0r+XKFY=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S7;
	Thu, 29 Oct 2026 11:53:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Marc Zyngier <maz@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 05/20] irqchip/loongarch-cpu: validate MADT LIO-PIC entries
Date: Thu, 29 Oct 2026 11:52:36 +0800
Message-Id: <20261029035253.2333852-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029035253.2333852-1-yaojiale02@163.com>
References: <20261029035253.2333852-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW3JFyxXr4Dtr13GF17Jrb_yoWkWFb_uF
	1a9asrJryj9F1Utw1ktr15Z3sxt3y8uFnY9rs2qFn8C395Jw1rXFsrA3yfX3y7KryvvFn3
	Gr4qvr1Syr12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbgTmDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x9LhWriwx9aQgAA3y

The LIO-PIC MADT callback passes a typed record to the controller
initialization code without checking that the complete record is
present. A truncated firmware entry can therefore lead to out-of-bounds
field reads.

Reject incomplete LIO-PIC entries before passing them to the
initialization helper.

Fixes: b2d3e3354e2a ("irqchip: Add LoongArch CPU interrupt controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongarch-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 84ce24889488..6185825477f4 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -119,6 +119,9 @@ static int __init liointc_parse_madt(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
 
+	if (BAD_MADT_ENTRY(liointc_entry, end))
+		return -EINVAL;
+
 	return liointc_acpi_init(irq_domain, liointc_entry);
 }
 
-- 
2.34.1

