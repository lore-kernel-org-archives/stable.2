Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163679;
	b=1B5Sir3O62W0FQ2CeUAQixCm7m7fBAJhGXls8d+hnfViDSYZTcFqaQXISmlxBJ5RfzHS
	 7ZwqJXhoThPQAM69dxd4Hrco3QnJRjq0ZDnsE0OMT/NjJsoONPnP8Yilrtw2TnNxutDXS
	 VemD46ASnAVYwSLTBen+Dksd86VHM9ubwxuOrGQ/83CVu3h0XM43W4/C6IytC6OJLpF4W
	 Kqe7fccx6KJJZE1ldNc27IYuV6FLnL9zZfQMfVEDkph5tk/jbMhhTiPGtthCfAJXoe4XN
	 To8TCAvGqIjZ8sp8dEsYxkItQTsOu3Daodfg+BJRp7g2xHwrNeTfg09wjceEDJj+neA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163679;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=hfpC3MC6bWV21eYYyaHQZe9yRDhpAr3URrO90cqjckM=;
	b=nJeJq0TOic5QaugC0wYw4bTMMh3BcKssW6fLqFa5TaOG+JCFHj0jEP+Fa5yVy0hWZw7O
	 UCAZN3oEDQnUwLZKiE2969HYKKUAaTGN0LiqzLpy56ECHIADnw6v3f5vK7oMwRx7LiOSv
	 QlargyV6N5DGTvPrZxJc/HLnVILiJJovtcs85kzzMG0a02UARM/MMJvaCkI+OLB7uc7ju
	 WXFCGb3wPn5HGHw9DMn7ff/ePuarqZSZfeVdtxL/visrAlXhxD0YCL3JrmhP/COXVDGdo
	 Qmr2+54JAJmgKSXTIdqKEHHuhhUQGo54ELfq+96ZxmxbnU6lUKqtIjnTw+IUEVNujLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FNaLc9Wr;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241960A2620;
	Wed, 28 Oct 2026 05:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7241960A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FNaLc9Wr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hf
	pC3MC6bWV21eYYyaHQZe9yRDhpAr3URrO90cqjckM=; b=FNaLc9WrFHfncNS9mm
	xHBhz+ffwbDgMAPiY8v69rX9lVwRLOtv3OgqCJMIE0HSdNAZwVrOeYzJMmu9kLQm
	2QG8vXW/U03XReoJh/nTt2LfaqP3OCpefHGbotqvTxfFDEthI6RcRqeU+GpiuMcw
	+G0ClY0B/gyuG/506MKufStII=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S8;
	Wed, 28 Oct 2026 13:00:48 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Tianyang Zhang <zhangtianyang@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Liupu Wang <wangliupu@loongson.cn>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/12] irqchip/loongarch-avec: validate MADT MSI-PIC entries
Date: Wed, 28 Oct 2026 13:00:33 +0800
Message-Id: <20261028050039.121080-7-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4xZw13WFyfArW7uF17Wrg_yoWDuFXE9F
	1293srGrWjgr4UGw10qry5Zry3K3WkuFnY9r4fta9xW348Ar43Zr47Zw1fAr4DKan2vFn3
	Grs8uF1S9347tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbyE_tUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8ACTzWrhgYBWPAAA3O

The MSI-PIC callback reads the message address from a typed MADT record
without checking its size. Reject incomplete records before accessing
the field.

Fixes: ae16f05c928a ("irqchip/loongarch-avec: Add AVEC irqchip support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongarch-avec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index 53d7d23af9bb..ae12541dd167 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -399,6 +399,9 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
 
+	if (BAD_MADT_ENTRY(pchmsi_entry, end))
+		return -EINVAL;
+
 	loongarch_avec.msi_base_addr = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
 
 	return pch_msi_acpi_init_avec(loongarch_avec.domain);
-- 
2.34.1

