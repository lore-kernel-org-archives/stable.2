Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594125;
	b=RZIaVLUfu/uDhifKNz+PIpKWbFj4aXehwZbI5dXsb64rPkZoIuLRa2NFop6obAvFp0az
	 baiUGizuzd9qivQj6qEEYNHvLKn6yL/HxoohF/3Zsf2WK8v2UB0SE56rohIEpouOxCu2B
	 oFvYlJBpBWO5/XgTPH8Qs5Dqnc+n4dMaF4lRHW6sJA3G+bbByWsEmj+494os24DCIfWsh
	 oMS8Ar6Oo7bCvYCLjqYLb2MEIdHF+b7YkrP3y8Bz5INz5AIkm+YqQJnci2c7bz7d14iGT
	 66J0du3F7hbq8oWW959O5/u+QVMFW7rDy0IOdkUHHpRWg40lyjehvds80rMx7MoRsuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594125;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xXMv4E7+NL6Qc9RBuiYMZAGQJseXFO9aN6xy3Bx0ye8=;
	b=YBeRBUsrUoOLGOEqb81nR7gYgIJY0fHYeBQm8GW2O/FBRXSnk7z22GoevDjkS6gxqZh4
	 UqWa4a8waA8le1+JUQpPDH2LFq1LRnhfqDwqf8xL5BzV+RRM+e3Tzul2/woWquKeMxAkY
	 i6gScHSePIIpGDwRDvYEIh8PR8t5W73XNdt9dEvEqNMoF8XfQLShzG/YILkx5jvdNXkX0
	 QFfuvpBnMWwP84zyLcyHGumtHvFXZ7lICJo3T4v/O/3Fz5E2wf+PjD6dW/gLrjx68+o3r
	 ZA//3FICi+BJkCHChQlQTXAGsJvjFvoypxhCqjDM3XbLdjs+lTxtUrBQX7Pky4s3mWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PgJR85Um;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632A606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PgJR85Um
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FD1F000C2;
	Wed, 21 Oct 2026 14:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594124;
	bh=xXMv4E7+NL6Qc9RBuiYMZAGQJseXFO9aN6xy3Bx0ye8=;
	h=Subject:To:Cc:From:Date;
	b=PgJR85UmF6DJ5N+M+F+2M8f5MTkUuixJXNj/a7tgto2xqazT9I0fGuNF5gPibsfZD
	 z6QS541vpJtG1wlf13SSEbjuc0CS/yEU+NHHxMVIuoI3XKrhTLNLDas+r6NkNQ5rLq
	 DkL2lwKtS4UrQmSLi9hWOoWk4DmC8suupeecGr9c=
Subject: FAILED: patch "[PATCH] watch_queue: Fix note pool publication race in" failed to apply to 6.6-stable tree
To: cenzhang@linux.microsoft.com,brads@mainlining.org,brauner@kernel.org,stable@vger.kernel.org,threeearcat@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:21 +0200
Message-ID: <2026102121-dial-citric-080a@gregkh>
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
git cherry-pick -x 5e531d62f1f8834faf7a4eed0d41105cf6570a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102121-dial-citric-080a@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e531d62f1f8834faf7a4eed0d41105cf6570a8f Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
Date: Fri, 9 Oct 2026 18:47:15 -0400
Subject: [PATCH] watch_queue: Fix note pool publication race in
 watch_queue_set_size()

There is a race between watch_queue_set_size() and post_one_notification().
watch_queue_set_size() publishes wqueue->notes, notes_bitmap, nr_pages and
nr_notes with plain stores, and post_one_notification() reads them with
plain loads under a different lock, so nothing orders the four stores
against the poster's loads: depending on the build, notes can be stored
last (gcc 14 on x86-64 does this).  Since keyctl_watch_key() lets a watch
attach to a queue before it is sized, post_one_notification() can already
be running on another CPU at that moment: it reads nr_notes > 0, passes
its bounds check, and then reads notes while it is still NULL,
dereferencing notes[0].

An unprivileged user triggers this reliably by watching one of its own
keys through a notification pipe and racing ioctl(IOC_WATCH_QUEUE_SET_SIZE)
on that pipe against keyctl(KEYCTL_SETPERM) on the key from another CPU,
triggering:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:post_one_notification.isra.0+0xa2/0x1e0
  Call Trace:
   __post_watch_notification+0x148/0x180
   keyctl_setperm_key+0x119/0x130
   do_syscall_64+0x108/0x4c0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  Kernel panic - not syncing: Fatal exception in interrupt

Fix this by publishing nr_notes last with smp_store_release(), and by
reading it once with smp_load_acquire() in post_one_notification() before
the bitmap and the page array are touched.  A poster that observes a
non-zero nr_notes then also observes the pool behind it; one that observes
zero drops the notification as before.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Dae R. Jeong <threeearcat@gmail.com>
Closes: https://lore.kernel.org/all/ZT-S8Q7tyutcvu_q@dragonet/
Reported-by: AutonomousCodeSecurity@microsoft.com
Suggested-by: Dae R. Jeong <threeearcat@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Link: https://patch.msgid.link/20261009224715.46121-1-cenzhang@linux.microsoft.com
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 538520861e8b..932a88ac1f39 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,7 +101,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, note, offset, len;
+	unsigned int head, tail, note, offset, len, nr_notes;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
@@ -111,8 +111,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
-	if (note >= wqueue->nr_notes)
+	/* Pairs with the smp_store_release() in watch_queue_set_size(). */
+	nr_notes = smp_load_acquire(&wqueue->nr_notes);
+	note = find_first_bit(wqueue->notes_bitmap, nr_notes);
+	if (note >= nr_notes)
 		goto lost;
 
 	page = wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
@@ -297,7 +299,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-	wqueue->nr_notes = nr_notes;
+	/* Pairs with the smp_load_acquire() in post_one_notification(). */
+	smp_store_release(&wqueue->nr_notes, nr_notes);
 	return 0;
 
 error_p:

