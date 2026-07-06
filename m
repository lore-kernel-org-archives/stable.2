Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FC296BC8;
	Mon,  6 Jul 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344306; cv=none; b=H9e+XnFVqmU01AnxCoLxw4iki4mAw6MNLzVcAUnPU68E6P0G2yztnDPB6I1TpYIJyAIZ1wW37p6IvBghams5HimozcgSHUuv5e0veI/R6ZsVM6bOfYGJD1RnINDBRLtR5t4uphVbuG3AcIqccZkl/wSXZPiieI0cMB85M7t9lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344306; c=relaxed/simple;
	bh=OTokZRt5phSX/EHX4ehUkaFnY3khII19gH5YByBQvnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t/njjvNueMpZ0WQuPcG+hX2x/HJROv2mDn/4keEI5J217NZQLnMvFPOvl+KP3dkHz8jNwGrzjz+s3ViSAPtmajHmew2eUAwYi0m44gfWaiusIMWsECdCGVH0EC4QvFwuePQW45Zn9pF8InrRoxm3rWMyWmw+CYLte0gHiGBzWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk9g4a+X; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk9g4a+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783344305; x=1814880305;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=OTokZRt5phSX/EHX4ehUkaFnY3khII19gH5YByBQvnc=;
  b=Fk9g4a+XRFD+LfryCoxHaDrjhyrY2E9sYtrY/lANctZMA7egQjR0ZoKE
   8H5PLI5/MtiZJexlOsFsgyx97rJwC8tpLGP5vn2svfVBtLOv6pWvnFj8O
   6Tvm4OM3t6+JiFHOEBgswKUrmQz84SfvXvYdn+KdYe32HUUAO2J8E72Bm
   8QGe3q5s1ZEouA11RZBCSHgLHgS4/KmKXmmXZufD6papjq7tf4dpUqM+/
   cpbaYZ3VjcbVA8bia5bQlfwHVN63K0kgLv8BOwGkxprCmYJEmdGB9F0Wj
   gZTjTJ1jW22Dx7hZguuJiXtZuQCSz9xCD8VQhoUIbGQg2FMQn+CaNyZ0W
   w==;
X-CSE-ConnectionGUID: jIvuEFFfTVW3YAyl4yl0Kg==
X-CSE-MsgGUID: zdiLlb87QVaR25sIWTZlTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="87797699"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="87797699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:25:05 -0700
X-CSE-ConnectionGUID: 8j+OlK40TZ2G7zg7kLJhvQ==
X-CSE-MsgGUID: Vh8tCdpyR6q1M9JHPhs+ig==
X-ExtLoop1: 1
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 06:25:02 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Mon, 06 Jul 2026 16:01:30 +0300
Subject: [PATCH char-misc v2] mei: lb: fix incorrect type in assignment
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix_type_le-v2-1-586826351454@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNzQ7CIBCEX6XZsxigP7aefA/TNJaudpMWGiDEp
 uHdRTyZOU1m5psDHFpCB9fiAIuBHBmdjDwVoOaHfiGjKXmQXDa84SV70nvw+4bDgoyLtlIXnGT
 ZdZAWm8UUZ9r9O7dsJaegT9FMzhu7558gcuGHFPwPGQRLqpUceTs2VS1upD0uZ2VW6GOMHwqns
 ymxAAAA
X-Change-ID: 20260603-fix_type_le-0184c7ed2399
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badal Nilawar <badal.nilawar@intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Menachem Adin <menachem.adin@intel.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>, stable@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783342932; l=2290;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=OTokZRt5phSX/EHX4ehUkaFnY3khII19gH5YByBQvnc=;
 b=ljUjmX10BeqMCTSjpzlaCOo2fBRW8uLxnjp0hC3OdX50TfZIkHdPjA1ps+boRtQkA9mfWj2Tn
 mSYgntcMho8DgPaQj9zmEALwe7dlNmfwUWYyEPPo76VC7u12Br7YYku
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=

Fix the mix between __le32 and integer by casting
the MEI_LB2_CMD constant as __le32 while using it.

Fixes sparse waring:
drivers/misc/mei/mei_lb.c:284:32: sparse: sparse: restricted __le32 degrades to integer
drivers/misc/mei/mei_lb.c:330:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] command_id @@     got int @@
drivers/misc/mei/mei_lb.c:330:40: sparse:     expected restricted __le32 [usertype] command_id
drivers/misc/mei/mei_lb.c:330:40: sparse:     got int

Cc: stable@vger.kernel.org
Fixes: 773a43b8627f ("mei: lb: add late binding version 2")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605091533.79Zcv3CX-lkp@intel.com/
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Changes in v2:
- Move cast to where macro is actually compared and assigned (GregKH)
- Link to v1: https://lore.kernel.org/r/20260610-fix_type_le-v1-1-15c2b08b6451@intel.com
---
 drivers/misc/mei/mei_lb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/mei_lb.c b/drivers/misc/mei/mei_lb.c
index f6a258c2b838..9fa69acf28d5 100644
--- a/drivers/misc/mei/mei_lb.c
+++ b/drivers/misc/mei/mei_lb.c
@@ -281,7 +281,7 @@ static int mei_lb_check_response_v2(const struct device *dev, ssize_t bytes,
 			bytes, sizeof(rsp->rheader));
 		return -ENOMSG;
 	}
-	if (rsp->rheader.header.command_id != MEI_LB2_CMD) {
+	if (rsp->rheader.header.command_id != cpu_to_le32(MEI_LB2_CMD)) {
 		dev_err(dev, "Mismatch command: 0x%x instead of 0x%x\n",
 			rsp->rheader.header.command_id, MEI_LB2_CMD);
 		return -EPROTO;
@@ -327,7 +327,7 @@ static int mei_lb_push_payload_v2(struct device *dev, struct mei_cl_device *clde
 		if (sent_data + chunk_size == payload_size)
 			last_chunk = MEI_LB2_FLAG_LST_CHUNK;
 
-		req->header.command_id = MEI_LB2_CMD;
+		req->header.command_id = cpu_to_le32(MEI_LB2_CMD);
 		req->type = cpu_to_le32(type);
 		req->flags = cpu_to_le32(flags | first_chunk | last_chunk);
 		req->reserved = 0;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260603-fix_type_le-0184c7ed2399

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

