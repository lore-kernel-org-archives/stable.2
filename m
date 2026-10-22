Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676592;
	b=TSanpcCOdU7gZMiiWqbfQPsEafHSqaKtJDMD5ggWan9OVLi/mtMx0Gt0TH1vih0JmIIf
	 viQ0dc/xeNpTPFP2HIatikiHEeI0GTNKc1SGPKty5QO20/gXDLLfw+EAtuHcnyhqSzNK+
	 C0QztPYC7P2ew9z9RLPXq4RKH13XICQC11Uj+PB70St7hEAksAhmouxbHRjJLEn+Ms1Yp
	 hNrDq67wnpWHboTztljlPBk7alsNauZadNRdI5UMnwNe6vOm/9F2f9AnK1m2jLvy0+BEc
	 WCuEjAuGmPAugCI+qi+hRI62rUIF2RDzW4OX6ogDH7gvlh0DzgJtVLqxawilA0JYQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C8xpfq44favFFop7efhqkoARNu05KpQUfyAQMgRInOc=;
	b=sizc37rB6L3CakdRCSR4JbsLZ9crOxgyV/n+5PVMXOdiSulN5Tf8dZOsxgWRvP/Jiaki
	 p60Nf7opSZ8a+B2O/tqx6lkEaRqY1xR+CaCt8RgiKY4SUunelJAr94r17g8eQhGqPg4m2
	 WH68JxoSMDk4H8cfSkjPrC/ZjxCu6c04TThKwTjjIiIQBCaxaS2LfQArdqvEHqZD1q6fj
	 6f4BZkmMtYrVa8TWWJmpVlf6AGTpdgEZ59pIz6O8gcYGelzcI0V5sIB5gev14iLHc7TWc
	 alE7Sup5ZUl0F4AbYUoFNGaaYCFvz2GPa3f0fZYN12yxmB0eMtwdfNLmdhcBZFFONnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsHlTy+N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893B60A2631
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsHlTy+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C550A1F000C1;
	Thu, 22 Oct 2026 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676591;
	bh=C8xpfq44favFFop7efhqkoARNu05KpQUfyAQMgRInOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsHlTy+NfdkRvb275oRMYWwh7nUuevlhDAVavukW3KpG4FlarRxqdIr/CcHO1rS3a
	 zlPSEq9mUkbp0FZx+xarBFVsssD20NRF2QxzsTOyhWi8sAZwX874FrrDI3Q5w+KKLd
	 R37hk9qTpsFNc3cTDnRCvHQxyHS8gVhDJagVi3hOYAEcnkk65b4JtkW11Fik4W4rHV
	 ESLpu4jnOXpY4FmmkdT8Z/plRaa4hGZW3fM7WtrV+lhdO6cGTFAUPT7T5RIHnYcby7
	 5bdBcqpJoFnD+iJFRaRQc7UmRYXDKjB/T0Z6gPrFJbeplqlua8E0zKLh9BHT+7u5Dp
	 Pdh4o4DXRklOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huiwen He <hehuiwen@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] smb/client: refresh allocation size after duplicate extents
Date: Thu, 22 Oct 2026 09:43:08 -0400
Message-ID: <20261022134231.1459788-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102114-sincere-numerate-a8df@gregkh>
References: <2026102114-sincere-numerate-a8df@gregkh>
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

From: Huiwen He <hehuiwen@kylinos.cn>

[ Upstream commit 5906d0e82e8e07d756f3ed1abfac8f8cea2c20dc ]

FSCTL_DUPLICATE_EXTENTS_TO_FILE changes the target file extents on the
server, but the client does not refresh the target AllocationSize/i_blocks.
Callers can observe or use the wrong st_blocks value immediately after the
clone, before a later attribute revalidation corrects it.

For example, create a reflinked file with a leading hole:

        xfs_io -f -c "pwrite -S 0x61 0 64k" src
        touch dst
        chmod 600 dst
        xfs_io -c "reflink src 0 1m 64k" dst
        mkswap dst
        swapon dst

