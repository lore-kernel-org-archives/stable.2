Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890955;
	b=ZfFCbZc3vJMpQDIt0AqIgq1X3TkFY2aHi3yWI/bZK38lmoz3ogbHxJB76pOwB5NMpi/Y
	 wQvPqGr8rVlUU+dLfA74IUGUkbQ6jbIjDY8k4xm8+EhqoBUHuvPQXer8sd9SplcT+uFC6
	 SpxQlZawDGbFp9vYPM5WDnvRpL2g8HSrGAtcDB8NKUjIGiBJva8xoHMPSb6U6Glk+u3qI
	 ZgdlcePPJQOVhCHFFxDv1i3AjsI7XM+Ak0hbXUOM22XY3t/njx4XUYq9deqBpNYPHu2mm
	 EvkII7FSYOVMSmcyK+RfEvHNOBtPHljmfN1nhRoKd+j6fwjaIVNvthijRGiDyBYBEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U1PjpgVVhezd5uaIzjG23jxybF1YkeYl0e7nh7D1cfY=;
	b=pB7YqiG35gVKXQ+PGAkC+UfPOBa3Pk+FjJ5gMSccQTZGu53RkV6xza0wCIhsDdm1XMiL
	 qu/r3pTUpf0v7TWjw5Sz92weWoMJNmXRZElUr0FXkDV8vKSgj4FYfnvhEfpVq9PEx69Ih
	 bq65cINMhwB8f+KyLAY+agErObhdJN4HzGCjQJp7HSfUVfi2p5LaciNzTyvlpgiZboKaI
	 l1oMN//g7jQllRTUxdMu3g3G9XiEJGMKkNXPFPbQraz4qC78CYfAh3w0OxGdos8FuPamb
	 hCyvZzGHglqlMMVsW9Agzw9wXcJZ02jvXlDcF8JWo7WYUDd0rUdCy7Qa9OuhLT6Hhdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSeZhGVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06737606A33D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSeZhGVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2511F000C1;
	Thu,  5 Nov 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890954;
	bh=U1PjpgVVhezd5uaIzjG23jxybF1YkeYl0e7nh7D1cfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSeZhGVQMWHtKz7sOrhUK4USF3g8tQF5dZ/9nJRbaO92hB+WHrjbvCiq6Jns+ycgd
	 Wtj1LvMiJCj4mOF0Y8caMRE1UTu2jJtLpf7I+Vkdv2KUJGlXMhVDEggIHVeURe41UN
	 2CP8OJBk5Yi0C6IcDj6ROp1ce6QDQvrjYZq4AVZz69znNRRajRrlRsRUa040GbFdiz
	 rFlNr/DbUveIJv3bjyQ39KBfa18/rxL7LMa7243tyOykxy06QzQ2rrg3HHXfdJTQOL
	 6Wj59b2xi+lVx46EtNNmdNo+EvFfnAma5U2WaPLkWJULcTsEP4PeryfudLljxgw8pS
	 VsvjwuWpxqimA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: bound inode fork length against the fork size during log recovery
Date: Thu,  5 Nov 2026 10:02:33 -0500
Message-ID: <20261105150122.1662584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110424-cure-criteria-18e5@gregkh>
References: <2026110424-cure-criteria-18e5@gregkh>
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

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit 9232301894a06e664d8de2da97175cf98419bd16 ]

xlog_recover_inode_commit_pass2() copies an inode log item's data/attr
fork region into the inode buffer using the on-log region length without
bounding it against the fork capacity, e.g.:

	len = item->ri_buf[2].iov_len;
	memcpy(XFS_DFORK_DPTR(dip), src, len);

The only guard is an ASSERT, which is a no-op on production kernels
(CONFIG_XFS_DEBUG off), and xfs_dinode_verify() runs only after the copy.
A crafted image with a dirty log can therefore drive a heap out-of-bounds
write at mount time. The XFS_ILOG_DBROOT sibling already passes
XFS_DFORK_DSIZE as a bound; the DDATA/DEXT and ADATA/AEXT memcpy paths
did not.

Bound each logged fork region against the destination fork size before
copying it, and reject the log item with -EFSCORRUPTED when it does not
fit. Because the recovered inode is only verified after the fork data has
been copied in, the checks are done up front, before any memcpy into the
on-disk inode.

Fixes: 658fa68b6f34 ("xfs: refactor log recovery inode item dispatch for pass2 commit functions")
Cc: stable@vger.kernel.org # v5.8
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Changed two iov_len accesses to i_len to match struct xfs_log_iovec recovery buffers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_inode_item_recover.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index 239dd2e3384ec..2e82ee4b404b5 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -403,6 +403,25 @@ xlog_recover_inode_commit_pass2(
 	ASSERT(!(fields & XFS_ILOG_DFORK) ||
 	       (len == in_f->ilf_dsize));
 
+	/*
+	 * The recovered inode is verified only after the fork data has been
+	 * copied into it, so bound each logged fork region against the size of
+	 * its fork now, before the memcpy below can overrun the on-disk inode.
+	 * The DBROOT/ABROOT cases already bound their copies against the fork
+	 * size.
+	 */
+	if ((fields & (XFS_ILOG_DDATA | XFS_ILOG_DEXT)) &&
+	    item->ri_buf[2].i_len > XFS_DFORK_DSIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+	if ((fields & (XFS_ILOG_ADATA | XFS_ILOG_AEXT)) &&
+	    item->ri_buf[(fields & XFS_ILOG_DFORK) ? 3 : 2].i_len >
+	    XFS_DFORK_ASIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+
 	switch (fields & XFS_ILOG_DFORK) {
 	case XFS_ILOG_DDATA:
 	case XFS_ILOG_DEXT:
@@ -442,7 +461,6 @@ xlog_recover_inode_commit_pass2(
 		case XFS_ILOG_ADATA:
 		case XFS_ILOG_AEXT:
 			dest = XFS_DFORK_APTR(dip);
-			ASSERT(len <= XFS_DFORK_ASIZE(dip, mp));
 			memcpy(dest, src, len);
 			break;
 
-- 
2.53.0

