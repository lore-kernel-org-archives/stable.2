Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046439;
	b=JJVeK0kCl8M9qZQ9RIqzKthURmUxeh2k6C/+H/ADAJezediUQz5gVIaX/rTeLa/ca6oV
	 MEU4pcAy8Z0Y48/2IRNDytUZOXzAQCb6vL9g+tq2Ie4FK/J4Xa6cz5EehucwFERHa4WDa
	 /BlDJPNiapf/PwT0lhmT2HMBPzd8bOQqRpJCRDklHiS/GLIQ8Jf8+s9JvwN55FR4Zl0St
	 oRL8CAUh5SJPDbRtFnoTbyBF9kqLg/VYh4f5vl3y9ebbfEqOLkk190ZdBaGYKSr9fGsGu
	 j55YpUvO8FkPEsyvAVCXNkOvHr4N91PHZIXc/J/jgDIUTtS4TYt4q3UZ8CckfzwlD2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AbX1MvO3u3KbLjbme2Eldkr1FEnQlugn03K9LKjNClg=;
	b=hk+qC8gjlM+lK6xOEAhujMdNk0eMWpLew724DSYxrYdA4HO8JqanTzLy4GwTHx8ehJjm
	 euZ+VAWypAsKjjHoOY3tHNZquIgLYcvos1+iRfeJMhCr7hmgxZ4O35gN78XvRPD9C16ha
	 WLbOmZdGl1Z1+yBIDMBLZt8PD4priFOtj2J8P1S7NvvGsYjtUvMBit8ZVi72NiaySiSOo
	 0HwjOJlPb4vbdEdLtF7W7FSyY5mT6NHAJnXEbQ9a/sNtAQuy1jXAKDD6YBWI2dcnrRHCP
	 /X1br4iNrkV8KK+iSTlGPMzIXNSfGtHBA1E2ElJhkHYlKUKz5ddpiaMGz0brJav6pPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6MQ9yiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A480606D80D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6MQ9yiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA6C1F008A2;
	Sat,  7 Nov 2026 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046439;
	bh=AbX1MvO3u3KbLjbme2Eldkr1FEnQlugn03K9LKjNClg=;
	h=From:To:Cc:Subject:Date;
	b=i6MQ9yiWjdkT/8ltMaxphSvCx8YZcuD32qYRH7bNlIuu2ZBWT6Vax/kLFoQwN/Qkt
	 qTx33DZEw4kpU0K+S02IBrB92eTazERqH5zryIJE4hM8JTQCY7XK0qSAYJIDIYunRK
	 iZmATnscXAz7NaxSBR1s8RYZyTj031wYDuxoSPzmoc0WS+3XzLzLmHfF9QtGDkS95t
	 dYpCQr8hGnlni3sfmxcd56kfsJGsuZasWz4jEeHJkE4ZC0/M1Fb8Jy4w3ebDHcMD+s
	 fGSSjuBPubZOWzK53y7c6uWoSF3C/8LdoehqXU8cK792GJ8jX+C1QL7ZXNKq1rc5cc
	 rbBFpqLBj9NAA==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	tglx@kernel.org,
	shawnq1@163.com,
	jstultz@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] timekeeping: Require permission to set auxiliary clocks" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:57 -0500
Message-ID: <20261107051357-failed-6.18-524d95c8a200@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 524d95c8a2000cba6cb80a173d76cb746c561244
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051357-failed-6.18-524d95c8a200@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 524d95c8a2000cba6cb80a173d76cb746c561244 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Mon, 19 Oct 2026 17:03:24 +0900
Subject: [PATCH] timekeeping: Require permission to set auxiliary clocks

The generic clock_settime() entry point delegates permission checks to
each clock-specific callback. aux_clock_set() does not perform one. Once
an administrator enables an auxiliary clock, any local process can
therefore change the global clock offset.

A test process running as UID and GID 65534 with no effective, permitted,
inheritable, or ambient capabilities set CLOCK_AUX0 successfully, and a
separate process observed the new value. The same process was denied by
clock_adjtime(). An AppArmor profile denying sys_time also blocked
CLOCK_REALTIME changes but did not see the auxiliary clock operation.

Call security_settime64() before mutating the auxiliary timekeeper. This
matches CLOCK_REALTIME's permission model, enforces initial-user-namespace
CAP_SYS_TIME, and gives LSMs the settime hook while preserving authorized
clock changes.

Fixes: 60ecc26ec5af ("timekeeping: Provide time setter for auxiliary clocks")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: shaos <shawnq1@163.com>
Acked-by: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261019080324.4147815-1-4ncienth@gmail.com
---
 kernel/time/timekeeping.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ea2e6e55f37bf..1b342825bd8f1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/loadavg.h>
+#include <linux/security.h>
 #include <linux/static_key.h>
 #include <linux/stop_machine.h>
 #include <linux/syscore_ops.h>
@@ -3215,11 +3216,15 @@ static int aux_clock_set(const clockid_t id, const struct timespec64 *tnew)
 	struct tk_data *aux_tkd = aux_get_tk_data(id);
 	struct timekeeper *aux_tks;
 	ktime_t tnow, nsecs;
+	int ret;
 
 	if (!timespec64_valid_settod(tnew))
 		return -EINVAL;
 	if (!aux_tkd)
 		return -ENODEV;
+	ret = security_settime64(tnew, NULL);
+	if (ret)
+		return ret;
 
 	aux_tks = &aux_tkd->shadow_timekeeper;
 
-- 
2.53.0




