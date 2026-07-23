Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1843C054
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815529; cv=none; b=YSde89kGyNyGsyHDrfiJU1FWXgz6q4Acc+6t6BTTtUO67iITNoIA9XqPcfVqKvCa16kkeq2pGNYsIp7uccJPzMqcXfG9QAm6wjT1rjqRImywTiMGNdC/mCYC7V/xARUXX/f95dqkXbO8yYJ3nKNteB1udN9deLWO6Si6fLac9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815529; c=relaxed/simple;
	bh=QNzhHSWXY0YVvLiHA9rtwSqhgx1pVfMQubvh670F2Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imnxK2uzwI5dM2ypcV++KpJs/Oulphyl+ruoxEpDP63wPP+Ehuxt+XkK29LgSf3BfA7ocq/rfxsIPP/ctYm2FSa7ElNNQI3IBFGfl31dCj4C60sGqlEdE+iaKTNP8wa8PqNN0ZiTh3iCh0flE6LOULIXCfhcbxZ/KAoqpWuOkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzLLMjMt; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzLLMjMt"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso250970a91.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815526; x=1785420326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAXDge/wn1yAOWtnkmMfKUnDJVLhigwWE+vKoPWa8rQ=;
        b=bzLLMjMtE6e4RR8S4W/XrTL5BTJPkBUEgDms6112hAd/wvj9WkSDo6dKOLdFmIkA0a
         6pIfhgFS8NPP/C5tuJnHxZYVc56EUHgP2wCT01blrE/rp6u7HSzj5vOkWB/yrimad0YS
         mj+0LSyCOSJdEB01sD4qUwfGGi2A2ebuPLvsk0wlCAV48+Y3Zh+y2CF2ciUsD/YUFeFI
         w52jcysXphWz0xKgkNYWDULkz2cI6VyeJHeIkT1/YMeoNA7V3NPs/8HGtiWi5P8+z59M
         TIp6ILGz54wlWPzP5WCdfvKhZgnWSgk6/baUwsg5aswhx2xt5bNPQ37bi3xxvrJkP6Xx
         YiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815526; x=1785420326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAXDge/wn1yAOWtnkmMfKUnDJVLhigwWE+vKoPWa8rQ=;
        b=RC35WnFR3PI1mWjDYE16r75ykWYCZEmuz/fMyNIggDleQ6qHZKCzdyN4VMSBCcYM6e
         f5sWAxzm0ltw6kp+mw7Z3ZLtnjhjmEqfW9k9pFaVbkQ53lpgPG4EDJPcRNXrqKOtIlUa
         Ua1SQ6kftfeZCZNb+Sb0cnbQif/WHHQkqF9u8nesZnfViwA/oV+ZS70KyuXI5ZuoLjnW
         Kiy+UMdcF3kTJ24UNvjYwz2e7gnNrRQNf1s0LAReH7+ClgGAqcoLbcJ6TbujstIjVD0v
         CaM7PgTM0Y9RW2pbmUcZey7eexfXRTsczzdKeucNe0VnhapTRx9VV483sDjDprU3nnM6
         xWEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2cAofNm2WSzTSQAOIJq5eTcbOubw8M5FkvHjO6+pzlCPd9wTEOQhORad08B5k6YAcRhj5eQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2c5dscA+IwvAnuEWRdlflAlVOOdCKMzt/fqVO2ZjEZZatGhl
	s1iRt1NUukZGdMFPQlIusmg7pgl9CuUeliOlfAno2xPEFLavzEXry8gB
X-Gm-Gg: AR+sD10AKcSq5B/a5Z0wF0wdHqb0VHE7bIkaPzsxNVZnRUi+UH13w05GWfGkU2HFo/B
	GFZj/Vg8BTjlyCJJc5JopKZoXnrHzNO/ewqI2+9gJ++XbMNKLdMqip5ZtL5xoVgpBkxJxZDKWBn
	zE9jJlpNofmwk7gC1pqZ6r7y+krl8Z9ZC1hryTdOLkGFQRgWAiA7zg7KCxFzckJERLN5yC9OZ12
	30Wt6exh9Cs3GKF7Myrm1YaVap/QXQUEhq4CqMYjo8JPvMQL6hrKv/exCh37S/mceEX8ypK/QQ5
	GYeA0w6oTx3kle+pTAIsp2zqTVxOc3JW8RHUgRyEM3C+PkMfc1VDrg/JtLPH523E0a3BXm9etH9
	hvEpzey+Iukl67Nmh/BbRSnfdhJm0RGApGdS7M3XHxpG8z2R4Mu8+5kcHKiCuUV3olhTXOnHgQw
	2EMoTRL2HlCi/frkadARM=
