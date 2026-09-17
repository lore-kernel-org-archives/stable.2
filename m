Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CF545DBF;
	Thu, 17 Sep 2026 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654460; cv=none; b=WfexzVrzA1t/m9uzT2uitYOWbycCYz4iGYN0ZX/RpxP5aec5gzse26OEVYsMN81PgZ0+1prp1RE30FBpNbAgO0ZwlH2MzL8wA8c4TQYxQYeTP+llBgCXx7B2+1M0ZGvpnJQ0YPToNWFP1zkpLB0DdAGFnW+ZJxPiCWRF26d2CJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654460; c=relaxed/simple;
	bh=CKzwH5IlqQ4tcQlRqwBTavEe5X3w0+DdU2PZds2WOgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CvP4JzMySfSekwjqqxq7t8UG3OrLdlrpSgxauRjlB9hePWjpwlmJ+gNzsS9aFBmRsiVElXewMdX20ZIPmlUs5ayMBjtmpRBCLrv9kXu57icR3XLGBg+KsRHNlfA9n86iOTUUGFKivt57cyno/H1C+BgHBHrRsO+Shd+jikYwG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD+39atqTzOCCA--.4496S2;
	Thu, 17 Sep 2026 22:14:15 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andriy.shevchenko@linux.intel.com
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	platform-driver-x86@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: pmc_atom: Fix PCI device reference leak in pmc_atom_init()
Date: Thu, 17 Sep 2026 14:14:14 +0000
Message-Id: <20260917141414.2156326-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD+39atqTzOCCA--.4496S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar15Ww47Xry3WFy5Zw1xAFb_yoW8Xw47pr
	sruFyayry5Gwn7Ka1DZa10vFy5AF42v34fC3y0y3Wq93s09Fy5J34Iqa43ZFnrAFWkJ3W5
	t3yDtF48Wa15XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x
	0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUznYFDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMNA2qrrJrfXAAAs1

pmc_atom_init() iterates over the PCI devices with for_each_pci_dev()
and returns pmc_setup_dev()'s result directly from inside the loop when
a matching device is found. The reference obtained for the matched
device by pci_get_device() (via for_each_pci_dev()) is never dropped,
leaking a reference to the PCI device on every successful init.

Break out of the loop, drop the reference with pci_dev_put() before
returning, as pci_dev_put() on a NULL pointer is a no-op when no device
was matched.

Fixes: 2b8f8eddaf05 ("x86/platform/intel/pmc_atom: Add Cherrytrail PMC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/x86/pmc_atom.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 48c2a0e59d18..750b72c6c616 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -579,6 +579,7 @@ static int __init pmc_atom_init(void)
 {
 	struct pci_dev *pdev = NULL;
 	const struct pci_device_id *ent;
+	int ret = -ENODEV;
 
 	/*
 	 * We look for our device - PCU PMC.
@@ -591,11 +592,14 @@ static int __init pmc_atom_init(void)
 	 */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(pmc_pci_ids, pdev);
-		if (ent)
-			return pmc_setup_dev(pdev, ent);
+		if (ent) {
+			ret = pmc_setup_dev(pdev, ent);
+			break;
+		}
 	}
-	/* Device not found */
-	return -ENODEV;
+
+	pci_dev_put(pdev);
+	return ret;
 }
 
 device_initcall(pmc_atom_init);
-- 
2.34.1

