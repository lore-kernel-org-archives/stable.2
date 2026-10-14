Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A3477E2E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960373; cv=none; b=rR9SD3pjp9CAfV/Ov0MLjRdUx33olsNPeZjApXgefjm+FLLMgkrP/Drj/LYCp4aD/1GfTF/tY4T+N5F0nLHxMeMuPLMWA6swGUm50MeOqfA9Rp+oZNWLaSoDes0bTHnskLqKSWdppUKlz6PuWoHr/F6/PmSJ1W/3E5KoiiM+2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960373; c=relaxed/simple;
	bh=Rvxc0ctCvKCcwUtqu+Shc59yyoETx391dL9BNPBy2oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p36oUwXpdEZFoGnXSa/ISqIc+gaHaee9W1dAgZl7pYzlqP+YA5Sfcg42ebvDYytEMLPVyxkOjPAV4UgqX7f6EiivUDlHmrb4UUZvrfAd+gNWgS8o36dYrmTTWHf1fZRJdrdtMpmQ0TZBNnb49F+gxPv1z3XYCC7waweckVu3av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKBOCpSh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKBOCpSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791960364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=;
	b=RKBOCpSh5j4Bz9X/O+Z9+geQw4wYeX4w5mgv4gUl9o9kDcMgJytnPFMf6al+j4BddNefR8
	6ShkxytFzgcQP1VnqKG5GnENaTi/1EAVH/s2NgmLVp5neqA6KU7htWWgDgEP6kemlSYcMW
	E7PZXUo9ItqG8m+uX6POkMQanWhwXec=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-MxfC6BBbP0ycHaM8okxLuA-1; Wed,
 14 Oct 2026 06:45:58 +0000
X-MC-Unique: MxfC6BBbP0ycHaM8okxLuA-1
X-Mimecast-MFC-AGG-ID: MxfC6BBbP0ycHaM8okxLuA_1791960356
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07728180034E;
	Wed, 14 Oct 2026 06:45:55 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC69C1800345;
	Wed, 14 Oct 2026 06:45:50 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Seiji Nishikawa <snishika@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Wed, 14 Oct 2026 15:45:24 +0900
Message-ID: <20261014064524.4015025-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eec983c0ead..4b775e22d3cc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1433,9 +1433,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	do {
 		bool pending = false;
+		bool got_send_mutex = false;
 		int result;
 
 		if (mutex_trylock(&queue->send_mutex)) {
+			got_send_mutex = true;
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
@@ -1450,8 +1452,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
 

base-commit: 5755f1bd0217ffe3c5cf85467bf6b0680f398265
-- 
2.55.0

