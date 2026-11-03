Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685573;
	b=1fwt9zK1x7BEoUzwuRcjNQB1evznL9hs5wuMiYlnMwgolcJYPW2lVSI3kn/zmFHw5xzW
	 e6aDCTVRMwtEB4cIj7adCA8l0GIXjxl7moWSrntGhnbBUb4InbZBT8PsjSKzowA8tMDtx
	 OEKTTL+1fMLqJNzKkyXhJ56Cexxho81s1C6edF937o6ZJe8bUyFAUiNg6OckJ5pveHp9W
	 9jXgzdRtGjzV/dNspRPaQ0M355gDMg0WgCQDE0SOUuSexnRp8btH14fJbcr8Zy4bBVxCi
	 yIPM8w6ngHo7KHQ1LeOXTPk3NtPPsimiOPLsOO31fwrRhVxK+cDAjUn2nS/WszSs9UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685573;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F2+4Yzh+dcpVAnl+hKWRshMrg70cWm8d6zxfSczxXVA=;
	b=iCw8t5dOSxCieo55DbVUFeEv3RRbPrs7Rr7HzkzBPu79Mm24xZxLCGe0F6CYN1qy88YX
	 bHf8nbL4cbyRJdlalqhreeKI4TFV6TjYnkSfBhUanKfaHcZ0PktESItaOAh0j3Vmcks1K
	 2O+i8iFayVoAosxDe2F03inWUYFEtqbB4bpQ1fl81F7PXm1SYPkmSXzLRKeHv+2pzo5by
	 +vC0IyghwYadanDfFYjrJl15nt+xUCQRa6FAF22Zfv3wfxSpGDZ7kC7htSG97sSzRsvAs
	 aQVpZTYWXiD0ygrANAofzP3u5KB2HaOM5dYITRxJU0FMbZiqr0YDY0ieZCb9sMK5FmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZmjbhOi;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602B606A32C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 05:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7602B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZmjbhOi
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793685564; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=F2+4Yzh+dcpVAnl+hKWRshMrg70cWm8d6zxfSczxXVA=;
	b=WZmjbhOinEbx8r5AgQYh29k4fjLNkVKk1cqbbRajMhDkLqu56YAWr5BWm0p3nQ5mHhD4Knted/RNrl0StJKhakBn0eRy1yllCuQ2R709wjhCaHnBvj08sTnKR1laykcVe0Ky66GLeSVDUxeWGhTGwat29gazaNadSMpWl8Zp7sc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0XE1iRn7_1793685563;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XE1iRn7_1793685563 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 13:59:23 +0800
From: Joseph Qi <joseph.qi@linux.alibaba.com>
To: Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] smb: client: base punch-hole EOF decision on server_eof
Date: Tue,  3 Nov 2026 13:59:23 +0800
Message-Id: <20261103055923.2003159-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

smb3_punch_hole() decides whether to move the server EOF marker by
comparing against netfs_inode(inode)->remote_i_size.  Nothing on this
base keeps that field up to date: netfs_inode_init() has no caller under
fs/smb/, so remote_i_size is never even initialized, and the only writes
to it are netfs_resize_file() from the clone and copy_file_range paths
and this function itself.  The writeback path tracks the server size in
cifsi->server_eof through cifs_update_eof() instead, and
cifs_fattr_to_inode() refreshes only server_eof as well.

Reading remote_i_size therefore compares the punch against whatever the
slab object last held.  With it at zero, punching the first 4k of a clean
8k file passes "end > remote_i_size && i_size > remote_i_size", issues
SMB2_set_eof(4096) and truncates the server file in half, with nothing
dirty left to write the tail back.

The flush added by commit 216e46958605 ("smb/client: flush dirty data
before punching a hole") makes a second variant reachable.  It writes
out and cleans any page straddling the end of the punched range,
including the valid data in it beyond the hole, and advances server_eof
but not remote_i_size.  When the punch end lies beyond that stale value,
SMB2_set_eof() shrinks the server to the end of the hole and discards
what the flush just wrote out.  The page is clean, so a later fsync or
close will not write it again and the data is silently lost.

Base the decision on CIFS_I(inode)->server_eof and keep both size fields
in sync when the marker moves, so the server is never shrunk below data
that has already been written out.  Take inode->i_lock for the read and
the update, as server_eof is documented to require, and only ever
advance it, matching cifs_update_eof(): background writeback of folios
outside the punched range is excluded by neither i_rwsem nor the
invalidate lock, and can publish a larger EOF while SMB2_set_eof() is in
flight.

Mainline does not need this change.  cifs_alloc_inode() zeroes
_remote_i_size there, cifs_fattr_to_inode() refreshes it, and the
writeback path advances it through netfs_resize_file(), so the value
cannot be stale after the flush.

Fixes: 288d398df80c ("cifs: Fix FALLOC_FL_PUNCH_HOLE support")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/smb/client/smb2ops.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 21a2b265ae7c4..2826a60f0d8ab 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3346,7 +3346,7 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 	struct file_zero_data_information fsctl_buf;
-	unsigned long long end = offset + len, i_size, remote_i_size;
+	unsigned long long end = offset + len, i_size, server_eof;
 	long rc;
 	unsigned int xid;
 	__u8 set_sparse = 1;
@@ -3392,20 +3392,41 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	if (rc)
 		goto unlock;
 
-	/* If there's dirty data in the buffer that would extend the EOF if it
-	 * were written, then we need to move the EOF marker over to the lower
-	 * of the high end of the hole and the proposed EOF.  The problem is
-	 * that we locally hole-punch the tail of the dirty data, the proposed
-	 * EOF update will end up in the wrong place.
+	/*
+	 * If the tail of the file beyond the hole has not been written out
+	 * yet, the server EOF marker is still below both the end of the hole
+	 * and i_size.  Move it up to the lower of the two: when that is
+	 * i_size the file is already at its final size, otherwise the
+	 * remaining dirty tail is written later and extends it the rest of
+	 * the way.
+	 *
+	 * Decide on server_eof rather than the netfs remote_i_size, which
+	 * nothing here keeps up to date: the flush above advances only
+	 * server_eof, through cifs_update_eof(), so comparing against
+	 * remote_i_size would shrink the server below data that was just
+	 * written out.
 	 */
+	spin_lock(&inode->i_lock);
 	i_size = i_size_read(inode);
-	remote_i_size = netfs_inode(inode)->remote_i_size;
-	if (end > remote_i_size && i_size > remote_i_size) {
+	server_eof = CIFS_I(inode)->server_eof;
+	spin_unlock(&inode->i_lock);
+
+	if (end > server_eof && i_size > server_eof) {
 		unsigned long long extend_to = umin(end, i_size);
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, extend_to);
-		if (rc >= 0)
+		if (rc >= 0) {
+			/*
+			 * Writeback of folios outside the punched range may have
+			 * published a larger EOF while the request was in flight,
+			 * so only ever advance, as cifs_update_eof() does.
+			 */
+			spin_lock(&inode->i_lock);
+			if (extend_to > CIFS_I(inode)->server_eof)
+				CIFS_I(inode)->server_eof = extend_to;
 			netfs_inode(inode)->remote_i_size = extend_to;
+			spin_unlock(&inode->i_lock);
+		}
 	}
 
 unlock:
-- 
2.39.3

