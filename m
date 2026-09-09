Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A956511D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972786; cv=pass; b=tsmRnAwkDn7nd7S9mFT8phVX4PNSVE4e1y4MF0q92PUJTjpJygCPxem5yEU5ae5LUciS5AOl3d4LNMYnvpJvxUHKOGp70w9A2zzVwHyc0uXEO7p/TVlvY8oTW7qolTPj5Elts4JPsoMwLzxt6n/KyDRboK86bC2onPJv84rLXh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972786; c=relaxed/simple;
	bh=JksfCM6TD5z2NNv3uNjlCHRQ7TozmDLYV+m4f9unFU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7tMGpxy9UjfdoQLj6LoKERDDHKc7jDZ85XA9r2iyYZH+OJUBXn8ENXnrjFxN3KddgyWypskTcYQQ/eesPFxTlBiY7YxD2zw2nLBvU4WRVnNPYmWr10EZ1o4o8CPLqtLUpdYZhxYkRGmUQ5hfempHgnefbOtQTvI7N9t1w0omAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B3mxRDrr; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B3mxRDrr"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47c272605bbso41324fac.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 09:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788972782; cv=none;
        d=google.com; s=arc-20260327;
        b=SOpc7xFbz/Lu4CEwwJvSAeBGnJSQpjgjfJjchzWIwph9y/Qwmpo5tfP1FaRtTXkpul
         /pwb/WxN2V6LXiWYtPBjDg12nBBB3mJmY+YPs921F68T6WclKQia69N0X9oXW2iCsQHu
         SPzNG6obwkBfAOq1x5HT43I7ew9y0MPgKpHeoMDoEHXkw3nn4uvP/MEni8652k0occ7e
         U/bO1FoBDBjDXBggyypzhOszWKRIxFqk215DEezpYLUg4V50JuPV/vGfhkg4nC+5Shv1
         fymFhZNEou2T84+846SsoGXvzj4MEzmo1ElDv7s3MD+fdlPL4qUqHaeO1r3wjHCOJrxa
         5Epw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hUtXC3Uox1wNKVf/0hG2SPcwuS8kRkzxVDm8ywTWO7k=;
        fh=hQuvyoKEqJ6BvyzXEtgrJ3u42JlC/EqBvGzB6s/7gf8=;
        b=e+c7A7uWrB05iqAUVv6o8C8kUSxtf1zectyP5e8engYDEwh/A/Q+y9Xfi5ZbbpWEbI
         aWnDtppNsD54runL8XeLEXDvM5Izv5GTUVH5Grfr9NxhQBhRFSVzxCqCvGmlyh+f47vG
         Ep9k90foFIEivJ8ncKxqmNpjbWht72GPF3+lslw8Md/h1zmEFr23bla8italALhccvaC
         2NnRbr4s88nij76YX/nsramRqYswf9G/88gKoAkj2jfawl80yWTRh/qXUfwZnJqYW3Po
         EgUGL/Z9Xw4u48k42HX0WofmqBZKQkGcqfdT8XdkrjUKCLbcCvU0LpLoSmMuRGDM6pI0
         t5Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788972782; x=1789577582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hUtXC3Uox1wNKVf/0hG2SPcwuS8kRkzxVDm8ywTWO7k=;
        b=B3mxRDrrdw9NrzRA7aP/DNBSMIUQYQDMQ3vW/ELDd+3Pcyk8XM2jXNRyT7B8RGUL25
         Kbhj0730YvaukqscRSM1fp9VC+ddx0YV7UnjrpQfGGSB3i5vy53AR32FOjH9nRA6KFqF
         sQYKGx5rsA19uqHxGyatSVyBARah5i6/Y08yoygkZDE28GVGa92I6a8JN/8sP6JwR3bR
         ojEIBCmmjMVHIXsgl+izy/2HjjLB14rOB34Obj8CZFpcQGPeNaIOSsFLoe65qWT5GB4r
         0ZdaBZidTIHRLygUnlh5TSW1Sfw9gLZ1oYBoA6js5Ow4IB1t8stVS/tRB0TPktEJykvQ
         cYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788972782; x=1789577582;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hUtXC3Uox1wNKVf/0hG2SPcwuS8kRkzxVDm8ywTWO7k=;
        b=FkPtv6CBGQFvv+xdMdRTFO1HwfR7h0fuH7ZLPHIzUPF1cO98+oGigBonwDBBY4iYyO
         I+GtrRVme9m40BVFGz2qb4zuRkIeJiLUo4uu5iUNdgJrverxyrg1fByYjeU0FAgHGb0Q
         IZNafcVltTUpyC07da01vtr9YGp6v3NH4kJtCDoYAm0+Ilyy295t2+PRycMm8GjQGk3N
         Lplx731jQY7zQ2yUI8IPePdpW6i1M2efl1epQy2ZdqV/2gS23nLzXglmkGokwHTYEp1f
         Bk+gayMpc8TYQ+4gQmUGJDJwq2JyzhYcp+ABE5D5fLET8aRE4DwzsjMHC2WlyppKr5Db
         CIJQ==
