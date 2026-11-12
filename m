Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453310;
	b=5ivwmuEc8SHbsmVCNdRLO5iUWCPRBPbVsIrYuSmP8Lq/1iY4rH6zoVeASthWI15meuFe
	 1mcnu+sZ5WS9q7onGev2cZjbD/xMn8GU3cVuGjJMtvYuJKroNYxh6bKoJWfLP/Js5UKS5
	 2CuyDDcavng2PX/Z9IUDe21efGpBv8q8UZT/Lh546uEBy2P+M9FNEKsxl+gCCmo707VUE
	 PJQanEfYMYlB//UJbRjpb/OMXP5fNEGGF5C1bb17oaXZYpkKSWp63NlX0ezrSH3mmUzWP
	 KkwTCUC5NZLXqtgg9nbaHD9CO1CY21Bg3bbDtCinlowP8g9SAaBdbA3qxVlQlBCK6kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453310;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KukHHa4IpQLPx0nLghzyKli6Eignxu46dayWT5IB5Os=;
	b=HKD1d7shbMxhEBA2D/8rm7tjXHlmi17vF6BNehb2YJiIfKC+9WoGlJ7KORqYxp24s4MB
	 UA/rFtjmpfb58HdXrP3gvsuZsyXtuRdrdEb4roYONBtJZTlKIath9M6JJmSF/GmvV+FRr
	 j07bA//XqI8N8IXhGYJobXEhjwm0dNHtD37d7AzEgvlxA/WkgdPTasHAUAi3MJ2o+4dy0
	 CL1DmFv1fvrPDrFFgf6GA7A4hXe3pWPL7SHXmnV0YiMiGmMVn2p4vA4oHdvWqfUeuYfCy
	 jZICNMoIMth7sx3EVxWjveGdrcEFQ+wAYXbzBkJ7QFr17qo9HwFS9QVMO8YNDKMt9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtdRHkFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116E606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HtdRHkFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC011F00A06
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453310;
	bh=KukHHa4IpQLPx0nLghzyKli6Eignxu46dayWT5IB5Os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HtdRHkFmYxZrCo6PzjigvXf/+cyDi/aIxj270oF4bJrWFqnKtWgx8cATW/rcYdR1r
	 OUxqOca4onuGyQdRhLadFiHZXwQ1IRBR64MxWFvDqYU0deRpxQMuNv6RY6sj/Uodox
	 6QxKHScgi2WRjN5KMkyggGUxKkHdkQoc6a078wGu3Js/vAHTNXYhRbmpIjvYBfLPZW
	 22WYN4YDfBbpyTdBYuM4ldiIu8kLVOn3ZSu7TNp8S9VF7WH5EGGQE7FALrlRWY8JRm
	 Z5cLQ4EIo/fZkl5uoWT2ymtJRKUVNM5yKfmgulrdXgjZE6mhVArSuTDb8vYyW0W6DA
	 DyC3Km3HHNAeg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4395d31228so507225766b.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 19:15:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEpg4EoT3j+02Ed+74zYISaKrcsRstUpznGczrVim5FdcnYCif0AciUMWcIFRZT9ZJiHgvxe6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+uIDMoadpJWZOm0xtJ/TcDTzhJtyfADOLrUrEnU+Z0LZ9yu5U
	eH5eB2oesvnhlbXS885mv2yKnvj2pU7685HFXRjGmvbLNRW08YC1+7/pbcAcxj8szXP64tCHQdR
	A9Vu29sg2vLPrT3Dal/NotpXw/IjH1vI=
X-Received: by 2002:a17:907:2d8f:b0:c50:5e10:71ae with SMTP id
 a640c23a62f3a-c5066afce46mr377456166b.17.1794453308567; Wed, 11 Nov 2026
 19:15:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111092421.3771992-1-chenhuacai@loongson.cn> <20261111170600.GS1779021@noisy.programming.kicks-ass.net>
In-Reply-To: <20261111170600.GS1779021@noisy.programming.kicks-ass.net>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 12 Nov 2026 11:14:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>
X-Gm-Features: AclHuK_e17qcvjrZPS0KZhv5Xdz0uZ2nPZtp3g7am9FbsyZNwEyKWIbkfxX2baU
Message-ID: <CAAhV-H6SYOjOw+owmStK7sr-HOiADC1zZ4Cii5hv1q+qYAUETg@mail.gmail.com>
Subject: Re: [PATCH] lib/smp_processor_id: Don't warn if there is only one CPU
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Morton <akpm@linux-foundation.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Peter,

On Thu, Nov 12, 2026 at 1:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Nov 11, 2026 at 05:24:21PM +0800, Huacai Chen wrote:
> > When CONFIG_DEBUG_PREEMPT is enabled on a Non-SMP (single-core) kernel,
> > calls to smp_processor_id() in preemptible contexts trigger some false
> > positive "BUG: using smp_processor_id() in preemptible" warnings, which
> > are harmless noise because the process always executes on CPU 0 and CPU
> > migration is impossible.
>
> The check is still valid, you don't want to have any code that uses
> smp_processor_id() outside of preempt_disable(). Such code would be
> invalid on SMP, even when ran on UP.
Thank you for your reply.

At first I also think that smp_processor_id() should always be called
in preempt disabled context, but after investigation, I found:

There are 5 existing skip conditions.

1. if (likely(preempt_count()))
2. if (irqs_disabled())
3. if (is_percpu_thread())
4. if (current->migration_disabled)
5. if (system_state < SYSTEM_SCHEDULING)

Condition 1 and 2 is to make sure smp_processor_id() is called in
preempt disabled context, but Condition 3, 4 and 5 is not.

Condition 5 can make sure no context switching since the scheduler
hasn't begun to work, but Condition 3 and 4 can not.

In other words, Condition 3 and 4 can only make sure the current
execution will not be migrated to another CPU, and I think my new
condition is exactly the same.

>
> All code must be SMP ready.
This is why I use "if (nr_cpu_ids =3D=3D 1)" rather than "if
(!IS_ENABLED(CONFIG_SMP))".

>
> Aside from that, nr_cpu_ids is the wrong number to check.
Correct me if I'm wrong, do you mean checking num_online_cpus()?


Huacai
