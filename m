Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594131;
	b=xiP3hNamPH8o9w6/SXjChwiQNbSy+RC9ODu1hJQJGlKXplUabc/Bw79x7NzhHgv75DXx
	 +1pPura3opJV6/glXfQuHsg0UZjNdHHKufDeQq4lpfTcbWDXYrb4cISIe6dj02l1vDs8Q
	 qLbiBgyfoY6SLuZ6wrNcP0sd+O3tETdwz0oGLplBrcyOYWL6Ou4lXV5QPiIyF3+oCNwSe
	 klcnZGPH2eIw92ueeij2keIyLQumOASzkKN9sgwvdBvuylXCruJyyBq7iwP5MW73mf10b
	 k7rp2TasGcqCjfVldwbOGOW9l5b7IoLvoMIwopSvwdFFHciSPiK3OkrTtbFEHl1fysw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594131;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=06Sj5+BuoBjwtbI9YvzZsfWWJ7wxbhserFprRqs7wD0=;
	b=dKPlwAaO1CiA1dtcPNfFdpnHr4HMnU34xOpoUYgen93n3CMYd/6BDLTQXJr1eQrs5vKd
	 OzZz1TxQ1SMu5C4OQtn6MyZOCWIj9HstTzMhb0POf5oAPl6nvPgq2Umhqre7hjZM7QQXu
	 lgtA0a94MoVxBcTOxlQzXRzVMnuD280gLPjdU3QQwyQ63G9wJtMcuT9q9kHMUIbg+xWkR
	 a6klA2iiyHnC7yyvuxOh9BtNU+TWif7Wt1Zlsm2UTxiHmJ3iNzSXx2qmKOKg3H55dJktH
	 72wrmZwnYe3exRQ3fnCub7opVvzenGd1kMklBB0rvpTkstb3yekHjS6vULjURHQvROQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=15gr4NfH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA91606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=15gr4NfH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A3B1F000C1;
	Wed, 21 Oct 2026 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594130;
	bh=06Sj5+BuoBjwtbI9YvzZsfWWJ7wxbhserFprRqs7wD0=;
	h=Subject:To:Cc:From:Date;
	b=15gr4NfHqi275S4DbN++FF8anfVfMbXviT6B0Tk0letk3PWhpeiIrKA4puM4PPXUP
	 iKOc0hdDrDdgAh+xERlkv7fdldv3EwfKUXqtN3ygncFFrOYjK2g4be3GOLTvHXX7rq
	 6+kHg1pYfVAVvVvx7/Co38seXLqIzbCWSYEU2P00=
Subject: FAILED: patch "[PATCH] watch_queue: Fix note pool publication race in" failed to apply to 5.15-stable tree
To: cenzhang@linux.microsoft.com,brads@mainlining.org,brauner@kernel.org,stable@vger.kernel.org,threeearcat@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:25 +0200
Message-ID: <2026102125-proud-dial-e6e3@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5e531d62f1f8834faf7a4eed0d41105cf6570a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102125-proud-dial-e6e3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

