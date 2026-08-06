Received: from jowisz.hostline.pl (jowisz.hostline.pl [46.248.187.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78E3DD503;
	Thu,  6 Aug 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.248.187.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006925; cv=none; b=f/sFS3hxqjoccThro2sCRlqzk1r2lOgYsUJPBX+d73XlxZDhen+XoMdXKIA4Mh8Ua9PFr9ATdfSjYjvfPZv6uEyRHKbw4XqWGteGzimqW6C6Ig0AdMPJYfWHAyyTyyPz28n54nmxwGCNnculWU7+IlItkKU71vBKwxBMLbtj6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006925; c=relaxed/simple;
	bh=CMKvJi3KQRbRwrZq4vl9A3QirNwV1XRUc0WsYYDVU8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+wr/37rLaUiHVjx2U7ke4UKUUGCTogpzre57/6ZTmWiKTGq4mSLQ5J2x4JDBL0yMQXGAC0sI/1uFYm2JrDSMUejeIvQr3SzyN3vozBncvS2l9Mp3hzEuJrDGdYV52Mh6pOh5cPA/vjsRLhSlfaAyi4G0NjK8NWBtSmnGaya7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krystianslowik.com; spf=pass smtp.mailfrom=krystianslowik.com; dkim=pass (2048-bit key) header.d=krystianslowik.com header.i=@krystianslowik.com header.b=vH9CgwPx; arc=none smtp.client-ip=46.248.187.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=krystianslowik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krystianslowik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=krystianslowik.com header.i=@krystianslowik.com header.b="vH9CgwPx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=krystianslowik.com; s=x; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ae7KKpgNYXnUIiLAeXMg1zBICpTLKdG/tSLDRQqjUlE=; b=vH9CgwPx1WukvQxisfL1GBuB+h
	6htBN1GvUcNAFmEDZbg67bnk30CSg9tmKzDEKlLuyHlq0POcqxtx5h0DePHBkMJJa5/huVwei8rZz
	2H0YpO7dmoxjgnOSudPjOqleeIftR6tgpAVD+E5zXv6TOB6fmdUxVIo9zC4+B8GIwesQIQ/Ssm1yt
	ebl9v+GUFdJPKWCpR0ZbWWlrZ1XV6Ct5TE2IAvNIqnHlRjuQ2aIgG2x2+ICxKsbFPS6utwa4TT3wl
	747yMdFnpdCjU1Ih7mZDD+EPSoDUeTO5dgY2xxaP7fEnaeqrO1WCU4R05Zoe1Wt5d44o+Z/ePcvVA
	/GE2lz+A==;
Received: from dynamic-002-214-159-214.2.214.pool.telefonica.de ([2.214.159.214] helo=localhost.localdomain)
	by jowisz.hostline.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <me@krystianslowik.com>)
	id 1wrtzB-0000000FJ4T-1oXh;
	Thu, 06 Aug 2026 11:01:56 +0200
From: Krystian Slowik <me@krystianslowik.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Krystian Slowik <me@krystianslowik.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/core: Don't pin the idle task in migrate_disable_switch()
Date: Thu,  6 Aug 2026 11:01:32 +0200
Message-ID: <20260806090139.20495-1-me@krystianslowik.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806072217.GL49951@noisy.programming.kicks-ass.net>
References: <20260806072217.GL49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: me@krystianslowik.com

[Resend as plain text, the lists rejected my first attempt for HTML.]

> What is actually doing migrate_disable() here? Why would the idle thread
> ever hit this...

Nothing, as far as I can tell. I went back into the vmcore and the
counter didn't come from migrate_disable() at all:

  swapper/3->migration_disabled == 8      /* 0b1000 */
  cpu3 rq->nr_pinned == 0
  the other 15 idle tasks: 0 and 0

That pair can't come from the API. Surrounding bytes are clean, the
whole anomaly is one set bit:

  swapper/2 +2416: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
  swapper/3 +2416: 00 00 00 00 00 00 00 00  08 00 00 00 00 00 00 00
                   migration_pending        ^^ migration_disabled

A second dump from the same box two days later (rcu_cblist_dequeue,
unrelated) has all 16 idle tasks at 0.

Correction to my patch description while I'm here: "two separate
machines" was wrong, both idle-loop oopses are the same box.

Fleet context, since it changes how much you should care: three
Ryzen 7 7840HS boxes, no ECC, DDR5 at JEDEC 5600, no EXPO. Same
board, BIOS and microcode, identical apart from DIMM vendor and SSD.
Taint 0 on all three, no out-of-tree modules ever, BPF is systemd
cgroup boilerplate only. Two of the three have produced corruption
oopses over five weeks (css_rstat_flush GPF twice at the same RIP
plus a slab freelist on one, the rcu_cblist fault plus this bit flip
on the other), and they were on different kernel builds at the time.
So I can't separate a scribbler from a platform fault yet. DDR5
on-die ECC makes marginal cells the less likely half, though it's
SEC per burst so not excluded. Memtest next, with low expectations
at 11 events in five weeks.

Which makes this not a fix but an assertion, and the stable Cc
should go. If you want it at all:

    if (likely(!p->migration_disabled))
        return;

    if (WARN_ON_ONCE(p == rq->idle))
        return;

behind the existing early return, so the hot path doesn't pay for it
and the state screams instead of oopsing under the rq lock.

Placement is a guess though. Anything reaching do_set_cpus_allowed()
with p == rq->idle hits the same missing enqueue_task(), so
sched_change_begin() might be the better home. And if you'd rather
not paper over corruption in the scheduler at all, that's a fine
answer too. The thread already answered the question I actually had.

Thanks,
Krystian
