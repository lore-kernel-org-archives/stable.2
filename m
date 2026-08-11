Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F834678E;
	Tue, 11 Aug 2026 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486528; cv=none; b=nCGjo5UClPBjzQGCYeYBoFtLu3M7U45igFHMdqTNKs1bt4JdvM3oVCCzTObUDmwNHoRev7xMsK3lcEUxMEmsjON5kUsTmRWOOJzFvRl0jMjQaZqkCq9egjQj6GZEz3x2zBVNwOUurYa8wbsH2YocOjq9OyfWsY5tdMn2aCe7agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486528; c=relaxed/simple;
	bh=YPrG4nrZElGOdTsycHzrRfWO4pDavR67fOeBSr39O78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of/tRedGpCFEfTFEJ3Q25Q1+MZil3x5ywNVQWvJvzFtc6GQNh2ROLlkiAKct7VaCMDK5MUtSZlEZY/s3ZfGBzTZ6LEfGCqCLmtn2L7WoGeXffSs3IaK9/my9PaDOKITSB5ugt9yJ/97dCic90Wz01H0wRtsCxRgxllXpFvjzykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8Id2yQz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8Id2yQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486526; x=1818022526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YPrG4nrZElGOdTsycHzrRfWO4pDavR67fOeBSr39O78=;
  b=D8Id2yQzEE56STqu6AsPNm9zwhLc37ygFc8IfudNSyc35mCZfAyatQGM
   3LsyNMzwrkzTy/hVOBCocRlVWkK/kcg2KvB7Lc8OCEZ/TtGMj6li8QrjD
   MWGvwrdHiku4sbkXEJ4mQA8VMvJYRd8I8/NT+OGgbEIaDD54JPAigO5vu
   lN/Xeuvp0vyu5NqUsj70h97CTMTRkm3mS/cj7e/SqTFWwmTs7sH74+NIf
   oiaHJtzm5dVHvsIpQ2CES4KPUaxhH9CRdjtvRtpeTQLs4Mc3y1QQnwE3B
   1H8ruvMMwqq471ME8LztIB9KtTPgFXov2YbSgqTxmnZ2N82L3KYBlyO69
   w==;
X-CSE-ConnectionGUID: IsthR/AuRq2JhHcGWkF+jQ==
X-CSE-MsgGUID: CFfLsppnRPKRGe3+JTR8Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97374768"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97374768"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:15:24 -0700
X-CSE-ConnectionGUID: KSECPpFGR/e7TFH7wF1AQQ==
X-CSE-MsgGUID: 9G+EX+P8RuCthCOwJRGFAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262138180"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2026 15:15:25 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/6] platform/x86: ISST: Validate logical CPU id and clos id
Date: Tue, 11 Aug 2026 15:15:09 -0700
Message-ID: <20260811221514.3905817-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
References: <20260811221514.3905817-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate max CLOS ID and logical CPU ID for core power feature.
Reject any clos level or logical CPU number greater than the
supported maximum. These are used to calculate MMIO offset.

Fixes: 12a7d2cb811d ("platform/x86: ISST: Add SST-CP support via TPMI")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel/speed_select_if/isst_tpmi_core.c      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index f1b6109521c5..a5ab3be92afa 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -649,6 +649,8 @@ static long isst_if_core_power_state(void __user *argp)
 #define SST_CLOS_CONFIG_MAX_START	16
 #define SST_CLOS_CONFIG_MAX_WIDTH	8
 
+#define SST_MAX_CLOS			3
+
 static long isst_if_clos_param(void __user *argp)
 {
 	struct tpmi_per_power_domain_info *power_domain_info;
@@ -657,6 +659,9 @@ static long isst_if_clos_param(void __user *argp)
 	if (copy_from_user(&clos_param, argp, sizeof(clos_param)))
 		return -EFAULT;
 
+	if (clos_param.clos > SST_MAX_CLOS)
+		return -EINVAL;
+
 	power_domain_info = get_instance(clos_param.socket_id, clos_param.power_domain_id);
 	if (!power_domain_info)
 		return -EINVAL;
@@ -703,6 +708,8 @@ static long isst_if_clos_param(void __user *argp)
 #define SST_CLOS_ASSOC_CPUS_PER_REG	16
 #define SST_CLOS_ASSOC_BITS_PER_CPU	4
 
+#define SST_CLOS_ASSOC_MAX_LOGICAL_CPU	63
+
 static long isst_if_clos_assoc(void __user *argp)
 {
 	struct isst_if_clos_assoc_cmds assoc_cmds;
@@ -729,9 +736,15 @@ static long isst_if_clos_assoc(void __user *argp)
 		if (copy_from_user(&clos_assoc, ptr, sizeof(clos_assoc)))
 			return -EFAULT;
 
+		if (clos_assoc.clos > SST_MAX_CLOS)
+			return -EINVAL;
+
 		if (clos_assoc.socket_id >= topology_max_packages())
 			return -EINVAL;
 
+		if (clos_assoc.logical_cpu > SST_CLOS_ASSOC_MAX_LOGICAL_CPU)
+			return -EINVAL;
+
 		cpu = clos_assoc.logical_cpu;
 		clos = clos_assoc.clos;
 
-- 
2.53.0

