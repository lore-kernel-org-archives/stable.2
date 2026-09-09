Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945484FC8EE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949699; cv=none; b=mvdfEn4odfFER6DyBKwzzFUHJitvkHIuiegwzArxROlnGgD2n07s7V96pusnnJGAa0pRlnExrxL9cPKVuXxCbh6dRhoUxPhtHDJSTsfI86rp+DKBu1zZwKU17CUD3T0UZtGNbXLifybkXnT1Ce6CNC/IIcZ6YUlTKmJk5HRbcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949699; c=relaxed/simple;
	bh=oWl1IbBeGzOXBvW+gkEw66fdcOAiNKxUUN0PLpquOYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ownYAbb0N5rxU4T5ILOyIlQBDrhQfiOsf4WGv1CZBrKo5coO1o30obDcdEbaF/enhh+Ay6JFt/6eYi+x1tqY/MadbklUy9XwDe1zlJzmUDj4z13asV0QLfCR1LnOwvn14Z3CIuEmqgNK6YbxT4zYEic/Sac6dvWV1+OLSpaFRlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge99DUmN; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge99DUmN"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4843f205a5bso3676289f8f.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949696; x=1789554496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+gTlYU7hGG/guxF0SMaP8s2Fu3DSflO5FB45eTlUlE=;
        b=Ge99DUmNZpRYMiGdOb4f2a0NmYOSo2dm+ECsZ0UCFl5XVYP7d8wcSTitjuf+Qq+i/U
         OV2QbsEmXMCX602Wg9AoU3yqJu+CEVcOZUS1Dn7VhQXE8CWwut5ztVa3FDWHsZ4Alj7j
         E+l/jb/DCioArZhsSCHTKqMgrW4MgqdhHsCmjgi331nXWIJGguVrv/kDc3WB+MIaHhfF
         XTYJFbmGjCLR4FxekwdGWJjAvMLmskTEU0F0nq+OyvsGSQs0DeP1yYDZOULXTFnRIW9S
         raUfjGZj5vnMBGIJ7MiSHbJ7IgDk4PRrCwt9HIMpsTrU4z7E4UvQ20dv1rP9sFy0m9jh
         uHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949696; x=1789554496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+gTlYU7hGG/guxF0SMaP8s2Fu3DSflO5FB45eTlUlE=;
        b=gfdBCNxDaahLQd0Vb/YLnLNLkI/bnlaxpim1wAD7N7eegqvUAc6EG2driutuIaPrVB
         MPwg2QquJLyucIbyBK0poaeHJek+guM3s30WG+UG53i1bhxlWXCplD6P6t8Qq+soYfv6
         m2NnFBnG4DZU9h4WFP1DQ/xE1qshqP4k/HyleAEaYuteb8R22ILRfaIuO/J1erz5ee4A
         UtFuR/x2XhRi3q5OtCS3m2JOGXJS8KPN15Fy9r21K2hhvG7RV/S6Mxd7Gxs62PDe/XeV
         37SveX+v6nWmkE3dOH8Tr9L0uCVXjyg8kJnhQ7PwMMRNLt/qrOTKHjvGAKY2RQJj9BBu
         Rqwg==
X-Forwarded-Encrypted: i=1; AKwUvBzHB7DplhNjLsoizHO8QscpWiJk8i98U4jMBYWeG1Kl+6cKc1zr34UT/py4s6/7sKkEuTy8zx4=@vger.kernel.org
X-Gm-Message-State: AFuF++nD7tvcGo4msB/89ML3x0DFw3RhpPJy4xFWwntTI7jcFIddFY9a
	ExL3y5w5xjWZCYx0w/IJd/+iUD3JQKyhHJ/9384ZcPjrExg2IJNWPneH
