Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA10428498
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434867; cv=none; b=hXESZDyX/Rzr0qcv4nUirmOihiMdrfLz6gPpjziwQs422ZlUn39hRBKUaKzd59vVYYY8kv2U+g1sa0P0NgabtYvlmVeltERvo1ItuXOwjntvjwJIL+8QgSNn7NdlVM6319VI/l+CwFSmMGRvNd6rKw+uqdgrlEMIgp5RYe4UVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434867; c=relaxed/simple;
	bh=aPvVr0Ll1JKVGggi+f7XHg7MZg7x9R1JAvebDjaxVq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4V/irx+JPk68b1huK8O7W9aLLcn6eDi39zRU+sEak4K/s9ARVdIJxBUu6Zz0R91z1u5924qUQdwElJJPVSold91Od4EoSeb6fZ3K3XywOkrMKg5TXNZxDLvfkEoVGGAHI9r9j2vqEN51vw/K6Es8bERp6Guiz/oED3BYF/8fy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHr5YAQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHr5YAQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D57D1F00A3A
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783434866;
	bh=7f2N/SJQhJLGukCIcGmJQv9G5BEKubFQyKhmhbtamRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cHr5YAQgwuJ40WYqmmXAvD5Yud1eg+3k/oTgssQil4smRcvOqud5HdZobqZ1DkSXs
	 Cw2u7GwpXyQTAf5gUWJ7CXzBtie7nKH7vMiLPeNAcyC/5MMyR4j2peWV7JU5Xjv1tS
	 spAe+JFdqwTmMSjtAshqBS0E2Pzjxg5wtGG99SdOZ+oSQDPla+ZjP7jiUO0Gj0IjQ0
	 rVnHcCNxtAhm01KECAvj0tyMbxIynhgT0z8gfkpnZXroRE5kEOiCKzJrTnxgg4wrhd
	 5UUrrTdE4F1P4mIySLv8Q4de9TTwvyQaeZT+OysYYYIeEwHeytkMTlX4AAliA4NvwJ
	 ylhbhxHe6TVMw==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c08df8513so28877211cf.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 07:34:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoIbudWLESChPuKdEPhx62HGh0nKJY53xxmR3EM+5VrrnWsjXHK33Img0R9xAC3g9VlCOKhft4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzra/h/EMjeR/2QXj2Ke0K8265Y/MyRCMowt2Z5+A1sktAk1qjK
	Qt/oNIRIJJup4iujuKpGVC8PwFuS4yuv53FgUatJs0DWxOlGN8SjRKMIFNvfwt8C28KcjpM/Q9L
	yshQlGS3gNx6jL9t2ic/R1KbAPxvmF4I=
X-Received: by 2002:a05:622a:e094:20b0:51c:7b12:1207 with SMTP id
 d75a77b69052e-51c7b12179amr15829651cf.85.1783434865720; Tue, 07 Jul 2026
 07:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
 <CAMgjq7AQcyypJ-VhJ_CxY6fdEph64fxjOzzYU-=EkMrHemkpzA@mail.gmail.com>
 <8ef0b72e-a0e8-4913-8d30-519335305260@linux.alibaba.com> <CAGsJ_4z5N6FSfWt5WUZ5YmqhCzLcd3Cj1sc9B79WYX9ZbDH8Gw@mail.gmail.com>
 <d01bae40-f94d-4e8a-baac-ad6fffa18b64@linux.alibaba.com>
In-Reply-To: <d01bae40-f94d-4e8a-baac-ad6fffa18b64@linux.alibaba.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 7 Jul 2026 22:34:12 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zbBRe383GQLGuPivUXXnjhs2L9xFyandXkCOUotcb7Vg@mail.gmail.com>
X-Gm-Features: AVVi8Cdk8e1_A5dUPq7XT_kY-SwTQ4Hn7kKDOOl2oDp5wOSBPnjQwov2kRW5pUQ
Message-ID: <CAGsJ_4zbBRe383GQLGuPivUXXnjhs2L9xFyandXkCOUotcb7Vg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem
 direct swapin
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kairui Song <ryncsn@gmail.com>, akpm@linux-foundation.org, hughd@google.com, 
	stable@vger.kernel.org, machao26@xiaomi.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 9:53=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 7/6/26 9:04 PM, Barry Song wrote:
