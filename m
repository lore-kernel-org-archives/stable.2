Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795105302;
	b=E2erox8raNzHoDEl+CA9C+l6KFGB6nBRCXa9KtoG301Zo7r+tSpzpmyK3PyWldmwEFKp
	 TqLS0BInvdzwwJeMANqEgAw6NB82SqHT9guyuSWoNfA+l9BwyyfM6BsxizPo1ELZRGGFk
	 51GOM8TaoIFRuSRWfZxxR/UsSUzmFkOvNUQ0pZk2FzUNbmUejHGjt42MmdNjtukxc9ekb
	 J5i9vCwFnqGWROD7o7AyWEfGCMr4E/XxtzcJ2X0o9YacAYdnivTtlrOwC1XhVKLgGBrAR
	 tUUfIs0rNaj8iRJIODC0qMjIcy7hVXs+hB9HkcCcSpKWXDPyMbH6pmv3FSA9pNEJzWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795105302;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RpH3Eqg7iYrUnR+bT4B28VRSM1FxKzR8GEzsrCXC1us=;
	b=KrXVMNwWWP/tfI09TLnVNBRZS2T8gxhkNdCGhRW8QHANyGnN4c7rcSjD9Wt0BAGekWKz
	 eCaNjkPuKaJjiZ6nVC6OD8qe9yS84Zcuvj0dgmiYy0w1hsA6kJW4DqpZlPSIrmGO+qKJs
	 klJ3xcnK1Xur6UUgSVYWiZUcM4D+nkGhvKra0HW7XmEWJwOYuKHN/lOgxRzuKyDddhks5
	 2g/6s37/bs6dEbnfvamc23PqnDtlZtKymXIf9uwpYjQ+BwVwfj73tXB9Kv1hdk4ApS65j
	 FupHKFIx0yuyWJZu104QTjwYZvvyLH6T50l9LubzZ13+q06OjwZ2tgvrvP1IQA3Y6FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LkLOlVSO;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E7606A33F;
	Thu, 19 Nov 2026 16:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243E7606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=LkLOlVSO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795105300;
	bh=RpH3Eqg7iYrUnR+bT4B28VRSM1FxKzR8GEzsrCXC1us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LkLOlVSOWuugqGm+EA4GX7dW2frbpVRp8g6BGWVcc/jVmA3642huRIW7DfUj2gd1P
	 HRzxn+rPCIR5fO3HcEQg63YI8+KxbkKw5k5+NvXy8+mIo+xlkCQH4rf/WyiQe0MydF
	 GlTTl6Uu8geQh3C/M+3WXp45JU3qoOtyNyhS+38wprTlT/ShN4pDu6eKJRtHncd5M2
	 rZv6jusekbVIY/1Vz1sLcQ4sLmzBQikak0ZoLzUmqLS+DHeMWREggm6vBMm3ZfK8bf
	 SLO72bDdrsnXKCpCW8mP4ovGMDDEeShVOFMMUpSB3FOqbaPWuPRMUv1Ia8PniOU+e6
	 FnKx96gX2w1dQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVkHm3wBhzSSm;
	Thu, 19 Nov 2026 11:21:40 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 05/17] sched/deadline: Refuse dl_server debugfs writes while the rq is offline
Date: Thu, 19 Nov 2026 11:21:26 -0500
Message-Id: <30870826885d7aa42b641d23701066e03b1a2b9b.1795103339.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
References: <cover.1795103339.git.mathieu.desnoyers@efficios.com>
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

Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
for offline CPUs") refuses a write to a dl_server's runtime or period
on an offline CPU. Its message says that such a write has no meaningful
semantics.

It tests cpu_online(). But during hotplug the CPU is still online while
it sits in the default root domain. This lasts from the rebuild in
sched_cpu_deactivate() to the offline, and from the online to
sched_cpu_activate(). That root domain does not count the server's
bandwidth. A write in the window still goes through admission. With
admission control off, it changes total_bw there. On v7.4-rc2, a write
of the current value divides by zero in that window. The previous patch
removes the division, not the write.

Fix this by testing rq->online instead. It is set under the runqueue
lock when the CPU joins a root domain that counts it, after
cpu_active() is set. Test cpu_active() too. On the way down, it is
cleared before rq->online.

A write now fails with EBUSY while the CPU goes offline or comes
online, as a write on an offline CPU already does. Writes at any other
time are unchanged.

Applied without the previous patch, this patch alone also stops the
oops. The reproducer survives 20 rounds with no warning, in 3 VMs of 3.

Fixes: d741f297bcea ("sched/fair: Fair server interface")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e6a3b516c703..ddb382df454b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -410,7 +410,16 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 			return  -EINVAL;
 		}
 
-		if (!cpu_online(cpu_of(rq)))
+		/*
+		 * Refuse the write while the runqueue is offline. This
+		 * includes the windows where the CPU goes offline or comes
+		 * online. The root domain then does not count the server's
+		 * bandwidth, and may have no active CPU. rq->online is set
+		 * under this lock when the CPU joins a root domain that
+		 * counts it. cpu_active() is set before that. On the way
+		 * down, cpu_active() is cleared first.
+		 */
+		if (!rq->online || !cpu_active(cpu_of(rq)))
 			return -EBUSY;
 
 		update_rq_clock(rq);
-- 
2.47.3

