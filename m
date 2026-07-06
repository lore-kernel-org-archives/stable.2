Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F3148D2
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343060; cv=none; b=OQhPq4Cd7o8NSLPkbzf/uhadNcoHLwcMHSnvYQtXB1Q5ZJACbeZJYTGv/bbRt3ExcSJUqYdANr78mnSAkByd6ZkMFNEtxfZT416QS1D8C41yyt8bef4tAHGfD5MfRt1CMuD6GGlvVXelceFle+P+tKVh+8Y5zHCMDUTNyMNI4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343060; c=relaxed/simple;
	bh=wtAL55Vy1IAVfMt9lDQ6e1FXFicQRPy2EBLWfWBUGcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG6nuLuwnNjCAvu6piHuL11IpT0kNB19HknpqkIi1e8PdCcDikim0kwFVcSAAGUMpwGWwXaEQHyqHnbkfiauCyxh/Epr0kQm3Nhs8s6EBw1BcMQX4ZaCpdqvt4P1RLAZLQ3jiVu60X5zmS5EgmwqiFi8IAA3mFBkMuIDlV2bQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+YjQi8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+YjQi8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A891F00A3A
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343058;
	bh=03m1i1njTYKshtMRdqLIQtrRPKyxLQ0WpIMYuekAZ+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P+YjQi8xJY0C73JtdBM+t3wwj2gtxC/v2J+ZVFysO1xMnkuaHKIvmPBB8lcUlCYJE
	 WQjGlWpvYiy5ZoM+m1lTadl5bawgUYCKd0/K1upoXLkBo4TPMzeZ0XxVQGFu4TsS1u
	 kMlhT055hUimiQgT620sxyhCYexwFW3AUdY+z+EIeI1GZ77Jdd3sVTZPSudKKWUuiJ
	 knxVGsTBuxIyVjbqFwznKbKoHroI0y+CiEz+gkU3FMiSv56jhptovh2FweygIW5/Ig
	 iB0qr49Z4haX9b35TrmzblmNyv6XBCj/GW7geIkj31jUZGSSUVeYKyWvF2L2kAnPHT
	 AQpXnoHen1WQQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e6391b114so213630285a.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:04:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrjt7X3U3a7rrv9FQKzxg9HK6objDCwTBW7a9OBXAX1hvgtlluXL8QVpk+E1jT3dEPvl0V+mH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbKfk3hFoH9K7p0D/0xUSvNZy0FF/lGZ0iKRoCR1KczxvQaA5E
	kd2jcG/f5vIBPj1nNqWqCNyQRyIzgeINwM9kZsCE3jH+1rhAXQh5zuruEcBQjkLcBQb+HTi1GO6
	cm+Y4Qc9tgHYu6prpOqogfPaoqtbKTmg=
X-Received: by 2002:a05:620a:19a4:b0:916:1806:302d with SMTP id
 af79cd13be357-92ebb60cc71mr55371685a.58.1783343058102; Mon, 06 Jul 2026
 06:04:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com> <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
In-Reply-To: <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 6 Jul 2026 21:04:06 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z5N6FSfWt5WUZ5YmqhCzLcd3Cj1sc9B79WYX9ZbDH8Gw@mail.gmail.com>
X-Gm-Features: AVVi8Cc4-cCPMWvrStzPGpTwA44_ETQ7K94w2ZYd1ngI74f-KWgZnyW5L8IF4f8
Message-ID: <CAGsJ_4z5N6FSfWt5WUZ5YmqhCzLcd3Cj1sc9B79WYX9ZbDH8Gw@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem
 direct swapin
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org, hughd@google.com, 
	stable@vger.kernel.org, machao26@xiaomi.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:08=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 7/6/26 1:59 PM, Kairui Song wrote:
> > On Mon, Jul 6, 2026 at 11:25=E2=80=AFAM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >> When skipping swapcache for synchronous IO swap devices, swapcache_pre=
pare()
> >> is used to prevent parallel swapin from proceeding with the swap cache=
 flag.
> >> However, on PREEMPT kernels this can lead to a livelock, as reported b=
y Chao[1]:
> >>
> >> Thread A starts direct swapin of a shmem folio and calls swapcache_pre=
pare()
> >> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refa=
ult().
> >> Meanwhile, a higher priority thread B also attempts direct swapin of t=
he same
> >> shmem swap entry. Since swapcache_prepare() already marks the entry, t=
hread B
> >> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish.=
 But as
> >> thread B runs at higher priority, thread A cannot preempt it, resultin=
g in
> >> starvation and a livelock.
> >>
> >> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) wh=
en
> >> swapcache_prepare() fails, following the same approach used in commits
> >> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
> >> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
> >>
> >> Note that mainline does not have this potential issue, which has alrea=
dy been
> >> resolved by Kairui's swap refactoring work[2].
> >>
> >> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaom=
i.com/
> >> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064=
c7@tencent.com/
> >> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchron=
ous swap device")
> >> Reported-by: Ma Chao <machao26@xiaomi.com>
> >> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@x=
iaomi.com/
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >> Hi Chao, could you try this patch to check if it fixes your issue? Tha=
nks.
> >> ---
> >>   mm/shmem.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 94c5b0d78ac3..d4cb57b3b0ef 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(stru=
ct inode *inode,
> >>          if (swapcache_prepare(entry, nr_pages)) {
> >>                  folio_put(new);
> >>                  new =3D ERR_PTR(-EEXIST);
> >> +               /* Relax a bit to prevent rapid repeated page faults *=
/
> >> +               schedule_timeout_uninterruptible(1);
> >>                  /* Try smaller folio to avoid cache conflict */
> >>                  goto fallback;
> >>          }
> >> --
> >> 2.47.3
> >>
> >
> > Thanks! That's much more simpler than I expected. Do we need a wakeup
> > queue like the one in commit 01626a1823024? Perhaps the reporter can
> > help confirm and test? I personally prefer to keep it simple if shmem
> > users aren't as sensitive as anon users.
>
> I agree. I'd like to keep the bugfix as simple as possible, if the
> reporter's scenario isn't latency-sensitive.

On Android, we don't see much shmem; it's much less common
than anon. So the chance of this concurrency happening should
be lower than for anon. However, shmem can be shared by
multiple processes, so could this still happen if process A is
blocked by process B?

I'm not really sure. Only large-scale data can tell. :-)
