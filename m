Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4F3CBE86
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486518; cv=none; b=m7hjrABHNoYpkq9rtdqvWo2B4eCamlXzKn7oPc/vutSubRJB5orrU9ylAcINcb6riRlxCEMsqGT+Y4zGyDttt0Xbd7K391/Jk4GXbnuU02XIwchlXXMBIsSzs1AFsfCpuc6rjnH5vWRtx6rdPg3p6XzaPezc0QJSnXyZEvFM2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486518; c=relaxed/simple;
	bh=Zir4Ph3FKLRzBTHiYIba+VfmJzMS/v9zNFVDu0Pjrt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1yl2aj8xYQ4qQMyh0sU80KDWdxnAPJmusSKNh/MKxdz6hLLlZBKQEkKdynBVqxAbi2O0vI2b/RxCQ3lCh+RuVDGed1fk2l6rnOnRghlpyib2D8JnLeqBWOqk8D8IBKqwGJn0GGXBHjaqS536VxBhuZK5ydg+LZck1phaLuPgcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=RWK9bvoY; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="RWK9bvoY"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-351f7a0b13bso602074eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486515; x=1792091315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5apqDPTTuz0tcu66C6sdhKkioJqFGVwtFVltYn4up0I=;
        b=RWK9bvoYyMwJ15/n+Wg75puZ6CXOUL5gIKCyPgZYt+MJ4Tp2vEnxh1iYc8EMg9aoBn
         63pB5BTLWEkNRqHJFdd/Rx3MPA+5DAw9cIETtIKF1QJeF7GRXlLLIguYO7/w96MRRVRz
         GidVgi0l4STuK1b65FHY7pircJZvi1aqHhVpD39ahHm+nkVmgsxx9jiCCehY3/Klmt9x
         oE/OvjXYa7qjbhq+JwKvZ1SMP+Dd5fw8C5nLoNC67bJuieZM/eJdfzvh6gGsRDC+75ws
         FY8vfNv9Lz6QE/1qSGnVjdeSkW/O12IsEJRWh8cyfv2Sl4Uj5FRtekkM42148V3H98CD
         Qf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486515; x=1792091315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5apqDPTTuz0tcu66C6sdhKkioJqFGVwtFVltYn4up0I=;
        b=nHikVX/z3tKLvF1wCB39NU8Pi0WaSXbg56h3sBAEzctE12akI9iwaPtdMThdJSnfFq
         YidKbsAb+drXimgu711geolrHPA3r+ILnaQlz/c6bBbsmH0MwL6rFor3wJo3TCL5Uo8s
         w7XbhcAzMKRAxyVoJ974gP8Euokwm3pLHEMWhTTNKs11bBKzmx7PR2eladCgCeF3DdhG
         4QbhyW58DZTFoAFK6J3nnhqBjZAokHtGyeAOUZ2AeAZByBoJ/Ak8QIP/G124mZTPMIWz
         jT+fJoG8sy0cCTs6dFw4nV6N44BqT4CpYYdgPhbs06ac9jvu9HLTVP4YMt678XYzST2e
         q8rQ==
X-Gm-Message-State: AFq9FYL478YJLvnBZ8fq9IwBF8eYxmelWfJdsx2lmenLy5Z9nINXVVRe
	GYmpQOymjEcaOzIHAURXVPKIDfPnrnvSRm1Uy/3oKi583OD9oSKNXiTVrCchlsnRk+MQsRZ33qF
	dhCu3ROuGqA==
