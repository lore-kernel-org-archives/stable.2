Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477726;
	b=JV4T9NU087TtJl0D0o5pCOCR/7qNmmCcL8zKYvbZ8VNuVMkPTKoanyHiOEPvvpDbqXWh
	 ypzw0X5lzoTXMDC4e+Zd+ZEr4qvsHZVsChi1sROJ3ZIzRX+8y0OkKoiTaBGUcvtVSH9/G
	 IgfQ4MmC6ouW4BKbyQx6vAOgJUCY+kvkd/d6gZkZhbVojXqN10USidjE9l9xIA7Khbzlx
	 sSLksX3qUD65fgc0AJrHfDx950SKXCgVInnub5/BryWkEJWOZXW1zDs725DTHnXn9VVlL
	 ZDtP2b+09mCBqRz0EJNQq/Tiy/Zz7nroVmgtWF/6JjvyibvUnAPIxrB+yjqwC6577Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477726;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ylKTuNgUblLqNxL717J4Osbex/tTFtCBiDG2Kicf2sU=;
	b=5F8cueCsNkvWTmNZ168w7ol8vlaaxgiMHD+VOiHoci9B1q/punUEaJfMpMogPtiz6WX4
	 Zx2XPyi0Y1qwcRSDkCkN+5jigxXLMHMOfheeFHhsqa8SzLww/g1Eo3xV6okwX1R6l3B8G
	 mc0frn8UAH6Xor653xPLLO7UP6ltXri/fYzeJysGT00ihIY5Z5qSoYzescrULm2uAcJm0
	 U4dRWwgbe3sXHjbChH5HgVgiw1j5sRJoa9OdWgEbeO31LLk1VCbfqOsV7YEAg5VcJrIfY
	 fHWMqjR+9NBmO9KBO1t6uYFsPcKuRvrc1p7PmEMdmAuguOdZtQNNHYSYktMo2lNeTzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ri0xaxb/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553B606A31E;
	Mon, 23 Nov 2026 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ri0xaxb/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567051F000D0;
	Mon, 23 Nov 2026 23:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477725;
	bh=ylKTuNgUblLqNxL717J4Osbex/tTFtCBiDG2Kicf2sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ri0xaxb/mXM+T7KSjkcttZNPnjkWTBK6w8vvma+CjUcU8xw6CqThdGemhLy8Jgj2E
	 3mYsNjyzcnKM2YfybsyC1YyXLxGxOqYd4KgQ3uN8N6f3QSgo+Syu9QM33wW38fwQ6G
	 n5gTZTGDk/dO9nfl7KP2lnsu2TWDobZ9x/wdKUQSKzCwdgChnDIudTUEBjncZu+OgP
	 Q0WjJh6mpl91uYxGDYuhydkXqlpXunX9l9U0lnoMe47X7fumngbd77cmTy6/yzLaKe
	 lYRYMrAQir1ourDpSKXROx9LdW3DapCQpZFeNrNZHJZuqbCeAvf9pbAxGmlrQ5ikDi
	 6cngnGwzHrwVw==
Date: Mon, 23 Nov 2026 13:48:44 -1000
Message-ID: <861e8b931f99acf9c44cff722d5e94e7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Huang <penghuang@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
In-Reply-To: <20261123160934.2289260-1-penghuang@google.com>
References: <20261122015729.2512645-1-penghuang@google.com> <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com> <20261123160934.2289260-1-penghuang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Peng.

On Mon, Nov 23, 2026 at 08:09:34AM -0800, Peng Huang wrote:
> For v2, rather than touching update_idle_rq_clock_pelt(), how about
> adding a fair helper (similar in spirit to rq_offline_fair() ->
> clear_tg_offline_cfs_rqs()) and calling it from scx_enable() in the
> existing per-CPU scx_switched_all() loop (where rq->lock is held,
> rq->clock is updated, and rq->cfs.h_nr_queued == 0)? Specifically, it
> would walk leaf_cfs_rq_list bottom-up (plus &rq->cfs) to:
> - flush cfs_rq->removed,
> - clear load/runnable/util _sum and _avg on the empty cfs_rqs and
>   their tg_ses while preserving last_update_time and period_contrib,
> - clear tg contributions via clear_tg_load_avg(), remove the empty
>   cfs_rqs from leaf_cfs_rq_list, and update rq->has_blocked_load.

I'm not familiar with this code, so I may be missing something, but
doesn't __update_blocked_fair() already do most of this? It walks
leaf_cfs_rq_list bottom-up, flushes cfs_rq->removed and propagates the
result to the parent. It just stops running once scx_switched_all() is
set. Maybe the helper can run the blocked load update once on each rq
from that loop instead of open-coding the clearing? If I'm reading it
right, one pass after all the tasks have switched would take care of #1.

As for #2, are the leftover sums big enough to matter for
update_idle_rq_clock_pelt()? It looks like fair can leave similar
leftovers behind once the avgs reach zero.

Thanks.

--
tejun
