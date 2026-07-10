Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF453DB31E
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674918; cv=none; b=ua4Q6/XU92pnqUo6P+Kzx+TDeln6pAyfOoFvbuFY1FBPZKBx0QHDEmc0bFKJoBiLFcp/wCthnByBc7cuEgY2bp7eyPnlkIFp5Npim6oykuSWCFM+t5AuvI7aLRP3FqlmzoY+d/B2susm5VWjk/tG+HPSiUn0FK3NaTXMpSCrd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674918; c=relaxed/simple;
	bh=0nEVyVR7Jpl+dPmv9FjJm0kEBMJe99wCLcmY9sQtfK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFbSL0XnWqWxkZsZqBqFTKycdEhho8jAPz4Nau5JZjJSme/NTHzvhyp7ZnroNAuqkfWsRvQBLVHIRaOnei7ekORxh6e54fAF/X7jBlkaThl+ArDXbO3ISpbuMK8U/0QTcQjOTXuepC+aPhrWxMcYrJNrIV0XYg2CwqaCmRx2ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDfZEO0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDfZEO0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A05D1F00ACA
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783674916;
	bh=0nEVyVR7Jpl+dPmv9FjJm0kEBMJe99wCLcmY9sQtfK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dDfZEO0RjJSPZMo9nP+UoRAQ5EUnnRfpwBz1k0xKudhWKSksXd2gomzbhJdkuHOK9
	 n42ADkJzM01mTbCjx3RqpzZ6xB1B3Vfy3zJHWh+2grIIsBxBs8RL0lgkX+qDqTPZQs
	 oTjtsq0KTH3sqr5gdtd0ZgcoFSYcu3P185AU8ogX0ME7rUDIfw1IBB/fs2P9d6Wqkk
	 7QYSqss/c3nNxxZR44XcI9Z2/GmJanPc/FaSQ3v7+9/h8CSY22PlmnfsAtDRFQvTOk
	 8YvmmpKv8caQvrIX9I8jeaC8gAhbapJwkwBTPn/tH838YWC+3q5qZg/a3jKSGeJNbU
	 3FL762YTPFJxA==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7632b193so37270285a.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqHxjOb8WmvegvLm1CO9hAl846gYImdnZjONTHCp0OOPmy3Cr8WzEfbV1ulpWuSfZKaEiDlzw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+xREM0RUYxjIQUOh8cyqjQaDOAReLYuFGRsQ+YUlc+jU6aC3
	ryy1jqoKIrfLs3GTpThi9jRm0HUDTtIghfXEa4IlseTaqU7ZOyFhMcL+9OQLYAIduKQnIrRBoPW
	lm3PWTt022QqIr8ZDtwXIbSsGCDUMXJ4=
X-Received: by 2002:a05:620a:2854:b0:92e:c118:18d3 with SMTP id
 af79cd13be357-92ecf9087c6mr1179574985a.94.1783674915990; Fri, 10 Jul 2026
 02:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0b158fe3f25709543b48a9d81b1933120a9e2ba.1783648317.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <c0b158fe3f25709543b48a9d81b1933120a9e2ba.1783648317.git.baolin.wang@linux.alibaba.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 10 Jul 2026 17:15:03 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xbPocaA9wmJD38+YLs8uaZeH5hek-98BM9fxY6s3oswA@mail.gmail.com>
X-Gm-Features: AUfX_mxGjaF2IWoQumKPG2G9y9iws7zBVU_BVLYKb1ptJAwHQVowr3oZzbY8uEY
Message-ID: <CAGsJ_4xbPocaA9wmJD38+YLs8uaZeH5hek-98BM9fxY6s3oswA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y v2] mm: shmem: fix potential livelock issue for
 shmem direct swapin
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, stable@vger.kernel.org, 
	kasong@tencent.com, machao26@xiaomi.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 10:09=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> When skipping swapcache for synchronous IO swap devices, swapcache_prepar=
e()
> is used to prevent parallel swapin from proceeding with the swap cache fl=
ag.
> However, on PREEMPT kernels this can lead to a livelock, as reported by C=
hao[1]:
>
> Thread A starts direct swapin of a shmem folio and calls swapcache_prepar=
e()
> to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault=
().
> Meanwhile, a higher priority thread B also attempts direct swapin of the =
same
> shmem swap entry. Since swapcache_prepare() already marks the entry, thre=
ad B
> repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. Bu=
t as
> thread B runs at higher priority, thread A cannot preempt it, resulting i=
n
> starvation and a livelock.
>
> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
> swapcache_prepare() fails, following the same approach used in commit
> 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
> commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>
> However, commit 01626a1823 ("mm: avoid unconditional one-tick sleep when
> swapcache_prepare fails") found that the unconditional one-tick sleep can
> cause UI stuttering on latency-sensitive Android devices. So we can follo=
w
> the same approach by adding a waitqueue to wake up tasks when needed,
> instead of always sleeping for a full tick.
>
> Note that mainline does not have this potential issue, which has already =
been
> resolved by Kairui's swap refactoring work[2].
>
> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.c=
om/
> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@=
tencent.com/
> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous=
 swap device")
> Reported-by: Ma Chao <machao26@xiaomi.com>
> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiao=
mi.com/
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

LGTM,
Acked-by: Barry Song <baohua@kernel.org>
