Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758247;
	b=rQJGQeF1v9PwZj9kL2LvxSzJvqksw1vXXTaVsMQpWujtq/fjlxwO3jlMByTd7aYbuJPX
	 M8CyHf2GJGCSvtrd1Z/CpWA1OxAhxlGKXZCLP3FzGSDEZUrfKFhMwn4edNw4apAXqV91g
	 rPVQHmdx8HxAXF+Jce2YFuV0IMQpIaTn4jP+vkz6QFis1IMa+c0bpS9LnxeDBK1i9vHxE
	 5W3UhDjhzNBskDHbwRnW3bJ+IX8lSej3660FsXVMAQz0vRL0gcSDkY0BhavKgTNPL9rjd
	 +vNFhlOiFM2G0PspvUC4L61Ja1nwI/RBv+IMwaPEHBzSBw+8qQkxb9GZHLU4TqZ5LGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758247;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=;
	b=l9w+uB8UXLtxRynACcZWxXNEc0ikYcgLlNC5+7g1JrqIKdO433W4WqMbAWUYsOhazxFi
	 w9CffQv827wEUZGQDJI4ApUJup9eDw152rbhm/3cWAraiWzpckvH7Zrr8pYUW+3gzVsPW
	 y4yIjcd6ocUCkMv7TxbQQQynuZb7ue6eBT4zD/xS55rCH6tePGua78UkueFLuEyMK2I97
	 qH2xuX54nthFOemQQcsEyUyIM9Ni13QTS+JXomlpuH6dkqpTwfVA5BO24jB0fmFamOUUj
	 EvQ7u0t0A/wccsVBqX3jcFvp5M1r74uBgjSffzmnObGZsIXA+oa+k9YJfxqt7iJVxEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3OG11W2;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5768B606A33B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5768B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3OG11W2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792758246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x4CmADp2ir7n+E8mOlnp3JESSQ5fFcEi+jbhhp5rGtk=;
	b=D3OG11W2tfzJApe6HgDa8JeQO3boMaYXHZWNyHytVO2jn9V8+6qx85LubeM9JtCeyRJ4qR
	wZb1Krd6Hq//FtvUuEbLzXi0PjSTje1DgOCl+TDCtceArN2ALsoBPrvPu1tTVjywhUJWlV
	Ir9j1LESVTZr2p2uThnH+86WF3j6uoA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-CHJDW6xEMZqCQT8L7LpFbw-1; Fri,
 23 Oct 2026 08:24:02 -0400
X-MC-Unique: CHJDW6xEMZqCQT8L7LpFbw-1
X-Mimecast-MFC-AGG-ID: CHJDW6xEMZqCQT8L7LpFbw_1792758240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47B6E1944D26;
	Fri, 23 Oct 2026 12:24:00 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9E881800444;
	Fri, 23 Oct 2026 12:23:55 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Seiji Nishikawa <snishika@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Fri, 23 Oct 2026 21:23:51 +0900
Message-ID: <20261023122351.977034-1-snishika@redhat.com>
In-Reply-To: <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de>
References: <20261014064524.4015025-1-snishika@redhat.com> <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Thank you for the review.

On 10/21/26 12:10 PM, Hannes Reinecke wrote:
> On 10/14/26 8:45 AM, Seiji Nishikawa wrote:
>> We hit this on a 6 CPU VM running a database on nvme-tcp storage. In
>> the vmcore, 2 tasks held send_mutex of 2 queues and were runnable in
>> lock_sock_nested() for 103 seconds, while the kworkers for those queues
>> kept running io_work on their CPUs. All database tasks were in one
>> cgroup, which got only about 0.3% of the CPU against the nice -20
>> kworker. Requests timed out, and blk_mq_timeout_work() waited in
>> synchronize_srcu() for the tasks still in .queue_rq.
>>
> How very interesting. I don't think you could craft a blktest for this?
>

I do not have a reliable reproducer in my lab. Reproducing the hang
requires a particular sequence of scheduling events. The task holding
send_mutex is preempted inside lock_sock_nested(), a higher priority
(nice -20) kworker looping in io_work, waiting for send_mutex to be
released, takes that CPU, and then starves the task holding send_mutex
of CPU time indefinitely. The kworker keeps looping because
mutex_trylock() keeps failing, since the preempted task still holds
send_mutex, and the pending check (f42d4796ee10) keeps the kworker
running instead of letting it return. It happened on a 6 CPU VM with a
database under heavy load. So far I have only seen it on the customer
system, but there it reproduced every time.

