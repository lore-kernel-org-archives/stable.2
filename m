Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F84A2E0F;
	Wed, 16 Sep 2026 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550110; cv=none; b=pQZpk2/edL/rPo8Cztc4loxMFlmr8Og1iSO+33rUVgs9Rc8ALBdHVQnSpwm0sEbVOt3AbVPDMox1IE7JVHFwU657m0bmtdJpMxiaMsHwF5ax4e/DyoliTrfxcTtmFhr6wrNSrFMrKkZ+SmUhJDzsQ3rGJaWThklhs/J+1mIk1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550110; c=relaxed/simple;
	bh=gUxLy90PlRktvF2nIp/cDo0L+xsCyzoxtGNnJLnk01s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uMS2wLQEnDpA4gB6iuQZo7L1fLOwn5qjK1Fc7014PM87cfSvf3kx3RV8nwpFxEMemalAja1ofWGhnSxpcyd5C60NRlJJt+7r33YZVaHxTSiz6VoNZypSoMP1sQTP244LWpbPKmgAFeVHcwm6xPDmlMSLNxm09tRRl5o9S2whWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAC3vTsDXqpq3y3gBw--.46964S2;
	Wed, 16 Sep 2026 17:14:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: akpm@linux-foundation.org
Cc: bp@alien8.de,
	dougthompson@xmission.com,
	juhlenko@akamai.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in i3000_init_one()
Date: Wed, 16 Sep 2026 09:14:15 +0000
Message-Id: <20260916091415.1997923-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3vTsDXqpq3y3gBw--.46964S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1xJFWUJFW5XF43AFyrWFg_yoWkGrb_u3
	WrZFy7Xr4kCF4qkwnrGr1fZry7KFsIgr4rWr4Ig3y3GryfWa1DZFZ8uF1DJr47Ww4rZFyD
	Kr1q9FyrGF42vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbYZX7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqP4eB6gABsB

In i3000_init_one(), a reference to the PCI device is taken with
pci_dev_get() and stored in the global mci_pdev even when
i3000_probe1() fails.  On that path i3000_registered keeps its initial
value of 1, so i3000_exit() skips the pci_dev_put() and the reference
is leaked.

Only take the reference after i3000_probe1() succeeds.

Fixes: 535c6a53035d ("drivers/edac: new inte 30x0 MC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/edac/i3000_edac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index 9065bc4386ff..d4ee6e185c80 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -461,10 +461,13 @@ static int i3000_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EIO;
 
 	rc = i3000_probe1(pdev, ent->driver_data);
+	if (rc)
+		return rc;
+
 	if (!mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
-	return rc;
+	return 0;
 }
 
 static void i3000_remove_one(struct pci_dev *pdev)
-- 
2.34.1

