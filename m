Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B1346A01
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963488; cv=pass; b=VuUL4+VUsJy52KMlD5+mCr8aMwEZdVEs1fRXnrVQ5wBlpeLEXWEVWRoXhN8OgeyBTwQyCkMdRMa9z+l+TX1W2O7Kwkx8S5331YRh4VOvm2UNUph0/Tv5OH7nf5l2E1AZVzAci7VG+lfo06q9ZAzipqa9pxXNAWzGmgW3pGh3nKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963488; c=relaxed/simple;
	bh=U9+pV9BQK0J2LKLjG50wc3GsJtadYzCJrEoYSxQcAco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpu/hcUXMB0IFF0ZuCO2g9i0eAeCnFLWJvRJjsRjWL2r6N2L3sbxP1uMXxi16I5YkaaCbHCuIEqu9uTQWDi+m+VD1WZrPNC+FmWvkMAo/cEgS8KKSQXa/nshbPnmUaaUuxhLQ7qBHYoglVh6aegBcvASdBDwZlJXItQw2VyyQLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rsq8eoTH; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rsq8eoTH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47dec32798aso3507246f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 10:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783963485; cv=none;
        d=google.com; s=arc-20260327;
        b=a7gpSZ2ro5q6LIWgw05071QcRoKARPt4X95kzEH+zyxlDpa5lD9DHmuqWDGsG2E+BH
         AGrE0btQ0NHprFIqMyb2h45TF2QhxFGT6KsotXLJVa5LCg+5KhmdQJVU8ipcvAEYWeel
         ARACJv/KDV7hOXK73A6ANYmv2psVApvb3ifv6dt2+PtBlxN76obFPFIYiUgq0NvCEj2d
         CVc94n3Z53NZsQnviQ3tq0P4E5zpTYqD6+xqM/VrR9TgbLJwoyl7OKIgTQDSNK41RpxR
         1Iw35i6B1wh2zQxXTKCzWNZUA6c4fwO3VbrD/fCiq4wVAJBJ9g066BFNdPCCuKyMg2gS
         VhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LsYopPB6o48hPqvaNGGMWtc62srs6hllgE/2L+4vLdY=;
        fh=1oUfnso5fC8EHzjNLwX7kgwYtZGa1X8WeZSSTa7N8xo=;
        b=HO9BTV9ZM44TcTHr/7OekhRHC5wZyibU4SlwsjtLOxplQNkO2jKVf/YixTrzRThNq3
         eqBblKt1yPTBw+a2kPlfiL99Lo/JfRGKlMKRa/aJzpt5dKx8eTOuPyokS6anlY0IoJm7
         qnXStWXiQrtFUhgPIxTXxJyXLB2Qldj+xAsrStMkoGXgpNinBzdm7ZBtFRdWCpULb7g6
         LVNO8xECFYMvYGYJ0ZKLtAbawvz0R3ClCGHy1zV55NVDt7KLA7bbN54efo/lmOli0z/H
         Lfg6/Cqh4rHjJNxfTnnCYIUsnTjBxTXTOZDfT0tsag0HcHh0rhhX/N/7tg0SnxxNkB6J
         N51A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783963485; x=1784568285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LsYopPB6o48hPqvaNGGMWtc62srs6hllgE/2L+4vLdY=;
        b=Rsq8eoTHciODvWEh3GASDbfKdzr9NHCN3IS6ff+prHwq4Bb7iRMa3KynEp7luIasRW
         Qcq2NWG7UEcPr2xkU0CYHMb1j9tpRGk6U0jYGmRmoL7QD2FrEQIc+8284YO4nGYlcH+L
         MrvjoP7xRMSfALZFX/LhO4UVYImJRhM8sjfgJlyOHTrC1hx77IYkZauHCqvXehXfSp0L
         y4ujZZ4vyBlvRCfesAkx4JTeuUMeAz0x1d1P9kl/ig7JygZ0v/UOkv+RLn+Qs97uWq5p
         ZbGLywHPorhZ1r+u9gE6jQ0SFfT5U1aL1kOOlZK4up0LsyLEn5IPOEbzg3/sc4d+Hf0G
         RUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963485; x=1784568285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsYopPB6o48hPqvaNGGMWtc62srs6hllgE/2L+4vLdY=;
        b=cqHVY29zJj1S9Pg0fr4H3j3zQwjICa9WeOJJFylKP8Z19yWWg86lFO5YpkCHG/HwnQ
         ll6ZQikA0nn3PG2iwBKquDHYpBbbZOC8quuDtBnVX1ndLT5lUBdOi5EAiqT+H+4dLzfG
         VvnO22nfnsBf599z7HAIezyAJZH7BvM+g4X2SKBGbPWadGo5TpUhsZ/hDhnJHjSYk8fl
         Lwv1+bTiX1DodOWXYjAHHOgJ8l6+cYAFCtiRhSMxp9To61bFfSQNKmfhNR71Jkm35cFK
         33MYlMCzoqPJto/kPRPP5hUS+rok8nR/Ce5uNQ1q+L3EnT1AVwtDRwSSDnikRhQElMbs
         WjHg==
