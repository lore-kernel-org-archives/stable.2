Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96664C6530;
	Wed, 16 Sep 2026 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585007; cv=none; b=qS2pUoC3k58aTrQ3x+/LS5OSUAYWxN+JLgblSqVdHyBw75mzjpD5R+I3t+dEnKW4CWavAiNK7pgKX62qnRYSTf1Raa0yZ3qtxpnoaoMtG1e2V60yKd9twRQOhdESYEaGRNjnCEWSF//511SOwHQ/VlvP71t8fOzvncLqiE7Y1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585007; c=relaxed/simple;
	bh=QdTJHlvPaT0x8kA6SbOWfo+8feXCZi+nl5EPI1AZoO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YgSHIGRBbSpMhk3gUb4O1itG5zr/A8BLkPhKlKw5ZRNKGDXhGDL/eZVFF4mB0G/j80mctNR8Is7bPIB0zOuBd3IrbbGiwmtDwc08tFRy6Q5dUypaM2zIr2K9StgKlOv+44hK+sLnNH8I8lx/oiWnUZLvXa8JYW+U9sH5yaECGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAHcz1T5qpqTfRvCA--.24691S2;
	Thu, 17 Sep 2026 02:56:19 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix root bridge reference leak in iommu_init_pci()
Date: Wed, 16 Sep 2026 18:55:51 +0000
Message-Id: <20260916185551.2093860-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAHcz1T5qpqTfRvCA--.24691S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryfXF4fJFyfGF4UJr4Utwb_yoWDCrX_CF
	yrZa4xJrWrGa1jk3Wjqr13Zrn0kas5uFn3WrZ2gw1fAr10v3WUCrya9F95Jw4UGw4FyF9r
	Kwn5K34rA3srZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUW6w
	tUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2qqpViF-AAAsM

iommu_init_pci() caches a reference to the root bridge in
iommu->root_pdev so that iommu_apply_resume_quirks() can reprogram the
IOMMU on resume without calling pci_get_bus_and_slot(), but nothing
ever drops that reference again, so it is leaked when the IOMMU is
freed.

Release iommu->root_pdev in free_iommu_one() as well.

Fixes: c1bf94ec1e12 ("iommu/amd: Cache pdev pointer to root-bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iommu/amd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4b155970151d..c92f7e64453a 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1811,6 +1811,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	iommu_unmap_mmio_space(iommu);
 	amd_iommu_iopf_uninit(iommu);
 	pci_dev_put(iommu->dev);
+	pci_dev_put(iommu->root_pdev);
 }
 
 static void __init free_iommu_all(void)
-- 
2.34.1

