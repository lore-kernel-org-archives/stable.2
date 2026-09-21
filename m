Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382874BE456
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010393; cv=pass; b=r3qBzM2kS/UYr54MhQA5GFww6zbPAYjjMPd6iY9W8q4WNtoNZ/oTaPTuY3KUO+ouOGHCavi7tiAQfXh9iZpg6aelRBOrsB9GqgXXg9aFustOD3y6RhDRZ261AyLgOGipA6qJviy46C0OIcnlnzfwvDjv5YiNU55G3mKNAJnJh80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010393; c=relaxed/simple;
	bh=8jhgqHTRxTuuigY866HgjOt1FsE6SLbZhK8oQY2FnVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R++z64eEtrFnWJHsbfPIo/SXmtEjAjeIhG7WfuKN1dthJAIS940KAJo7cun3C1fpCwNJCCEa7OlUmx21UoxTOHSlIu+p/i8heLPeZ7cNtdRsKjIklJJdS6EAMKniKTz+ZbJg85d5+VUGjqMtDwb7WXN/KlXlIDHSMM1QVncLk94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYACQkjZ; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYACQkjZ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so2547705f8f.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790010390; cv=none;
        d=google.com; s=arc-20260327;
        b=dN2PvjsxTH2Ty641BozZr+FzrH+SNHyhJtYbCap4VKoY/V/rdOH1RHwJVI2XNYWWsH
         x8rzy+BsnbTdLS1sT/PmrEhAPPrBdLBtzBXJov7bwhONPKTCms2lgyCYvOpI7IVaL4T1
         UpRWaFkeqJRoQvgOqhHSv+yk52KscgKxbzyU6ydPny+tt+Rwswxr0zTLL1rkt58g6NJg
         L8GwVzXGmmdzgN5RgzxVL4c879BMyzsi6SwsJqt17I91NrplRBiFV+ELNrrA7eB8iAvQ
         m181eeGY6SniJwzJZBWmFijYPpBlQa8oMd2qmM3DlBwabtweXd6gXneT/F+9OzUCemZW
         h32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        fh=yhLnPmiU2wWIVRURfri8tlPs4UMq42dpOFfw4ATYOfg=;
        b=WcuGtPlrPSaigC16vFwF1YjCHDbhomJQQKyi/1ppn8n3c8XEMYIsCpqS0Q+tyFS9dN
         pUFHz9sISAA+WvRVGb2COfGsD2AFb5Wige2ITKotk32SLChjwG2oyM50vPTfYePpyGvX
         ribTmcKwF1hWjX+L5qCqPPu1m4lIfDXE3e/sQ1TYsBHYyTFH6R7qbmfYL6AecD+VKLX7
         r4xXN4nwTcfpZ2z5aUGfkX9ycVfxhbEwUbqVdlgw39NtlJEak7pRUbzZObQNqUwPLg2a
         CsdnIW7c1yg/+/HMa15V4WTbFSnIbGuSGGJFrI87uByuUZxNXgAd0ArvrV3uUYYLBU6H
         WJSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010390; x=1790615190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        b=XYACQkjZJmhEAwd2+zKnldKuCtmQFB6n9FZVYrT4ECiCHPORF4T3SPNibzutvXeWxf
         rGeRqqZN4hpRRjlo1xiXW4ILAGRxJcqWrbRoInvOJFJww7YCZ7t/GeOM7mTw15wFmhab
         XXcUKVlRnHOUZdQud/LJbvczBLDBdTlGBVY349uvE8/BSQ+ZX8i12/31R1fHO9ay+iVJ
         DTyjxC7g0AA8L60vs/yUBV3qtkooZzhvV2VR7wm13tT0DXnbk7Wfo+94TCnu4mcjZ5Gi
         KjUl3UK4GBmp1Jz9jIvOROlOes7i3CkmpWEc9Y1Xfwv2z+4ZqQR4hJ8CLCe7aX8WETFC
         zziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010390; x=1790615190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiS0d1CtQKQd+kk9HZnyknOslzVRUF82l9lMpasjrIs=;
        b=GRlV1FKwvvXxVYPWB7E8VeNWEz+dkmCLM1nIy1BqKQymfEXSq1Pwd+eRkqsipVMaoi
         tJ3VP4ri2Hn026pQI2DN0A9IBez9y8FB1GvOtdc20m+1+jm1xEY4KS77zoPGZ8pHG4ZU
         z4PgSJpnB6B2KtfLWc6w07sJdnYwCtkHBvUmS60Vlzad3ZvOSLAjJvtQ/qOIQhCUcHCd
         NxAjFb21RhYmQrSlnBNDSjjX+I9gHeIpmTbfRUZ6WFD4XJ6PD+l1gV/ltT2iMOU8kJXn
         h4xR6tUr5F1r7TSOoS4zqtR+sTKTmiq+Na+qzfToD7zdF78RZpzkLgVa9KK3MUV1j/eq
         L/MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRSekf/li6kb6aSc1MtXlgLSyc9c3C/dD4q4c4XrG888K1DNJgyevursvDgF+8meeLupSV7oI=@vger.kernel.org
