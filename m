Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB84ED188
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164682; cv=none; b=Xeg1SkxM3OD1q+BbH6yw0yBaZAACihgQP5fCAg9Wa3dm2PRQ70kBEKF1M+Ic9dc08ESyj621j5iZwO44fszQ/nP/5BGC/CJZDCoxoUx02mxXy2Vqf6NQxaikgNij7rXaJldoKHtgcU9aoV1txFOEPdjorLmW+ixXRsVHNXP9YV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164682; c=relaxed/simple;
	bh=QYUa20pIZh2wxiF+T5Z9fR8QFbYCIIP9R0h4qS+mLH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oL3flIz9KmE2pcfNcLammJya/JTrSWAQDQ/Xe0J23zKrgxlLNMKJxBM1Hy0CiZ8/9Wiq6uqBr1j3d4x4/qep9vcztDZ2DhP2LN8rQSHA3HBA+NQu0VpHfnz/V6EfLs1TouVkQYNTmnR/BVdJ7oGCbUFai9BNaL8nNdk8QUTQT+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwanlu1Y; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwanlu1Y"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a4c5c582eso316453137.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164673; x=1790769473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fcqVoGIOsqHneznya0CjxdKSZ/9QYnIEWsldQdbwafY=;
        b=pwanlu1Y5uhorzXbF2bYqznbUDl3U0lbePyU4DsYEOzt7gbYpuQAXPEbmOlcrlOQeV
         T51ojFvBOg9XNqn1OnZsl3pRZxFuQH/VH0Pxu2jYO9l/XmtgVwnJf69nsbOCEdLLY6y5
         uhsp6xqnMq10JKr4l3vK40tppAC4GCYi3Lt+sEGSEuwDIwTSBmZD1kELJNpPwvRwUY9f
         yeRnZQSV0bCR+g8gH1IkurGBZ8HV7URwCXp6u3HaoAMnsHIYk0uvGP/XdwCh5ZffGnos
         FYchKWwXe96WJtPbCmnpRExCu2vLxgxqP+vk6NPHjFFqXOsBNKeFZjoyM0DO0njHf1ZY
         HHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164673; x=1790769473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fcqVoGIOsqHneznya0CjxdKSZ/9QYnIEWsldQdbwafY=;
        b=n+khQYbwCoQODZYJEAkzFR/19cqSrwV9n727eBroNIS5lFQMvd4+EfYW1nnRcHkYZy
         l/xe9GVWz2vzxMiU9raffUHjmNmXp2lNo+0ppU6zMNAf+mGIZ6YoTHu2THObMLyq20Hm
         u3oQvIB9HJx7fPT3gIztO54ztm+9RWlsVT1C3KrWMwT89HjCMVSZITW2WPH1dunmy+q2
         9CdnzVfwNUAT5i1MOvZ/sSUAtS08QdRC+YtGvst2KaT4IojdP9mzJ/UbQUCrEvZxv9oG
         op3pPiTzxa8YJtxHlkmsUpaFcXjo6jPGIXYWHmui5TnkENjjYivLyuSXcBxONjzbB9Me
         AHbw==
X-Forwarded-Encrypted: i=1; AKwUvBy3w0L+o7JpW4/wAIqPAgCe4IjeprazixPM9yJniijYhzmDJkSh/KdXCHrzZgIxrK+ef0Xl0dY=@vger.kernel.org
X-Gm-Message-State: AFuF++lwvJ9CyNEKdYf9PNoqQJYY4zLS9pVjc548otD6KwApd4dc1U4z
	t5io/pM5/k3+DZsrAB8y016+7JdaOGZlLRK+JruoksmNnBgM6VSpSrS1
