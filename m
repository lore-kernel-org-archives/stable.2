Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D5455167
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338932; cv=pass; b=CEz2u37/z0SxByjQStZ05ApV+vZcn7GeZYKNKzK0SlgTlAKzcVkEmdpV5yhfPkNYd431Cw9pdRIN2qfK60FXiaLSoHr2acVkGbmOpT4Xl9QTqs5QnOqq0wWyWdE9lFfph+urlHV47eCK0yy7Hl+YV6xDjuQ3Pq8VgcYY5iAxlRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338932; c=relaxed/simple;
	bh=C6R/o07THPKaUY0DQJZ5/BVO3pGAOQVKEDgT/HGBRcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OskpYNBPTbUk+bt+4L5B0OsqnNkWz0JOkK28rkK7ZJT2SGgb/8pjVzLViO9KlXiK/RaI+klToTp12YBjWDlV9y8wGOUIUybkinKDvZO213TEgYlr8kTcsuzZHCgtxZcsAgaC4zhXwYqSCzNnVP2HQN2YvORc9kGVwgv35+yAUVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=eVeTdH/c; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="eVeTdH/c"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c74722e27so11931821fa.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:28:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338928; cv=none;
        d=google.com; s=arc-20260327;
        b=qqjO920T3BJjESyoYNQoZTN8kUl/yONxMP6zFa2tJILIDW2lYCd1PjnaYS5vZMo9BN
         mUy37xYsip7Z+CemnwLvS9PUUDSuyahqiCht7a8YZWkPWF8mqVGt+mWRNK3X5oAbTuho
         jQuPbH/6HnDvgm0dGTngXqFpV4eRVeI5AFjRx/SpA9mRdX6poSmRRzU/mHetKPJVoQDr
         il17L/WAAxri9fN+QhtF8Jm7HgqZF/Ly6TUfmjTRowDJNJYvJsoyZTBTFw23aEtoI1co
         ohgPZ4nT0dUW+UuP6+YfKUdwgUp/EoRQkirxVCRcdGwrhenxCwP/Ehzm0ABY6VTYkt/9
         jF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bk2WQ2GjrElQ8urTZLjvYR9a94JRaLak6rNQmM8ggPE=;
        fh=lUyuudpJO/OtbOohSEywrJAN+RSKxL2tpVsFTUIC/iU=;
        b=GNVwyXjke1sTfepX9j5fUdDwUgQr4lfNw2VPBDctk+B6bio0CJsESvJCzthVeL2LCM
         Dz2xZqsgk535otM3BYHqPB1sEzX3x17u/dTzg+c9q/kpVMFxFz1VW6E2tViDqrWZMpFe
         R4axwlLvVnE0v+c8grVUXTYwbq8Fht9CKbIaVGvJPD4hfKrQZdQWgktJTsVSL/PrXwMp
         TaIFMt2wl8NxS/gdvUmur5TaHCarsXEMMwZ1gwYx+Ky7jwglaSqikRdI/kW4srwbKgi5
         QTY1MoEDdZyyjuobtso+JCn2hFIFOPwklfqMo5amWS3j2KP+m4Qe0n2xq5lPS4hjze3h
         36Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785338928; x=1785943728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bk2WQ2GjrElQ8urTZLjvYR9a94JRaLak6rNQmM8ggPE=;
        b=eVeTdH/c78UYWKJqJmYBWEHeI1yzKrrTk5QIIgL+NP3rAWbg7ex1ta23i53hDl4YmW
         3hMw288ZGdPgVzXbApRTyX57p2BryMSR1xuCVDgFThx5dYj5fRsrH+4NtH5YqL/mbZSs
         dLx04tFLwxn76QoJ1wlIikOCyysBUKYW/hkRC3Kl1gTOfUmJIJkYXU+8WBXhwGRWlFAW
         3vS/tTBPMms6TVZ7wZikAfkUrP01l4AiYz32bIxuyzKy+JqAUTqfcPpuR8CE/Yt3H88t
         ixQd7fWko9z6FH6fiaIk3w6LG9AhH/82JWXi4wJTyvyxrA/Sas5DpAVm4sSUzbjIGSzY
         0Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338928; x=1785943728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bk2WQ2GjrElQ8urTZLjvYR9a94JRaLak6rNQmM8ggPE=;
        b=L8PiKfRoQbJQjOYCyrBj5cBcIgZoFdnc8DJmK8GjndnFGc6W/MKHT7S22vg8f5YNeb
         XkgJF7JexYcMnuQaXs+B3asiVLx9FaGIEw77VmF4DnUW2cxgK9vehBGu/lJ7dW9N55Lk
         SxI/DHWlaOKvBirt5KMqJ8IrCJ0OrsVQc3eqjVlZ4exmJ2wqlPeciiMVwwxSs1m0Pe12
         UJJkjdZ7TQV/QkoWlCEGdSNc1IUu9Dj5S7M/43hdl+JfKdgIWsrOinZaJuMKtfXxkuJU
         mVhXPTb82fXk/ZEiGH6TnKQfmX+jCACWR0di3trqXQ0m1z3CQzLHoMzeJ/ZVFXTI1JQr
         YM0g==