X-Received: by 2002:a17:90a:d64c:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-38ec6989c62mr3111974a91.12.1784815525765;
        Thu, 23 Jul 2026 07:05:25 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm17870433c88.14.2026.07.23.07.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:25 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: daire.mcnamara@microchip.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	minda.chen@starfivetech.com,
	conor.dooley@microchip.com,
	mason.huo@starfivetech.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	alitariq45892@gmail.com
Subject: [PATCH v3 1/2] PCI: plda: Fix use-after-free of event IRQs during teardown
Date: Thu, 23 Jul 2026 19:04:33 +0500
Message-Id: <20260723140434.675512-2-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723140434.675512-1-alitariq45892@gmail.com>
References: <20260723140434.675512-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plda_pcie_irq_domain_deinit() removes pcie->event_domain via
irq_domain_remove(), but the per-event IRQs mapped from that domain
are requested with devm_request_irq() in plda_init_interrupts(). The
actual free_irq() for a devm-managed IRQ is deferred by devres until
after the calling probe()/remove() function returns.

This means irq_domain_remove() can free the domain's internal data
before the deferred free_irq() for IRQs still mapped into it has run.
When devres later processes that deferred cleanup, it can end up
dereferencing the already-freed domain.

Free each event IRQ explicitly with devm_free_irq() before removing
the domain. This triggers the free immediately and removes the IRQ
from the devres tracking list, so devres will not attempt to free it
a second time later.

Also dispose of the event, INTx, and MSI IRQ mappings with
irq_dispose_mapping() before their owning domains are removed.

Finally, guard the calls to irq_set_chained_handler_and_data() for
pcie->irq, pcie->msi_irq, and pcie->intx_irq so they only run when
those fields hold a valid (>0) IRQ number.

This is a pre-existing issue, flagged by automated review during work
on an earlier, unrelated patch to this driver.

Build-tested and boot-tested on StarFive VisionFive v1.2A board

Fixes: 76c911396807 ("PCI: plda: Add host init/deinit and map bus functions")
Link: https://lore.kernel.org/linux-pci/20260714115343.4D49E1F000E9@smtp.kernel.org/
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Cc: stable@vger.kernel.org
---
Changes in v3:
- First posting of this patch was v1 (single patch, no version tag).
  Jumping to v3 here to align versioning with patch 2/2, which has
  already been through v1 and v2.
- Guard irq_set_chained_handler_and_data() calls for pcie->irq,
  pcie->msi_irq, pcie->intx_irq with an IRQ > 0 check
- Dispose of event, INTx, and MSI IRQ mappings before their
  domains are removed
Link to v1: https://lore.kernel.org/linux-pci/20260718115022.231990-1-alitariq45892@gmail.com/
---
 drivers/pci/controller/plda/pcie-plda-host.c | 24 +++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index f9a34f323ad8..791f5c1cce06 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -559,9 +559,27 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
 
 static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
 {
-	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
-	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
-	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
+	u32 i, event_irq;
+
+	if (pcie->irq > 0)
+		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+	if (pcie->msi_irq > 0)
+		irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
+	if (pcie->intx_irq > 0)
+		irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
+
+	for_each_set_bit(i, &pcie->events_bitmap, pcie->num_events) {
+		event_irq = irq_find_mapping(pcie->event_domain, i);
+		if (event_irq) {
+			devm_free_irq(pcie->dev, event_irq, pcie);
+			irq_dispose_mapping(event_irq);
+		}
+	}
+
+	if (pcie->intx_irq)
+		irq_dispose_mapping(pcie->intx_irq);
+	if (pcie->msi_irq)
+		irq_dispose_mapping(pcie->msi_irq);
 
 	irq_domain_remove(pcie->msi.dev_domain);
 
-- 
2.34.1

