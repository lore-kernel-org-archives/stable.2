Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C7268690
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786326307; cv=none; b=Y40v0tSU5zWrATc9lNadFSmas69v1YxMOlVRk08xB32rXnHONp2sEn6y6ENmTFTcVUWxEUK54IQjQMVvYNnSYM64N8efjS94ZiebAnPAY6vABOrx0txYgbaYmrwWIQj3r9bZsGP/FLIfi+wheSnFXiqP9F6aASzz8E/PpVLKpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786326307; c=relaxed/simple;
	bh=e5bZXitToeluxNapgCJzm7CYubAiUYY2xbTVjandf+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALI9JQar2ctbNeehxcFlbu+OlpC/5loDmWNzzQ0wv3uIE5QIRL4/iQLc4+HsWgYecyaAQ5am/CPy+2c7qs2wv/QShfmo5obDp6eFI/pKGAKvkTtR5hL2CqmjwmUqEriMmyhlzouB+q/vPhDwmfaILNX0uHc2twoU0mhkUKsg0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xgTUJhwV; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xgTUJhwV"
Date: Mon, 10 Aug 2026 01:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786326294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5bZXitToeluxNapgCJzm7CYubAiUYY2xbTVjandf+Y=;
	b=xgTUJhwVXvoR+cN12IFDSq9/lkeBglwv1MUWJ3lUldM8va0FLkxUTDdhzKORFKC2yUVoDD
	Nk7INCpExiJXIONDgjG2ABL7eJ3KwY11tggNw7aUJ5hwKA/SLkpTTDzK2wX7jI9AGhGZj+
	tsXHQr8Gp6BRFDYrGPv/tY8iqiB0134=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jose Fernandez <jose.fernandez@linux.dev>
To: John Stultz <jstultz@google.com>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Sasha Levin <sashal@kernel.org>, Janne Huttunen <janne.huttunen@nokia.com>, 
	Zicheng Qu <quzicheng@huawei.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	William Montaz <willymontaz@gmail.com>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
Message-ID: <anksxhdkYBfcpJmN@linux.dev>
References: <20260324100126.3502-1-willymontaz@gmail.com>
 <20260415211149.2658910-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415211149.2658910-1-jstultz@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 15, 2026 at 09:10:53PM +0000, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> [ Upstream commit 101f3498b4bdfef97152a444847948de1543f692 ]
>
[...]
> (cherry picked from commit 101f3498b4bdfef97152a444847948de1543f692)
> [jstultz: Resolved minor collision in the revert against 6.18-stable]
> Signed-off-by: John Stultz <jstultz@google.com>

We have been hitting this on 6.18.y in production. The setup is a
thread spinning on one CPU inside a cgroup that holds nearly all the
weight on that CPU. That cgroup's weight gets recalculated on almost
every tick, and the per-cpu kworker on the same CPU ends up runnable
but never picked for minutes to hours. We see it as workqueue lockup
reports and hung tasks stuck behind lru_add_drain_all().

I tested this patch on 6.18.44 in a 4 vCPU KVM guest with a reproducer
along the lines of William's script. Three spinners are pinned to three
CPUs inside a nested cgroup with a high cpu.weight, and some extra load
in the group keeps its weight changing. On plain 6.18.44 the kworkers
on those CPUs get stuck runnable but never picked, and their vruntime
stops moving. With this patch they run normally. Running the same load
with no cgroup does not starve anything on either kernel.

Peter said in April that this could go to 6.18 [1]. Janne Huttunen
posted the same backport last month [2] and Sasha is holding it for
Peter's ack on taking the revert without 4823725d9d1d [3]. This patch
and [2] differ only in div64_long() against div_s64().

Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

[1] https://lore.kernel.org/all/20260407134519.GH3738010@noisy.programming.kicks-ass.net/
[2] https://lore.kernel.org/stable/PAWPR07MB100712177EB29A65F4385E4C29ACF2@PAWPR07MB10071.eurprd07.prod.outlook.com/
[3] https://lore.kernel.org/stable/20260725192000.stable-0001@kernel.org/
