Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1064A2E3B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333600; cv=pass; b=Cua1Uy8EJ2tfB8wpOstWP+yA6KYByCOuhuqrx+rQi/VDU5p//lqqNF2PYJgJSQDl2qYXMJaeyEhzxrJy80c7algBIeqvwhpLqNjNgkmjs2qhXPrgtT0IXfEt+AW+TGaGOTij44FQwcTpMJIphU62LPTyPjdX6FZTMGU24ReVOao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333600; c=relaxed/simple;
	bh=4qe50KTIVPbM8CANycvSYRvypNB4O2/hGZYA+ySnSMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/8FlKpXwXS2AgdiX51fMKPQIlurU7krqlTc3fFSxkEGboI+gYhKEeZBEYAGx8F9VIw0rOkhe1ZZP7qqXJ79FHzKQdzEASsqCvgutbs3NqM8vNXg5n6g3TCA3zEJvTpEB58UtbWiNgLt1bZtnrBSVQ6v2DFb5KNpVc3MYqLBu58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVdWoWhy; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVdWoWhy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccdf36f63dso123055ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 06:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785333596; cv=none;
        d=google.com; s=arc-20260327;
        b=rMsYbnh2tbYTSA8k4B01D7xC2itcAczCJaEmBlOUFIUYET6RSOhX/hLSJjHRRUkUOO
         8+cH3fRfGbv7nYqOQpg0i1Eb2r1QeLti77bFKvg2kcFfv/Voncxjib+xpMfP5iUw+Yn0
         RK1vV8gc9WU2NWQFqfOcfYW1EG+rTUzCx50nO10IKIA5XNMcf1zvoQjJvYse/kwhJ57u
         SWdYX+Olk3ULCPev/zGkJH1OA3apMLa5+RKblA44n7IgzxNKKnFF5wejs7T+2+SqXoA5
         +xs3yjG+4C8QiywmeW3nMh+GO1cbOlS2RHf9eMjlF1+XbmKWyIr7wWcHwVKHQwvJp79h
         JFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        fh=lyFtragB2GICGNxueOYYFYbgMWk2ij+lCRgRnqx9Nyk=;
        b=OsNVx+Wo55Ax09bO9I2X2mIxCUn8nogd/PzFm9Uk440E1qKI+a0MMoeL4Cxv2YLjqn
         HWJqdnT6sGZ/AjzZPIk39lTH3dUgzFd+qGiIHDe6wMB3o8ZqpRvgsp7H5C+FfixziaOR
         TTIXOaNpBPpsvaBtuU8gPG0+10msWERb2pjjiBCytrUyV2eiqpaueJ0HZEzVhvo33HyR
         KS+XB/0y2H3Oz2kWEoQ+3MQKzjdwNmr3epH0nKnsQyZEABrRJaHTHXIUHiQtRVPPa2/Y
         Jfi73vqnI/FbUtyU5WWwNfBXbybNfJX62VbCOLZA4/H2174l0iO3iCjI3C9BckyaryYY
         p4iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785333596; x=1785938396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        b=WVdWoWhyDq5hX/hsToB3l/zt2T8BZGo7bTDCnZRk2WvNvebSBKw79/kzuaIQSSsH0S
         r/0c0ZuzXL5EudZbl/6keoGaMRT2D9oO0vfhN5JnQyqguo9cUWoLr85T5PtHfiC3KmER
         i6HJjAyQmRDG84Wnrt+Naklw7frprCcLQfimY8FZ/PsGo857ibFXPMtoqI0vKPaXUzHa
         ySJ+ZqZwB/dXMNBHq73tdVftvPscFsyIg1rtgPoCqRA72TOQrEdxLHtz2ghoUN1zhj0K
         0fFL/uYn6IZtU4PMmvOu2YVKrDvb8RpRPLmWsompzTYR/389rR/0HtjyBkX12e/4QU8L
         2Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785333596; x=1785938396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKcySLFaScFmr1bueu4Vh/oR9sazTcKBYENtIklzl98=;
        b=KEvPB6x42c2X6i7g7oATayiLayxH0Gy2UwqSuVwTrUo6TqeHxPO/Dsy5JDJtTu4yHM
         RJVJZld6yxydpHz1WkDmioYalAxP/8I5KE898S/EHveQgitctrFZhe2PcTGstjGzDhp8
         24CNhNovECaechS3MLYNgn+zu0gc6VOaFRxgvNnaf5M3C+H4qO5IdZSzjcVoz/W5SsdU
         ZBwtz/StHl7dGm92LQb2Wz42IvjF4+wXbSKW1lma9tPAZk6qs53U6ZOn9SUVKbhAwe6M
         mare3gViPmbg/Ct3k4LXKdii6tKHePlEfDdtD2IP0X86e9J1OlTrxtD5ulyN+GB6x+sr
         a8Uw==
