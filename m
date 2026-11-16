Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855302;
	b=mw3cc3mk+YbciTl9834U7HnubDKVxhePkXoGzLwHozRBcVQaUGnz0iY9/d64GAE5BIle
	 YCqQ+dJnRJXgk2BCfP+n9/FzGuitUXhoas2hkhhZEtCrDUmUDUg7baTaNQlHGa6gLxQbO
	 F5JfyXT+2VltNq/eFcy9plnInRymn795lOXWqWFJxPMda/Zvhmewv8+jlhW4Nn9su9sfp
	 EmLUK6MpJv3/0M1oYnix8qFQ/K4odf6yedaCwTtFZI7kOTmQBnKV76fCMwq1scsUhLhIV
	 h5LU5I6POcoTTF5gK3X7D952U0lk2VMABlS7oVAj8UtK4ZdSjZOpqUliyyiox8mAUuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855302;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+HftUw/uUqd4jgUY6b3i56RpufOwZrQW8huZ8KLBZYk=;
	b=hvMmCSOS7pYaFVAJPMdar1WVoBbOZ37XpO+Cpo+Bj26TbjUXfY6k7KPqlETzLeW8/hD/
	 9O3zdEO2fpm8IbJGvaHnY1uRTPCVDQjVAc0zfp7k45JyDmxHkBEeMPR/AHYC/6RQzT/ZP
	 88WeAfNJOR+PquBw+9ulzdGIdY2sRvIUfAXArkfhjUBFtp7KH1oDe8baNT9dG6n9KztYd
	 Eloc1q+iLyq900vsH2bvoQ4giNIQ7gFJYwHbzaV6dNeeGvpByGgYzT7JWNRHwsGaMUk23
	 Bfplp38NuKSlh60EjipiPBjuMfdoVUhXqeBdv9k1kRtlCIBghcCL7Wp1fquxh+OivIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WckHz/bu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BAB606A31C;
	Mon, 16 Nov 2026 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WckHz/bu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AE61F000CC;
	Mon, 16 Nov 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855302;
	bh=+HftUw/uUqd4jgUY6b3i56RpufOwZrQW8huZ8KLBZYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WckHz/buWLBASZYRje/c8GkwldfZTdQyUi+xHS34PNbWqlPot/94Rhhfr4G1xf8/I
	 tubaZVo0xDsZ6CmunU8fkZtwRNXTkyOj9HbaaW4yby4NbjwG02GgXb/H+3+wuBDuNV
	 oeLW1mTWjU1BOG76ckHM7Xjsuk0MDclSbTkU/MCG17x8ZjC5Mm5mSARkY89uNyH7zt
	 CLncMKBDY8Aeh/jCs58Sw6ZjNy4f337rBvBbYHK2xWTt6QNPPQbObPYlFQY79YtG5D
	 qUxA8RIMlA035DPw5/IsFikf6ysO7ies5NK2FNnSY3q35dr10luZOz0Pe1jtPJoaFp
	 rkiCwu4QxFcJg==
Date: Mon, 16 Nov 2026 11:54:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Avoid unsequenced accesses to jiffies in
 sd_init()
Message-ID: <20261116185456.GA1036399@ax162>
References: <20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org>
 <avtMzjJxIpFWkW-L@google.com>
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
In-Reply-To: <avtMzjJxIpFWkW-L@google.com>

On Mon, Nov 16, 2026 at 10:36:45AM -0800, Nick Desaulniers wrote:
> On Sat, Nov 14, 2026 at 09:19:52PM -0700, Nathan Chancellor wrote:
> > +	sd->last_balance = jiffies;
> > +	sd->last_decay_max_lb_cost = jiffies;
> 
> This pattern is going to wind up with two volatile (expensive) accesses,
> (with potentially different values) rather than one access and the same
> value by accessing `jiffies` once then storing the result in a temporary
> local (before the designated initializer), then using that to initialize
> the two fields in the designated initializer.

Thanks, I should have revisited this solution once I had a wider view of
the scope of this warning (it was one of the first patches I wrote)
because I definitely would have done that. I'll respin.

-- 
Cheers,
Nathan
