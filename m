Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314B3859EC
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666198; cv=pass; b=EgYId8YhfrstX0SAP+kRk8ztEpZgtB+lLveXFdfyYtKf7RC0bSnf7OddQQuB++i7u/rsrEDsiPSAHkWrG5TEJhc3u/whKT5pazPRqZDfg1Gp+K0mHGAk9MdyXEcovX3pZbiMP/WIXMa+T+j6fTqS9pZ4+5LasrV0z8oo2Pwrtc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666198; c=relaxed/simple;
	bh=3FsesW7qrrCUuDxnT67q/DYl7INNeb4HegPSlzYOH6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEhdw4WqGx09UTBGL5Ic9JKJqOMshRJsT+EUS0h//Q42bkl60Yr9cU7mZe7DYp97CTSb9Ds7wynHgbQBGpBsmNt/SD3qRaXtsaxqFqKNjvkEOrhx60MLUrk7U5UTgMs+A1P0bie+xwqp07NQ/qkAbBnnN4+1+79niDrbQ7nAP88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=C9y2i9r1; arc=pass smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="C9y2i9r1"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a662e5f209so2100011fa.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 00:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790666193; cv=none;
        d=google.com; s=arc-20260327;
        b=s2ce1S9oAE7ZC+Uu/nLZsr1a75RuYrvzD7oGDdX4cCIgKKvlRjlCreRbp6l+m5M+kT
         n65XNXV7hgVdHXz2b2CCdbeQYEVSVMqxV6lcjiNvGnx4sN1MicA8Q9aHC0mxktWuVlGu
         ek8K+buVFSdX5pIJDq3N9Ccl6CynzInfFX0rdKMA+72lD6hjP0kxXVFSwViCdO/20fFd
         XolwvYh2ESNr3LwLXojz1qQF867hfMuRw4OMDsj3T61NUDJq1s81KUq7upq4zfYz04lZ
         d+RjNWCB0jY1jiC9DrqpK2yfOttA7yF75PFcHJix6fuLQbw78c6rKZu3RiD/wrg+T/np
         Leqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhgHZwKUgXgdevQt+gPZYqRRgdry8oanfBmQ6gGzpUM=;
        fh=Z7YoGaTio0VzEszW49Ps3RZWSKxDgJo8SQi1SiTxMwQ=;
        b=P8G8D6MJlV7qrG0SBx6NkUwnUAW5B9Nv/nWONneKaNa6DC1SbQX1b9A/hqWLqZO6In
         ism5mgzWHdFrpAf99cQmISEmO9ZgYgu0AjzJVX12iBIMFjXuNCu4I7clHJ25A2SqjZAE
         y+A8fQofc7I18LFKL/uGprh2J2EyS9ZZWliSqcL+a8uHzSUZlC+8ZXN75VJCUsDgoudC
         N9/DhrRYg1CMaurClaIsYnGhGmr/OXpjoj4pIQ3vdpLirZE4LfKJUazMe0XlbJ0Sj/KA
         eCMfLHGWvQdD5J7qu7yMcCViWanBuPauDn85eaZBSdYpGhWx/EaLi7yvduG4XB5Bh+F9
         /Xlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1790666193; x=1791270993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WhgHZwKUgXgdevQt+gPZYqRRgdry8oanfBmQ6gGzpUM=;
        b=C9y2i9r1j+abclBoOnqaI9fatGircUXum24g0sKw3NK7bURGU2AcCfFg11X4S1oimq
         vE0ApKXR3htEidqDiW7H1dhaOW//Gymqz8yY65NLD/JbZGqbFrTjlKEy9qbNxZDkA388
         9jSreRK9rWJIsYKGFi6s9WWsTNnCq7l6++7Hk0ob7pfA6Ml+wmKwVzmU6HVcKdUISsvQ
         SVRcK3hn2aynHjxca4g5C3p5a454Kuq99xjbM3kXYQoiyYbkqd22gEr1i/3ntFv3DSB+
         OhaSIB774ke6O0Imb8m2BXOj1cPHGbj7ms0kDKV0OpJEFStSZyKkDY5YjjXPmG1YLFPq
         Gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666193; x=1791270993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WhgHZwKUgXgdevQt+gPZYqRRgdry8oanfBmQ6gGzpUM=;
        b=lvSAT0fdP4TklP0sZxQ3NsY7pJXWZNw00qJUdEE6jZcMDoND/k4uw/PYgHlJq2INW7
         ks7htlHEUYCkeTE4IrvF7IFHYPnGGdv7oRbuBNAdBK679BMtiKleKKkvgFbt0gHhXAh+
         eQh8uERsFrVSDUkfzh81Eej4iKEMCrdR8W4zjnWyGN87RehV0cVzX7BHIBJKwZAuzcuJ
         jwHZ5IgVaV7cN176H1rxoFk1LPRKYbJlpHRpo4FERjy9ZfuwoataPpCiX48ehWzzWFNJ
         d5VHUCYY4T2g+aHQPzt8AYqpbe/9iwXZy4mVbttBcu3EvSBUrbsI9+zweyw1k+8yrjTP
         PgrA==
