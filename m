Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163704;
	b=eGZ7lDO/xA0MGCPR1S7us+vxtbmKCARgrKQmQu/ZUFdWSo/BFMEeXKyjJSgjO06zmn1T
	 RxexMNGkn6TcjAFVNopah65GHRpwVMw0hhnzOXBpBFE1d0l995+jvReQF7obu1et208F4
	 HhiMDvXGNVARhqcJm2ozsS5XoOscHshMUWT22MmPd3qsHhu8PIHofjSd3pYjvEEMIZMQr
	 hic+WFGhF+6WK1OqnQFuRljfop98lO+BelFmgnWcb+q7VyZXs7V4KZybX2DDZh0Uwtofm
	 Npp9anNGFGDBczmSa+wAEL5+mUD36Hc3AqL2UO23jvMTlSEj2jhuWrLAKxDdEkLPJag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163704;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=YGf46adzam7uLIFI8ht//dQytCRtYBHLyOFw2qVtmWw=;
	b=qDYU5ojCY0TFAosbwH5/dCDpiJ6Lf8sLLs3gjDK9QjIdTJO2LYPGbDIbKOpW569hVREx
	 actDqK2TjBgXGGqVcWwqKYkNXiaE4vNtC6s/WXFSXWNYc+cHNL0jmdZO+n7DTSUiKVWh2
	 m2KsSDd8HyJaqEipDIEh+w/kwgisriKUacu17EKrdlN6fOJHdtwJdhjAuJmgFEfPSSbNv
	 fL92TGxURws2Ni6vH8csI5r4/s/HN3C+lwOX2v20mUaxohuBLd+Ar6fvR6mmMfiWZcJnF
	 qafsqm343GOf+B1A76cteIfCvPcY2eL6XquNxGSGXa9uISnH/mY38YjdonFyxNkcoNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d25ZTego;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0C606A32C;
	Wed, 28 Oct 2026 05:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A0C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d25ZTego
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YG
	f46adzam7uLIFI8ht//dQytCRtYBHLyOFw2qVtmWw=; b=d25ZTego774FWoIM+T
	GK+ePFd9rczgnY+B8ip28umFvw+ER6wv+dnWXQK73feQVGupf/lLD9FiGWbbYDxy
	h0etVwTd/zH9OZxE/P3Q2U2dluIl2rfkxEzcrLpysR8s1yDTuuhc0EwpH2WDEqtn
	Bbj40cc9Qh0gGhZKqI3fThsDc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3X2CggeFqRyhQDA--.12044S2;
	Wed, 28 Oct 2026 13:01:21 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Marc Zyngier <maz@kernel.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 11/12] irqchip/loongson-pch-pic: validate MADT LPC-PIC entries
Date: Wed, 28 Oct 2026 13:01:19 +0800
Message-Id: <20261028050119.122424-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD3X2CggeFqRyhQDA--.12044S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xry3Aw45WFW3AF1DGw1kAFb_yoWDZrXE9F
	1YvFs3AryUCF4Iqr4Iyry5XFyaqF4F93ZY9r4SqFy5G3y8X3WfArnrAr4fXa1UGF1FvFn3
	G398ur9ayrW2kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjGjg3UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgGb1WrhgaHVWQAA3m

The PCH-PIC cascade callback passes a typed LPC-PIC record to
initialization code without checking that the complete structure is
present. Reject truncated entries before dispatching them.

Fixes: bcdd75c596c8 ("irqchip/loongson-pch-pic: Add ACPI init support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 98fc1770e2a5..49eb81add098 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -432,6 +432,9 @@ static int __init pch_lpc_parse_madt(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_lpc_pic *pchlpc_entry = (struct acpi_madt_lpc_pic *)header;
 
+	if (BAD_MADT_ENTRY(pchlpc_entry, end))
+		return -EINVAL;
+
 	return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, pchlpc_entry);
 }
 
-- 
2.34.1

