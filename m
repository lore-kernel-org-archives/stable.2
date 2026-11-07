Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055015;
	b=Sv7qlc3hI7xB9ULdU7A5HSmiYT20WhErJFydneXAHG03xX4pYhhVrpAhpg9VrzzGGu0J
	 iKwOeJV91Bf4Q04O2bsXEpqVDli/zLqs500tS3LCK89MmkNgtmm05/b+ggopYlK0zLZPp
	 ry+NyrpWVQfj3UZpwtJbE33DBUVlDczIXbOyAqCDsNry61YZom+mtiSXjjwzWpHunuFeo
	 OjNmB4sCprpTrP+XSXgJ/LNeDS9N+Uk/EnWgvMU/Isz71vUDQtVCQDuNV+KCeI20EsE6E
	 tWRgVkC/dPODe/6CHBu5bXxctuSXSfiKxXruYNxbsb5kfzrg7U+sriTJd7OWLdKtESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055015;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=8u99XbUTanP0HfUni1Sw5dV+IGmAUo+1HlzgOIYgtjw=;
	b=VHOfbJxvIcnJHI1MBMmTsukgBs3HUfrso737Rkdk6T4YaD5lSW3KPWg3unC+QwUW0J+5
	 t8WGQ1yGXYtK10BTg7fJyZ8/Kae+PSGfNPy8dgzv59pCUY4TkXCgd/6aowNUD4CTBDnY9
	 TFE92rSmu68/VwsZ9xf8Me3KvzVjNO8t5XhchdUDlPSntIc/ID2vEBoDVyLE0mlqvALZr
	 FcGlGJxEItvUVAigOThZFlK4awmIOlrJJ91vjyCSmCQDKLDFrgAdP6U4KmhFsOiiHVsAu
	 IBWAVfv38aS0VGc6+jmPFxl3rWEb4NmSj9bJRw/RDcP4aKYLmMsXlU8eeVsbEMeY2RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="f/BFYXiw";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEBCC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f/BFYXiw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794055013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8u99XbUTanP0HfUni1Sw5dV+IGmAUo+1HlzgOIYgtjw=;
	b=f/BFYXiwNBNqcrG8JGsLq5OuDMyfNFznOk7wpJ2dL8S6HpkG7o8mBta953gPvJNEE6jnzx
	CA1OGfmrywU5C6INsCtHNGcp1sHSBD7JdtlAYeIygQhncJ9WTtDLMB3UavDMPpkQ02uBl/
	SALQqn5cMqi+YczjZYwV92yy3qibZA4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-cLi9nGVEOjSbbvmskEb7wQ-1; Sat,
 07 Nov 2026 07:36:51 -0500
X-MC-Unique: cLi9nGVEOjSbbvmskEb7wQ-1
X-Mimecast-MFC-AGG-ID: cLi9nGVEOjSbbvmskEb7wQ_1794055010
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5994119560B5;
	Sat,  7 Nov 2026 12:36:50 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E39D144D;
	Sat,  7 Nov 2026 12:36:48 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: stable@vger.kernel.org
Cc: Seiji Nishikawa <snishika@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.12.y] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Sat,  7 Nov 2026 21:36:15 +0900
Message-ID: <20261107123615.516406-1-snishika@redhat.com>
In-Reply-To: <20261107052743-failed-6.12-5db358f3a7f9@kernel.org>
References: <20261107052743-failed-6.12-5db358f3a7f9@kernel.org>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
(cherry picked from commit 5db358f3a7f9c33717622c1597d15c4c91997b19)
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1a1a11671826..f0d33e3d065f 100644
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
 
-- 
2.56.0

