Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246012;
	b=H24sjqk5lPFj640Dzib0iayUqe+GR0QFIR5wducd66+IU8SSGBod47xy2Kk3xLBfItxk
	 AQZJXZqo91xAsf6sb/eHPEH5BQsjhgHZ5p4wAJPUx5HNQcqjlx2TneJsWuDVZ/ZsrK9Gf
	 t6n3WGDK2pydiFSivCpubJhSRcL7GWz6O0wbML7ht7VjTIVt1IzAh7BBjfztAWK1vyZrO
	 OOWHzC3GEq0O0C/NC9LYQnRHLQVqhM/kkTEKXZgxBoT6R+cl/HzhKQ4hiJQA8oz0upim7
	 Jte302f61i6mfMvM8HmBEedo1fY8Vs67S/9N0G3P8sW4VEbOraQaA97rr7S2ungnU9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246012;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=QHE+UHIk8uhs1bNGgsBBl+NelMRjuvlA6zpwrIo4BCk=;
	b=mH+Efl4PAvmMl/bJjLFyYxQsWbSnQTqHmiNqCZoxDMASScQFFsd8Ln3pp0mYr819EJtT
	 4EB+Besi5UPvuTMe9XTiuwoJdokOl+9MDnP+5YZ0oAuAuzIwglLNBBp4BYng2mjqX9L13
	 LZahOutrgOibv18V10xOB+w0VwbMOjUJt19RgYXkFOvb7QNKhOkzrjoj1sAt9WEXk4/lX
	 OKwUVLo6OTqnt9c24oq+osQ4CeSBnI+otDsshcEzyFvRubPTLCx7TQSMJgANK15XGU54b
	 Mh7CEHIDnySERyihhqknDzRrjqm/+8z0QsrGM2mL6XuuJZmQz7lMHn27jOsVVPvKZHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JEJE37r1;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6D606A31C;
	Thu, 29 Oct 2026 03:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44D6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JEJE37r1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QH
	E+UHIk8uhs1bNGgsBBl+NelMRjuvlA6zpwrIo4BCk=; b=JEJE37r1QVJBjWOjeU
	HR5h0xcHWWHS/jISAb1AWqqgm/JM8FC/kLTZXgQzKZ8KpQC+R+FyjOfNUmc6fEQt
	fIqfEJyXxahn+WylahzthI247JFleqMaEoP0kFdlHzQCEGs7Dv1oAXGZezzkJE4g
	QKb8/tuhOAO2euPZ9r0fHStg0=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S8;
	Thu, 29 Oct 2026 11:53:03 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Marc Zyngier <maz@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 06/20] irqchip/loongson-eiointc: validate MADT BIO-PIC entries
Date: Thu, 29 Oct 2026 11:52:37 +0800
Message-Id: <20261029035253.2333852-7-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww18tF15KFWrZryDWF1kAFb_yoW8XFy3pF
	W5Ca9Iyr4UJrW5Grn2ka1DXFyrZas5Zay7tFWfuayfZwnxXr1UuFyUAFn8Xry0y3y7Ga42
	vr4FqFWUu3W5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UP9N3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR9LhWriwx-jkwAA34

The BIO-PIC MADT callback reads the controller address before checking
that firmware supplied the complete fixed-size record. A truncated entry
can therefore cause an out-of-bounds read while selecting the parent
domain.

Validate the BIO-PIC record before accessing its address or passing it
to the initialization helper.

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index ba6e8480e383..1b90edef5a52 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -454,8 +454,14 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
-	unsigned int node = pa_to_nid(pchpic_entry->address) & 0xf;
-	struct irq_domain *parent = acpi_get_vec_parent(node, pch_group);
+	struct irq_domain *parent;
+	unsigned int node;
+
+	if (BAD_MADT_ENTRY(pchpic_entry, end))
+		return -EINVAL;
+
+	node = pa_to_nid(pchpic_entry->address) & 0xf;
+	parent = acpi_get_vec_parent(node, pch_group);
 
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
-- 
2.34.1

