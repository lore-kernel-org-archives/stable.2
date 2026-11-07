Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046489;
	b=IpPNlzURffFxjbz5q8aJoXpqH4j8rc/eeyWA0roKHhGBP44M30AU0tGf6VsrmXwGNaBm
	 xOvcuHYfKX0IdWE4ioi8UvjEaL5ACBj0wJURsDwX5bRZJ3mmaTtw1oKEvWjImwyZ5e61C
	 n4SFULTLHeBBWJM/+TGBGlsPTVcHAMTkruU5FIemdZzCLjw8Xbj+3MNZm4xWIjzG+Bq3S
	 MXSG7mBvkPd9KTCK4C/jG6l5PmZBaP07vHSym02aOqyj3oFBgILHkz4FD2LfWy4GNDP8Y
	 Mr25Nie51KrwLAGMHvB8CutGnPfLZyI6yUI3LDWAPVORf3Ys4SN4bxpAXB0oN4jHwVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=M/G8xwc0e/WpcwcY0zfnrQgR0EgYRevWrPf/TXL0PY4=;
	b=PKbWka+2edYk1azGXXierOnR+vtOFpgd3OLP20JLRSxTuY8oOgICIzioCpndtPIhPrn4
	 /DISUS+L0dr0Qi/3J5QvUpEc8Wit2/wcPk1SrdX34J5hUWwRZue81gqgdx7s5JAyCE38e
	 MBCcqD2KiecmqxRV5H+KtV0zFXSqHI6P4UAbBqjldwEW6buiPdDtt6/LAm9Fd/ZKLpNmF
	 cZu2z6CiCxEvpRuwlQk4qSECeo/dyAZi3oua/8pz4aLdywfLDFTyqHl/iKSKsY4CmLl9M
	 1RjxkId7BQ2YT1k6MpQF0tjJXvz1AV9eu7bD2cLokD2DoQfP2SZleYT81+HJzuin/ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGb0P4gH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FC606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGb0P4gH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9FE1F0089F;
	Sat,  7 Nov 2026 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046489;
	bh=M/G8xwc0e/WpcwcY0zfnrQgR0EgYRevWrPf/TXL0PY4=;
	h=From:To:Cc:Subject:Date;
	b=KGb0P4gH6SgwPst7By7HpbnQUCZk7Q8G64nuYIwgnkE0bEB+7MB7yjQTKYUIAI/Tz
	 wB8TzBk+z36TOQ4E+17KMsZSzLp0ACtLpjSj1PufZSHvfnHXHhvV9BrcTatseHomix
	 3Qs9gTanXpU92TVtjzuK2bhiS352GVbWEw42mBxD9A8lJkN1mq4BxjY3proTvJXolH
	 WvQvopTV+4Sx2dZ7UTcHvEzm83JNuWgbjdBOl6PbWL0IY9aRutbA1JitCLuZrTKwMf
	 WIGPYT3yikGYD7WPPR3CEA1E0qhbRnApr8XsUrZ34Ya3fbdfCJKg50o+iFqIoN2xr0
	 VgIfpmxqXWlXA==
From: Sasha Levin <sashal@kernel.org>
To: peng_wang@linux.alibaba.com,
	frederic@kernel.org,
	herongguang@linux.alibaba.com,
	tglx@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tick/nohz: Reevaluate the tick for kicks flushed outside hardirq" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:47 -0500
Message-ID: <20261107051447-failed-6.18-e389ae428847@kernel.org>
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
git cherry-pick -x e389ae428847a2e6a3b698b5967df68ccf90361c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051447-failed-6.18-e389ae428847@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e389ae428847a2e6a3b698b5967df68ccf90361c Mon Sep 17 00:00:00 2001
From: Peng Wang <peng_wang@linux.alibaba.com>
Date: Fri, 23 Oct 2026 22:51:00 +0800
Subject: [PATCH] tick/nohz: Reevaluate the tick for kicks flushed outside
 hardirq

The nohz full kick relies on interrupt exit to reevaluate the
tick. However, a remote kick can also be flushed from task context without
an interrupt exit guaranteed to follow. If a tick dependency is set or an
earlier timer is queued after the idle-exit reevaluation, the required tick
update can be delayed until another interrupt.

Reevaluate the tick directly from the callback outside hardirq context.
Keep the existing interrupt exit handling for hardirq callbacks. The
offline flush remains harmless because tick_sched_timer_dying() has already
cleared TS_FLAG_NOHZ.

Fixes: 4b44a21dd640 ("irq_work, smp: Allow irq_work on call_single_queue")
Fixes: a5183862e76f ("tick/nohz: Conditionally restart tick on idle exit")
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
Signed-off-by: Peng Wang <peng_wang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023145101.8217-1-peng_wang@linux.alibaba.com
---
 kernel/time/tick-sched.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6c3fea3867139..baa3ac9b48f88 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -400,9 +400,21 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
 	return true;
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts);
+
 static void nohz_full_kick_func(struct irq_work *work)
 {
-	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (WARN_ON_ONCE(!tick_nohz_full_cpu(smp_processor_id())))
+		return;
+
+	/* Task-context flushes may not be followed by an IRQ exit. */
+	if (!in_hardirq()) {
+		if (WARN_ON_ONCE(tick_sched_flag_test(ts, TS_FLAG_INIDLE)))
+			return;
+		tick_nohz_full_update_tick(ts);
+	}
 }
 
 static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
-- 
2.53.0




