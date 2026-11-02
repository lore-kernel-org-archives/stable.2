Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660612;
	b=WvymaleUJzMvi6LMVQPBP6MDhSnb8107GkzK8Jyq3z7bjJsqOmC07oHBJxp3W526snGm
	 FQIrNRBU8aqRWcAqGONRJf7K+vS8jVHD96ftuRg0x87knG70goqO7HlNtVlnaBRiRSAOC
	 AwbMbjzKj3xPoFq3MiOzwy5UDjsQt2FT6uL7/Vinc+drtr6/eUA//H7eDMwME3IkNNMcJ
	 PDE6UoK1nmEoF9oKzpdORFAx82EyW1ioOoYgTMitcK+xC38bk/I/e+l5scdOVg/P+U09r
	 o0tTN1/gJu74JMYFNH1Sr9kuJWK5GhXDdXqpekOe4CESH9zmgKlkrtDiaJk1l67vfoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lGocBAMC/i8J5/Hj7+KgWY7bfXnqCzAptBnBdvhLMz8=;
	b=Ch44ZNbbaJmRaivITFuinXQ0O9B9Qmc5VF7c2l/6hMvCj3ZSz2HueCJ8f1pBC3Pg4jY/
	 Kq75v2m8+jTVOxWerpH/+v/PHnvKTsDXat7TwNF11ByHKiw9V25N5vqF6a255hjHld54A
	 jmQidV8fHjA/P/YgMwN4mCLozQhHiRf0ZzsAaU3UQlQH38YEiFlj8ue4xsvVXWVp54YEQ
	 PbyNz+vndf5Kw1QOAGP4WwM3Yt2HS+n13gnGsMSElb6c4H/AwPxsIdpNl7AASZEH0+asi
	 410NUxthWznowLBKpZU23VyjHdLifZNZNzqTgcuwFAMl7Qbtb9whR59YWQ6ZnU72TpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lK7aJyVY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83591606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lK7aJyVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B611F00A16;
	Mon,  2 Nov 2026 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660612;
	bh=lGocBAMC/i8J5/Hj7+KgWY7bfXnqCzAptBnBdvhLMz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lK7aJyVYb08f8504WU5AtTvMMQjgTZ6MWMX6sR1bvlVc2uXFM80ISAMklv4WsArsj
	 MWGI/AmsDyeT1HD01FwvmBzv4vV0sGoq3N12zqAIPG+vKKiofjJ4jNgmSUl0n24i2I
	 C0MWPGGws8TeGac3qXVb3LfRipLHhzCrREIsOOtp9049/2vPSyqa03WGEfmlOoA+u3
	 AxLoz7JAhHWEu5vjjgc1LFzUE6ctiOE9NCDLBJfq+gb+9hgLwB1I/StvpK5DSAiP+N
	 42Y0jjnFMxr20qaj8LrGu5i2RDYu8aoklhm/nrrLq7xK7EaKKvrrjgXVa/O9OJRa52
	 BtE4GQCvj34rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongjun Gwon <d3bugee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: serialize directory emptiness checks with readdir
Date: Mon,  2 Nov 2026 18:03:30 -0500
Message-ID: <20261102230043.2418573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110242-rental-truce-4d21@gregkh>
References: <2026110242-rental-truce-4d21@gregkh>
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
[ sashal: Adapted the directory check to the existing condition without the ksmbd_stream_fd() guard. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 608e542254f92..a6185ca546826 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6546,6 +6546,7 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 				     struct smb2_file_disposition_info *file_info)
 {
 	struct inode *inode;
+	int err;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
@@ -6554,9 +6555,13 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 
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

