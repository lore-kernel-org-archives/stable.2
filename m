Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=AK2sfcfKPhnMtuZTQh6joOd1OvZPTUonQvXDP5OIakH1L5eJyv5Dl4oLIOLzHKCztVls
	 +vKi0bNHb1KcYKDaiK9AyWhyRkj/CPmqF+D1MOGSz7fWYyiCS74FfQHdE0uRZhRtangnu
	 M0tMZ1vkwUHUcShgl3YIO1PrWi0vnrDI5KOgLrtwaqBlpbIJbwucD8f9bGmGEV5Oo/3Nk
	 FUCWPjVNdFVWs0DF95SB3eL/eVSnOCTq4O+d0h+r8mYn0p6WVVakqxcIY/hOmF0nhT08E
	 ek+UID0gdksAtXbH5oxRCsmKSUQ5IhJ8VSn3gfdUCtTBVa2e8/4Vshxcv2jyLxR3H2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=KxVNeIJrGr9qlmIQvjAJsM9SSTFfUCnp2tPgwkRft/4=;
	b=12DzTjViVoqWQpId2yNhkDr5Kkqcwg1+i1oAn92zJdicpq0KDfP5qFU4yOg8b2riHwfd
	 Ie01JSEcCkCdBculTEGBf3IvEPkC4Ws34tB8UvyTwobo9FGUBYgf5TDewOqCQMUkTXMzy
	 zDp4BgMnS4udgz4GJthqHoLaMWgcxVaffKVB+xl8FXo5XdDMVlblddOvSAJ6KFzlVsRzg
	 t/6ZQX7pWds3C644zIEO/VmJyWrRZGi5FJy/cCbF5cxXrn6912z9D4IS71xoXx6MDDh73
	 5qMFAGcjyuWPKz0NwFdA/awHuXfOhOoIE/EPvSPagHeqKIazcSQETCIMGeHezCHeW+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="HG4sy2A/";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F65606A31E;
	Wed, 28 Oct 2026 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92F65606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HG4sy2A/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Kx
	VNeIJrGr9qlmIQvjAJsM9SSTFfUCnp2tPgwkRft/4=; b=HG4sy2A/u+9RAt4kne
	YiPpvjeiq8OW+A/yQtRmsB2xcvFi8hKc26BU93FlrYhOBZye4zXQlWRWyFHZ9iyN
	crMQw7FY6zpHextZtdZn/BRK2kYKpv4MPgaXfFo7IzRZHvKn528lWF3t3wYsPjeE
	rBI1tuCrT2CvO41Tm2/YrL6ws=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S11;
	Wed, 28 Oct 2026 13:00:50 +0800 (CST)
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
Subject: [PATCH 09/12] irqchip/loongson-htvec: validate MADT MSI-PIC entries
Date: Wed, 28 Oct 2026 13:00:36 +0800
Message-Id: <20261028050039.121080-10-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S11
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4DuFWrGrWfJF1fCF18uFg_yoWDCrbEkr
	n29rs7GryUuF4xJ340yry3XFyaqw48u3Z09F4SqFy8X340yr1rArnrAr4fGF4UGw1SyF93
	GrZ8CryFkw4IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbkhL5UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AOTzWrhgYNWgAAA3y

The HT-vector cascade callback passes a typed MSI-PIC record to
initialization code without checking that the complete structure is
present. Reject truncated entries before dispatching them.

Fixes: 70f7b6c008b3 ("irqchip/loongson-htvec: Add ACPI init support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-htvec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 725f30b7574b..1f5bf01c3183 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -280,6 +280,9 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 {
 	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
 
+	if (BAD_MADT_ENTRY(pchmsi_entry, end))
+		return -EINVAL;
+
 	return pch_msi_acpi_init(htvec_priv->htvec_domain, pchmsi_entry);
 }
 
-- 
2.34.1