X-Gm-Message-State: AFuF++n4gdXQu8uPXlsTfmTDLB+WS7WKWYahf3Z1enm17FL2L+BOjRV+
	fX4LOHgw/xxZ1ItbjziEBRChpv0Ysb2Txjlkj2rU6cBkoL7Lxp5ivmaJ3D4C6nSyAH+ntK+Pkjr
	Cazb9AVF1WRtHId8AFdbKyUC1KGeerfQ=
X-Gm-Gg: AYBFou20ACUIpAEE4dpHU7xzqrQ2vXaO5g2VrZhw16jHPbm+aUXTiskRvRmqlWB3uv3
	4kAm2wJkk+jv1z/k87D4zdL+UA0P8jxjqwsCj4IOMIxJtiQeUQHxgR0/c5mkckyIiTXNdrmL9Rx
	bRrAviltOQ2o6lwPy9ek0OrYfwNgnZ41TjIxE1L4x4u64DrjAQImR59TGXUc0kR1Ucy0HX7xSxb
	GVXEmxrSyqEtfZLdGPL0sCtFS/xZHK85L1omixjA5XwRC09FNvROo1HY8klti4/a1SrNLVv3SCo
	T0QGyshR2tUuBRsjSvJSqadP1U5V7cldNtsMv/HWz3mhAP27XVsiYj/bhA==
X-Received: by 2002:a05:6000:288a:b0:487:b44:a561 with SMTP id
 ffacd0b85a97d-4871e21231fmr16437625f8f.10.1790010390061; Mon, 21 Sep 2026
 10:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me> <20260912053921.49151-1-kumar.shivam43666@gmail.com>
In-Reply-To: <20260912053921.49151-1-kumar.shivam43666@gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 21 Sep 2026 13:06:19 -0400
X-Gm-Features: AcwNN1UxlKOlhAl4RVco_AYxwNupTP3xOjulgztmGStoHgdH5AIdgx-VsINsQOk
Message-ID: <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 1:39=E2=80=AFAM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> A command that has received all its data but whose data digest is still
> outstanding is stalled in NVMET_TCP_RECV_DDGST, where
> nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
> therefore skips it during teardown, leaking its submission queue
> reference, and nvmet_sq_destroy() then blocks forever waiting on it.
>
> Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
> rcv_state after that call.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> ---
>  drivers/nvme/target/tcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index e59810175262..3bf344b184e8 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct n=
vmet_tcp_queue *queue)
>                         nvmet_req_uninit(&cmd->req);
>         }
>
> +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd &&
> +           !nvmet_tcp_need_data_in(queue->cmd) &&
> +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +               nvmet_req_uninit(&queue->cmd->req);
> +
>         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>                 /* failed in connect */
>                 nvmet_req_uninit(&queue->connect.req);
> @@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct w=
ork_struct *w)
>         nvmet_tcp_restore_socket_callbacks(queue);
>         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>         cancel_work_sync(&queue->io_work);
> -       /* stop accepting incoming data */
> -       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
>
>         nvmet_sq_put_tls_key(&queue->nvme_sq);
>         nvmet_tcp_uninit_data_in_cmds(queue);
> +       /* stop accepting incoming data */
> +       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> +
>         nvmet_sq_destroy(&queue->nvme_sq);
>         nvmet_cq_put(&queue->nvme_cq);
>         cancel_work_sync(&queue->io_work);
> --
> 2.53.0
>
Gentle ping on this one.
