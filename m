Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595516;
	b=lU7ou1XqO/mAaIV5WV0cOuuzy7YR926Wy4AKc0s0ZD4aX5cVs8l5gyN/TmrzexvbQE7D
	 yaEjuDMfYmzPbz6cAO7qhpmsrb7iA6Van97v5b+bhxvSFHXFEYvaDqd+Ic1Mx+Wa2UmUh
	 bu3Xh24g1eVpQpgLxCjHBcBx2XiDB4GRp8rpgMMxQN005lEH733mhyau8T2toqwj/KRlj
	 chdm1/gKI1FiVl5kWxBi7HG0x8+sjItE1b2DbaFWn3PdJCqBg5d5DEHuyUHHSyW/as6Ew
	 qT/zP9lkGDKMwjln+O86SGvs+hkif27IZrDFwqsLYjxTiAFXi7tkJ2bEBF96owinZig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595516;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eP0obCsKH5UdLV1jt9UkUYpRY29uEZjDPBVycF6QJ7M=;
	b=1HP+sTOHScnmHiEuo/kS1T9ZBcLnz80QECjHZ0U9kZQcgntz516b+Nf7LsbJTbWMXzUJ
	 4uT6xpDQNwBc9FCvrVM7mguTx9nhCXQWdnSnhTHjdzbiDqPnsx6pRliKhOC2ljPctogn6
	 ZOfoG+8N/rxndFfXQ9dJPJcLQTkbEt/5TYMliSa7no30PgKXmPzJ9Bvg+PlSBHbLkKzrj
	 kZ+jHrkjwE5nfWhRG19rAh3gFxpeqHyIaakAguO5uZl6KD8Vq3SB2xWBZ/K/oOEZK6QmX
	 EnPTzYqEFb+XafmUtkjuILxx5v3YRjQAgNTsNClBYDJgXVRdU2ESLp/piFzqaCr2qNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="Y4/Ny1Bi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654E606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y4/Ny1Bi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7161F000C1;
	Wed, 21 Oct 2026 15:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595516;
	bh=eP0obCsKH5UdLV1jt9UkUYpRY29uEZjDPBVycF6QJ7M=;
	h=Subject:To:Cc:From:Date;
	b=Y4/Ny1BicNPmiTxPbdDLI0zyIsogSogKCC3aXmuZCi7znm95bsYqAUeX9KJJOkMeE
	 gksAts+OVFo0upMtGTVflN8sJ9hpNOqfleVu0J2/NsYUv7VKrhNwNCSnz8wNhaJKow
	 d/m1JTR1LWJ1Cnb6vHbWyMCGkOpxRp2H6Ewsalm8=
Subject: FAILED: patch "[PATCH] cifs: add revalidation on FSCTL failure in" failed to apply to 6.12-stable tree
To: sorenson@redhat.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:06:14 +0200
Message-ID: <2026102114-skimming-various-491e@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 53676a5e28231186c9f56d87b7998b640699bc15
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102114-skimming-various-491e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

