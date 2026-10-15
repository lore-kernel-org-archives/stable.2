Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840004EBAEE;
	Thu, 15 Oct 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055394; cv=none; b=KrtN6mFvsQx8Em5eS8wy6jqB8irg4zClmMrI0YrKFl6QIdPP73+boO79P5uOzaS1JsNF0Wc9R9vNbUe27t/duA1ESNfGjvGDoe2AEWEke5vNIhuCkTWkgRrS3z5jPiQZL+Tdichqa8+C/qMd8pVy5oHppotO/l4KD1CocH+eCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055394; c=relaxed/simple;
	bh=6KLs+0KZ4UBmc3RQZp8/mh7VvZ1/XfDMBVDcqY5fVUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLLfPQ5qN+2qd2Aa88Xmf4g2DooX43p3gkC8Hw90j3K1xepytzTYU1egVvb+o1IoOhwmHGOpSqcz3Hl3aoG+fMe9Oe8fayVY7kCfgiHkbm+HsXdTmyF2qU1QzLJLK4TLvfYxVh5jenYcDbVzCf5r/qbco9xTyKgqBXL+NSc1MUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOPU3LwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOPU3LwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920971F000C4;
	Thu, 15 Oct 2026 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792055391;
	bh=6KLs+0KZ4UBmc3RQZp8/mh7VvZ1/XfDMBVDcqY5fVUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOPU3LwGhL92elJpY66RwfdcNEcIc/mZsBiS0ptOvKk+fUAjOwVdiAD3MF2mLhVfT
	 iOMMMYVCnjyejI5ebsD1KctiBwbQrKt954xW37nDuo6yZemnFSHA7fglqIt1gtOwPv
	 ZPaVUUzMrQhRruia3Ae//64M+1/3SWMDdPoqAobgRizMcfPiM4FaVhFruEk5R2VflQ
	 PT/+SoPNwS0lNtDXLwfdrvmVG9Tz9DkPl/KNXI+i8t+UwDb+sQiPp0+mbRLuyhTgfJ
	 MDTl+e5MVeyxYfFUs3s6bBQLC7NKYIdYJX+bBbSSbf5v9e5LXd+/vdrbZj8+lLZ4Ac
	 jxm237dNZv4+g==
Date: Thu, 15 Oct 2026 10:09:43 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>, 
	Alexander Motin <alexander.motin@truenas.com>, Ameer Hamza <ameer.hamza@truenas.com>, 
	"Caleb St. John" <caleb.stjohn@truenas.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: track the perf mlock gift separately
Message-ID: <atCYFpm63elRyuw7@gremlin>
References: <20261003-perf-locked-vm-fix-v1-1-d214dcaf0d76@kernel.org>
 <20261015075817.GO2009045@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015075817.GO2009045@noisy.programming.kicks-ass.net>

On Thu, Oct 15, 2026 at 09:58:17AM +0200, Peter Zijlstra wrote:
> On Sat, Oct 03, 2026 at 05:29:07PM +0100, Lorenzo Stoakes (ARM) wrote:

> > Resolve the issue by simply giving perf its own field separate from the
> > rest.
>
> So I'm a little confused by all this -- perf introduced this field,
> others jumped on and shit broke, so we fix perf instead of the others?

Yeah I think the blame really lies with the later users, and that send a trend
that led to further confusion (including myself, mea culpa!)

> Anyway, patch seems straight forward enough; and you added comment to
> the fields, which I suppose does clarify things some.
>
> I'll take it. Thanks!

Thanks, much appreciated! :)

--
Cheers, Lorenzo
