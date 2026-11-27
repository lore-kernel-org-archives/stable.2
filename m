Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762237;
	b=x/I/TJqfGqAID1bTko7FXYuhn6rbuaMI/qawxWeni8oILtI2maG4EmfFB8AQXMZaeybo
	 wfpD+kGc4gl7qq62+1xKTBUdBw/PPyo0STXl3bj+Bpi0Q5/uUdtnUoZDQEzU8v2zwucIe
	 5P41VnjeZGqzW1xIeuYxE2Mdf0FKBzNFnvgSY9gen1e4F9DnaVyZxunuXE/Y8SSojsGwQ
	 myhn8112S67guirlSGGifKzwHYBoU6QDIupMWp7U3vQhwLu1YjYyQvR9NfIV2moHH8EgT
	 iCXvbPDI+/DaDYJ9rdA9wdvAKXCJYXOC8i2cAv1qpuCZlfWJWffXSdyiCUBrs/G9Hrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762237;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=KZFupaYaw2l2hiD+l4s1N1CQ+SbjqIzWQZ47VhByxFY=;
	b=2RA8Suv26tQICuIB/9MhqIRXXYoDG/stKgU428NhKZD0KxumfJk1B9T2fNW0UJ6x0YWM
	 +D0OzMCCkh3fgC0Tr7+J22ZOSXMi33xXgktzgy66FdJkoNBz6Onn/nXu/Ybdyc5q8WD9e
	 t4dexwiQ+C0pODt7iHX9o09zMlcAZJS9r4zk9jdDR8UERro7TOsEAWPHgh4d+L8G0Hoeb
	 LOqgpS0Gc5L3BtFGd7iGAfGRNBe+Gd9Bc8hHhKJzWrR1ntkkxTMkR9AeihcF9WieQcZsL
	 PlMaay6o3xvg0g25CU+rXo/H3oi8wK1e9kCqdnMqBuOwWWfcyjvZcngMNbkR5hD3tIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jbsJnURw;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77943606A31C;
	Fri, 27 Nov 2026 06:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77943606A31C
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
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jbPDd1skxz1prRJ;
	Fri, 27 Nov 2026 14:50:09 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 65DFD4058C;
	Fri, 27 Nov 2026 14:50:27 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 27 Nov 2026 14:50:26 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <caixinchen1@huawei.com>
CC: <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>
Subject: [PATCH RESEND v2] ima: initialize the real inode attributes of the iint cache
Date: Fri, 27 Nov 2026 15:21:29 +0800
Message-ID: <20261127072129.2162668-1-caixinchen1@huawei.com>
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

