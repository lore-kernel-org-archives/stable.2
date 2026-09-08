Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28781258EF3
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877332; cv=none; b=ClDp0h/IUMJrKnWSH688sJnfeKPolikxpm9KsJKdatj+5lghMQh/d4MUY898aqSaP2H2e9y+Q6RwtUjXmvOeUsKuOJflYPa/DMasry+yOF12tyXa7Icf1XJDUn8KzeqDd61aa99iAcXn7jJlDiN07gv1VB8fTMUJeVPb1oQtuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877332; c=relaxed/simple;
	bh=Ibj5uMLqtAXhyWcvht5Nh0wJBbp7+x40ZtmQrmdjrEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWpXrHNlF4fJkvm/X+3gvJ48qnDBpT5+m8Xil4sZKksZKuseDi+CyR6Bm8NSVx+lsz1XMwawFud8f+X7roPRYYPkzXT30ySO6VY5l8o66oHPW56AboTPn1Qv/TD4u1NWyVSzHsv7nzp5l6op9sRHNY2Ezzx38AqCpZeiZsGVmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oEBE5NpX; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oEBE5NpX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=S7s/9N9uO/V0zChLYaRJHk624dUiqvODSn1DeHB9W9g=;
	b=oEBE5NpXzuCnGV9Xo8PURX5GM4IU8VTuu5okrSWyFFz2hNbqfGtJAhS8TNvHaU6PxQs0PnMat
	VAk0AacYGxjqcMHC6FTsXn22oR8fyWuMx+yJu5nOy+tapOUqj8meccBzmmUqXEMC2XW2QmxlVjt
	NlvXYLVA5S8I7Cdm4eK1gzc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hfQpK074vz1cyVb
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:11:05 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (unknown [7.202.181.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 34B5640572
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:21:58 +0800 (CST)
Received: from dggphicprd10024.huawei.com (10.243.6.112) by
 kwepemf100015.china.huawei.com (7.202.181.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 22:21:57 +0800
From: Abbott Liu <liuwenliang@huawei.com>
To: <patchwork@huawei.com>, <liuwenliang@huawei.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v3 2/3] RAS: Fix out-of-bounds read when tracing arm_event
Date: Tue, 8 Sep 2026 22:21:36 +0800
Message-ID: <20260908142137.45919-3-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908142137.45919-1-liuwenliang@huawei.com>
References: <20260908142137.45919-1-liuwenliang@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100015.china.huawei.com (7.202.181.14)

The vsei_len < 0 error path did not verify the pei_len and ctx_len.
When vsei_len is negative, section_length is too small to hold the
full record, yet pei_len and ctx_len were derived from
err_info_num/context_info_num and may describe regions beyond the
(long)err .. err + section_length buffer. To prevent trace_arm_event
from reading past the allocated record, sanitize the parameters:
recalculate ctx_len and pei_len based on section_length, limit them,
and set the corresponding pointers to NULL and lengths to 0 when
there is no remaining space.

pei_len and ctx_len become s32 so that the recalculated lengths can
be checked for negative values.

Fixes: 05954511b73e ("RAS: Report all ARM processor CPER information to userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 drivers/ras/ras.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 2540538a16a8..085fe2d980e5 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -58,10 +58,10 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	u8 *ven_err_data;
-	u32 ctx_len = 0;
+	s32 ctx_len = 0;
 	int n, sz, cpu;
 	s32 vsei_len;
-	u32 pei_len;
+	s32 pei_len;
 	u8 *pei_err, *ctx_err;
 
 	pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
@@ -87,14 +87,28 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 		pr_warn(FW_BUG "section length is too small\n");
 		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
 		vsei_len = 0;
+		ven_err_data = NULL;
+
+		ctx_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len);
+		if (ctx_len < 0) {
+			ctx_len = 0;
+			ctx_err = NULL;
+
+			pei_len = err->section_length - sizeof(struct cper_sec_proc_arm);
+			if (pei_len < 0) {
+				pei_len = 0;
+				pei_err = NULL;
+			}
+		}
+	} else {
+		ven_err_data = (u8 *)ctx_info;
 	}
-	ven_err_data = (u8 *)ctx_info;
 
 	cpu = GET_LOGICAL_INDEX(err->mpidr);
 	if (cpu < 0)
 		cpu = -1;
 
-	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+	trace_arm_event(err, pei_err, (u32)pei_len, ctx_err, (u32)ctx_len,
 			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
-- 
2.43.0

