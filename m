Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D9361DA7;
	Mon, 12 Oct 2026 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849124; cv=none; b=aDGIlW3PNGceDu4xXAJxDOW7J4HLuKazLOiUnn+Gup282Ats9udzFcxg8ubNACqHZ8FJMG43kpliHdgwJZ59aB+rNZ8irNJsP8x+eaYGrYjAe4HiWI9CYW7vt/mFvy54zeyf+RriichdPnaouUzH4JNV17u++Q+3MgzgKTw9XUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849124; c=relaxed/simple;
	bh=5KVnq2LLGoHBus7nXsCunp3AWiAf9UrDRK8F+p6YW1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQT7JJjqt+bKOezP2Khxk7mvI8HFAnTfntXSG7JEmcULT3F2I6Mo1ml9MHsdvWGCP9YQPB7maf/MOd/tx1+2AgljJtaiuzv0jLZ+OuBnlhu/AgKm3vN8RZ2T/9v936OYCgRB+Fk7BPVVD99u/UC1TCzHu3x8pFSI/fOXv/wM2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SaJbWh34; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SaJbWh34"
Received: from mac.lan (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 89FD320B7166;
	Mon, 12 Oct 2026 16:51:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89FD320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791849120;
	bh=QEjrch+u9y1UfmbvRcn1+TwHa77VbWv9PyJ4iRX+4FA=;
	h=From:To:Cc:Subject:Date:From;
	b=SaJbWh347RFJnb8F/M8G9R1qN9NG0HtZfFRbOxQXjIdZmYZEe5WyKar37534/Xtl7
	 LrH+YxccH7UipSrhdR2Z+MWM3Vowi+0lgaqJ5SOpg2ERDVs6sC9gh49xdFbvyiRpRI
	 btQk/tMs4XgRhqvpaF8EkENMG0HI4dL+f44ESzKU=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] posix-cpu-timers: Fix pid refcount leak in do_cpu_nanosleep() signal path
Date: Mon, 12 Oct 2026 19:51:49 -0400
Message-ID: <20261012235149.66531-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_cpu_nanosleep() sleeps on a temporary k_itimer whose reference on the
target's struct pid is taken by posix_cpu_timer_create() and dropped by
posix_cpu_timer_del(). When a signal ends the sleep, the timer is
disarmed with posix_cpu_timer_set(), but posix_cpu_timer_del() is only
called for a result of 0 or TIMER_RETRY. If the target thread or process
has exited in the meantime, timer_lock_sighand() finds no task,
posix_cpu_timer_set() returns -ESRCH and the pid reference is leaked.

An unprivileged user can trigger this: sleep on the CPU clock of a
thread, let that thread exit, then signal the sleeper. Each round leaks
one struct pid. Repeating it exhausts unreclaimable slab memory
within minutes:

  Out of memory: Killed process 150 (poc) total-vm:789292kB, anon-rss:484kB
  Kernel panic - not syncing: System is deadlocked on memory

Fix this by also calling posix_cpu_timer_del() on -ESRCH. With the
target gone, the deletion is safe. It finds no task either and only
drops the pid reference.

Fixes: e26d70d271ee ("posix-timers: Cleanup reaped target handling")
Reported-by: AutonomousCodeSecurity@microsoft.com
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
---
 kernel/time/posix-cpu-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0bf4fcd969c8..65cc612046d1 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1600,8 +1600,8 @@ static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
 		 */
 		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
-		if (!error) {
-			/* Timer is now unarmed, deletion can not fail. */
+		if (error != TIMER_RETRY) {
+			/* Unarmed or target gone (-ESRCH), deletion can not fail. */
 			posix_cpu_timer_del(&timer);
 		} else {
 			while (error == TIMER_RETRY) {
-- 
2.55.0

