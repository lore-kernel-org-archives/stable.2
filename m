Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585638;
	b=o+mtoQtP1I+vwgp9yOle9ThzZ5RxV0VusQxaMaQ14ff9cn1UVKJYmU2GB2rQEOHkNzKP
	 jmtsPomYejdLL98UOpy5zIAAP2oXfwiR5SIoUGOet1JrU3AfOZameih9coKrInmU86j5R
	 x9HTVjuemVH0otvqFVFTcy8caqSJgeEtAQDCFXRSNhII7quBbOhsti/GnCY1+ovhoDloF
	 mRf/tyEUp9nOZ6p4IZea18tsjpa/KOFUHH2FYr19BYDHewKr4s2xSd7KmiX6ebf8pzvMB
	 FX1/PSEH56CNsYlgvzeBI96x+g8C8IyVamuwvOiTnTedUzc13x6E3TTmlrLSphfQzOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585638;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=qgE8n7yW5SC6aLalyjWlKIFFYYtc4u+TIhJY+ne9Wfg=;
	b=tOktxv8nzrEzEYFjworzYLjWuJT7S2kZiRbFRLTVAeHsUXcFw4h/7MrTH03jajf2f+Jd
	 pK5TEHZD7nChJ+KgRQ9Z91sGocq0ZIejoZwxR9PhedELr5gx6uIecI9u0KgWvdeARwzFd
	 rgFEoCSxmFCaNjayjxPOeaVkBJ/3e9bUGo5e1OF/xUOpFExaBnmxfHWirbmbUOUtt1qLa
	 ficSPFmwV0mkUJTu2uI8pnwFBs+NI7WPDw1UoZsns8EtenIvl/TDuwjUoh6kNuEONco7P
	 8VjGYcuJjN1AnKTg77jInneXsr9PPj6QaexYWwFeFVbt9FsIWYdn+CczBegvkqrAjCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UGaQpPDT;
	arc=none smtp.remote-ip=113.46.200.221
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F2B606A333;
	Mon,  2 Nov 2026 02:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F2B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=UGaQpPDT
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qgE8n7yW5SC6aLalyjWlKIFFYYtc4u+TIhJY+ne9Wfg=;
	b=UGaQpPDTVn/Gntfv6VeHIZqORc3iLrXrsQihIgp0OXr0k6kZu3NI1d2LhMu5L4f0mmNSc+6h8
	M2952QJCQoDDTaVA/zf2kR4nXy4aO3GtZGirt+vmrjAFFvqAUl5DNu5BBGiDY/BspJmCzOcM/NG
	ycLF2AkPWxgxJDeZD3v8m6s=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4jHwH85S29zRhST;
	Mon,  2 Nov 2026 10:13:40 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A91F4057D;
	Mon,  2 Nov 2026 10:13:45 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 10:13:44 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>, <caixinchen1@huawei.com>
CC: <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>
Subject: [PATCH] ima: initialize the real inode attributes of the iint cache
Date: Mon, 2 Nov 2026 10:47:03 +0800
Message-ID: <20261102024703.816178-1-caixinchen1@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Initialize real_inode.ino and real_inode.dev with the identification
of the inode the iint is being associated with at allocation time.
On stacked filesystems the first comparison against the underlying
real inode will then fail until ima_collect_measurement() stores the
real inode's attributes, which is the safe, conservative direction.

Fixes: b836c4d29f27 ("ima: detect changes to the backing overlay file")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/integrity/ima/ima_iint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..02efa8eef28e 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -59,7 +59,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 				 struct inode *inode)
 {
 	iint->ima_hash = NULL;
-	iint->real_inode.version = 0;
+	integrity_inode_attrs_store(&iint->real_inode, 0, inode);
 	iint->flags = 0UL;
 	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
-- 
2.18.0.huawei.25

