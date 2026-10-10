Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9851FF7C7;
	Sat, 10 Oct 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791635514; cv=none; b=PPFEPhQZJEcbsxO1VspUBvDZbiJAn+zRk1LmfFUw67Y8Jgoos2ZmZWtPqZjlwUEk83hcmzZAbzaearJQnwCavjIyLiQzhIHjZ448ctZMHoki//oHrT4QP1ZF84Grz/8PnkC3XVWRyb7FMLyuGE9ovTb+a/Yf+JPAcBtZDxx1ygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791635514; c=relaxed/simple;
	bh=frpxXg9hPGDM03nFowUJV+CKR7flPJDXWbN+RkJwAsY=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=V9hcnXNupXXcDSCAwgzG5QNKKADc2RH40NPAAY8uQdIo7Md5wt3rhc+Gale9CuL8jbdOSgjGu6cl8gR6nfDxfrPyliDacCYP86xLMM8qH5LYyWoXjtzgzSzxLUkkZ4trh/8fLz1aOy3hsGt8ZinL829lKO9DzCe5OaQAhb2+0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BTOf3rOO; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=QMhww6A/; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BTOf3rOO";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="QMhww6A/"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791635497; bh=ns6QuIJwQmI2wSLwOOfK9Y6
	EB2HsWBuBorBLYJCW6CE=; b=BTOf3rOOeHDIk3rNhwmuwiiNRQRx0lj+2IVu3Kj0LAC6W02ixR
	XgePTKApKWnLNm7e6eCGj5XW02jVYBHJYz/NJ31ijzK98P2Ll7sStcRvRFq7IfSkwXq28pmW+kF
	iqyZilPznF+Oc6MOYwgOXW/ivHQ+UUqBh9Xv0OiGkMfEoTGtG+rSM0/LqBU2M61vUzzNadj5ZTZ
	LTTdtouWiNximXJbRvThk9mtLepAM6bpIflIHNW9JI5me7K+rFyjGhJtRe4uZlQvwPxATeM/VPG
	koDub8F1+LmI97EU0nyihkigUi65KeH88nU3VjBqo5ZdbnRor2dxGDKKUXbrDS5MAxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791635497; bh=ns6QuIJwQmI2wSLwOOfK9Y6
	EB2HsWBuBorBLYJCW6CE=; b=QMhww6A/GP5XUL4YUPEKs/NbIYRaxWLe5q6tPoGWEPTYa+mRV/
	HZP9wvyqhXHUpLYZRR9BYDhaMifgupB/eLAQ==;
Date: Sat, 10 Oct 2026 13:31:38 +0100
From: Bradley Morgan <brads@mainlining.org>
To: cenzhang@linux.microsoft.com
CC: AutonomousCodeSecurity@microsoft.com, brauner@kernel.org, dave@stgolabs.net,
 dhowells@redhat.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tgopinath@linux.microsoft.com, threeearcat@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_watch=5Fqueue=3A_Fix_note_pool_?=
 =?US-ASCII?Q?publication_race_in_watch=5Fqueue=5Fset=5Fsize=28=29?=
In-Reply-To: <20261009224715.46121-1-cenzhang@linux.microsoft.com>
Message-ID: <B042CCA8-1AE4-47DC-B9FB-F34B86D16461@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 9 October 2026 23:47:15 BST, "Cen Zhang (Microsoft)"
<cenzhang@linux.microsoft.com> wrote:
>There is a race between watch_queue_set_size() and
>post_one_notification().
>watch_queue_set_size() publishes wqueue->notes, notes_bitmap, nr_pages and
>nr_notes with plain stores, and post_one_notification() reads them with
>plain loads under a different lock, so nothing orders the four stores
>against the poster's loads: depending on the build, notes can be stored
>last (gcc 14 on x86-64 does this).  Since keyctl_watch_key() lets a watch
>attach to a queue before it is sized, post_one_notification() can already
>be running on another CPU at that moment: it reads nr_notes > 0, passes
>its bounds check, and then reads notes while it is still NULL,
>dereferencing notes[0].
>
>An unprivileged user triggers this reliably by watching one of its own
>keys through a notification pipe and racing
>ioctl(IOC_WATCH_QUEUE_SET_SIZE)
>on that pipe against keyctl(KEYCTL_SETPERM) on the key from another CPU,
>triggering:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  RIP: 0010:post_one_notification.isra.0+0xa2/0x1e0
>  Call Trace:
>   __post_watch_notification+0x148/0x180
>   keyctl_setperm_key+0x119/0x130
>   do_syscall_64+0x108/0x4c0
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  Kernel panic - not syncing: Fatal exception in interrupt
>
>Fix this by publishing nr_notes last with smp_store_release(), and by
>reading it once with smp_load_acquire() in post_one_notification() before
>the bitmap and the page array are touched.  A poster that observes a
>non-zero nr_notes then also observes the pool behind it; one that observes
>zero drops the notification as before.

Gnarly looking bug.

>
>Fixes: c73be61cede5 ("pipe: Add general notification queue support")
>Reported-by: Dae R. Jeong <threeearcat@gmail.com>
>Closes: https://lore.kernel.org/all/ZT-S8Q7tyutcvu_q@dragonet/
>Reported-by: AutonomousCodeSecurity@microsoft.com
>Suggested-by: Dae R. Jeong <threeearcat@gmail.com>
>Assisted-by: LLM

Nit: Cc: All Applicable 
<stable@vger.kernel.org>

>Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
>---
>v2:
> - Use smp_store_release()/smp_load_acquire() instead of lock (Dae R. Jeong).
>v1:
> - https://lore.kernel.org/all/20261008224233.9675-1-cenzhang@linux.microsoft.com/
>
> kernel/watch_queue.c | 11 +++++++----
> 1 file changed, 7 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
>index 538520861e8b..932a88ac1f39 100644
>--- a/kernel/watch_queue.c
>+++ b/kernel/watch_queue.c
>@@ -101,7 +101,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
> 	struct pipe_inode_info *pipe = wqueue->pipe;
> 	struct pipe_buffer *buf;
> 	struct page *page;
>-	unsigned int head, tail, note, offset, len;
>+	unsigned int head, tail, note, offset, len, nr_notes;
> 	bool done = false;
> 
> 	spin_lock_irq(&pipe->rd_wait.lock);
>@@ -111,8 +111,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
> 	if (pipe_full(head, tail, pipe->ring_size))
> 		goto lost;
> 
>-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
>-	if (note >= wqueue->nr_notes)
>+	/* Pairs with the smp_store_release() in watch_queue_set_size(). */
>+	nr_notes = smp_load_acquire(&wqueue->nr_notes);
>+	note = find_first_bit(wqueue->notes_bitmap, nr_notes);
>+	if (note >= nr_notes)
> 		goto lost;
> 
> 	page = wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
>@@ -297,7 +299,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
> 	wqueue->notes = pages;
> 	wqueue->notes_bitmap = bitmap;
> 	wqueue->nr_pages = nr_pages;
>-	wqueue->nr_notes = nr_notes;
>+	/* Pairs with the smp_load_acquire() in post_one_notification(). */
>+	smp_store_release(&wqueue->nr_notes, nr_notes);

Looks okay to me cen, just the nit:

Reviewed-by: Bradley Morgan <brads@mainlining.org>


> 	return 0;
> 
> error_p:
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
