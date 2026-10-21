Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597366;
	b=ILp0xnpj4TP3VlibpgwIXShDKKLu65VLW2KL+c+/lQMUuorOkMh+cC1g0zNVkrBEckXJ
	 wolTTAjoH3jEvZBpEYHpVvGtHJnyh7grCQpx/EualUiDVcRBS7IvkoIQAN2UOcHanqSuJ
	 uBPhomJmuHdiRs4YUzJ057OB/rCjiYxMs1CWOMKYs9hvT52cnwzQvpQE27MZl4lwBvFAe
	 XieFgLZfb7rSfT93bFN+PTEBMOuzjnvC8cr5DN5S/t9WpQiGb34sQ4+3IiyA71Pyld9vc
	 GqJ/2Ek94z4LsV2Wm/gvpvunxRAUxsffUT7uIF2xQ8RZ+IFuKwZ52WM1GtRSCOhAoUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UpzJOxslNgjGEQcWy6GofmMdygicxpvnZYVwLnMByMs=;
	b=vlDrSJ7H91ZwLqwc76vTUqKoj/L5q0pLtKhWmxCd2I9Og3Af7EczyvtP93yXyw4Wzicn
	 x5tDwO3UMqJ0xtxTpd8Wt1HwNsGjx7OMly1r3vomovacTp7/6oCZsrrR9jPphNznTCgY4
	 LtIGlz2ftqchneRsmrtzw+4fGCcwhYI0Ne4H5kSUfQmZEdVJHMCTjBJ9OCiZvtSHYvuNV
	 NTqsbtBi9KPjdRhHWvH1sUC6QQyPWRrdQs0bCxHbHXYbK0dbvNI7tedDfg8PYNo4CpqhK
	 7ZMxL8fAHf6rYdAgt6JbB/vaqO1opVB8cVheblGDoWxEbFi6HpToBU+jiyU1yQ6Jtlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9vZfTRP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7B606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9vZfTRP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CA81F000C1;
	Wed, 21 Oct 2026 15:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597365;
	bh=UpzJOxslNgjGEQcWy6GofmMdygicxpvnZYVwLnMByMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q9vZfTRPqBgcyNd3EetE3ZmCO3q/NiP8vQRS6V252e8PFApgR2Q7BrDWtVLrRtikc
	 W+95pAGDonjBj95GfVbkgisa5c0fSQQieuWuf5eg16GkdtSYSEXFdJzyzjD7rTVnWe
	 dT76GQoryU3koh1KOyGXC0bzpxnjxUdhJfNGy2SPY7lrInKBpye5pgGrTh1DVy7h+e
	 Bt8u0ONrToTQCEZtStrwd+bLkAvcxPd+HdzTDCt1kZGljAXXs+kLXRREcao7u7DeKP
	 9CP22SVAUuWiSRAhANWAf/VP4mWbbwn6ii6t19dLe8RiAZBzWHT5L6NogO3R3gjMAK
	 LiUIv7HnMFuYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] watch_queue: Fix note pool publication race in watch_queue_set_size()
Date: Wed, 21 Oct 2026 11:42:43 -0400
Message-ID: <20261021154232.364295-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021154232.364295-1-sashal@kernel.org>
References: <2026102121-dial-citric-080a@gregkh>
 <20261021154232.364295-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>

[ Upstream commit 5e531d62f1f8834faf7a4eed0d41105cf6570a8f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 0840603c91e37..d5a76a5efd204 100644
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
-- 
2.53.0

