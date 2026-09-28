Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8D4DE716
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609439; cv=pass; b=nXTs6u0UugXCC9FkK15Vn1tDMH93s0gzfiQ0djsPQvll5mPXPNVNoN8/xuO9sxsqqN6rHzhiuGjRjoE4MM1uoMWpqZt2xwMvM7CFL1YFq5iJ+nVpA9FfAWtYR3gtFMe9mEItf89pEHvPNAgzX6X+EHL5Np2anrRmFx1gDSnAaOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609439; c=relaxed/simple;
	bh=gZgMmy9iAMgkBrxlGAqSHgLuQfDEbw4L61apoLC/Go8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NglhQPDtaQX5SGKg5ERh+S0aBs8itR6Iy/S4JQCII4snVDfPOaIR7tvG1Ks46tpFWak5FVcEBmf12zNdeNlY/bHT7ZYxrhbahKlUKtyKrqfqvuoKb7SKC9p63S10wLtERMXd75AEHWaDtiQ2R9Kz1zve0s+EtGhggjqg+Wg+zZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4XVAUld; arc=pass smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4XVAUld"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-482f635552aso2527819f8f.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790609436; cv=none;
        d=google.com; s=arc-20260327;
        b=sG57Tj8AZsbOFQDNy651W6iHqTGp9bfsJyrPU/HqkRrlHt+PYmtCbIRjpB2mR+VGiM
         W8HhEXOkl+sFeEGS94RPXJQ01kohnu64PD5Mob/CfpO8rHyUTC+ON+0wqibdh6VLkSw2
         IYpLq3CLmO/Jx5glyWIQAMSUmyJeHgJFQ6RyjhxfrkZN1SD4WNR46og7Vb3zEfY7XZv5
         Ym2+a8tUT1sbyEc2Ey+84laNepLuAbHReaDPfZp0Hc5KYXoGjybU+FHWpVkFbtOgICu1
         GORWzxWVxb76E33hCulhIrIcu8Yb3AbM5I1iwoFNc5IdKlQ2gCfEJQEO3jAj7UqLKqh/
         8BXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        fh=JsVAAXUWf+Sp694KLtexPi228w6AF0FTKQbhKP6Fu98=;
        b=PRoMlWpqIdMm3haU7yNFq/jhykqF6AK7A9cExu3aZqBUgEgJULLUnenrnfZsrKbomK
         HUhJhYXkmQyiwG1FghJ3Ksyo2h7WUE003xl/DBp8RuyyP50cKVXGtYwTU0RMq97a9upQ
         eICA3b+YWybbbul2bnB+Y6i52NtZGhKmadHyFVsRFA5gi3ne1x76+NHtKb/Q4n3QU3RF
         VQyJA2M4lxHCypTPdwqLMq+dihFo+QuM58K/u/a0qhgxQt3wUVPAklxwmDJ7bV7pty/N
         pC4blhx/BxA/yYYejRgUWlhsRAOg/Lzd5ZVBZ2Vu5O8sV0HjOOyNjwtez5JRVizJdSPY
         GRWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790609436; x=1791214236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        b=O4XVAUldfBCKV2kbOeqMguuL8bQ6zwlsdrZJr5WfLH1S1IIxFPw6bhuBR7oMP8j3VB
         gYkXgm27xU+wVSZwHSpYgpxZ/J4VDMP7env5IeMAnvJdh2n9otnPewLJEXfCXRshMGv6
         mqqgXxqulAqen9z2626QPbJ31HYXfen/z0ZHGVfpqkyoI5sQJhOVNDZ23Dse8e1etmG8
         uDkVHj5DeQvtmSW1h3rLd+XFiliYfwKRPp/+fXZOpkrgmudH0Z2Zj5C6dItYvGmMcqVu
         OBH9YcO/UeErO6+rtUd56PmPlpxTvwFRyFJJI03TPmDimj+XDm5c/bKihEq1IiQfrzn/
         +FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609436; x=1791214236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1sUtiuOaBXEezf3iViA9gUAl7eyYpT11jnOSB4ZV8M=;
        b=uxT22si1odaHB+c8pMUiJ9x1MDcgBjYBWIbz+/lfZd0h2H015Yn2uM4q2/D+x9PTSi
         25AvW2mX7hdmndDvO8snSSzXk3riKxnydMLkwWcOeTLR+onmzpXlUCNtB23LL5/PP+5H
         oEG1h9D1MrBiYGad1lKyao+5yXDDIAPf9ALLSWwNSc9OjPxqN/iW4qIvHPPqzdBAR350
         n7XE7KJt3pvvovUkzh3OQtvmotIaB77Q2e30uDb0XFB0cjd7SZPahkvqF5czltjKF2QH
         avmdUKgWTeDOZmh7DDfgKgZlrRE2WliYixHihFx0k+AucwyOOiCKYZ6iyb4vUnlfVjWX
         bURg==
