Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFB72602
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350799; cv=none; b=Fu0yOvIrCHyxrcz/qTvNh0WUbb9rllRRlAGQbTCXoRmTxG+3jluApjcDPLilcrXQGos5k6ke7fc/MnA8oBs1if4AwOoPM36HM1HyfFt6TClSTvIPak7QXBlteaCBl6okITvWmh/tSJT2TOjioqNbd9XZAZYJzTmDhZm3gJzQoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350799; c=relaxed/simple;
	bh=Jb5UDsBJcMDy5Pr8T5RI5dN7TiwGBG76HJ74oudtg7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9enbjCMmawuMlMLV1vU6SXg8kfKICLh3XQ/x1r41HmhQqWpsKWI3/B0sNF0bOnTmu9L4fiiTvWUx63OFJ7SO4+lv0/Jq4/2Wj4QkzhJP516NWNJSSVlstglcDWgG1o3Ss96TYXnz4KdBQmzjm4DPSDMSO3IugkhIZ4BiL4ktnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXdawBiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXdawBiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278841F0089B;
	Wed,  7 Oct 2026 05:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791350797;
	bh=pqm0qsnrdvbRSf+HXBt/1WDyLAFSa+ZnBXyteoaulq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXdawBiL2OoqW2lG7baLvUzbxgRKZd7ocKaURaQHHjEKKLMmXQ8s7CljWURFOHyNL
	 SYe1OctmnHZSNiHUUvoGkVKwTrJluO7u80PYf3yQRFPJO2BXtPmHxt2aIkjyY4I+Pl
	 H5zDJ6/MC+TXbVK4NUIqpIrqsin9azDjTXVDOaPwjJmEeI4yrfcLWvcV05Tvif8IAy
	 R+qIkk8rkohTPTZ0+2rB5q8zecGLEdcP4T5U7GuXVNCeUGupYm6e49zKlPrf5Fffa2
	 CWl9jWZQB8BuAHcukjPeeHuvcCiYwIp/JP7CmUJtTEvpE30bw0B6nXeCAPpNilfE3W
	 xQfDz/QDVt5Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: flush dirty data before zeroing a range
Date: Wed,  7 Oct 2026 01:26:32 -0400
Message-ID: <20261007052616.1250540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100511-numbness-stinky-677d@gregkh>
References: <2026100511-numbness-stinky-677d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 8f8d32c1044f70e46e87550e039a15ff20a4b21c ]

smb3_zero_range() emulates FALLOC_FL_ZERO_RANGE by invalidating the
page cache over the target range with truncate_pagecache_range() and
then issuing FSCTL_SET_ZERO_DATA to the server.

Dirty data was only flushed conditionally, when the range reached or
extended EOF.  For a purely interior zero range that does not reach
EOF, no flush happened, so a dirty folio overlapping the range could
be written back to the server after the FSCTL and refill the range
that was just zeroed with stale data.

Fix this by unconditionally flushing and waiting for dirty data in the
range before invalidating the page cache and issuing
FSCTL_SET_ZERO_DATA, exactly as was done for smb3_punch_hole() in
commit d7d2adcd022b ("smb/client: flush dirty data before punching a
hole"); the two paths are structurally identical here.

This is observed as generic/363 randomly reading stale data where a
zeroed range is expected against Windows Server.

Fixes: 91d1dfae4649 ("cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target region")
Reviewed-by: David Howells <dhowells@redhat.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org
[ sashal: Retained i_size_read() instead of netfs_read_sizes(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2ops.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 91e1e7b52bfc7..83fb7e7fa67e0 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3485,8 +3485,7 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
-	struct netfs_inode *ictx = netfs_inode(inode);
-	unsigned long long i_size, new_size, remote_size;
+	unsigned long long i_size, new_size;
 	long rc;
 	unsigned int xid;
 
@@ -3505,14 +3504,11 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	i_size = i_size_read(inode);
-	remote_size = ictx->remote_i_size;
-	if (offset + len >= remote_size && offset < i_size) {
-		unsigned long long top = umin(offset + len, i_size);
 
-		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
-		if (rc < 0)
-			goto zero_range_exit;
-	}
+	rc = filemap_write_and_wait_range(inode->i_mapping, offset,
+					  offset + len - 1);
+	if (rc < 0)
+		goto zero_range_exit;
 
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
-- 
2.53.0