X-Forwarded-Encrypted: i=1; AHgh+Rpm0G5oGSlGO6EoTJazxpSFYWBiOmF4s7OftjANYL5BvjB9Z3DWDaBYBjI6fjVr4dCo0/qGuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rmq9IMG1Z427OcBdOWIc5Wej5tREVS8/NHvPFSPKnt6suFEF
	ajhXlFKmcseO6samMFv/T8EjASDu+iSKadPycdkB8q/F2IAjf8rVAt5cILWUt0iPOMm0zmDKP7i
	ggJHrAZM8oSinDtNzceC+dnQeSj/sCQc=
X-Gm-Gg: AfdE7ckm6g2aJScFePuS8gLVwb/O1cF3AdfBKq42iy6FtsHHQ4pHJqAFRje0ivOPeAU
	U+2w8D9peNDQRy6sZzl3HKTKnNiedS2mTbJ2qozzTDZzBSDJ4RPE84tYCDJw/D6rx1eC/ZOnzpE
	WOWleT6L/SN//g1rR250ISQi80X1lOJlNMaO1RaLf/A88VgmCaV9VyjEo3NIJSK/mBMJPLidL9o
	LQT9mn+PQ1PZGsUn4ioo7OkOEawbfML3AOFgXaZ73VN5lT7OmIqMF65D8D/8Onr7lB2C9PCINyZ
	DLfYnExTFnVI7uloyWwwq6rwFuopYx86LlofRv6S11YCUAp6ZX28D9DBrKumWtKKxjxNyg==
X-Received: by 2002:a5d:5f89:0:b0:472:326c:a4a1 with SMTP id
 ffacd0b85a97d-47f2dc9b856mr11273284f8f.22.1783963485101; Mon, 13 Jul 2026
 10:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709211130.543773-1-xmei5@asu.edu> <20260709211130.543773-2-xmei5@asu.edu>
In-Reply-To: <20260709211130.543773-2-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Jul 2026 10:24:33 -0700
X-Gm-Features: AUfX_myhSaDPwHMJYmu_3zqBXlJBVmiSvx7jGX39NT-6i7iZPVT7Znv4C7dKQp4
Message-ID: <CAJnrk1Zek9hHOehCjfmR42+Gc=K6vixmyn5977ZHv3J5fUUS_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: bound io-uring payload copies to the
 registered buffer size
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 2:11=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> The fuse-io-uring transport imports each ring entry's payload buffer at
> ring->max_payload_sz and bounds both copy directions against that value,
> ignoring the buffer length the server actually registered.  Both the
> server-supplied reply payload_sz (fuse_uring_copy_from_ring) and an
> oversized request payload such as a large FUSE_SETXATTR value
> (fuse_uring_args_to_ring) can then overrun the imported iterator and hit
> fuse_copy_fill()'s BUG_ON(!err):
>
>   kernel BUG at fs/fuse/dev.c:1053!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:fuse_copy_fill (fs/fuse/dev.c:1022)
>   Call Trace:
>    fuse_copy_args (fs/fuse/dev.c:1329 fs/fuse/dev.c:1351)
>    fuse_uring_copy_from_ring (fs/fuse/dev_uring.c:686)
>    fuse_uring_cmd (fs/fuse/dev_uring.c:1226)
>    io_uring_cmd (io_uring/uring_cmd.c:271)
>    __io_issue_sqe (io_uring/io_uring.c:1395)
>    io_issue_sqe (io_uring/io_uring.c:1418)
>    io_submit_sqes (io_uring/io_uring.c:1649 io_uring/io_uring.c:1934 io_u=
ring/io_uring.c:2057)
>    __do_sys_io_uring_enter (io_uring/io_uring.c:2646)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_6=
4.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> The request path overruns the same way, via fuse_copy_args() ->
> fuse_uring_args_to_ring().
>
> Store the registered payload length (payload->iov_len) in the ring entry
> and use it for the import and both bounds checks, so the buffer the
> server provided is honoured and an oversized reply/request is rejected
> (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> fuse_dev_do_read()) instead of panicking.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v3: propose the patch fixing another issue found by Bernd by Joanne sugge=
sted way
>
>  fs/fuse/dev_uring.c   | 9 ++++++++-
>  fs/fuse/dev_uring_i.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 0814681eb04b..248e5a3e340e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -650,7 +650,7 @@ static int setup_fuse_copy_state(struct fuse_copy_sta=
te *cs,
>  {
>         int err;
>
> -       err =3D import_ubuf(dir, ent->payload, ring->max_payload_sz, iter=
);
> +       err =3D import_ubuf(dir, ent->payload, ent->payload_sz, iter);
>         if (err) {
>                 pr_info_ratelimited("fuse: Import of user buffer failed\n=
");
>                 return err;
> @@ -679,6 +679,9 @@ static int fuse_uring_copy_from_ring(struct fuse_ring=
 *ring,
>         if (err)
>                 return err;
>
> +       if (ring_in_out.payload_sz > ent->payload_sz)
> +               return -EINVAL;
> +
>         err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &=
iter);
>         if (err)
>                 return err;
> @@ -725,6 +728,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *=
ring, struct fuse_req *req,
>                 num_args--;
>         }
>
> +       if (fuse_len_args(num_args, (struct fuse_arg *)in_args) > ent->pa=
yload_sz)
> +               return args->opcode =3D=3D FUSE_SETXATTR ? -E2BIG : -EIO;

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Not saying you have to do this, but if you wanted to, I think it'd be
nice to have a separate cleanup patch that deduplicates this setxattr
special casing logic between the /dev/fuse path and here.

Thanks,
Joanne
