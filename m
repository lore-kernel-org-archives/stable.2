Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988631;
	b=YVTxgpGELbTcUE/DGmmjFdEoqGauN+U5E4rkPsz6hgO9PJ1hdhHu+CT9i2FQ5Fg0aipb
	 nZgzXw1v40untErJAYGNXrq6RwMNNoALb/edZK1+8PqqdCFM457EAqZmFoCWR7pvirGO6
	 3zuuP+sUZq1bg71ieXmi3+5UykGMoRM11j5D0OfVMm64gxs1Qm885nbet3YUC6JlTPvzA
	 l6fwjZkJ1NY3/QFXfrOOHViL3H7M7aVXDb2MJD3R2SdLdbo1ed/K3zjUYTFiQignNpBMW
	 x8glcoDb34cCDtYWXndl3UefAGUqKoDZozNCvGoVEm+qc20fwK982hGe5FjHg1pw7vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988631;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HVlY59yebrjjIBqdbedBvMWvL8/mmW3OmeZ7ju/UwIk=;
	b=0kzCIBglB3f58/wbvzuFzJtRMb3P758lH3NbP4iFCu39FOxWpNUrDYQg3zH72eyrNNVr
	 0AP1BLSnFgSSEFg3jsOYe/U5r+FYVqMBhhh5mNpvTkD0Cn6uEyMogUEyWg9Z3SNQ2I1TK
	 n/QfgwMar5Z0McS+pLupkQLUka0u6OEy/0T8PEjhWk6Sc8nLmYkMi2dSnIAlecDqQs5PF
	 9fiqJZsfGoW74jYyU32wC/R57zaXv6lRsRt94gaKn+FNqrO7BX2QrhkAu+VmDbvPpqlOG
	 pBAEOfnzzz5PkoS2LiC89x8AJF+br7l8ZJsyQO9bo3aXf9nwwD+50wcwBU8zJmRahLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDqCzRnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD3606A33D;
	Wed, 18 Nov 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nDqCzRnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924671F000C4;
	Wed, 18 Nov 2026 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794988631;
	bh=HVlY59yebrjjIBqdbedBvMWvL8/mmW3OmeZ7ju/UwIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nDqCzRnHPXyb/gq9KlbI1jhO1d6sLC5wiyW1rsRinzdlIwL0M5af/x0zWX6fkyafn
	 9AbML9xsvFdVnL+8ZFVOF2K8/+MC1NUV10r0LBEGMPQG0P6+p79WJvNUgsQTMCZdUA
	 aryafQ98wFmwISoxAL6muJCU1SLywwZeYX9Xhf6fNuVA4MzFdxXufC1jplnimOwVEv
	 DcY3hwxVCJpy1Vw/WxhyWDgqIo1q/lUi64oXnFo+VpmowczPmhm+T4PsQYcRxAGdeV
	 1aQwC7oLh2Z2TEZowt7f3/SdDNC5Dyy/FcHqmmiDvfQvaVvbFyO4T1UDkFlNTQuuMJ
	 JfxAMy33K2JmA==
Date: Wed, 18 Nov 2026 00:57:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261118075706.GB325225@ax162>
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
 <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
 <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>

On Tue, Nov 17, 2026 at 10:39:15AM -0800, Nick Desaulniers wrote:
> On Tue, Nov 17, 2026 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I don't speak enough C legal to actually understand the Changelog, but
> > the actual change seems daft. Is this really needed?

Yes, I would say this is needed. I am far from a C lawyer myself but I
think this is like any other undefined behavior: it might not be a real
problem now but it could always become one later.

> I would imagine a delta of the disassembly here before/after the
> change would make it more obvious (one less volatile access, which be
> have arbitrary ordering between initializing other members).
> 
> But I guess I'm also curious why jiffies is defined as volatile
> anyway? I thought the usual guidance was to use
> cast-to-volatile-qualified pointer during access, rather than declare
> as volatile?

Maybe because jiffies is accessed a lot across the tree?

-- 
Cheers,
Nathan