X-Forwarded-Encrypted: i=1; AKwUvBzYcgltVz372OQVTncqf3l5mzuLjfIkx5hlHN9bpUtCyj44sMwgCW26GjKmkpiyCZnZxv57aA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+PJp6VvxHW6MAqIsNIB79/lZHD2FZ4IwUiOvsQi43od4A044S
	2JOaqEKn6kIM9XGrAN3iMA6pypvfaq4OGvOfQTQWbAzTzEVYsioh4b9xeiTbfN3YTZZhjnV9w5i
	K9UQ4lgXIzehV/KShDNamv4tTmVwl7C3rTUJeMg+lkA==
X-Gm-Gg: AYBFou0bunY/KhSb+LF7VDbP0aD3WYQIe93/cbUzCD2gOb7qd3bI47TF67Or+mCn3fd
	WduuRP4L9V4CJeUTox6rIzygfGi5hqnLags7Dkh2n9hfVF68BLiMbw+qPJGxupcWBMyDF7jjTsH
	MjMaPZoOprQCsvuPJQ/7iuoBapa5hkTH8ET5BMn7BjdIJAFzDkDRbEzTprksZKWKCjos+hwL1WU
	3wuh0S4Joksh+2rRlygZEELO4Ja2L38j+uZjRnc3JJWz6s7rXPFJ8Kw7Sfg3SSNNQ25NT3b3Up/
	ukdai067x6LHuJtzgQj3RG4m3KH1gamcCK4Fj1YgDWnFz6AYeGUViitHYuSYKzict2M=
X-Received: by 2002:a05:6512:1396:b0:5b8:ea1f:120f with SMTP id
 2adb3069b0e04-5b8ea1f12b5mr4002276e87.6.1790666193242; Tue, 29 Sep 2026
 00:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929054222.1576877-1-yhlee@isslab.korea.ac.kr>
In-Reply-To: <20260929054222.1576877-1-yhlee@isslab.korea.ac.kr>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Tue, 29 Sep 2026 09:16:20 +0200
X-Gm-Features: AclHuK96qQhAQnCyE5jgVePYa6Ry3VCKnc88oqxBv8jb7K_-AxFU1N1PqJnE6f8
Message-ID: <CAMGffEn6Ou6QhViG+M26iqyVP5vgv3VNPRGO14ydxjeAtc7mQw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: Reject a zero queue_depth in the
 connection response
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: haris.iqbal@ionos.com, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Farhad Alemi <farhad.alemi@berkeley.edu>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yehyeong,

Thx for your patch, there is a fix reviewed already:
https://lore.kernel.org/linux-rdma/CAMGffEkQ8tZZcrLp2Sc7UyZoqAyBoYMdkPhGvHX=
7RGqrwSmJzg@mail.gmail.com/

