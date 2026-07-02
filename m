Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90932ED40
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009215; cv=none; b=dc6v3yDmLaGHU7HWqROjFo4wrcsOhjfmiMIeTnAzVyx2ySmOYuiU9/Nh9lpoU6y2O+BDTPgSXvk/cEpTm1bkwRmRsRJOOvZuyJddNqhwYS/NSS9KMASzg2u9JOahlBF5aGePjxTOwj3VjJn27Iz0c341d/zWSHVpihqSDClpzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009215; c=relaxed/simple;
	bh=uZdyal3TudfnXzXkBrQ6v2e5yAG18HQf5hN6L3CsHfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOMDrDacvrtVoWPnBWudGXtE5OCoucouL6fMv6V8jhq41vJqli/PNgxuUmKnMdIN93ntZzTkr65JgmowlziC46Ny4LbZJg4jTwkaUVLojduXFbXtf1NBYHENbYOEHl6eg85tKwmi0thmZ49kjs5ujYNII85SHqcd8sW40q2inaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxy/q4/c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxy/q4/c"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9d87b1f9eso20130565ad.3
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783009214; x=1783614014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnMPSSlYPbFeKjZ6REZ70kPjg0z6TdA8YrdT5/DPlfA=;
        b=Yxy/q4/cg8O1qzxwt0+VHPudaf+CzUx8dTrx8m2cviij0IQN8nOs6FgtLLEHxSD9+G
         BuXx9HStXPGjax46W18Oolna9sTCa7SxPWqmBOddGTMiB8mFjgedGYyxKqIyn/fD++P6
         zwnXamJtece2oI4ttxCW2wpGgFwZIBRyOlbTfhmtuouOi5+j7qvMFJSA9V0iEPnxUccf
         KDfdm59ulHSJ57LUXbxl/sy0xDbq2rsn5dpF3qL9n/MP3r5LiUCt6McTXDKFsKRfbrNm
         OKjYt3TbY1AtGE6EEI0A60EMQX+nUDmvJ5pM3VHi2ISjuOC8iOmJzdZ+K4OR+daG1apF
         pLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783009214; x=1783614014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnMPSSlYPbFeKjZ6REZ70kPjg0z6TdA8YrdT5/DPlfA=;
        b=q5CT5VbLbKbgr2qCgBsORHmS9t3pX0JwOh34GYLEjXg1SBVrT8OLkWXMGoxBodnMoZ
         Kisz3tWSNLPJ3+BhfKQqxZ7KX7GWwigvHj06bGmjvoL++RI7myDY39yVGK/tgrm8viY3
         7XV6xJdfVQSi5ij5qtQyAomTiFm2WJPzl4li8KUfVUAJxLhrlM5HwizVbA5QHELfHBAQ
         vnDdqjWyH9/Xsfvo+Ao9C5EctHJmsdUU8eJHtvEVT1l+eYi+rKVeZ60LA6Eudc1cedDo
         wk50fXBO9TAsh4N9EMJ5vEqSVjDZsOQl+p+dkwwB8OX6SbBqYe8mRlUxNYDZOI6clEPI
         NJog==
X-Forwarded-Encrypted: i=1; AHgh+Rrr3B4n9YrcnKO6441ofzjlSKLzujj1m+0EyOrTH6D3YVwCdOBpmT9/R7kx4QUq5XEqkfo2zlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIFg3WZ/1fNqkb6i9JxivSK29Vbbi1QXSzFl8E1CXloGdzsD2
	D7lOdyxZbe9lOQa6vf6AviCV9Hq7UROLaGL1RVx/JZDfrdXNIp/LrD1P
