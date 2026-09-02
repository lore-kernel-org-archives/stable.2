Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86408381EB5;
	Wed,  2 Sep 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377877; cv=none; b=gUUdB7uuxw6wIrswl5m2G84K2u6G3EJ+SgKJBSbtGmcIrfEvTXeZH0XhMSROGVGhfCOm8woLdBF8kZgINfyNX7x7dTHfB7j3zvPbCv+F5jfqzykmyRKZ/lzgBPPOF/TvGqQCxPm87GG/03HR9ZU7NACtWfbm1UeUDNuxdhbONn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377877; c=relaxed/simple;
	bh=8E18SqwHY4di/oWmHZ1yDYszCmQ16MuqpzXqo/0VDPo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=l06xdDQb3foguN/tMOh+J24lO+nZBiE8N8C/+sOXyeGx0oHJxILMPyAYwTOsmliEHE41C+mPh9BCPxZb9/Wc5PRdxVCNimCkU6u211BZI8KnyddyNH7+VCe6B+Ze7x+YPqcxbqzJMkCqOsgLOeZpp2ZzklbynkQ6qg8sjL+yVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLfdBK29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLfdBK29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6B91F00A3D;
	Wed,  2 Sep 2026 19:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788377859;
	bh=0m5c9E83vdybP/p7zVB+DFv5Yx8r/Uoa+vVZSN9z+hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DLfdBK29zgDQ0e3MbZdP9tRqsGg78mpCf1NYzxNv5n7w0vaEYNa54ji4cIeTEbJmn
	 HkFELowOAC0DdI2sbxMwDN2NiNlhdATGDrvkILoSsIQM2SLeNTJtTn+YT/PylFbWHT
	 ZqD+MW1pBCYthQVSLciwXzJVSffa+a0arLTq3+pwVloRq9Sk+1np4YxJeDOmzvvALS
	 L8eDcgK2afs8BoVxduC9Uan0XxhrMs+Mcd+7+tK3ZR046EbpBbfdNctY/Dl72QjsX5
	 ENlbys58NTICpdUdPAcwkzzUUeiKS0eDhnccxJCznCNjp24W2vrBSevzKR7UMG+yQw
	 DbgwgY/hT51rg==
Date: Wed, 02 Sep 2026 09:37:39 -1000
Message-ID: <d819e8358fffc09015feffad57794f7c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix NULL sched deref in kfunc sub-sched
 error paths
In-Reply-To: <20260902170751.256434-1-liwanwu@kylinos.cn>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
 <20260902170751.256434-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hello,

On Thu, Sep 03, 2026 at 01:07:51AM +0800, Wanwu Li wrote:
> Neither wrapper requires a contrived @p. Tasks that are never enabled --
> kthreads and tasks of other classes under SCX_SWITCH_ALL=n -- keep
> p->scx.sched NULL indefinitely; and a task handed over from

This isn't accurate. p->scx.sched is set for every non-idle task on root
enable and on fork regardless of sched class. The only tasks with NULL
p->scx.sched are the ones past sched_ext_dead() and the idle tasks. The new
comments repeat the same claim with "managed by another scheduler".

> Keep the "error out @p's scheduler" attribution -- it is what every other
> kfunc error path does (select_cpu_from_kfunc()'s cross_task,
> scx_kf_arg_task_ok()) and it is correct for the callers that take this

Both of those error out the calling program's scheduler, not @p's. The
compat wrappers are the only ones using @p's scheduler and only because
they don't have @aux.

> +	 * which scheduler called us, so error out @p's scheduler -- but read
> +	 * it under RCU (@p's locks aren't held here) and fall back to @sch if

@p's locks are held when called from ops.select_cpu() or ops.enqueue(). The
ext.c comment's "aren't necessarily held" is the right wording.

> +		scx_error(scx_task_sched_rcu(p) ?: sch,
> +			  "__scx_bpf_select_cpu_and() must be used");

As the fallback only triggers for tasks already past sched_ext_dead() (or
idle tasks), tearing down the root scheduler doesn't make sense. How about
adding a flag to the root sched and printing a warning once instead?

Thanks.

--
tejun
