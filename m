Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B63093CF
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150023; cv=pass; b=mniD7uzf9u4Rqx++27j3duEZxqL8QHY32IdxfDQSxJuQ1vrB1YQhU7FygcSxgdxTFRmyuNmLLyRPt9uQYXAzUwDyn+tTYKN5izvKVK6Yu0zShei369CAT/CzAq5Khgloqo2iZPwII+kJORBHjMtZQrMWb7uWYVpO2OsovNI77AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150023; c=relaxed/simple;
	bh=71ybj3J5oMv8gnAsFJwnucxiEQA5mI0LVBfOSfWmgws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJObD+8py+Zfw8NFSxP6VinHXYtGf9A6au59ID5hncSg3GVHUE9dIzAqkGqXySAuVy+qxxRmC/tRXhwn1hSWQmG7WgV8ZT+sx8d4rcyH0WJeNB/7zAzPm+hBbLwjJWyEBaGItz63+HpXSErTic0a7cmZSOnO92MddUT6qM8GKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqqimmtn; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqimmtn"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso1792594a12.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150020; cv=none;
        d=google.com; s=arc-20260327;
        b=ipQqbwuSCpL50YkQGXaz12/oj0lf054iZa34nJ+kaFFlz71jhUyoDU/DDGX0A+zkrc
         Tngjn5S4AcNZ60RwDITm0BWAhF+BUiqIgMIQZIj4vKhZ6/p85sftt4xZ8GD0VThrklJK
         r38jx1XUgcAc5BpfPxFIrtSjG93UYWz6KYIgQ0nrpcDHZfhqARoNy19tFtt3Tdrdozo4
         kHIbSr7Csv8lkjiRoqLTPF4rtAX9oW1MuzGS/oLRRxqz4eQN7lGhheIMzhYaENrr7jW9
         DnHL/SGeDLdBl9XIkG5ihVNhYuxdWFyxS7ZdMaUaJarHbmCHyKEG8KXO24aSSVxmskXg
         8VaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        fh=z6ugPVjU+tbeVN7NCmBIzpciztoDkofhkfKikIZdnhQ=;
        b=lQUh8xRaOkQpCgE6Bzzf4yAdrKn+rE3ju8Nwmvvcmc5XJ5X8+7+1MgVRBc6/1e2eMX
         f0bwRYt9n+R9HoFWg6t4im0PLgshVDbpPeDCkePrPkC5vWw21NeguMLUTly1Jp78m8BU
         uXqJiKSjIGVsRbggkwAmzYtVvHGknrFRO3BkYAaGtzprMGGyeW/Dh1TYEGI/5uC+UIVi
         F6g/XSHao3HLwGVtjGfq9vwc99X8tS1U2w0Bpv/MIyEka5h9/o/5U1jlD0RLoA5+iIun
         0J9OEIMb6AaZinjID9PZcpcEGgvoCrcKkD7ANaglwGZd2cjbiwD6/fX+G/H/D0XlnYC5
         vKhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150020; x=1787754820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        b=iqqimmtneQwNLwcEPud3BJWbpUeCTQ7VUL890NGB5o0r7TkqRcl7JAWJZiIZXsCfIh
         LuaDMncNAgiy54/RSzREq2W174cjKvfdN0aZcvyQVZ2t+//Lt5Hue4atPzc8rUOiMWb6
         vpucteoHoK8WSa4x/DGJVqi67PM+fdrmAFTAeb04nuL1QmmdAcD6dP8pyBKnw04aKp9i
         Mkszv+00bVe2nb86JINBanK4IcByheXsqG1L21y1fOv7ECQQSzlVRQmHOebbMA3Mijon
         WakqCTuzHiAgO7jIS3oTVp/uInd6BfvxpV28ZuIqhjxo3WWodf6r9wj1d+174nFQUEm/
         VXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150020; x=1787754820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        b=WCO/Ckuj6As6DffmgDjUZh47ucVuZzm5ZpQxPsv+8twH/TmFZCkGeixfO45sA0YmHL
         l+5/QvyYIxUSVTD7dTSK1uUjL814snJ2jz0vwiQXTiRqie4MTUaayAL9OpHHm1qpLG1Q
         2VSZ6dcoQu4tPXoyrH9s8Rtf7RsbFz8iJdA/Q1SvzddcZFQX+igul9YY0Ukv8D8lIDwZ
         6A0ty5obaNhQITlxylzdpPW8HicS1yNlwH8nAJ4AEiN8NAjLs5xLa7IDK7vBiJ9M3J40
         B+9soEw1rXVdrNY63CUd8eXH7IsIvwYlGKuZB76Qe0nC4uwkTlumSXv0SBjUfUzXEIpC
         nfww==
