Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793694827;
	b=uArQ4Gl9BEGqMLLz1y0BpffbnYJNmZ3uDUTtxq9iK765eX2BFqiXeV3inaUlnAqLq2Qc
	 K1bq08EiUR3EU9pYuerqKIC2PKUm+QYvs6PLiyLKOoaS2YszTOahFcvZy5njb/S+m9aDz
	 jjvsUvXex8QqEm5nmXHigLY0MqYIxhVN7GyrC/+rgXYUyf+jf4XoAP33vhQKnqz1m9KIv
	 Us1udNQ6JEK/3mwbWWpHFd35bc4T28iiqgskMxlVok0ts1x3Ge+1P2OfcBi3M17GMYvjI
	 77Wt5ZEdiKCpZx6e702iyriGnNeHAqVwRVkEpS8ba2+NwMs4jWxkT0E3F6Y8P2IBhDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
	b=X3sCbK+q5P7GM6zunPJYXZb/lX7ns7UfjWCEWWpCux87VDWz76+hXArDBR2uGim/rGks
	 CrvQ3Ok05GsLKWflDec8Qz/e4QBh/EiwgfcxsXxXEszmHi8A/O4ec0lTs3XeFqqeTBdFP
	 53DaiLm2SbbUXTXmQQNbl8RddgGOQKBvSMKdGJKNt0IK5KrrJjoU3X/fwueyhW7FA2z+o
	 OXCTjJMj7PQhq9BxhIZ31Sqh3O4a4jytN1bwzMbwwuc9EuYQ0yoCgt8+xf63YOK2AV8ld
	 auoY+pLiD36AEQlKUtN3YmGx6JdKfIvMtaw5Qk/5mBi2toFTlPYjGKDIT8EJkoAPfqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpKRh5iM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9D6076BB4
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F9D6076BB4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VpKRh5iM
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so2103568a91.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:33:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793694826; cv=none;
        d=google.com; s=arc-20260327;
        b=St0LHljgBPoFKoDmXBwp3YMx6nV4/VBmeGhKt+698VcOlWoPcc4PPoz87yXGiLHeqf
         hFrYi17JflQ3zLLO8/6JxkZUw8ree37B4e2pQhBzJZBbCS08An6jiAA8LBR2+0FLVOhs
         D/g38EFXZRrj45TdACJAgsJ2tEV0zuvZ5VQNz+1iq5VnlJJqk4dBpinR3ALNRwMtYeKR
         9XBKOGWAkgnKylLG7i9yCZdIz9TmkLYWsjb6iakD+a+BLcx3S1xhvCyagDPPvPRI4eTl
         JpDtoI57k8lk++6oVajTCW19jvLnOAHaA9Q+74uERkcRAa64juK+42NlJM2UTeyBK2mN
         WrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        fh=YfT1h7k7+a8MN5ZHdvw6y+rntkd9+CaNTz1OP5xDklA=;
        b=QUE/yHMgcr9NECavRekHTkJYguc1QdvxruhAsi+tsQMWZM0CXMx0gaCvbSxYoasE1X
         2Wg6iCdv1vICBUV+F1QCl3n5znuqE3FClBxdEauA0YzYml0DLNg16utTuHvbTZefCVe/
         U4ghAv3O4/8P0j/aQ+ajlsuYMryIcmlDP42K6JlwC65N5fIHeHBtRPFya2LZjCspWji0
         l4D05f1CCMhjNjQYxGda7T60u9/X08sdAQsQQ6AMgVwdP2xjt0ZTX9zzxYDAuBE3Z3Tw
         QO3RsTYfCYQskX6xFGfJY4RtnKyA/+G6OIc53SM640fUewQV0/7wHrpxina2Gx/oBOkq
         Zcqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793694826; x=1794299626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        b=VpKRh5iMMk/uDrxhCUU+vgVGN8WWGzbo1owdw++3mPZSar70R5Xp3muHRKWC4ssocD
         IsNAJjccanDWxOjWHzQVA31b8YG1buwVNtZnkM4Voz2Ng4zrcFn5pQcZ2WaW0Pucq8wu
         mfqEBP+8X+Abmtx2BhkgfuVox5Reino5rFZUC6QDOR+GwjRRarjUxEFv5HPN7vCbFRWl
         AoGh4tc7INzidBgkx6NDuEB4l1Lo5bUQczEhKFdGeGn+0wDZsOgG+6ujrNPxXdQlfQgW
         7CkruBMfViCHcqnqyQvMKV4BNUg/MOuTHYmUZCdVWu3HU/Wl+juFJ4AAxMATWj7OIDb+
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793694826; x=1794299626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HwF4S5bxm2j9EzIyz1SC/J8IudB+3qt9yXUwER1aUJM=;
        b=GwtL/Y9CsBPHXNRfvufbR+akNE4gN2x3ZuXQoZ4CrDB0FAAaOrwSyeysm3S0QTlaMA
         byoC3RARcFdmV3TwXePFXGHOAcOzSK/CCk0qqVEqQ5ICTToH/k05j6SSR1zydZz5lXms
         6gsEQYdxd4eBVUCEFpeJrS8jrNWiBJVPadatg459IF/Y5WQxpb2mfJcB2eVUhHNrCvL7
         8UjFUOs4XYbWiquDa/YUohDfqSB9YVK22LV5gB4C2ok/Ml+EZ0ZTjFMoByQIm9kVMvg9
         +MaELVEyIV5YUiHDIXMpIcsex+C8nI89SES29fsTAUUf0wDWpY3adW4hcMaaxPfbnqPT
         +iqA==
