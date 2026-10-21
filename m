Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596588;
	b=p2sRKSRU1gHAOP7fo/+PT23nSblf1c+tskPoA0VlD4fvx82ay5niUr3tqdLc9rCVt1vE
	 ZJkI0W78wkB3RHnMpR7P9eI1mARTJbQaUG9WC2TDZxVfsP1JS6jxjVH60KHiDfiuH1Pei
	 KsQQAhDT4coRhsKXsLcu0VE0PdNk/gB5t2fI0rf99L6Qu5SzaNVFxWThvixWYBDrwkW8L
	 U4U1DdC/2jA4gz+QL52PEs8btTe8n7dSnbWI7gVUzwo5IEyXACYMzFiw0xxDTy37XLD2f
	 1aefFyKeQT8//g/hQJLY3HK4DKVhWnIXZHKb6OYG/6AjdNsPSjQrODwra1TJzKypXCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596588;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FVQDpr44eYLngX2WxrdQHG1E4iz8Ilkkjbc5bw5llxM=;
	b=E0ofsY+ETi1O0b17r9f09ddhiVA6BpOmwOuq0EV+l1htCE5BwD15/J4SCcSaqjC3ukXD
	 fUmJnoiSe3F3uXuTro2BXCEsXOfF3CKGHKHgit40l7F1Jg0cBOw518+LFcz/COJbdScq+
	 vT64nOxnJSTQSY12Y6C8CmJa7ev1g9YYtMaSMhGVsoOKTwF4sNxUWsg0FzDKXFn1acfXR
	 Zhgjeeh1zzEL8dBGPXlC+fIbUGXZnyz45oEjHbL0pDGG/C7SBh9Spmka/7p521SJu53ti
	 CpV0lDlqs8KZe88Rm6tnk1gzq4fSAz4dkXul+uRTsP9zIJP8vlLNBKaWtwHr5w0uUig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNU2CobF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693A606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNU2CobF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5711F000C4;
	Wed, 21 Oct 2026 15:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596588;
	bh=FVQDpr44eYLngX2WxrdQHG1E4iz8Ilkkjbc5bw5llxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HNU2CobFXJVZvcXi9vfS1OwEnm4OU2yRjU5x0Ogg6qh09G3eQQnz02Tm9LuSdR8pe
	 bo/KdGnC9niSdPUWnuNY/3Es6P9A+PVDHTJwkse15aBi4rXTfawsvmOAaNXInlrrbk
	 5JwKNe8JdtSNKdnSTmbcWFyMMXYwx3FIia3PCfe6zl7jJpInwvhPI1gVq31A0h8DU7
	 NeeQKu7lLTVdMSUo7kUHBBYaTGBUECP4kTIatIN5kw1tW6zNkjfchf9tURpxQFCAMH
	 eZHYkEV04mlocC1Yi+ZPHb+0Hh7K3hmAA7WEXx1lxK/HNqIbmEZyi7VYM7EopuQU5p
	 I1e6VOBQvq1KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] watch_queue: Fix note pool publication race in watch_queue_set_size()
Date: Wed, 21 Oct 2026 11:29:45 -0400
Message-ID: <20261021152924.289040-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021152924.289040-1-sashal@kernel.org>
References: <2026102119-suffocate-expensive-8655@gregkh>
 <20261021152924.289040-1-sashal@kernel.org>
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
index 5da67a1047d00..8f809cc60c036 100644
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

