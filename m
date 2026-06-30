Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04A279903
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832387; cv=pass; b=en9UFRtDkH1h1QnJcu+z6WSAwZ1e8uejGfWLk53mNV0dwoxp917hhTb6xyWi5cAyhsqCB6gmha/P3EiX8TyyYx4lYviaV7Bb2AoHNyBqaoe1rWUhY14M6/ktV2DQtenvP1/oUNMd0KvmifdztdqwiPdYb3hJ8MznL/Q1aY0uw20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832387; c=relaxed/simple;
	bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiv2MseC67N94iEOLA+Dqbc4tryuIRnzkTsUaPrCtgF/CO4FtqkXGMmPiGlkDwKHFx2rUgG1FCqbUxmJYrw5jieRxwHpbdjf142rv7UVjhK2nGfZ19o8XIcjfy3BPvLCifzGU1kw2YoKCoLcJ8oXPpNeKmDrYNhU/03HGyBKWQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=u0IPYxCK; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="u0IPYxCK"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so1849576a12.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 08:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782832385; cv=none;
        d=google.com; s=arc-20260327;
        b=NR6ESCbGqdTe+KiKPhZLbRjUGYDHM2tELMZW0OpuSU2uTRRjBNELEnBNQVLz+9ab9S
         2BWcdrH0hHC9usKsjs+WGT76/OZSoNpy6SA9PZEoLZhor2QjSgvAPu+0HifvvyGUmMqN
         TxVB0x37AyNsG3J916+LpO5rha7BR+MIc+RtM6Y9uWUwyeSJqSpPIckax62pD1q6U+9Y
         UbDUNmdIG4RXtOsh63YaBdMpWp+AXxiHOdQCTBYU4+tKmR+tgoB+6qF+AnjKj8nz64Zf
         nXSBN4L/PryH9fiGhVEmHGMGmSubDTz5USCFwQn9eBKQksVetCtuP0JNPWxTt/zZ7+mK
         FtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        fh=Lk5BldHHmc9LchyYLLoniVTZgKtWdQhTKlFjVaqBqxA=;
        b=AOZSvPoZHYZc4+W7ymZehO1O954Bje1YesX8fOAq0jlLRw7GbznqthGzjXBML6dQJQ
         hzFYxpuB74/swhg+MlygIAKj/PuqDnAj1tPP1+AkWBa4edG+0xjk12F58qeBNVvzEwAp
         +f+598LoLRi19giQuOxCF7tg+RLJP927LHQqgFuefF35bYbQYBxxvP7kIF7xsThlhsoU
         u95Lhjd5iQKH7Inm/N4yDqoczmqkLulhpY1n8Tm0MfvY0GZYFym5Zi8+WrWBkAYQnpMP
         VXScHJcthzZxMorQHXaHm1aBKtJBOlsfX9DAHvf26raktcrIMzQGb5JG0ZevfFsY0KX/
         HfRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782832385; x=1783437185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        b=u0IPYxCKGJAuEgUYMjWBG2ou/o00l2/OmyMv8Ly2jdrVfYDtudr5vkrDcQdsbaG3pg
         qO96WJ/e0yQm05m0iXnd5v0DgiTpJSO5431M95fsZIARe7pzzsqId/sv+p43YbRzsyNg
         1Bxp8Gk8Ethw/oPP5fJBbTX0luOYmH9p6tDV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782832385; x=1783437185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJYqFnL2vG71AIAqq+EbZ1KEewPN7ISeg84rZvQEiKQ=;
        b=Wm4CsOdwYLc1WezLcDdVy3H44n59MG/8ENCD2vkFV4wzYWCfAyAWLqrcHYuFNrQtm7
         UbxWum1I7lZ7IbhSQ0T8LT/+5jlEAMhIlaglla6qXtrftKeYKk9feofpGJiSrVHJ0zBk
         yt8StMZ6yXWRiaB1GhNGPfoPNiYWmSDCE44e2hTtvFn7V4Mqnd+4kfVBSiCl4+qZS68q
         nMpqLiyM4VH78Prj2w2IjonPfbkAgqTIGUlGJ25l6vJcxdSx6jMEzKlylL5lhaQUEnjE
         xA0fc7glExlKtXXVKveX1a9zcF0Fo6rwrEgPDS5OVHh4fLP3lt6+BGTRePanMm7ykLk9
         x6fA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4AXjlZgCvWmq1HT3lOro0hpp0QGoR6leiPkcZb4Z9HwSWidGwc6gwcisjmK0J3RL/UQWlMi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EkpEVQbDn6/ExFU0lG6MmjPzYmguUDtvDHcUOEOK0qOSJfVr
	Cjy9hH+MJ1fb2vGKg5qAw+60ealXwY4ogpUJSNVmK8wKL6m6NMA7FZnefmIKpMesG6i+V/7dNJK
	3MXpq2k2wG01wfF5Q821dVD8ocAomkMqyr4ELgxfo
