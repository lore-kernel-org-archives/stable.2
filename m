Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839833AB272
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981605; cv=pass; b=AB/OY0sEyWkmmPifWL5L85w6CdD1XrisIMye9w13RhtdjzOEcTtWoZF1wAHVbYpfvs0BsO1edF18UQIEWbiEC82EasyCVBLKh1zMDuQZd0oGdChr+ECNlZKpWv2bbnnwpDdT6XgENnDw/Ns7oNhfRr2S7U+62xzJO1bqz/Hi2yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981605; c=relaxed/simple;
	bh=Ajiydw3L25W781rT08oBIgJWAfLm/lQwQ3vUJDLb5Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5qMCjGT10M8JJMYBe/qOwS3qpB5Btfll8MQsrd+jEkZ+17DdL7Epkafz7KV07kqhjPfuixMFJI5SF8nF5V60BUWux5itvb87B8kZcbLNsnv77hUz0oRio8bzKNGNaGbcNcrMpwy1gXV0gxLPixmNRm6aeqSFtdHmRjtCLdmNuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mcz+yyym; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcz+yyym"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441fa5c37so4546667f8f.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 12:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788981601; cv=none;
        d=google.com; s=arc-20260327;
        b=o2L+ed6qfDGRi+0c8vYCVeUkKxojF6cJm3711306Bhwt5AsjQE3Tpt2aTb4zDNJ5Tu
         75dvcrLXoFpp8vDTbCfEWnS4Gn9vZda/IJgdptam0e1Xe7aL1n7iKjmA0hfOF2m/Aipv
         J9ETag+PWH7VD05FX+j79jwfIMH8y3r3lOXc7xs78wPQmssMa7PEE2szNj29YbZGbJD0
         AwP9b4Ngz5uZlJaV5m4gl0CW53oUUf45cY9lwcBPrLkqKGc1Y3P+mYR9kc5QaUVrUQyS
         P3R3YatmxziUzz+FPwLtIbOrLW5Tkt4Ic7q4tgTEPkri8aVe1lDIDUgLFXxUeGVVbpXR
         CjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        fh=gQJdDc730k+uqAH/jYqt+5L1ggKVwqRF7Itvb8mua3c=;
        b=ThvbyLQqFc6xPGiKSc1o049v5VJ1wlJvt8UG+Mc8ZtOZxRiyZ7du8Z72EfWLEtsPhM
         U1kEopw8t+dNRJDFHynoKAZhFFKmjdEPQsX8Amgl5/ob3EMLbUIZ1gR6dpbZVVom2KTY
         YnG/LSuoAkgSb56QJfZFvGlaIxS/vvWyk2BhRfVw006sHXQnMGCs2Jz6kmlqTcvRBcfK
         sU7oG78bmK2bAPRwLoJQ7GwgEHD06IN43wMZOs4F1CS81po4qrk0Na2JmFfCEdK+8s5l
         NT44wOAqt3nyjiYkaGF+2ASlMQ75kMMXvSYcTgZqW5ndIF0dKyL00WEliv6zzYlLBL08
         fvRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981601; x=1789586401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        b=Mcz+yyymtajFDKDJK/Y42w2jiYBaeGNxNF50vBrQ0l+gnNfMW0J+sioh8S9eHQEyAM
         /J3tVAcv4iadezS1FOpbZyLGgujj3DnG0KPjndUNOetidOXvoYVeEuLjgKAn97956jXD
         n2s+kCFofFWr2k66eOrbE3mAocYTpZPqmx5gtTJgj1T4sUU2Mp1XuuhSrhHhliSUJxnB
         B5jao7RU/xbEfVZFQfCgR9mjEyQ0m2QIWCe4jWf4AFUnhLkKV8feYzSd/ktsZMCMoeE3
         WN8BYBfY0ueUZxWG5OT/BFfX+ypBqsaNSKTPvmd+mLojpL14u3WzGjs6iuZjOFwAiROR
         9WVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981601; x=1789586401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FRm+Wk/CzcgkkZNM6le/ovLDE/1ge45ZLQJ5VGLwHc=;
        b=SWAknrNcs0SRBDF4pLf6gOH9ccmw7VhBuqWKoLJLI0b2GPktd9mQ42wr5P/lS4fgYV
         igPmR3Xw18lzrTv7ZgOxbJBa9jrSp5TON5zpPBU9PVRq6CE42+9jyPwgQ8axO0n9aziV
         oyQvlBkJnKhp7eWm/YP7xq0TvW3I5gKqL03KVo5CWPHOkIvq9lumA5MYjAUiMkyMrMAE
         N+zBEgUNZcOzojjYwW36O3ueMIqiQNDQ+6toap0L9n0qQ0d+nRQaVVgpuSpSw8Di++2e
         +gMnx34pYV7OiXUrY2nsbFrVttSPvDYoiAJvtlkpWhA90u87LBTDJ8xKMBzOHGzeyUzv
         jASw==