> > On Mon, Jul 6, 2026 at 8:08=E2=80=AFPM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 7/6/26 1:59 PM, Kairui Song wrote:
> >>> On Mon, Jul 6, 2026 at 11:25=E2=80=AFAM Baolin Wang
> >>> <baolin.wang@linux.alibaba.com> wrote:
> >>>>
> >>>> When skipping swapcache for synchronous IO swap devices, swapcache_p=
repare()
> >>>> is used to prevent parallel swapin from proceeding with the swap cac=
he flag.
> >>>> However, on PREEMPT kernels this can lead to a livelock, as reported=
 by Chao[1]:
> >>>>
> >>>> Thread A starts direct swapin of a shmem folio and calls swapcache_p=
repare()
> >>>> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_re=
fault().
> >>>> Meanwhile, a higher priority thread B also attempts direct swapin of=
 the same
> >>>> shmem swap entry. Since swapcache_prepare() already marks the entry,=
 thread B
> >>>> repeatedly gets -EEXIST and busy-loops waiting for thread A to finis=
h. But as
> >>>> thread B runs at higher priority, thread A cannot preempt it, result=
ing in
> >>>> starvation and a livelock.
> >>>>
> >>>> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) =
when
> >>>> swapcache_prepare() fails, following the same approach used in commi=
ts
> >>>> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") a=
nd
> >>>> 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
> >>>>
> >>>> Note that mainline does not have this potential issue, which has alr=
eady been
> >>>> resolved by Kairui's swap refactoring work[2].
> >>>>
> >>>> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xia=
omi.com/
> >>>> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e0=
64c7@tencent.com/
> >>>> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchr=
onous swap device")
> >>>> Reported-by: Ma Chao <machao26@xiaomi.com>
> >>>> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4=
@xiaomi.com/
> >>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> ---
> >>>> Hi Chao, could you try this patch to check if it fixes your issue? T=
hanks.
> >>>> ---
> >>>>    mm/shmem.c | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/mm/shmem.c b/mm/shmem.c
> >>>> index 94c5b0d78ac3..d4cb57b3b0ef 100644
> >>>> --- a/mm/shmem.c
> >>>> +++ b/mm/shmem.c
> >>>> @@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(st=
ruct inode *inode,
> >>>>           if (swapcache_prepare(entry, nr_pages)) {
> >>>>                   folio_put(new);
> >>>>                   new =3D ERR_PTR(-EEXIST);
> >>>> +               /* Relax a bit to prevent rapid repeated page faults=
 */
> >>>> +               schedule_timeout_uninterruptible(1);
> >>>>                   /* Try smaller folio to avoid cache conflict */
> >>>>                   goto fallback;
> >>>>           }
> >>>> --
> >>>> 2.47.3
> >>>>
> >>>
> >>> Thanks! That's much more simpler than I expected. Do we need a wakeup
> >>> queue like the one in commit 01626a1823024? Perhaps the reporter can
> >>> help confirm and test? I personally prefer to keep it simple if shmem
> >>> users aren't as sensitive as anon users.
> >>
> >> I agree. I'd like to keep the bugfix as simple as possible, if the
> >> reporter's scenario isn't latency-sensitive.
> >
> > On Android, we don't see much shmem; it's much less common
> > than anon. So the chance of this concurrency happening should
> > be lower than for anon. However, shmem can be shared by
> > multiple processes, so could this still happen if process A is
> > blocked by process B?
>
> Could you be more specific about how that happens? I think we should fix
> this starvation/livelock issue if you think it could still happen.

Hi Baolin,

I think your change has fixed the livelock issue, but an unconditional
one-tick sleep could still be problematic, as commit 01626a1823 tried to
address in do_swap_page():

"mm: avoid unconditional one-tick sleep when swapcache_prepare fails"

If possible, I would suggest that your fix also include the change from
commit 01626a1823 to avoid the issue caused by
schedule_timeout_uninterruptible(1): an unconditional one-tick sleep
could cause UI stuttering. At least, this would make the code more
defensive.

Thanks
Barry