X-Gm-Gg: AfdE7ckUQYON8nnzbHFLQlLebYVB2ZKqBmnvOqNfHrDDrsG92/ld7kR28Z2xI/hlOvd
	RZweqxvBV/kVX+ySSFHOvy0A/567UzuldNNNZMFBGjNvRcbCDBWALYJZpMhXk3V1fapXu2pflP9
	leppMY4pZgD3b2bUnY5JRF47HHrt3V04T/AjKZQZFR0aAFJBB7j70N3yBaFQPYzxJV+KvbDOJTW
	atUAE0MEQbTBVyqO6Uv3VcGTI0So5f/LT8+q8QGswwOHMQJfgmseyLryr3k+A2F1xPhs2D99w==
X-Received: by 2002:a05:6a00:22cb:b0:847:8449:2bb6 with SMTP id
 d2e1a72fcca58-847add5ed31mr1031837b3a.4.1782832384500; Tue, 30 Jun 2026
 08:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628111229.669751-1-jhs@mojatatu.com> <de40b1a5-663e-43ab-9fb7-5a49f029cc4b@redhat.com>
 <CAM0EoMn-6Ayjd3mxsiifDXwN1zdefx9eiRk_wWRpsuEh22LziA@mail.gmail.com> <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
In-Reply-To: <3dab7c8e-aed3-41f2-97e0-558c7a82f925@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 30 Jun 2026 11:12:53 -0400
X-Gm-Features: AVVi8CfDVmG9Z4yADXh5AS1CG7Y0BA3PaEb22keblCHUYnyd1XomuuYfPnXpfXM
Message-ID: <CAM0EoMmzrJHLzFczYsXGcr7oEJ2-TSrkPVJJa4ROwPwA+MFj3Q@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 10:12=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 6/30/26 1:49 PM, Jamal Hadi Salim wrote:
> > On Tue, Jun 30, 2026 at 7:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 6/28/26 1:12 PM, Jamal Hadi Salim wrote:
> >>> The teql master->slaves singly linked list is not protected against
> >>> multiple writes. It can be mod'ed concurently from teql_master_xmit()=
,
> >>> teql_dequeue(), teql_init() and teql_destroy() without holding any li=
st
> >>> lock or RCU protection.
> >>>
> >>> zdi-disclosures@trendmicro.com has demonstrated that the qdisc is fre=
ed
> >>> after an RCU grace period, but teql_master_xmit() running on another
> >>> CPU can still hold a stale pointer into the list, resulting in a
> >>> slab-use-after-free:
> >>>
> >>> BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
> >>> Read of size 8 at addr ffff888013fb0440 by task poc/332
> >>> Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-5=
12)
> >>>
> >>> The fix?
> >>> Add a per-master slaves_lock spinlock that serializes all mutations o=
f
> >>> master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> >>> teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> >>> around those updates.
> >>> Annotate master->slaves and the per-slave ->next pointer with __rcu a=
nd
> >>> use the appropriate RCU accessors everywhere they are touched:
> >>> rcu_assign_pointer() on the writer side (under slaves_lock),
> >>> rcu_dereference_protected() for the writer-side loads (also under
> >>> slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit(=
) and
> >>> rtnl_dereference() for the loads in teql_master_open()/teql_master_mt=
u(),
> >>> which run under RTNL.
> >>> Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the lis=
t
> >>> traversal in teql_master_xmit(), so that readers either observe a ful=
ly
> >>> linked list or are deferred until the in-flight mutation completes. T=
he two
> >>> early-return paths in teql_master_xmit() are updated to release the R=
CU-bh
> >>> read-side critical section before returning, since leaving it held wo=
uld
> >>> disable BH on that CPU for good.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> Reported-by: zdi-disclosures@trendmicro.com
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>
> >> Looks good, thanks!
> >>
> >> Please note that sashiko/gemini found a pre-existing issues which may
> >> require a follow-up/separate fix:
> >>
> >> https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.=
com
> >>
> >> (the 2nd one in the above link, IDK how to generate a direct link to a
> >> specific comment)
> >
> > I just sent v4 which covered that but i will send a followup instead
> > if you already applied.
>
> The PW bot is went on vacation and no 'patch applied' notification is
> reaching the ML; v3 is already applied.
>
> > BTW: What is the ruling on when Sashiko finds a pre-existing issue?
> > Should we address that as a separate follow-up patch? It is unclear
> > what the policy is.
>
> The general guidance is that pre-existing issues should be addressed
> separately.
>

Ok - i think it would help if this was documented somewhere..

> > This teql patch was one of the hardest to deal with in terms of
> > reproduciability and the fact sashiko kept coming up with pre-existing
> > issues - including the one Simon and I were discussing. Note: None of
> > the pre-existing issues affected reproducibility at all although i am
> > sure one of the AI-kiddies reading the sashiko reports will find a way
> > to create a poc (this is why i entertain fixing them when they look
> > simple enough)
> Not an ideal situation both ways (which is increasingly the case).
>
> Addressing incrementally pre-existing issues can lead to an huge/endless
> number of iterations when touching some unfortunate area (4 is _not_ a
> big number ;) delaying the actual fix indefinitely.
>

Agreed. I guess i get anxious the AI-kiddies seem to be following
sashiko and as soon as it complains about something they immediately
followup looking for new vectors and i feel like i will be going back
to fixing the next issue ;->

I just sent a followup.

cheers,
jamal
> /P
>
>
