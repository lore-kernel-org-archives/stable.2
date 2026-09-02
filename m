Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E238E8D3;
	Wed,  2 Sep 2026 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378021; cv=none; b=CxKhrjEbvdvFNFzMPkFSDW099mb3PZJpm0EL/54PHvGoI5pUoj/DC7uzxfjiCd6CoWh+gLPJIYbnU1qiDv6neg2QIEHxzJYCz3Tt3ze8G/7ONIqnN5R7hN3ygjlrWzrStnfoqRihFhppxI0+fRMUcDw3YSua/VeWJaZaHifuIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378021; c=relaxed/simple;
	bh=hvuhYZ/zhnSW3W9EnPxfxrGI6iqbq44S+PuYionHMek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS2ngCdlaUuBzLmmFMO+chNXH+0Y4Gjqrnaytth4O1e4/PyxYGaScgD4UtYxVBaBk8eBCXeOElOvt9tix4dSblzptyYc7h0OlmtmXQwLp61D7T/LSyBS9QnWsIRVCoR32iNX3UcM9OqUt4FalryaeoH2Fcj+FNbAj5XcwVZ3tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItDJqVqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItDJqVqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685821F000E9;
	Wed,  2 Sep 2026 19:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788378000;
	bh=tl89XML9mHT8dTGxLA/sj5/YuKXGrGcAaXUOBvAx+Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ItDJqVqLsWB6V6D/OnKtJWqeKFZODrq2XpC2EfPZqNd0nSLbWe8s3aEhDPtXBwcqO
	 jUYic40USK3rLd949sPMuKkYkC129Wtm1Hbz1mnXHSW0aS3xWg3Pb/dCubYsX/G6AN
	 j1AHmsiTrVtxlBiLGdAiz3sc+Zo4/Noajf25hdN73Wv7smeTl+FwzRwQTqkBnTZEJL
	 vB0wha4FMQ1+QBWcc3eh2YMUt3d+YwuyUXTlL/gNwlzLVstMaDXtlz8P3YbwOdgKcB
	 hrbJ4kCU1tWncY8W+qqyqCMpxyjTV+7A4P8Cax0PYYk1LueHcc4Ctjz0x679KtJ0ns
	 zQgLvIH8e/rwQ==
Date: Wed, 2 Sep 2026 09:39:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix NULL sched deref in kfunc sub-sched
 error paths
Message-ID: <aph7j7b_rqqqcSwR@slm.duckdns.org>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
 <20260902170751.256434-1-liwanwu@kylinos.cn>
 <d819e8358fffc09015feffad57794f7c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d819e8358fffc09015feffad57794f7c@kernel.org>

On Wed, Sep 02, 2026 at 09:37:39AM -1000, Tejun Heo wrote:
> > +		scx_error(scx_task_sched_rcu(p) ?: sch,
> > +			  "__scx_bpf_select_cpu_and() must be used");
> 
> As the fallback only triggers for tasks already past sched_ext_dead() (or
> idle tasks), tearing down the root scheduler doesn't make sense. How about
> adding a flag to the root sched and printing a warning once instead?

It'd be fine to just ignore it too. The scx_error() is there to flag cases
where things went obviously wrong. I don't think we'd lose anything
meaningful by just ignoring it when sch can't be determined.

Thanks.

-- 
tejun