X-Gm-Message-State: AFuF++mROroM5BUDjqu1T/XMwDqKQqvLyFm9heuo7zupxfwDsqNhOyhd
	HbJMMRyVn/14gSy34XLU0L5DtU2mQrUKAN3vl+qcjE9Es6KoeghTMcLHLsTZ0sAMGQ5v+64+0SQ
	412Tu2E9VX1/UnVTGH7psylBTjPPcuSUS0IanhK2evw==
X-Gm-Gg: AYBFou3QZvo3J65GZzNZo7Sw8NbOBm7Fph1FfqkRV2AL8/Swq3hqwvTLqi8O31Zz0yw
	LbvXTlvAL584G5CzkNv4W3aNND5hpMlBe8PannpV1bt/RHyHdRaruBJbmI82GjxEKya1mXTqewo
	3/96WKIrdy24xnkEfZuU9Q95uMHEw4vyUrsJ2Pwt/mqfkHO6uxpzEdCnTFS9Ihdkib5AOzlaVvl
	FfZ6IOKzpddEEvzSWn/y9YrRkgYMzcfGDUgBnqGYWkX1Ng79v6O1q5Hcpbmcuf0o65/Wy22pr0N
	Y7/R6B3bXLRnSEiGF811e02WYEuw/zjguNHoo3DtdFbN4HuQrAByDHw=
X-Received: by 2002:a05:6870:55d0:b0:47c:7e8:fa95 with SMTP id
 586e51a60fabf-47c908682ccmr333076fac.1.1788972782245; Wed, 09 Sep 2026
 09:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090345-dolly-jolliness-3485@gregkh> <20260909162719.2984896-1-sashal@kernel.org>
 <20260909162719.2984896-2-sashal@kernel.org>
In-Reply-To: <20260909162719.2984896-2-sashal@kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 9 Sep 2026 09:52:50 -0700
X-Gm-Features: AcwNN1Uo-BZSVAhmxqb5Y1pKclORVw68qa5oIhHa-bM3rXdRDbRbgEeIs8vebc8
Message-ID: <CADUfDZoOVT_geEKEt6M2KLoNYg+DqYc0tB9MPbgmyTnz3wvV_A@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 2/3] io_uring: add wrapper type for
 io_req_tw_func_t arg
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:27=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Caleb Sander Mateos <csander@purestorage.com>
>
> [ Upstream commit c33e779aba6804778c1440192a8033a145ba588d ]
>
> In preparation for uring_cmd implementations to implement functions
> with the io_req_tw_func_t signature, introduce a wrapper struct
> io_tw_req to hide the struct io_kiocb * argument. The intention is for
> only the io_uring core to access the inner struct io_kiocb *. uring_cmd
> implementations should instead call a helper from io_uring/cmd.h to
> convert struct io_tw_req to struct io_uring_cmd *.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> Stable adaptation for 6.12:
>
> Keep the request-wrapper conversion and supply the missing by-value
> io_tw_token_t interface. The existing io_tw_state is already empty and
> io_tw_lock() only asserts that uring_lock is held, so no locking change
> is required. Convert the stable-only token users as well, and include
> io_uring_types.h in poll.h and rw.h for the new typedef.
>
> Add the cancel member and initialize it from the existing
> io_should_terminate_tw() in the fallback, per-task, and local task-work
> executors. This supplies the interface required by target 14572de82e50
> without importing the unrelated task-exit or callback cancellation
> refactoring. Keep the stable futex cache and async-data cleanup paths.

struct io_tw_state's cancel field was added by commit 7be20254a743
("io_uring: unify task_work cancelation checks"). Can we backport that
commit as well instead of folding it into this this unrelated commit?

Best,
Caleb

