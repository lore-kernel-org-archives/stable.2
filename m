Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EF474245;
	Wed, 29 Jul 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324393; cv=none; b=Weyiqb2gTPfXcXj2NQiqpjgD1gtMwsMlwrs1l3goUkmHYPGYU4hHI3wS9tuZiSiqgyNkWVocmFm5VzpqsiYiIHeHhpbhrVNXU0lbzxCOc9XJD/Kry7xthqXlkTkJyAThsrZ/HPLzc4mPyZdZWTD2A6W5RL6t1ZKtJCWozQpOGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324393; c=relaxed/simple;
	bh=/AcmFRcaRgqP2vRA8+82Q7m1Dpx23kK7ikkH2pstyb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vi42VI1ATcY1boLq0ibma6y8jVyKiu4cA66DeIMkexre02eiV0CvhaihxO+Y3KPXfvy99eiW8Ip84bYMAhWB4siwgKE2DbEY1oyKcoCMsMpYDLmfwroopZ2EcQvNtAF+5ur4qLELsmkesjjmNWFcM53U995ojCu3pAVKnbGksko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=c0CyrNhC; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="c0CyrNhC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=o/ioV+0lKVSCMKWDxyofqVQddDfBDoxkVm+507Wo/bY=;
	b=c0CyrNhCnH+glw29g8WHcTRlHy5BaYXsl5JWDLdEYDXK/5Z19UzSW94hBI5cpJO91Gh5e4KNs
	oleiGi6k5Nl+VZ6SIlJwUnP/KFBOtQRBdgBxp2SlLl6pGOGjAQS9C/4FDo6RGga2/MaAEsV7lhQ
	Ue8a+MQ5z3o6FsNeEFyN/tM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h98tP20hhzRhVP;
	Wed, 29 Jul 2026 19:17:01 +0800 (CST)
Received: from whupemo500009.china.huawei.com (unknown [7.152.184.116])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AA234057D;
	Wed, 29 Jul 2026 19:26:27 +0800 (CST)
Received: from localhost (10.50.87.202) by whupemo500009.china.huawei.com
 (7.152.184.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Jul
 2026 19:26:25 +0800
From: Jiacheng Yu <yujiacheng3@huawei.com>
To: <petr.pavlu@suse.com>
CC: <samitolvanen@google.com>, <rusty@rustcorp.com.au>, <hannes@cmpxchg.org>,
	<yosry@kernel.org>, <nphamcs@gmail.com>, <liuyongqiang13@huawei.com>,
	<linux-modules@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Jiacheng Yu
	<yujiacheng3@huawei.com>
Subject: [PATCH v2] params: fix charp corruption on allocation failure
Date: Wed, 29 Jul 2026 12:32:43 +0000
Message-ID: <20260729123243.790023-1-yujiacheng3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
References: <ff0b7cdd-8fa7-4cb8-9e21-6a7204809766@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

v1 -> v2:
- Use memcpy() instead of strscpy() as the length is already known.

 kernel/params.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index a668863a4bb6..939ef84a46ff 100644
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
+		memcpy(tmp, val, len + 1);
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

