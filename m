Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9B446840
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226139; cv=none; b=pokE9QX1s6Unfz0o1KPA+HcUbPhazP/aCzdKDxE0AjXUw5DBB93AODUiBskRICiQKhMhKbk3KQ+P+MASuZUj+sw3stOO6kx4Vxq7+H2PO4q4s4AydcfVCDSNhVgXRwgEb3wOGd60ot33P4ITBYryFztz2ziufW1CrKjOqpO7ybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226139; c=relaxed/simple;
	bh=JW5lV6QzR/gz/VxJKF/ysWJ2BV0tccL2n6Wk/Jj8wFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mac4sMlFcgMEqk8GqaoN1SdBTAKS/Lgz9WWf2kfEGQCdSUMdIMWUd9HG1YrUSzlVuSJ7TVQgqmRMaruQakhGM1qYU7UDaZt73X5b5a3UCOFSCy1G4o/W+0tuPhwM59urr8f2ZWbbh/UTEUq4HTPGENDc/JQZG0XnS+ORjuWCX+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klJj4ey1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klJj4ey1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69981F00ACA;
	Thu, 16 Jul 2026 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226129;
	bh=1yowg+baIjA+VCzswIiTxD4UxnRCeeyBiXXIKQbzYHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=klJj4ey1hOxkcw4zdRJvn0152YD7tpF8wDS5QYk8ZWZtXK8q1Mp+J5X5L8eoXs9hv
	 Ymo4rjVL2TV3EIuU6+iuFxdsyXIBhWL/EzdwZ/j5L5DwoqFKpDJyiqMsRaPTRg+pkf
	 w/dxGAc0F6CXFRQwtxZFZx4rIddiVTESs5L9gGWIJT3KaA2iTAzmuCYZUm4uyAzJc5
	 xUNGPwFOuP5lJznw5YFcGtFFHSHtFuqlnPjFBuaPRJIDeXKWvYjoXaIuhfzJGDSbJ5
	 W1NxGHFU+9bmlMRznwOLOm52X7Cv9480VUW+xjct5GOeiy24vcRRDkmQ7K0JC0lpBD
	 LeaZikHrv9J8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	munan Huang <munanevil@gmail.com>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] ksmbd: fix use-after-free in __ksmbd_close_fd() via durable scavenger
Date: Thu, 16 Jul 2026 14:22:01 -0400
Message-ID: <20260716182205.921233-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716182205.921233-1-sashal@kernel.org>
References: <2026071415-rambling-chooser-b760@gregkh>
 <20260716182205.921233-1-sashal@kernel.org>
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
 fs/ksmbd/vfs_cache.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 2528ce8aeebbef..65dd85668cee24 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
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

