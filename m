Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593966;
	b=tpZZWO/qYghb9+3L//H8Kz3Cc1mrMpDdkzhLs0MeTcWDmgN4F8UPx5Fx6K4yIrsJ8V8t
	 8R4K4d2DD2+0L8i4+8WMXyap4YZlYD9Y5wPBUG6oxCL9W++oaOZvBSRVBSkWvv5x6GkcY
	 mh1coL3JLGcnQa+jEwZZR0/wN6w7k7drIgXeOBH3yqcwIvimsZNtBAKPVd7EfbBIQPH3Q
	 Kl/cXTqjW+80y6vv7yP8aXpt8+3b92pj1gP8FVnqyq35ewMmfaFiZgezr5YtwHebOCoqm
	 W8qRRjm0n2socxzPJJ2gdjd2tbiRMe4LDKCjvuQR6BTHmZfJmlqx0mgrpvfLII3mE2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593966;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=tcgNMAMAaTNAVmIOyjLzl3HehOwbhta2Y5yaYhTlXpk=;
	b=wCBFS8HYz8dUv1j4bUgPrYya1ygGA47DiMUf8fV9Bo04lhUgn4pu3K/ZKgsrX9i1MUai
	 zEMpq7Mb0imSRG7TmSKwDmgdcV2B+gG1019gf9EdphM0e/7qFHEYQoPqLNlhVsNSIPlmo
	 XugJkEmcMLktYikRJWnCl9ENGwETK0aHs1w7TLvuoAGjakQ2HXLhndj0hQzJjDLh87u2k
	 mca7ZDPAU1dOR+6RYC2nDDvZNWqR8hqewXz7u9YwIdsUtYow/UWjsqcHjtuuKejZXpS6u
	 65OjhPdq8MOTwJruw2EAFr/Rz63d1Z3XaRlYSulujcv1qPD1ZMPI6D8tlOuW0KPpnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kY1Tucdx;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAC60A2604;
	Wed, 21 Oct 2026 14:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDAC60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kY1Tucdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=tc
	gNMAMAaTNAVmIOyjLzl3HehOwbhta2Y5yaYhTlXpk=; b=kY1Tucdx1CimJKCAbS
	DNyGVC7awxR/OgzRpIO7XYUOyMPl9/B8NGFtjfDhSwL2aK9ZktH/Dz1Lye+i6JCv
	3lxkclSRl4BsAjNl6KhOTU2prr9jJ5z8ciuPkdA+xUZDbPCsvs69CAoBguOmKoNV
	rP88HRFvrMW02de6eeEfYTQuk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S4;
	Wed, 21 Oct 2026 22:45:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Hanjun Guo <guohanjun@huawei.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/6] irqchip/gic-v3-its: validate MADT ITS entries
Date: Wed, 21 Oct 2026 22:45:20 +0800
Message-Id: <20261021144524.364143-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021144524.364143-1-yaojiale02@163.com>
References: <20261021144524.364143-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWDGw15Jw45Gr4UGF47XFb_yoWkArb_ur
	yjgFn7JF4DKr4UKr1xtr4UZryY9a109w1v9r4vva95GrykZ3W3urZru3s8Zr4DGFs2vF1f
	GrZ8Cr1Skr13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8IAp5UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgkHQWrY0AlSxgAA3+

The MADT ITS callback reads the translator base address and ID without
checking that firmware supplied a complete generic translator record. A
truncated entry can therefore cause out-of-bounds reads.

Reject incomplete ITS entries before accessing their typed fields.

Fixes: 3f010cf19732 ("irqchip/gicv3-its: Probe ITS in the ACPI way")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e9807af23537..485a790e4856 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5725,6 +5725,9 @@ static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *header,
 	int err;
 
 	its_entry = (struct acpi_madt_generic_translator *)header;
+	if (BAD_MADT_ENTRY(its_entry, end))
+		return -EINVAL;
+
 	memset(&res, 0, sizeof(res));
 	res.start = its_entry->base_address;
 	res.end = its_entry->base_address + ACPI_GICV3_ITS_MEM_SIZE - 1;
-- 
2.34.1

