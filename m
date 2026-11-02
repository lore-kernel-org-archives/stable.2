Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659190;
	b=E7wC5Fg/RJS4xq5qLRf97yIZZMs1TJskAyYoUWc0UzpNrDvNVta9Y02OQgxtogJbj5iw
	 31PRBw0zL5/mJdm3DescXZkDIfUbhNVgE4cae2X33nNE9+bDaAvYkwHUY5byQbBZ5oLLo
	 +P3HWVLXF2THCJqHwsr8xhAuP2uTdlQRbffaF+1d5dCRFvOBElfpeTzxNHamFGr4BjS/P
	 37+RAtlRzU0ukKh8F/nz58lm0QL1DQ5xvhfiUYEL8uLEp+z3E4n0IosxaE1rbaohb6f3a
	 TnzZi0zNKJRi9c+a+Vmj6COZ6VVz/epu6JaPY6KgCq3Dgp3sF5GIZ0xoMtnNcrT4YlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659190;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U5TiAoAd5cVqE1NQgjUPAZnz47J4i+jszOLVy5sh2PU=;
	b=EEKD0w0dFTSy8b2vtWRdEsmxemc6sL4g9N8P4rq7ukIHIxmRtq8kTAZmiA8QmR5SUTwQ
	 HuiiGC7yCi58pS5577+maI+3IlDIlGGdwZ411HDlNQb5lfDI6EwUW1cj0Wm43fqpogQMn
	 IBw1fGXeyUj+Z2mr30xgUriVUXGF+jrU+05eJcFrw2vkNDwVhX2JRNaTk1IkuRBscUDee
	 A53rBZmKiP+NNJMv82Cu9FerLstxTqm9wvD+bwfoqj5um30DQg+EIleAV6YjKnxoP3WbW
	 2L5hoGDDhHf611k7abVjGyJxY/E/Fw1vfXsMKfx/BGVD1tXAuPtK3v7xu88VBulmhuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxjRnBXo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582E606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxjRnBXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4654F1F00A16;
	Mon,  2 Nov 2026 22:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793659189;
	bh=U5TiAoAd5cVqE1NQgjUPAZnz47J4i+jszOLVy5sh2PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxjRnBXoKhqbxq588220rRja5LibgOmEjpjFF907rJ3OL5NQRQhhVXwV5ZCfVgh5F
	 xTrd3prAKYNBZ52Lhi0m3xgAAMNRm4F141Tgxwfh/6SA/1NR45e6Tn/cv3pR0cYDvj
	 NWsljWNiY+BrkDqwfeSBFoWsbdc4UtFnEvOvN4ogmGDGVL1xpS1bts+I0dwmE6loaA
	 sh6LGpPiDIc2BFAR1OOawX4xG4Y4BnE5Q1XfmGtZ7LD6AwywSUgzAjlHfI7MCte2s0
	 RCKOVgi7k3lkqH492eWX5q1J/fopR9xzXEzvHaaVKzGFyJjhf8wDmqRrlqu5NzatiD
	 1UUQVb6OXdh7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjun Gwon <d3bugee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: serialize directory emptiness checks with readdir
Date: Mon,  2 Nov 2026 17:39:47 -0500
Message-ID: <20261102223759.2132920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110241-arrest-granny-ae4b@gregkh>
References: <2026110241-arrest-granny-ae4b@gregkh>
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

From: Yongjun Gwon <d3bugee@gmail.com>

[ Upstream commit 7220980b2423d06a0604516129bfa4cec8a697ae ]

SMB2 QUERY_DIRECTORY holds fp->readdir_lock while it calls iterate_dir()
on fp->filp. An SMB2 SET_INFO request with FILE_DISPOSITION_INFORMATION
can resolve the same FileId and call ksmbd_vfs_empty_dir() on the same
filp without that lock.

iterate_dir()'s inode read lock permits concurrent readers and does not
serialize per-file iterator state. ext4 stores its dx readdir cursor and
fname RB tree in file->private_data. Concurrent reset or refill can
therefore free a fname node while the other worker still traverses it or
retains its RB-tree link, resulting in use-after-free accesses.

An authenticated SMB client with list and delete rights on a directory in
a writable KSMBD share backed by ext4 can trigger this when the directory
takes the dx readdir path. The client overlaps an SMB2 QUERY_DIRECTORY
request with an SMB2 SET_INFO request carrying FILE_DISPOSITION_INFORMATION
on one live FileId.

In one x86_64 SMP KASAN multi-shot guest using ksmbd-for-next at
171df27077fb, the unmodified kernel reported a cross-worker use-after-free
before a panic. The first report's access and free stacks show the two
request paths directly (trimmed):

  BUG: KASAN: slab-use-after-free in ext4_htree_store_dirent+0x488/0x550
  Read of size 8 by task kworker/2:0/29
  Workqueue: ksmbd-io handle_ksmbd_work
  Call Trace:
   ext4_htree_store_dirent+0x488/0x550
   htree_dirblock_to_tree+0x535/0x990
   ext4_htree_fill_tree+0x319/0xba0
   ext4_readdir+0x175a/0x2f40
   iterate_dir+0x1b6/0x630
   smb2_query_dir+0x1003/0x1cc0

  Freed by task 279:
   free_rb_tree_fname+0x67/0xc0
   ext4_readdir+0x13a9/0x2f40
   iterate_dir+0x1b6/0x630
   ksmbd_vfs_empty_dir+0xa2/0x100
   smb2_set_info+0x2ffa/0x45d0

Take fp->readdir_lock across the entire emptiness check. This places both
iterators over that handle's filp in the same lock domain while
preserving the disposition status handling. The exact code change
completed a warning-free x86_64 KASAN bzImage build. Tracing three request
pairs showed that the two iterate_dir() calls no longer overlapped and the
expected statuses were preserved. A further 1,600 reproducer iterations
completed with expected statuses and no KASAN report, Oops, or panic.

The reproducer and complete guest configuration are available privately
to maintainers on request.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yongjun Gwon <d3bugee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adapted to the existing directory check without the ksmbd_stream_fd() guard ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 51436cc50c790..7ff5b9b3f243a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6574,6 +6574,7 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 				     struct smb2_file_disposition_info *file_info)
 {
 	struct inode *inode;
+	int err;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
@@ -6582,9 +6583,13 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 
 	inode = file_inode(fp->filp);
 	if (file_info->DeletePending) {
-		if (S_ISDIR(inode->i_mode) &&
-		    ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
-			return -EBUSY;
+		if (S_ISDIR(inode->i_mode)) {
+			mutex_lock(&fp->readdir_lock);
+			err = ksmbd_vfs_empty_dir(fp);
+			mutex_unlock(&fp->readdir_lock);
+			if (err == -ENOTEMPTY)
+				return -EBUSY;
+		}
 		smb_break_all_levII_oplock(work, fp, 0);
 		ksmbd_set_inode_pending_delete(fp);
 	} else {
-- 
2.53.0

