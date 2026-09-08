Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8987556BA9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877335; cv=none; b=V03wlQaO/AD6y7rCdDClaSkmuXUn7GMLYPhbunKPgjVQMfEhbim9UmYc/foaAhSQtX7BAGLlMNSSMMEsWwldMpIUXfDqVkKBMt6ZBMZI5g8U78Y7wCr1hEZqitSV6xNqm7iVIovwnh/Wi053BaR6a99hcFt/FxfM9r8jLChSZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877335; c=relaxed/simple;
	bh=w4JN1LoknTxau7e9LJ9w5fD8MhoEzbK3gS8+b7n0vj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qkoc316L6ZKeqzP6PmnwDwsF6iUnajhMUt5f89GEcWAZuSEtz9+COLSXjWJnM+K1W0H0v/TUb/CYMJ9Gx28P9VR1Rj6y1PfUVgbTR4nY572lQ8ezWPHXk/ejkCwizeVzoSTmd7thF3QoW3V6zNsegxjT+BsQyWzt3TYbXPG2IA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K29khpMD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K29khpMD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nsRORm7Tyu5dhAf0VkCK48Q5CELkZ0VQKMOS3QJ1Do8=;
	b=K29khpMDZTupQfXNcyubwasyAlleTzoh3vOHGfTkRVpIylIsqCACGtP9taT3VVOPrACoxiWqN
	T1gKEIELEVvD4OpaChMAEklqEc5fCxp4pmmVcDcnUJ1mtl6Hy48ehobxHvD5MJsit2oJK5xiEtg
	HAF8eq/v5XvFZUUmOJhichk=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hfQpN6S8RzRhQs
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:11:08 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (unknown [7.202.181.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E6BE40561
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:22:00 +0800 (CST)
Received: from dggphicprd10024.huawei.com (10.243.6.112) by
 kwepemf100015.china.huawei.com (7.202.181.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 22:22:00 +0800
From: Abbott Liu <liuwenliang@huawei.com>
To: <patchwork@huawei.com>, <liuwenliang@huawei.com>
CC: Hanjun Guo <guohanjun@huawei.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 3/3] RAS: Fix integer overflow in ARM processor error context walk
Date: Tue, 8 Sep 2026 22:21:37 +0800
Message-ID: <20260908142137.45919-4-liuwenliang@huawei.com>
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

Commit 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past
allocated memory") only checked that the context info header is
inside the error section before reading ctx_info->size, but it still
added ctx_info->size to sz without checking that the context data
fits in the section, and it kept walking the remaining entries after
the check had failed.

sz is an int while ctx_info->size is a u32, so a size greater than
0x7fffffff makes sz negative and moves ctx_info below the error
record. The header check of the next iteration then passes, because
the offset of ctx_info relative to err is negative, and ctx_info->size
is read from a wild pointer. A negative sz also deflates ctx_len,
which can keep vsei_len non-negative, so the truncated record path is
not taken and the out-of-section ctx_info is traced as vendor error
data.

Check each context entry with 64-bit arithmetic: both the header and
the context data must fit within err + section_length. Stop the walk
at the first entry that does not fit, flag the record as overflowed
and take the truncated record path, which sanitizes the values
passed to trace_arm_event(), instead of detecting the overflow after
the walk from a negative vsei_len.

Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
Reported-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/all/20260825134323.4181892-1-liuwenliang@huawei.com/
Cc: stable@vger.kernel.org
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 drivers/ras/ras.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 085fe2d980e5..db378fd6f1ff 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -59,6 +59,7 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	struct cper_arm_ctx_info *ctx_info;
 	u8 *ven_err_data;
 	s32 ctx_len = 0;
+	bool overflow = false;
 	int n, sz, cpu;
 	s32 vsei_len;
 	s32 pei_len;
@@ -74,15 +75,21 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	for (n = 0; n < err->context_info_num; n++) {
 		sz = sizeof(struct cper_arm_ctx_info);
 
-		if (sz + (long)ctx_info - (long)err <= err->section_length)
+		if ((sz + (long)ctx_info - (long)err <= err->section_length) &&
+		    ((u64)sz + ctx_info->size + ((long)ctx_info - (long)err) <=
+		    err->section_length)) {
 			sz += ctx_info->size;
+		} else {
+			overflow = true;
+			break;
+		}
 
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
 
 	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
-	if (vsei_len < 0) {
+	if (overflow || vsei_len < 0) {
 		pr_warn(FW_BUG "section length: %d\n", err->section_length);
 		pr_warn(FW_BUG "section length is too small\n");
 		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
-- 
2.43.0

