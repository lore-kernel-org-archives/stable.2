Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601638;
	b=ZrX0EyOFtnCElW18BnE5WKxsbQBwckI/p72LsDKeqp/XuEROFxdNcpNnEDze5RFgNHI7
	 820SWxsyK4HnejI3hhRwe6GEB3cf2A5vjsDL9ij73teWILVHv/26IRWGtOqIjeuWa13gp
	 MHOIKaDwaUoa5a7hZOFNIwcLN/s1WvKfZ0lbYIci8eMa9HKGKSjODrE5YRNpROtBrTQKF
	 sluR8I/OoCPJup6y/XhGKUo88qfvKWHozm6mIteINNmSnfJPw65O0FieFhIyyVNQxN5fv
	 ICDPtOdAxfDVtRjU6bRfCcOeCSYwZ80VrNprq6nBvT/cK4PB69bGk8AEEWvss1tfgJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601638;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Qesufly2/205g6tNcX4xDlg84xP6DXgUBIhzyFIoiJw=;
	b=uxkqoFj4CZCdiXd/Rn7GD8DLuwetPdLmGgwsgYBl8lWId/cZeK7x1zkgi6T+AsW0FYOt
	 t/E/PqYPZNtJmRYa8DW4sKe+Kq+/nd9jeR/tcSaFUazKlA8df8V+m4gtpK3SwWXodeAVk
	 R5oQFa3n5JlU0+6KfDplxEAX4c2NZ+Ev2H1OsuiWfpTK4+O1F6/JMIaJXp+s0cMB1bACO
	 j5WE0g3SLNe6IS5YW6P9ihYuUuHcmPqMFnuCjCERPO4x2EBWo6FeNzJst7awx4zRp9MVq
	 7Vjpr2/Nj4qkyY+3uYJPbA+o6YTtDKqbkfGnJDYnVeykm2BqaaJrIr0kYcFekhfTuTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lkvDdNjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17409606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=lkvDdNjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349381F000CA;
	Wed, 25 Nov 2026 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795601637;
	bh=Qesufly2/205g6tNcX4xDlg84xP6DXgUBIhzyFIoiJw=;
	h=Subject:To:Cc:From:Date;
	b=lkvDdNjJMayj1JjyRNyV7IaKcIFpn/UgJSF9Pxmv6iO7A0nEInSTt2+ObZLMs4pGP
	 ZV8FtI6UULb4jG7dKsTnirM+/Lj40o5fhYE5FR0lDWJ+2g4VQ3vvpNsqGJLvwILL8e
	 2YXt/EyAZjz6xCE0jTg0TQZRU2Ll8s1jNpjXuCVc=
Subject: FAILED: patch "[PATCH] fs: set I_METADATA_WRITEBACK in mmb_mark_buffer_dirty()" failed to apply to 7.3-stable tree
To: brauner@kernel.org,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:11:43 +0100
Message-ID: <2026112543-dipped-sultry-a7a2@gregkh>
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


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d4fdde3257a577f184b4498d040f6fe20be72326
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112543-dipped-sultry-a7a2@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4fdde3257a577f184b4498d040f6fe20be72326 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 9 Nov 2026 17:51:23 +0100
Subject: [PATCH] fs: set I_METADATA_WRITEBACK in mmb_mark_buffer_dirty()

ext2, ext4 without a journal, fat, udf and minix track the metadata
buffers of an inode in a mapping_metadata_bhs list and sync them from
->sync_inode_metadata() and ->evict_inode(). The inode block itself is
only tracked by I_METADATA_WRITEBACK which ->write_inode() sets after
copying the inode into its buffer.

Set the bit in mmb_mark_buffer_dirty() as well so that it covers all
the metadata an inode may still have to write out. Set it after the
buffer is on the list. An fsync() that sees the bit then also finds the
buffer when it walks the list, and one that cleared the bit before we
set it leaves it set for the next one.

The inode itself may never have been dirtied. fat for example tracks
the FAT buffers on a private inode that nothing marks dirty. So attach
the inode to a wb before setting the bit, the way ext4_mark_iloc_dirty()
does, or writeback_single_inode() has no wb to lock once evict() syncs
it.

That lets evict() write out everything the bit tracks in one place
instead of every ->evict_inode() calling mmb_sync() itself.

Suggested-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org # v7.3
Link: https://patch.msgid.link/20261109-work-inode-metadata_writeback-v3-8-91ac6c024018@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/buffer.c b/fs/buffer.c
index 5d3852b726d6..f951559e7d32 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -621,12 +621,15 @@ void write_boundary_block(struct block_device *bdev,
  * @bh: The buffer to mark dirty.
  * @mmb: The list of buffers to add the buffer to.
  *
- * Mark the buffer dirty and add it to the list if it is not already on
- * a list.
+ * Mark the buffer dirty, add it to the list if it is not already on a list
+ * and set I_METADATA_WRITEBACK on the inode so that fsync() and eviction
+ * write it out.
  */
 void mmb_mark_buffer_dirty(struct buffer_head *bh,
 			   struct mapping_metadata_bhs *mmb)
 {
+	struct inode *inode = mmb->mapping->host;
+
 	mark_buffer_dirty(bh);
 	if (!bh->b_mmb) {
 		spin_lock(&mmb->lock);
@@ -641,6 +644,15 @@ void mmb_mark_buffer_dirty(struct buffer_head *bh,
 		list_move_tail(&bh->b_assoc_buffers, &mmb->list);
 		spin_unlock(&mmb->lock);
 	}
+	/*
+	 * The inode itself may never have been dirtied, so attach it to a wb
+	 * before setting the bit or writeback_single_inode() has nothing to
+	 * lock when evict() syncs it.
+	 */
+	spin_lock(&inode->i_lock);
+	inode_attach_wb(inode, NULL);
+	inode_state_set(inode, I_METADATA_WRITEBACK);
+	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(mmb_mark_buffer_dirty);
 

