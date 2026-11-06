Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.67
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954830;
	b=YpJRoIpb8Y+Un/fgOigvvhcUnF98N9GPEVhQ4CPY5Sqt4X/MUtKLFPnuoF9HKZ8bQHyf
	 s/DtAEe9C6uUNA89NoV5oJu61MSwZtZ9bJod53c1+M+1M2uqQX8AYIiN/3tUj5uawx9ca
	 0fLhzhgjRZv07ehQk35r1Lu40gDF6Hno76nrDKqKjOUQt44z+HtqIHxTPJkG7THRX/QdD
	 w0UQEkZWjr7zpeusBUPQd9vJx5qV3F9BblwRbp+H8Kc87LAae3zhasFfKEmXiSILCeR4o
	 BzTCvqZLlAScqC3vd/yJrviVRVN872aAtJU2FHIXdCYObgh24Bdoc3SphAKNNoSKi6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954830;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WVjR7AQi4oaSYLPP/YcMBKqO77FuEMf6i3mIOfBIYwc=;
	b=uLNbN0Y2IHjmpNVqRStLL8vuQAYuMt68JcEUkEtPBuaa8c4Q5VxcjJ6cQKYefVaSUL00
	 3Oq2DNODo80xcObMFmDi+z9ONQCvISu27QNmjK/Zl6qo9vzttOCV71oLMO2ECp7CQPX/L
	 xsWcN0FdPlDRDFDr/ypPHexyCwjJUIRgxVjRT3xVJ2wNwjT+SmS7v3HnOW4ZnjgUmrbTD
	 jFYEuyCOjWbq40Ei7bOxAe0sbDCRuDj/X9jS0rI7KYlrw5iuJPFnvZCl117QaECJBmkGC
	 V8ku6hgSG+40R5qKg+3NEJPSY+PwA6742yX1tP895HYi3vRwFIgIzwSeIWp8hk1K58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l8iEegfi;
	arc=none smtp.remote-ip=91.218.175.67
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5088D606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5088D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=l8iEegfi
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xBISfCPjp+kLETxVE0uQCWrnE6fGni8796KMoogwtJM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793954827; v=1; x=1794559627;
 b=l8iEegfiOPM853xuCz+hUf29kN9y3PYTO8iba4KxQD1yQw+4Yu8KzMFt7UjndYb7bT80CG+r
 fJSWEz1IYrBX1sHHwB48MIZpRl16FjCCPqoXdZ+IVYMSXpu/jvYYT02QSw1lkl+76T4qt3/kbh8
 SAA19PwPtbp53gkL/xZttcRE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 571745cc821a2578;
	Fri, 06 Nov 2026 08:47:07 +0000
X-Mizu-Trace-ID: 571745cc821a2578
X-Migadu-Flow: FLOW_OUT
Message-ID: <626381b8-8111-4b8d-b93b-def9ae33f1cd@linux.dev>
Date: Fri, 6 Nov 2026 16:46:49 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mani Tofigh <mt4022@columbia.edu>, stable@vger.kernel.org
Subject: Re: [PATCH cgroup/for-7.4-fixes] cgroup/freezer: Fix exiting tasks
 left frozen forever after rmdir
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20261105191951.3409248-1-tj@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261105191951.3409248-1-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Tejun,

在 2026/11/6 3:19, Tejun Heo 写道:
> Since 93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir until cgroup
> is depopulated"), rmdir succeeds once cgroup.procs is empty, but exiting
> tasks hidden from it can stay in the cgroup until their final context
> switch. If such a task is frozen in a v1 freezer cgroup, nothing is left to
> thaw it after rmdir: freezer.state is gone with the cgroup, and a THAWED
> write to an ancestor clears only CGROUP_FREEZING_PARENT.
> 
> 8ab6980c7007 ("cgroup/freezer: walk exiting tasks in the v1 freezer") made
> the freezer walks include exiting tasks. A FROZEN write now also freezes a
> hidden task in a freezable sleep on its exit path. The fix depends on that
> commit, as the thaw reaches hidden tasks through the same walk.
> 
> Since 81933038f5e2 ("pid_namespace: make zap_pid_ns_processes() freezable"),
> an exiting pid namespace init sleeps that way until a parent outside the
> namespace reaps a zombie in it.
> 
> Thaw the cgroup from ->css_killed(), as a THAWED write to it would. A
> descendant removed earlier can still hold hidden tasks frozen through
> CGROUP_FREEZING_PARENT. The thaw reaches it too, as its css stays online
> until its tasks are gone.
> 
> rmdir removes freezer.state only after ->css_killed() returns, and a write
> to it takes no cgroup_mutex. A FROZEN write after the thaw would freeze the
> removed cgroup again, so refuse to freeze a dead cgroup.
> 
> Verified with a reproducer, including under a frozen parent, from an already
> removed child and with a racing FROZEN write.
> 

Ran a three-mode reproducer (rmdir / frozen parent / racing FROZEN
write) against next-20261103 + 8ab6980c7007 on a 2-vCPU VM. Base hit
the hang at round 1 (11s), with the patch 600s / 106334 rmdir rounds
and 6817 raced rounds all ran clean.

Reviewed-by: Tao Cui <cuitao@kylinos.cn>
Tested-by: Tao Cui <cuitao@kylinos.cn>

Thanks,
Tao
> Fixes: 93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/cgroup/legacy_freezer.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
> index bd11047f2311..1792523d119a 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -382,6 +382,24 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>  	 * CGROUP_FREEZING_PARENT.
>  	 */
>  	mutex_lock(&freezer_mutex);
> +
> +	/*
> +	 * A dead cgroup must not be frozen.
> +	 *
> +	 * rmdir thaws the cgroup from freezer_css_killed(), but freezer.state
> +	 * stays writable until rmdir removes it a moment later. A FROZEN write
> +	 * in that gap would freeze the cgroup again, and nothing could thaw it
> +	 * after that.
> +	 *
> +	 * A freezer.state write doesn't take cgroup_mutex, but testing
> +	 * cgroup_is_dead() without it is safe. rmdir marks the cgroup dead
> +	 * before the thaw, so a write that takes freezer_mutex after the thaw
> +	 * sees it dead. One that takes it before the thaw may still see the
> +	 * cgroup alive, but the thaw then undoes its freeze.
> +	 */
> +	if (freeze && data_race(cgroup_is_dead(freezer->css.cgroup)))
> +		goto out_unlock;
> +
>  	rcu_read_lock();
>  	css_for_each_descendant_pre(pos, &freezer->css) {
>  		struct freezer *pos_f = css_freezer(pos);
> @@ -403,10 +421,25 @@ static void freezer_change_state(struct freezer *freezer, bool freeze)
>  		css_put(pos);
>  	}
>  	rcu_read_unlock();
> +out_unlock:
>  	mutex_unlock(&freezer_mutex);
>  	cpus_read_unlock();
>  }
>  
> +/**
> + * freezer_css_killed - Thaw a freezer cgroup being removed
> + * @css: css being killed
> + *
> + * Exiting tasks hidden from cgroup.procs can still be in the cgroup when it is
> + * removed, and a frozen one has nothing left to thaw it once freezer.state is
> + * gone. Thaw the cgroup as a THAWED write to it would. A frozen ancestor keeps
> + * the tasks frozen through CGROUP_FREEZING_PARENT until the ancestor is thawed.
> + */
> +static void freezer_css_killed(struct cgroup_subsys_state *css)
> +{
> +	freezer_change_state(css_freezer(css), false);
> +}
> +
>  static ssize_t freezer_write(struct kernfs_open_file *of,
>  			     char *buf, size_t nbytes, loff_t off)
>  {
> @@ -466,6 +499,7 @@ static struct cftype files[] = {
>  struct cgroup_subsys freezer_cgrp_subsys = {
>  	.css_alloc	= freezer_css_alloc,
>  	.css_online	= freezer_css_online,
> +	.css_killed	= freezer_css_killed,
>  	.css_offline	= freezer_css_offline,
>  	.css_free	= freezer_css_free,
>  	.attach		= freezer_attach,

