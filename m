Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354053;
	b=wD1+TeAXQJYBq13vCXoTQCk97fid+z1qT2dZn5ZPrGNiP9QpXiCz+FDBe5u0+6zZiseT
	 P9w1EIBSPMSKQCRLqUYTUL81071eHAXm434TXwjBSl5gOSDDzftrQFuBr5J72OMeRCvsA
	 aQGJ7XFxVMTevQPwuCPgRzG5C1ipt0slknVbfD9Heyh87O/UuJ7u75eVffQkANnDXjW81
	 fCrdVZU3SbdQUKWpAjEJKFUeSSYOlwr3dZTJkLVfnZuLdH3LP0Btf3TZuKXUm4pS3mtlg
	 7FkTWu8Ya/7SBuTvvXhqSHMoxs29JF2h5GzbUs7VsivmVw8H2oll1o9BoHj1/7R/GTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Owbk8go3s/YK6qq6glJqe7qttYuK2DZ19j1wIpD/QKs=;
	b=xXd7KouKInW1aeo/D9HBYGn2p8JE8bc1MgJA38fB8+VuiBVws3S+1UTqA717fTxKNZ1R
	 qZ5/iFmyVOMjdkuBKKiqOXdcy2IslfPEY8UDTmkt3d+dmhGCsBbm4nQ4AUKCPbb8AbBGm
	 cvqNu79GTlqiPa/sLusEDvFJNUFMuw0CIopxQs/4WxnwOKPFTt1KHz/UcV276pbBsvII8
	 noyYlpZrYbHoaD3YRCDAzre+0apyoUkUEtpupSWZx3z7lr1Ah6XvjPEOGd5YKYpWl98uy
	 qYAAhL2ODXmEhXxdMx5btk6dnJPFQNLTEdCHeaPGIUQOHbdhQkl5D+pBEWFSttWVoyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mozlZtiw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mozlZtiw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999341F0093C;
	Tue, 10 Nov 2026 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354053;
	bh=Owbk8go3s/YK6qq6glJqe7qttYuK2DZ19j1wIpD/QKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mozlZtiwgLiMdgyd1RZx8WPghU5UsVwHe4s3H24bCL+Mm7WpAOaQC69nsOXIumyah
	 xCVZVYM2kfdCeSoB4067Fn61YgpiTf0bpwPiwR30y+ynXkpEcPfjseARU1WGWG+6CI
	 5AGsYwmKhzbrUdY9wNKPZWjvBamatLpi1XC8fPcmKMXjtY/19yIVEkV/EZvnmGCQsr
	 UX9oaFCulOeNfS2kl9DyKg751Wns/bLxAoP2BP5MJ+iiW2tE+eH6QfXxDKfSvFbGpu
	 F6na4mNKdb0VVAuZWu0hd/Bo7D91V3J6q6OkZ2aG0w+JfK2acfLqMnO+NhenU/CZwn
	 z45Q+xXLs8osg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daeho Jeong <daehojeong@google.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: don't use truncate_inode_pages_final() on live inodes
Date: Tue, 10 Nov 2026 18:40:51 -0500
Message-ID: <20261110234029.156812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055222-failed-6.1-74bbd6ada01f@kernel.org>
References: <20261107055222-failed-6.1-74bbd6ada01f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

[ Upstream commit 74bbd6ada01f91fcad60608e0417bf45a9fa99e6 ]

truncate_inode_pages_final() is meant to be called from ->evict_inode.
It sets AS_EXITING on the mapping, and nothing ever clears it, to tell
the VM that the inode is going away.

f2fs calls it in two places where the inode stays live:

 - F2FS_IOC_START_ATOMIC_REPLACE uses it to drop the page cache of the
   original inode before setting i_size to 0. The atomic write then
   goes on through this inode.

 - f2fs_abort_atomic_write() uses it to drop the uncommitted data. It
   is called on eviction, but also on the last writer's close in
   f2fs_release_file(), from f2fs_file_flush() when the atomic writer
   exits, from F2FS_IOC_ABORT_ATOMIC_WRITE and when
   F2FS_IOC_COMMIT_ATOMIC_WRITE fails.

Other processes may still have the file open or mapped in all of these
cases. The mapping then stays marked as exiting for as long as the
inode is in memory. This stops reclaim from storing workingset shadow
entries for it and breaks any code that assumes an exiting mapping has
no users left.

All we need in both places is to drop the page cache, so use
truncate_inode_pages(mapping, 0) instead. The eviction path is not
affected, because f2fs_pre_evict_inode() still calls
truncate_inode_pages_final() after f2fs_abort_atomic_write().

Cc: stable@kernel.org
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ sashal: Omitted the atomic-replace hunk because atomic-replace support is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6f792ebe6f530..ef1b80827fb0a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -193,7 +193,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		return;
 
 	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
+		truncate_inode_pages(inode->i_mapping, 0);
 
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
-- 
2.53.0

