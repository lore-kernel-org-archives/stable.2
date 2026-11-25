Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596644;
	b=YGTcF8uepfwFk9tT26wxRmwRTA4zb3/XhTjXEGafjquPgHuXWtB2+GGFCcnjxJhhRJqe
	 x5q1s46I7ok0hI3Nj6aGLYxP6BhalugA7GIDDRfr0/iCiny0llna+xFZRmY85M+fAsKr1
	 jUeplS00Gl6mgfmxmlhfJozxAVpMYKSSZ4ZHA+laZwUFbakMHO43Epmcontof2cyRAjSD
	 9y0M40sHCQXahOGCaJtMFuVgVsZA9rY1NdA0g2Th4tMcm5N87YdxKoCO9dRus7d79LroZ
	 cPLJWNhntEWz2P0E7oMovNblBj3MDkTrb4C4FGXYVaWSkBvfZFDkGcrVW5XzxAxj8Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596644;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5laU9I0S73+AGD0F4yDxMMUy92egq/eFll50tQZJnfI=;
	b=fr7UZNp6wZhN4y81t5h34Kle/M9Y4jovGVlBEJQaO++z0wtamc6iBBPU3EF+e4I3xHOp
	 FfaimnGa9hBY7d+TKgBw39QcR9s4vxT04KuyHwPjY6QHfOnjHm5XmugUKBJLf5dzQZsm9
	 RXJjY9xd2tUH0TTK0n7N+nHt77RN59p2Eja32U64CJF20YJZqnwlEUSoIf5eJnmtuZ60N
	 skromCZcXYJSbUavSbEz39Ik6oNBM8+MRLUNJ2Mmh1A3myz4c13WuTuEcD+Z2UOMiFzn7
	 pfk02j7AqWAcT9xr+FPRVeIxqRaS+7inHxE+Z1KfAitt6s9yYrYHGh/PqWiAAOCrbYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="dbwFxg/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CAC606A331
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dbwFxg/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8211F000C4;
	Wed, 25 Nov 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596643;
	bh=5laU9I0S73+AGD0F4yDxMMUy92egq/eFll50tQZJnfI=;
	h=Subject:To:Cc:From:Date;
	b=dbwFxg/Yv0Vv7qpEPyzV5Cqh68vLTTBT+kztpB2RGdXLSBvq2ZEA4lQ9qjOv7vzEP
	 CwfF3OyQRpLywsfTU7J7C0BxJPNyl2Slefj1bNTZVxhjJ87yvglhwxCi128abZdddW
	 RRrz74kW6bl5r4rudoKkGkpHaTP5gxpGVgGQNq1s=
Subject: FAILED: patch "[PATCH] tsacct: Keep task begin times stable across suspend" failed to apply to 5.10-stable tree
To: dennylin0707@gmail.com,oleg@redhat.com,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:47:52 +0100
Message-ID: <2026112552-oversleep-submitter-9603@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x c49b3c20a2d0b22700e2100a527e68e829ece7f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112552-oversleep-submitter-9603@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c49b3c20a2d0b22700e2100a527e68e829ece7f0 Mon Sep 17 00:00:00 2001
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 30 Oct 2026 05:42:27 +0000
Subject: [PATCH] tsacct: Keep task begin times stable across suspend

bacct_add_tsk() derives ac_btime and ac_btime64 by subtracting a
CLOCK_MONOTONIC elapsed duration from CLOCK_REALTIME. MONOTONIC stops
during suspend while REALTIME continues, so querying an existing task
after resume moves its reported begin time forward by the time spent
suspended.

Calculate the begin time from the wall-clock boot timestamp and the
task's CLOCK_BOOTTIME start timestamp instead. This accounts for suspend
and adds the nanoseconds before truncating to seconds. Keep ac_etime and
ac_tgetime on CLOCK_MONOTONIC and retain the existing rebasing when the
wall clock is adjusted.

The new begin time can be negative: setting CLOCK_REALTIME is bounded
by CLOCK_MONOTONIC, which excludes suspend, rather than CLOCK_BOOTTIME.
A permitted backward clock adjustment after suspend can therefore put
the task's begin time before the epoch. Clamp ac_btime64 at zero too,
instead of wrapping in the unsigned field, and retain its positive range.

Fixes: f3cef7a99469 ("[PATCH] csa: basic accounting over taskstats")
Reported-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20130611200600.GA15168@redhat.com
Link: https://lore.kernel.org/r/alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de
Link: https://patch.msgid.link/20261030054227.35453-3-dennylin0707@gmail.com

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 5c153106e642..48320684c7c0 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -24,7 +24,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	const struct cred *tcred;
 	u64 utime, stime, utimescaled, stimescaled;
 	u64 now_ns, delta;
-	time64_t btime;
+	struct timespec64 btime;
 
 	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);
 
@@ -39,9 +39,11 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	do_div(delta, NSEC_PER_USEC);
 	stats->ac_etime = delta;
 	/* Convert to seconds for btime (note y2106 limit) */
-	btime = ktime_get_real_seconds() - div_u64(delta, USEC_PER_SEC);
-	stats->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-	stats->ac_btime64 = btime;
+	getboottime64(&btime);
+	btime = timespec64_add(btime, ns_to_timespec64(tsk->start_boottime));
+	stats->ac_btime = clamp_t(time64_t, btime.tv_sec, 0, U32_MAX);
+	/* Setting the clock back after suspend can make btime negative. */
+	stats->ac_btime64 = max_t(time64_t, btime.tv_sec, 0);
 
 	if (tsk->flags & PF_EXITING)
 		stats->ac_exitcode = tsk->exit_code;

