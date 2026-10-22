Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668902;
	b=ABGLTBHX9ggtn9Li6g4L/LaR7lGRkc+4kCSr0G+2Dtr7X9dZg6cjNsbD+nvT0RKRdtJM
	 RDTNuOStNdwzgsEHauYsoprkVyDwmFMPBHoLNAMedem2C/LWfSYc4tiBE/e86ceYPtsiO
	 B+8uneTj0bQ14/eGAyYJZ3UOMSobvPbWcQoREGmz0DzFLeETRQrggt/6hS5G8Ce9l4iGT
	 X2yNrk9bPcBgaV/7w5SvfT/Rt1PkRb/bDdpcDeOGWVNUUAkfIgZRO50Yn4UkYieBhC4k2
	 K3HMiq1oR0ucqyPqxtMOT5qkHEE7uzURXORSnAXai7CEnjEM0cUsA2t7igd8xjwsd0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MIOkEkykK2VZw61H3IZg5UZiUCGJsR4FNDPUbCVuUug=;
	b=gqoVojdpfCR3+gd3kXcg3y3XxhPyrsWDy2OoEXqqUUBMIAGbf9u4kJNq3mkmL23Z9HEO
	 8iO2kOHOAlNSUXroa4l4zDaluTqMxVeSHgyTPJiQxlc6q269VOH/U4evvDcCgMHQNWY2b
	 /M0abbrgToU3c1eHBJnk7RQxAWX1/eMgYd+beDS6BcSFYEPhbVYrhCZJmxZ/zZigdATKj
	 iWPcMMBf8v6ie/C5tEk4GhdMLviUAFxK/0C8A8hi2k5TAMD152V7cd3wnnRrZn5zUksV0
	 GT30S5hfZIfQWDfLovCGdIeLLjfqRCVPotBVL9OVA9u06AJzA49G6k+ucv0H80Vwlww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZjiK4hb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D695606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZjiK4hb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA91F000C1;
	Thu, 22 Oct 2026 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668902;
	bh=MIOkEkykK2VZw61H3IZg5UZiUCGJsR4FNDPUbCVuUug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZjiK4hbIMnOaJaadmaYahrehUa11irIUYIeZSypvFNE1NEIz65AzV5qzOdEK+7Jb
	 gw9kr+PAx3Lnrqft4wLlGKym9xPDssUoJhPfzbqv+5t0lQSok53vHmbV8/l0tPk8OS
	 h74BZ37uCEyPdmVO5MzpogUQn9iSBQ2Qt5VPNYjQk2RTkmfH3CaZ6c/tnD8sefliai
	 vzTIPrzcdmcKRaT+dN8qtza3ryODiddk8MXZzEZAS/eqaETHn1B0oy40KfTFlA1THy
	 tjuo2wHHicp3v8vnwHQ0hXGVRCpgD7/vsGP3bHSlp9xVjcGJSXMD0N6y7rLuEqO2+K
	 JxpWCXuEnxK8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
	"Dae R. Jeong" <threeearcat@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	Bradley Morgan <brads@mainlining.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] watch_queue: Fix note pool publication race in watch_queue_set_size()
Date: Thu, 22 Oct 2026 07:35:00 -0400
Message-ID: <20261022113411.917463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102127-refocus-parakeet-893f@gregkh>
References: <2026102127-refocus-parakeet-893f@gregkh>
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
[ sashal: retained the existing mask variable when adding nr_notes to the local declaration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 37da8647b4ecb..978c29b1fa427 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -102,7 +102,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, mask, note, offset, len, nr_notes;
 	bool done = false;
 
 	if (!pipe)
@@ -116,8 +116,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
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
@@ -305,7 +307,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
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

