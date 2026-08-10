Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AB3769E9;
	Mon, 10 Aug 2026 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347537; cv=none; b=BXciAJtRZGBkZJswTtaESbJVifyeAro/LOg5Vb+3avP+WSuStSW5gM3a+BGu/5D5oeaj/uSps3IqHAckTqh5zBXHHuNOerqBgZN73ki6ljIR2slOvSJKNQ0eD9UrqeO+Z9M1TYY2zfJwAlQBPNt6SPcGLEgmlkVnImnT8xfauoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347537; c=relaxed/simple;
	bh=Tz0ZCRWFixHAIs7oZ5wtKehSDPy2ZEjcQK/B9l4XAfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLnoISF7R0LZVjR76uUGXknio+xxnH9PRO/DqndUUdp3WiKnRjAogtVUt7ta78Ynk+g3/BBu4LQNmw5/FUgOLwwQUPVbiDqSq6qhotso3+hbq/XLd8ehg7M6kpJCfSiFQc9YK5RoLoiqvH44MgI2wwXRkrHFhafpssSH+GFBZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dzA5GGQQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dzA5GGQQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pZhZEbnFi3CBwXPlZfbRBsBUWJjVwpj8fu0LSjowEHI=; b=dzA5GGQQxlhvt0A3xsvHTclJoZ
	hE6NWGkHTXRl+7riYaY09G2gxc9E+g58Hck7Lwkki2fjfezYjL4VGNTHvTC/ob32U3Ui/kkozynEK
	rKOcXkZBLN/up5wKpsfmgbcSneX/0zkSx5c50SPX/DIhu+GwNCHKrfGaHWMovGrNS3HmxvupQqbQE
	CBXOrrJqId96TW57+0GtsxBjPTNHSPfIzH00nwFXYEDcC2WqJ+fElFpLf+NsNSyiYraRWies7CxJs
	PAu3eczVhQZ1ZHS2sHmu+Qfab8bAEooypK8YFRZlm6vKCztwzn3VYXFNAHlmMYlndovg4HpFmjuj5
	dKYGoiyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wtKaf-0000000Db7n-2oex;
	Mon, 10 Aug 2026 07:38:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A55A3030A6; Mon, 10 Aug 2026 09:38:30 +0200 (CEST)
Date: Mon, 10 Aug 2026 09:38:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jose Fernandez <jose.fernandez@linux.dev>
Cc: John Stultz <jstultz@google.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Janne Huttunen <janne.huttunen@nokia.com>,
	Zicheng Qu <quzicheng@huawei.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	William Montaz <willymontaz@gmail.com>
Subject: Re: [PATCH 6.18] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
Message-ID: <20260810073830.GC1642880@noisy.programming.kicks-ass.net>
References: <20260324100126.3502-1-willymontaz@gmail.com>
 <20260415211149.2658910-1-jstultz@google.com>
 <anksxhdkYBfcpJmN@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anksxhdkYBfcpJmN@linux.dev>

On Mon, Aug 10, 2026 at 01:44:25AM +0000, Jose Fernandez wrote:
> On Wed, Apr 15, 2026 at 09:10:53PM +0000, John Stultz wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > [ Upstream commit 101f3498b4bdfef97152a444847948de1543f692 ]
> >
> [...]
> > (cherry picked from commit 101f3498b4bdfef97152a444847948de1543f692)
> > [jstultz: Resolved minor collision in the revert against 6.18-stable]
> > Signed-off-by: John Stultz <jstultz@google.com>
> 
> We have been hitting this on 6.18.y in production. The setup is a
> thread spinning on one CPU inside a cgroup that holds nearly all the
> weight on that CPU. That cgroup's weight gets recalculated on almost
> every tick, and the per-cpu kworker on the same CPU ends up runnable
> but never picked for minutes to hours. We see it as workqueue lockup
> reports and hung tasks stuck behind lru_add_drain_all().
> 
> I tested this patch on 6.18.44 in a 4 vCPU KVM guest with a reproducer
> along the lines of William's script. Three spinners are pinned to three
> CPUs inside a nested cgroup with a high cpu.weight, and some extra load
> in the group keeps its weight changing. On plain 6.18.44 the kworkers
> on those CPUs get stuck runnable but never picked, and their vruntime
> stops moving. With this patch they run normally. Running the same load
> with no cgroup does not starve anything on either kernel.
> 
> Peter said in April that this could go to 6.18 [1]. Janne Huttunen
> posted the same backport last month [2] and Sasha is holding it for
> Peter's ack on taking the revert without 4823725d9d1d [3]. This patch
> and [2] differ only in div64_long() against div_s64().
> 
> Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> 
> [1] https://lore.kernel.org/all/20260407134519.GH3738010@noisy.programming.kicks-ass.net/
> [2] https://lore.kernel.org/stable/PAWPR07MB100712177EB29A65F4385E4C29ACF2@PAWPR07MB10071.eurprd07.prod.outlook.com/
> [3] https://lore.kernel.org/stable/20260725192000.stable-0001@kernel.org/

Yeah, this should be fine without 4823725d9d1d.