X-Forwarded-Encrypted: i=1; AHgh+RqMbe/JVMJzbXNdfePUG2ZS73KEDlB1NidlO+wzwiKtvzG1bnm/0F/Ci20/ICkP1xQwuBiQyOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUSe6LqQ9hoEfScssJTP8U0zueogfj775RllNq1ZcW/UJv7T6
	CLGJjpkprgjEUKtgijcJu7YyrQrGMbBtN6168VDnwppNspxyavhoRPUDKWOQ3UO7qkCKt7IYad+
	VHTMoKwmkbxP7MjqQQAoFJkLEaL0MmuM=
X-Gm-Gg: AR+sD12bjK++/X1wfI/liyH9Zz+3uJemzsQWn0xk7h34aF9wJT5LxSoAJr8bo1xEMzb
	VQ4H3ddenqMc+atNOe2rgtWsSH2yOWsyG2J8Dl0sFjZNOS713tJ0jx52YVNkRhRgaTNGKlCC+Po
	MXRDf5aBTfeY++9tsdonaMAu7qMMYUqa1AKGfqerMZo6ruf1mRXFRpkbW6XXOq7CGMO6nrvaOtE
	w0vfIhtuRNUkbyXQHmJcwymIXSAflHghGTVUQbInq/cI1yH4lAwd6aU1NepwScY2MECRLTbSls2
	Bmu894YmOfhkanPoB78AEpTpedK0JgwwZq2a48cuqVek+e0O0sBWSlBSY184TPOsNg/WFLbA2iN
	nSscJ4mNjYZoO8eR66AojuV8f1ANXyhiaAFRleuFKeow=
X-Received: by 2002:a17:907:d506:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c242e364b6fmr405411966b.15.1787150020054; Wed, 19 Aug 2026
 07:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818210322.53266-1-meatuni001@gmail.com> <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
In-Reply-To: <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 19 Aug 2026 19:33:25 +0500
X-Gm-Features: AcwNN1U2NqsKGE6UtzZCK8YAN1WJvKH2WepR77b6ZIJOP-mGimuqt2krQdAHeEo
Message-ID: <CADqcGB=ZbfAkM_90ty7=_QD3eqJd8f7urXKvTnagdv09U9RRAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on
 disconnect and probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

You're right, thank you for catching this. I traced through
vub300_probe() and vub300_inactivity_timer_expired() again: the
kref_get() taken right before add_timer() is exactly the extra
reference the timer holds, and the timer callback releases it itself
and stops rearming once vub300->interface is NULL. So the UAF I
described can't happen with the code as it stands.

I should also be upfront that this was flagged by Sashiko, and I did
not verify the reference counting closely enough myself before sending
it.
That's on me. Dropping this patch.

Sorry for the noise.
Muhammad Bilal

On Wed, Aug 19, 2026 at 7:19=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Aug 19, 2026 at 02:03:22AM +0500, Muhammad Bilal wrote:
> > The vub300 driver arms inactivity_timer during probe and acquires a kre=
f
> > reference for the running timer. However, vub300_disconnect() sets
> > vub300->interface =3D NULL and drops the driver's kref without shutting=
 down
> > the timer via timer_shutdown_sync().
> >
> > If the timer expires after the host is removed and vub300 is freed,
> > or if concurrent work items re-arm the timer,
> > vub300_inactivity_timer_expired() accesses the already freed vub300
> > structure, causing a Use-After-Free.
>
> No, this cannot happen as the timer holds another reference.
>
> > Fix this by explicitly shutting down inactivity_timer via
> > timer_shutdown_sync() and releasing the timer's kref reference in
> > vub300_disconnect() and probe error cleanup paths.
> >
> > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> How was this "issue" found? Are you using an LLM?
>
> > ---
> >  drivers/mmc/host/vub300.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index 8e45dc1a4a12..9f84bd1531e2 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -2350,6 +2350,8 @@ static int vub300_probe(struct usb_interface *int=
erface,
> >
> >  err_stop_io:
> >       vub300->interface =3D NULL;
> > +     timer_shutdown_sync(&vub300->inactivity_timer);
> > +     kref_put(&vub300->kref, vub300_delete);
> >       kref_put(&vub300->kref, vub300_delete);
>
> And this results in a reference underflow.
>
> Johan
