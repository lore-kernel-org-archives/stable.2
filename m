Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A361FBE90;
	Fri, 24 Jul 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925447; cv=none; b=gqxdeLu+Vsd7tUtmKK090Q6LZtkHFZ9QFjslbiuSERjXDqhLIOh7q8b66SY1dE78a4o05vftOysNDJpj7OL3D24jDiLHclp20XCDVLI97tqyzhmJ+ygWpBkqemp4jNPK0qm6Gb5RFMar4Z5UXsb5KvZuLEZlGjn5Gat0QydS2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925447; c=relaxed/simple;
	bh=3dNeVbOoObT0F2jKa2/XLl7OoZvfQY9f+dMe0NNObR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEMTLv7f7+GPecdxaA5z79wWHZZLr21LXk6j8jMRRh00mQXnaa88oicIr+YW+15tzADRBI8uTHq2yNhXG3zDR4ZUEblIR3HOfELIi3tbtRNZhThiZfzsOArszF1E2I3sLxSCKQAMj3bay8P9oMvrpJyLTS93tiR+K4Qk20SZ54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpN0Nsup; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpN0Nsup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784925445; x=1816461445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3dNeVbOoObT0F2jKa2/XLl7OoZvfQY9f+dMe0NNObR0=;
  b=GpN0Nsup8EZ+NGeRZ3QaPwnYjQMtNnY4qqD18hugZuE5BWphbBJw1m1g
   eo+2IYrn7/hpKtCE1yRko1V0Wf9NKqh7p+aEMnUOwGrkjX7GhlKmki3yf
   lSc3tFV4ON7QQiGJjiRuwWt5tCJDvDnc+1DfVGgLlAdQfjJmdsxIGd3Ff
   yhb11CEV4DL2Dk5mZJb/WBnhhOf4kYOHoIBFP5zihjKHCXJMOvRyQs9zz
   eRN1NHk4hRJBgmVLMB053VtxyUpwzofHJlGgrrtqViYq0uHeYbE0CD1lj
   hhKppfKvzCh6/ziG4Vo7qxq/aCVXC4rv5iNO/YwV3Sbxiw09C4TA080Wq
   g==;
X-CSE-ConnectionGUID: 40gnMQusQsmt0asvpqKaVw==
X-CSE-MsgGUID: g0jeKDCfQBqOPD4dstb3Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103008231"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="103008231"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:25 -0700
X-CSE-ConnectionGUID: X1pKU5n9Steq+W9yob/Mlw==
X-CSE-MsgGUID: 2kF403ExTF+b84kiHmPH2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="258872380"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	stable@vger.kernel.org,
	Dan Williams <djbw@kernel.org>
Subject: [PATCH v3 1/3] cxl/pmem: Format the nvdimm serial number as unsigned decimal
Date: Fri, 24 Jul 2026 13:37:17 -0700
Message-ID: <2c673a5ba0a8fa93ad160578e193bd556091fa95.1784924949.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784924949.git.alison.schofield@intel.com>
References: <cover.1784924949.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL NVDIMM security passphrase key description and the nvdimm 'id'
sysfs attribute are both derived from the CXL device serial number,
but the serial number is not formatted consistently.

The key description is formatted in hexadecimal while the 'id'
attribute is formatted in decimal. As a result, ndctl stores the key
using a decimal description while the kernel later looks it up using
a hexadecimal description. For serial numbers of 10 and above, the
descriptions no longer match, preventing automatic unlock after
reboot.

The decimal formatting has a second problem: both the key description
and the 'id' attribute use the signed %lld format for a u64 PCIe
Device Serial Number. Devices whose vendor OUI sets bit 63, such as
Montage CXL devices, appear with negative decimal serial numbers.

Format the security key description and 'id' attribute as unsigned
decimal, %llu, and document that the 'id' attribute is an unsigned
decimal value.

The key lookup mismatch was exposed by CXL unit test cxl-security.sh
when cxl_test mock serial numbers were extended to 10 and above.

A work around is described for ndctl load-key users here:
https://github.com/pmem/ndctl/issues/299

Cc: <stable@vger.kernel.org>
Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
Acked-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
 drivers/cxl/core/pmem.c                    | 10 ++++++----
 drivers/cxl/cxl.h                          |  3 ++-
 drivers/cxl/pmem.c                         |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index 64eb8f4c6a41..46dafd8482b9 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -48,7 +48,8 @@ What:		/sys/bus/nd/devices/nmemX/cxl/id
 Date:		November 2022
 KernelVersion:	6.2
 Contact:	Dave Jiang <dave.jiang@intel.com>
-Description:	(RO) Show the id (serial) of the device. This is CXL specific.
+Description:	(RO) Show the id (serial) of the device, formatted as an
+		unsigned 64-bit decimal value. This is CXL specific.
 
 What:		/sys/bus/nd/devices/nmemX/cxl/provider
 Date:		November 2022
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 68462e38a977..5a3bb7e8a1f1 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -219,12 +219,14 @@ static struct cxl_nvdimm *cxl_nvdimm_alloc(struct cxl_nvdimm_bridge *cxl_nvb,
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_nvdimm_type;
 	/*
-	 * A "%llx" string is 17-bytes vs dimm_id that is max
-	 * NVDIMM_KEY_DESC_LEN
+	 * dev_id is the nvdimm dimm_id used for security key lookup.
+	 * It must match id_show(), which emits the CXL serial as an
+	 * unsigned decimal. A u64 decimal string is at most 20 digits
+	 * plus NUL.
 	 */
-	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 17 ||
+	BUILD_BUG_ON(sizeof(cxl_nvd->dev_id) < 21 ||
 		     sizeof(cxl_nvd->dev_id) > NVDIMM_KEY_DESC_LEN);
-	sprintf(cxl_nvd->dev_id, "%llx", cxlmd->cxlds->serial);
+	sprintf(cxl_nvd->dev_id, "%llu", cxlmd->cxlds->serial);
 
 	return cxl_nvd;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..d683ae5e0f7d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -503,7 +503,8 @@ struct cxl_nvdimm_bridge {
 	struct nvdimm_bus_descriptor nd_desc;
 };
 
-#define CXL_DEV_ID_LEN 19
+/* Holds a u64 serial as a decimal string: up to 20 digits + NUL */
+#define CXL_DEV_ID_LEN 21
 
 enum {
 	CXL_NVD_F_INVALIDATED = 0,
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 261dff7ced9f..a9f50281875d 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -52,7 +52,7 @@ static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_dev_state *cxlds = cxl_nvd->cxlmd->cxlds;
 
-	return sysfs_emit(buf, "%lld\n", cxlds->serial);
+	return sysfs_emit(buf, "%llu\n", cxlds->serial);
 }
 static DEVICE_ATTR_RO(id);
 
-- 
2.37.3

