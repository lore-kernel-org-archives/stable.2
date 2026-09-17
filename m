Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C252940B;
	Thu, 17 Sep 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651678; cv=none; b=Umc51c4DvQLlJzqFxSB8Rhig/J/wUQuOklKTkj/wAVyS5CQNutXXnm7arTnulw3Ibx4HatwYspluU+jWhS9BUUNGVPaS24xWL5s9xiVN/IW79JzVx7GvBqfL8j9CWMvSy5DlErXWAJupt4dGsa+Inr0oxNX+/GhYUMufMRCaPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651678; c=relaxed/simple;
	bh=qnlXgJqq9H7/OzIAsICq6vhg8MqwANWylrBCFL3cYI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fFecFa82C9RepCY7DqetTDtDhfKzWKBox5JV0Yk5rYyB1MAzWBZpQQPcs35PIU4Lomtf23Jv2POLb/rqKZtfULeTzJ1OZ9JeRPgcED1jPCDaRsa/uwxQeBxC2PqQNiuAXN2pkkNsuFtt9pDcnUXS75cUbsN+quhd72f2OiileT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz3R6qtqanKBCA--.44150S2;
	Thu, 17 Sep 2026 21:27:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: aduyck@mirantis.com
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/IOV: Fix peer device reference leak in sriov_init()
Date: Thu, 17 Sep 2026 13:27:45 +0000
Message-Id: <20260917132745.2153341-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz3R6qtqanKBCA--.44150S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4rWr15CF15uw1kuw1DGFg_yoWDZrcEgw
	1Uur93Xr4UuF1kC3Wakr1fZrZIk3Wqq3yIgrW2qFWSkFy7Zr98ZFWUZas8Ga1kWw43uFyq
	yw1DCr15u34S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x
	0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUDZ2-DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUNA2qrrRm6SwABsJ

sriov_init() takes a reference to the SR-IOV physical function device
with pci_dev_get() and stores it in iov->dev.  If the subsequent
compute_max_vf_buses() call fails, the fail_max_buses path frees iov
without dropping that reference, unlike sriov_release() which puts
iov->dev on the normal teardown path.

Drop the reference on the fail_max_buses path as well.

Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..f0687fe8514a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -907,6 +907,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
 fail_max_buses:
 	dev->sriov = NULL;
 	dev->is_physfn = 0;
+	if (pdev)
+		pci_dev_put(pdev);
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[pci_resource_num_from_vf_bar(i)];
-- 
2.34.1