>
> No functions are added. The target waitid patch applies unchanged.
>
> Stable-dep-of: 14572de82e50 ("io_uring/waitid: honor task_work cancellati=
on")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/io_uring_types.h | 14 ++++++++++-
>  io_uring/futex.c               | 20 +++++++++------
>  io_uring/io_uring.c            | 46 +++++++++++++++++++---------------
>  io_uring/io_uring.h            |  8 +++---
>  io_uring/msg_ring.c            |  3 ++-
>  io_uring/notif.c               |  5 ++--
>  io_uring/poll.c                | 25 +++++++++---------
>  io_uring/poll.h                |  4 ++-
>  io_uring/rw.c                  |  5 ++--
>  io_uring/rw.h                  |  3 ++-
>  io_uring/timeout.c             | 20 +++++++++------
>  io_uring/uring_cmd.c           |  3 ++-
>  io_uring/waitid.c              |  9 ++++---
>  13 files changed, 100 insertions(+), 65 deletions(-)
>
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index 6d47d0d3fde01..1d32c66a9a052 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -422,8 +422,16 @@ struct io_ring_ctx {
>         struct page                     **sqe_pages;
>  };
>
> +/*
> + * Token indicating function is called in task work context:
> + * ctx->uring_lock is held and any completions generated will be flushed=
.
> + * ONLY core io_uring.c should instantiate this struct.
> + */
>  struct io_tw_state {
> +       bool cancel;
>  };
> +/* Alias to use in code that doesn't instantiate struct io_tw_state */
> +typedef struct io_tw_state io_tw_token_t;
>
>  enum {
>         REQ_F_FIXED_FILE_BIT    =3D IOSQE_FIXED_FILE_BIT,
> @@ -549,7 +557,11 @@ enum {
>         REQ_F_BUF_MORE          =3D IO_REQ_FLAG(REQ_F_BUF_MORE_BIT),
>  };
>
> -typedef void (*io_req_tw_func_t)(struct io_kiocb *req, struct io_tw_stat=
e *ts);
> +struct io_tw_req {
> +       struct io_kiocb *req;
> +};
> +
> +typedef void (*io_req_tw_func_t)(struct io_tw_req tw_req, io_tw_token_t =
tw);
>
>  struct io_task_work {
>         struct llist_node               node;
> diff --git a/io_uring/futex.c b/io_uring/futex.c
> index a3d2b700b480c..cd125e4671d35 100644
> --- a/io_uring/futex.c
> +++ b/io_uring/futex.c
> @@ -44,30 +44,34 @@ void io_futex_cache_free(struct io_ring_ctx *ctx)
>         io_alloc_cache_free(&ctx->futex_cache, kfree);
>  }
>
> -static void __io_futex_complete(struct io_kiocb *req, struct io_tw_state=
 *ts)
> +static void __io_futex_complete(struct io_tw_req tw_req, io_tw_token_t t=
w)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
> +
>         req->async_data =3D NULL;
>         hlist_del_init(&req->hash_node);
> -       io_req_task_complete(req, ts);
> +       io_req_task_complete(tw_req, tw);
>  }
>
> -static void io_futex_complete(struct io_kiocb *req, struct io_tw_state *=
ts)
> +static void io_futex_complete(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_futex_data *ifd =3D req->async_data;
>         struct io_ring_ctx *ctx =3D req->ctx;
>
> -       io_tw_lock(ctx, ts);
> +       io_tw_lock(ctx, tw);
>         if (!io_alloc_cache_put(&ctx->futex_cache, ifd))
>                 kfree(ifd);
> -       __io_futex_complete(req, ts);
> +       __io_futex_complete(tw_req, tw);
>  }
>
> -static void io_futexv_complete(struct io_kiocb *req, struct io_tw_state =
*ts)
> +static void io_futexv_complete(struct io_tw_req tw_req, io_tw_token_t tw=
)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_futex *iof =3D io_kiocb_to_cmd(req, struct io_futex);
>         struct futex_vector *futexv =3D req->async_data;
>
> -       io_tw_lock(req->ctx, ts);
> +       io_tw_lock(req->ctx, tw);
>
>         if (!iof->futexv_unqueued) {
>                 int res;
> @@ -79,7 +83,7 @@ static void io_futexv_complete(struct io_kiocb *req, st=
ruct io_tw_state *ts)
>
>         kfree(req->async_data);
>         req->flags &=3D ~REQ_F_ASYNC_DATA;
> -       __io_futex_complete(req, ts);
> +       __io_futex_complete(tw_req, tw);
>  }
>
>  static bool io_futexv_claim(struct io_futex *iof)
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 03c6ab505d74a..c00768f616c3f 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -251,8 +251,9 @@ static __cold void io_fallback_req_func(struct work_s=
truct *work)
>
>         percpu_ref_get(&ctx->refs);
>         mutex_lock(&ctx->uring_lock);
> +       ts.cancel =3D io_should_terminate_tw(ctx);
>         llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
> -               req->io_task_work.func(req, &ts);
> +               req->io_task_work.func((struct io_tw_req){req}, ts);
>         io_submit_flush_completions(ctx);
>         mutex_unlock(&ctx->uring_lock);
>         percpu_ref_put(&ctx->refs);
> @@ -509,9 +510,9 @@ static void io_queue_iowq(struct io_kiocb *req)
>         io_wq_enqueue(tctx->io_wq, &req->work);
>  }
>
> -static void io_req_queue_iowq_tw(struct io_kiocb *req, struct io_tw_stat=
e *ts)
> +static void io_req_queue_iowq_tw(struct io_tw_req tw_req, io_tw_token_t =
tw)
>  {
> -       io_queue_iowq(req);
> +       io_queue_iowq(tw_req.req);
>  }
>
>  void io_req_queue_iowq(struct io_kiocb *req)
> @@ -1012,7 +1013,7 @@ static inline struct io_kiocb *io_req_find_next(str=
uct io_kiocb *req)
>         return nxt;
>  }
>
> -static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_stat=
e *ts)
> +static void ctx_flush_and_put(struct io_ring_ctx *ctx, io_tw_token_t tw)
>  {
>         if (!ctx)
>                 return;
> @@ -1042,24 +1043,25 @@ struct llist_node *io_handle_tw_list(struct llist=
_node *node,
>                                                     io_task_work.node);
>
>                 if (req->ctx !=3D ctx) {
> -                       ctx_flush_and_put(ctx, &ts);
> +                       ctx_flush_and_put(ctx, ts);
>                         ctx =3D req->ctx;
>                         mutex_lock(&ctx->uring_lock);
>                         percpu_ref_get(&ctx->refs);
> +                       ts.cancel =3D io_should_terminate_tw(ctx);
>                 }
>                 INDIRECT_CALL_2(req->io_task_work.func,
>                                 io_poll_task_func, io_req_rw_complete,
> -                               req, &ts);
> +                               (struct io_tw_req){req}, ts);
>                 node =3D next;
>                 (*count)++;
>                 if (unlikely(need_resched())) {
> -                       ctx_flush_and_put(ctx, &ts);
> +                       ctx_flush_and_put(ctx, ts);
>                         ctx =3D NULL;
>                         cond_resched();
>                 }
>         } while (node && *count < max_entries);
>
> -       ctx_flush_and_put(ctx, &ts);
> +       ctx_flush_and_put(ctx, ts);
>         return node;
>  }
>
> @@ -1280,7 +1282,7 @@ static bool io_run_local_work_continue(struct io_ri=
ng_ctx *ctx, int events,
>         return false;
>  }
>
> -static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_sta=
te *ts,
> +static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t tw=
,
>                                int min_events)
>  {
>         struct llist_node *node;
> @@ -1292,6 +1294,7 @@ static int __io_run_local_work(struct io_ring_ctx *=
ctx, struct io_tw_state *ts,
>         if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
>                 atomic_andnot(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
>  again:
> +       tw.cancel =3D io_should_terminate_tw(ctx);
>         /*
>          * llists are in reverse order, flip it back the right way before
>          * running the pending items.
> @@ -1303,7 +1306,7 @@ static int __io_run_local_work(struct io_ring_ctx *=
ctx, struct io_tw_state *ts,
>                                                     io_task_work.node);
>                 INDIRECT_CALL_2(req->io_task_work.func,
>                                 io_poll_task_func, io_req_rw_complete,
> -                               req, ts);
> +                               (struct io_tw_req){req}, tw);
>                 ret++;
>                 node =3D next;
>         }
> @@ -1326,7 +1329,7 @@ static inline int io_run_local_work_locked(struct i=
o_ring_ctx *ctx,
>
>         if (llist_empty(&ctx->work_llist))
>                 return 0;
> -       return __io_run_local_work(ctx, &ts, min_events);
> +       return __io_run_local_work(ctx, ts, min_events);
>  }
>
>  static int io_run_local_work(struct io_ring_ctx *ctx, int min_events)
> @@ -1335,22 +1338,25 @@ static int io_run_local_work(struct io_ring_ctx *=
ctx, int min_events)
>         int ret;
>
>         mutex_lock(&ctx->uring_lock);
> -       ret =3D __io_run_local_work(ctx, &ts, min_events);
> +       ret =3D __io_run_local_work(ctx, ts, min_events);
>         mutex_unlock(&ctx->uring_lock);
>         return ret;
>  }
>
> -static void io_req_task_cancel(struct io_kiocb *req, struct io_tw_state =
*ts)
> +static void io_req_task_cancel(struct io_tw_req tw_req, io_tw_token_t tw=
)
>  {
> -       io_tw_lock(req->ctx, ts);
> +       struct io_kiocb *req =3D tw_req.req;
> +
> +       io_tw_lock(req->ctx, tw);
>         io_req_defer_failed(req, req->cqe.res);
>  }
>
> -void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts)
> +void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_ring_ctx *ctx =3D req->ctx;
>
> -       io_tw_lock(ctx, ts);
> +       io_tw_lock(ctx, tw);
>         if (unlikely(io_should_terminate_tw(ctx)))
>                 io_req_defer_failed(req, -EFAULT);
>         else if (req->flags & REQ_F_FORCE_ASYNC)
> @@ -1557,9 +1563,9 @@ static int io_iopoll_check(struct io_ring_ctx *ctx,=
 long min)
>         return 0;
>  }
>
> -void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts)
> +void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> -       io_req_complete_defer(req);
> +       io_req_complete_defer(tw_req.req);
>  }
>
>  /*
> @@ -1760,9 +1766,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsig=
ned int issue_flags)
>         return ret;
>  }
>
> -int io_poll_issue(struct io_kiocb *req, struct io_tw_state *ts)
> +int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw)
>  {
> -       io_tw_lock(req->ctx, ts);
> +       io_tw_lock(req->ctx, tw);
>         return io_issue_sqe(req, IO_URING_F_NONBLOCK|IO_URING_F_MULTISHOT=
|
>                                  IO_URING_F_COMPLETE_DEFER);
>  }
> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
> index f1d3b49289977..8439deda9ca47 100644
> --- a/io_uring/io_uring.h
> +++ b/io_uring/io_uring.h
> @@ -82,9 +82,9 @@ void io_req_task_work_add_remote(struct io_kiocb *req, =
struct io_ring_ctx *ctx,
>                                  unsigned flags);
>  bool io_alloc_async_data(struct io_kiocb *req);
>  void io_req_task_queue(struct io_kiocb *req);
> -void io_req_task_complete(struct io_kiocb *req, struct io_tw_state *ts);
> +void io_req_task_complete(struct io_tw_req tw_req, io_tw_token_t tw);
>  void io_req_task_queue_fail(struct io_kiocb *req, int ret);
> -void io_req_task_submit(struct io_kiocb *req, struct io_tw_state *ts);
> +void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw);
>  struct llist_node *io_handle_tw_list(struct llist_node *node, unsigned i=
nt *count, unsigned int max_entries);
>  struct llist_node *tctx_task_work_run(struct io_uring_task *tctx, unsign=
ed int max_entries, unsigned int *count);
>  void tctx_task_work(struct callback_head *cb);
> @@ -96,7 +96,7 @@ int io_ring_add_registered_file(struct io_uring_task *t=
ctx, struct file *file,
>                                      int start, int end);
>  void io_req_queue_iowq(struct io_kiocb *req);
>
> -int io_poll_issue(struct io_kiocb *req, struct io_tw_state *ts);
> +int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw);
>  int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr);
>  int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
>  void __io_submit_flush_completions(struct io_ring_ctx *ctx);
> @@ -347,7 +347,7 @@ static inline bool io_task_work_pending(struct io_rin=
g_ctx *ctx)
>         return task_work_pending(current) || !llist_empty(&ctx->work_llis=
t);
>  }
>
> -static inline void io_tw_lock(struct io_ring_ctx *ctx, struct io_tw_stat=
e *ts)
> +static inline void io_tw_lock(struct io_ring_ctx *ctx, io_tw_token_t tw)
>  {
>         lockdep_assert_held(&ctx->uring_lock);
>  }
> diff --git a/io_uring/msg_ring.c b/io_uring/msg_ring.c
> index 3cf59d8c58073..5c7d35f2f0b86 100644
> --- a/io_uring/msg_ring.c
> +++ b/io_uring/msg_ring.c
> @@ -70,8 +70,9 @@ static inline bool io_msg_need_remote(struct io_ring_ct=
x *target_ctx)
>         return target_ctx->task_complete;
>  }
>
> -static void io_msg_tw_complete(struct io_kiocb *req, struct io_tw_state =
*ts)
> +static void io_msg_tw_complete(struct io_tw_req tw_req, io_tw_token_t tw=
)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_ring_ctx *ctx =3D req->ctx;
>
>         io_add_aux_cqe(ctx, req->cqe.user_data, req->cqe.res, req->cqe.fl=
ags);
> diff --git a/io_uring/notif.c b/io_uring/notif.c
> index f50964c7dab82..cc9fc345da327 100644
> --- a/io_uring/notif.c
> +++ b/io_uring/notif.c
> @@ -11,8 +11,9 @@
>
>  static const struct ubuf_info_ops io_ubuf_ops;
>
> -static void io_notif_tw_complete(struct io_kiocb *notif, struct io_tw_st=
ate *ts)
> +static void io_notif_tw_complete(struct io_tw_req tw_req, io_tw_token_t =
tw)
>  {
> +       struct io_kiocb *notif =3D tw_req.req;
>         struct io_notif_data *nd =3D io_notif_to_data(notif);
>         struct io_ring_ctx *ctx =3D notif->ctx;
>
> @@ -34,7 +35,7 @@ static void io_notif_tw_complete(struct io_kiocb *notif=
, struct io_tw_state *ts)
>                 }
>
>                 nd =3D nd->next;
> -               io_req_task_complete(notif, ts);
> +               io_req_task_complete((struct io_tw_req){notif}, tw);
>         } while (nd);
>  }
>
> diff --git a/io_uring/poll.c b/io_uring/poll.c
> index 002f1ae830b8a..39c7f47c1f5b5 100644
> --- a/io_uring/poll.c
> +++ b/io_uring/poll.c
> @@ -150,7 +150,7 @@ static void io_poll_req_insert_locked(struct io_kiocb=
 *req)
>         hlist_add_head(&req->hash_node, &table->hbs[index].list);
>  }
>
> -static void io_poll_tw_hash_eject(struct io_kiocb *req, struct io_tw_sta=
te *ts)
> +static void io_poll_tw_hash_eject(struct io_kiocb *req, io_tw_token_t tw=
)
>  {
>         struct io_ring_ctx *ctx =3D req->ctx;
>
> @@ -161,7 +161,7 @@ static void io_poll_tw_hash_eject(struct io_kiocb *re=
q, struct io_tw_state *ts)
>                  * already grabbed the mutex for us, but there is a chanc=
e it
>                  * failed.
>                  */
> -               io_tw_lock(ctx, ts);
> +               io_tw_lock(ctx, tw);
>                 hash_del(&req->hash_node);
>                 req->flags &=3D ~REQ_F_HASH_LOCKED;
>         } else {
> @@ -261,7 +261,7 @@ static inline void io_poll_execute(struct io_kiocb *r=
eq, int res)
>   * req->cqe.res. IOU_POLL_REMOVE_POLL_USE_RES indicates to remove multis=
hot
>   * poll and that the result is stored in req->cqe.
>   */
> -static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state=
 *ts)
> +static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
>  {
>         int v;
>
> @@ -333,7 +333,7 @@ static int io_poll_check_events(struct io_kiocb *req,=
 struct io_tw_state *ts)
>                         /* multiple refs and HUP, ensure we loop once mor=
e */
>                         if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v !=
=3D 1)
>                                 v--;
> -                       ret =3D io_poll_issue(req, ts);
> +                       ret =3D io_poll_issue(req, tw);
>                         if (ret =3D=3D IOU_STOP_MULTISHOT)
>                                 return IOU_POLL_REMOVE_POLL_USE_RES;
>                         else if (ret =3D=3D IOU_REQUEUE)
> @@ -355,11 +355,12 @@ static int io_poll_check_events(struct io_kiocb *re=
q, struct io_tw_state *ts)
>         return IOU_POLL_NO_ACTION;
>  }
>
> -void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
> +void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         int ret;
>
> -       ret =3D io_poll_check_events(req, ts);
> +       ret =3D io_poll_check_events(req, tw);
>         if (ret =3D=3D IOU_POLL_NO_ACTION) {
>                 return;
>         } else if (ret =3D=3D IOU_POLL_REQUEUE) {
> @@ -367,7 +368,7 @@ void io_poll_task_func(struct io_kiocb *req, struct i=
o_tw_state *ts)
>                 return;
>         }
>         io_poll_remove_entries(req);
> -       io_poll_tw_hash_eject(req, ts);
> +       io_poll_tw_hash_eject(req, tw);
>
>         if (req->opcode =3D=3D IORING_OP_POLL_ADD) {
>                 if (ret =3D=3D IOU_POLL_DONE) {
> @@ -376,7 +377,7 @@ void io_poll_task_func(struct io_kiocb *req, struct i=
o_tw_state *ts)
>                         poll =3D io_kiocb_to_cmd(req, struct io_poll);
>                         req->cqe.res =3D mangle_poll(req->cqe.res & poll-=
>events);
>                 } else if (ret =3D=3D IOU_POLL_REISSUE) {
> -                       io_req_task_submit(req, ts);
> +                       io_req_task_submit(tw_req, tw);
>                         return;
>                 } else if (ret !=3D IOU_POLL_REMOVE_POLL_USE_RES) {
>                         req->cqe.res =3D ret;
> @@ -384,14 +385,14 @@ void io_poll_task_func(struct io_kiocb *req, struct=
 io_tw_state *ts)
>                 }
>
>                 io_req_set_res(req, req->cqe.res, 0);
> -               io_req_task_complete(req, ts);
> +               io_req_task_complete(tw_req, tw);
>         } else {
> -               io_tw_lock(req->ctx, ts);
> +               io_tw_lock(req->ctx, tw);
>
>                 if (ret =3D=3D IOU_POLL_REMOVE_POLL_USE_RES)
> -                       io_req_task_complete(req, ts);
> +                       io_req_task_complete(tw_req, tw);
>                 else if (ret =3D=3D IOU_POLL_DONE || ret =3D=3D IOU_POLL_=
REISSUE)
> -                       io_req_task_submit(req, ts);
> +                       io_req_task_submit(tw_req, tw);
>                 else
>                         io_req_defer_failed(req, ret);
>         }
> diff --git a/io_uring/poll.h b/io_uring/poll.h
> index b0e3745f5a29b..bf894dc6b9f86 100644
> --- a/io_uring/poll.h
> +++ b/io_uring/poll.h
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/io_uring_types.h>
> +
>  #define IO_POLL_ALLOC_CACHE_MAX 32
>
>  enum {
> @@ -43,4 +45,4 @@ int io_arm_poll_handler(struct io_kiocb *req, unsigned =
issue_flags);
>  bool io_poll_remove_all(struct io_ring_ctx *ctx, struct task_struct *tsk=
,
>                         bool cancel_all);
>
> -void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts);
> +void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw);
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index a74664c4a05ef..55e5bff818b10 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -508,8 +508,9 @@ static inline int io_fixup_rw_res(struct io_kiocb *re=
q, long res)
>         return res;
>  }
>
> -void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts)
> +void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_rw *rw =3D io_kiocb_to_cmd(req, struct io_rw);
>         struct kiocb *kiocb =3D &rw->kiocb;
>
> @@ -525,7 +526,7 @@ void io_req_rw_complete(struct io_kiocb *req, struct =
io_tw_state *ts)
>                 req->cqe.flags |=3D io_put_kbuf(req, req->cqe.res, NULL);
>
>         io_req_rw_cleanup(req, 0);
> -       io_req_task_complete(req, ts);
> +       io_req_task_complete(tw_req, tw);
>  }
>
>  static void io_complete_rw(struct kiocb *kiocb, long res)
> diff --git a/io_uring/rw.h b/io_uring/rw.h
> index 3f432dc75441f..283beeeb05fbc 100644
> --- a/io_uring/rw.h
> +++ b/io_uring/rw.h
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +#include <linux/io_uring_types.h>
>  #include <linux/pagemap.h>
>
>  struct io_async_rw {
> @@ -22,7 +23,7 @@ int io_read(struct io_kiocb *req, unsigned int issue_fl=
ags);
>  int io_write(struct io_kiocb *req, unsigned int issue_flags);
>  void io_readv_writev_cleanup(struct io_kiocb *req);
>  void io_rw_fail(struct io_kiocb *req);
> -void io_req_rw_complete(struct io_kiocb *req, struct io_tw_state *ts);
> +void io_req_rw_complete(struct io_tw_req tw_req, io_tw_token_t tw);
>  int io_read_mshot_prep(struct io_kiocb *req, const struct io_uring_sqe *=
sqe);
>  int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags);
>  void io_rw_cache_free(const void *entry);
> diff --git a/io_uring/timeout.c b/io_uring/timeout.c
> index 9cc5776103feb..1f0c66b643e3c 100644
> --- a/io_uring/timeout.c
> +++ b/io_uring/timeout.c
> @@ -65,8 +65,9 @@ static inline bool io_timeout_finish(struct io_timeout =
*timeout,
>
>  static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer);
>
> -static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state=
 *ts)
