Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618621;
	b=jr+VCOBE8QdLfw63VB5IjYlMEbs1ZwGfDeJtEBnkdCXiiB52mLBdQ6SG+HwOKhiOhKMr
	 BODEq3a+F7+smk4BfdQteJg41R5OsgEZ7OmJZtNBuC8LmFBnaiM2/2mXinlFu09nvPPig
	 CPA9u+mbdIDiuRj9iHMuhlp9JO4RAW3MDHLFnGGHuKELkW64pqRozSZKIDDG6K3vL3cJe
	 Z10GGg3Npp9PJrYkEVBP5qKdzuh94T/CWU9Y+6rIAK9K29NuNFEBxQB3zMQt4mlALMl+m
	 hTM+sPQdA6oUMtKTCco/iZMiIow7cb3b3+yjcddgT2C7orQXWBn8RtEjNwzNG3rPYxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618621;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pfbvP8ERwK73SH9Gn4Wt15mmii4sCF+TMSgVmQgxJrI=;
	b=CvGe880YzEYNS2vCRI5ZbTZX0YbtyekNyV7SEsmmxlL+rqnELzbcjIdeQtiRSKwA/WfC
	 DigYfHx9RP3nostl9xkyDv5Zm/UpQfJss9R6Gdn7IjkrRwem+QTA6hp7fQ9gnq9dvmMIc
	 YicqbHIAHPBPI5l+AkFh/4MYfFTzWMJ5yeWXpFvfry4lxJMJcPbYNazVy4+bz5jr40mum
	 AHAHqcPbFjFwibo3oR6kNNiU46DAwVGhHACRVLjZXCmt+nlznErGHUj8+ym1JWu+ucfjJ
	 Bq9efKPeCKmv4HoEgM+kPua96srP8xLtMtC/bbm+12TgwmNchHd/9hZ4gC32+4D0PjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDgf3KSc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14F606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dDgf3KSc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA701F000C2;
	Wed, 21 Oct 2026 21:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618620;
	bh=pfbvP8ERwK73SH9Gn4Wt15mmii4sCF+TMSgVmQgxJrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dDgf3KSc5kwnB4bwczmU+6ZLm5TDYBNH423z5RvyqwY+0k3Tqqht6vuc+b11koSBd
	 snCNxh+momALluccHslOkLvRx84F+Tr0uGe+/JzNG6taBxkWnOOLln+zZGyWUkKC2O
	 QcH//54Hkh8Z2PvsrSm8KbQwdQwwOglOwWZJACQaAxGShhaq6lSg0RKmFZPebL9Fpp
	 Mqs/KFjJ4NIWCrhIu8Fj9Kcnv4EdrUTaZ7Jm19m2YeZez2RUq86iXf9eiOabyU1dNn
	 jkurfebJuClXWHj+EbTDMaiEjFUogVez40gQEc+6ZOR+kPdFWxUqHL8/UBtlw9VdVH
	 iJEMLtnAH0f0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] watch_queue: Fix note pool publication race in watch_queue_set_size()
Date: Wed, 21 Oct 2026 17:36:58 -0400
Message-ID: <20261021213612.388357-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102123-doze-gizzard-4a63@gregkh>
References: <2026102123-doze-gizzard-4a63@gregkh>
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
[ sashal: Retained the mask variable in post_one_notification() for direct ring-buffer indexing. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a72ea1c2f59fe..506776c113794 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -102,7 +102,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, mask, note, offset, len, nr_notes;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
@@ -113,8 +113,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
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
@@ -299,7 +301,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
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