>> Only do the pending check if io_work could take send_mutex. If it could
>> not, the task holding send_mutex sends what it can in
>> nvme_tcp_send_all(), and queues io_work again after it releases the
>> mutex if requests are still pending, so no request is left behind.
>>
>
> The direct send path again. I really wonder if we need it at all, or
> whether we cannot simply delete it.
>
> Can you try if you see a regression with this patch?
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ba5c7b3e2a7c..2c59b550e13f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -405,17 +405,6 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>          empty = llist_add(&req->lentry, &queue->req_list) &&
>                  list_empty(&queue->send_list) && !queue->request;
>
> -       /*
> -        * if we're the first on the send_list and we can try to send
> -        * directly, otherwise queue io_work. Also, only do that if we
> -        * are on the same cpu, so we don't introduce contention.
> -        */
> -       if (queue->io_cpu == raw_smp_processor_id() &&
> -           empty && mutex_trylock(&queue->send_mutex)) {
> -               nvme_tcp_send_all(queue);
> -               mutex_unlock(&queue->send_mutex);
> -       }
> -
>          if (last && nvme_tcp_queue_has_pending(queue))
>                  queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
>

I cannot try it where the hang reproduced. That is a customer production
system, and I have no reproducer outside of it. On the kernel with the
regression, that system hung within 12 to about 50 minutes after boot, 5
times in 2 days, under its normal database load. It has been running a
kernel with my patch since October 15 under the same load, and the hang
has not come back. With your patch this hang cannot happen, since
io_work becomes the only sender and the trylock in io_work never fails.

What I could do is a sanity check. On a 4 CPU VM with an nvmet tcp
loopback target I ran

  # NVMET_TRTYPES=tcp ./check nvme

on 3 kernels: v7.3 (base), v7.3 with my patch (seiji), and v7.3 with
your patch (hannes).

base    passed=49 failed=0 not_run=12
seiji   passed=49 failed=0 not_run=12
hannes  passed=49 failed=0 not_run=12
per-test results identical

The 12 not run are the same on all 3 kernels, skipped for reasons
unrelated to the patches:

      6     nvme_trtype=tcp is not supported in this test
      1     command tlshd is not available
      1     driver scsi_debug is not available
      1     kernel option KASAN has not been enabled
      1     kernel option NVME_TARGET_DEBUGFS has not been enabled
      1     libnvme version is older than 1.11.0
      1     Remote target required but NVME_TARGET_CONTROL is not set

This is only a functional check. It says nothing about latency.

To apply your patch on v7.3 I had to drop the !nvme_tcp_queue_tls()
line as well, since 08acb54b063a ("nvme-tcp: defer TLS inline send to
io_work") is in v7.3. That commit already skips the direct send for
TLS queues, so the io_work only path is already in use there. Two
small things in the patch. empty is set but no longer used, which
warns with W=1, and nvme_tcp_send_all() loses its only caller. I
dropped both in the version I built.

I agree the direct send path is the source of this family of bugs,
5c11f7d9f843, a0fdd1418007, 70f437fb4395 and this one, and I am fine
with removing it. But I think the two should be kept apart. This
regression is in v6.16 and later, so it is in every current stable tree
and in the distro kernels based on them, and people are hitting it in
production now. What stable and the distros need is a small fix that
only changes behavior for those who hit the problem, and that is what
this patch is. Removing the direct send path changes performance for
everyone using nvme-tcp and requires a performance review before it is
introduced. Also, it belongs in the next merge window rather than in
stable.

So I would prefer to take this minimal fix now for v7.4 and stable, and
do the removal as a separate patch for-next. If you agree, I can write
and send that patch with your Suggested-by. For the performance side I
can only test on VMs, so latency numbers from a real nvme-tcp setup
would be needed from someone else. If later performance measurements
reveal that the direct send is unnecessary, the check added here goes
away with it, which is fine.

Thanks,
Seiji

