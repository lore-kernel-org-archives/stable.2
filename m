Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498614E50C1;
	Wed, 16 Sep 2026 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585164; cv=none; b=OeVJLK7l8SdqISKkNq8pcX5P/KvyMO8K8jHJCJQCPMpvD84N4hOw5kdvvq8lZSPVUSimFKV79J+FeN8vZIxEUSriLFHSkj30JBrdxiOHtlMlu8x+OQkBVAvQYiRlvqsbmjfMWr7Gnmim2DOlaSPL1IfEnKwWFsVCXoSxbTRTr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585164; c=relaxed/simple;
	bh=FQ5/IXI6ngyKjEXmTzOIjn8L5yo3/n8SygYFq+HbAbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hzXvLnmFiMEjfGB2rTy8KOK4OFa50Q/+2iMBkkn+jHCO0eXX+X+P1r4U5MxWYM4FddCYqhdgqZWi+C/wh9FLxB/CuZYjwJY4VDXUhcS+4wdGmWBeKXeZ/O4jy2gukJk7JAGrKFyADdQa4/3MigzwgAM9SYaAG37Eascpm0elxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnVD_Y5qpqnvtvCA--.24836S2;
	Thu, 17 Sep 2026 02:58:32 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: iommu@lists.linux.dev
Cc: jgg@ziepe.ca,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	wei.huang2@amd.com,
	will@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix PCI device reference leak in iommu_call_iopf_notifier()
Date: Wed, 16 Sep 2026 18:58:04 +0000
Message-Id: <20260916185804.2093996-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD_Y5qpqnvtvCA--.24836S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF48JF1fWr4xtr4rKFWxJFb_yoWkurcE9F
	4rZas7Xw15Ar4qyr4UtFZFvr9Iv3ZruF1kZFZFg3s3G34YvF10vw45XFZ8Jw47W3yUJasr
	Kwn8WF13X39rujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0ob
	IYCTnIWIevJa73UjIFyTuYvjfUFhL0UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMMA2qqozWPWQAAsV

pci_get_domain_bus_and_slot() returns a PCI device with an elevated
reference count, but iommu_call_iopf_notifier() never drops it, neither
when the page request has been reported nor on the abort path.

Put the device reference on both exits.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iommu/amd/ppr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1f8d2823bea4..1e4392b17bd8 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -151,6 +151,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 	/* Submit event */
 	iommu_report_device_fault(&pdev->dev, &event);
+	pci_dev_put(pdev);
 
 	return;
 
@@ -159,6 +160,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
 			       IOMMU_PAGE_RESP_FAILURE,
 			       PPR_TAG(raw[0]) & 0x1FF);
+	pci_dev_put(pdev);
 }
 
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
-- 
2.34.1

