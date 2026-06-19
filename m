Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7F31D72E;
	Fri, 19 Jun 2026 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848781; cv=none; b=tfVx6fx6mm4cjOx6j6UOkgOiUk39ReBLTiN6Wo3vLXGrImU4IPO0V528CrYC+MvI4pSQFqP3MCYSE34aVXsvqSTcahBvQAotJ5XFr6wXKN4PFaKmRd4wED+0r9qPqhp2w0N5pxX3ZtTjhXeXz1pPkbCqxal5oL0AyWYYWzaYmfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848781; c=relaxed/simple;
	bh=ul6L67vfdokeUptdpdT9dCOfB07PN+0828/A0Bnpuyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRUcUKzSAkzJ99w0BJXjqsXT2pbZTwDDi8QlJ8ONnazFNsxdjXo6CzQf5887k5okbsB0mDFW82T7Kkuq1FKBEMl/+ihVS1pE2V3nOpmF+hc+aDxvbddPKiTYZSQSeMtsrHVfGTuD1tMWY8G5n0roacvKcJk4zNqXRUYj9uZwqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fKC6PkdD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fKC6PkdD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781848779; x=1813384779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ul6L67vfdokeUptdpdT9dCOfB07PN+0828/A0Bnpuyc=;
  b=fKC6PkdD0DzZ+CLmK33XapYJ8FTShNOobT9LsoPSrb5PTj1xhVI+e9d3
   guG1s7MocFUk8ukH/PCS2GTFtM6hUq4tfXeS7VoXtjq4Ag/TCdvGR/jVp
   +1yJn2YyiRZKzssZhoMmlKl6FEg19ztLxDZ/W55x73Pre1RuE+ZBdyEuo
   FLCbwcZvpujSGGRM069ZZiN84zNyKVmgV3dDvLDN0u1zm1OdAgrlFKFtV
   5Hf8RQOS1q2DRZOusqMzBW/+nOFV9rhu9+3k0P+7wWc1T6T/Z6ct9v3sH
   KfX5aVYaKbLFKt5kZtiQSXP/1cWNGdHao35m2BEwoxir7GcN7svtvX87A
   w==;
X-CSE-ConnectionGUID: W00M7ciXS32NiNpQbnu1iw==
X-CSE-MsgGUID: UZ037YfWSGm/42djcI9Jlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="108244386"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="108244386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 22:59:35 -0700
X-CSE-ConnectionGUID: noD0j7qBSdqjaQcPFw589w==
X-CSE-MsgGUID: n371ufhbTyuCsUmrlmDhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="272622546"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 22:59:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH] cxl/pmem: Format nvdimm serial numbers as decimal
Date: Thu, 18 Jun 2026 22:59:29 -0700
Message-ID: <20260619055932.1354182-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL NVDIMM security passphrase key is looked up by the description
"nvdimm:" followed by the device serial string. For serial numbers of
10 and above, the kernel auto-unlock path fails to find the key
because ndctl names it with a decimal serial and the kernel uses hex.

That means a passphrase-protected device cannot be unlocked after a
reboot, and the pmem namespaces it backs do not come up. Devices
without an enrolled passphrase are unaffected.

The mismatch occurs for any serial number of 10 and above. Since CXL
device serial numbers are vendor-assigned 64-bit values, that covers
essentially all real hardware once security is enabled.

The 'id' sysfs attribute is established ABI that ndctl consumes as
decimal, so format the kernel's serial string the same way. A u64
decimal string requires up to 20 digits plus a NUL byte, so grow
CXL_DEV_ID_LEN to fit it.

The issue was exposed by CXL unit test cxl-security.sh when cxl_test
mock serial numbers were recently extended to 10 and above.

Cc: <stable@vger.kernel.org>
Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/pmem.c | 10 ++++++----
 drivers/cxl/cxl.h       |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 68462e38a977..2ccdf04c1f43 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_nvdimm_type;
 	/*
-	 * A "%llx" string is 17-bytes vs dimm_id that is max
-	 * NVDIMM_KEY_DESC_LEN
+	 * dev_id becomes the nvdimm dimm_id used for security key
+	 * lookups. Match the decimal serial emitted by the CXL 'id'
+	 * sysfs attribute. A u64 decimal string requires 20 digits
+	 * plus a NUL byte and must still fit in NVDIMM_KEY_DESC_LEN.
 	 */
-	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
+	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
 		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
-	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
+	sprintf(cxl_nvd->dev_id, "%lld", cxlmd->cxlds->serial);
 
 	return cxl_nvd;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1297594beaec..3463faeb8a15 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -487,7 +487,8 @@ struct cxl_nvdimm_bridge {
 	struct nvdimm_bus_descriptor nd_desc;
 };
 
-#define CXL_DEV_ID_LEN 19
+/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
+#define CXL_DEV_ID_LEN 21
 
 enum {
 	CXL_NVD_F_INVALIDATED = 0,

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.37.3

