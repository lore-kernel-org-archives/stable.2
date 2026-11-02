Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646921;
	b=inAzAm/CZOFFbWaFpKei7lDSWya7WeCRid+qdgwWiSI1dPOaNTcaS/LbW5+3T3cssx1Z
	 YXsxrkFhT2NraaZw5mUywtCrY7ZczIemGxy3HBCU09XbjI4FPRTuhcsXIDdCGC6+C5j1R
	 QsQj7gWl13DGOxhSBDvWUkepC7JYhDdZyXnCtzFe848grXrYl8E9N+y/mekYoXGT3caNM
	 aZ+CTzdGdzJbrieWoVkuUIUFsyLVN+oQxR/BOeMBCRqTFoKUdfxJ9ox0dTS8UQZIti94c
	 rBZHckcDHNpKYKPE5JRNHW2wfr6zJlhs2hVCPM8P4MgmzNF20Zky3kOVwAXgOjRg02A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646921;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0RnqXmZ+9Ani1e/AhZz6uPTzWljFfwzbO2WFi9bEg84=;
	b=oP3fbdnL5IuvObkJlkiZZQmP/6+XO9gdgDI0uoPJN7mSWIAMpvpRhljClgyp5gMa5BAm
	 IEjvwWSfB9gERs6BdYMsgSnqDm5/M39ENZ81a/iAmt7M7s8TVguoY1nQFDvzsI1GIwaVM
	 o+ihgmc/PBr+KHfyr2BJf8oYEzCw4mg5dQOwcaTpme0E1OgNYjASly++f7uGAj+3YMu++
	 X218Wz6JOji7m3+6VDVFcdyBU/LmKy6orFwqgV5LepK/KuLKcuQcTstIAjaYDYTe+Ztef
	 bUFkTd6sIVmnOhL8Hp5/Mork/anv4iVzKeY8UgmtTWusE/xygRtC7AlX3da0tgulpKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBGVh74M;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF71606D803;
	Mon,  2 Nov 2026 19:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BF71606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VBGVh74M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793646920; x=1825182920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oZn562NDFpjPvDOkLcZOgauyidMK7m/Dk+nYQr9ns0=;
  b=VBGVh74Moa/lqc35SRVfhXKP8Har40RsdAFEbrsZW6prm+iLovsccQfy
   IgNYSZ0WB9gcUAxVdbDHVkE0iYecHIRWhbspnr61xHosBH7MsUSWnBknV
   qINge2rwP12qA/STsTgU6IgrkKjlEwWFCN/3Dmxdn7db/cDCFzYrvK6dx
   7p0TV8IXXvctg0pOubURYBsU2s/cUBaY3sNkHnsV8jGfOpoHP/ctB3Mtz
   xo+u7Uz3SzWq8o+D3ixon4CUbJSs0d+ib2E0Tg3QAdgzLvMlehD2bl71+
   YdJB1zYrZwH2eQL8/y1awmtE6v450vxb+D5TRpy65LIPgh25pax49p+Ix
   g==;
X-CSE-ConnectionGUID: fRs9oZhyQ7C6ctsXSNUzYQ==
X-CSE-MsgGUID: L5/VHBx+S3uucCP+MhvP0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2383482"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2383482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:19 -0800
X-CSE-ConnectionGUID: Nz/FKZNtSxCRphNvWd7ndA==
X-CSE-MsgGUID: /8KGo1aoRPyD0o5XFbQWtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6294149"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:19 -0800
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
	stable@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 3/4] cxl/mbox: Treat unknown device return codes as errors
Date: Mon,  2 Nov 2026 11:15:13 -0800
Message-ID: <1c822ac0361e7aecb318b73f0288ad1c862517ff.1793645996.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793645996.git.alison.schofield@intel.com>
References: <cover.1793645996.git.alison.schofield@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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

Found with a QEMU Type-3 device returning codes 001Fh and 0020h, which are
defined in CXL 4.0 but not yet recognized by Linux [1].

[1] https://lore.kernel.org/linux-cxl/20260929060747.3550005-1-huanggaobin23@semi.ac.cn/

Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
Cc: stable@vger.kernel.org
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 35268d1c387c..e64fb09fe79a 100644
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
@@ -206,13 +207,18 @@ static const
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

