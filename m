Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4554EEA2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955095; cv=none; b=tuDHk7BjOptPML0nSz0WJBCZ1xNCmV8DZgR1z25hDOjTxZAFS5+iDKOFgq4BM2fZNydFkm8eoGCIGS5vZEIpeom+JfYLGKsscANX/F5b5ajn50jrlRg9qGWgUeHI9keVtUCCn6kruJnSsPfN7BNc52eqSdjJSt2UTovsaJ8Tm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955095; c=relaxed/simple;
	bh=/7g8qeqkjXft4wv9tqN/2PT5lSrwnZCVhpKlhh+aiiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cylDXSAiTsYqOCxJD4uj7/+T/XZBLqFvxgy4KJYu1U2AUkcvrx4XwX2qxn04RrcPTU4CsVXheZ80D7tMsuwFnFdOcy+qsutOk/Zvlt6TgTl/sXx+Mn9aJge7srOuefNMqsf8+XtJxieUQLmpzxz90JdvE03Shv4NADQ85bFC0ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdNIHb0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdNIHb0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132F91F00A3D;
	Wed,  9 Sep 2026 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955093;
	bh=WThcMroFitPUMmGqRz9QRab492Wz35cgY148ibw/TKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdNIHb0HHs5prRyrdXpo7MlQrIkAVLc3OJ3vVceTI6EBaJVGsrtfe4UkNSWQGhdvY
	 U7mUI5ppEuHMnzinis1NV0T2Xl+l6UZyMvuqz86nuXoig7lE/oy8MftqGpfb/BU3iL
	 jKnvTaJTlbLhWNZkpHkvazuIwM1+5HPuulhOpAZgQ8I4UY7BE5H6fy5ZkiXBAYKIG4
	 bWzUIZjyJS6z3IF4DwrF6kc/zBaUCvLD5OiHRsyCnj+oDKWRA1D5NtP/MDURM9lVHi
	 Bx0T4ipT7MSvS1LrPbPRMqL2iFaQyYUuNFDRH+U4YW+ILMAWTNwBqXNYB1Dl9MKNXj
	 KJDvo6jGD/SGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Tony Zhu <tony.zhu@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iommu: Add max_pasids field in struct iommu_device
Date: Wed,  9 Sep 2026 07:58:09 -0400
Message-ID: <20260909115810.2181247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090350-unpleased-sandbag-2584@gregkh>
References: <2026090350-unpleased-sandbag-2584@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 1adf3cc20d693569ebee90fd91fa34b0570fcd6f ]

Use this field to keep the number of supported PASIDs that an IOMMU
hardware is able to support. This is a generic attribute of an IOMMU
and lifting it into the per-IOMMU device structure makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver that supports PASID related features should set this
field before enabling them on the devices.

In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
enclave so that the pasid_supported() helper could be used in dmar.c
without compilation errors.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Link: https://lore.kernel.org/r/20221031005917.45690-2-baolu.lu@linux.intel.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Stable-dep-of: 607432b2618b ("iommu/vt-d: Force requesting ACS when tboot is enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/dmar.c                  | 7 +++++++
 drivers/iommu/intel/iommu.h                 | 4 ++--
 include/linux/iommu.h                       | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index eba2b2e2da0b9..ab03f1789d2af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3622,6 +3622,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
 	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
 
 	/*
 	 * If the SMMU supports fewer bits than would fill a single L2 stream
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 47ac10fb76db3..75eb4bd5ebb74 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1106,6 +1106,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	raw_spin_lock_init(&iommu->register_lock);
 
+	/*
+	 * A value of N in PSS field of eCap register indicates hardware
+	 * supports PASID field of N+1 bits.
+	 */
+	if (pasid_supported(iommu))
+		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
+
 	/*
 	 * This is only for hotplug; at boot time intel_iommu_enabled won't
 	 * be set yet. When intel_iommu_init() runs, it registers the units
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c99cb715bd9a2..5116105671727 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -480,8 +480,6 @@ enum {
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
-extern int intel_iommu_sm;
-
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
@@ -799,6 +797,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern const struct iommu_ops intel_iommu_ops;
 
 #ifdef CONFIG_INTEL_IOMMU
+extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
@@ -814,6 +813,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 }
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
+#define intel_iommu_sm (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2bfa9611be672..780b688e4e043 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -322,12 +322,14 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	u32 max_pasids;
 };
 
 /**
-- 
2.53.0