> +static void io_timeout_complete(struct io_tw_req tw_req, io_tw_token_t t=
w)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_timeout *timeout =3D io_kiocb_to_cmd(req, struct io_tim=
eout);
>         struct io_timeout_data *data =3D req->async_data;
>         struct io_ring_ctx *ctx =3D req->ctx;
> @@ -83,7 +84,7 @@ static void io_timeout_complete(struct io_kiocb *req, s=
truct io_tw_state *ts)
>                 }
>         }
>
> -       io_req_task_complete(req, ts);
> +       io_req_task_complete(tw_req, tw);
>  }
>
>  static bool io_kill_timeout(struct io_kiocb *req, int status)
> @@ -138,9 +139,11 @@ __cold void io_flush_timeouts(struct io_ring_ctx *ct=
x)
>         spin_unlock_irq(&ctx->timeout_lock);
>  }
>
> -static void io_req_tw_fail_links(struct io_kiocb *link, struct io_tw_sta=
te *ts)
> +static void io_req_tw_fail_links(struct io_tw_req tw_req, io_tw_token_t =
tw)
>  {
> -       io_tw_lock(link->ctx, ts);
> +       struct io_kiocb *link =3D tw_req.req;
> +
> +       io_tw_lock(link->ctx, tw);
>         while (link) {
>                 struct io_kiocb *nxt =3D link->link;
>                 long res =3D -ECANCELED;
> @@ -149,7 +152,7 @@ static void io_req_tw_fail_links(struct io_kiocb *lin=
k, struct io_tw_state *ts)
>                         res =3D link->cqe.res;
>                 link->link =3D NULL;
>                 io_req_set_res(link, res, 0);
> -               io_req_task_complete(link, ts);
> +               io_req_task_complete((struct io_tw_req){link}, tw);
>                 link =3D nxt;
>         }
>  }
> @@ -296,8 +299,9 @@ int io_timeout_cancel(struct io_ring_ctx *ctx, struct=
 io_cancel_data *cd)
