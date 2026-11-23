Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795453670;
	b=eqUqfTwBl1XfzNjrVqWhRcvCx9uTwYvrfgFERyxjIznYJLnJiZDOQdI4EzEK8Ti5ZA19
	 2FMgKtngV+tG2QSXFsP2+g0u2IiTNvdfdspY0UxlqQLVskZuS4kTTBEuxauYLckOHJiDv
	 Jl+NM/yFZoU+JkSpcYjm6Wj0iPqv0yINFzbW3/oVeSgRN364qRvIC+wMafA4Ibhh+z/LP
	 QQ/fVVjvNulS272VNGnNUFJHxo3T6vqQuaewqsCVLTT/5UuVbu8p77vyZRXFVa4ZnVrNp
	 FRkXtH7MpyAr0Pr6Dc1Epf3EVGTv4a5z4zTsycaybFonNbgb5Q2HkDd4DJtE8jKLlmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453670;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
	b=wPwWD9wMZ4372c0e3aEL2kGy9WkoA30x1OQfmh3kSCyk7yVHdyb1MgTTH8eoHgzUtZOF
	 LZ8g9OzEy+wS5TaUU0/sMbZLN6K+R6dTKK/18miaUZ4hvBz4LPFKHMsQHYEqS+I43ic8m
	 0rymfJODn9t1DvM/r/rLW/ZY8ipypOh2vBaB6l5+nK5XGWpCeNRoN1IH8B20G2Io/UAwa
	 eQIJdhqltFkhVffzEDB77O+P7mCc92V9kF8DEy8klk4mNqavLr1ZxOxAZ+yGfOPfVB/zp
	 6sghz5Ym8vyqxcYbWC8ZP/Q5g+puObLzkAznaZ3iN8SXCicMNEcQdHGAEb54i1K9nHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bJJCiYt0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6AA606A32A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E6AA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bJJCiYt0
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b894d9a075so3855973a12.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795453668; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/aLiGMof+AYRHhcdaYmZqmnRYUHBKiWAHA7+uGhwaZXrDOarXA32T6szo2q0HhJ0W
         n19ujXIg6WpH9b/h2FBsE+IxsDEba0/1jp1czWZCOvMJAg9TNVmWkfrKgNBPsnZBcANy
         NujgisPT7lvRDDM8xCwom3/8QAZirKRQO1yGzPmu/vrR+VnnC9ocrESaQicy+PzbfH0j
         vcHLazxoU7ErntXZnWsLxUIcFMb2mmdM0NsJasHOhRJuNx85F/N+K5USTShV30DVcCgD
         mxzvb4ksi23+odcQwynotbySJ55bCf87NGbxowGzwN2de0Ma2B7cKdRM2kk33b0DULt/
         Rp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        fh=MZFMftiRbjMmONQmWtw7zoy4V1YpXYdu5EubRouXUyI=;
        b=HrYD+OpTsKUMhlpP/spjB7YDFvEP8lZVGfqvTNWw34qiC5aTJHbCimJ60uD8txSJK9
         OCADuT8ikkx2J+AzlrbTFe3FsBrd3rC95o9lNAty2/GcTX58fwlaXCH/7NPOXoitdWnq
         5ycXEjiS4DOylQjLYIEAwLbNEobxKrT1BCK/Rqo707I/FkSOyQthTU7ADc4FXDwX5xjE
         w49bspuSk2QQmkpqJnMijHbKHOehz1QFlbJxzzANqL8WNjYGDV2Wbf+cn1E3nFwrc9yL
         cCnbIGOqZpsJe6LTRtr25ySjCp9Lvl6kBgUg6/IWH25SPdUqcFWcNoOa3uB0M3W2d4qQ
         mbXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795453668; x=1796058468; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        b=bJJCiYt0S/vb94j7FaVaundwc0nL1p6kzmMdCgNUdSklpo9uP/FCGc33k7C365cnWR
         Tj1Kp85kU/ruBKGuyRt19q2mnKBsj3DuaoAnBMEV0DV7z/pdiWYm4i/ejXqJIaeT98sI
         KP/PzGEI276UWbWHUyCb+urtpTW3xCkIB42Oi3pp2qD6U5QOC8K6eJ1iJBzxINt5neF+
         MAnUdoHI/1MOLYf8lblXa0OPV+HDeFcoV+xUzsWWcuZuOP5O+ajqRYZd31gN+fI3Yumm
         WwLK4Z/rrRZzFMJKfc/jjvERNbVYwwwhcLyQquCUyS5WVak2uVFQ2r71zz3K1JOqF53w
         pLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453668; x=1796058468;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+xaIvYw9qB8U9m5yBZTbNli0aV2ssc6MRhHdFn2AjAQ=;
        b=HejktB3xbwrsVtkmBoC9IdmKfZBOovADJc2e2hIUcJnUP6FR+Tx91CVcfdrFECvEeh
         tS5Z3UTaJ4ID8HzbAxNmIMbsl630yfcOO/S5UcDblwgp5gmHuujdPdKO+JZ4DjIWhbyT
         3jwrs7oWDkX0nfyLRDarZoBVA8Gf+howSVyqssWXo/uhWzm3pEh62CPv8Zk5Y2EP6Dfq
         GSQgEwXfhyyxQRLqbnqzzQbU9VOKd6mrYKKyFADR3KCRI61Zb28sG4RYHzmSo0WBs3M+
         5h9VZkl+NUhrOL5fUsnMIorc7NJDw1BKUwfVvPNYMERkJ/6ysDo+xoeKjela7X+cR8F7
         CxtQ==
