Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245996;
	b=h5ZLJnkpkE4HdRRwXV2LVpkEeQN0gUQADEK7I2mDVCXOvAQvHkOQ9CIkPMOMahT1NDzL
	 nqIeiTD2Xn5ohtufeJFtagrMrEIxUjn1GhO6/8WQJcNOCIH2YCO7Qji7dRz4jUxs/8e1w
	 NLc8kL+sb6ICszA1jOHWKLH+TP/9QdJkHM8RFrIarHNgYOdaHa9lBn++aTe17rUvOqUe0
	 eUy7zoq41vdTRHjJq0aAuqeEHnP14o5f06JMdO/o4HuNSHQaDdj1GFQ89p8VkFuzpS55d
	 GYv++MpIgVT3dKUvyvfYAyIzFTkfhQAQ5/t5YER0KcmhVUGPL7ddTcbGemx7GSoT3eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245996;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=hIJqIH2TSbmK7oxQQb57cDQpLyotV6/gNsiGp7etsrM=;
	b=j5gRv7K/ajhj41Jn5QTDrHgr4GSW+khzSbxCntiXPZvjcjh6kcf7SESqJXfnwMXvAZ/O
	 RjGhfy4ERUChyPk06reMeVkJuTB2dooJkY99IDM95ygm5rM3jLPENFWuuUhm95o4n52Ni
	 PMNrCJMXaBQWN9pylI/Q1J/bTwiRvNwBgJSIzAvBNqZg2+vnkQ+TqvGHaxdHEE1gfJaB9
	 rkjAsZoABTrzjcr668zJRu841FlaGhvWSIYYb7USSO4LlX3uYbyAb2Es734MGVkuJIj92
	 UYINSyBbpNmDaYLZp2rpf2McvruLKchm/mL1JwkqyxTh1RxJyOBvyWDau08SihtycDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=adlXg3PT;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFC606A31A;
	Thu, 29 Oct 2026 03:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=adlXg3PT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hI
	JqIH2TSbmK7oxQQb57cDQpLyotV6/gNsiGp7etsrM=; b=adlXg3PToRtCVJPOvd
	4SyDtxvumn+/n7fcuQuJDdIanhqjS/7TaVogheE089itlhuBv3bHWIVgtpxa5ThP
	CFcSg29u5akRog+f60V5jJKA4gMaUNbsFPcfzXI5nwHJFGqq6oPlzbykooBUD/U+
	gvpa6G+tcD8iOG0+a6OqgP9h0=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S3;
	Thu, 29 Oct 2026 11:52:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 01/20] ACPI: irqchip: validate MADT entry bounds before probing
Date: Thu, 29 Oct 2026 11:52:32 +0800
Message-Id: <20261029035253.2333852-2-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw13uFW3uF13GFW7GF1kGrg_yoW8Jw1rpF
	9I9Fy5tr43trWagw1xZr4UuFWrWws3Ga42gFy7G34Fv3W5GFyruaySk3y2qr1UJrWfWF42
	v3srtr98CFW8J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0g4fUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRtKhGriwxvjBwAA3s

IRQ chip probing invokes validation and probe callbacks after the common
table walker has only established that a generic subtable header is
readable. A malformed length can leave callback field accesses outside
the MADT.

Validate the generic header length and ensure the complete declared
entry is contained in the table before invoking IRQ chip callbacks.

Fixes: e647b532275b ("ACPI: Add early device probing infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0b17a7e51956..10e8d736f44b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2896,6 +2896,13 @@ static DEFINE_MUTEX(acpi_probe_mutex);
 static int __init acpi_match_madt(union acpi_subtable_headers *header,
 				  const unsigned long end)
 {
+	unsigned long start = (unsigned long)header;
+
+	if (start >= end || end - start < sizeof(header->common) ||
+	    header->common.length < sizeof(header->common) ||
+	    header->common.length > end - start)
+		return -EINVAL;
+
 	if (!ape->subtable_valid || ape->subtable_valid(&header->common, ape))
 		if (!ape->probe_subtbl(header, end))
 			acpi_probe_count++;
-- 
2.34.1

