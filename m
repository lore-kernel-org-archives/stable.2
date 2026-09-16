Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684E4E50DA;
	Wed, 16 Sep 2026 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584840; cv=none; b=GegAj5WLWd9t3ChhpZ56eNxz9qTpE9NFQDGhjmZdFNbOWwUw4Rk4p0ynle1SbNhlaXcQVG4o2YzS8qCm1dlNzggWZq/86bJ8Xtl8bmTj6bZTDv3uIrNZgMS7ZQJWailzXOLLOKYg9V1TJ3a811cYI8G1UR/xjjuXssKw8pEFFT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584840; c=relaxed/simple;
	bh=oZ74DBm5ryiVX5dnrDePlI2yqZz3F2DEUP8ILajCMyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2GL5lxel1g3i18Blq74cyWa06mqxbFvrd536G4cbnqUBvsYU02vzBD6AsdyNE2a8HpNurZTX2hXxCwy95BNkP4LLwBtS9vNbBQYcYmk91p+nARqfsmQHvNfZHUJScU1QEjsJ+7F1BOiEhSq5c46ajKY9+PSvsKMyDyZa6w9yAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3J0Ky5apqU+pvCA--.24921S2;
	Thu, 17 Sep 2026 02:53:38 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	mingo@elte.hu,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix IOMMU PCI device reference leak in iommu_init_pci()
Date: Wed, 16 Sep 2026 18:53:10 +0000
Message-Id: <20260916185310.2093691-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3J0Ky5apqU+pvCA--.24921S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4kCryUAFWxWw13tFykuFg_yoWDtwc_Cr
	W0qFn7Xry5Ga1jkw1qqr93Zr1DKa4DZFn7XrW0kwsYy34S9F4UJ34Yvr98GFW7Ww4YyF9F
	yr1DGay3J3srZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUCNt
	xUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQMA2qqpO+GbQABsm

iommu_init_pci() takes a reference on the IOMMU's PCI device with
pci_get_domain_bus_and_slot() and keeps it for the lifetime of the
IOMMU, but free_iommu_one() frees the IOMMU without ever dropping that
reference.  It is leaked whenever an IOMMU is torn down again on an
init error path.

Release the reference in free_iommu_one(), after the sysfs device that
uses it as parent has been removed.

Fixes: 3eaf28a1cd26 ("AMD IOMMU: save pci_dev instead of devid")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/iommu/amd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3bdb380d23e9..4b155970151d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1810,6 +1810,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
 	amd_iommu_iopf_uninit(iommu);
+	pci_dev_put(iommu->dev);
 }
 
 static void __init free_iommu_all(void)
-- 
2.34.1

