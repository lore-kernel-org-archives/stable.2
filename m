Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308343B0AE4;
	Thu,  8 Oct 2026 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791499378; cv=none; b=X+0zDe7Dgn4ltbny6GSGxD3ndzQRl1RREfhOOOCh7JHr+wXU5BV8T6Um7G8S8X6O0w3sOZMCYH0M0JeLu3DpkkWTbXUe5mTDlwoXAAakml43biMvhgLZBEGOLYEpgQHCPiDX5mFo3+oB62fRivR7il3pfKIFPD5o+l5txjssKcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791499378; c=relaxed/simple;
	bh=+goYj/o+YwHUjbxMWjYtF5BIR5nU+fqhQjD3RDm4t/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GM/zg9Z2H519EYo9ODxr4XNrimrhd+9iiW7O20+6AX8vg33fR99pSaykQCGGo3f9cnZd7IJAjZ77+GQUrAdUZNBk4bV45igoCabvF0BRDz35+xO6OmTGPWldcLeDBKuvYDXeEAx0L203fHhjGz9K8iTJ4gXSUp2FVLyBK1ziWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gZo/HnFl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gZo/HnFl"
Received: from mac.lan (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC43020B7166;
	Thu,  8 Oct 2026 15:41:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC43020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791499319;
	bh=OP5F7DlztNufb0JidK9WhyBFcBtyfMxwleYWMwnNSFs=;
	h=From:To:Cc:Subject:Date:From;
	b=gZo/HnFlMOWyYrAzIdQxtcKR3swk5/tAoxih5V4Bx0E7wL9S5k2xm4NrZe7F+mR7w
	 zTvRj7pV/1XKhs6GvG7U8IBGz5f+PNo9Kc5/I4eVVI1jIoaY93cdLl3H5xT7WcsoiP
	 RzGyVfDK5V1eCGvjqBbG/ByB0dgWWwmt167pW78k=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Kees Cook <kees@kernel.org>,
	"Dae R . Jeong" <threeearcat@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] watch_queue: Fix missing locking in watch_queue_set_size()
Date: Thu,  8 Oct 2026 18:42:33 -0400
Message-ID: <20261008224233.9675-1-cenzhang@linux.microsoft.com>
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
nr_notes with plain stores and does not take wqueue->lock, so the four
stores are not atomic as a group and, depending on the build, notes can be
stored last (gcc 14 on x86-64 does this).  Since keyctl_watch_key() lets a
watch attach to a queue before it is sized, post_one_notification() can
already be running on another CPU at that moment: it reads nr_notes > 0,
passes its bounds check, and then reads notes while it is still NULL,
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

Fix this by putting the four publication stores under wqueue->lock.
post_one_notification() already runs with that lock held, so a poster now
sees either the whole pool or none of it.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Dae R. Jeong <threeearcat@gmail.com>
Closes: https://lore.kernel.org/all/ZT-S8Q7tyutcvu_q@dragonet/
Reported-by: AutonomousCodeSecurity@microsoft.com
Assisted-by: LLM
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 kernel/watch_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 538520861e8b..9fb3035b3ebd 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -294,10 +294,13 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error_p;
 
 	bitmap_fill(bitmap, nr_notes);
+	/* Use lock since watches may already be attached. */
+	spin_lock_bh(&wqueue->lock);
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
 	wqueue->nr_notes = nr_notes;
+	spin_unlock_bh(&wqueue->lock);
 	return 0;
 
 error_p:
-- 
2.55.0

