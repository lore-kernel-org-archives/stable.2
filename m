Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D823D9058
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032880; cv=none; b=C1WC6/rJ0uOGbk39kqr3aafw6OS5bBhR47mChB6ZpLXZCizKOWm/maLUtWdMzdc+ITwWGFjeCXTEOY0pWCWRuo6Y6oUDSLCBsKA2MGnDLGXYY5WF+s+0OW20H3DWaWk+5Dx+ybkBUZ1v6GzBsdlCMJLqfBT1tHsEG7tOX3R1/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032880; c=relaxed/simple;
	bh=qGghBUlf3V3g6LO2dcL44ianiMpWfunKtANgbBixqtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfY1eUGSr+zKfA0YxIo81NclVCXGCYNHoKJkfTwK7HK9pKYhQriBQKWYpODZEOyEu4KL0afPXEeHLSRh6bIXabWavo3pEnISBQnrNUYZzIzidYcUQJAtEyrVD/tUXcbXeppDMlg3nk9mHzfS882lbw53JR6ow+QyGelNh8aTHbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxZUr4eb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxZUr4eb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6001F000E9;
	Thu,  6 Aug 2026 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032878;
	bh=EiYhcwLfSe3koQcVjnccpB4WhUyGDHIlPhWm7KA4BDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxZUr4ebsL/9yZ7GI9cS0dnVwIvqpdUBBa7GoUQO8DyyBvRI8/wZFSES7Fz8AqdM5
	 pwYZeaoIEK6dsVKswUkgqvuUz+sKJpF4lcU1W2OV6f91XL8ejLQEIKrUj7N5Uy8LeZ
	 OhkfaE4FS6Ov5wHI+ea9K70ZU2MOZKJ4j1iHm5Kgb1+u69NhyAY31G3P3XS4dmTuO0
	 zganHqGRsqid3zpVtuA7Ynm51Fbll0c+4Ov08PksmOp4w9xTTrrzNtQ3plw6wXdmA1
	 guBxpS6GaFETF2xUbfinBBw9JJRq47t50ozvJDdrgqxSCOE9O4dzZpceE8Q+iagTDZ
	 ANVWy3YfYeq+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: seq: close a re-opened queue timer in the destructor
Date: Thu,  6 Aug 2026 12:14:36 -0400
Message-ID: <20260806161436.1142604-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072945-oppose-vending-195a@gregkh>
References: <2026072945-oppose-vending-195a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit 2c4dc0ed50b05cd847a4b34b8cebf0775f19aeb9 ]

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
[ replaced scoped_guard(spinlock_irq, &t->lock) with explicit spin_lock_irq()/spin_unlock_irq() pair since gnu89-compiled 5.15 rejects the macro's for-loop declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_timer.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 9863be6fd43e1..50581120f2822 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -58,12 +58,23 @@ struct snd_seq_timer *snd_seq_timer_new(void)
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
+	spin_lock_irq(&t->lock);
+	ti = t->timeri;
+	t->timeri = NULL;
+	spin_unlock_irq(&t->lock);
+	if (ti) {
+		snd_timer_close(ti);
+		snd_timer_instance_free(ti);
+	}
+
+	*tmr = NULL;
 	t->running = 0;
 
 	/* reset time */
-- 
2.53.0

