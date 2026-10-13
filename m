Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64B4EA367
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892597; cv=none; b=LkpzPVtJb1uNv3WHJr/czD6UPELsn/RRgBrhKzksG1vnq1f2qQ/DIJper2U3xRIAei/qM6FxdGjpbGFRkcTAXvkaps1bPgZMCrnNiYsLWfLGxiMjmL/Hej6NG6ehs8IzBGfFeuxUtn64n2efelslIvF3bGa08caMXM4UYvqgvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892597; c=relaxed/simple;
	bh=aajoIehjNmVxG+zPDW2Mu4E0IvdQnS07fqtea4FejVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZST3eAfX+tA2gQyoRKABnbTnN29mZbedvSejSWxL/zDHP0abzPX/fCpd290UiKfcMWKOJQjS4k1ZF2DniEm0pkyf5U+/sgdBPcogKnr0YOD7Ek+zsWe7tEGCWXBq/LWifxVP9MkXgmnuqMmvkDI2oumyPRZhNHdOSeQxRMksVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFDB0kx6; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFDB0kx6"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so1464733a91.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791892595; x=1792497395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=;
        b=AFDB0kx6fAKpLPSIdJbimLrhllzTPBDU66dMN+6kRyxobZq4RjBfzPgeVimeOa2X7S
         BKXDqgUhDQEv57fi7+JOKmsKaMhbSzZg0tAkDXS5vIhEVOOKqta5zCGHmq7kreYNPeKI
         0p2mMUMEFOhl62DwbbRldJSWDqNNxf04vklAfqHfNdXuDLE+HOWyQudU1h6g5w3TTjlE
         K644W9JTbbxPOMNcWnEtRNMM794dmrivM2Bt9FNzahLspoqCDsu7EGLNU2NcsgcDJcHz
         YFytF4zzLg+JNAicCUH7UAEcHiyN7sATJW71YjbzS0KwGeqjSlCcE+7mNK33udeL/BT/
         t1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791892595; x=1792497395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aDr2CmceL3ca2fswvyyunUdCe7sbFULSntXyt994J+0=;
        b=jM4B+TnbyETeKIIZrjNj+MRrm3o2JRhGYdrYDx5wcebOtmiJypwUKIMhRrpV4ivgVz
         NgL5h6D25Fu5EcUfPGpOyuhACfiH/Uf3dzfrKy71tYjfr0M0ppcpK9/PWXMocqrSlYHp
         IrbL2/v3zAycG6TrNNoOpjmFdIvfjirPLU52dcv5AIuo4cXskvOte9BGs84aWgTeT3cq
         daSZ9+qhzK9T7r6uXs6iJ6SASwWhjjxW/ZIN9B8Qaog6PzfE+vXOrVq/YuKNqLZP6cPc
         a2kfMwtZU7KsVX3TV7gvYZojupTRjEOscGFI3fY8/+RRYC95afDPaawg2fukNXovTkh0
         pfyw==
X-Forwarded-Encrypted: i=1; AKwUvByHRS7OyO1Ut2Fq7x0oPNpOk5bAcF5fdUzt3PoTyjb67kzaSoLAwaD03tDvwWHe2bOun/LO6/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjE08vGIyk9dJVl9+1MH2wt7XTMU0oWGhRgx77IlJK1FYUrbwZ
	+35nvfjyNHe/S5u5FcqyN/5mV7+5Oz/st6KoYyHocEwMtzrxqVsejaB5
X-Gm-Gg: AYBFou2yy32ywKrbicLbI5VEhdxrn+SrG4TxMD6yU8HhcpTOemR+4Gb/tQwfpkqjngR
	RXZlf9AdZmpciykaIMaHqJEERVFK7wWsQAzZW2wUjIhWxYvQDjVvNJq9OSOwTnnjdLzF4XLvVo1
	DUZyiG57wk2bgKDWsIu+2dyERGnl4hHfz0RTzmDC0XpgNClhQj07FaRxr7oml4QZ1aXH/y7IEo4
	TRaNXL0MIcU1JUp9pPs45cvSJv+nj7aDNbYgQvJM/5EWf4dGsq7lfbBtDkcuKeo6W3BolWojwOX
	GIcxm1R9kOxCoxxU2TemmpjwzJRk7mmvlweOPSbEZD9IjQpiCPpRkoKjGayj5/juqMhKnsN7JZW
	3AF2bAF2bD/JUPtsdHRqJrJRAyhADXw//tCYOluxbgbYJ//V4/tkxJ/OFKF6njvFho38A2AXWyF
	cBfojWlEBcAnyIRoF/HdHjw4b3J+e3ccI2Y1Sp2PYCwlZGwompB8TKhd1qEMnBiJKA9fzkaBCa+
	UBK3SWPw0eodHgcF1bA2GoqAdLJ2SL5FFxZ
X-Received: by 2002:a17:90b:3c8c:b0:3aa:6b5d:a018 with SMTP id 98e67ed59e1d1-3ab3af94c34mr9681745a91.67.1791892595477;
        Tue, 13 Oct 2026 04:56:35 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:56:35 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/18] f2fs: read i_size once in f2fs_vm_page_mkwrite
Date: Tue, 13 Oct 2026 19:56:04 +0800
Message-ID: <20261013115621.968742-2-nzzhao.sigma@gmail.com>
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
 fs/f2fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ed1b944f8..fc959cdb9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -125,6 +125,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	loff_t isize;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -188,8 +189,14 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	/*
+	 * A concurrent buffered write can extend isize, so we store isize in a
+	 * local variable to let the zeroing offset match the EOF check below.
+	 */
+	isize = i_size_read(inode);
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
+			folio_pos(folio) > isize ||
 			!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		err = -EFAULT;
@@ -225,11 +232,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 
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

