Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C803ECBC7;
	Tue, 28 Jul 2026 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225001; cv=none; b=BXJe9JceQhvpiHwnYJBT0l9R/EIrZA7kZolw8H+MOzvCv5KDzJmn7MKu6WnYEAIuu8E50Iyk2AHcwhbngma/p32DQlgYYzBsHrvnSU7v0axg+son9GUr9le6LJE3dIeN7bciT1b4E8ReGGimDmgRorPVOUHHKifRQyDVAxQVcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225001; c=relaxed/simple;
	bh=tlvVa6+Y17MXt7epgDGCdZFPuGDwR8o4Mh8SYzI09ek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtq5tnM5VpBZhHrWlQjuTymJv9zBUm/DwFQCOO8u6Iqgl5R+wkjM5VRqSTNJ+MhM0a8ysbjdS3hRoatZ1yT0RSBepZS120Njum59YFNXiCCaq/gkh9F5R24ORDFrUo2uusozDigXQX3czZ7FmG96RZ3ZCU3/FUJOu2Uy44joMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qQQEKvZH; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qQQEKvZH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dVbEMkAH4oQeLM+2qQKORoOzs7wAWPFGJUizPSN6T/o=;
	b=qQQEKvZHLWWqDDOyJSQZV4u8a2fga2Y2dfFmfzcl/ChI5LAbYXn/sAqt467hI+xhhHf6oniXl
	aiUhuQy12/ciqRrA0UcsKDQIAYZ3TxLIZn7CtI1yFg0bxU4Ld8oOLjSHbObTX+WZOSRC6wIdUbM
	0uIHXOFVvirdQSfGacfbtNQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h8S6v6WFxz1T4JN;
	Tue, 28 Jul 2026 15:40:23 +0800 (CST)
Received: from whupemo500009.china.huawei.com (unknown [7.152.184.116])
	by mail.maildlp.com (Postfix) with ESMTPS id DD1C740575;
	Tue, 28 Jul 2026 15:49:52 +0800 (CST)
Received: from localhost (10.50.87.202) by whupemo500009.china.huawei.com
 (7.152.184.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Jul
 2026 15:49:51 +0800
From: Jiacheng Yu <yujiacheng3@huawei.com>
To: <petr.pavlu@suse.com>
CC: <samitolvanen@google.com>, <rusty@rustcorp.com.au>, <hannes@cmpxchg.org>,
	<yosry@kernel.org>, <nphamcs@gmail.com>, <liuyongqiang13@huawei.com>,
	<linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Jiacheng Yu <yujiacheng3@huawei.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] params: fix charp corruption on allocation failure
Date: Tue, 28 Jul 2026 08:55:18 +0000
Message-ID: <20260728085518.3865621-1-yujiacheng3@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemo500009.china.huawei.com (7.152.184.116)

param_set_charp() stores charp parameters in allocated memory after slab is
available, and releases the previous value when the parameter is updated.

The previous value is released before the replacement allocation succeeds.
If kmalloc_parameter() fails, the setter returns -ENOMEM with the parameter
left as NULL.

Failing zswap's compressor update before zswap is initialized can later
trigger:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:strcmp+0x10/0x30
  Call Trace:
    zswap_setup+0x3b1/0x490
    zswap_enabled_param_set+0x5b/0xa0
    param_attr_store+0x93/0xe0
    module_attr_store+0x1c/0x30
    kernfs_fop_write_iter+0x116/0x1f0

Allocate and copy the replacement first, then replace the parameter value
only after allocation succeeds.

Fixes: e180a6b7759a ("param: fix charp parameters set via sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiacheng Yu <yujiacheng3@huawei.com>
---
 kernel/params.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..e4f2b71dde1e 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -261,6 +261,7 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
+	char *tmp;
 	size_t len, maxlen = 1024;
 
 	len = strnlen(val, maxlen + 1);
@@ -269,19 +270,20 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
 		return -ENOSPC;
 	}
 
-	maybe_kfree_parameter(*(char **)kp->arg);
-
 	/*
 	 * This is a hack. We can't kmalloc() in early boot, and we
 	 * don't need to; this mangled commandline is preserved.
 	 */
 	if (slab_is_available()) {
-		*(char **)kp->arg = kmalloc_parameter(len + 1);
-		if (!*(char **)kp->arg)
+		tmp = kmalloc_parameter(len + 1);
+		if (!tmp)
 			return -ENOMEM;
-		strcpy(*(char **)kp->arg, val);
+		strscpy(tmp, val, len + 1);
 	} else
-		*(const char **)kp->arg = val;
+		tmp = (char *)val;
+
+	maybe_kfree_parameter(*(char **)kp->arg);
+	*(char **)kp->arg = tmp;
 
 	return 0;
 }
-- 
2.34.1

