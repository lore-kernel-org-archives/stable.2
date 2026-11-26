Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795665838;
	b=WcFLNL+UwqiEOq2xSNgiqZafF0AHmNpxBGiDNZICUM/DLap4LfYXn+5Lm9rUMfGK93A1
	 Q4qjGQ+lCcyLAMr/XTphDRw/tYsab7OoOVpFlrdYIc5oDS2EPZEaBfJ+1TPtdnbBppY8z
	 yBZ7KyRoY5AwkVJ5cssV/k8oYz7w9EWF8FXmoI6NRASJx3mOJZxsiz61UuvnCOFi2hecd
	 mtTNbAUMWoqrTASzali4UupNtPJhnz0kGU3ABV7kvdP1z66J5g+2mHNqKItwC9a4Jc3Oa
	 STsPGjO1RZNr+cNWLR4CuhlCgnY3poL9Xgw7pofYs4N30woHc3d1CujvAH3MNDjKtmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795665838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=htuc+DVRNPo8qiMLm1F7zKfOFAlV3+P/0+E/ctgCNUs=;
	b=GKfwkQHNkgXU2i6O3GLha0m4ioMogBklvHzAVXs1hNfX1Oj1VA1GHhnzgZXH2x3HB08m
	 kTKCsWTwAJEj+koGOFF1iIjZpmicmkWlRTnwRgh3cYNLno+NhHx40N/cp9IfaqbLujk0E
	 rmKkuMgMXFbrA0wQff6VMOZp7ZcXZzih5vkHyaYCS9yToPMqe0+6zgwSmsef9hSlmY2I9
	 9JqUpfiVsN8L5rnGJ7qvBmXfX22qE0m5aDaj/MRcFcV5Yl3ze2qP2YxH0sUB+GFZwYB4C
	 wJTv+0hv3XFtnDPEJPvnfW01dOicbAEKPhnFH744eY3pseJWfGQJLfwQxv92OrsLVkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqgUW2y9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0789606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqgUW2y9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00FF1F000C4;
	Thu, 26 Nov 2026 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795665837;
	bh=htuc+DVRNPo8qiMLm1F7zKfOFAlV3+P/0+E/ctgCNUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqgUW2y95IFFCsukVaO/fml8flU3sKBi/x10EmSl+6SPuBC6J/CGqdnMsJuiNlNLN
	 LmQH/wMmz9ir2exH6W9vhQ6ShcmZpjBGtlFtg/s3pV9aQ3Pz+3STZo6YpdAhmWcE0k
	 nb5KhFJv0H8ak7hHmgclY7Cg5vxcioJdvT+UM48mxwwW7JO0YT4gXW2BCIXL4h9D3Y
	 u0IKAnkxO8m9Ejp6Oujdhh08imghO+mXrKurIiUCZckDCLBNR+lvsk3jatSnfVVAHU
	 lyJjBjPM8oqxNgWoU5TpSwVCuDeY6u7MXDx6DTDJ9D4DztJnZIc2iG+dF0tEmhTkyM
	 MS1S4talZwVoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: hold the inode across cifs_oplock_break()
Date: Wed, 25 Nov 2026 23:03:55 -0500
Message-ID: <20261126040330.1880424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-throbbing-bash-4fb0@gregkh>
References: <2026112558-throbbing-bash-4fb0@gregkh>
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

From: Joseph Qi <joseph.qi@linux.alibaba.com>

[ Upstream commit fce78321f1b59531cf6fc94860550db1db8dec55 ]

cifs_oplock_break() drops the handle reference in the middle of the
handler and keeps using cinode afterwards, to send the break
acknowledgment and again in cifs_done_oplock_break().  The reference
cifs_queue_oplock_break() takes is the only pin: the handle holds the
dentry and the dentry is what keeps the inode alive.

When that put is the last reference, the dput() in
cifsFileInfo_put_final() kills an unhashed dentry, drops the last
i_count and evicts the inode, so the rest of the handler runs on an
object whose free is only RCU-deferred.  An unhashed dentry that a
handle still references is an ordinary state: unlinking an open file
leaves the dentry that way, and so does the dcache teardown at unmount.

Take a reference on the inode for the lifetime of the handler and drop
it once the break has been reported.  This also covers the
cifs_get_tlink() failure path, where the put is followed directly by
the out label.

Fixes: b98749cac4a6 ("CIFS: keep FileInfo handle live during oplock break")
Fixes: 23b26f4408ac ("smb: client: avoid leaking refcount when cifs_sb_tlink() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Moved the change from fs/smb/client/file.c to fs/cifs/file.c and placed ihold() before the existing cifs_sb_active() call and iput() before cifs_sb_deactive(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index affb1ade0c15f..85bbda2d56e82 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4883,6 +4883,14 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
+	/*
+	 * Dropping the handle reference below also drops the dentry
+	 * reference that pins this inode, and cinode is still needed to
+	 * acknowledge the break and to report it as complete.  Hold the inode
+	 * until that is done.
+	 */
+	ihold(inode);
+
 	/*
 	 * Hold a reference to the superblock to prevent it and its inodes from
 	 * being freed while we are accessing cinode. Otherwise, _cifsFileInfo_put()
@@ -4964,6 +4972,7 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
+	iput(inode);
 	cifs_sb_deactive(sb);
 }
 
-- 
2.53.0

