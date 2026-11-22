Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340652;
	b=qMcbLEMoIhGjzYqhPGNybZwlu6LuacaAUgyRAmlCvCHkr+tOLhgdigRXEB71RBQZAeM2
	 zQ0w8080LlSrBtpw0p1yqBLLtLuNUsYUG2B9KKU0OH8Zp0aWZpvc+aCyndBz1qzhcOamy
	 9WSHWUQJ/qbPV1p2S9SJkmAWR3+1r9ovqN917N8QPqCVgwaIR73O9sgJAgVaMWAaJ2l/q
	 IQlXiXivB3y5FUzj9hhfsx5JNaba9PL5QBvVZG8K3k7gN7n/F49xmO67GvRnq8gJzsxfd
	 7vRypVgqh1dqM2s2rJOiz7jgAbc4j172SQnt0r3OpzzGl1lvjF8hdhT5nWKWa3E/LqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340652;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ondTaIIXin5v9jdtiVVpkXFVJQmH5LSnfZ5orZJV4pw=;
	b=UWO+H1TPUyQ5zoE8Nv1q7cV+2CCzUJSn8LUPG+b3j1WWI+RbX19lcXdrNrVc6e5gK+jq
	 gXgZ/FESmaRAKKsI76Ln6ci3HufSqaMnUNudXoS9jR/bIzC8nJHHLZD6CDUiYId32Z1Rk
	 aWe4kF2Y+xrEV6o7a8RV/rUA0PVDv+VOZGhnBd9gq28tHLrg6j3k1050cmWoY8B4VYG/H
	 GzQxSNM2e5xWfDO2z5VRp3E/Q/+1RtVtajrPhXbHr/nNjJGV9F81VpRJAJzlOHQiu1kmb
	 v8gfgQDbZi/oAtt6itbkASALsJAmsPXuOJW8reRiOqNLK0abJTy8xWfdV/bi4AtTwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuBkk6so;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB10606A331
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuBkk6so
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19331F000D4
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 09:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340651;
	bh=ondTaIIXin5v9jdtiVVpkXFVJQmH5LSnfZ5orZJV4pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BuBkk6sob/LD6z7GbOwvK1VrvDFCqbXJXDUWC9CerFpWYXg2EJEOA1aMts3rZY48k
	 Yk5b9FHgOrgUQfF02OciMeYFZzrpaDR6yWvyOAv44itkLHCvq7VKNSvgky18Ikztfp
	 pWQbz8mRREGnoe9gMqtjlhnQNjAPPLKD3ENoTtzl/s9sQy21WA4EL5ua015D2bUnjd
	 FvJZ7ySORrN7dBzI29hWZN5J08B9yBjoX2wzKeYmw0urBnQQ5g/C3ktLqzkagFsE+b
	 Mb01PsO9o8TOfYzjcCRu63GX/v29i/G+N8l6chCnfrpDICnW5qehgn4ECgV7V0PYaK
	 zxpd9xlIij17A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so2049987e87.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 01:44:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE+n8MXMXEcrDWURX0tH+u5sPz6srtPF1TrmBPcpcexaYbfdsrgZY5mlKk1djg0ZGpeWQKMGeM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iaJBL5R7y3qX6+dBzACpVw2ZQe8SRK5CHUAH4hpfHXUz2wj9l
	hvEzidIz6VvUsgeZQcFCFadUYuLL7cven8j/fiKgVsOfWZHluVc2LwEKb4BSph+blmFQ9eopcnx
	zTBILLKg18B5v8N6FujjovG1KPB3+xmg=
X-Received: by 2002:a05:6512:340e:b0:5c1:b27f:81b3 with SMTP id
 2adb3069b0e04-5c1bc84bdcfmr2370010e87.41.1795340650308; Sun, 22 Nov 2026
 01:44:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118033225.1212442-1-wangxiaolei01@kaihong.com>
In-Reply-To: <20261118033225.1212442-1-wangxiaolei01@kaihong.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 22 Nov 2026 10:43:58 +0100
X-Gmail-Original-Message-ID: <CAD++jL=jN7=30r14jgyQsqLgW_sbjxmM392GE=6XmFHTbUXhBg@mail.gmail.com>
X-Gm-Features: Aa3M54ouVxjkRk2jr8m2jAT-UsPmm8R3vdK9FXVq1CjeCyp5g0cMA8Ig-_UwC7s
Message-ID: <CAD++jL=jN7=30r14jgyQsqLgW_sbjxmM392GE=6XmFHTbUXhBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: use GFP_NOIO for SD cache flush buffers
To: Xiaolei Wang <wangxiaolei01@kaihong.com>, Jens Axboe <axboe@kernel.dk>
Cc: ulfh@kernel.org, cw9316.lee@samsung.com, avri.altman@sandisk.com, 
	shawn.lin@linux.dev, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiaolei,

thanks for your patch.

On Wed, Nov 18, 2026 at 4:32=E2=80=AFAM Xiaolei Wang <wangxiaolei01@kaihong=
.com> wrote:

> sd_flush_cache() is called from mmc_blk_mq_issue_rq()'s REQ_OP_FLUSH
> branch, which runs in the block layer dispatch path with the queue usage
> counter held.  Both it and sd_write_ext_reg(), which it calls, allocate
> a 512-byte buffer with GFP_KERNEL.  Under memory pressure that
> allocation enters filesystem reclaim, and reclaim may submit I/O back to
> the same request queue, closing a cycle against queue freeze:
>
>       CPU0                              CPU1
>       ----                              ----
>   lock(&q->q_usage_counter(io));
>                               lock(fs_reclaim);
>                               lock(&q->q_usage_counter(io));
>   lock(&q->elevator_lock);
>
> lockdep reports it on an arm64 Raspberry Pi 5 that boots from an SD
> card, with the flush dispatched by blk_mq_requeue_work and the elevator
> switch in another thread:
>
>   -> #2 (fs_reclaim):
>        fs_reclaim_acquire <- __kmalloc_cache_noprof <- sd_flush_cache
>        <- mmc_blk_mq_issue_rq <- mmc_mq_queue_rq
>        <- blk_mq_dispatch_rq_list
>
> blk_alloc_queue() declares this ordering explicitly and teaches lockdep
> about it:
>
>   /* Teach lockdep about lock ordering (reclaim WRT queue freeze lock). *=
/
>   fs_reclaim_acquire(GFP_KERNEL);
>   rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
>   rwsem_release(&q->io_lockdep_map, _RET_IP_);
>   fs_reclaim_release(GFP_KERNEL);
>
> Taking q_usage_counter(io) and then entering reclaim is the reverse of
> that contract.  GFP_NOIO drops __GFP_FS and __GFP_IO, so neither the
> lockdep dependency nor the writeback that could resubmit to this queue
> can happen any more.
>
> sd_write_ext_reg() is also called from sd_enable_cache() (probe) and
> sd_poweroff_notify() (suspend).  NOIO costs nothing on those paths: the
> allocation is order-0 and 512 bytes, and reclaim without writeback is
> still available.  Keeping a single gfp flavour in the helper makes its
> semantics independent of the caller.
>
> Fixes: 130206a615a9 ("mmc: core: Add support for cache ctrl for SD cards"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>

The analysis appears to have been done by an LLM because it would
take a human weeks to do this, and since you are doing other patches
on parallel I think as much is clear.

That said, the code checks out and the fix seems right, though ideally
I'd like a block maintainers ACK on it as well and I think if you fix
issues like this Jens A need to be CC:ed.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
