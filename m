Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795128095;
	b=oJfiLMh8VdmyM8qcS+CKIlvYp5mt3LKFN+UPXWgDsrLzQlx3Tta0HxDPIA1aQFYmuOvt
	 qfhV2bRC/4rc229y6BuVERzD9kWAXec+AKrLzixz+igOBmLcWO5tKAR1wIlxUjazuQfbw
	 igSsWrcrWPyzGZMO29uMxZec84qZzLSGd+6aceOywZcPSARs3G9dMBLg0G8z0ALwwjUOi
	 10lWJAqma3k2i+brViK/1NS6Ny3nJiFaxdL2lez1z5goohCwlQVnfsUUf7lH6nZaHajwq
	 Km7eMMlB4CrLc2wlz1jh0MdTAIJ8GZNW0FIiiroSqe5MCPETAVW9pwOeUBKomNyg6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128095;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HThH4kBX+N5TuSiGT1XOmUDM/pI2y7ROXUxoCeZkev8=;
	b=FuTYVsY9v8FTa6gFLtxo86BM7BWLcWtQDVA9Fc8rcTUR6Yx7u/dHmCtZwXl6i0NAyJzq
	 aE0BWQNNrN94VbuB0MjPOaSdeSSQItQqb2QKfFFFpHcwYuDCFJy7x82gBuFscINtZwHbR
	 JgxkrjRBUNVHfGvubKPXoneNobiZQKk01PRcl3GPmB27K13LBODJDQ9JQcXlk4YYv745Y
	 SjtTBvHEuNeKFXBZzPjyX7POBuLLqoNW/atqbVkfiWwR8IGLx9Au93JrdkkK+wBx5G2m8
	 HRNb2q/YmsgIGgMCpiVs2tC+nEH2PIA32WItZTSJabJzsvNpN1vGF50zQbS+721RGcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFFXSRJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780C606A320;
	Thu, 19 Nov 2026 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFFXSRJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F6E1F000C0;
	Thu, 19 Nov 2026 22:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795128094;
	bh=HThH4kBX+N5TuSiGT1XOmUDM/pI2y7ROXUxoCeZkev8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LFFXSRJMl8dZ5st0UrtKyV0Dfq0T6uYXbb5jLstzSJo5OABcR4WhILtXE9N1L1tpl
	 61vQ9q4wRjNH3LQsChBuljFE/NcTGCON9eLoE/T5M9RAV0ThRfzrPOvxgM7srcEHHZ
	 grblWWoHO2z80bq68fEnCEVbyO09pvEWYgJOoPdsVStqzcVSORSvOIMV2bkVOJXkjk
	 9nIv8Yoo2AAKWEVrqFgEBkG7ZDLbY61ayMXpoEpHDiUaTHTKaXl/Pts4/p9hYgWumQ
	 4HZeWGdbdpcQX/kSHrP5A801Nabv0mBc3n/gZ1LH84R8IG8CUzynl/YPjBdCHhBBrK
	 XFAIfT9N6EnsQ==
Date: Thu, 19 Nov 2026 15:41:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <20261119224129.GA1660308@ax162>
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
 <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
 <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
 <20261118094726.GM1813469@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261118094726.GM1813469@noisy.programming.kicks-ass.net>

On Wed, Nov 18, 2026 at 10:47:26AM +0100, Peter Zijlstra wrote:
> Could it be fixed by adding an explicit cast? Say:
> 
> 	.last_balance = (unsigned long)jiffies,

No because the accesses are still unsequenced even with the cast.

> Also, the C people are daft and want to get rid of volatile,
> irrespective of its many uses, so perhaps this is a subtle act of
> sabotage or something and we should get clang to revert this weirdness.

I won't comment on C standards politics since that's far out of my
league but I don't think it is wrong or weird for clang to warn here
(this went through a lot of review upstream). I would argue it is
genuinely trying to be helpful here since as David points out down
thread, there is a potential consistency issue here. Either you want the
same value for jiffies in the initializer (in which case, use a variable
to read the value once then use that in the initializer like this patch
does) or you don't care about potentially getting two different values
from each read of jiffies (in which case, move each access out of the
initializer like my v1 did) but the way the code is currently written,
it is not clear what behavior is desirable.

I am happy to try and make the commit message better in whatever way you
see fit.

-- 
Cheers,
Nathan