X-Forwarded-Encrypted: i=1; AHgh+Rp7o5RR4CpES7jEtwG1b3dpzdichF57zIzeqAPKFPhfcrjimnIpKtDtU2zB+hzH8+NfWgryYws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEesjGMCTk6tteOVpmmcFcgeWVcdN1FcK7UlSoMHydpwiqELiK
	wFqrOh6IIqUo7C9v/xyHXYBQivN3QYRZIpY/8TEmj7MT5ZUWkYevAwdJwh25L+FS4Ku4ydrfkga
	ufUlEUAOUdMQ7LK494ptlGktrJAhZMJUPtLn1kRMhCOk=
X-Gm-Gg: AR+sD10VcBu7AlShGWJG/D7w982EI34/Zrv3C+0fUiK0jm2nycfwcRBLiMZOwBJhzEP
	+G0PNOQORv/ejdzs/vW3tAwQmx00MNrfHuWSZYi3gi8VibRhKo2XVYEvlX+1kCX4l5JpUX7UtSb
	sa6Il9rWeqJtduT0XzkFIAQ07ARgAotkBn1bYF+mi1mNUTnQJkA32CLVo+5h37LL8s7Q6GIU7m9
	oAopWRWjQc4+EC19ye5FilTZngi7LCsxLuE7Cn4sBpzv+I8rXXtwBaeFMLLviqZx1s6lGeY/lsN
	MJ5zEHAw+bNc2lH/2l507IGvifQ19bwC9gZS3DP8m67pNE/506pU3Q==
X-Received: by 2002:a2e:b017:0:b0:39e:bcf4:419a with SMTP id
 38308e7fff4ca-39f6058be4dmr5587991fa.5.1785338928506; Wed, 29 Jul 2026
 08:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785307980.git.zihanx@nebusec.ai> <b9b0022c68b6d0ac1a729f768466e3400a825a87.1785307981.git.zihanx@nebusec.ai>
 <amoVNFtNX5mpbum_@strlen.de>
