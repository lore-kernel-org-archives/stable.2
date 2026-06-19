Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE77324B2D;
	Fri, 19 Jun 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871115; cv=none; b=IIJYA53t3DP3mi1xDLGsJ/9Bbuqdp+8p83n9TUk/GHpHDhFEiCT37EgF9KVyt1/yx60s/XegqtOA2fTSvpUP2jHkUdiq5ud/BW1rZybM/VMxXNBIa9E9bjgQgww+8t9nh9NfoSIXcrE8N6G/bruzKYBjOT3eP3Sn1LH64MHNW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871115; c=relaxed/simple;
	bh=YslTV6eV5fPq4eUf4UjTiAySUDmp+g4dwHtAwIyiDMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxIAPy6T/218Xl+HEk+TPpTNZ6nckfeRQT1wXmp4fYUUaVU2epe/hHL2GtmWNFbweOZaQLPcqDRPQnnk73Aj+q1xN/eNdAgO+ytNInRS8DwwQGBvkB7YEBxSkR7mxKeDvEuakwBatAEGvrLORuJmE01Z2qHFgzjNqfzUecHRjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FbxMf+Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FbxMf+Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C2B1F00A3D;
	Fri, 19 Jun 2026 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781871109;
	bh=ISuUVtKgAI9SWbS9/kCT68F0LDChQp4znL1i51x9Hcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbxMf+Gd+riPdkNdxtmhaPrPNaOj00a7W5rWvQMSvyW4FdgqpcsLIKLrCn9JYQb95
	 ZMIDhRPn1si6DVwGoZMvr5ETn+XLYjYTPFlogAeVPDDojcHQGjyd6Mx0fPjDI7Llgl
	 nmDZpJmQup/WBVPpVVRtr/iUAXbJGmKnSBrAPasc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.1.1
Date: Fri, 19 Jun 2026 14:10:31 +0200
Message-ID: <2026061931-escapade-veneering-c707@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026061931-reversal-stopped-29e3@gregkh>
References: <2026061931-reversal-stopped-29e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 211119ce7adc..ad04d1cdc0f0 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -128,16 +128,28 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76AE    | #4193801        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1491015        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #4193798        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78AE    | #4193793        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #4193794        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
@@ -146,6 +158,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #3456084        | ARM64_ERRATUM_3194386       |
@@ -158,20 +172,32 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #4193791        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #4193792        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #4193788        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #4193786        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #4118414        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #4193781        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -182,6 +208,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #4193800        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
@@ -190,20 +218,34 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N3     | #3456111        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #1619801        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #4193790        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #4193787        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3AE   | #4193784        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Premium      | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | C1-Pro          | #4193714        | ARM64_ERRATUM_4193714       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Ultra        | #4193780        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
 |                |                 | #562869,1047329 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
@@ -256,6 +298,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | Carmel Core     | N/A             | NVIDIA_CARMEL_CNP_ERRATUM   |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | Olympus core    | T410-OLY-1029   | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 GICv3/4.x  | T241-FABRIC-4   | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | NVIDIA         | T241 MPAM       | T241-MPAM-1     | N/A                         |
@@ -323,3 +367,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/Makefile b/Makefile
index 408f070d49b8..39baa3275447 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..10c69474f276 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1154,6 +1154,44 @@ config ARM64_ERRATUM_4193714
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4118414
+	bool "Various: Completion of affected memory accesses might not be guaranteed by completion of a TLBI"
+	default y
+	select ARM64_WORKAROUND_REPEAT_TLBI
+	help
+	  This option adds a workaround for the following errata:
+
+	  * ARM C1-Premium erratum 4193780
+	  * ARM C1-Ultra erratum 4193780
+	  * ARM Cortex-A76 erratum 4193800
+	  * ARM Cortex-A76AE erratum 4193801
+	  * ARM Cortex-A77 erratum 4193798
+	  * ARM Cortex-A78 erratum 4193791
+	  * ARM Cortex-A78AE erratum 4193793
+	  * ARM Cortex-A78C erratum 4193794
+	  * ARM Cortex-A710 erratum 4193788
+	  * ARM Cortex-X1 erratum 4193791
+	  * ARM Cortex-X1C erratum 4193792
+	  * ARM Cortex-X2 erratum 4193788
+	  * ARM Cortex-X3 erratum 4193786
+	  * ARM Cortex-X4 erratum 4118414
+	  * ARM Cortex-X925 erratum 4193781
+	  * ARM Neoverse-N1 erratum 4193800
+	  * ARM Neoverse-N2 erratum 4193789
+	  * ARM Neoverse-V1 erratum 4193790
+	  * ARM Neoverse-V2 erratum 4193787
+	  * ARM Neoverse-V3 erratum 4193784
+	  * ARM Neoverse-V3AE erratum 4193784
+	  * Microsoft Azure Cobalt 100 4193789
+	  * NVIDIA Olympus erratum T410-OLY-1029
+
+	  On affected cores, some memory accesses might not be completed by
+	  broadcast TLB invalidation.
+
+	  This issue is also known as CVE-2025-10263.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7b518e81dd15..1b9f0cda1336 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -97,8 +97,10 @@
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
 #define ARM_CPU_PART_CORTEX_A720AE	0xD89
+#define ARM_CPU_PART_C1_ULTRA		0xD8C
 #define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 #define ARM_CPU_PART_C1_PRO		0xD8B
+#define ARM_CPU_PART_C1_PREMIUM		0xD90
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -189,8 +191,10 @@
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_CORTEX_A720AE MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720AE)
+#define MIDR_C1_ULTRA MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_ULTRA)
 #define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_C1_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PRO)
