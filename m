Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176496;
	b=FLF1sI5DITwqEiFrGfjYK7wpzK0e1JSrekJJDBYrJeiQtKq1n8LSXrmy+lwz7UfmHDtg
	 CB3Tlf8kUHYCAi9TWxfL2MCC7a4v2Ltk9I4eJw76IXLG6+RPycmW3SijwDPJrhy3OQo6K
	 Lo/EabgnLBQsx4daYJB6QsCQ2AzOokvCBrFdAmoQXeQFGfJK89guYPMWEbGIak1MxqNoz
	 Wlsp4DsU3eQ8CY+hYboSI7h06nmen1LlZZSxtDP2mYGlf903VZbLQvj7cjUDeH1Cnf4pK
	 oqTouMSa2CfumaL1qT5KdjZFmsGMjfAsWKZOUSJjYe5GUbjuM1zRCHkyH3oiJHEW1yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176496;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=leH4vKCDxg4Q4mbVrfWpHJbzOjqXkPLFQadbncRScqc=;
	b=GdgDkDPqaiL5JIrYgoOuQSaUIXRukkGPyxG0rtdaakHdDJqfEkxHqNpSClcobSOzVFPb
	 htNb6j7gzlitimflmB8mreMWpw7bXJUA6dSUBSQ8Ra97DPxGovUrkuhRauhc72KFJ77oH
	 MTDmRPcpn8JlRb6KloBJMncT4w/YC4aeBcG0ajFB14kXLEZ20fB/al8adcIZ6d8kaSeQU
	 EPa98zzFMPPMWr3e27+92Qo0gHUQmvBGNvmF+oFWBDdhzTtWOAmouoeeLQMMJisIUdYlY
	 UjTVlQHQfK2lFCCVcNLiK6mIWh+cFD6c5n8jSBDk6qfITPHi+i7fuBvAiSYzUVx3mkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=pWCrJsIR;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A8606A33D;
	Fri, 20 Nov 2026 12:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5A8606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=pWCrJsIR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=leH4vKCDxg4Q4mbVrfWpHJbzOjqXkPLFQadbncRScqc=; b=pWCrJsIRg/rUdUJopFL+uSchfV
	nugUPTlQygkizPNxLXYFxjlmGwnLzbHKSFC/47HVx4xP77V6KMmxZxOccb3ZwpdAnS0LZQPL9mB7s
	+E1YR+Y/Q5vC9GG4cjhqsa2g2w7a518WjpaxGZsfqph2/q7PYpgpesYG7Z0Pa8y/bwboPbGHvSC6v
	UWRG+A9jH9xbs+dmi75BE/glBjXgPTUVCdN7PFBUB979TQ9iE5UpRdvufdvxDyZp2szsSmIX5mRpS
	DEizgSnjvu6AWq293mFWR0AMSk5zGBAQG3RhUTPyUjcuyhh3uBHC7j927LyvBrjS6fn9SawVAyDnf
	HvnsRXfg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNPK-00000000jzH-255A;
	Fri, 20 Nov 2026 12:07:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C8379301185; Fri, 20 Nov 2026 13:07:56 +0100 (CET)
Date: Fri, 20 Nov 2026 13:07:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Chris Mason <mason@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fork: clear p->mm when copy_process() fails
Message-ID: <20261120120756.GS2668564@noisy.programming.kicks-ass.net>
References: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261119-mm_failed_fork-v1-1-b3019f43d197@kernel.org>

On Thu, Nov 19, 2026 at 09:04:58AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> When copy_process() fails after copy_mm(), the error path drops the mm
> reference but leaves p->mm set. Perf and BPF can still reach the
> task, and take a reference on the already freed mm through get_task_mm()
> or bpf_find_vma(), resulting in a use-after-free:
> 
>     copy_process()               PERF_EVENT_IOC_SET_FILTER
>     ==============               =========================
>     perf_event_init_task(p)
>     copy_mm(p)
>     a later step fails
>     mmput(p->mm)
>       /* frees the mm */
>                                  perf_event_addr_filters_apply()
>                                    get_task_mm(p)
>                                      /* use-after-free */
> 
> Similarly, a BPF program on the task_free LSM hook can call bpf_find_vma(p)
> before the task is freed.
> 
> Fix it by clearing p->mm under task_lock() before dropping the reference,
> just like exit_mm() does.
> 
> Further, if copy_process() fails before copy_mm(), p->mm is still the
> parent's mm pointer copied by dup_task_struct(), without having taken a
> reference. While nobody can access it concurrently, there is the
> chance that it might get accessed later when a BPF program is attached
> to free_task().
> 
> With CONFIG_MEMCG the task is freed after an RCU grace period, so the
> parent might already be gone and p->mm in the child points at something
> that was already freed. So let's just clear p->mm before freeing the
> task. No lock is required as there cannot be concurrent access (and we
> might not even have the lock initialized yet).
> 
> This has medium urgency.
> 
> Fixes: 375637bc5249 ("perf/core: Introduce address range filtering")
> Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-180866@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description and comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> I can take this through my tree (rather soonish) unless someone else
> wants to pick this up.

Have at.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
