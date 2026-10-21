Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597289;
	b=KObRY7Cd+rdBZ8lf6lTmRPFKIX/hI0IQORoqa9z5KEaZ7tmHHlF96RajHANQz1QSU6wY
	 BwNySK9i9hpEeoKgbNqo6Wrqq2s2IdBJ8nPDsMRWMWJeHHeSKh73AMiU3zhmwcoDChHxV
	 eRzDYWY8F1ZsUjOYB7i/gakZOzNcBvQ2vLo3/GW3xbPMH0EnSyr932NNKnb4n7XTC5zdb
	 H/+pWeMvIOjIzke32nPJ759f06hRf03+pz5/oaAGib52tdU8qqp4avbZ/8EpDxjItsB3C
	 n0DCYqeWaLVks47po+WgTt0AA4Gyex6j9jT4EdEf96grbubtTTnrm/kPXZ/g1keAlIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597289;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WZCtZ677LbeXmT/FvAupaobbEZpMxqdy5knY5FH1lG0=;
	b=CtCYAgouM+yX8ZB3eBHskBbGVYsfZlvv9g0tRogCRnSjIs3hQvYLCkXoPScHryHHcz7C
	 NeQJNY6mNElsBR4/t7GhBW/MfGPeQTWc4CKePucgfoYJMj7/lgcGxlUCPXnlMKIbSO+qE
	 qUCNGyg8eGBMx64H489G1jicNro5BmK5DURC9kFmlA3TPQEycPmkXYn30n19sF4peGKaH
	 rQTKSTqtRerplweVxHCKl0BcryIuAKztzXH5SDQhDhNMyAUXEn5Z8q94UputI4ekLMrta
	 nEsVL3wEamErrdZdDxpREtq96Eow/WIDWJbewjkc00yODghhO0EtQzW8ftF2Bf8b1tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KIwvX1mK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492D606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KIwvX1mK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E041F000C1;
	Wed, 21 Oct 2026 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792597288;
	bh=WZCtZ677LbeXmT/FvAupaobbEZpMxqdy5knY5FH1lG0=;
	h=Subject:To:Cc:From:Date;
	b=KIwvX1mK2h6fV/DQclDI3kb4V8CKWfgwTw+/xVM4/VooGIF/7SHCwCv1hhReXQbui
	 DeWv903Xjk8R9HlMJp6EThhfAMUIhyScOretlm0ZH0OUMSo1s+jfMrz5V+aaPSGuUW
	 4HvsX+3D7cNIBROIVqsriq+xsmKdcqEoe9+F7yO0=
Subject: FAILED: patch "[PATCH] s390/pai: Handle multiple PMU stop callback invocations" failed to apply to 6.18-stable tree
To: tmricht@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com,sumanthk@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:36:47 +0200
Message-ID: <2026102146-bonded-pancake-e5ac@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f3110e969ad226ffbb2d9b4bf5387e68d0d9ef40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102146-bonded-pancake-e5ac@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3110e969ad226ffbb2d9b4bf5387e68d0d9ef40 Mon Sep 17 00:00:00 2001
From: Thomas Richter <tmricht@linux.ibm.com>
Date: Wed, 19 Aug 2026 07:58:55 +0200
Subject: [PATCH] s390/pai: Handle multiple PMU stop callback invocations

Handle the following scenario:
The kernel protects itself against a very high sampling load and
throttles the sampling using:

  perf_event_throttle() --> PMU->stop()

Shortly later the scheduler may terminate the task and removes it from the
CPU. It again calls

  PMU->stop()

which results in two invocations of PMU->stop() called back to back.
Protect against this and check the PERF_HES_STOPPED bit on function
entry.  If it is already set return.
Clear bit PERF_HES_STOPPED in PMU->start().

Prohibit ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call for this event.
It sets perf_event::event_limit to a positive value and causes
perf_event_overflow() to invoke pai_stop() call back function when
perf_event::event_limit hits zero. This is not supported because the
sample events CRYPTO_ALL and NNPA_ALL are only taken at schedule out
of a task.

Use list_for_each_entry_safe() for safe iteration over syswide_list
in pai_have_samples().

Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index cdb8006220ca..05f74d74fad1 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -464,6 +464,7 @@ static void pai_start(struct perf_event *event, int flags,
 			cpump->event = event;
 		}
 	}
+	event->hw.state &= ~PERF_HES_STOPPED;
 }
 
 static void paicrypt_start(struct perf_event *event, int flags)
@@ -510,6 +511,13 @@ static void pai_stop(struct perf_event *event, int flags)
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
 
+	/* Cope with multiple invocations:
+	 *   1. perf_event_throttle() --> PMU->stop()
+	 *   2. task schedules out --> PMU->stop()
+	 * Check for event already stopped.
+	 */
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
 	if (!event->attr.sample_period) {	/* Counting */
 		pai_pmu[idx].pmu->read(event);
 	} else {				/* Sampling */
@@ -672,9 +680,9 @@ static void pai_have_samples(int idx)
 {
 	struct pai_mapptr *mp = this_cpu_ptr(pai_root[idx].mapptr);
 	struct pai_map *cpump = mp->mapptr;
-	struct perf_event *event;
+	struct perf_event *event, *e2;
 
-	list_for_each_entry(event, &cpump->syswide_list, hw.tp_list)
+	list_for_each_entry_safe(event, e2, &cpump->syswide_list, hw.tp_list)
 		pai_have_sample(event, cpump);
 }
 
@@ -691,6 +699,17 @@ static void paicrypt_sched_task(struct perf_event_pmu_context *pmu_ctx,
 		pai_have_samples(PAI_PMU_CRYPTO);
 }
 
+/* Prevent ioctl(fd, PERF_EVENT_IOC_PERIOD, ...) call.
+ * It sets perf_event::event_limit to a positive value and causes
+ * perf_event_overflow() to invoke pai_stop() call back function when
+ * perf_event::event_limit hits zero. This is not supported because the
+ * sample events CRYPTO_ALL and NNPA_ALL are always taken at schedule out
+ * of a task.
+ */
+static int pai_check_period(struct perf_event *event, u64 value)
+{
+	return -EINVAL;
+}
 /* ============================= paiext ====================================*/
 
 static void paiext_event_destroy(struct perf_event *event)
@@ -804,6 +823,7 @@ static struct pmu paicrypt = {
 	.stop	      = paicrypt_stop,
 	.read	      = paicrypt_read,
 	.sched_task   = paicrypt_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paicrypt_attr_groups
 };
 
@@ -1015,6 +1035,7 @@ static struct pmu paiext = {
 	.stop	      = paiext_stop,
 	.read	      = paiext_read,
 	.sched_task   = paiext_sched_task,
+	.check_period = pai_check_period,
 	.attr_groups  = paiext_attr_groups,
 };
 