X-Forwarded-Encrypted: i=1; AKwUvBwlznbP+DpOXP2vWqm50C4oOc5jbWx5JGeWttT+jC5yJAuoZsY9KgU8Sedf8idtnt/2C+xeLjA=@vger.kernel.org
X-Gm-Message-State: AFuF++nAReZBiM5+e84m4lRq1IEkNnbQRTSo1OgLUDV2pKYAHOPAk+hp
	G9H3ZRwjQYm92lmhQXDKtRI9yFOGwX776HIya5nbH1pCXChAw76zn+ZP4mhLndL9uzJ4zYQxqcb
	Dv2Kj/6H+Xr3dTcvqyjCnALbQ4iK1KxY=
X-Gm-Gg: AYBFou2JN2Wy5VEMdhieVexCFXW7Lq4umHCuA90jsE7uLUUQBmTFDKnBv1hlgvctP64
	ib3qKROqSC63706pW6FStzN3myWnHzxU9+U/SdJtAu5mq3UQjXGK2lWS20O+h4i+9AY3HnYOOor
	HdujqqVnKcLacreJmI87vNV9LK0n3jo7Wq3uBsiWrXnXStlTkk3n+pQSkTy11DvuUKWzQqyxx5n
	Zmz8Y5VndyRqRIoqJImqvwZGv23z0yHVlZCadz9SQGLbBBDsmfH4ssl3ipeNEhLq/+XCQzieAeh
	Xzgj9RfvxLqVZTa4sL7D1Y7gI+07w0krZsUAvseICW1i903Z0F8szAGJFVunxS0WoagxVEm+wKr
	+8DWkHMX5Dck3dDbHsgCdvQMTdo2aPMelx30fBwS1OEP1M0bs
X-Received: by 2002:a5d:588b:0:b0:485:ac96:7263 with SMTP id
 ffacd0b85a97d-485ac9673b3mr6592105f8f.12.1788981600320; Wed, 09 Sep 2026
 12:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906012924.1928316-1-xmei5@asu.edu>
