Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA4554096
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877346; cv=none; b=AYSTy4D70bbsTG8rkGHJYeTX/2Ze+pPJ5AIlyYJg3lUVlv/R2OIavUbpMBH8TvRZ3MGUxTr9a08YP6ekOmZAk+Tia4uzPAxxuUVwBdTG11TVFp9YPO4rlD5xJcAbJllbRmeMsY5jJoINqE85wNVilAQu6LihXhH9mw6rtR7Mh6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877346; c=relaxed/simple;
	bh=0mysyToHvqP5e5DKgMHPszVepF4tISUWsYxbAjeL4oI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0Mfub+y7RRjkpS0mbkGXhnHrWmlvr0lOft5urA8BZBt17K1+q8hhRvjrlh+QPrMM6OTbbQuHsHeB8moIL07an0UnEgvDriyLs07VonIraM9Lxg8VlCmP6viaIv49KhpWejfiSIFh6q1JNyHapunhbvCKsNo+hOPbkyDBqOn460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zhncPP0D; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zhncPP0D"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=r8ssry16M5aSeT7xlvXOax7jov1McZIxliOAZ/6MYRg=;
	b=zhncPP0DXgoXlFYqhkL73/0wmOk1FS/Q5s7y7X58cfAeYDqfYyOPrIFZf1l2msvt7ItAh/0eF
	sUStN6gVcgENxjiKpTVdk280TfBT41G+US9EJWDhLJvJqSC3fC1FWIPsLdyYXyRwgTZFp5NJ1gX
	q2bkwJ6zmLzaHGfUEZt4rco=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hfQpH1LBMzmV8g
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:11:03 +0800 (CST)
Received: from kwepemf100015.china.huawei.com (unknown [7.202.181.14])
	by mail.maildlp.com (Postfix) with ESMTPS id 3493D40586
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:21:57 +0800 (CST)
Received: from dggphicprd10024.huawei.com (10.243.6.112) by
 kwepemf100015.china.huawei.com (7.202.181.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 22:21:56 +0800
From: Abbott Liu <liuwenliang@huawei.com>
To: <patchwork@huawei.com>, <liuwenliang@huawei.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v3 1/3] RAS: Fix inverted context info bounds check in ARM processor errors
Date: Tue, 8 Sep 2026 22:21:35 +0800
Message-ID: <20260908142137.45919-2-liuwenliang@huawei.com>
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
allocated memory") added bounds checks for malformed ARM processor
error records but contained a bug:

  In log_arm_hw_error(), the ctx_info bounds check is inverted. The
  condition "sz + (long)ctx_info - (long)err >= err->section_length"
  adds ctx_info->size when the context header is already past the end
  of the section instead of when it is within bounds. So change the
  comparison to <=.

Fixes: 87880af2d24e ("APEI/GHES: ARM processor Error: don't go past allocated memory")
Cc: stable@vger.kernel.org
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 drivers/ras/ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 03df3db62334..2540538a16a8 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -74,7 +74,7 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	for (n = 0; n < err->context_info_num; n++) {
 		sz = sizeof(struct cper_arm_ctx_info);
 
-		if (sz + (long)ctx_info - (long)err >= err->section_length)
+		if (sz + (long)ctx_info - (long)err <= err->section_length)
 			sz += ctx_info->size;
 
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
-- 
2.43.0

