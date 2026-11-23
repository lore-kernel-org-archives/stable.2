Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450177;
	b=1Qs77wwKRz+pQiIeDH3tRxkdaQo78a1+vb3ZCzWw6TNtkamKx9mEazmcool0Mo7J2mP7
	 5z1RZ/bU4Q3OeLIKypFyRhi9B5BA3jq//zQhlWrDep9AbOiMG9LaY29bFGdd9O2WW7DoJ
	 nsUCbBdvOaZMPPu4Dm81Clpq7S6TOCytCG9IJkKUP4TKvxx9kxAiBmfqBsyaAxQ6lBuyO
	 eoZK+CWH/X2V4oDmF3zFK7iQHlhA1Su1aAknJV+wC52CuhPLBZ+MfuSACxpRQwHB7rWve
	 csR8hIx7thgjR6JqJqMOMmID1F9a/qgWdx3tgVjsqbDt3PEMASJsHX9k444yChk07Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
	b=2bkAXmb5KQRlZNpSLCjgAFEkiZo27MY2zLC+3Bq0h9BnDd0UERu0ci/RKWSI3C9ZKLKD
	 rY5orEgp1jnRDx0rMwYreFKsIbL7vVI1Vjibh/zX4JWXPn7J0Xcb4owoNwN5LFToFk8+r
	 RzK/EHfNU893PlKhKRQyARFpVXeNATZct7iRAIa+HuvHxzi2Ap6IaJjfkqTrifKJg6GPM
	 Vr3n0F3ZHa6w+ZjfvEtyco6Lj2ew4y4W/b9pfKkT+Vm3bunaFxUoNSg3Rqqq4j78WCXWi
	 waAIHsYTTsPwkj5ScmtfVZfVu3bWVTEcX4KnbGN1hdOkvnlwywQSFyTPwcDQ4JFJKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ewKOjoXP;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F5606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E04F5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ewKOjoXP
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3869865a304so1559794eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795450176; x=1796054976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
        b=ewKOjoXPN39yp0jVeaMqx6C2OwF0rXLLiqjYLeRo3WkCV1R48gogHGci439v1gMnsa
         BmbLTPcjth/T6hJBuzIgCHOkUnYmt/HjQYaU0A/R9Dcw2nkveWRI2fvNP1tdESzac5+b
         gtX4cEuex2rGRf90bGPd/0ovDW6gAYokWYdb0D9bbYL8N8BOH/Tpd30U6qK3p3uU0QaA
         94FHbBLRK7YUWFDFOLEQX49n7R/5rzhJizbn5nKL3wVBV7vQ5bK0694LnQ+aUIcd6dFE
         Qu1KVM0Yct4VZgRlfK4/fYxSfCJSxseXUh+G7gMdcJFDaTL/+Nhvf2IoaP13D51+f5U/
         DIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450176; x=1796054976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhcfpBwHSU7MgwxhgP4Qq1k5bLuK7ieaSxmvk+gyAcc=;
        b=UMu83qBlwO2bh19pG+XT0RdFUNVaKEJMjuR05HcBf2fcMFYw0aDSWwwhokuQeX2+3b
         ARXCCc30O7v8TU1H9vN39sMjaFkKU7KT2xd/uB23z1+tHeSO3ty2XBC/E/avfYWwUYZU
         LuhS1n+wQ8EVlEownFCqnfupVdp8Ox43GZhzPyLLitW9+WyXMMA55CkdcyLKEuzuh1Dd
         4sB1Crp2r/xnlAd7qW2A5gzpptb9nRCaDk5TQPJ8CCfuPMiPwIJQoBY7QkIela4qYkQe
         HuJUEd8sXWelI5l0DmBb2ixhUHcXxJtVSuafj7HZwfgkO/g96KzyMXzdddG7Tty14Oh5
         dyaw==
X-Forwarded-Encrypted: i=1; AL+hErEp/oEBSvejtJ/050XmWW7qP5lQXJTfpi36QcotrzhTgpUfgQ7KhDvuEBxVOXtFdHBn8CMc1HY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gAefHGj/nJ6N5zZDG0xtlsexDwmOml8+ICAZ+H19nG9FFvpo3
	cVZjQ2wOgsW6fEKeQgNYp6EUj786gkcg27caXyb6Ci7OUKBjpTtLIkaLh0OTJcl/ZJ4eetTBfyR
	8fChnxph90eF6hDXlQQ==
X-Received: from dybmf40.prod.google.com ([2002:a05:7301:928:b0:36c:9b55:8436])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4284:b0:382:1aea:c21d with SMTP id 5a478bee46e88-3857191bcf7mr12981179eec.41.1795450175386;
 Mon, 23 Nov 2026 08:09:35 -0800 (PST)
Date: Mon, 23 Nov 2026 08:09:34 -0800
In-Reply-To: <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com> <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123160934.2289260-1-penghuang@google.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 11:34, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> When all tasks are moved to sched_ext, fair utilization should be 0
>
> ...
>
> This is not the right solution but a bandaid to hide the issue. When
> there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
> Please look at why it is not null.
> It could be that the update stops before everything has been
> propagated correctly in the task group tree

Thanks for pointing this out -- you are right, and looking into the
code confirms your suspicion about stopped updates and incomplete task
group propagation:

1. Deferred cfs_rq->removed and unvisited sibling task groups:
   Tasks that exited (task_dead_fair()) or migrated while sleeping
   (migrate_task_rq_fair()) before scx_enable() queue their load/util
   in cfs_rq->removed via remove_entity_load_avg() rather than
   deducting and propagating immediately.

   During scx_enable(), switched_from_fair() -> detach_task_cfs_rq()
   only visits and propagates along cfs_rq chains that still have at
   least one live attached fair task. Any CPU or sibling cgroup cfs_rq
   with no remaining live fair task is never visited, so its
   cfs_rq->removed stays undrained and its tg_se contribution remains
   in rq->cfs.avg. Once __scx_switched_all is enabled,
   scheduler_tick() skips sched_balance_trigger() and fair_sched_class
   is bypassed, so __update_blocked_fair() never runs to drain and
   propagate those remaining leaf cfs_rqs.

2. Sub-divider util_sum residuals:
   Even on visited chains, if tg_se->avg.util_avg has already decayed
   to 0 (with 0 < tg_se->avg.util_sum < divider) when the child
   gcfs_rq's last task detaches, update_tg_cfs_util() sees
   delta_avg == 0 and returns early without subtracting
   tg_se->avg.util_sum from the parent cfs_rq. Independent PELT decay
   truncation and integer removed.util_avg accounting can also leave a
   < divider remainder in cfs_rq->avg.util_sum after util_avg hits 0.

For v2, rather than touching update_idle_rq_clock_pelt(), how about
adding a fair helper (similar in spirit to rq_offline_fair() ->
clear_tg_offline_cfs_rqs()) and calling it from scx_enable() in the
existing per-CPU scx_switched_all() loop (where rq->lock is held,
rq->clock is updated, and rq->cfs.h_nr_queued == 0)? Specifically, it
would walk leaf_cfs_rq_list bottom-up (plus &rq->cfs) to:
- flush cfs_rq->removed,
- clear load/runnable/util _sum and _avg on the empty cfs_rqs and
  their tg_ses while preserving last_update_time and period_contrib,
- clear tg contributions via clear_tg_load_avg(), remove the empty
  cfs_rqs from leaf_cfs_rq_list, and update rq->has_blocked_load.

Does this direction look reasonable to you?

Thanks,
Peng
