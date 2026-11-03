Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675394;
	b=UZvwX57YQ7k75hM6dSb/7XJpTfwXm2ku9xF4hOJXc13xAm8w672TZDmP/7ZHLph4oHgV
	 5MyEFnejLfSrYfsF8fns+6S1mHrlMkt1aEsyASntCmPfoJnXk49sFvwFV3ssp2zHl8Rvn
	 x9hAiRZo8k519rFqg/m/RxRdOq0NQx5n9wKqZ8DRYRh4mPGAvcr4Yg2kURB78mtxJ1rHz
	 jAuAU3CwNC1ed7UC1ovtpII8826CegG/XFM+AxTTM7+4w/2Jg1ycP75bWaDz68c4JWf2o
	 9LY75hUx8qFwWxIWFNMQOu+Z1zLOq0xrvWuFhMEGi5mgzX9ttOgkHmUcc8ZntZAp5Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675394;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=KZFupaYaw2l2hiD+l4s1N1CQ+SbjqIzWQZ47VhByxFY=;
	b=MUKKp4OZlxXpjGHMNk+YF3O8qe2geihHufTYvTEVss6IZ3WzHFBGIBdw9H5Ho4F7kN5p
	 yPfjGWBkh3K6NETDGnwiDrsxtYfbOQUD34aE+RcKQM09OTQL5MO+mTMy+dfMdAueNEtf6
	 i0yptS20YWXvD6MwjT6f6251ElpjT04wGAdG1k+K9pNcS81BO/sBoT13K96o8FZGaRXCm
	 bGwy4b7T9zeKkC9dIkGu+BIN6nxKV+PVeHM4fHwmvPbKZkB/nlY7O95j0VrTwh0ZmkFtz
	 6yGg70l/QRpZLk7WIFdtYlqdJMdaG64Dk5vCAmBvKKw3Y/ZDL4Ipn/7RV4doEVzvqkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jbsJnURw;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9A606A324;
	Tue,  3 Nov 2026 03:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA9A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jbsJnURw
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KZFupaYaw2l2hiD+l4s1N1CQ+SbjqIzWQZ47VhByxFY=;
	b=jbsJnURw+andRErr8ZkNglhEAFuDQ7RrG3MdggxEX4WGqLQoJ2+bGYEN5PI/Y8QfB3xEjNYSg
	IpgdhRfkjncQ7jEKhEC2n+LzYODCLjfeYtLnZASLkjn5oFjp0RGVmWTjUPcZlHW8n/CLVoPtI11
	jDWHVdS8DKjbg+tQgAQ8sPc=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jJYTG39hzzRhT9;
	Tue,  3 Nov 2026 11:09:38 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E56FA203AB;
	Tue,  3 Nov 2026 11:09:43 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 11:09:42 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <caixinchen1@huawei.com>
CC: <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>
Subject: [PATCH v2] ima: initialize the real inode attributes of the iint cache
Date: Tue, 3 Nov 2026 11:43:20 +0800
Message-ID: <20261103034320.1756673-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100010.china.huawei.com (7.152.184.41)

ima_iint_cache objects are allocated with kmem_cache_alloc() from a
dedicated slab whose constructor only runs once, when the slab is first
created; the constructor does not run again when a freed object is
reallocated.  ima_iint_init_always() resets all iint fields except
real_inode.ino and real_inode.dev, which therefore keep the values of
the previously freed iint.

integrity_inode_attrs_changed() reads those fields in
process_measurement() to detect changes to the backing file on stacked
filesystems.  The fields are normally written by
integrity_inode_attrs_store() from ima_collect_measurement(), but the
IMA_HASH path sets IMA_HASHED without calling it, so on the next file
open the stale, uninitialized ino and dev are read.  Depending on the
residual values, IMA may skip re-evaluating a file whose backing data
or metadata changed, or needlessly re-evaluate it.

At allocation time there are no valid real-inode attributes yet, so
clear the entire real_inode structure.  On stacked filesystems the
first comparison against the underlying real inode will then fail until
ima_collect_measurement() stores the real inode's attributes, which is
the safe, conservative direction.

Fixes: b836c4d29f27 ("ima: detect changes to the backing overlay file")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/integrity/ima/ima_iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..c25f41a4dede 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -59,7 +59,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 				 struct inode *inode)
 {
 	iint->ima_hash = NULL;
-	iint->real_inode.version = 0;
+	memset(&iint->real_inode, 0, sizeof(iint->real_inode));
 	iint->flags = 0UL;
 	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
-- 
2.18.0.huawei.25