>         return 0;
>  }
>
> -static void io_req_task_link_timeout(struct io_kiocb *req, struct io_tw_=
state *ts)
> +static void io_req_task_link_timeout(struct io_tw_req tw_req, io_tw_toke=
n_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_timeout *timeout =3D io_kiocb_to_cmd(req, struct io_tim=
eout);
>         struct io_kiocb *prev =3D timeout->prev;
>         int ret =3D -ENOENT;
> @@ -312,11 +316,11 @@ static void io_req_task_link_timeout(struct io_kioc=
b *req, struct io_tw_state *t
>                         ret =3D io_try_cancel(req->task->io_uring, &cd, 0=
);
>                 }
>                 io_req_set_res(req, ret ?: -ETIME, 0);
> -               io_req_task_complete(req, ts);
> +               io_req_task_complete(tw_req, tw);
>                 io_put_req(prev);
>         } else {
>                 io_req_set_res(req, -ETIME, 0);
> -               io_req_task_complete(req, ts);
> +               io_req_task_complete(tw_req, tw);
>         }
>  }
>
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index e5d0cc8a8a562..0dfd27963fc0d 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -113,8 +113,9 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd=
 *cmd,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
>
> -static void io_uring_cmd_work(struct io_kiocb *req, struct io_tw_state *=
ts)
> +static void io_uring_cmd_work(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_uring_cmd *ioucmd =3D io_kiocb_to_cmd(req, struct io_ur=
ing_cmd);
>         unsigned int flags =3D IO_URING_F_COMPLETE_DEFER;
>
> diff --git a/io_uring/waitid.c b/io_uring/waitid.c
> index b67b6d5bc6830..f3222cb30cdea 100644
> --- a/io_uring/waitid.c
> +++ b/io_uring/waitid.c
> @@ -16,7 +16,7 @@
>  #include "waitid.h"
>  #include "../kernel/exit.h"
>
> -static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts);
> +static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw);
>
>  #define IO_WAITID_CANCEL_FLAG  BIT(31)
>  #define IO_WAITID_REF_MASK     GENMASK(30, 0)
> @@ -236,13 +236,14 @@ static inline bool io_waitid_drop_issue_ref(struct =
io_kiocb *req)
>         return true;
>  }
>
> -static void io_waitid_cb(struct io_kiocb *req, struct io_tw_state *ts)
> +static void io_waitid_cb(struct io_tw_req tw_req, io_tw_token_t tw)
>  {
> +       struct io_kiocb *req =3D tw_req.req;
>         struct io_waitid_async *iwa =3D req->async_data;
>         struct io_ring_ctx *ctx =3D req->ctx;
>         int ret;
>
> -       io_tw_lock(ctx, ts);
> +       io_tw_lock(ctx, tw);
>
>         ret =3D __do_wait(&iwa->wo);
>
> @@ -271,7 +272,7 @@ static void io_waitid_cb(struct io_kiocb *req, struct=
 io_tw_state *ts)
>         }
>
>         io_waitid_complete(req, ret);
> -       io_req_task_complete(req, ts);
> +       io_req_task_complete(tw_req, tw);
>  }
>
>  static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
> --
> 2.53.0
>
