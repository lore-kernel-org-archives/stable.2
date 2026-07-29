Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4648B366
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331429; cv=none; b=aKpMbvcKexJwMxvbDfcqqdNjkQEcDnQivipx6AAAXKkHUWoBWkysCUMPLla5AD9PEZS4N9SWr7EiAfluE0gaukOhU2K9p4CHzfWVf4VPUdt6i872nUdU5ECFwoXNqC/E0VsWaai6b96t0FscOjcQtEDF165h08/+ycOhLDekK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331429; c=relaxed/simple;
	bh=0X0fn9TMg9AIamrgdtF/Es+VT6XjoUIbLk1H95RaRjg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nKC+It16/TQjMyfcSdw14/Q62ORTP6EwDmVEd13Gbge0BlDkCeO1coIue08zngcpO5O/XwwbUKWcXpXQ+nI1Ef6DtPjoOQG/D7Li/O24e/7N2ulEkjYs/1bilnyo0EtRyzVfC6zrHdtpIxnZx0CEc0wPnbF3la4c6zQSNy9vhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZXk5rNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZXk5rNh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598601F000E9;
	Wed, 29 Jul 2026 13:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331426;
	bh=mQT3ndQFPTOJCu8acroWnt93BsoTU6QriZBrJeBvR34=;
	h=Subject:To:Cc:From:Date;
	b=UZXk5rNhvowUbZjOTbpJlOLYgVIGcilujPasa5gRpW1ZWJYaVq8Sxtp/f2FkWY0wS
	 BllOq5HYc8pCmgB4kv2zDXwpzggR08HJHk4A1Ley7O65ouAUg/0FFTEe15ZNjn/Dgo
	 Uc6yho/eLsrB+bD1UDNwVPspO/TbMSx4pOeh1CzM=
Subject: FAILED: patch "[PATCH] ALSA: seq: close a re-opened queue timer in the destructor" failed to apply to 5.10-stable tree
To: norbert@doyensec.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:18:46 +0200
Message-ID: <2026072946-underdone-mule-5e1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 2c4dc0ed50b05cd847a4b34b8cebf0775f19aeb9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072946-underdone-mule-5e1d@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c4dc0ed50b05cd847a4b34b8cebf0775f19aeb9 Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Tue, 14 Jul 2026 10:29:23 +0200
Subject: [PATCH] ALSA: seq: close a re-opened queue timer in the destructor

queue_delete() closes the queue timer, then frees it. snd_seq_timer_close()
clears q->timer->timeri. snd_use_lock_sync() then drains borrowers, and
snd_seq_timer_delete() frees q->timer.

A borrower can re-open the timer inside that window. A SET_QUEUE_CLIENT
that took a queueptr() use_lock reference before the queue was unlinked
runs snd_seq_timer_open() after the close. Open refuses re-open only while
timeri is set, and the close just cleared it, so it re-opens timeri.

snd_seq_timer_delete() does not close that instance. Its snd_seq_timer_stop()
is a no-op, because running was cleared first. So it frees q->timer with the
instance still live. The queue is freed next.

The instance stays on the global timer with callback_data pointing at the
freed queue. A non-owner START on the unlocked queue arms it. The next tick
derefs the freed queue in snd_seq_timer_interrupt().

Reachable by an unprivileged user with access to /dev/snd/seq. No CAP and
no queue ownership required.

Close any lingering instance in the destructor. There, ->timeri can no
longer change: the queue is unlinked and all use_lock borrowers have
drained, so no snd_seq_queue_use() can re-open it. Close it before clearing
q->timer. snd_timer_close() waits for any in-flight snd_seq_timer_interrupt()
to finish, and that callback still reads q->timer (via snd_seq_check_queue()),
so q->timer must stay valid until it drains.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Link: https://patch.msgid.link/422FDB81-2A68-47C7-A22D-2D3301E2E86D@doyensec.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 4cd7211ccf48..419288eec4bb 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -61,12 +61,23 @@ struct snd_seq_timer *snd_seq_timer_new(void)
 void snd_seq_timer_delete(struct snd_seq_timer **tmr)
 {
 	struct snd_seq_timer *t = *tmr;
-	*tmr = NULL;
+	struct snd_timer_instance *ti;
 
 	if (t == NULL) {
 		pr_debug("ALSA: seq: snd_seq_timer_delete() called with NULL timer\n");
 		return;
 	}
+
+	scoped_guard(spinlock_irq, &t->lock) {
+		ti = t->timeri;
+		t->timeri = NULL;
+	}
+	if (ti) {
+		snd_timer_close(ti);
+		snd_timer_instance_free(ti);
+	}
+
+	*tmr = NULL;
 	t->running = 0;
 
 	/* reset time */