On Tue, Sep 29, 2026 at 7:43=E2=80=AFAM Yehyeong Lee <yhlee@isslab.korea.ac=
.kr> wrote:
>
> rtrs_rdma_conn_established() stores the queue_depth the server advertises
> in its cid 0 connection response without checking that it is usable.  The
> only bound it ever had was an upper one, dropped in commit 0e8558476faf
> ("RDMA/rtrs: Avoid Wtautological-constant-out-of-range-compare") because
> it cannot fail for a u16; a lower bound was never there.  A server that
> reports zero therefore leaves clt_path->queue_depth at 0, and setting up
> the first I/O connection trips
>
>         if (WARN_ON(!clt_path->queue_depth))
>
> in create_con_cq_qp().  The connect is aborted, but the peer has already
> tainted the kernel, and on a kernel built with panic_on_warn it panics
> outright -- all from one field in the response to a connect.
>
> The rbufs array is sized from the same value one statement earlier, so it
> is also allocated with zero elements, which kzalloc_objs() returns as
> ZERO_SIZE_PTR.  Nothing dereferences it: the WARN aborts the connect
> before any buffer is registered and the path is then freed, and a path
> that already carries a nonzero depth is caught on reconnect by the
> existing "queue depth changed" test.  The WARN is the whole of the damage=
.
>
> The in-tree server never sends zero -- check_module_params() rejects
> sess_queue_depth < 1 -- so this needs a hostile or broken server, but the
> client should not rely on the peer for that.  Reject it before rbufs is
> sized from it and before it is stored, but after the existing "queue dept=
h
> changed" test, so that a server which drops a nonzero depth to zero acros=
s
> a reconnect still takes that path and still disables auto-reconnect.
>
> Reproduced with rnbd-client over soft-RoCE against an rtrs-server patched
> to advertise queue_depth =3D 0:
>
>   WARNING: drivers/infiniband/ulp/rtrs/rtrs-clt.c:1688 at
>     rtrs_clt_rdma_cm_handler+0x1b27/0x29f0, CPU#0: kworker/u8:5/56
>   Modules linked in:
>   CPU: 0 UID: 0 PID: 56 Comm: kworker/u8:5 Not tainted
>     7.3.0-rc5-nvmerdma-atk-g72d3fcf802c4-dirty #23 PREEMPT(lazy)
>   Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
>     1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   Workqueue: ib_addr process_one_req
>   RIP: 0010:rtrs_clt_rdma_cm_handler+0x1b27/0x29f0
>   Call Trace:
>    <TASK>
>    ? arch_stack_walk+0x94/0xf0
>    ? __pfx_rtrs_clt_rdma_cm_handler+0x10/0x10
>    ? ret_from_fork_asm+0x1a/0x30
>    ? process_one_work+0x6b4/0x10e0
>    ? stack_trace_save+0x8e/0xc0
>    ? __pfx_stack_trace_save+0x10/0x10
>    ? __kasan_slab_free+0x43/0x70
>    ? stack_depot_save_flags+0x29/0x7e0
>    ? worker_thread+0x45b/0xd10
>    ? kthread+0x2c8/0x3b0
>    ? ret_from_fork+0x36e/0x5a0
>    ? _raw_spin_lock_irqsave+0x86/0xe0
>    cma_cm_event_handler+0x3e/0x240
>    addr_handler+0x1e0/0x300
>    ? __pfx_addr_handler+0x10/0x10
>    ? pick_task_fair+0x46f/0x1a60
>    process_one_req+0x10d/0x510
>    ? finish_task_switch.isra.0+0x1d9/0xa70
>    ? __pfx_process_one_req+0x10/0x10
>    process_one_work+0x6b4/0x10e0
>    ? __pfx___schedule+0x10/0x10
>    ? __pfx_process_one_work+0x10/0x10
>    ? _raw_spin_lock_irq+0x81/0xe0
>    ? __pfx_process_one_req+0x10/0x10
>    ? assign_work+0x11d/0x370
>    worker_thread+0x45b/0xd10
>    ? __pfx_worker_thread+0x10/0x10
>    ? __pfx_worker_thread+0x10/0x10
>    kthread+0x2c8/0x3b0
>    ? recalc_sigpending+0x15c/0x1e0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork+0x36e/0x5a0
>    ? __pfx_ret_from_fork+0x10/0x10
>    ? __switch_to+0x572/0xdd0
>    ? __pfx_kthread+0x10/0x10
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>
>   rtrs_client L2644: <s1>: init_conns() failed: err=3D-EINVAL
>     path=3D<invalid address family>@ip:10.0.0.1 [rxe0:1]
>
> With the check in place the same server is refused without a splat, and a=
n
> honest server is unaffected:
>
>   rtrs_client L1870: <s1>: Invalid RTRS message: queue_depth is 0
>   rtrs_client L2649: <s1>: init_conns() failed: err=3D-ECONNRESET
>     path=3D<invalid address family>@ip:10.0.0.1 [:0]
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Closes: https://lore.kernel.org/linux-rdma/CA+0ovCg_sG8gaZXXj9zmOrpxRt=3D=
8+-x9wvycVNUKwWmMbr6-Yg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index eac38b57b00d7..5c2c65c15a65a 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1866,6 +1866,11 @@ static int rtrs_rdma_conn_established(struct rtrs_=
clt_con *con,
>                         return -ECONNRESET;
>                 }
>
> +               if (!queue_depth) {
> +                       rtrs_err(clt, "Invalid RTRS message: queue_depth =
is 0\n");
> +                       return -ECONNRESET;
> +               }
> +
>                 if (!clt_path->rbufs) {
>                         clt_path->rbufs =3D kzalloc_objs(*clt_path->rbufs=
,
>                                                        queue_depth);
> --
> 2.43.0
>
