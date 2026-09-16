Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C54C33E5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577387; cv=none; b=d8OdzUVT69wgAIIEK2DZuX29LxERvHH6iChER3jK/tE+NkE4FX/qRwYbDvDWG1joPaIEaL+hqlIBc8LsyEgKQWPvkQqx6M4eToZuQHF7DuorDFOxzv0JHBMh2Qvp51Knz3zTi3Abt1CJIE6C322zi+pacaSiugSPc4C2EkMlrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577387; c=relaxed/simple;
	bh=AswO8Z/xUY72kmzXsVTLhynNOPPcNUkzcDXuxMzLjtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eoq3dJdSJwL/Sdfud9bycJyzKfaPrYg0sLubSBNGO37bKfvsD3auwhBwctmVEBEBAlVfQKJiHiQyAza2Re7XVUNUqGaWDjvhml+nW/1oy2I5uRdn7tgQgfGb2/QuEoKXdXjjuBh9AvkaHVxm8isJeZ36UV+TfJPDsvxTLBxrPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCgHy6Hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCgHy6Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE231F00898;
	Wed, 16 Sep 2026 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789577375;
	bh=W2bVoo9t1zdWh0hOe6fyPG6TqgzMJBgeZY+PgJqzW00=;
	h=Subject:To:Cc:From:Date;
	b=bCgHy6HmVCd6LG6z+I1erMTfHUxS5RzujEKSau8N+6S4mlh2mNNOeBIBKEWyS+50b
	 upDg+49QppD1517IVK9Ia66fYNHS+wKPn/2dHLYNoxooS2A+zfM1Na7L98GWKL7At5
	 pGEmgCglhDmVJBAQuTM4XnT1WxwZkFZrlzRw2Vgc=
Subject: FAILED: patch "[PATCH] smb: client: avoid leaking refcount when cifs_sb_tlink()" failed to apply to 5.15-stable tree
To: doebel@amazon.de,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 17:44:29 +0100
Message-ID: <2026091628-uniquely-reborn-a640@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 23b26f4408ac3f35a482d2e5cf6fc865d4201b71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091628-uniquely-reborn-a640@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23b26f4408ac3f35a482d2e5cf6fc865d4201b71 Mon Sep 17 00:00:00 2001
From: Bjoern Doebel <doebel@amazon.de>
Date: Fri, 4 Sep 2026 10:42:36 +0000
Subject: [PATCH] smb: client: avoid leaking refcount when cifs_sb_tlink()
 fails

cifs_oplock_break() takes over the reference that
cifs_queue_oplock_break() acquired when it queued the work, and drops it
with _cifsFileInfo_put() once the break has been processed.

Only in setups with "-o multiuser", cifs_sb_tlink() may fail, at which
point cifs_oplock_break() returns without putting the file reference,
mirroring the reference leak we already fixed in the companion patch to
cifs_queue_oplock_break().

This would trigger a crash due to busy inodes on the next unmount:

  BUG: Dentry ... still in use (1) [unmount of cifs cifs]
  VFS: Busy inodes after unmount of cifs (cifs)

Drop the reference on that path as well. Doing so before the out label
mirrors the normal path, which also puts the reference before
cifs_done_oplock_break().

Found by Sashiko code review. The failure path was not exercised at
runtime.

Fixes: e8f5f849ffce2 ("cifs: fix potential oops in cifs_oplock_break")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index d7b0a9512dfa..27b58d907203 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3348,8 +3348,11 @@ void cifs_oplock_break(struct work_struct *work)
 			TASK_UNINTERRUPTIBLE);
 
 	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink))
+	if (IS_ERR(tlink)) {
+		/* drop the reference taken when the break was queued */
+		_cifsFileInfo_put(cfile, false /* do not wait for ourself */, false);
 		goto out;
+	}
 	tcon = tlink_tcon(tlink);
 	server = tcon->ses->server;
 