X-Gm-Gg: AYBFou1yarGz8NzAmK1KBtdLwIVUxHpKqBnCvmd1w8GREgWHhxJmMr5pXPOvOpCU7HN
	tPBhWCmKHCzzQmp5Qq9Q7iU/yksGYYpqg8hDnsBM6qZWH1YtzPqBsoqAz/X5gAaMIRS3zH1JhLG
	VyU9L8g3dlTYMEQMq/7TKKyLaC5B9yAjMgfD7/w5ngUHe8vF+Acj8JmxS7CHKF5+332SsfYeyJI
	mp9uoWT+B+Ugkpk6uEutWbok50+gGxWdG9pTsAaEqip9qnGXBJQx/vPkaxqz3LsqbkwOv2mg5f3
	aLW8kgBhN+CTk5DGCUc6ctGS2Wl3EDOxrvbs9QL3cryvZDWysD69ElcovCRLRMhudjPM2supCGp
	9tGghvsqq4zYtTU+LSXZ4wq+i+TTlBvoEcpBgxcc1M+KJG82cb9StDJZx/E2/pzQDy3/oJMImfD
	ytKjmyCLS5B1Fu2fx12r4MXPaFSGsM14r108AKEqI0YN6vAwgw97SKaXASGgNP+ZvO
X-Received: by 2002:a05:6102:689b:b0:7a1:f7d2:e831 with SMTP id ada2fe7eead31-7ac1d4f3614mr1859344137.17.1790164673544;
        Wed, 23 Sep 2026 04:57:53 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98517a8ecaesm2629757241.12.2026.09.23.04.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:57:53 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 RESEND] xfs: bound inode fork length against the fork size during log recovery
Date: Wed, 23 Sep 2026 08:57:44 -0300
Message-ID: <20260923115744.3160635-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xlog_recover_inode_commit_pass2() copies an inode log item's data/attr
fork region into the inode buffer using the on-log region length without
bounding it against the fork capacity, e.g.:

	len = item->ri_buf[2].iov_len;
	memcpy(XFS_DFORK_DPTR(dip), src, len);

The only guard is an ASSERT, which is a no-op on production kernels
(CONFIG_XFS_DEBUG off), and xfs_dinode_verify() runs only after the copy.
A crafted image with a dirty log can therefore drive a heap out-of-bounds
write at mount time. The XFS_ILOG_DBROOT sibling already passes
XFS_DFORK_DSIZE as a bound; the DDATA/DEXT and ADATA/AEXT memcpy paths
did not.

Bound each logged fork region against the destination fork size before
copying it, and reject the log item with -EFSCORRUPTED when it does not
fit. Because the recovered inode is only verified after the fork data has
been copied in, the checks are done up front, before any memcpy into the
on-disk inode.

Fixes: 658fa68b6f34 ("xfs: refactor log recovery inode item dispatch for pass2 commit functions")
Cc: <stable@vger.kernel.org> # v5.8
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: cc stable # v5.8 (per Darrick).  Move both fork-length checks to the
    top of the fork-copy block, before any memcpy into the on-disk
    inode, and drop the now-redundant ASSERT.

 fs/xfs/xfs_inode_item_recover.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index 169a8fe3bf0a..6c7dd7dd7032 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -507,6 +507,25 @@ xlog_recover_inode_commit_pass2(
 	ASSERT(!(fields & XFS_ILOG_DFORK) ||
 	       (len == xlog_calc_iovec_len(in_f->ilf_dsize)));
 
+	/*
+	 * The recovered inode is verified only after the fork data has been
+	 * copied into it, so bound each logged fork region against the size of
+	 * its fork now, before the memcpy below can overrun the on-disk inode.
+	 * The DBROOT/ABROOT cases already bound their copies against the fork
+	 * size.
+	 */
+	if ((fields & (XFS_ILOG_DDATA | XFS_ILOG_DEXT)) &&
+	    item->ri_buf[2].iov_len > XFS_DFORK_DSIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+	if ((fields & (XFS_ILOG_ADATA | XFS_ILOG_AEXT)) &&
+	    item->ri_buf[(fields & XFS_ILOG_DFORK) ? 3 : 2].iov_len >
+	    XFS_DFORK_ASIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+
 	switch (fields & XFS_ILOG_DFORK) {
 	case XFS_ILOG_DDATA:
 	case XFS_ILOG_DEXT:
@@ -546,7 +565,6 @@ xlog_recover_inode_commit_pass2(
 		case XFS_ILOG_ADATA:
 		case XFS_ILOG_AEXT:
 			dest = XFS_DFORK_APTR(dip);
-			ASSERT(len <= XFS_DFORK_ASIZE(dip, mp));
 			memcpy(dest, src, len);
 			break;
 
-- 
2.53.0

