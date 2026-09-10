Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E063B8D48
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060956; cv=pass; b=RnNpemhVVytdxvIdOKr7gI4G9J8cVsG4u62oOHi0Zv5Lu/x5TLOoQ2/Ob6k0+DBXuSNnp4IgEm7Z8B6RgmLVHaaHMOKQz1thXcnWbcrKW0eBZd/x/NjMHl+HUEM2o2GCctC2msLQ39OPHRi2oWlAGg3P2q1vCbWdxgsEis1ZO1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060956; c=relaxed/simple;
	bh=IFR4nKdEOKKYPNJProJ/LoqY8uLWMn1OZMkBxks7z6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjGwUR2zHUxtNKLb5w2EcJDRHDyHFFIbutNO3c2vAzZbtgYgn/Vj6B9IvSJy//11PGlwOALZJtRrcWxbJkuoSDeCuC2mkrgb7nqWLXIN9x2Zi6c82TUkKygzCnqLvjMn+btxygOi6uMX/BOdIH/TpOQxtxDuZqISWVYZCFOK5AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz1rGn7Q; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz1rGn7Q"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d0e19300cso453585e9.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789060948; cv=none;
        d=google.com; s=arc-20260327;
        b=S8GD9sMBlUZuxiwaQ7NDr401qvl49oKYMVeOVr64aIVvJsZ9nnEH35nT+pw9z0/Jli
         0buJZlLLewZdhCik+/Oww01Y7xVb/FTUTXLhHUYpLR7QUmyPHgXbjSUZF8DX3o7THdp8
         w8xGE/o8YgIACsfo3vyK6ZdMVYYBO6YSz0b8iU5DoxxRDXmppSVZHpBKkWh/j+Smtlkh
         ahiKIu/VFKCVUKoWMkzwDrk8QghWJgsZ7MpBIM+lF7vUa8iqj9mwzy4uCCBzVtXfQiNV
         UfZwWport8S+WOrJoQnRPrI55ER0BLZwOJSSW8t4lRRY4VddxJ7dtcmHjIRTeZH4Cfc8
         Xh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        fh=6X511C/5YUME+qwf1VIwfYkqS1eh36kha26sil8Dyko=;
        b=mYKuiryEka3gobF49MGzaitim7SegLhkkqdIjRQUcWnoN97a1BPxrykPFCcpNVvFqw
         4M8vzFVVgVDhOP6p4Ik+lPi+UwHNGP2megOaEAnEq1CgKPylepWvMIfEhQocFce/yrIS
         Dsd/2FNSZCAF6y37zGxM7Zm9wMe2/DMnhljUMw4VTUdjgazNyvH7uq7pBlZSGfLrBDsc
         c2OMXKW5WI13lrYr5005MLUaWGRLrb7LYCyZjmQVXdeYtAubi1brn/ycF3C4OSfgP76N
         D63SyP7ZLkSoSHdq/4d+bB1K9RT/s0X1boxjhmGyFiG1o77a0sHCtbExBPohtKqMGRuz
         V9Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060948; x=1789665748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        b=gz1rGn7QAKE9OEvSMgCuo7Os9QeOAqpxNj6m6AAvr1kLlolE3N/AGiA8Al9aR+nw1L
         s5bD8yrLrlElG4HI+KBRpTsV6DPRlyOvymL2SOROCbRUf1cpjcrZWS3pwtMmLpWAB6Gz
         YP0NPNbzGzdK4DBMUbQc+k7ng+NJT0e5mxWjkQaOr6E4dGrW43mc2QRHTQlAmSE9l1gV
         4FliB+EDN0PYHPkS/BU6MJEiISeZQir7Qzbz1XsR4npgHTZ7Unvp/XhiBoagTNxJ7V5M
         RbaecXs+3i6ZgPu1Fd41m1QqWAklbNU+M8iC1vD5r5JCm9wTmm+bGpw3aLK31pVdwgHP
         QOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060948; x=1789665748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4I3/z0Z834sx5ZQDBMDFhlcKX3jNWqo3Yat82eHYo8=;
        b=NyRo7GzHgZF1reUJ/ip2Rx9SkATObaWd9RLLVz0c9iwpYT09lCLiTV312Gsrv0jYa/
         MYz4aS44+N10dGaxBLSA3z2Umvj0ZyTtu0JWXDFSd9bDwHh6Cu8zp0TODNzwhxSjx+Bk
         qHFSEmbZ84VhVKQA+L2onSAoNy1wqaSv6l9GdF8gIcn6qJe1rrtovE2uH8u+A8kLVW24
         Jfm9GpJqHsABDA5bwYK2Q0hR19S3O2WAk+VkS+oMEI7E0YShQz1sPAr+AWeXC2IFN3+4
         Ab15hHgbRlRlBfd8hkg4IxNrjiiweeiiN6WEhhW5SgfQ+8aJ6/OW/PRgFk/0SuxPb+YV
         3rIA==
