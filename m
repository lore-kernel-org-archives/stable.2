Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035D4BA1D9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213305; cv=none; b=f+cJGmVqWk8a9oP597MbNoyQy6qjbTikiQ22g1uInbwXtq4tjcYxlWbBvgdrEqdBm6OvQnHurfyFMA+IsyX828v0hKy+0PvBJeRuxZq5p1fCdu8wqnfk/PkV3QmLZdGJ9t11GdCLHygK/VJqVKgd9IBHRCgocXJLHtLb7sdRRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213305; c=relaxed/simple;
	bh=Z/+WNdD3hTJj39k351mpDv0goTZyEqDIfZD8B2cpMiE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zn3r8ob1F6jXCd5aU2pZuxMVf10voOLW7Iu1odlNlaD46bbq6cb2vdFXa6ayAbXysrkDFBqBhAqbscLrX7UGg7rmHmemMTmEDf6CkoSDG0llsEWZtIrYiwhV9RbY33OwCalh2w/8lKtIGhpZZaQ+DMTkVyCGafS6dYwOabmAdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JYQoPFu7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JYQoPFu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE51F000FF;
	Mon,  5 Oct 2026 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791213304;
	bh=pf4df3NTucPKjoEeutxA/+zcO9C3YBUjdi8ixEiNQcI=;
	h=Subject:To:Cc:From:Date;
	b=JYQoPFu7w7Ng/Fafk+ee7ynXij3r6DjmsDr+Y4HnEdYLs1XOAkFONgeuGhGgGXc90
	 Iv+MhSa4D8vvYkWqmC9m4W/td2AkFEqdajo6uru1bUB/pcEaV/O145TFvexRxKJTZn
	 CJw9v3dDxw5v1e+TOKZxjikmi7BPsBXjJJG4pHIA=
Subject: FAILED: patch "[PATCH] smb: client: discard post-EOF pagecache when extending a file" failed to apply to 6.1-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,brauner@kernel.org,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 17:09:53 +0200
Message-ID: <2026100553-unlocked-trodden-96fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4721587f96cb8de8164f3fd203093a0875560999
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100553-unlocked-trodden-96fe@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4721587f96cb8de8164f3fd203093a0875560999 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Sun, 20 Sep 2026 16:38:03 -0300
Subject: [PATCH] smb: client: discard post-EOF pagecache when extending a file
 via clone range

cifs_remap_file_range() discarded the pagecache only for the folios
overlapping the destination region, so when a clone extends the file the
folio straddling the old EOF - which may hold data dirtied past EOF
through an mmap - was never dropped and became visible as file content
once the file was extended.

Start the discard at the smaller of fstart and the old EOF.  i_size is
still old here, so nothing past the old EOF is flushed to the server.

Fixes: c54fc3a4f375 ("cifs: Fix flushing, invalidation and file size with FICLONE")
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

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index f1fb4b7b7b7c..6410249f529a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1467,9 +1467,14 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	i_size = target_inode->i_size;
 	spin_unlock(&target_inode->i_lock);
 
-	/* Discard all the folios that overlap the destination region. */
+	/*
+	 * Discard all the folios that overlap the destination region.  Start at
+	 * the old EOF when extending so the folio straddling it, which may hold
+	 * data written past EOF through an mmap, is dropped too.
+	 */
 	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
-	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
+	truncate_inode_pages_range(&target_inode->i_data,
+				   min(fstart, i_size), fend);
 
 	fscache_invalidate(cifs_inode_cookie(target_inode), NULL, i_size, 0);
 