X-Forwarded-Encrypted: i=1; AHgh+Rrzp9TXmUVzYl5WkAfR2Qeo90xAUORMKPegfnjGpVS7I1YTicOOu0lkpmZXIOpUb41/QH++bao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ka7Anx2Ny6bR1hnAgoD4nyRMlmg/6y8OH1A19tnLCvGYeM0q
	RTUQGu4Z1ZbnDOZBK0FNguM/Q3/zXj02gQ/msNMHRT61A3W9aX+cytmrsUPDqEZFTfgKw4zU9Fw
	y5/ChdjuQvrVePrlASw1BmLBTgnCKeXEABARIGGdh
X-Gm-Gg: AR+sD13w8xl5ibyeNBVm8IPxI2Izl5eZr7X03o9eJ6VL8VdUU6SpDpfIdiDFbEpeFVO
	JiieSBmYTXlSQS8YMnrEj/OgczP6TfZysDE59rW+J/28H58ArF0COBgXjIRCFUDSJ5/sY61DpmE
	dKB0rLQ8/6IB18VHyIUqDVvOwwDZtl9NreUeeZJUluFWyubLQK/dfOpe4JdCuc7aScISmzePrsg
	9gDIVCtnUCQDLqNwnrEcYLnTywUD1/Amdwe/oCUFnWoIi2+OM/bh4kQD0XADESRiQf2QEeMD481
	976LgvZVu5DdrLSCYQabsxcmKWUsT0MRLiO4yq36k0VtKaa+FMiL6mADSIWe2Yz1E2/F62pDeLW
	sIs7uPK3js6wr3gvmuymT0pkx6i6d6bc=
X-Received: by 2002:a17:902:ef06:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2d0287cf9c8mr4618065ad.11.1785333595219; Wed, 29 Jul 2026
 06:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
 <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
In-Reply-To: <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 29 Jul 2026 15:59:18 +0200
X-Gm-Features: AUfX_mxsSGeX5Wk7ttteu_H2elB1yzsLWm21TrFa_WMDUNzOOPYaOsNkMreMWbY
Message-ID: <CAG48ez1tUk+8b7-eWw-fHh2x_bJA1n3CTANVWKQuPW=J+inCrQ@mail.gmail.com>
Subject: Re: regress caused by upstream commit 6650527444dadc63d84aa939d14ecba4fadb2f69
To: Pasha Boroffski <hex.dec.bin.oct@gmail.com>, stable <stable@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Wed, Jul 29, 2026 at 11:08=E2=80=AFAM Pasha Boroffski
> <hex.dec.bin.oct@gmail.com> wrote:
> > Hello.
> > I believe 6650527444dadc63d84aa939d14ecba4fadb2f69 has a bug in it as i=
t causes "kernel bug" with PREEMPT_RT enabled.
> > How to reproduce the bug:
> > i used 'find /proc/ | grep 123'. When scanning, the kernel triggers an =
"Oops".
> >
> >
> > [  344.465851][ T3715] BUG: kernel NULL pointer dereference, address: 0=
0000000000000f8
> [...]
> [  344.465888][ T3715] CPU: 0 UID: 0 PID: 3715 Comm: find Tainted: G
>    D    O       6.12.98 #9
> [...]
> > [  344.465905][ T3715] RIP: 0010:down_read_killable+0x9/0x40
> [...]
> > [  344.465974][ T3715]  proc_map_files_readdir+0xc7/0x500
> [...]
> > I think calls
> > mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > if (IS_ERR(mm)) {
> >   result =3D ERR_CAST(mm);
> >   goto out_put_task;
> > }
> >
> > should be fixed like
> > mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > if (IS_ERR_OR_NULL(mm)) {
> >   result =3D ERR_CAST(mm);
> >   goto out_put_task;
> > }
>
> Ugh, yes. This is not an issue on mainline, but the API contract of
> mm_access() changed in commit cd3f8467afd4 ("mm: refactor mm_access()
> to not return NULL"), which landed in 6.13. So we'll need a
> stable-specific fixup for 6.12 and lower.
>
> I'll try to come up with a patch for stable later today.

I've reproduced this, triggering this NULL deref on 6.12.98 is as easy
as "ls /proc/2/map_files"