The file still has a hole after mkswap:

        /mnt/scratch/dst:
          [0..7]:       allocated
          [8..2047]:    hole
          [2048..2175]: allocated

The server also reports only the allocated ranges:

        server dst size=1114112 blocks=144

but the client reported EOF-derived blocks:

        client dst size=1114112 blocks=2176

and swapon succeeded:

        swapon_result=success
        /mnt/scratch/dst 1.1M 0B -1

So EOF-derived i_blocks can let a sparse reflinked file pass the CIFS
swapfile hole check.

Fix this by querying FILE_ALL_INFORMATION on the target handle after a
successful duplicate extents request. Update i_blocks from AllocationSize
and keep the refreshed target inode attributes valid so a following stat
does not immediately revalidate again.

If the query fails, mark the cached inode attributes stale so a later
getattr can refresh them.

This also fixes the xfstests generic/370 regression introduced by the
i_blocks accounting change, as tested on a Samba "vfs objects = btrfs"
share.

Fixes: 99cd0a6eeb6c ("smb/client: do not account EOF extension as allocation")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 53676a5e2823 ("cifs: add revalidation on FSCTL failure in smb2_duplicate_extents()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c  | 10 +++++++---
 fs/smb/client/smb2ops.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index f63519a0b1d8e..0429e90dcfd6d 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1463,9 +1463,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 			target_cifsi->netfs.zero_point = new_size;
 	}
 
-	/* force revalidate of size and timestamps of target file now
-	   that target is updated on the server */
-	CIFS_I(target_inode)->time = 0;
+	/*
+	 * On success, duplicate_extents already updated the target inode attrs
+	 * or marked them stale if the refresh failed.  On failure, mark attrs
+	 * stale because EOF may have changed before the clone failed.
+	 */
+	if (rc)
+		CIFS_I(target_inode)->time = 0;
 unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2026e627bc441..c962f22f3655a 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2271,10 +2271,14 @@ smb2_duplicate_extents(const unsigned int xid,
 			u64 len, u64 dest_off)
 {
 	int rc;
+	int qrc;
 	unsigned int ret_data_len;
 	struct inode *inode;
+	struct smb2_file_all_info file_inf;
 	struct duplicate_extents_to_file dup_ext_buf;
+	struct timespec64 ts;
 	struct cifs_tcon *tcon = tlink_tcon(trgtfile->tlink);
+	u64 asize;
 
 	/* server fileays advertise duplicate extent support with this flag */
 	if ((le32_to_cpu(tcon->fsAttrInfo.Attributes) &
@@ -2309,6 +2313,32 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc == 0) {
+		qrc = SMB2_query_info(xid, tcon, trgtfile->fid.persistent_fid,
+				      trgtfile->fid.volatile_fid, &file_inf);
+		spin_lock(&inode->i_lock);
+		if (qrc == 0) {
+			asize = le64_to_cpu(file_inf.AllocationSize);
+			CIFS_I(inode)->time = jiffies;
+			if (file_inf.LastWriteTime) {
+				ts = cifs_NTtimeToUnix(file_inf.LastWriteTime);
+				inode_set_mtime_to_ts(inode, ts);
+			}
+			if (file_inf.ChangeTime) {
+				ts = cifs_NTtimeToUnix(file_inf.ChangeTime);
+				inode_set_ctime_to_ts(inode, ts);
+			}
+			if (file_inf.LastAccessTime) {
+				ts = cifs_NTtimeToUnix(file_inf.LastAccessTime);
+				inode_set_atime_to_ts(inode, ts);
+			}
+			inode->i_blocks = CIFS_INO_BLOCKS(asize);
+		} else {
+			CIFS_I(inode)->time = 0; /* force reval */
+		}
+		spin_unlock(&inode->i_lock);
+	}
+
 duplicate_extents_out:
 	if (rc)
 		trace_smb3_clone_err(xid, srcfile->fid.volatile_fid,
-- 
2.53.0