X-Forwarded-Encrypted: i=1; AKwUvBybSgsB4XSdQ+XdL3nm1NjA+NhuBgnsZQE1yivesRN6WvFIRNMXqH0WHMI7PwPhizyFulnJAkM=@vger.kernel.org
X-Gm-Message-State: AFuF++nbG/4hwkUO5h9b6GEvEoZh+TWGtxmvWeXcQk2UnvPP/Yz9VExi
	qwfzcxk3sXc08g2WWGLSUC+1TMhE6VNtGkzeodQt/rfXt4SR7Xt9+dnPJ6+JV5mCUmO9cYSEDzE
	uc6s37tmFIC+7zCS5EMuzPxkahJxW4SY=
X-Gm-Gg: AYBFou2QMbeb1XLZ4WdYLlv8qjg+bwzERGdlxaHrFrU5r7jodv4vkWSqf5OFx8/Gp7l
	h+crAZId85MNY1z3OqADEXxldA05wOXhzXSJniTu+1mA5YxchnSYxXzC7tFBoh53u1PNnGwudNx
	Jm5ZQMhdH3gffaHlPybteh5SkHlR0fQM+Qssb/twk/MXcMwtfaCg+rhlSS6faAbnIRSpzt7KeiU
	rP5FChk8tWiMKhXR4CCbE/kOS0Ub/jOrpX0nIYzfDhEFtwtX7CISDB5BBDfAcx7iohgbFvQtjSB
	7kcVr4tTzhA6xtX4a/Ju4mIinZtJCX+9gbD2dtTxBU24Ti8DRrrBZSe4A+VAgO6r5xsLLwxndNi
	+gzgr+aj4Z109pLJ6eGoP4oyFFF7hf9ZskDGQbA==
X-Received: by 2002:a05:600d:8646:20b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49e619c079cmr485295e9.19.1789060947517; Thu, 10 Sep 2026
 10:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910022442.3594649-1-xmei5@asu.edu>
In-Reply-To: <20260910022442.3594649-1-xmei5@asu.edu>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 10 Sep 2026 10:22:14 -0700
X-Gm-Features: AcwNN1ViYMaLgvTSlyD77nmlLTiqiJ9NADONiy9rDk9d6ocZ1sATbKbnTXWESp0
Message-ID: <CAJnrk1bVwezZwMFmOE-4T6KTa5SzQFapkATS2LVeo7+bMcjdbg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] fuse: don't BUG when the copy buffer is exhausted
To: Xiang Mei <xmei5@asu.edu>
Cc: Bernd Schubert <bernd@bsbernd.com>, Baokun Li <libaokun@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 7:25=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> fuse_copy_fill() hits BUG_ON(!err) once the iterator backing the copy
> runs out of pages.  Over io-uring the amount copied is not bounded by the
> payload buffer the server registered, so an unprivileged user can drain
> the iterator and panic the host - mount a FUSE filesystem with small
> payload buffers, then setxattr() a larger value:
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
> The reply path can drain it the same way, via the server-supplied
> payload_sz in fuse_uring_copy_from_ring().
>
> An exhausted iterator is recoverable, so return -EIO.  All three

super nit: imo, the reason for returning -EIO is unrelated to an
iterator being recoverable.

> fuse_copy_fill() callers already propagate the error.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Joanne Koong <joannelkoong@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Thanks for your patience with iterating on this fix!

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

> ---
>  fs/fuse/dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 4fec31fc0b84..4148e4488d77 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1061,7 +1061,8 @@ static int fuse_copy_fill(struct fuse_copy_state *c=
s)
>                 err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1=
, &off);
>                 if (err < 0)
>                         return err;
> -               BUG_ON(!err);
> +               if (!err)
> +                       return -EIO;
>                 cs->len =3D err;
>                 cs->offset =3D off;
>                 cs->pg =3D page;
> --
> 2.43.0
>