In-Reply-To: <20260906012924.1928316-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Sep 2026 12:19:47 -0700
X-Gm-Features: AcwNN1UbD6k4LeCepkUvjqBr96R-weQxM4XVCQGN4UqRnGUCJVeyGH44lDLJG20
Message-ID: <CAJnrk1aXL9QuW+USSbx2La9qgNYU8jybqqpoSSRo6wEAAZqxAw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 6:29=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The fuse-io-uring copy paths do not check that the data they copy fits
> in the ring entry's payload buffer.  fuse_uring_copy_from_ring() passes
> the server-supplied payload_sz straight to fuse_copy_out_args(), and
> fuse_uring_args_to_ring() copies the request in-args without comparing
> them against the buffer.  Either can exhaust the imported iterator and
> hit fuse_copy_fill()'s BUG_ON(!err).
>
> An unprivileged user can trigger the request side by mounting a FUSE
> filesystem that registers small payload buffers and then issuing a
> setxattr() whose value exceeds them:
>
>   kernel BUG at fs/fuse/dev.c:1064!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 1 UID: 0 PID: 148 Comm: exploit Not tainted 7.3.0-rc1 #2
>   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1033)
>   Call Trace:
>    <TASK>
>    fuse_copy_args (fs/fuse/dev.c:1354 fs/fuse/dev.c:1380)
>    fuse_uring_args_to_ring (fs/fuse/dev_uring.c:891)
>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:940 fs/fuse/dev_uring.c:1=
057)
>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1745)
>    tctx_task_work_run (io_uring/tw.c:96)
>    tctx_task_work (io_uring/tw.c:133)
>    task_work_run (kernel/task_work.c:233)
>    io_run_task_work (io_uring/tw.h:84)
>    io_cqring_wait (io_uring/wait.c:278)
>    __do_sys_io_uring_enter (io_uring/io_uring.c:2676)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:61)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>    </TASK>
>
> Bound both directions against ent->payload.iov_len, the length the
> server registered, so an oversized reply is rejected with -EINVAL and an
> oversized request with -E2BIG/-EIO, matching fuse_dev_do_read().
>
> On a zero-copied request the last page-backed argument is handed to the
> server as registered pages rather than copied into the payload buffer,
> so exclude it from the request-side sum to avoid rejecting valid
> zero-copy reads and writes.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: add: Cc stable and Reviewed-by tags
> v3: propose the patch fixing another issue found by Bernd by Joanne sugge=
sted way
> v4: no context change as v3; add Reviewed-by: Joanne Koong ...
> v5: no change
> v6: rebase on fuse.git#for-next.  The ring entry already keeps the payloa=
d
>     iovec and imports it at iov_len, so only the two bounds checks are le=
ft.
>     Skip the page-backed arg on a zero-copied request, it does not consum=
e
>     the payload buffer.
>
>  fs/fuse/dev_uring.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index c6dd420c4034..981b7c295e5e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -775,6 +775,9 @@ static int fuse_uring_copy_from_ring(struct fuse_req =
*req,
>         if (err)
>                 return err;
>
> +       if (ring_in_out.payload_sz > ent->payload.iov_len)
> +               return -EINVAL;
> +

This logic will break fuse zero-copy reads (ent->payload.iov_len is zero).

imo I think the cleanest fix for this bug in general would be to just
remove the BUG_ON in fuse_copy_fill() and return back the error, eg

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ static int fuse_copy_fill(struct fuse_copy_state *cs)
              err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &o=
ff);
              if (err < 0)
                      return err;
-             BUG_ON(!err);
+             if (!err)
+                     return -EIO;
              cs->len =3D err;

This would cover both the request and reply side and get rid of the
special logic here and below. It'd also make backporting to stable a
lot easier. I think it would still be worth having the FUSE_SETXATTR
errno fix (eg returning -E2BIG instead of -EIO)

    if (fuse_len_args(num_args, (struct fuse_arg *)in_args) >
          ent->payload.iov_len)
              return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;

as its own patch, where that check is only about picking the right
errno, not about preventing the BUG.

WDYT?

Thanks,
Joanne

>         err =3D setup_fuse_copy_state(&cs, req, ent, ITER_SOURCE, &iter,
>                                     issue_flags);
>         if (err)
> @@ -854,6 +857,7 @@ static int fuse_uring_args_to_ring(struct fuse_req *r=
eq,
>         int num_args =3D args->in_numargs;
>         int err;
>         struct iov_iter iter;
> +       size_t copy_size;
>         struct fuse_uring_ent_in_out ent_in_out =3D {
>                 .flags =3D 0,
>                 .commit_id =3D req->in.h.unique,
> @@ -887,6 +891,16 @@ static int fuse_uring_args_to_ring(struct fuse_req *=
req,
>                 num_args--;
>         }
>
> +       copy_size =3D fuse_len_args(num_args, (struct fuse_arg *)in_args)=
;
> +       /* a zero-copied page arg does not consume the payload buffer */
> +       if (cs.skip_folio_copy && args->in_pages && num_args)
> +               copy_size -=3D in_args[num_args - 1].size;
> +
> +       if (copy_size > ent->payload.iov_len) {
> +               fuse_copy_finish(&cs);
> +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;
> +       }
> +
>         /* copy the payload */
>         err =3D fuse_copy_args(&cs, num_args, args->in_pages,
>                              (struct fuse_arg *)in_args, 0);
> --
> 2.43.0
>
