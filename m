Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594133;
	b=K8y/J3RWyGZa1QKLkjqj8PVZWtmc9K0AXbW7Fhee+ap6UNFlSEk8LU3gHNxHjcFJWIrV
	 vCs6IDcTPcs2+yksha+9cBhn2UA2ewzFX+BYIz/vV/ZIFkfTkamJwAGK7o5K1OV1vk3QM
	 ohHvsSqm1Q+AAciM0WlFhteLdzP59vsC9OEr9jA0qDtjwdsHzAKkR+hFBfWVgAp0yUgMx
	 f4xZsnxmmurl0PPYCubatlCyr/0rlckXLpKypvkAmzDWrUkD6IGbpYTKCoRnlDi/R4ECJ
	 UnFrRi/kKp8/H8eP8oZuFy/1iWDkoQjiUy4qDuOuZS2lR20up4CgILjV84NVOIDk5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594133;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YXKtKgTSNKgMG8YZTPM/kxryPwW9v0+pgavpxrlyOvY=;
	b=lm8N1JqwDQ5r2sh9wqm5CBnapT+fJ8hSc2k0x3zEj0uE2QF6vSrFfxnVbYj5PThPPNKP
	 EAVEOnI/lsjga3eIK8pGfnLQIDoDNp0uyTcEPqpfD55PzrXsOHylRBQhLtgalU7r6rGu/
	 Ww5SZ4WQM2EyyAwfnbjR0ExnH1GQGK1wuHdzUoqtb2p6FcXVLE2MoXnTRmzbhHkpME4uG
	 HoQuxAbzgPQ87yyPGCwK1rHsC0k7l/BoqmEmXqzjtTa5cT4XwomwL2A0tvAPHKYDcydoU
	 VTpoPzEFqyXz+PYTZ0wOW4laGWHTDCkBBcfAQM2F1foe+g9jxeBUeZbbkonlWAx/fUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kNwBmnGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CB6606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kNwBmnGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8FB1F000C1;
	Wed, 21 Oct 2026 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792594133;
	bh=YXKtKgTSNKgMG8YZTPM/kxryPwW9v0+pgavpxrlyOvY=;
	h=Subject:To:Cc:From:Date;
	b=kNwBmnGUdCd0i5hI+27GcRYIStejsSNT1nFz5Ts1iEQ9QBoWr/rtXdvIdQ17BtUzu
	 r3o7KWMRpbS62PYjNOMvuzQcWjItNiEvnQ8F9En/glFEBtTMrzLJ5xjaCzrm3IUgoO
	 pOpnlBZY/eWt5RFPZA8Jn8fG71qxYTWpmu+vmMb4=
Subject: FAILED: patch "[PATCH] watch_queue: Fix note pool publication race in" failed to apply to 5.10-stable tree
To: cenzhang@linux.microsoft.com,brads@mainlining.org,brauner@kernel.org,stable@vger.kernel.org,threeearcat@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:34:27 +0200
Message-ID: <2026102127-refocus-parakeet-893f@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5e531d62f1f8834faf7a4eed0d41105cf6570a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102127-refocus-parakeet-893f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

