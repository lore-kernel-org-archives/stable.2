Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246019;
	b=ytJmeKadmmuIFEfn9qhHNfibDNX2eA2PGW0bB4aSjUB68yOa+vCLu51CPeDcRntiZmXH
	 ijpkdpQ/ihjcEoSVMuT285sCyQX+DSVVbattw2utPugsochU0/apBFORaQoOR2sgjt/LA
	 natYrgnTslCZCxxb0Chfexup/qytB3RSdXuexJscnD7p8Yyn6J7eUTwNAeN0E1OXmwx+F
	 oqDFa5N399aQ5O+3EbYu3vgoSXEiS8iKr3mYWxEuK5yTUfpQXfb9E6I2cYN/SI9bRFzYn
	 FqzVn34PhwVBxMVDcVqB2IfbUZGCm8mQwGPDX00sQl3olHotchz7kKp4mTxt2ZhmjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246019;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WtpjjH3vtE/54r/970fSiN4Comd2TOvSsRScFTJeCcM=;
	b=mvU16GsMY7G6H4w484FiI5I33fkdlkvS5KY1v8GiCuDYt2CkFqnjAyT7EnTHm7GBFWHJ
	 ip8R/LPEqgIQwrYuY0kKnccitd9cg3Hq8iG7Z0zSP2e35EAWAfHUIiYJnuqrQWDrfkD8W
	 xtpN7uEnxufMHpSnLkFZSZ8YMha7D90NasbayGelQOJWoru6wGrTQCbHcCNg1SG1wGfwA
	 tyZwFP9PGcF8paLXnmwvC4ksiOuRTRTwLx/XqZHKH7eKgDxvvzovnSr5R+pIXlzO4uyBn
	 yEoass3LXImGcyfKuvMY9YgWODgpQHmgw2Gaaa1uZH8+3ojEHU02PDMvH6b/KM8pBdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z4E54OUs;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA4606A338;
	Thu, 29 Oct 2026 03:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79FA4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Z4E54OUs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wt
	pjjH3vtE/54r/970fSiN4Comd2TOvSsRScFTJeCcM=; b=Z4E54OUs9YrrYCP/L4
	dO3qGwmLGFBt2CHcZPQ7VNPBYOID/2/M07BE1PiZHPCEzpYJMI4fRv8ryTbRsITF
	3OsXfBFPEuG0PGBAgP1PO/13mc0psy/QQ346WCZNOOSz1eREn8MSVzVLiT1QcWHe
	UjAJD34aluVWqpaNFqko+qw84=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S12;
	Thu, 29 Oct 2026 11:53:07 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 10/20] irqchip/gic-v5-irs: validate MADT GICC entries
Date: Thu, 29 Oct 2026 11:52:41 +0800
Message-Id: <20261029035253.2333852-11-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S12
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF17Gr13CrWrZrW8Ary3CFg_yoWDWrc_Cr
	yvvanrJFy8uF48Kr1xKr15ZrWUtFWkurn5uF4IqFn5GrW8Zw4fZFsxZFZ3Aa18GF4SvFn3
	AFZ0vrsa9r1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyEEUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQNMhmriwyPkGQAA3R

The IAFFID parser reads fields from a typed GICC record without checking
that the MADT entry contains the fields it accesses. Reject truncated
entries before reading them.

Fixes: 35866efa52fe ("irqchip/gic-v5: Add ACPI IRS probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v5-irs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index 9d60f474aa4f..4e60a1caaba5 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -891,6 +891,9 @@ static int __init gic_acpi_parse_iaffid(union acpi_subtable_headers *header,
 	struct acpi_madt_generic_interrupt *gicc = (struct acpi_madt_generic_interrupt *)header;
 	int cpu;
 
+	if (BAD_MADT_GICC_ENTRY(gicc, end))
+		return -EINVAL;
+
 	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
 
-- 
2.34.1