+#define MIDR_C1_PREMIUM MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_C1_PREMIUM)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5377e4c2eba2..4b0d5d932897 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -340,7 +340,37 @@ static const struct arm64_cpu_capabilities arm64_repeat_tlbi_list[] = {
 		ERRATA_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
 	},
 #endif
-	{},
+#ifdef CONFIG_ARM64_ERRATUM_4118414
+	{
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+			MIDR_ALL_VERSIONS(MIDR_C1_PREMIUM),
+			MIDR_ALL_VERSIONS(MIDR_C1_ULTRA),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+			MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
+			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
+			MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
+			{}
+		})),
+	},
+#endif
+	{}
 };
 #endif
 
@@ -693,7 +723,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
 	{
-		.desc = "Qualcomm erratum 1009, or ARM erratum 1286807, 2441009",
+		.desc = "Broken broadcast TLBI completion",
 		.capability = ARM64_WORKAROUND_REPEAT_TLBI,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = cpucap_multi_entry_cap_matches,
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8b6722ff8590..d17bd91490ee 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -544,10 +544,10 @@ static const struct attribute_group driver_override_dev_group = {
  */
 int bus_add_device(struct device *dev)
 {
-	struct subsys_private *sp = bus_to_subsys(dev->bus);
+	struct subsys_private *sp;
 	int error;
 
-	if (!sp) {
+	if (!dev->bus) {
 		/*
 		 * This is a normal operation for many devices that do not
 		 * have a bus assigned to them, just say that all went
@@ -556,6 +556,13 @@ int bus_add_device(struct device *dev)
 		return 0;
 	}
 
+	sp = bus_to_subsys(dev->bus);
+	if (!sp) {
+		pr_err("%s: cannot add device '%s' to unregistered bus '%s'\n",
+		       __func__, dev_name(dev), dev->bus->name);
+		return -EINVAL;
+	}
+
 	/*
 	 * Reference in sp is now incremented and will be dropped when
 	 * the device is removed from the bus
diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index fb3e42f21362..3d1d1eafb473 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -133,6 +133,9 @@ struct faux_device *faux_device_create_with_groups(const char *name,
 	struct device *dev;
 	int ret;
 
+	if (!faux_bus_root)
+		return NULL;
+
 	faux_obj = kzalloc_obj(*faux_obj);
 	if (!faux_obj)
 		return NULL;
@@ -232,19 +235,12 @@ EXPORT_SYMBOL_GPL(faux_device_destroy);
 
 int __init faux_bus_init(void)
 {
+	struct device *root;
 	int ret;
 
-	faux_bus_root = kzalloc_obj(*faux_bus_root);
-	if (!faux_bus_root)
-		return -ENOMEM;
-
-	dev_set_name(faux_bus_root, "faux");
-
-	ret = device_register(faux_bus_root);
-	if (ret) {
-		put_device(faux_bus_root);
-		return ret;
-	}
+	root = root_device_register("faux");
+	if (IS_ERR(root))
+		return PTR_ERR(root);
 
 	ret = bus_register(&faux_bus_type);
 	if (ret)
@@ -254,12 +250,14 @@ int __init faux_bus_init(void)
 	if (ret)
 		goto error_driver;
 
+	faux_bus_root = root;
+
 	return ret;
 
 error_driver:
 	bus_unregister(&faux_bus_type);
 
 error_bus:
-	device_unregister(faux_bus_root);
+	root_device_unregister(root);
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index e452444b33b0..99bc9ad67d5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -174,7 +174,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	const u64 max_bytes = SZ_2G;
 
 	struct hmm_range *hmm_range = &range->hmm_range;
-	unsigned long timeout;
 	unsigned long *pfns;
 	unsigned long end;
 	int r;
@@ -201,15 +200,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
 
-		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-
-retry:
 		r = hmm_range_fault(hmm_range);
-		if (unlikely(r)) {
-			if (r == -EBUSY && !time_after(jiffies, timeout))
-				goto retry;
+		if (unlikely(r))
 			goto out_free_pfns;
-		}
 
 		if (hmm_range->end == end)
 			break;
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..c7b8c4ff7a33 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -519,6 +519,13 @@ static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
 	return NULL;
 }
 
+static void hidinput_cleanup_battery(void *res)
+{
+	struct hid_battery *bat = res;
+
+	list_del(&bat->list);
+}
+
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
@@ -610,6 +617,12 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 
 	power_supply_powers(bat->ps, &dev->dev);
 	list_add_tail(&bat->list, &dev->batteries);
+
+	error = devm_add_action_or_reset(&dev->dev,
+					 hidinput_cleanup_battery, bat);
+	if (error)
+		return error;
+
 	return 0;
 
 err_free_name:
diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..92d643a14196 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -929,11 +929,11 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 			send_sigio_to_task(p, fown, fd, band, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigio_to_task(p, fown, fd, band, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
@@ -975,11 +975,11 @@ int send_sigurg(struct file *file)
 			send_sigurg_to_task(p, fown, type);
 		rcu_read_unlock();
 	} else {
-		read_lock(&tasklist_lock);
+		rcu_read_lock();
 		do_each_pid_task(pid, type, p) {
 			send_sigurg_to_task(p, fown, type);
 		} while_each_pid_task(pid, type, p);
-		read_unlock(&tasklist_lock);
+		rcu_read_unlock();
 	}
  out_unlock_fown:
 	read_unlock_irqrestore(&fown->lock, flags);
