Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795712623;
	b=dtRy2kq5gC9erbjBVi+A3TFvmPjM6xx3/ppgzx65KpYiWr+IxtYxB9CnqyeUu2UU/WXG
	 0Re8yrPMaSEu48pZrdsaE+Mugdsq6IvtePGlqy6OrVxBWwH0zMBppn/N4sSBkj5MXUEYF
	 gDzUoFXVsH1y8qJuNWObDsq/oP8ap3uE+dJQkQWidtfaFQvY+ZArRYBxXDdjI6l66iHHl
	 txiubA7TVYyi6EgxhYPs9h5ZTRJfSTK9A614nh57husRdASHQTE7GgbWhzZ7vgp0R59qW
	 o7BhqGKgjXhT3cSin7HWa6kVSw1uAs3iB81oAaMJ8w2q2NEzLxHtWDiZedbtrd+0R9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
	b=vlwPBj7OAtuBLIqiW4AoqBjpKTJN+xhJahHn9agRbW0fgBHVwBo7Z111K/T2BT0XfIsm
	 YQ8PI0o7oYFXJjtyIIsUYWbREmoLX6aXT6a7DBe09ZWi/Xz/LFOW4b1qEfjhBMaUchtlR
	 CerJPiOYimpi4UUDsh4fweUsCJbXCjRnC2VSeRbwqGa2NJpjzRc3CkgKgw1HEwNXwFt7g
	 F1wLC/yd6+u7dkbrxdpAeugK98PpbVfBhasmeiyQmJdCpw27IJqySgMCWJQs7VZ84LIye
	 0Mc+8VPZlBOq1os350dyu6gESY7N2FZHoUdpr8UhIuT1pxODyF9QepSadsysupwpq4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1mTsAqM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B37606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58B37606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1mTsAqM
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ae417eb235so58531001fa.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:03:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795712621; cv=none;
        d=google.com; s=arc-20260327;
        b=f6cxm46JIZSA0Ij5zWdJ5RPhHEpfAinUtPKy676AEisG401rPjt4R4LhfDk3pcZLha
         NHvuIXLkwsPU8H28ZCzsEIuC9yo7XR/+C4telwWnEuhkRvksTW9TVkjoR8Zct5QlcIr2
         RaaaEDOq6cTH+ZvNpsNgeHXx4TFS13HaWgbYAxwhSN3GXxQOGnA3ux278A8eICk7Jlx2
         tIKhOnDAyBc0MqV5rKZO3aWQbThlc7Frc3G0nXD81QRN6jWNF0DlRBv7dZWx1rtmJAi5
         g6qtucQcVOE951xYrZSQaQMzwsc/34miJ3BQ+ul0KS3pH/Sd6THehQj31tbHowYGsdYP
         NyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        fh=jEGa3JQMqvTHRRqkwotkRdRNZEGEIejNir8OQsV/PVg=;
        b=gJVfaP+vmwyZOdGnNJwJseRoNSIVgrJ2WAPWOjlg99bZ1i0pkhza0v4rsqFhqbMj1C
         tOEYUX2Z9TcUFWAFN+C5OddbNMLVUhggIlN2Q8CBceWhhDoMxwuzHYpBVv9B3wI+iSSO
         gA13MVDMSuZtRb/xw25Re6IymlKMD7b+iTJFnP0zoINDWD9zZ++lWixSp22tejnPx4wM
         Hina5JrIHp0Y6Ex11p3vkncmFi6VWqfUwKB9LlD0csJJWRAdULlitZJTulr1t1eJkvBw
         loUoHbIaSU4UtzTsqLCe++xffIy42Oy5DhzEJlctLP2Lz0Ud7A8e9DnZj/oROPfg2LrP
         WomA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795712621; x=1796317421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        b=o1mTsAqMV1PjZ4PoQSHVAydatYbSaAzqhBlfIJ+kLdrbJb4optEcVyJEs6GYw+xuJX
         uLFd2itOaZCdd40i16O+DggNspF7pwtVzYO4o3pQYX2bXJcLhW3yVeVHzmI1xQ0W4UOf
         pp2jJrKg8qPZOCgTluJB4lE2RnpzrtCp2T7Ix29ajwOPynX/zkOYo2Dv0o6XzHCfhrKR
         QZWhXniDiwvqdPDhONFd/uRzsoXazF3/qUkVEO74i11nMBtPrQaOIi4JgQKtk2bzDI+1
         4Za6bQCTioaw70Htd/bl96JUjVuOjYYdBQIUDG8Cqq45teCTpJuFYhQrAv1SGWnpIJOO
         XXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712621; x=1796317421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+fJ/MNcJCzccF7MdK9Ukp6LXKmZ9d7V5PuIGgCcDMI=;
        b=MgRosO+agnarLC3cysEsBEbWiuRw5ZNateKqAKZvS660JgIing5I7pwbww5N40sxCg
         T7y94Ox+5ah2bJPHVDs73GKwYIoSET+7uNhajPeLeL8bJT1yp5VV/zKVPyQnxHA4eTym
         sS91wwYAjfbq3IMNhwH7PslMxdpQBH05q2TQsht4gidXnSjVas8jf/T2pFmt3YE7Vu8P
         6K5j5PBZcekZZU8kEVl9BBeFKVEf92ULvLEe+bb9fee/ln9ECkllD8yBxxguGF9qUa2g
         oxseqGCR8PHzlJZJCYZCBiceI4bY7dXQQ2tWAeAHnRy9v6rV6PrrV10kycX5RLC9A70f
         h0Mg==
