Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593961;
	b=1oBoZITMqGKZfcm0MowLgcwDlu8O4HfpH9R6mmXpasuONpndQvvBW3QocyOhFcLRzoT6
	 eDEyPosBB9nZp1S3xV4HJujAXM2S5Nz78R0qKF1CXlOeR3v6/Sgx2ue6m6raIPEgftetb
	 miGRQlioo/bsj0p/gUb7VdmP1TzR/Ecexo8vIUYpa323gl9NxmgkZmIIsRtdrnEqOfAqb
	 duoRATBVsoSE3oVxoUqBvnP+aVZhK9OBXZB6JGA/azZ1vul12Lp0LAWjeE6vcKkG4xnXR
	 DFR+s7yKkIIv9FGcUZAZyuRIu+8MBGE89hfzuVaV7b/BR33fPiZS1AJrXECYkkoJIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593961;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0eL2bzd9HSLFKqzLgVouTcXW+mDlC5BCNips3rCkPwE=;
	b=5BeiTLOCHFoBn6bPo3fpWVw+LKlgxjExqZdJO5rmgN8NZ+mB0/1Hy3YhnhNJ7rqfIfLl
	 uR15jdA3j2aHJpb3MTAx2LuyQNDbHeMZsFPeKMTP1X9+s9QMbPJR9KKG/WCqzfJMQjotL
	 eyGhKpYtjvvYYAcxOHg/9/3okDDfBky9MV+waKR2kRzhrwVvvG+am69uR9cZ+62Z65hbR
	 Nd32W89OaqRhk//6hL4nw8FFKmig9ZiM2SI7qsE/wtenBdiNt4O3e9pcOm0yjcjI8rvi8
	 NaiQMId4S4gSkMV1nY7N2wrQkwuPsmupyUm+Ntv4Zd9+8hxcHoBrAUWz3d3VdxY+b/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NGMvGGrX;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F3606A31B;
	Wed, 21 Oct 2026 14:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02F3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NGMvGGrX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0e
	L2bzd9HSLFKqzLgVouTcXW+mDlC5BCNips3rCkPwE=; b=NGMvGGrXxdBWVQ21oO
	bGXLqxx+VUFtNZ5J4Ke6u5gaQXoBXkPEKj3QYO9hxPSVhyd2pQaG2hnqYDsrLVvU
	mWsKzlvRa1K18zigAiuY6JwZQuUxBtUQD+sCOX27DCa10D4XHDfwSx8/SDKAOQ7x
	oSulK0Bz1gPQ1RQYXhXjhFwLU=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S7;
	Wed, 21 Oct 2026 22:45:31 +0800 (CST)
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
Subject: [PATCH v2 5/6] irqchip/loongarch-cpu: validate MADT LIO-PIC entries
Date: Wed, 21 Oct 2026 22:45:23 +0800
Message-Id: <20261021144524.364143-6-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW3JFyxXr4Dtr13GF17Jrb_yoWkWFb_uF
	1a9asrJryj9F1Utw1ktr15Z3sxt3y8uFnY9rs2qFn8C395Jw1rXFsrA3yfX3y7KryvvFn3
	Gr4qvr1Syr12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbAwIDUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wsHQWrY0AsT2wAA3D

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

