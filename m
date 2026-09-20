Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E323D952D
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885558; cv=none; b=KqaXKVGxDiWxikTWxT5g8arMolMHx8kxE0jAyoqMfPzH/NapYGyo23da64M6s/UpCOeQfFoDtVXOAHBbUSLaelgxMf9LCxYH4hE7X3iF6tXE/vZnIuas6/V6zYUYdI78+LkzxzavkzurcoV5lk/w4S74LaIV39Isv+33g3fKrxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885558; c=relaxed/simple;
	bh=D/kDtYLh5aNB9e9RHnR+Dgz2EBmMSaiqhxAvGXD6J5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQzNPoWAhHmLztgm0nLp49Ixe9xnsCuIVtSL0oOqgQRS8UNEMtDh07AzZl8RPFeuCBUFr88+5/i/JF02kujKAPNhweGXN8p3I51A/DfaLYgxM3FPvz1/TAJ5Ge548LG9amsR18wUMgjtkTNIA5FiusxQbPdSj23VnQhUPkiikQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwJ33Nsq; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwJ33Nsq"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1825821a91.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 23:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789885557; x=1790490357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+W4DMeZDefwNmcwnBVkAJUUX1++SWxk3vXL4LXcg+o=;
        b=QwJ33NsqzjRn3B6ytU5Ecd6ldZUMwCcOa++CC3rT30a4EiAlpBLQp8lZirKgVbxMPa
         nirlCyhQcEGuvobyhzed62rIhGMCjTXtmLafvroHOSUAISWyP8D130V2c/UMXOY3sX9F
         N9/fRn52J9PZ8mAsVE+DHNN7O8GPdTdxAVkteqlEAffVGraP54vfDB5U13rZIIBoihfq
         X0MRd2DiyYyZXJUjlstqWmqg3CJx6MFKbPawi3Y9U5KVK2na7r70bQqea+rpYUBPOY1/
         1RGYmnVPVB7XVWhxGff1Rc0cO8FBTHFQnHajcfRd0qoK1uIgfb5TJPG5bITZ3T5VG6j8
         UhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789885557; x=1790490357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+W4DMeZDefwNmcwnBVkAJUUX1++SWxk3vXL4LXcg+o=;
        b=vxq32DBZkSbrIc2J6xOxwffR2OUid3wMVywX+IR6oMy2FKtktUe4UXuZyvtHGMSuxf
         FbKB92S3RBVhoKij2qFJ0rqkYGSmGondwadaxdqso+ATNdp+h9aiRRRS4mnNZ68KDNLj
         ll8cVnSSCXcfMiQXT+lWFBxNtyIMBbsMTHra3n1iMIXG2UIYQgdiXGyxvpthf8I0FTMI
         MJjaEliZ/AL1lNH/rLOeZkXdEo51T/8TTwAFVQhglbiRjvkVfLCIwfVP6J+kGi53aK5s
         1/y6QVdu791vIppis5ibm4cVsvLyNPowJH2OAVgMnS+j7tUwP7S0kdUSUEktUSV5iHmO
         aGAQ==
X-Gm-Message-State: AFuF++m8+peRUGPEnMtj+jGbxUuqowJDjfgD4ckw4+hr1ls0AlaBFJ6U
	dLSMCvF2CJKHlD+QTFf5PjbNQGNQy+TBtSPiAd3VhO5fFjJotzt5PD64
X-Gm-Gg: AYBFou3qkgOguSKUzTvUN1sabkWOQ9VCbqGNQ1KTNm7xm6JgIzPaFBj6oaA6yO/c6Sd
	TFNrUpUvaoGmgASVGFSZ/+eSwXlzo0FjvAvOoxru22mEYkLzPi9qgHE+tpMzuMb1eCvcGvmmDeZ
	xZqTdmRw0RgwKx/sUApdIX2khUlQ4xEK8ddWhJWsPf1uX6aew41Z5JLLko6xC0V53iy3z6DRHPn
	M9ZQ5vYGG9Y38jdZ2n+GO8WeuvV/GGaOM4KRta5pAseap4z3yjnJ4j7r6788L8E1Mp5fiZG+tKc
	N2b0cwC7h/rpCmssbAkKYn/WZ6LBKKJ3+dTBIpTrEZO7VZYtL31CAd3+SpYSUf1zV8OyFyZVTE9
	7ioOwf/Z0gzWa4/5yd552uJ1p5ljn0sAM35vL+/CxuCJJzCNCq9Ov59cW0nozX8u6qCfqADmX1w
	ZR7koHFbL3diBAPrFaCkbiK6rZkKfk2MqJapXF6dbatOR10ybyVXwLxSzjOhM1PIjgGfYVZqnHm
	ozSMFiZwacddTL77GO/b1bl
X-Received: by 2002:a17:90b:17cb:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39e54df713dmr12415337a91.15.1789885556738;
        Sat, 19 Sep 2026 23:25:56 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55c9cabdsm4529321a91.0.2026.09.19.23.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 23:25:56 -0700 (PDT)
From: ret2c7 <cccccccccccc777777@gmail.com>
To: ret2c7 <cccccccccccc777777@gmail.com>
Cc: stable@vger.kernel.org
Subject: [PATCH net] rds: ib: Clear the sg list when mapping an MR fails
Date: Sun, 20 Sep 2026 14:25:46 +0800
Message-ID: <20260920062546.1590098-1-cccccccccccc777777@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rds_ib_map_frmr() stores the caller's scatterlist in the MR before DMA
mapping and registration can fail. On failure, __rds_rdma_map() unpins
the pages and frees the scatterlist, but rds_ib_free_frmr() can still
return the MR to the pool with the stale pointer set.

This leaves the pool with a dangling scatterlist and can lead to local
privilege escalation. KASAN detects the resulting use-after-free when the
MR is later torn down:

BUG: KASAN: slab-use-after-free in __rds_ib_teardown_mr
Read of size 8

Call Trace:
 __rds_ib_teardown_mr
 rds_ib_unreg_frmr
 rds_ib_flush_mr_pool
 rds_ib_flush_mrs
 rds_free_mr
 rds_setsockopt

Clear the scatterlist fields before returning an error so the caller
retains sole ownership of the scatterlist and its pinned pages. Route a
zero-length DMA mapping through the same cleanup path, and skip unmap
when no mapping was created.

Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
Cc: stable@vger.kernel.org
Signed-off-by: ret2c7 <cccccccccccc777777@gmail.com>
---
 net/rds/ib_frmr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index bd8611911..fea387952 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -213,7 +213,8 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 					 DMA_BIDIRECTIONAL);
 	if (unlikely(!ibmr->sg_dma_len)) {
 		pr_warn("RDS/IB: %s failed!\n", __func__);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unmap;
 	}
 
 	frmr->sg_byte_len = 0;
@@ -261,9 +262,13 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 	return ret;
 
 out_unmap:
-	ib_dma_unmap_sg(rds_ibdev->dev, ibmr->sg, ibmr->sg_len,
-			DMA_BIDIRECTIONAL);
-	ibmr->sg_dma_len = 0;
+	if (ibmr->sg_dma_len) {
+		ib_dma_unmap_sg(rds_ibdev->dev, ibmr->sg, ibmr->sg_len,
+				DMA_BIDIRECTIONAL);
+		ibmr->sg_dma_len = 0;
+	}
+	ibmr->sg = NULL;
+	ibmr->sg_len = 0;
 	return ret;
 }
 
-- 
2.43.0

