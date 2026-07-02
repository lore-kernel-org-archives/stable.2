Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA72B9BA;
	Thu,  2 Jul 2026 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952258; cv=none; b=oPkiIdfZKZws/GNZVchyTdxCGzZt3F6MlDw/DpESZbN1Ol8elr890w4RO5LChX1B12mnPtX737lhAnQn2a68ZQ5G0+mEHTlr+l9CyM9tZ805vUe8zrGTgbRjSFfcmJJug5YxTxy+FC17k4OZ7v3guejJu8iqvhY7K62/ySs/jDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952258; c=relaxed/simple;
	bh=6RJz9T66+OhsFA81BL/SHfEOMk3438nuaMTFEC3yGgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRLnqu9yhun44sBoa9u4LqA4HueAosBPl5U22N/NGwEi5HBcxPuoGBZq6r4jfKJ5kzTgsnf5gM76qurA5IfvCiGJ5Xyy8B8oXr8U/d55uTx9zJuYPMApSoT6m3t23jZ3Mo7gFAwUypXT3dT9fSPxtV+0/b7R6aZLOWLcB1vAwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EL9wvESS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EL9wvESS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782952257; x=1814488257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6RJz9T66+OhsFA81BL/SHfEOMk3438nuaMTFEC3yGgQ=;
  b=EL9wvESS1b8OoPMq5BOG0hD3COViTxbTCePlhPKPLgkst2el6dhI9CcR
   fXN8aFOaek4pd05DZjDJ98ZCT7T7UnbWBRZDfOWd7UlR+8XKDr5UywPdH
   4wwCNWzQAoBP1hJfLG27rAqlAnxRxDMrDLP+OgSGTUmxzMjwr0bTrwc26
   bhCN6Zau7vn8Bbp6SA4yGAXJXniC3JzxLNNr2qHdKGOMpaiJ4WKUjI9Po
   RBaUKaVpNnbVloYDbW1QFrKoNxh9hGPfFLu6jSrs4gVt5EoqbYrn0BUcS
   6r/QwZK0dljSQnf7zgUvx0ZnCc5gTEpAM+to9iIY6b+499PUhY2Psn/wZ
   w==;
X-CSE-ConnectionGUID: t11JjtdHSiOIR5DRE70I2g==
X-CSE-MsgGUID: /6FSvT/TQiybo9hKD11bYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83565774"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83565774"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:55 -0700
X-CSE-ConnectionGUID: WdBrzBkwRMezzuZu/OI1hA==
X-CSE-MsgGUID: QGcuDEZMQTSqvKqlv3MV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="275920054"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:54 -0700
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
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] cxl/pmem: Format the nvdimm serial number as unsigned decimal
Date: Wed,  1 Jul 2026 17:30:44 -0700
Message-ID: <e124234e95069cb6512b9e1ab8a1335bf4fbed5e.1782948930.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1782948930.git.alison.schofield@intel.com>
References: <cover.1782948930.git.alison.schofield@intel.com>
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

The decimal formatting has a second problem. Both the key description
and the 'id' attribute use the signed %lld format for a u64 PCIe
Device Serial Number. Devices whose vendor OUI sets bit 63, such as
Montage CXL devices, appear with negative decimal serial numbers.

Format the security key description and 'id' attribute as unsigned
decimal, %llu, and document that the 'id' attribute is an unsigned
decimal value.

The key lookup mismatch was exposed by CXL unit test cxl-security.sh
when cxl_test mock serial numbers were extended to 10 and above.

Cc: <stable@vger.kernel.org>
Fixes: b5807c80b5bc ("cxl: add dimm_id support for __nvdimm_create()")
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

