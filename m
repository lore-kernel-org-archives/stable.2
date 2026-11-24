Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481265;
	b=slx8OerQdJY6Q3gG5Vnn9FQsnq9AfXsPaHZ4j8KHrb+42g3pT/4BkxoFgNzwJ9yCKUrJ
	 p/ufdkiQh33PCzJOByO1/wQMIB7DRzE6xQUPNeP5dqp7ANdXzQr5Ogt3sRE26UUvJ60nW
	 fPYUep5xNnaZHHtQJGi4rGNLT77e0dZ4EaUgs1JceyMFI59fYMveDEEtH6eb8iKMDu+49
	 PwS4fxm2gK4w/M3ZkqYGXdDLqJrd81/PE9pgxHKaTepRMVtfhQbu3zOyiTGL+TGQUYArC
	 48O587qzdlWCpdG0Vo2HimBhwCRCvG/xuPQnTXKrn2PhlXjwU3yA0gAoEq0XSvPokyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tDMwizw/fxrX9EdkfSy3P0m+iIcym6dxr577RysOy0w=;
	b=ewhpYmuuA3A/PukHx0hFSTYFLY3T3Che+F6yw/AwTo7EAR3K6Bjahdm5z0eNfe0Wkebb
	 VI4iBrjWQw17hs5KXGYbprT9rcGbdQ2ghQsQ+VnwlshY/oWUV1pk9JBJIPQV+gnxiRlEt
	 Lugc4sd5N5FmfPfY75qRK+38qTHPcMDjn3wmUOi04jsA1RjrYWL8WBaonuU0CPU4cv1PZ
	 Cb4ceWAXvXcAb94iNSl+aRLCFkdRFVfHBUsFBi9sd7DTuZLadr73Mgk7HlPq7M843qAR8
	 2oZmLy9McCutlEEjgmgsHKeg2XO55cgqBcSbf757T30hL+XzoOvjg6ps71gQkcideyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsGOJYRU;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52AB606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 00:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A52AB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsGOJYRU
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3854627c1c8so5815874eec.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 16:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795481264; x=1796086064; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDMwizw/fxrX9EdkfSy3P0m+iIcym6dxr577RysOy0w=;
        b=OsGOJYRUqVqvOsCYltNyjiIiNYG1UOsKPnxnIX3m/SqeQGY+o95ng7enZMqus1W6u+
         3Yc/xJsOzOV1WbHGdHUCvvHXRaqNeye+tzqwa94IEp7Ra+n9OANUgkvt2NXoZBDwyzlu
         sO8zw+w9tKSXMgZHvI37iz7jvzQujLBvAb658wWtQ+Mh5UYA/xMtX0rrUzg6SqUbyBC3
         ZWhWNGeWNAjSpi+RA4kmbt/8ASg1mDwXHJhdD2G5w+8rH5E3xwCqxyw8eslKA7MXgzau
         tI7exSrdOLkHpAruRIriwhQHg8etbcYdhGit+94vetyiFTuj9iuo1QIY+tMJLKgq/LNf
         W0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795481264; x=1796086064;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDMwizw/fxrX9EdkfSy3P0m+iIcym6dxr577RysOy0w=;
        b=JuwNs1RKePHEEiYg7RqQhy5cJ2rd31uvncVP+dPzn9JhV3fuOKb6bXtQJcQ0TxqcDd
         iCixBc5zNh3rWY/Vg+8lms8AAavThzWO6yJhgeFpfOhjpbvfVVhjGHXp9xNnlweA4tUU
         FApLWq7TApRzwwTxH5CvFtZ7ag5u6LY6PaIdxAXdqHuSeA3tFlBor1UTb9jAYZSKt0zk
         FKESQZCc51xBw5OonQLV1FjytGfUJ+5Xej/dT3vxJ2fHqAXb0fDLJEeYXtAV9kY9nOcO
         wTnQW2//7XVAR8mLeN2dMTEZYcYw8fY32KDT9BJLmx9yMenccYVF2iHJagaOWn5gddiR
         br3w==
X-Forwarded-Encrypted: i=1; AL+hErEoxLMpPVZcH61IFxXcmzaoy4lizg2+3mpa6YaEk5uPyUP5rqT1APtAtoLQkk6fhO8sQhbEZBU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qo3LaoEV0vOFpM+Auu2wgpfD5SCGjpe88IkkX5iWpl9Wh0BPz
	BY7d/XLIgVo/7BmJ4x85v0luX+IWoDEv34jfW4t04U0dKp21UM2oYt05Cn3H5x+HnS576CBPWfM
	D+e5I15mu7Ip7Xo4nCQ==
X-Received: from dycnb22.prod.google.com ([2002:a05:7301:b16:b0:386:af9c:96b6])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2108:b0:386:b99:8ff9 with SMTP id 5a478bee46e88-3860b999354mr11840342eec.40.1795481263233;
 Mon, 23 Nov 2026 16:47:43 -0800 (PST)
Date: Mon, 23 Nov 2026 16:47:42 -0800
In-Reply-To: <861e8b931f99acf9c44cff722d5e94e7@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <CAKfTPtCQpVhtVT7Mhqe1=Ukcmc1pX8Jgn9ypb64--8cJ-7G4BQ@mail.gmail.com>
 <20261123160934.2289260-1-penghuang@google.com> <861e8b931f99acf9c44cff722d5e94e7@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124004742.1248371-1-penghuang@google.com>
Subject: Re: [PATCH] sched/pelt: Skip dormant cfs util_sum under scx_switched_all
From: Peng Huang <penghuang@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Peng Huang <penghuang@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Mon, Nov 23, 2026 at 01:48:44PM -1000, Tejun Heo wrote:
> I'm not familiar with this code, so I may be missing something, but
> doesn't __update_blocked_fair() already do most of this? It walks
> leaf_cfs_rq_list bottom-up, flushes cfs_rq->removed and propagates the
> result to the parent. It just stops running once scx_switched_all() is
> set. Maybe the helper can run the blocked load update once on each rq
> from that loop instead of open-coding the clearing? If I'm reading it
> right, one pass after all the tasks have switched would take care of #1.

Yes, Vincent suggested the same thing, and I sent v2 earlier today doing
that one-pass drain via __sched_balance_update_blocked_averages(rq) in
scx_enable():

  https://lore.kernel.org/r/cover.1795462673.git.penghuang@google.com

> As for #2, are the leftover sums big enough to matter for
> update_idle_rq_clock_pelt()? It looks like fair can leave similar
> leftovers behind once the avgs reach zero.

You're right -- for update_idle_rq_clock_pelt(), #2 on its own is tiny
(< divider, i.e. < 1/1024 capacity per recently-decayed group) and is
not nearly enough to cause an issue once #1 is drained. #1 was the real
culprit in our reproduction.

I only split #2 out as patch 1/2 in v2 per Vincent's suggestion to clean
up the util_sum != 0 residual in update_tg_cfs_*() when _avg == 0 (which
otherwise keeps cfs_rq_is_decayed() false and leaves empty parent
cfs_rqs on leaf_cfs_rq_list in fair). Patch 2/2 alone already resolves
the sched_ext issue.

Thanks,
Peng