X-Gm-Gg: AYBFou29me4fCYntxKoAQroyO2K9Z3OxOam3X4JSB+xoIXyKxL0LKoTww3zBUcAk3oi
	QqN5m5Z4fDy454J72HroT+FIyIxpZANqHnCHF+zBmkHT5Cbrx/zHGqrsSn8CfA0tGJMsYahCNBF
	q1fCc01reo9ed4Z830uOvn80Y5sVpyDDZbh0fNegQtdPrg+dqo9t11jef+75JDzdqOO6IByE+JN
	sz3/NjdWfpDttkKaAvcJC2zFARKca+cf/aD2VeoS40oo43qk9cAq+7IIHdZD6EaUxhNTdVoQtEm
	PF6g670K/6kpv6XyYBJlDguIrfMx0CZjoNnYHCfCr9/JFO56n7Hmo7Hy1zCcKNig+pkUQtDYz/4
	zqIKXn26MhN+Xsow5y4r02M0kzsyLeh98fASFwz9C0j+7pvLmG0jQcJEE2eK0x3/QB1nRflYZIr
	4ZVrGR9qNu++EGPtngERYjz7HEQyFWkYSVVRsIZnmheJyKuT45Ndr2WjFHr6eu6lt51Lm56g/7T
	E5yKHvTg5LlR7FZDdjyy++OVl+SwNED8/EbB+Ujr+x0UG+pt9oXVIoArXKlnOn7e6VkEVQ=
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id 5a478bee46e88-3536c53930dmr317574eec.13.1791486515207;
        Thu, 08 Oct 2026 12:08:35 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841648sm80561eec.3.2026.10.08.12.08.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:08:34 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH 6.6.y 1/2] erofs: avoid infinite loops due to corrupted subpage compact indexes
Date: Thu,  8 Oct 2026 15:08:27 -0400
Message-ID: <20261008190830.97970-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190830.97970-1-artem@trailofbits.com>
References: <20261008190830.97970-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit e13d315ae077bb7c3c6027cc292401bc0f4ec683 ]

Robert reported an infinite loop observed by two crafted images.

The root cause is that `clusterofs` can be larger than `lclustersize`
for !NONHEAD `lclusters` in corrupted subpage compact indexes, e.g.:

  blocksize = lclustersize = 512   lcn = 6   clusterofs = 515

Move the corresponding check for full compress indexes to
`z_erofs_load_lcluster_from_disk()` to also cover subpage compact
compress indexes.

It also fixes the position of `m->type >= Z_EROFS_LCLUSTER_TYPE_MAX`
check, since it should be placed right after
`z_erofs_load_{compact,full}_lcluster()`.

[ Backport to 6.6.y: preserve the switch-based full/compact loader and
  perform the type and cluster-offset validation after either loader
  using z_logical_clusterbits. ]

Fixes: 8d2517aaeea3 ("erofs: fix up compacted indexes for block size < 4096")
Fixes: 1a5223c182fd ("erofs: do sanity check on m->type in z_erofs_load_compact_lcluster()")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/35167.1760645886@localhost
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2025-68251. 6.6 validates clusterofs only in the
full-index loader, leaving corrupted subpage compact NONHEAD records able
to drive non-progressing lookback.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.

 fs/erofs/zmap.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 76566c2cbf63..e53d5239f04d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -67,10 +67,6 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 		if (advise & Z_EROFS_LI_PARTIAL_REF)
 			m->partialref = true;
 		m->clusterofs = le16_to_cpu(di->di_clusterofs);
-		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
-			DBG_BUGON(1);
-			return -EFSCORRUPTED;
-		}
 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
 		break;
 	default:
@@ -276,14 +272,34 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 static int z_erofs_load_lcluster_from_disk(struct z_erofs_maprecorder *m,
 					   unsigned int lcn, bool lookahead)
 {
-	switch (EROFS_I(m->inode)->datalayout) {
+	struct erofs_inode *vi = EROFS_I(m->inode);
+	int err;
+
+	switch (vi->datalayout) {
 	case EROFS_INODE_COMPRESSED_FULL:
-		return z_erofs_load_full_lcluster(m, lcn);
+		err = z_erofs_load_full_lcluster(m, lcn);
+		break;
 	case EROFS_INODE_COMPRESSED_COMPACT:
-		return z_erofs_load_compact_lcluster(m, lcn, lookahead);
+		err = z_erofs_load_compact_lcluster(m, lcn, lookahead);
+		break;
 	default:
 		return -EINVAL;
 	}
+	if (err)
+		return err;
+
+	if (m->type >= Z_EROFS_LCLUSTER_TYPE_MAX) {
+		erofs_err(m->inode->i_sb, "unknown type %u @ lcn %u of nid %llu",
+			  m->type, lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	if (m->type != Z_EROFS_LCLUSTER_TYPE_NONHEAD &&
+	    m->clusterofs >= (1 << vi->z_logical_clusterbits)) {
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	return 0;
 }
 
 static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
-- 
2.39.5

