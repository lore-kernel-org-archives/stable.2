Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246032;
	b=hOMFEQORd521hj5l6R19vbO3BnspLOtFjk3ItgZGf/uYuS8UvxtOw2bk+ium2XU7NYUg
	 RTwcmlquBHppJQMCy4vQND8/wD0Uv33oZBxTirAd9X2P9ZquWCO7Tf381+jNPtaLqkBZL
	 Rnyk3eENfVSzs1V5wG5r6lDVkBXBjfeLzTE413UIK+dANwr/0lFvUzutzg5YwcwPwg7gD
	 g1rhFdWNhQmq0oqZmmnW0tzAuF9aPiDueyYCuxC6FSPeEpto/ZEpkhxZJZr4XiNuN5r07
	 Vi2qeAf8kNtcbeemw5oEsxrVC3VgLOdNwl0rmhaUYlhRaiiBXN98IbKHiGlIb4JCeZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246032;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=4EvimmkLbEENi9mMSmhBHB4VvqJZ5Y7K64ru9liOtoY=;
	b=zghfiG0nIsKjp0jdYEstKy3HzjcVtNIcj/Go8MlZN1G8/LEJlePMmvrlL944UKlarV/b
	 +gh/Dju7er+cfqs5PcxJZ6veOpwF1OXgURSrFkGbXzUyOfRwvnH2wEUJWtr0OWfxd6hU0
	 PPIHZE6QYiDG3YK7eKxkkq9VIJGuebdbsKGjjmBSnxAEBD4F7u8ovnjl2MioBGTW4lboq
	 LbPym7v/t32tT/8vcqDi6062eopIO8TAcEmxNkNShXMueuSBaAnnWct+HJRuBSd5/xfw+
	 qyIAhiph4ZfHAurQ3BjCovZk9AmDf2yIg3Thiy19CvD17E5gYzJSxoKUcgRAEl4Z+Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fkeqOZpE;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CC606A322;
	Thu, 29 Oct 2026 03:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803CC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fkeqOZpE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4E
	vimmkLbEENi9mMSmhBHB4VvqJZ5Y7K64ru9liOtoY=; b=fkeqOZpER4SizIoayk
	P7iZxjXd/+qUXdzCF0VAcUkOHJZHUzuCcUaBEKOXtf1hOSklIyftwboWY0FZeIpR
	izJAY+9XLmoPDz/jT5D5tCUAE++8b1OSLb06xlTtFpwM30P5qP7cZZbGcbq+o6N6
	5duH1wYS4uzCwbdfWdfG5W3DU=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S11;
	Thu, 29 Oct 2026 11:53:06 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 09/20] riscv: acpi: validate RINTC entries before use
Date: Thu, 29 Oct 2026 11:52:40 +0800
Message-Id: <20261029035253.2333852-10-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S11
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxKF1xAryfCr1UGr1rZwb_yoWDCrg_C3
	Z7Z34rWr9akFW0qr18J34rurW5Kw1fAF95Cr1avrWUGFn5J34aqrZxAr95AryvkrnYgan3
	Awn0k39F9r42vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbgyCJUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQJMhmriwyLj-wAA3w

The RINTC callback reads flags and other fields from a typed MADT record
without checking that the complete record is present. A truncated
firmware entry can therefore cause out-of-bounds reads during CPU map
initialization.

Reject incomplete RINTC entries before accessing typed fields.

Fixes: f99561199470 ("RISC-V: ACPI: Cache and retrieve the RINTC structure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 arch/riscv/kernel/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index efd52a5d05b5..9e0658c6a869 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -171,6 +171,9 @@ static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsi
 	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
 	int cpuid;
 
+	if (BAD_MADT_ENTRY(rintc, end))
+		return -EINVAL;
+
 	if (!(rintc->flags & ACPI_MADT_ENABLED))
 		return 0;
 
-- 
2.34.1

