Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657728;
	b=zGH9NGAf3tYp7dGunQRWcu2KUmTi/+s8Er5rtvLZYBW5mOgnH9je0J7gv3S77R1ldac0
	 h3r3wSTN3GuwNGoZUu4e/Hd5GBZb6XdOxRYVM7htYMog5ZBvD1/ACAShDfMV9vYPUO6Qh
	 OdZpemvaXmNlRAVhDnBXtBeOvTfYi2khF6/3fKKsG4d7rnCb9llGNxr4ZM/fV67nQUS06
	 ud+42rdtAp112mKisiKnxH/VRKTpBMSe3aOnVUN2MRwkSDqzu+qL4esXobc/REdnnEdOr
	 Qk5vYwefUq8d0ZIlIa1j/5G+XbNhNLYsfYG/HuBgSkJzRKtEGQBEvoTqCwpW9sIo46g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657728;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8b5ULcVEEMSYAqO+yslC0UqeEuaJkEAY07J9LgZtD2c=;
	b=gKOii6e5iwTBm/lE+q31auDbO5KAn0BDPFUh1XMCidEidV7ZCmwr0BnHB3tNiourfDfn
	 do4rEf67tj3qnIKC/AvQHPE1jVkp7CQrm1Nem9SnptyZLHgBaLvyP+2y7l6Ntmc0Xfvd0
	 TGHliUcRzavCUOsRESifr8uXvBIQnOe78fQqY6qydBqrBYz8339D+UDtNNS2ujGeCuiHw
	 uDVwxQQi1PBhOi697JI7xooNSsszmxOYkJFvE5Xw3lF+Wve1QegUgW/0SAqjD35leJ3v7
	 9FYU8hUkm9hjQkYL+wpFvuLZZyw4chU3zogsK6f82+9OU+J2gAh7PeansodpvviMTJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVKvVB1o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69687606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 22:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVKvVB1o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB221F00A1D;
	Mon,  2 Nov 2026 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657728;
	bh=8b5ULcVEEMSYAqO+yslC0UqeEuaJkEAY07J9LgZtD2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVKvVB1oGmGb9ktxFRR5b4NqdVYHSCFC+PHgI4IJ9XkLXtr4qaXnF3+CUDejdo5lh
	 N3VQib0kaULXJHLiq1Q7UwhjRruGzYo9tDReshHjpYZCTkKMtfaAxOraRtOyS3WryF
	 cbWWkIRvW4MIG7+Thv3CQoDi2dWIgo99AB96AAuachxDkX1twUIMbGvVuzrqff8ncn
	 Z/n9Zw+bCXpHQm5KbRL2X3r8EoI6KQm5vhiPXo8jWANjWZEWhD3VUvY1s77QiGdqSj
	 r+LSwc8MpYvIfg/6TMfaqKd+DV3aBx1AxMTUO9ifOecB3q2OqqmlJZI644LSGGcxnj
	 skcQICIzpkNOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjun Gwon <d3bugee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: serialize directory emptiness checks with readdir
Date: Mon,  2 Nov 2026 17:15:26 -0500
Message-ID: <20261102221430.1868858-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110239-facial-handiness-1e99@gregkh>
References: <2026110239-facial-handiness-1e99@gregkh>
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
[ sashal: adjusted set_file_disposition_info() context for the existing directory condition and older oplock/delete-pending helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7a9eac676cbb9..1b6cd2a1d02e5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6596,6 +6596,7 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 				     struct smb2_file_disposition_info *file_info)
 {
 	struct inode *inode;
+	int err;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
@@ -6604,9 +6605,13 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 
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