In-Reply-To: <amoVNFtNX5mpbum_@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 29 Jul 2026 23:28:36 +0800
X-Gm-Features: AUfX_mxe4sRXouHcR4pSk1Bo3uWvGfQC9V--4kk-W--y-MegDLaNaVyOTDw84tw
Message-ID: <CAANe3eQHBikBexNfBaKpfUgzP8iXM=bf_2Xj7pFnT5yJRbOQUA@mail.gmail.com>
Subject: Re: [PATCH nf 1/1] netfilter: nf_conntrack_tcp: defer invalid logging
 until after unlock
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	chamaken@gmail.com, vega@nebusec.ai, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:59=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > nf_conntrack_tcp_packet() can log invalid packets while ct->lock is sti=
ll
> > held. This happens both through tcp_in_window() -> nf_tcp_log_invalid()
> > and through the NFCT_TCP_INVALID path -> nf_tcp_handle_invalid().
>
> Correct, this is a bug. While I like the general direction, I find this
> patch too large and too complicated.
>
> Please consider making at least two patches to fix this.
>
> - One patch to make nf_tcp_handle_invalid() return bool, then log
> outside of spinlock().  The timeout doesn't even have to be included,
>         you can change the message to omit it (e.g. lowered timeout to
>                         UNACK or whatever).
>
> This will help with review and it will simplify this patch too.
>
> > +enum nf_tcp_invalid_log_type {
> > +     NF_TCP_LOG_NONE,
> > +     NF_TCP_LOG_OVERSHOT,
> > +     NF_TCP_LOG_SEQ_OVER,
> > +     NF_TCP_LOG_ACK_OVER,
> > +     NF_TCP_LOG_SEQ_UNDER,
> > +     NF_TCP_LOG_ACK_UNDER,
>
> This is fine.
>
> > +struct nf_tcp_invalid_log {
> > +     enum nf_tcp_invalid_log_type type;
> > +     u32 value;
> > +     u8 index;
> > +     u8 dir;
> > +     u8 last_index;
>
> index, dir, last_index no longer need this stashing once lowered-timeout
> is solved as outlined above.
>
> > +struct nf_tcp_invalid_logs {
> > +     /* At most one tcp_in_window() log plus one lower-timeout log. */
> > +     struct nf_tcp_invalid_log entries[2];
>
> Same, once the lower-timeout is handled differently this is not needed.
>
> > +static enum nf_ct_tcp_action
> > +nf_tcp_log_invalid(const struct nf_conn *ct,
> > +                const struct ip_ct_tcp_state *sender,
> > +                struct nf_tcp_invalid_logs *logs,
> > +                enum nf_ct_tcp_action ret,
> > +                enum nf_tcp_invalid_log_type type,
> > +                u32 value)
> >  {
>
> This function doesn't log anymore.
>
> >  static enum nf_ct_tcp_action
> >  tcp_in_window(struct nf_conn *ct, enum ip_conntrack_dir dir,
> >             unsigned int index, const struct sk_buff *skb,
> >             unsigned int dataoff, const struct tcphdr *tcph,
> > -           const struct nf_hook_state *hook_state)
> > +           struct nf_tcp_invalid_logs *logs)
> >  {
> >       struct ip_ct_tcp *state =3D &ct->proto.tcp;
> >       struct ip_ct_tcp_state *sender =3D &state->seen[dir];
> > @@ -640,31 +728,29 @@ tcp_in_window(struct nf_conn *ct, enum ip_conntra=
ck_dir dir,
> >                       sender->td_end =3D end;
> >                       sender->flags |=3D IP_CT_TCP_FLAG_DATA_UNACKNOWLE=
DGED;
> >
> > -                     return nf_tcp_log_invalid(skb, ct, hook_state, se=
nder, NFCT_TCP_IGNORE,
> > -                                               "%u bytes more than exp=
ected", overshot);
> > +                     return nf_tcp_log_invalid(ct, sender, logs, NFCT_=
TCP_IGNORE,
> > +                                       NF_TCP_LOG_OVERSHOT, overshot);
>
> Maybe rename to nf_tcp_store_invalid() or similar.  It only has to stash
> the value (overshoot in this case) and NF_TCP_LOG_OVERSHOT.
>
> Could you also add a lockdep_assert_not_held(ct->Lock) to the old
> nf_ct_log_invalid() plus a comment explaining that we must not call into
> nfnetlink_log with that lock held?
>
> Thanks!

Thanks, this makes sense. I=E2=80=99ll split the fix into at least two
patches, first handling the nf_tcp_handle_invalid() timeout-lowering
log separately by deferring it until after unlocking, then simplifying
the remaining tcp_in_window() invalid logging path and renaming the
helper accordingly. I=E2=80=99ll also add a lockdep assertion/comment to ma=
ke
the no-log-under-ct->lock rule explicit in v2.
