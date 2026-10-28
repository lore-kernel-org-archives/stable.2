Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=tzU8GJ5K5GeO8r21pQdnU7EYBHJXCxIOHIyN+t9oT2mGPxEnLAKUe4pOe3/p7VctxX5o
	 XflgUOLI1tELAsOBu8vrB34HuFk2daPCo0vDIcEzbQ8qSPDdClfdjYOhOs92i/TFz3ACr
	 BukHnyJfglZiR/ofi/tmuSz08FF2fYJbXhYMMkHRRub38+F4GoLkgnNQJYTmzI/szhuqt
	 lw/3Q6FK+vR5m5DNgx4SpE26IVppUz+x8OLQh68i3kzggqT9ACEbn+HQ0fn8Bq6ClNhC/
	 wuKj/HXIjWIVUvr1grmAAGLhMPQt95JZxQeoilJnIxl0Ut+U8MK1xxMyd1wd2azr/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WtpjjH3vtE/54r/970fSiN4Comd2TOvSsRScFTJeCcM=;
	b=SL+K60PRfJXiDWRXiLbmd1AgH9JEXyH1hNXVnBDuWUiuo00WoXN8cgmmkpoCEXzYl6de
	 o6ousJIIvIxax5jN2n6kcYmjFzqJ421n4ApAqnjTNGBtLJQgpAb4bqVKNKwvJK7Bmy3Ux
	 pT/znnnfJmEkFwJMhS3W5XWw7E5LPA3a4SLWcyk2DQw7p5HdkE017R3Of1MYZ/919Ak9Q
	 wJOseWttXs1ZgWy1cct8Zz9Xz69nfH9KThi551ZH5+f5nkDKmWYxHt4VXf9T6CISo1iro
	 4X5CHwA4tuZQsH3BDAq8oyPriaicxLppJGgg/7LtyQTiOMBgzfKD+/MvGJjM0qP8lWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YLPgo9+o;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF3606A322;
	Wed, 28 Oct 2026 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECF3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YLPgo9+o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wt
	pjjH3vtE/54r/970fSiN4Comd2TOvSsRScFTJeCcM=; b=YLPgo9+oow6/BR/t4v
	iEn+v8UaieMkw4jXc11Ky+HrUtZsOzURQz/fwPeOqUsZ3k16M9g6DkK9q1J/eyDT
	1YHQL8ydSok/4yHt92ndOGIygpTMmNmQOyBqzEZ/OzN9b/qlz5/C6McP3NxiLTCo
	s3FDPu31Ocz+pkAnhQz0fMmAk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S4;
	Wed, 28 Oct 2026 13:00:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/12] irqchip/gic-v5-irs: validate MADT GICC entries
Date: Wed, 28 Oct 2026 13:00:29 +0800
Message-Id: <20261028050039.121080-3-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF17Gr13CrWrZrW8Ary3CFg_yoWDWrc_Cr
	yvvanrJFy8uF48Kr1xKr15ZrWUtFWkurn5uF4IqFn5GrW8Zw4fZFsxZFZ3Aa18GF4SvFn3
	AFZ0vrsa9r1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1gyCtUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B2SzGrhgX1V3wAA3O

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

