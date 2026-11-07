Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047051;
	b=E3IJTQrICFfKXqOlntbKWYAvCItHav98b59T6Oey/9kr8jqSF5fTV/OmnRQttitrlwP8
	 FZtAdb7nr/xLhTr0ngz28Hfu+LRBYoN23zTCCB11yJgnyJK1jjOFJaRX3oZujYQSxjs74
	 dHE8x8OkJOHRKMEozYrSJqLlrWrYxkjAornKJcfAcQy8VexnFX0Cb41SqUSX5TDFCxUgd
	 UWAfrZWOaPJA1fZEOFkrgiLk+0dBBKvgqZ7AzipIvqucCWpJQg+drn5OHoZDiQyCXz0D3
	 n8HziA/UUGICJoLFLC1Bd1bg6mbWwVt9rINdeRo7ekXVXTJUpAAgVs/Ub9Vvl82+Suw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YjjsvtbfbzwzgX4K+pnmaP3RVENSpl6u/NoEFBDoqgA=;
	b=0tudPcD5Ezg+BP0D7tJzuK6hdGx16ImWSZZSqpCsL5Y0qqTSa0XF1974QC0S6JhzH6J9
	 EDQZmc/d3gUbX9EHMNFm/Yk5e7djRo+Z0ZiDcLTYF0u4fFPU0+L5vMzSqzEs5ws3BXzVe
	 lKPjs+9F/eVMZLgM2xxh5qeHyYvRpx9qjMwnM073nDEon1jGKMLjOaq+t4RP4qoOnzRTL
	 3u9fugNbT+XLG7NyhxoGjZBltRe+A5Ye+uI2fAWeBfjR7ngsvM+mqHTJxNzduzQK7TAE5
	 mk7nMjFpaJ/pSC4TLE2delhpn2QlB6L3zWlVJEkAq0X7angD3O+ttg6v/uhsy7mvZRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8cfIZzk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94436606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8cfIZzk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED3C1F0089F;
	Sat,  7 Nov 2026 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047051;
	bh=YjjsvtbfbzwzgX4K+pnmaP3RVENSpl6u/NoEFBDoqgA=;
	h=From:To:Cc:Subject:Date;
	b=M8cfIZzkn0WcIUEPfF5VurHSSKXeBxwQW0pXBHIwz7EgzAxqK+h6eoHrxoBisiVKt
	 EYjUsc2tolCK0d2LPdX4DflCRTRMft1DwwJyaIKNyQUI3FcehgDjvM1/jzzYV4lJ5N
	 D6NwJnO70QoCjREsUQ5kxulTaajqH8elzjLALgZydBTefvL4NevD/99tku+aRy3yly
	 trhCMffTKFqRdpZU8J621zpt3HE9RQRExwsD8MOvutFydjUVT7R0mMSwNdbbsl9R+E
	 +5LhNgIsR9ZztXPSAlgT7fZfvKqIZwo1MbcVLWdJ6Rh1QF/Jdj+7CJ3isq4aWz1aRu
	 TxDyv4Ln6wYkw==
From: Sasha Levin <sashal@kernel.org>
To: dmitry.torokhov@gmail.com,
	kabel@voidship.net,
	jkosina@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Input: always accept EV_SYN in input_event()" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:09 -0500
Message-ID: <20261107052409-failed-6.12-c1d13bfdb9c7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c1d13bfdb9c75c2885d10332174a887349eb0b51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052409-failed-6.12-c1d13bfdb9c7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c1d13bfdb9c75c2885d10332174a887349eb0b51 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 11 Oct 2026 23:12:40 -0700
Subject: [PATCH] Input: always accept EV_SYN in input_event()

Commit 0cd587735205 ("Input: preallocate memory to hold event values")
moved allocation of dev->vals into input_allocate_device(), which caused
input core to accumulate events reported while seeding initial device
state before input_register_device().

However, because EV_SYN is only set in dev->evbit during
input_register_device() (and some drivers also overwrite dev->evbit
directly before registration), any EV_SYN/SYN_REPORT events sent before
registration were dropped by is_event_supported(), leaving those seeded
events stuck in dev->vals until the next SYN_REPORT after registration.

Always accept EV_SYN in input_event() and input_inject_event() without
checking dev->evbit so input_sync() flushes dev->vals as intended.

Reported-by: Karlos Abel <kabel@voidship.net>,
Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Acked-by: Jiri Kosina <jkosina@suse.com>
Link: https://patch.msgid.link/asx50uz6iafsyAd5@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 1cca6d48f5977..3e6af517c596b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -391,7 +391,7 @@ void input_handle_event(struct input_dev *dev,
 void input_event(struct input_dev *dev,
 		 unsigned int type, unsigned int code, int value)
 {
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 		guard(spinlock_irqsave)(&dev->event_lock);
 		input_handle_event(dev, type, code, value);
 	}
@@ -415,7 +415,7 @@ void input_inject_event(struct input_handle *handle,
 	struct input_dev *dev = handle->dev;
 	struct input_handle *grab;
 
-	if (is_event_supported(type, dev->evbit, EV_MAX)) {
+	if (type == EV_SYN || is_event_supported(type, dev->evbit, EV_MAX)) {
 		guard(spinlock_irqsave)(&dev->event_lock);
 		guard(rcu)();
 
-- 
2.53.0




