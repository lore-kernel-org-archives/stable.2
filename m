Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1F50AC2F;
	Thu, 17 Sep 2026 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650135; cv=none; b=i/kaL6//wEPCoeeVkbXN8vriifaTt0bZgFkbL5ltcvurOd87TpsXTf0nAMYiO/t2uNUFGsjFqnyxnW7aTHM8kQKUz0zZLhaCdaRcmrrtv3yrYulN3vg88WCqH7R2EUBj0M0xZxlkqBSetOHd7yYSaB0jg34ok2PAlVf214fLJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650135; c=relaxed/simple;
	bh=OSXwh9Ig+PQq5u8inJX/lP1U/PzoQjfh/DEEYEIS1t0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRdV9OIWX5b2DR5K+oyO3mQUMv66/Zc+OJZ3vPTyoDJ+t7tZTSXfK/tN1QD90xlhQ1aF50cNUXvhnGcrXX+RkPfKC0DlX1A96l9M5NjH1dP0C6jZxgdCIEE2irbheNethJUlZiV21YjRJzYRz7TgJ5KdXmYdo+WpTaVH4L+CojM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAz7B5KtqRgmBCA--.3240S2;
	Thu, 17 Sep 2026 21:01:53 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nsaenz@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_pci_dma_ranges()
Date: Thu, 17 Sep 2026 13:01:53 +0000
Message-Id: <20260917130153.2152542-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAz7B5KtqRgmBCA--.3240S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1DWF45Kr4rGFW5AF4kCrg_yoW3KFc_uF
	yvvr9rWrs5Ca1Ig34fAr13ZF9F9a48WrWkZwnFya43Ca4Yvr13Wr1j9r1kGw1rAF4avasr
	KrWkXr18trnrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYjsxI4VW3JwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j5
	CzZUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq021DwAAsI

of_pci_dma_range_parser_init() can fail when the node lacks a dma-ranges
property. That error path returns without dropping the reference taken
by of_find_node_by_path(). Add the missing of_node_put().

Fixes: 04db93a95aef ("of/unittest: Add dma-ranges address translation tests")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e10fff3f68c4..939cbff45ab1 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1198,6 +1198,7 @@ static void __init of_unittest_pci_dma_ranges(void)
 
 	if (of_pci_dma_range_parser_init(&parser, np)) {
 		pr_err("missing dma-ranges property\n");
+		of_node_put(np);
 		return;
 	}
 
-- 
2.34.1

