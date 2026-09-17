Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50C72621;
	Thu, 17 Sep 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650207; cv=none; b=gVWNGFIHdbllXdkg/oVmaAwhkRs8Ssse2G9L01PbossS3e64SaQ382VXLxAOODILdjlII1tPoooXH+6jNvvzNosdU2xuo14JsvBZGv8RHTT+WwRr2wScYGWFf4ok7elS5HflzeS7EeQQsDYJa+nmqBVK1SU00USXLT6QZ2gGhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650207; c=relaxed/simple;
	bh=cMKffZKhIq2MmaepcEQR4J2ib6YDoo/Fu6tdVfQx0to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpbW/cl/A/6Iu/9lXDj3IfHzJv5Yi5nZAtmY++wk3IoOL3XvR1bHRmOnph1LlNVeWIh0OXjPFtuOl5uY+iDO1HTS4rZ9Rhqi0JKlmS0u3A56EXmfJSscKnKlW1M6xwYFrIuTtlBpFpCLjMVSB7GG0rpbVUSv6skg5B3G+GSyblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACXAj0L5atqXw6BCA--.3230S2;
	Thu, 17 Sep 2026 21:03:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrea.porta@suse.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of: unittest: Fix np reference leak in of_unittest_pci_empty_dma_ranges()
Date: Thu, 17 Sep 2026 13:03:07 +0000
Message-Id: <20260917130307.2152615-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXAj0L5atqXw6BCA--.3230S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1DWF45KF13Ar1UGw4fGrg_yoWfJFg_WF
	9YvrnxWFs5CF1Ig34fAr13ZF9F9a48Wr4kAFnFya43C3yYvr13Wr1q9r95Gw1rCF4Yvasr
	trWkXry8trnrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qrq021EQABsR

of_pci_dma_range_parser_init() can fail when the node lacks a dma-ranges
property. That error path returns without dropping the reference taken
by of_find_node_by_path(). Add the missing of_node_put().

Fixes: 1a75e81baf4f ("of/unittest: Add empty dma-ranges address translation tests")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 939cbff45ab1..6bc5babddf0a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1250,6 +1250,7 @@ static void __init of_unittest_pci_empty_dma_ranges(void)
 
 	if (of_pci_dma_range_parser_init(&parser, np)) {
 		pr_err("missing dma-ranges property\n");
+		of_node_put(np);
 		return;
 	}
 
-- 
2.34.1

