Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235C4F055E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892602; cv=none; b=kYOY75aFCGWscIVT0TvuA1aIAOTQnt7MEvGuTMRAT6uZ7YRAxFM1IYrmbVevfPt5/iZ+UHTjdZgE5MggMdUy2rhE84V7NXgD939E9wN8eEKEr+vr4yttIWDb4P6ZVEaLEWUIsoGpPFuJ0o6ABhApIN804BzR3c8XHV5kDmJiBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892602; c=relaxed/simple;
	bh=jta5wjdiHYkDEBCD2FaUvr4GTFcZOd1wWSt7UE0AljA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9K27s6oq17MfQaQ0UDDOvIk8dPmzes8HImADZq/WTzo0QlbEV13F8WzVFDlwxGpYoQUMCNp5qtYvMS/9nIgDjxUfnxsXS0vXpQxiCA3JmJMBv7c+R2k5hBKlTuWUwufHa0FDxiYWnO+ElSXLjDCnA0sBbvOOK/MbAlQ1tu8jEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qScQltUU; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qScQltUU"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3ab00078c22so85876a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892600; x=1792497400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=;
        b=qScQltUUkP9Q+z5kB8A7OofnHSzWQqrhr3a/VQ/zI5TwxMGaRqJU8/XFKWb9q41jDx
         vR5KXzMNlbB/IcXe/OwXN5q8ry4JMd8Ttn1Uvt++tTWzzp5ACDY7RZgaDPz/jExn8GjM
         HIWY3AKXqK/HhAvlnlW3184j9H0RsDqJDb4hlpa4HMMN6XHHYWGkd0Vd5iKmH/F1S0+R
         L8M8PBEEke8SHq1IN63vVIA0SG1mRPcsmP0+rKwalS9o1jPLNhPco/uY/6KspURLZdwz
         +aCvnIW8ZD1aNSOEzqRSLgVT+85jZ76KeRDvI5tiOnlZuwNqKDomC/3LQQiSL41KKc24
         jBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892600; x=1792497400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=;
        b=IJK823urkNNzlm5A1jWhtMF533RpH9xFNJPPzPJhuibKqlO/eZQycLkpr5+xrxWPpn
         NoS9r5wrzHvAA5Rd42HiuORxaI2vKqozsOgBxvSWZklxQ+GJoR6xjtvDHTANvnuPBEsH
         Vy0TpEUNcuWYb14A1sjyCcGn7r9J+6kI0a+SrMZrhGMLSpjI8kBZHBEIzWOuUWQn+qsA
         G+CoDHL0vyv4ZDu8r3tRucLYGq7etscZa4gTwf+souaSMKLZiwU+B/r2BDXUosbjEB4N
         clAPuv2bYTz9VkH8MrKLhYv8Yqv1erjuus8/yD65wJRgMZxTFaFsoNS+pvEeLA/ot4AR
         mI5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxviXHeA9rdNJkosw+H7vcEt7Xbtkd5TmVcuiJtYyk5FlFyxndBOAU/OPTOmpz2VZ+KfdLLdX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9rbdIysVr0OhWVE2sKx/Db1+JYLeh8c5AaiS8NtALrdkDAeNY
	rBLRRIpgzyo7qnmMANleEZLqahUhX7FmrSrmtWaI5iVmW6A/SYIO+DsF
X-Gm-Gg: AYBFou0en5KxPINmHoa3WRMZSTpfWoK1PNoPlYBTKqu864WiAm1kCYHVukxzqxY+J02
	H+tcBb1kDPGLsBFPpVLOYlFi/lP3bvh83xH/aUMjZnYqpL91YFrjybNKCvvtyParYlKvKIogR3S
	2pH0Qy7SZhxMHLOVa9Y7omUC5uRqJGyxNrUpOuZk8d4F3Mbnw+/CoFkcnRhSMihhouQiSnLlH6n
	PcLIxvtsJLcNCcwItljPye9+St5usXr7PfH7mc2DkFoZ0jjHqTilB+2ttIoFMs3yprEb3C1PDhr
	pxmllIVPXX700/kLyGjbIPbxdgN9gTEenOfUb0tFJ/cXtADrxKjRpHRoKA2phSuxGjiovIo7N3h
	9GjVomB99XzNc11sK/NJxUFRM/TXhh6Y7bI+18PtTCmJQUL8G/MDDQIShsa2GZ21lS5J4SODlOj
	yV9gVSAVZdt4ZNCJpVJ+P7RWCFhZWN5Rw0gKu6nC31lSn/m+RhbDdW1ZDlWaxxvuYivYpyKM9TA
	Su9pZo9+QpNtq2HAoIVDeJ3X1q0TPn9Id0l
X-Received: by 2002:a17:90b:3a48:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3ab3a367926mr6555917a91.6.1791892600332;
        Tue, 13 Oct 2026 04:56:40 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:56:39 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Juan Yescas <jyescas@google.com>,
	Daeho Jeong <daehojeong@google.com>,
	Dev Jain <Dev.Jain@arm.com>,
	David Hildenbrand <David.Hildenbrand@arm.com>,
	linux-kernel@vger.kernel.org,
	Bo Zhang <zhangbo56@xiaomi.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Nanzhe Zhao <nzzhao@126.com>,
	Pengfei Li <lipengfei28@xiaomi.com>,
	Ryan Roberts <Ryan.Roberts@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/18] f2fs: remove mappedtodisk flag usage in mmap write path
Date: Tue, 13 Oct 2026 19:56:05 +0800
Message-ID: <20261013115621.968742-3-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip marking the folio dirty.  Moreover,
it causes the following race condition with filesystem freezing:

 CPU0 (write fault)     CPU1 (freeze_super)
 ----                   ----
 f2fs_vm_page_mkwrite()
 sb_start_pagefault()
 /* shortcut: no dirty */
 sb_end_pagefault()

                        sb_wait_write(SB_FREEZE_PAGEFAULT)
                        /* no waiter, passes */
                        sync_filesystem()
                        /* folio not dirty, skipped */

 finish_fault()
 /* PTE writable */
 fault_dirty_shared_page()
 folio_mark_dirty()
 /* dirty folio on a frozen fs */

It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
folio zeroing.

Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
f2fs_read_single_page().

Reported-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 29c4a81eb..f2d2f0106 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2481,7 +2481,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fc959cdb9..d680f6f8a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -225,12 +225,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
-- 
2.43.0