X-Gm-Message-State: APuU4Z+Jmfd3bozMp5/GbYA2co6ajROBUFBvezU+bQjCGVJqg7rQNkWa
	FLz+32e2ktjmLZvJrRkJUzAzuBl3U630eVcem9nYdWs78UTi6G1/8GhihP/nCiS6emj49dIHCwo
	F07w1LkoLRnpRNHosCpSBbyqjDtV+TcQ=
X-Gm-Gg: AZFdTZcAXagl7VmxiCcK6zIxNCG/A6ya3JaqltpOGAgEZW3eNeL9gmSCFp3CPFRAeuS
	k8v07n7Tc1oFRVBGZnzoXxAgwevgOBIICjYtZsvV1bLW8OKFTNqDdF9u/q5n5+nhsQeFVC+qDCD
	kmL5m/m1/nMHCyWIC/uKSztQYT9PWfxp1FaGzVbiWoDh6cnWWcOzJYktytcntkTv0EUWlw7a3R7
	7af0L31sQpwY1kG5J0IgX8kPb+cP9uo8HwFo8JSlKRg7NXpZL7/nYQoO/XBPVW4D8hhiIdbDoeN
	fOPGCWsldi0E8imi8gdE5tZIXMluoMsv5AOu+3iPyVenZHXXrwybQET8DnzvyUL5avxS4nTYUKn
	VQNn3KxbOGrFcNUjOpABPr6wwqE62yUE9qxN6spZRrO0yK1gXkqK1/Hu0wAYC6YWcXPo56Q==
X-Received: by 2002:a2e:a98d:0:b0:3ae:7eee:15d2 with SMTP id
 38308e7fff4ca-3ae7fa63ad1mr67706561fa.18.1795712621201; Thu, 26 Nov 2026
 09:03:41 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126162700.22257-1-yphbchou0911@gmail.com> <20261126162700.22257-3-yphbchou0911@gmail.com>
In-Reply-To: <20261126162700.22257-3-yphbchou0911@gmail.com>
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Date: Thu, 26 Nov 2026 23:03:19 +0600
X-Gm-Features: Aa3M54pMJJ_YDN6FEUok4MV7qr3Ypgnk5485IR27NNeQwhjhL6TdAKskizbXdfw
Message-ID: <CAFj_506c59K-XDwcvdk4i2dAJZz+B2f7bhWrVx2R6Jgp9B1_wQ@mail.gmail.com>
Subject: Re: [PATCH 7.3.y 2/2] sched_ext: make DSQ iterator stay drained after NULL
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: stable@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Kang Chen <k.chen@smail.nju.edu.cn>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for fixing the 7.3 backport and cleanly factoring out
scx_reset_task_fields().

Acked-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

On Thu, Nov 26, 2026 at 10:27=E2=80=AFPM Cheng-Yang Chou <yphbchou0911@gmai=
l.com> wrote:
>
> From: Kang Chen <k.chen@smail.nju.edu.cn>
>
> commit fcbff7b56a881bbe041b6c5ba12831a3c1ac1bb4 upstream.
>
> nldsq_cursor_next_task() unlinks the iteration cursor when it reaches the
> end of the DSQ.  A later call sees list_empty(&cursor->node), starts
> from the DSQ head again, and returns the first task of the same
> iteration.
>
> The verifier relies on the iterator contract that once next() returns
> NULL it keeps returning NULL: process_iter_next_call() marks the
> iterator DRAINED and treats the result of later next() calls as the
> constant zero.  A restarted DSQ iteration therefore hands the BPF
> program a task pointer while the verifier believes R0 =3D=3D 0.
>
> Remember the drained state in the cursor flags and return NULL on every
> later next() call.  The cursor has spare flag bits and the BPF-visible
> iterator layout is unchanged.
>
> Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> [ chengyang: drop __SCX_DSQ_ITER_HAS_REENQ, which 7.3 lacks ]
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> ---
>  kernel/sched/ext/ext.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 1049a0914d60..6db6ca912bb3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -492,11 +492,13 @@ enum scx_dsq_iter_flags {
>         /* iterate in the reverse dispatch order */
>         SCX_DSQ_ITER_REV                =3D 1U << 16,
>
> +       __SCX_DSQ_ITER_DRAINED          =3D 1U << 28,
>         __SCX_DSQ_ITER_HAS_SLICE        =3D 1U << 30,
>         __SCX_DSQ_ITER_HAS_VTIME        =3D 1U << 31,
>
>         __SCX_DSQ_ITER_USER_FLAGS       =3D SCX_DSQ_ITER_REV,
>         __SCX_DSQ_ITER_ALL_FLAGS        =3D __SCX_DSQ_ITER_USER_FLAGS |
> +                                         __SCX_DSQ_ITER_DRAINED |
>                                           __SCX_DSQ_ITER_HAS_SLICE |
>                                           __SCX_DSQ_ITER_HAS_VTIME,
>  };
> @@ -10255,13 +10257,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf=
_iter_scx_dsq *it, u64 dsq_id,
>  __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_sc=
x_dsq *it)
>  {
>         struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> +       struct task_struct *p;
>
> -       if (!kit->dsq)
> +       if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
>                 return NULL;
>
>         guard(raw_spinlock_irqsave)(&kit->dsq->lock);
>
> -       return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
> +       p =3D nldsq_cursor_next_task(&kit->cursor, kit->dsq);
> +       /*
> +        * nldsq_cursor_next_task() unlinks the cursor and starts from th=
e DSQ
> +        * head when it is called again.  The verifier relies on an itera=
tor
> +        * which returned NULL to keep returning NULL (see
> +        * process_iter_next_call()), so remember the drained state.
> +        */
> +       if (!p)
> +               kit->cursor.flags |=3D __SCX_DSQ_ITER_DRAINED;
> +
> +       return p;
>  }
>
>  /**
> --
> 2.56.0
>
