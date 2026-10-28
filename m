Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=kjsAmxIOa8c2640t1xhVK+72Pk9FVvtd5Llhzelxq13TXImJQP3y3HPA8IGNQRyRpUqs
	 WTlZjLJnUhZfmp+G6Kuh+hnesYm6Wn52q1nr8MAYAAOxrvVZ7/Au6bkxje+T2iBk4HPzn
	 UOxnsMhDYPfILi+p5z2TKKHdg8P1GAF1h62Q4/TlIB/+n5vL44y94L9VgYsw2S/XVSU4u
	 QcvGxd8Zbe8ZMMiZpjtfhy0xv2Xxm1b+QEPptPZWCogYUYqBslxWFBLzhSAAFkGlZMfj3
	 0uWwcvOHg65jPY58QzXskIEhZTekMDXD80Ak/p0UC672OnZrgp3u5vGxOg1rkHzPpDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=GRoKOdBuy8yrogjEG1E1/pNl5KdS5hR+N9bAYyEDzRk=;
	b=mWdr55KqaGh6k1ZIfl1moq3pFZ1vHO6u6mBWpj9rMtmIv4xKQSGqL9nY4e8yZ1BkQQck
	 9ECSUgkmhuu05PVsJT3CysiRCcrf+3ury+rMdLY6pmKBEnDQuE9DGZt3a+3TJFReNjkrW
	 S5O7i+BI4cZ/8iR6Y/raeSLOS2V0GWjL13W2b7S7LBK2lA3Tna1O4YkaFrUlCjnJet+w/
	 BO3ZapdeSVEV+0veOrijZbeKxnu/1Oe6yiLoJMKyxVq7Wf4YSMIkfxcLO1rzdcJVeEfY0
	 TKiovqYwBWRhz9bqPIsEAOX1r4iqptdPvRNMhRbasStc54NBFFNy9QxqKWRHyHtiizQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oZYxiNy7;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF0606A31F;
	Wed, 28 Oct 2026 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CF0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oZYxiNy7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GR
	oKOdBuy8yrogjEG1E1/pNl5KdS5hR+N9bAYyEDzRk=; b=oZYxiNy7rcduNPUpwE
	o6pDmJbU7MgxvAwkh1w1W5xdQf/kxDPGhfVXiBuNhC2u/SXKPwsKERPCt+DTnyGB
	72ExVuJN1d2OgcgYsg14dccOmWyqUegsGSRneQNpBowxuHBC5qMJZT3tpkAmaq9/
	njeBWfKHcN81EkPa6pjo1XRYA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S12;
	Wed, 28 Oct 2026 13:00:51 +0800 (CST)
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
Subject: [PATCH 10/12] irqchip/loongson-liointc: validate MADT HT-PIC entries
Date: Wed, 28 Oct 2026 13:00:37 +0800
Message-Id: <20261028050039.121080-11-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S12
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWkCFy7Jw13WFy7JFyftFb_yoWkGrXEkw
	n2vrs3JryUGF1rtF92yr15XFyavrW8u3WY9F4IvFWrCw4rJw15ArZrAws3Ja1UKrW0vFn3
	Grs8urySyw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyCJPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AOTzWrhgYNWkQAA3j

The LIOINTC cascade callback passes a typed HT-PIC record to
initialization code without checking that the complete structure is
present. Reject truncated entries before dispatching them.

Fixes: 70f7b6c008b3 ("irqchip/loongson-htvec: Add ACPI init support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-liointc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index cf44a333b9c8..2b6fdf9eff42 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -378,6 +378,9 @@ static int __init htintc_parse_madt(union acpi_subtable_headers *header,
 	struct acpi_madt_ht_pic *htintc_entry = (struct acpi_madt_ht_pic *)header;
 	struct irq_domain *parent = irq_find_matching_fwnode(liointc_handle, DOMAIN_BUS_ANY);
 
+	if (BAD_MADT_ENTRY(htintc_entry, end))
+		return -EINVAL;
+
 	return htvec_acpi_init(parent, htintc_entry);
 }
 
-- 
2.34.1

