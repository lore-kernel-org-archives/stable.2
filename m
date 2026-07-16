Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7016B3019D8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216229; cv=none; b=ZrKiwfOoho9V61hDTw0jHQ6XfWOCanZnHjdlicS5YqYWuPOFMBp2w216hmMGa32ZlvxM5SconZxo/yAjp0FqGjZ0DIbm4L9KdCFC6ho+2GpgJKjo9ysU/6jmTj76Tur+yx+3UOg6U/Yy+JQG4GNcqPoiVOT81HfP/KIFp9IbYSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216229; c=relaxed/simple;
	bh=q5eQ4gcu5q1hO5TvSTm2OWEy3qp8Tb53R5WP+yQdhPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILiyUznNoxJMLJsIXFCBZokMgENmBq0TsacsN4r+FxBLj2VA5K8uI5VKAXAxrxUpr0hiJkCreqbgmN5dqvsYTe4NLJIfkgLzpOK1ckz30aF8vVWrDLUamn1ysTqFidwULCtPjAFKVPDPcnGmt+LHryEmRV5kAPQyRwJ0u8HN5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEdqMtEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEdqMtEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6071F00A3A;
	Thu, 16 Jul 2026 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216228;
	bh=8h/ygwnu8MbGX7+0ydI71uS5Plg6w4pVYz9yJ+MsJSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEdqMtEB8yJxcGntxZahXluo1/3/A+JtxXwvt731FZ4/bBs+bDBfxzB7+32+BOiqx
	 dvc2ecF5Ai3GuN3YrvjpbsacOF38RvHMJR1VGcABOQ61QyifpowLL5woXl7YCF1kYs
	 et2IbDSDFiarlj3Cnc1A0FyDlPar7HKIS/IGMJeHB7Qi/BT6tOH7WOZAtEoOa6g7ic
	 ZpolvhIA96tuFP/apwvR9AgwG/xSQaacEet+/8+oITV3+48XZmA+CFzL1hDB6TBXMZ
	 1Je5drb1rgiVffeXKKMeZ/dmPWVSU48JpW+HeUFsWW4Gt6EHZVbJPq/mFNDfBPXoO8
	 Esfs86mj2EABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	munan Huang <munanevil@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/7] ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
Date: Thu, 16 Jul 2026 11:37:00 -0400
Message-ID: <20260716153704.583869-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716153704.583869-1-sashal@kernel.org>
References: <2026071414-kosher-parsley-920b@gregkh>
 <20260716153704.583869-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 235e32320a470fcd3998fb3774f2290a0eb302a1 ]

When a durable file handle survives session disconnect (TCP close without
SMB2_LOGOFF), session_fd_check() sets fp->conn = NULL to preserve the
handle for later reconnection. However, it did not clean up the byte-range
locks on fp->lock_list.

Later, when the durable scavenger thread times out and calls
__ksmbd_close_fd(NULL, fp), the lock cleanup loop did:

    spin_lock(&fp->conn->llist_lock);

This caused a slab use-after-free because fp->conn was NULL and the
original connection object had already been freed by
ksmbd_tcp_disconnect().

The root cause is asymmetric cleanup: lock entries (smb_lock->clist) were
left dangling on the freed conn->lock_list while fp->conn was nulled out.

To fix this issue properly, we need to handle the lifetime of
smb_lock->clist across three paths:
 - Safely skip clist deletion when list is empty and fp->conn is NULL.
 - Remove the lock from the old connection's lock_list in
   session_fd_check()
 - Re-add the lock to the new connection's lock_list in
   ksmbd_reopen_durable_fd().

Fixes: c8efcc786146 ("ksmbd: add support for durable handles v1/v2")
Co-developed-by: munan Huang <munanevil@gmail.com>
Signed-off-by: munan Huang <munanevil@gmail.com>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: c1016dd1d8b2 ("ksmbd: track the connection owning a byte-range lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/vfs_cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 2528ce8aeebbef..65dd85668cee24 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -317,9 +317,11 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 	 * there are not accesses to fp->lock_list.
 	 */
 	list_for_each_entry_safe(smb_lock, tmp_lock, &fp->lock_list, flist) {
-		spin_lock(&fp->conn->llist_lock);
-		list_del(&smb_lock->clist);
-		spin_unlock(&fp->conn->llist_lock);
+		if (!list_empty(&smb_lock->clist) && fp->conn) {
+			spin_lock(&fp->conn->llist_lock);
+			list_del(&smb_lock->clist);
+			spin_unlock(&fp->conn->llist_lock);
+		}
 
 		list_del(&smb_lock->flist);
 		locks_free_lock(smb_lock->fl);
-- 
2.53.0

