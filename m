Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663128;
	b=ddju3V41aKf8hnUjSsyg17wnMagi7Sc22Itl+1PrQoeePcKJpNYatpw3C4U2kgGych4l
	 agqYwjM8cmREwT34Fsw0LBXeJWPctZG6Yin2EFQEhvizfw1q/B0YvMFENqpj2LaV5sbW5
	 YwWMiL5GanaD5c/NSvB0XmCpLy9WSticB7DAIvksHdUE+20Rh2PlHdm/Iq2p0qTJkQ9fr
	 xC2ZpoId4A+JA3UwBbjK2xgCWEuLYCOApUZfzjckxoY08c7EkHplzFhFSSXZ7bjeXPvbB
	 O4tMOElPz4YCJAbzFlzkdT0J8M3h+nx6YO1lmtWGg4oVTKN2KmMJN9phJXXgwXgcdmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EHiF5cSD0SeACs8er5oOSSGUf9vIit/oZi2eyqsY6Jc=;
	b=pztLdC2dGrVtqsPdZQRrBKW99xtcFKkimd0IZ7u38oiPTe9wu19DrGFtMsUlVrVh3pz/
	 7700EkbamGCLXaQswoPUXVhmhxEp7Up5uldp/9JOfq6mQCa5FM1ZCi/UG1EW4fQHwgNlb
	 LTf2Vsh4NOCUYDZq5ln/FgevY8fsV72+LWDx6s4SZmC9fuYBB1gauwqUVKh/m9k9UyzQN
	 cmrnIkzRY6V1JrrpF9RSJ2IXhybfEa3WgxjMpvahw58Pvr0cTstzTbTtW0qQIxVGtcPu1
	 Jn6VZtSShfeGVs5LxDOD6EpDstnAH+duemgt8ptmTBak+Hp3QYlh7XGk4Ucgo0Kd5tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e54nDZFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838E606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e54nDZFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C551F00A16;
	Mon,  2 Nov 2026 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663127;
	bh=EHiF5cSD0SeACs8er5oOSSGUf9vIit/oZi2eyqsY6Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e54nDZFHRONsgtSF8+CU4hLcvSNcqbPASGyp2cjerWqY1ES42aHzyIcA4OFRcV+SC
	 wnytRZPFpmbYCJ8n73yvfjtPHRT+QwSGtxfWZdL+lEZcVvFvd1JokN0oJGJubpy7bl
	 O2G3ri9A+olk5gpNmtZVOpG++/Y6QdPp1lRhpLTzYH+pl5atOS8V+DqBXFyG8BZ80w
	 S33Owoy+0wLu5/3O7XegMVnkzYX4HOHRDHC/3JtLjnu/zjBqAVqU/ii+Z0LOKqnex0
	 kwsock+wp9rBsBvTsxmFRxdL65xBxx60LNKqLQoQARdNNFIiIpgk4Lf83p88MH4QGj
	 T1E/7Gz+7B55w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjun Gwon <d3bugee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: serialize directory emptiness checks with readdir
Date: Mon,  2 Nov 2026 18:45:26 -0500
Message-ID: <20261102234410.2575558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110243-apostle-blitz-3a1e@gregkh>
References: <2026110243-apostle-blitz-3a1e@gregkh>
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
[ sashal: omitted the ksmbd_stream_fd() exclusion from the directory condition ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 1c13f359ac0cf..895c5dcfad617 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6089,6 +6089,7 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 				     struct smb2_file_disposition_info *file_info)
 {
 	struct inode *inode;
+	int err;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
@@ -6097,9 +6098,13 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 
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