X-Gm-Gg: AYBFou3j+HgRcLkbTRVzmjw/NCfl8AJHqZyrRgZxYP7wP9+v+1at3PoLaKkpEK7VK1r
	0gYxgxvTvR/ILi3Llsn5Tg1SbGq2Ol/sq7WVG0STp4vXogZnmOmOKy9z/uVXOLIIYWjbzdJ71kg
	m/WoavnhMolewJq+9x8MfFMWBtknhbQclU4SnMnAk7zzO4tFPa4+WFBGy2mNQq9rR1JaPn2mpiY
	npDMNHOcXASsRiGqyX/iqaY962b6t8qBHs+XmkSYxBNXec2JaDh+twfa/z80EG8dxZAg6nAw4Od
	D7+A/TGTWpOXqaExp/1vMgPpT4b0ZPnekteeuNC26bm5X6L5bNcK/rZT1a2ehzLUorgjHq3DVtn
	VQB2HSuP3LR4VQkR4r9sJKoJGGRNCaix9sBwoDLSoFOrX5MK7mWU3RzAt3a/UdU2pXMPvomTU2V
	pf/TITd1buI/FYp0f0X5wx8/OP82TkZWds5sVQ54zLeGCQ/4GwXDkSysj/7JY2Q78sg2qZ1AxCD
	ZwFhRYIkjE=
X-Received: by 2002:a05:600c:8715:b0:49c:fa20:cc06 with SMTP id 5b1f17b1804b1-49cfe7a30demr273506395e9.29.1788949695341;
        Wed, 09 Sep 2026 03:28:15 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.32.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc1be3sm22782285e9.4.2026.09.09.03.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:28:14 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] hrtimer: Use hard expiry when updating timers on the same base
Date: Wed,  9 Sep 2026 12:27:49 +0200
Message-ID: <20260909102749.7677-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearming a queued timer with nonzero slack can leave the timerqueue out
of order. remove_and_enqueue_same_base() checks the new soft expiry
against its neighbours' hard expiries, then stores the new hard expiry
in the node without requeueing it.

For example, with A at 10 and B at 20, rearming A at 11 with slack 30
passes the neighbour check but leaves A's hard expiry of 41 before B's
20. The same function also caches the soft expiry in base->expires_next
when updating or inserting the first timer, giving next-event selection
an earlier deadline than the queue head's hard expiry.

Set the timer expiry before handling the queue. Use its stored hard
expiry for the in-place ordering check and both updates to
base->expires_next.

The early update should be safe because remove_and_enqueue_same_base()
runs with base->cpu_base->lock held. The lock keeps the queue stable
while hrtimer_can_update_in_place() checks the new expiry against both
neighbours.  If the check fails, timerqueue_linked_del() removes the
node without comparing expiry values before it is reinserted.

Fixes: eddffab8282e3 ("hrtimer: Keep track of first expiring timer per clock base")
Fixes: 343f2f4dc5425 ("hrtimer: Try to modify timers in place")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
Changes in v2:
- Set the timer expiry before handling the queue and reuse its stored
  hard expiry, as suggested by Peter Zijlstra.

Link to v1: https://lore.kernel.org/r/20260907211134.3854-1-parri.andrea@gmail.com/
---
 kernel/time/hrtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 530d61257b9a0..af22a2fec4904 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1263,13 +1263,16 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 {
 	bool was_first = false;
 
+	/* Set the new expiry time */
+	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
+	expires = hrtimer_get_expires(timer);
+
 	/* Remove it from the timer queue if active */
 	if (timer->is_queued) {
 		was_first = !timerqueue_linked_prev(&timer->node);
 
 		/* Try to update in place to avoid the de/enqueue dance */
 		if (hrtimer_can_update_in_place(timer, base, expires)) {
-			hrtimer_set_expires_range_ns(timer, expires, delta_ns);
 			trace_hrtimer_start(timer, mode, true);
 			if (was_first)
 				base->expires_next = expires;
@@ -1280,9 +1283,6 @@ remove_and_enqueue_same_base(struct hrtimer *timer, struct hrtimer_clock_base *b
 		timerqueue_linked_del(&base->active, &timer->node);
 	}
 
-	/* Set the new expiry time */
-	hrtimer_set_expires_range_ns(timer, expires, delta_ns);
-
 	debug_activate(timer, mode, timer->is_queued);
 	base->cpu_base->active_bases |= 1 << base->index;
 
-- 
2.53.0