X-Gm-Gg: AfdE7cnSogMVBWoRNlw8yJ9YDIOHtYYdrNsgHeyFLnSTHao2cBqydRghooamDT8OmIb
	o+TKG8NXHYa+74/m4sjcx164zBcvsOTubZQAIpJxq7XSa/BOHYa0uNgUi/yuoyLXFKBBZdrEdTv
	VrS/HhodKGfw63lNaA1U1Wbf8buZhAAc2Ir16KcCdQt/uX3SzxDHUk4Oijf+kmUQ1bA0OyVWKLf
	F4ZgvMaYXxOJiuK6AkFnK1mx3aknH6Er+5IDeThIQZm6UP/4XCBHi51WALTWqvOKKfOiwfAWAUv
	W9nrAQGA2o7wur0GuYtogTUUHr8WAfNcP45zre+HyfmpjwLrzXWFL77e97PfK6norjgSmXOMTPi
	+THxxQUnVA0LU0y6UV7Pg6DC9rUc5VvVcHIpRP2uM+W/dqXLNFh1R4uGDViUuLjkj5fcB7VDZV/
	Z9uWj9AOaZT2SzKo5sUp9al0mtupTEcOr6CuUPoIcYL5eif7HSflO2Mr+tCQ==
X-Received: by 2002:a17:903:3c05:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2ca7e6519c1mr75850665ad.8.1783009213852;
        Thu, 02 Jul 2026 09:20:13 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85b345sm16493826c88.10.2026.07.02.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:20:12 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] xfs: fail recovery on a committed log item with no regions
Date: Thu,  2 Jul 2026 09:20:00 -0700
Message-ID: <20260702162000.3548359-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702162000.3548359-1-bestswngs@gmail.com>
References: <20260702162000.3548359-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the first op of a transaction is a bare transaction header
(len == sizeof(struct xfs_trans_header)), xlog_recover_add_to_trans()
adds an item but no region, leaving it on r_itemq with ri_cnt == 0 and
ri_buf == NULL.

The header can be split across op records, so later ops may still add
regions; the item is only invalid if the transaction commits with none.
The runtime commit path never emits such a transaction, so this only
happens on a crafted log.  It came from an AI-assisted code audit of the
recovery parser.

xlog_recover_reorder_trans() calls ITEM_TYPE() on the item, which reads
*(unsigned short *)item->ri_buf[0].iov_base and faults on the NULL
ri_buf.  Reject it there, before the commit handlers that also read
ri_buf[0].

 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:xlog_recover_reorder_trans (fs/xfs/xfs_log_recover.c:1836)
  xlog_recover_commit_trans (fs/xfs/xfs_log_recover.c:2043)
  xlog_recover_process_data (fs/xfs/xfs_log_recover.c:2501)
  xlog_do_recovery_pass (fs/xfs/xfs_log_recover.c:3244)
  xlog_recover (fs/xfs/xfs_log_recover.c:3493)
  xfs_log_mount (fs/xfs/xfs_log.c:618)
  xfs_mountfs (fs/xfs/xfs_mount.c:1034)
  xfs_fs_fill_super (fs/xfs/xfs_super.c:1938)
  vfs_get_tree (fs/super.c:1695)
  path_mount (fs/namespace.c:4161)
  __x64_sys_mount (fs/namespace.c:4367)

Fixes: 89cebc847729 ("xfs: validate transaction header length on log recovery")
Cc: <stable@vger.kernel.org> # v4.3
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 fs/xfs/xfs_log_recover.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 103b2a79667b..fdb011e6ef60 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1907,6 +1907,15 @@ xlog_recover_reorder_trans(
 	list_for_each_entry_safe(item, n, &sort_list, ri_list) {
 		enum xlog_recover_reorder	fate = XLOG_REORDER_ITEM_LIST;
 
+		/* a committed item with no regions has a NULL ri_buf[0] */
+		if (!item->ri_cnt || !item->ri_buf) {
+			xfs_warn(log->l_mp,
+				"%s: committed log item has no regions",
+				__func__);
+			error = -EFSCORRUPTED;
+			break;
+		}
+
 		item->ri_ops = xlog_find_item_ops(item);
 		if (!item->ri_ops) {
 			xfs_warn(log->l_mp,
-- 
2.43.0

