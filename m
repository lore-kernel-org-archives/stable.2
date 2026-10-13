Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AE48094E;
	Tue, 13 Oct 2026 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872652; cv=none; b=QPQCgSBhJ4UIoFmcyEaR0XA4UIXD6a6zRxOQ1gQqAltkA9fThZOTyHNae68wJOBtgiEza8FDg2a1Q3mnCDR2aVUv/AvaBogzOBbG3KqeWslWjj9XzEvqTk7YyGeqRhJbCMHWzD7eHO+zfWISTSQ21CvyuczqD/kBkTG7Vh5zEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872652; c=relaxed/simple;
	bh=dx689UEWIGXzJKVDQMpQh8j+vlrLpRRUN6YVoK0IJJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCIc8Kp/nlEm0ipF3IiYVhP/xzkbzR90ySPSjllYihP0TdjSKDxeR0lm8KhJt5liMnVRuP1AdrmGOWZx3CQoRALI65NbpidC9K/4uTNaPQunMufBakiH7AVMgGg4a2FgAil3S+cxadZsNmrARl2cP9EFC5ttS6LlLBbTdshZnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9591F000FF;
	Tue, 13 Oct 2026 06:24:08 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] irqchip/loongson-eiointc: Use pa_to_nid() rather than hard-code
Date: Tue, 13 Oct 2026 14:23:58 +0800
Message-ID: <20261013062358.60654-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NODE_ADDRSPACE_SHIFT is 44 now but may be changed in future, so use
pa_to_nid() rather than hard-code.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index a9e8b481d31d..ba6e8480e383 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -454,7 +454,7 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
-	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
+	unsigned int node = pa_to_nid(pchpic_entry->address) & 0xf;
 	struct irq_domain *parent = acpi_get_vec_parent(node, pch_group);
 
 	if (parent)
-- 
2.52.0

