Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5083CAE75
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367375; cv=pass; b=D9Rg/BiGrfuuOfje6YgxJZUmBbpnLlbvAoM08jYs61WIac+IrXKil2lL2GxPCRkx7PplK8xttGQfsS5zUVieoHLPrIIM/pHZuZWMkJZ1iQr/MU5iwz0ndTXotwOhQK5mCftod/PuQVYjN6p8T2+y78luA30RGBELhNWGR892NDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367375; c=relaxed/simple;
	bh=/OsoJ6WFMuNprCL2My0grk6w6fmGF77nobg7rrCwVqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud97TqJ+aHJjOMsKqsjac4RnNTtksfxsyg4W1L35Y2o/g0IA94oPLBR2u3TQpZpAbCe5OcJQdYfb/y23MLExX6CSQaloVGePARdhHXt6IHj5RkZBNwTEP3pHujJN6NuwBuWdG7FxDs6siGg2oZP5/iqv3YRgnBIsjO4mtFA4GqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6DnQ0Lz; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6DnQ0Lz"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9696319e14dso656965241.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367371; cv=none;
        d=google.com; s=arc-20260327;
        b=JeiyZ8MsITJGlqxx7/e0w1KrwCMYgdX6bCrM+xCZZmuRoOVfr1bvCyaUOPdbsOoYa5
         EkA4aysdgYRJuW2gJVb04CsOY4eHd7vpRdTPn+jF/WbeoyLOzawIi9/n/HsB2/WB59yU
         V1G3ffNp02lzIO0fruZvVXSDvMB2vEf/HgJBt6BbO0K3NZR3VWR5aZ0wC7jTt32JeJeV
         HwKk4xxXh2nzMaxZI90Z6wFfJpaldutPZ7p+lNLm9OzIJg9x2Z7K369UEHvL8zPzy4dv
         Gn5bPT8lI+ZNIj+/WoV33pcbyjauHjHu2YkYi5hhn6kLB0NZd1oel9kfVldosbPIpfRo
         S9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        fh=Fc1MoL0bnsgo9GMqr6SQGDq+ytLp8F9IsUXVB3TRWtU=;
        b=ilypB/nY0jK5Il1GtcqDIQcpaR3yeA6ssEdh12gsmf0gUbi53hcHgme/uey+kj1zqr
         EcLd/MvUb+xiEOuotLWz74Ae/FtY2uXA4ra2oqW2se6ehMD32SZ4fTdt0eeEi4khRzWF
         ZEdOx5ftUwZaNdOismWHUfVqkGZznp3Ztj3jrHyetjDSAlJx0wKoZAjSfBgLD6zJiQqR
         qaDmgExaYP3H4DaySuDiFJXC3AV6PM+lLaPvFkm7ZwhUhOTiLpv2BFc8RJ6rkoggFPcf
         zZOlDseoMwEJ/+Zdbd73+GLPxJxKgSHlb8Gd5PWzk/3KKJ0bbOHla0KcJ6ylgh+N+QyY
         PO0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367371; x=1786972171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        b=L6DnQ0LzA47xitcNNBNQLWHnYPE19sdz1coiB3IPO/kpJ26H9gBu4G9AZ7fiL6XjDE
         AAzhV7AzPcmm07tYax+nxgWDisgvw/2RPlXmp3NHlPhohLxZvPKDtxxFSxL8on2WFyWk
         HqWfBZZEaH9uOM4WnOKc6jhK8JKhf+iz2Q+cj3isgriqdlHWE3KFEDvpiH7/Jt/pDtC8
         k1s8us28Z0vjE5xFRDx1CcrORzfoepNf1JBHaB22jKwvDobhO2sr81fGA6ef+scx15OG
         TJWMs47plcfp+gnGGL737PS/rf/o1BiqqqEr4f/QFDoVrxNSGIbeLVLwMHtTpCbEnP8p
         UOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367371; x=1786972171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NHKwQBIE8Wzfaah998DNpv9XkkL4runk8ryU+O/Sfu0=;
        b=H79JhBM8GI5wb7Rq+MzYNqP56JBnQ4+EAA0WWRoJ3N/0puOzbzTZTFLx+afqDh4hzO
         gwXSO8yrWAdc3BDqRFrn4SOl8ymuVV4qVP8jbz5+9ksn2soXO0JYOuIgUJ/cS9/5jZUR
         9aq8OwkEeXh4JXuckfguNa9wth+BiPGk1pYX56IQLIJ9hNf2JxDJvQfNrl+VUOztkk53
         XPuumuYguSR8CGzHY4koBi5Re48CoLWRCrr9GYHk+Yxa1rdZuatbbRhSnovjLisLQvD5
         1l/8v5W7V0xr4uRIFv+f61Z0/fcawms2qxiIPystzGI8S63jtisYERF5EnHb42qbvYk2
         CSbw==
X-Forwarded-Encrypted: i=1; AHgh+RpLijyI8mRKV1zVLJ9vbXpTm/up/AUJd+JYYO6PraOFF2WNboAU4B/8+O1Lhtumj3cGQC1a/KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMaEzcjYE4KEEilmoX++LIvnuuXKXck6mQA39khnPbMrFxzvQP
	Tr0ZCdbi/EkvdQmAlh73kkXA3I1OdLwRhsJZTCREIsyImvvzkc9kfpM+KCZ0MElmp+dZl5xe5uk
	qtTALTqQVRws9H/qRaXGq2fyizxa5gcY=
