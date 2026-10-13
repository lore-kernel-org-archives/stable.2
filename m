Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC553C3CA
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918776; cv=none; b=GQO/ppM+IAa+A5UBfSMipgfQSIfynpeHlsCedCQwhcCn8edk/G1WPHy31wXHIiSEP6My9JpkdPBphQIJcZcugglcC9XP0SfAb8dqp30UO84H8sr9J8o/oENyLXcL2nnciJwY/65f4oSQ8YVny/EJLBFpirx1YoRLlqMHjqLmZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918776; c=relaxed/simple;
	bh=6n8156s2VK36YFVBvBtRuzqft3+6cuSHxeirZYKhFrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX2WcKctkTh7xYCoAuP0Ap9PBfkWAocJZ6Xv4aBtgzvhczloTNOXXermNIRRZNOTrKvQvelG8zvH8O07WhB0F5vOuNB0k4VVMXf0tE6fYlMT44Wv4/MpLrN2z/ebvGvx3rsXilCymOoDpmLtdGkCu4g5xZ5P1FULEV8OWDVJHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X054wpZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X054wpZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB54F1F000FF;
	Tue, 13 Oct 2026 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791918775;
	bh=DTnS4lY6qeA8v5SB/spuVahN1rlvAF4q5PiNkbJv6eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X054wpZmj686YkjWFPxD5OTP/2HOvBhiUVs/+Y2H4PObLu85bUKTW43dcXymJFo1p
	 xtczogA62E/DfnaXdxUh3iZr48PyvIazE69ec5/K3k9mkFYbAzyTcElOlJ7XLiAsLO
	 IsJNrlLdbmAvqxnXXv1gn2lGTJJuVLhQ8z4ivXDxM10a91N9HX6YgVNPWHBU+QszPQ
	 rlDk78xNTR22eftNP3WsJG0p/mqnElum/+XPZIfiiMiPNJXELkdjKPQq6mMFw/9Udh
	 8aBLj3sncBMUR/1teDrIsHMk1JlqI4Ij3+sXsz++3L3V8EvKeBTOxTPfeHiVB3Ji0A
	 VERWl7RNHKHYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] cifs: fix time_last_write stamp placement in setattr/truncate paths
Date: Tue, 13 Oct 2026 15:12:53 -0400
Message-ID: <20261013191215.834912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101323-delta-nappy-a3a1@gregkh>
References: <2026101323-delta-nappy-a3a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit ecababf08905958ba8c125979c4e39fc2f1a8a05 ]

cifs_file_set_size() calls cifs_setsize() on success, which calls
i_size_write(), updating i_size to the new value.  The subsequent
check attrs->ia_size != i_size_read() in both cifs_setattr_unix()
and cifs_setattr_nounix() therefore always evaluates false after a
successful cifs_file_set_size(), making the smp_store_release() of
time_last_write dead code.  The truncate path was unprotected against
stale readdir size updates.

Move the stamp to before the cifs_file_set_size() RPC call, guarded
by attrs->ia_size != i_size_read() to exclude no-op same-size
ftruncate(2) calls from stamping time_last_write unnecessarily.

On the error path the stamp remains rather than being restored:
restoring a stale snapshot (prev_tlw) could silently erase a
concurrent _cifsFileInfo_put() close stamp if that close arrived
between the READ_ONCE and the smp_store_release.  readdir is
suppressed until the stamp expires, which extends beyond one acregmax
if the caller retries failed truncations.  stat() is unaffected: the
cifs_revalidate_dentry_attr() path calls cifs_fattr_to_inode() with
from_readdir=false, which bypasses the time_last_write check in
is_size_safe_to_change() entirely and always writes the authoritative
QUERY_INFO result to i_size.

Remove the now-unreachable stamp from the dead block in both functions.

Fixes: e8a8d54c2d50 ("cifs: prevent readdir from changing file size due to stale directory metadata")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ sashal: removed the timestamp write from cifs_file_set_size() because the original size-update blocks were already deleted ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/inode.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index ec6d27ba4083d..995d6df9304f4 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3135,11 +3135,8 @@ int cifs_file_set_size(const unsigned int xid, struct dentry *dentry,
 	cifs_put_tlink(tlink);
 
 set_size_out:
-	if (rc == 0) {
-		/* Pairs with smp_load_acquire() in is_size_safe_to_change(). */
-		smp_store_release(&cifsInode->time_last_write, jiffies);
+	if (rc == 0)
 		cifs_resize_file_locked(inode, size);
-	}
 
 	return rc;
 }
@@ -3202,6 +3199,17 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_SIZE) {
+		if (attrs->ia_size != i_size_read(inode)) {
+			/* Stamp before RPC. On failure the stamp remains: restoring a
+			 * stale snapshot could silently erase a concurrent
+			 * _cifsFileInfo_put() close stamp.  readdir is suppressed
+			 * until the stamp expires; stat() bypasses this via the
+			 * from_readdir=false path in is_size_safe_to_change() and
+			 * always returns an authoritative QUERY_INFO result.
+			 * Pairs with smp_load_acquire() in is_size_safe_to_change().
+			 */
+			smp_store_release(&cifsInode->time_last_write, jiffies);
+		}
 		rc = cifs_file_set_size(xid, direntry, full_path,
 					open_file, attrs->ia_size);
 		if (rc != 0)
@@ -3378,6 +3386,17 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	}
 
 	if (attrs->ia_valid & ATTR_SIZE) {
+		if (attrs->ia_size != i_size_read(inode)) {
+			/* Stamp before RPC. On failure the stamp remains: restoring a
+			 * stale snapshot could silently erase a concurrent
+			 * _cifsFileInfo_put() close stamp.  readdir is suppressed
+			 * until the stamp expires; stat() bypasses this via the
+			 * from_readdir=false path in is_size_safe_to_change() and
+			 * always returns an authoritative QUERY_INFO result.
+			 * Pairs with smp_load_acquire() in is_size_safe_to_change().
+			 */
+			smp_store_release(&cifsInode->time_last_write, jiffies);
+		}
 		rc = cifs_file_set_size(xid, direntry, full_path,
 					cfile, attrs->ia_size);
 		if (rc != 0)
-- 
2.53.0

