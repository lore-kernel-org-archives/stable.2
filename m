Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047265;
	b=UhbDNUFzmC3tFFtZpbUHJngM4NY8qtg6G1+XyTemINoRcPSGZowkYOB6bT545aQBVACi
	 NKNot+qxbf0hECkdPJwt53Qan1VpvPjeZFq60o1BAPlqZKGypCZLZ8x/Bx2jJcGP1Hf74
	 AOl/mnR8y/G9LSX0zl2LUNZwB3qtgEYB3r4wL6xDM+NXkG+nlmBSgyJxqLZoR4I8IXHHW
	 3vvuN/dMNVSyUr1yiFbUfiBXPa1hAA3M4xmR9Mjf7MMcGnVc7Z0nqI0fpk3UTf97N1Mma
	 NFs4AbqPAGGC3gUzU2NlVZdfgWl6s/Fz+hDTo/h8u8wIEWR9IKF4xT4md1LFCm399Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hSiCUa21YkgriRruF1UgOJDZSQ28TKXfIaF4xMsRBrM=;
	b=yIcvxZFIp8Hf2nBvgy2ZPVYFfwxbJU0Z0zU4B3ENkhUb+bFPf5dlf8pfVlvmksHtKvTD
	 u6PoUjTk60xnZ/p3O5XZOwkYTAOtnEsKDe3bJwIEmGVVmFT5IvVJkPvZv5DA37+1ZQw7W
	 o58wSST3gOHLyYOvjIYORWlJ/THSdNtgqsRH4n/qcbh7MO5uLpBXw0PrfGFQiP8swwr6N
	 XKkv0tnYLRpaZ520fWHr4rCN1SjwerKu0fuYUBD23GflBGmPf9LL6ZEbToghdxLmdx9ir
	 ADF03sIFuavTEowjDgoQkj4ikJrquPQ4LdwUzqayTT98ldP0y6pZG8kxQFu7h0HnkWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqsUNIgk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB95D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RqsUNIgk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586B91F0089F;
	Sat,  7 Nov 2026 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047264;
	bh=hSiCUa21YkgriRruF1UgOJDZSQ28TKXfIaF4xMsRBrM=;
	h=From:To:Cc:Subject:Date;
	b=RqsUNIgkV0bN4Z7BUsxOWd0V5UK08rkjktU7H8hlGmeqftXqbAqg4shKSEeM+XOR7
	 8y9eI3tZSjdna28+Ht8iTiwen3RIs9WY8k1fp9s7aIpd+TwVcSv33ghg/tvPjhPXmM
	 h4fFR4HST12KxpuNuGnVUGlCUq8f5xiBrBUtGhPi3WeHeEYXd0Q9gClcdiYIaX3qOA
	 rJ0gmi6caI+jpq4ngzQUxFsz0cHjTp3PlLi9+m7uZ2P+ty1hT4+jvzAhe4uIh0MB9o
	 rtOjOy5Cka8T5zBtredsiXkwlFO/rSIekS5n6fcAXVShcte/ulyJKtRBRYCXPaZm2X
	 Ldr90zbsgOE+g==
From: Sasha Levin <sashal@kernel.org>
To: snishika@redhat.com,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:27:43 -0500
Message-ID: <20261107052743-failed-6.12-5db358f3a7f9@kernel.org>
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
git cherry-pick -x 5db358f3a7f9c33717622c1597d15c4c91997b19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052743-failed-6.12-5db358f3a7f9@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5db358f3a7f9c33717622c1597d15c4c91997b19 Mon Sep 17 00:00:00 2001
From: Seiji Nishikawa <snishika@redhat.com>
Date: Wed, 14 Oct 2026 15:45:24 +0900
Subject: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is
 held

Commit f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
added a check in nvme_tcp_io_work() that sets pending to true when the
queue has pending requests and the socket is writeable. The check is
placed after the mutex_trylock() block, so it also runs when
mutex_trylock(&queue->send_mutex) failed and io_work did not send
anything.

When .queue_rq sends a request directly from its own context, it holds
send_mutex and can give up the CPU in lock_sock_nested() when another
task needs the CPU, for example the io_work kworker of the same queue,
which runs on the same CPU. Then io_work cannot take send_mutex, but
the requests are still on req_list and the socket is writeable, so
pending is set to true. io_work loops until the deadline and queues
itself again on io_cpu, without sleeping.

This is a priority inversion. io_work runs on the high priority
nvme_tcp_wq and cannot make progress until send_mutex is released, but
it keeps running. The task holding send_mutex runs at normal priority
and needs the CPU to release it. The scheduler keeps giving the CPU to
io_work, so the task holding send_mutex may not run again, and the
requests on the queue are not sent and time out.

This is the same problem that commit 70f437fb4395 ("nvme-tcp: fix
io_work priority inversion") fixed. That commit removed
"pending = !llist_empty(&queue->req_list)" from the path where
mutex_trylock() fails, and let the task holding send_mutex queue
io_work again in nvme_tcp_queue_request() after it releases the mutex.
The new check brings back the same behavior in a different form.

Two things make this easier to hit. nvme_tcp_queue_request() sends
directly only when it runs on io_cpu, so the task that takes send_mutex
is on the same CPU as the io_work kworker of that queue when it takes
the mutex. Also, when the tasks are in a cgroup with the cpu controller
enabled, the whole group competes with the nice -20 kworker as one
entity, so each task in the group gets even less CPU time.

We hit this on a 6 CPU VM running a database on nvme-tcp storage. In
the vmcore, 2 tasks held send_mutex of 2 queues and were runnable in
lock_sock_nested() for 103 seconds, while the kworkers for those queues
kept running io_work on their CPUs. All database tasks were in one
cgroup, which got only about 0.3% of the CPU against the nice -20
kworker. Requests timed out, and blk_mq_timeout_work() waited in
synchronize_srcu() for the tasks still in .queue_rq.

Only do the pending check if io_work could take send_mutex. If it could
not, the task holding send_mutex sends what it can in
nvme_tcp_send_all(), and queues io_work again after it releases the
mutex if requests are still pending, so no request is left behind.

Fixes: f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 191e5811d25ea..1f7a2de954197 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1461,9 +1461,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	do {
 		bool pending = false;
+		bool got_send_mutex = false;
 		int result;
 
 		if (mutex_trylock(&queue->send_mutex)) {
+			got_send_mutex = true;
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
@@ -1478,8 +1480,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
-		/* did we get some space after spending time in recv? */
-		if (nvme_tcp_queue_has_pending(queue) &&
+		/*
+		 * did we get some space after spending time in recv?
+		 * Only check this if we could take send_mutex. Otherwise
+		 * the task holding it sends the requests and queues io_work
+		 * again after it releases the mutex.
+		 */
+		if (got_send_mutex && nvme_tcp_queue_has_pending(queue) &&
 		    sk_stream_is_writeable(queue->sock->sk))
 			pending = true;
 
-- 
2.53.0