X-Gm-Gg: AR+sD12dSs70YFICjb1yC4k56QwcqEwLUwiYfrFCPR926M2Xy4Pj8Lgvsggn4Vzw2Rq
	IltGjMkWrM/PxKRRhY3BfNmFADoW38617VkJg9APIx8Tt+RbiuAo5d2D3sOuMuPgz+XJpjvLFhP
	DdxWMX/nvuv/YACDbJUp8eDrntaA4Z4tgO3bSidXAaRW8arSD8plfiAwZUS4Xlk98I4FyZ3UR9i
	HHabVH9LTBZlpvsTN+1JSYy+vUsbuwRUqwQeReifK6QgmD2TmTiygvodNSJVe1VlqyYa5JbBMzM
	Pzep+HlqMFN9jjACQGzp54dStQ+otp9ClpCJRhGlAuOJtkvYrQNqu3tSFaWMG0nQkMOsrWQFc0c
	VcPbwfwHcyTqwFDmFwWQu0Xx3jl1NahLOZYH4IFyTTnn8DA==
X-Received: by 2002:a05:6102:f84:b0:73a:128b:ea07 with SMTP id
 ada2fe7eead31-760e8f3a718mr10041605137.14.1786367371255; Mon, 10 Aug 2026
 06:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260809043806.2768302-1-yangyx22@mails.tsinghua.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Aug 2026 09:09:15 -0400
X-Gm-Features: AUfX_mzsbeYdYkOlQZHCVgoV17rwfrw_tCfsBSPvbAc2yHIWo94HLmGEcrDrukY
Message-ID: <CADvbK_cv+Wkb5r-8_sGnKsuA5tfErvLoiPZYVN=yXALbWfBOGw@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix use-after-free of cached ASCONF chunk
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 12:38=E2=80=AFAM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> addip_last_asconf caches the outstanding outbound ASCONF chunk. The norma=
l
> ASCONF-ACK completion path releases the chunk and clears the pointer.
>
> However, sctp_asconf_queue_teardown() releases the cached chunk without
> clearing addip_last_asconf. During peer restart handling,
> sctp_sf_do_dupcook_a() queues SCTP_CMD_PURGE_ASCONF_QUEUE, which invokes
> sctp_asconf_queue_teardown() while the association remains alive and leav=
es
> the pointer dangling.
>
> A delayed authenticated ASCONF-ACK can then reach sctp_sf_do_asconf_ack()=
,
> which accesses the stale chunk and passes it to sctp_process_asconf_ack()=
,
> causing a use-after-free and a second release.
>
> Clearing the pointer exposes a race with T4 expiry. Peer restart handling
> queues the timer stop before the purge, but SCTP_CMD_TIMER_STOP uses
> timer_delete(), which does not wait for a callback already running on
> another CPU. Such a callback can reach sctp_sf_t4_timer_expire() after
> the purge and dereference NULL.
>
> Clear addip_last_asconf after releasing the cached chunk, and make
> sctp_sf_t4_timer_expire() consume a stale T4 expiry if no outstanding
> ASCONF remains.
>
> Fixes: a000c01e60e4 ("sctp: stop pending timers and purge queues when pee=
r restart asoc")
> Cc: stable@vger.kernel.org
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Assisted-by: Claude-Code:GLM-5.2
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
> Changes in v3:
> - Resend as a new, independent thread as requested by pv-bot. No code
>   changes.
> - Link to v2:
>   https://lore.kernel.org/netdev/20260808005748.1981039-1-yangyx22@mails.=
tsinghua.edu.cn/
>
> Changes in v2:
> - Guard sctp_sf_t4_timer_expire() against a cleared cached ASCONF pointer=
,
>   as requested by Xin Long.
> - Explain why the T4 callback may run after the restart purge.
>
>  net/sctp/associola.c    | 4 +++-
>  net/sctp/sm_statefuns.c | 6 +++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 5b0ae61..737f8ea 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1713,6 +1713,8 @@ void sctp_asconf_queue_teardown(struct sctp_associa=
tion *asoc)
>         sctp_assoc_free_asconf_queue(asoc);
>
>         /* Free any cached ASCONF chunk. */
> -       if (asoc->addip_last_asconf)
> +       if (asoc->addip_last_asconf) {
>                 sctp_chunk_free(asoc->addip_last_asconf);
> +               asoc->addip_last_asconf =3D NULL;
> +       }
>  }
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index 708fa07..3a8e16b 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -6145,8 +6145,12 @@ enum sctp_disposition sctp_sf_t4_timer_expire(
>                                         struct sctp_cmd_seq *commands)
>  {
>         struct sctp_chunk *chunk =3D asoc->addip_last_asconf;
> -       struct sctp_transport *transport =3D chunk->transport;
> +       struct sctp_transport *transport;
> +
> +       if (!chunk)
> +               return SCTP_DISPOSITION_CONSUME;
>
> +       transport =3D chunk->transport;
>         SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);
>
>         /* ADDIP 4.1 B1) Increment the error counters and perform path fa=
ilure
> --
> 2.25.1
>

Acked-by: Xin Long <lucien.xin@gmail.com>
