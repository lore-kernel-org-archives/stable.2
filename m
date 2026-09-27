Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4631AA1D5;
	Sun, 27 Sep 2026 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790481782; cv=none; b=HSK577LWUbGioEb8qlJqU93IvEVYjH/KCBnSOOln4Y1cVu2A6DaH5bae1pe7OUbKYgTjCES5cBWCf57qzCnibHEh3sKWZyJlc6U5SQpHeJ+u8oytDRgbeYyXGXRjcx9/jKoYWhCTePiFkvdZkbbwZNtZfC+n2z8xSlb/eGUrMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790481782; c=relaxed/simple;
	bh=8/Pbq6e0Egu5v5AdbXrKrQZKM8VxS12zXS4hrd1rh88=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SW3h5WXjnvIALfTTNDrq8c4ekw5bAqrOmYTMJgW27G78zDNi7DcHjVIyGR0YpVxpT+JJwo2Gg4CpNcipHZXnQ4BfwhOcM5F3ulSBXp6lqhoVTB9Y0u18tpGvCm6CeOf6gsh4DaAi5xSSWx9INj+AqYYhjuqbq9nV+MVQcrKK+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFtP15S4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFtP15S4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5902F1F000FF;
	Sun, 27 Sep 2026 04:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790481781;
	bh=GC7coo6sKErkgEMskr01q7qu9o3kxRtbkgfzjm0Q4lY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kFtP15S4BUOShAcFAgqUdROdbeOeafymgeS9M6D0J0a8jC+wMgqDIK9tixgRQJCN9
	 Z84+fZ30DBMhOxu23nmUx0Y9JS3ufzBhY6XakzL9m8Hr1s922PUM1YVTphFKo31fGL
	 cvbpRc5TnfgDw3amSwr0eU9q+rukAocRDmHhZdTwR0LgohJB9gH3/qRULEMj4WMvv8
	 /JIP6dtNjzuk3kWPS2SlNZq+SDBm/aWjNW4SjklbsCruOP5eZ0PaihE1Ev0TO5GvcO
	 Ua1A4Ti13QprF5Tb1+fRiFBoXtJJK+UsQYaHaSBXT7NhlGHZlkZ7nRnKJLp25sMJhU
	 DejpI9xv0LZbg==
Subject: Re: [PATCH net] net: gen_estimator: protect seqcount updates from
 hardirq readers
From: netdev-bot+sashiko@kernel.org
To: runyu.xiao@seu.edu.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Date: Sun, 27 Sep 2026 04:02:59 +0000
Message-ID: <179048177964.2160803.12902537767476134602@kernel.org>
In-Reply-To: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
References: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a bug that nothing in the tree
  can trigger, yet the patch carries Fixes: and Cc: stable.

--

net: gen_estimator: protect seqcount updates from hardirq readers

This commit replaces preempt_disable_nested() with local_irq_save() around
the est->seq write section in est_timer() in net/core/gen_estimator.c. The
aim is to stop a hardirq reader of gen_estimator_read() on the same CPU
from spinning on an odd sequence count while the timer is interrupted.

> est_timer updates the estimator seqcount with preemption disabled, which
> does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
> observe an odd sequence and spin while the timer is interrupted.

[ ... ]

> The hardirq context is deliberately injected to
> exercise this interleaving; ordinary userspace traffic does not guarantee
> it.
>
> Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
> Cc: stable@vger.kernel.org

[Severity: Medium]
Is there an in-tree hardirq or NMI caller of gen_estimator_read()?

struct net_rate_estimator is private to net/core/gen_estimator.c. That
means gen_estimator_read() is the only reader of est->seq. Its callers
appear to be:

  gnet_stats_copy_rate_est() in net/core/gen_stats.c, reached from
  netlink dump paths in process context: tcf_action_copy_stats(),
  tc_fill_qdisc(), and the drr/hfsc/htb/qfq dump_class_stats callbacks.

  xt_rateest_mt() in net/netfilter/xt_rateest.c, which runs from
  netfilter hooks in softirq context or with BH disabled.

  tcf_police_act() in net/sched/act_police.c, which runs in the tc
  datapath in softirq context or under rcu_read_lock_bh().

Netpoll transmits with IRQs off, but it calls netdev_start_xmit()
directly. It never reaches qdiscs, tc actions or netfilter.

On !PREEMPT_RT, est_timer() runs from the timer softirq. If the writer
interrupts a process or BH reader, that reader just retries. On
PREEMPT_RT, preempt_disable_nested() already expanded to a real
preempt_disable().

The commit message also says the reproducer relies on a test-only
hardirq injection.

If no real hardirq reader exists, could this be presented as hardening,
with the Fixes: and Cc: stable tags dropped? If one does exist, could the
commit message name the hardirq path that reaches gen_estimator_read()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923032936.2020902-1-runyu.xiao%40seu.edu.cn
