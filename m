Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBA3DCD8D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887540; cv=none; b=Rj2KQER0Qkex3l+wdXgSAPiEEdOqxhKCg8D6eAqPTwPYtMSFiyb0wdgCR10gtPmFwxYNJmj2ETUADRpnyDmZ3UoCcUDLDfaR73hv8geOtvathv5IgsF9ui6YlBXB77HjHsTap9P4F8kJS/kfWPqoJHsEGBnEUjeXdnAMuPJHONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887540; c=relaxed/simple;
	bh=dgaWyliRWsI+DQxRPeJtPipOXsA4t5H4YRraHpaECuQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZIO6LN6GPgsktHkejbdkRrtyUrgsckUtCuub4HT2l0LRKOL5vA5YMZJybSBpesu6UGr+knauM4svVcbaCXQOKuqNICqVt4VseKvzC4Sf0ssbN0ZMmH2+i2pUMDuhBeECKL4f9IMT93T/sT83AotEjWCD3rwCbifOD70rrGnTQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fnQA9+w3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fnQA9+w3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573F31F0089A;
	Tue, 13 Oct 2026 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791887538;
	bh=I4DYzhqchztgt7h2c591DyPQ24pqH13JkA10a2Woxm8=;
	h=Subject:To:Cc:From:Date;
	b=fnQA9+w3taVdt5IYI22jT/m/EBOSKqhGTkVT+vAQbgcSyKvRITwpxnV04VhQAnkgz
	 oQUaj3aKcckOYhBmoKW6+4hMcaKY2Fxn38OSqqgM8dJb7e2qC+SeVqoiygpmUHSrhY
	 TaCV3Qgd8BMKToV+eJiL6QDeGYdY6HP6i56tjhHc=
Subject: FAILED: patch "[PATCH] cifs: fix time_last_write stamp placement in setattr/truncate" failed to apply to 6.18-stable tree
To: sorenson@redhat.com,pc@manguebit.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Oct 2026 12:32:23 +0200
Message-ID: <2026101323-delta-nappy-a3a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x ecababf08905958ba8c125979c4e39fc2f1a8a05
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101323-delta-nappy-a3a1@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ecababf08905958ba8c125979c4e39fc2f1a8a05 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Fri, 24 Jul 2026 11:30:36 -0500
Subject: [PATCH] cifs: fix time_last_write stamp placement in setattr/truncate
 paths

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

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index b2806371bfde..808085eb0cdc 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -3190,6 +3190,17 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
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
@@ -3279,8 +3290,6 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 
 	if ((attrs->ia_valid & ATTR_SIZE) &&
 	    attrs->ia_size != i_size_read(inode)) {
-		/* Pairs with smp_load_acquire() in is_size_safe_to_change(). */
-		smp_store_release(&cifsInode->time_last_write, jiffies);
 		truncate_setsize(inode, attrs->ia_size);
 		netfs_resize_file(&cifsInode->netfs, attrs->ia_size, true);
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
@@ -3370,6 +3379,17 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
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
@@ -3482,8 +3502,6 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 
 	if ((attrs->ia_valid & ATTR_SIZE) &&
 	    attrs->ia_size != i_size_read(inode)) {
-		/* Pairs with smp_load_acquire() in is_size_safe_to_change(). */
-		smp_store_release(&cifsInode->time_last_write, jiffies);
 		truncate_setsize(inode, attrs->ia_size);
 		netfs_resize_file(&cifsInode->netfs, attrs->ia_size, true);
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);

