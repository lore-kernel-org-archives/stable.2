Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FD3D667D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885261; cv=none; b=mrVYgbnl7ofPKuKI02zjtSjq16f08nyc6+as+Z/u3FZZbew7uaVd3xZoQAXoJHRLae9F/6Jgywf7sP5b10JSshOkHy72F8bpn1+Y22BySwBup4Vbay+9zWvF0/mA7l7hKGXnx3u1mqMO7BT58rSZ83OtcYMhU3yPLtz5jXRRvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885261; c=relaxed/simple;
	bh=div+Ou21HPwvbQnZhN5P7XYJdEa9ICzLG3RzHc+7684=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFnqyLJYQuBWm+D+Ct0BbPmo9y5hAfWxtIdaJ91UTrvU7lgc6VR8FeLjATBLRNOpzuXtYjYz+SJNVXN0yu2NeYziPf0ZhfjFDkNCWG7MCiZXlGC0jANuAL1oCHYuyf8PJ6xRWPOZSeXx7ISesDDmNa+P723CAdYVJERBjzzyFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=RvXJqo5f; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RvXJqo5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0o
	kxf7ehqUJ0LZKPerGNiv4PTPkPmQEewfHfZJI5Fug=; b=RvXJqo5ff5IkC2yayF
	LpL8/U938JxHydCuP7FrIuUxgHrxGEs6/egcPvy1OXQSbVSahfx65+rgKFvcnVBh
	bcGpB5Rsh8tPGmgJBUPSFgOqNmVPFYMmReSelWoMU393Wb/saKMCVV3RGRJ/Fb1d
	3FJNF2BHX2lJ1JL+FGLPvXwTc=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3P9Oe_81qEuNLBA--.35692S2;
	Tue, 13 Oct 2026 17:53:35 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Barry Song <baohua@kernel.org>,
	Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: read i_size once in f2fs_vm_page_mkwrite
Date: Tue, 13 Oct 2026 17:52:34 +0800
Message-ID: <20261013095235.731331-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P9Oe_81qEuNLBA--.35692S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1rtr17ZF43ArykWF4UArb_yoW8KFyxpr
	Z0krn8Cr4fWr15uwsagFn0v3WrK3s7WF47WFnrGw1fX3Wjgrn5K3Wrta48WF4YqrW3Ar1I
	qFWDKFyfX3WUJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1MKZUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsR81BWrN-58VXQAA3R

f2fs_vm_page_mkwrite() reads i_size twice: once to check whether the
folio is partially beyond EOF, and once to calculate the offset for
folio_zero_segment(). But a concurrent buffered write can extend isize
and cause the following race condition to corrupt data:

buffered write writes [0,3500)

CPU0 (write fault)                        CPU1 (buffered write)
 ----                                     ----
 f2fs_vm_page_mkwrite()
 folio_lock(folio)
 if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 i_size_read(inode))
 /* i_size_read() = 3500 */
                                           write(fd, buf, 200, 4096)
                                           /* writes into page1, does not
                                              wait for folio lock */
                                           i_size_write(inode, 4296)
 offset = i_size_read(inode) & ~PAGE_MASK
 /* i_size_read() = 4296, offset = 200 */
 folio_zero_segment(folio, offset, folio_size(folio))
 /* valid data [200, 3500) is zeroed */

Fix this by reading i_size once and using the same value for both the
EOF check and the zeroing offset.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261012030315.978375-1-zhaonanzhe%40xiaomi.com
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..672182300991 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -124,6 +124,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -223,12 +224,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (folio_test_mappedtodisk(folio))
 		goto out_sem;
 
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
 
-		offset = i_size_read(inode) & ~PAGE_MASK;
+		offset = isize & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
 	folio_mark_dirty(folio);
-- 
2.43.0