X-Forwarded-Encrypted: i=1; AKwUvByGfV8hexmBMTFKjBJ40Sn4wzCd9iF70gyCKdAVOGhtHHWcBEyxZNpgjre5aRbBLmNaycb1Xs0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW2TrOaRhz9VwzYRA0u/BUyMZgOYxZxOoHYKgJocvl0sPmuIWc
	PQ8gwPqNPkk/QJHsME20jbChp1w2VswyMzPOXirRhuWXefbs7ELIYwisgA9OPENA2CL8tAHHYPT
	j2sX/VX8izhvzhZNCRZq3m1RETUJTltg=
X-Gm-Gg: AYBFou0tbd+TUpmzujgOXKW47spqBFBBD0t/k6PfxhF6ZdsFhW2PxvgS8VHYmRJfQn7
	9tHI91VeTCQKO2lam1PRB8qizV7V3Y4T78pdQQyqGDttJUCVz35/lMWZ+zo//YPp1wA1GqGBYKw
	o4ThHJtVBJFOADlVi+jp6Aa/KZlCnQvGe00oEQwUcNHAJlFI2ZqP3Mq52E7DYUj7u3qAIhywBIq
	qWdupCmFTcTIvRZfVv7/8KzuoVX7chcEh3C0GsbG/X1eWuG2PEbP/4R6VYXWTqLcKeqPEw7LvBJ
	fFsX6/FLjIljIchAqT2xK8TVLGSahthO3xnASM73XDuP7sP8jIRaGdqIU1Aj63PAEo9Atw==
X-Received: by 2002:a05:6000:4202:b0:488:8864:e2cc with SMTP id
 ffacd0b85a97d-4888864e5b2mr12975651f8f.26.1790609435839; Mon, 28 Sep 2026
 08:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d040bea9-711d-4638-9d64-50516709b41b@grimberg.me>
 <20260912053921.49151-1-kumar.shivam43666@gmail.com> <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
In-Reply-To: <CA+ysrS+a_fsst35-V0YDD00LWT9NaHkO0A9Zrko9EQ8NEwzRBQ@mail.gmail.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Mon, 28 Sep 2026 11:30:24 -0400
X-Gm-Features: AclHuK_EFO-MrMNQ8EFUgp2EHKyxJFqvC1p70t-79Pi28sirn3E3ngQLYs1JnWs
Message-ID: <CA+ysrS+xp10hJeCKy70BirjEDengQvZw_o6X6fSUAh5kVGYCeA@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet-tcp: fix a hang on queue teardown with data digest
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:06=E2=80=AFPM Shivam Kumar
<kumar.shivam43666@gmail.com> wrote:
>
> On Sat, Sep 12, 2026 at 1:39=E2=80=AFAM Shivam Kumar
> <kumar.shivam43666@gmail.com> wrote:
> >
> > A command that has received all its data but whose data digest is still
> > outstanding is stalled in NVMET_TCP_RECV_DDGST, where
> > nvmet_tcp_need_data_in() is false. nvmet_tcp_uninit_data_in_cmds()
> > therefore skips it during teardown, leaking its submission queue
> > reference, and nvmet_sq_destroy() then blocks forever waiting on it.
> >
> > Release such a command in nvmet_tcp_uninit_data_in_cmds(), and reset
> > rcv_state after that call.
> >
> > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> > ---
> >  drivers/nvme/target/tcp.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index e59810175262..3bf344b184e8 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -1608,6 +1608,11 @@ static void nvmet_tcp_uninit_data_in_cmds(struct=
 nvmet_tcp_queue *queue)
> >                         nvmet_req_uninit(&cmd->req);
> >         }
> >
> > +       if (queue->rcv_state =3D=3D NVMET_TCP_RECV_DDGST && queue->cmd =
&&
> > +           !nvmet_tcp_need_data_in(queue->cmd) &&
> > +           !(queue->cmd->flags & NVMET_TCP_F_INIT_FAILED))
> > +               nvmet_req_uninit(&queue->cmd->req);
> > +
> >         if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))=
 {
> >                 /* failed in connect */
> >                 nvmet_req_uninit(&queue->connect.req);
> > @@ -1636,11 +1641,12 @@ static void nvmet_tcp_release_queue_work(struct=
 work_struct *w)
> >         nvmet_tcp_restore_socket_callbacks(queue);
> >         cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
> >         cancel_work_sync(&queue->io_work);
> > -       /* stop accepting incoming data */
> > -       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> >
> >         nvmet_sq_put_tls_key(&queue->nvme_sq);
> >         nvmet_tcp_uninit_data_in_cmds(queue);
> > +       /* stop accepting incoming data */
> > +       queue->rcv_state =3D NVMET_TCP_RECV_ERR;
> > +
> >         nvmet_sq_destroy(&queue->nvme_sq);
> >         nvmet_cq_put(&queue->nvme_cq);
> >         cancel_work_sync(&queue->io_work);
> > --
> > 2.53.0
> >
> Gentle ping on this one.
Gentle ping.
