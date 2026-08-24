Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C10404BFF
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566093; cv=none; b=FOwzXTrzN2tByzyQ+E9Md/TIBCe77YKdvmoADDBRYZxbYosiR4M+uzos7QmQ1SFEP4n8LXdB7KPt2SCyn3WA0pZ4utgu829ruHjDq+GV0bnvxd1Qwq43kxN31gyxN08dDNJov1dhHmnWe1Prg2VKir6sZNs6Niz32d/NabubwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566093; c=relaxed/simple;
	bh=MK1bTeDP1txjyVCTeVzZWjn2zKbM2eitzwzAxKkMbKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qoou/kY6YYP1hfekf9xvWHTHg7Si895Xm2LuFs+2CuKEVLuRv0+G5C/YlMjbSE4ijPrt0ceFWDg3ybqXgiU4CWhizhpg//84xf4hvV67rzRNYerp06VWZTqL8XBxZahIiHVyM0XkxjMbM4rK7NAGdoU9ZJjvgZQQK/YSEMnX/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZmgTPFXq; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZmgTPFXq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=i1JAQEY3//d8jRV2AvfslPG4lR4vqzSVTZhK2aUj38Y=;
	b=ZmgTPFXqo36QaiJQjj8VDZQ1Cag6MKI0Dw8YekmknKaBSthaT3Zv3ShUEmhyARFC8RQ3s241c
	J7o5hWsGn5vkfQc6bewiriKKKLF7SfIP0qsbtiuKqB8g2S3+4js39jv7R7wtrv+fQMGwIIPQdvL
	nYwZPv7ACsAd0THvrIBZxgU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hT5t55nmfzpT0q
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:57:01 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (unknown [7.202.181.14])
	by mail.maildlp.com (Postfix) with ESMTPS id AC2974056D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 18:08:06 +0800 (CST)
Received: from dggphicprd10024.huawei.com (10.243.6.112) by
 kwepemf100015.china.huawei.com (7.202.181.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 18:08:06 +0800
From: Abbott Liu <liuwenliang@huawei.com>
To: <patchwork@huawei.com>
CC: Abbott Liu <liuwenliang@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] RAS: Fix out-of-bounds read when tracing truncated ARM processor errors
Date: Mon, 24 Aug 2026 10:07:16 +0000
Message-ID: <20260824100716.3507949-3-liuwenliang@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824100716.3507949-1-liuwenliang@huawei.com>
References: <20260824100716.3507949-1-liuwenliang@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100015.china.huawei.com (7.202.181.14)

When vsei_len is negative, section_length is too small to hold the
complete error record. The error path clamps vsei_len to zero but
leaves pei_len and ctx_len at the values derived from err_info_num
and context_info_num, which may describe data beyond
err + section_length, and trace_arm_event() memcpy()s pei_len bytes
from pei_err and ctx_len bytes from ctx_err into the trace buffers,
reading past the end of the allocated error record.

Sanitize the parameters on this path: clamp ctx_len and pei_len to
the space that is actually left in the section after the
cper_sec_proc_arm header, and set the corresponding pointers to NULL
and the lengths to zero when there is no space left at all. Also pass
NULL as the vendor error data, as the context walk may have left
ctx_info past the end of the record.

pei_len and ctx_len become s32 so that the recalculated lengths can
be checked for negative values, and the cpu lookup is moved above the
section length checks so that both paths can share the final
trace_arm_event() call.

Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
Cc: stable@vger.kernel.org
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 drivers/ras/ras.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 4ca3435d90a2..e37bf11d0926 100644
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
@@ -80,20 +80,31 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 		ctx_len += sz;
 	}
 
+	cpu = GET_LOGICAL_INDEX(err->mpidr);
+	if (cpu < 0)
+		cpu = -1;
+
 	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
 	if (vsei_len < 0) {
 		pr_warn(FW_BUG "section length: %d\n", err->section_length);
 		pr_warn(FW_BUG "section length is too small\n");
 		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
 		vsei_len = 0;
-	}
-	ven_err_data = (u8 *)ctx_info;
-
-	cpu = GET_LOGICAL_INDEX(err->mpidr);
-	if (cpu < 0)
-		cpu = -1;
-
-	trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
+		ven_err_data = NULL;
+		ctx_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len);
+		if (ctx_len < 0) {
+			ctx_len = 0;
+			ctx_err = NULL;
+			pei_len = err->section_length - sizeof(struct cper_sec_proc_arm);
+			if (pei_len < 0) {
+				pei_len = 0;
+				pei_err = NULL;
+			}
+		}
+	} else
+		ven_err_data = (u8 *)ctx_info;
+
+	trace_arm_event(err, pei_err, (u32)pei_len, ctx_err, (u32)ctx_len,
 			ven_err_data, (u32)vsei_len, sev, cpu);
 }
 
-- 
2.43.0

