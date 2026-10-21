Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593960;
	b=nlJeCmLO8HO6HD5gQcWTwQ0YhY5Y3Oa72M96x5U3zxCfbrxOZhoggdJjvdls2wwEe1mq
	 HkNasHWjz/6mM+FzDFO+HPIVXtn8XJu39NFve8PLQnZUkrTBWub8X1kycgsgqbSk0iGN5
	 OscAvR+ELqc11Mnq8Fs1j4FgkrpSvDBqVLotloxBGKesBtIWXuZKKCKRCx7ykHgGQEIUb
	 ym2+tOiFiHRX9ZgF7JEDPUYV06ZX8HS87Rbs2rtNHcuGJYr2n9w1IiT64Z/XRhhHkBHI9
	 2lUpuTvAPAYm1kj6sQbfe2zLZJPh3/gq/pjdEgFZwT1SkNb//uTn+UE9h96oy/QPHtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593960;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dmI12ASRBID7pbG7Kj3YA2ZrzgqrOIsSp9SPF5rc8VU=;
	b=Jzyhx2wJfzNsvagkrEGt8p7rjvL5KVr3iX1frBrIqdK3DtJYwhoXv1wpGd0XrGumEVxv
	 QF+rSfd3biSWtyzaM5eSR9gatjYG09/2CsnVPl5ywsv7sRdakM/SanM0YCo5bnXtbmWct
	 pD6Ar6qK0oE8OdqzTj53rN651nn54G9IejpkPONALVcyye3Rq5SCHoLcG/cVwdGxMHqtr
	 HyQk1GvSROxuezTuWJhH3AdrpY6VUVhKe2giGiWsjZPDQ9aIHCKUGzOFO6Ub6WG9umHVG
	 Oh7gQ46p+MocrIwwKeZK0JlfW26Sfr6Fj6JMBpBpybKvd5xbrQEtcHgO+2270PszBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ED6NNPBb;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9F606A319;
	Wed, 21 Oct 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE9F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ED6NNPBb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dm
	I12ASRBID7pbG7Kj3YA2ZrzgqrOIsSp9SPF5rc8VU=; b=ED6NNPBb8bgQDJXUMs
	qILbSV9NC9mPowlKI5JB6DGM8Z7x6PNhDIzIxUl3YVI/Aa8Y5CwCxBccMvwJ488u
	IQ2AjfXvxRfFByGqhFryI8lHlGVbj9wzVHvkdwjRyLGYfXPDTeJMCWkOFXV/FBmZ
	IGi86S/RE99pKvwT4wdAAjFR0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S6;
	Wed, 21 Oct 2026 22:45:30 +0800 (CST)
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
Subject: [PATCH v2 4/6] irqchip/gic-v5-its: validate MADT translate frames
Date: Wed, 21 Oct 2026 22:45:22 +0800
Message-Id: <20261021144524.364143-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18Gw45AFyfCw4xKr18AFb_yoWkGFX_Cw
	1kWFn3JF4xKr47tw1xJr45ZrW2vw1v9Fn5uFZ0qa95Gr48Zw13XFnrX395XF4DGFnYyFn3
	Gws8CF1fKr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbAwIDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7woHQWrY0AoTzAAA3U

The GICv5 ITS translate-frame callback accesses IDs and the base address
without checking that the MADT entry contains the complete fixed-size
record. A truncated firmware entry can therefore cause out-of-bounds
reads.

Reject incomplete translate-frame entries before using their fields.

Fixes: a97efa5ba594 ("irqchip/gic-v5: Add ACPI ITS probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 28e39b065de0..dad3b95ba150 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -1233,6 +1233,9 @@ static int __init gic_acpi_parse_madt_its_translate(union acpi_subtable_headers
 	int err;
 
 	its_frame = (struct acpi_madt_gicv5_translate_frame *)header;
+	if (BAD_MADT_ENTRY(its_frame, end))
+		return -EINVAL;
+
 	if (its_frame->linked_translator_id != current_its_entry->translator_id)
 		return 0;
 
-- 
2.34.1

