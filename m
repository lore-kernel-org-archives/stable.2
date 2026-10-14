Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B7414410;
	Wed, 14 Oct 2026 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951486; cv=none; b=AqbQVpxgJYiTvRKye1dzymC789kr/qaH4fD8gHDscauQEUTJWWKj1IzYzaH2gD+/SLfORk7aHDQnOT9sGINtmaJ4xGBbhOgr8XJ+/zY1KqQgaym5hPj6XK+ycYnv3uthTBCNZKHdTGTmpKV/DEKg8uS5sjBKSIPg0x16g4a1msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951486; c=relaxed/simple;
	bh=57PmCYmLxLvDz9SI9ANqRzbtEm8aJkNkAN3UuTBiU20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMmLF1Ff8620eKPxCmb0sfrLjHS/B0kX4GzsmkBoFTOAgl+eOuprtgi/dAxCYmkMJIO+MSRk9wtKckRnob0U6ur5VvjWqSBGL2BSeQt0DBMnp0QJgM6COQWjNlL4ybFzETbg9n9alKCP/XCzDfGQ0gg3Y1wzYL8wFPcx7MYTkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UC4RrXxt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UC4RrXxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791951484; x=1823487484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57PmCYmLxLvDz9SI9ANqRzbtEm8aJkNkAN3UuTBiU20=;
  b=UC4RrXxtv0Lh5jskRjckQSbu9x8kB5NYqoFd6fhgTnEqzvoHz9XqOp3I
   F0VPC7K63HwLk8OJ9UsvTOSa4/ozITTe000oX4T23DXyhr6RKx5U2vKln
   D2McJE1h4cMNAownuyy1SZ3yPw0zWF67p9DhqfU8LcUlPOmUdFQ3qkfOi
   GdMjZiFglwJ7CD8JECCjVozWDimLblyBNYxeyhSuvLcrxSpq6A4Qdg4XG
   gVSsCMGOVFMn1DhrcpfBuVq/SKtg8pLzdWjqKR9Cp/AfPMUkLvN8YAVbd
   55GZerNQGI4Y4g2ISE6ygurjK4bpMU0OYhlkFdv/O2YIIvQDcYW6tPanD
   Q==;
X-CSE-ConnectionGUID: rXD3vtjCRpmopV1qHNX6dg==
X-CSE-MsgGUID: f4Rhf+D7QC6IWDwlWckqrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="696250"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="696250"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:03 -0700
X-CSE-ConnectionGUID: SyvM+5fKTgKql17cI9A5kQ==
X-CSE-MsgGUID: rVGfMfgnRh+CDtPGewk6qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1783581"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
	Gaobin Huang <huanggaobin23@semi.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] cxl/mbox: Treat unknown device return codes as errors
Date: Tue, 13 Oct 2026 21:17:54 -0700
Message-ID: <3ed8f5db3f21c937d8783f31ee6faca3703ba72a.1791949910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791949910.git.alison.schofield@intel.com>
References: <cover.1791949910.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gaobin Huang <huanggaobin23@semi.ac.cn>

cxl_mbox_cmd_rc2errno() and cxl_mbox_cmd_rc2str() use the device's 16-bit
return code to index cxl_mbox_cmd_rctable[]. A return code outside the
table's range causes an out-of-bounds read, potentially allowing a failed
command to be reported as successful.

Check the return code against the table size. Report unknown codes as
-ENXIO, the errno used for most device-reported errors, and describe them
as "unknown return code".

Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are defined in CXL 4.0 but not yet recognized by Linux [1].

[1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/

Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
Cc: stable@vger.kernel.org
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This patch is independently applicable and backportable. It is
intentionally introduced here as a lead in to the kunit patch
that backstops this fix.


 drivers/cxl/cxlmem.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..357d0d873e87 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/array_size.h>
 #include <linux/node.h>
 #include <cxl/event.h>
 #include <cxl/mailbox.h>
@@ -205,13 +206,18 @@ static const
 struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
 #undef C
 
+/* The return code comes from the device and may be one this table lacks */
 static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
 {
+	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
+		return "unknown return code";
 	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
 }
 
 static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
 {
+	if (mbox_cmd->return_code >= ARRAY_SIZE(cxl_mbox_cmd_rctable))
+		return -ENXIO;
 	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
 }
 
-- 
2.37.3