X-Forwarded-Encrypted: i=1; AKwUvBw+E3dX7qzl6ThpXXiHcYQ+wO7zWEww016xXF/oJ+CV1bcKgKoLkzNKF4H8hoGPB7LqM5PiMAU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0b+WLvnzcmzqNndc+yYTWPMxu7lPfp9v17EYnO/BIMi5DmcYd
	2uyOKjb+sori0zwPHDDb8pfqjINxk4XoYakt33JVw4WK1r0ekSb0O2bEz4vg+msal0otMVpUCLm
	3SobhbjbDqsgP84cxCJLzBOdg1cHKacdT20w5zwhI
X-Gm-Gg: AYBFou3stOmmJ+dBBNcMMPBHDNEJVrwXcZTJPQXezuxNkY5yWoVUmTd22Lm7/1WCRuU
	9wKJ8BU0V8z3uEL9vjzNdkmEKXyJiQ1ZMnKhR8Eo+RtgX0C8tKaAQZAS+m07HCsunXsnLUF7GZY
	uV5Uz0YDPu0R4SwWIM0uqVapbFGlSZ486bfUjF8KqpxZ9jCaRI2PKF/gOa9RkyYcINOkcaNJaOe
	utJZJPMVEYDox5TlvWUFHv5DQpVqLrUMpSA+9OMSeHc8xUw4EhO68BfZL5/NEJepiafa+niI97u
	2kzMohrLiZjnX7icKEcaXaKLbhUhr3U1rqlEGUcphz6Z8mZN3MLnCAda6/F5b5NQylPZEGaoW0V
	p7rThjc8QWkr0yDRoHKwCBf3ie1SU0rwJaFDs
X-Received: by 2002:a17:90a:e7cd:b0:3a0:8050:2ec9 with SMTP id
 98e67ed59e1d1-3ae897ccf9dmr9830837a91.16.1793694825021; Tue, 03 Nov 2026
 00:33:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029211634.2232784-5-hramamurthy@google.com> <179365432386.3131.15374369453099115031@kernel.org>
In-Reply-To: <179365432386.3131.15374369453099115031@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 3 Nov 2026 00:33:34 -0800
X-Gm-Features: AclHuK8zM-JZ_3yaCoKIW6N5v6Mma-fZLHgYVCQdxl4X3qkS-7jYnU2RPPScwO8
Message-ID: <CAHwYsip2mYupJp3a7JhWCHX9e7U7hHGmqrAGSxzRDBuN_RJJ+Q@mail.gmail.com>
Subject: Re: [PATCH net v4 4/4] gve: Fix link flap after ethtool ops
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:18=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The patch removes `queue_work(priv->gve_wq, &priv->service_task)`
>   from the end of gve_queues_start()=E2=80=A6
>
> --
>
> gve: Fix link flap after ethtool ops
>
> This patch changes gve_queues_start() to update the carrier state
> synchronously through gve_turnup_and_check_status(), instead of queueing
> the service task to do it. It also takes netdev_lock() around the link
> status update in gve_service_task(), so that update is serialized with
> the synchronous path.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index b5e2f39a903c5..bc7d7c41948c3 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -1494,8 +1526,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
> >       priv->interface_up_cnt++;
> >       return 0;
>
> [Severity: Low]
> Commit 3b7cc73628ff added this queue_work() for the link status update,
> and the new synchronous check handles that. Does removing it also drop
> the service task run that used to follow every reset recovery?
>
> gve_reset() clears the reset flag first and then disables the service
> task:
>
> gve_reset() {
>     ...
>         gve_clear_do_reset(priv);
>         gve_set_reset_in_progress(priv);
>
>         if (was_up) {
>                 gve_turndown(priv);
>                 ...
>         }
>
>         disable_work(&priv->service_task);
>         ...
>         enable_work(&priv->service_task);
>         err =3D gve_recover(priv, was_up && !skip_queue_setup);
>     ...
> }
>
> gve_schedule_reset() could run after gve_clear_do_reset() but before
> disable_work(). One way is gve_tx_timeout() from dev_watchdog racing
> with gve_turndown(). Another is an RX NAPI error path just before
> napi_disable:
>
> gve_schedule_reset() {
>         gve_set_do_reset(priv);
>         queue_work(priv->gve_wq, &priv->service_task);
> }
>
> In that case, disable_work() cancels the queued work, or queue_work()
> is rejected while the work is disabled. enable_work() does not queue it
> again.
>
> Before this patch, gve_recover()->gve_open()->gve_queues_start() ended
> with queue_work(), so a leftover GVE_PRIV_FLAGS_DO_RESET was handled
> right after recovery.
>
> After this patch, the service task is not queued again until some
> unrelated event, such as a later gve_mgmnt_intr(). When it does run,
> gve_service_task()->gve_handle_reset() would perform a full gve_reset()
> because of the stale flag. That reset could happen long after, and
> unrelated to, the event that set the flag.
>
> gve_suspend() and gve_resume() seem to have the same gap. They call
> disable_work_sync() in gve_suspend() and enable_work() before
> gve_recover() in gve_resume().
>
> The other parts of this look fine. A missed device REPORT_STATS request
> only skips a stats_report_trigger_cnt increment, because
> gve_stats_report_schedule() sets do_report_stats on every timer period.
> A device RESET request raised inside the disable window is covered by
> the reset that is already running.
>
> Could gve_reset() and gve_resume() queue the service task again after
> recovery, or re-check gve_get_do_reset() once the work is re-enabled?

Yes, this is indeed a regression introduced by this patch. When the
reset/suspend races with the Rx NAPI polling error path, the reset
will be delayed until the next service task is queued.

We will add an additional queue_work() after the
gve_turnup_and_check_status() in gve_queues_start().
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261029211634.2232784-1-hramamurthy%40google.com

Regards,
Pin-yen