X-Forwarded-Encrypted: i=1; AL+hErFGVejnuVAnxBnxatE3EuZSk4h58XxHtN8DV16LBdhD1jojZYZQKj+gMF3388omS14IVEoFhWw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9S1sObcB2nd4DUONynaQN2C5Ei199jqcwEn4znXqFmpr1YUCaA
	OinN1b/CbQtOcvTTN3tHU/VcC4HTG9rBB8FiCvbdAUPrV+28e0da31nAqGZsgkWSGg/iSud3AGk
	OdPSn/R1s5agOhTpvNA58UK7ow4QN7sjd++baDNB3ww==
X-Gm-Gg: AZFdTZdYdpva5fmjWQJ/XkCuAAH+cRmxZAbiAyLa2NixAK35CG20RoN1oLP2x+4voP+
	o3qXe82hy8IOsVOh6Ho+0dfownLt1UotvH8znVs4o2SDD6Qf9hUUdn9iodpUnnkW6eHYMF3BeFP
	cPl+fj5efubGPQc8PJ2J1wYoLRhbXVzTL3PZeOLILM8+dRzcnoDmarXvI+SeVBI2D4xrrgycXD5
	ctGr3Ldmp2hkQNt87D+nXkV6uDAA0CxHXsjgTWC/q6g+6BnLw3+8ud0nJ2fLRiwkEWGT5BkZCMG
	g+b5VJF/3K6dL0G2Dhb8/3fF4kmYsNVVb0B/482oXf75M86WdKynRXA4Xf2kYkyycEWTbCGOVb4
	mNtgEVWzwhDympTrtDekXPIIbekTdx37kcHytTJhG2OEx8FpU+567rA5KhqgUU4myimjsCg==
X-Received: by 2002:a05:6402:1f90:b0:6b8:6d0e:42d1 with SMTP id
 4fb4d7f45d1cf-6ba37ec55b7mr8892708a12.42.1795453667947; Mon, 23 Nov 2026
 09:07:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com> <20261123160934.2289260-1-penghuang@google.com>
In-Reply-To: <20261123160934.2289260-1-penghuang@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 23 Nov 2026 18:07:36 +0100
X-Gm-Features: Aa3M54pZP_B9lARK2Zw6EDmAmPbhCNYrxOAs4lBrYCe4I2A8S177FGDlJx_bcaI
Message-ID: <CAKfTPtD17e-veL1QgrhO6i4nsKyA3QfOEm8jNinJ_zf+vc8RDw@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
To: Peng Huang <penghuang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 17:09, Peng Huang <penghuang@google.com> wrote:
>
> On Mon, 23 Nov 2026 at 11:34, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > When all tasks are moved to sched_ext, fair utilization should be 0
> >
> > ...
> >
> > This is not the right solution but a bandaid to hide the issue. When
> > there is not fair task,  rq->cfs.avg.util_sum shoudl become null.
> > Please look at why it is not null.
> > It could be that the update stops before everything has been
> > propagated correctly in the task group tree
>
> Thanks for pointing this out -- you are right, and looking into the
> code confirms your suspicion about stopped updates and incomplete task
> group propagation:
>
> 1. Deferred cfs_rq->removed and unvisited sibling task groups:
>    Tasks that exited (task_dead_fair()) or migrated while sleeping
>    (migrate_task_rq_fair()) before scx_enable() queue their load/util
>    in cfs_rq->removed via remove_entity_load_avg() rather than
>    deducting and propagating immediately.
>
>    During scx_enable(), switched_from_fair() -> detach_task_cfs_rq()
>    only visits and propagates along cfs_rq chains that still have at
>    least one live attached fair task. Any CPU or sibling cgroup cfs_rq
>    with no remaining live fair task is never visited, so its
>    cfs_rq->removed stays undrained and its tg_se contribution remains
>    in rq->cfs.avg. Once __scx_switched_all is enabled,
>    scheduler_tick() skips sched_balance_trigger() and fair_sched_class
>    is bypassed, so __update_blocked_fair() never runs to drain and
>    propagate those remaining leaf cfs_rqs.
>
> 2. Sub-divider util_sum residuals:
>    Even on visited chains, if tg_se->avg.util_avg has already decayed
>    to 0 (with 0 < tg_se->avg.util_sum < divider) when the child
>    gcfs_rq's last task detaches, update_tg_cfs_util() sees
>    delta_avg == 0 and returns early without subtracting
>    tg_se->avg.util_sum from the parent cfs_rq. Independent PELT decay
>    truncation and integer removed.util_avg accounting can also leave a
>    < divider remainder in cfs_rq->avg.util_sum after util_avg hits 0.
>
> For v2, rather than touching update_idle_rq_clock_pelt(), how about
> adding a fair helper (similar in spirit to rq_offline_fair() ->
> clear_tg_offline_cfs_rqs()) and calling it from scx_enable() in the
> existing per-CPU scx_switched_all() loop (where rq->lock is held,
> rq->clock is updated, and rq->cfs.h_nr_queued == 0)? Specifically, it
> would walk leaf_cfs_rq_list bottom-up (plus &rq->cfs) to:
> - flush cfs_rq->removed,
> - clear load/runnable/util _sum and _avg on the empty cfs_rqs and
>   their tg_ses while preserving last_update_time and period_contrib,
> - clear tg contributions via clear_tg_load_avg(), remove the empty
>   cfs_rqs from leaf_cfs_rq_list, and update rq->has_blocked_load.
>
> Does this direction look reasonable to you?

Yes this seems a better solution but It would be good to reuse
__update_blocked_fair() which already does the work for pelt signal.
Regarding your issue with util_avg == 0 whereas we still have a
util_sum != 0, we can use delta_sum = gcfs_rq->avg.util_sum -
se->avg.util_sum; in update_tg_cfs_util() instead. When util_avg == 0
we will be sure to clear util_sum too

Thanks,
Vincent
>
> Thanks,
> Peng
