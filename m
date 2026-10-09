Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D213A258;
	Fri,  9 Oct 2026 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586056; cv=none; b=m1GongVkIHKy7aFPLcjrSq7BX41AKPSq2R0f7wC7WduQXL21GZ+tU+gkBJMviyb5u3qV+vje+8zr+mvLF1vvjDHDqMGbTZrsSZhuTZ/eHgZ3n5ezma0fKA5EN5Wzq+0uYv0qL3Vw0Z5zgz76wHmxcxUS8gyfZ/FhY+gQw5palqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586056; c=relaxed/simple;
	bh=681GZBiJc3PS3tdM5LQrptP9/bCWqhNsWEoXzv7oM7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNyCM+7F1WnD78RaKyLJVihWc3uDlU08BZKQN87hm/L9sFIWZaBjIFURgVEKEOBW6kVedTteMzmCchrEKjTrGOUrVvWiDYvXWBQ/Zaa+WhN3IiQ9pQl3js72d19Ymh6XmjAWVcCYNeTSwDh9D1+q5KN9zrDECzqdM03oIqnmZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pYnse+H6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pYnse+H6"
Received: from localhost.localdomain (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 121F320B7168;
	Fri,  9 Oct 2026 15:47:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 121F320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791586053;
	bh=bEgMkEvJqqQsQLarrL7RLZsWo2GDNyZQrcIYFzoS6oM=;
	h=From:To:Cc:Subject:Date:From;
	b=pYnse+H6qmJK78NRF2nSPJdbWKO+a94M8HNiCAZZmqBcBQIvLsHNUCIiecisuLqKB
	 UX0FJmAy1E7YlOACpXEJ9TSwRbuxj4pVAD4D5h78uRKh0j0ydNkMa/JUvTYwpEYphb
	 1hxpXEvxzBmu2OXfuxwg+w3nqiUBnsN47rkzHtKA=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kees Cook <kees@kernel.org>,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH v2] watch_queue: Fix note pool publication race in watch_queue_set_size()
Date: Fri,  9 Oct 2026 18:47:15 -0400
Message-ID: <20261009224715.46121-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: LLM
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
v2:
 - Use smp_store_release()/smp_load_acquire() instead of lock (Dae R. Jeong).
v1:
 - https://lore.kernel.org/all/20261008224233.9675-1-cenzhang@linux.microsoft.com/

 kernel/watch_queue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

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
-- 
2.55.0

