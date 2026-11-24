Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532699;
	b=azK0s0qzy+gKNDAtMVa/7bQ7E6/grR2wZ55EJztyXnQbnxPu7RwsTbg0wTZqgZRV1CEr
	 iNqtLY+rHbpj/qdha2zcgp8xk5Mkm0jbg9wDmGvmgyXEbqdogQTuhwR13dI1TjW5JmhvC
	 QKxnonj6gXOM3pXkWl04Reqie5pZRm1qS/BLaAf3qjCg6sQYTAvAJtM8UK+rP4QLoq+Ne
	 shyuuRnc5IU5K71e88ueSN+4MS4sJhszJ27pss70MgqKcCyV+m6pE67Cer8H/wkM7PfcC
	 8ER6cqto1wTO+tDLEuJr/Xvmxp4v980I01dEkHVwCaZZ/UADKtJDSMxCopAoNEaLoqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532699;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bcl2PJvXV04dgKnYFVKpNkpO3QtdQMhmYVAKnAGdZ5U=;
	b=05z7b/GS/HmPda4qbbKlLUBVafpccbq54UCbocMkXZUAaW34BLrePB0GjbSqPD3/LhFj
	 Ugk2QDrCItbKegyJJHFBiQ1uuJH3ugYJo6VjK5qwPP1bDj5fJkyyAB1xlVAV6Q1F7xOhR
	 ++3r04ZQDQjiCw7f76GF/bWZWVwHU209IyY//ZmFTCfMc1/9Y4VF/VicQ51Oc1ZUxAHVN
	 t9aaD4dKLPlDmmwB9NGUbc3Cg5RTxIKkkjDfs5NFzbJflSfEv+GQWsRnnw3oV0zPASgUU
	 rOovy3iNjKsK1f4q+z+VgcZpcPrVwpZyiM+j7r9tR8FgoE4kaJ4CUaYFbu0NQpsCicA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A54tfeEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE87606A321;
	Tue, 24 Nov 2026 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A54tfeEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254171F000C4;
	Tue, 24 Nov 2026 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532699;
	bh=bcl2PJvXV04dgKnYFVKpNkpO3QtdQMhmYVAKnAGdZ5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A54tfeEHcgsWXjg+SJ53FX8mlg9+10DfPv1euMYyBpDB+2aS2f1+SZdyb0Smj466K
	 JDkUHT74+DWFsxn/ONKro23IhjtkV007bHB2YTuT07Tia15OnltAlmrTYxc95XP7Ce
	 BOZAdG8C1iR8AAuwgws/UpLZGWsNdxScd2LMqGHKq7i8AiX4iNJKWUHSL1zuLa6u7n
	 aK8BwXBh/t9FMyFHt/7SAIGZhI+Ifhj8C+Fx6FngmGMakuCZq2vRAMSE/RnSvXdko/
	 kXN/m8i2pI0LLl6oRAoIncWLXPPelxtb3U539vogmQiUX6QXoKH+sXHpMBBO9Dh1fQ
	 VVM9zQMaf3tPw==
Date: Tue, 24 Nov 2026 05:04:58 -1000
Message-ID: <322ab097a3e7c2dbae960aee2e8b4573@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched_ext, sched/fair: Drain blocked load on scx_switched_all
In-Reply-To: <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
References: <20261122015729.2512645-1-penghuang@google.com> <cover.1795462673.git.penghuang@google.com> <2b1ef28e12d12a1f894827b951910c1979d54d45.1795462673.git.penghuang@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, Peter.

On Mon, Nov 23, 2026 at 12:13:51PM -0800, Peng Huang wrote:
> Export __sched_balance_update_blocked_averages() and call it on each
> CPU in scx_enable()'s per-CPU scx_switched_all() loop so pending
> cfs_rq->removed entries and task-group propagations are drained cleanly.

This looks fine to me and this probably should go through sched_ext too.
Can you please ack?

Thanks.

--
tejun
