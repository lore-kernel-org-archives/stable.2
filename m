Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595528;
	b=ltZVY9AsqOYYnZtU7OWEhcQtrNvauT/70EFz8dzTflSrN/mEFYUEmPSSL4uINjSOvDeB
	 jg9Ilw/u2jb5dr5rFz/la+KDJJ5y+dIAUyLIfxZUz7NWXRCtQv3+9DcUyLkl1Qn3AQk+g
	 NocaeuNpoX/RVTJXaOyRcwiaCTNzheHx1k+X57dxQAPtInx5aMnNwI9OQnCPC+Cc6sf9b
	 gAQyHDGhDANTYfuLVrEj/NLtSoszGJx4bVW8V0SuzgQkkZMN8LAYz0/XXTInEf/ooppY1
	 2pNMcYJYwzwcm2ROFwEiKFBIHLPxx+9G4GFFLhu0SQ1YMjuwcdkF2yGJZSkBrXwQqUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595528;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t4QbqVHrraYqKHmbJaPfxAZVBnKrO+O9tesHuL9vmq4=;
	b=OhBUIK7Ob8pTig4Bn1BuV90dgYQgWISzBWMw+BjopXKk2Xi+7n9creeD2M5n3ky6CDeg
	 C30ilp3pjp952QvVPaUBp//P8kNAv5Dq6GQ7ThRIbgyNlD/m+Yru6T5clJpbf2vYl+Izy
	 o57XQpSd5kR1RAxn5uKYIwlI8NRP8MRunkZAhky7bD0ZIfaC26nVLcL5jUdHxSI21S9AO
	 lu51tSJgh+W2mV9QUeMY3V0t/cJZZU8dJTrUsfMALjUC1iFm9elSKmDfgLuu2SG4SlmY3
	 q5ytdDv2fm4JzuxWM7K37yFuZd/yU4IdlXFQ/cm/O/IJbA9KYU0lfDRqkcYQWWjMhfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KVY9+uEc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E906606A31E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KVY9+uEc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626661F000C1;
	Wed, 21 Oct 2026 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595527;
	bh=t4QbqVHrraYqKHmbJaPfxAZVBnKrO+O9tesHuL9vmq4=;
	h=Subject:To:Cc:From:Date;
	b=KVY9+uEclE7gSINx47i7kW0J51NCgHJVFh8DRrQiDTMumqtHYZlmMkFBCaxa7z2L6
	 6PO60rNaCqG88sF41pTq8GkL+RgrhYRY/7Qf4+7N4yVmIN/wBQT3RRYm9HUv3w/uj+
	 2K7kJCycVN1FnjrjTDLHXUyIIsEPfIYOnQ/lJWfY=
Subject: FAILED: patch "[PATCH] cifs: add revalidation on FSCTL failure in" failed to apply to 6.6-stable tree
To: sorenson@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:06:15 +0200
Message-ID: <2026102115-justify-disrupt-2bd1@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 53676a5e28231186c9f56d87b7998b640699bc15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102115-justify-disrupt-2bd1@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 53676a5e28231186c9f56d87b7998b640699bc15 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Sun, 23 Aug 2026 18:26:46 -0500
Subject: [PATCH] cifs: add revalidation on FSCTL failure in
 smb2_duplicate_extents()

smb2_duplicate_extents() has no handling for
FSCTL_DUPLICATE_EXTENTS_TO_FILE failure: when the FSCTL fails, local
inode metadata may be stale from the pre-extension or from concurrent
remote writes, but is never refreshed.

Force revalidation on FSCTL failure and use i_size_read() for the
pre-extension check.

Fixes: cfc63fc8126a ("smb3: fix cached file size problems in duplicate extents (reflink)")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7d6738ffcb80..bea4876b58cb 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2218,7 +2218,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2235,7 +2235,10 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
-	if (rc == 0) {
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	} else {
 		qrc = SMB2_query_info(xid, tcon, trgtfile->fid.persistent_fid,
 				      trgtfile->fid.volatile_fid, &file_inf);
 		spin_lock(&inode->i_lock);

