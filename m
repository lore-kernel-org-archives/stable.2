Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853423395F;
	Wed, 12 Aug 2026 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527834; cv=none; b=V1y42weD7ARoS/lA01hg5/Br2JGrsz2l4ebILM0eCg6D9P45+RSB5Az0sMNBIymQJWRPkVnR7oL84PT8KFb+hutFnZXcEZHJPEdtnnEAoDoct+SJvGTcNzmw+lxI6MU6XBJwoDFTbG3VaNmnenrMsxFilbo8WN6InTO3hNj3na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527834; c=relaxed/simple;
	bh=XDR/2PVTG/RM5H77RckhF+lj6T5bPR1ePhBA135i0fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVAmFJljV49na1bcwIQKklewzxxD7wj2yo4ZWLcAOfKWXxEPaQN2ST85kwtMzQXeygxnG6DIatHXmvzE6KFLbt1iLEDo11/98uSMA3A/V9JLLI6I9EIWftAbXf2h0SphXg/GrCX6TpQ+JldpyCEvxR2g71QzGnsLci9st/SvA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Gq+hqnbC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gq+hqnbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6z
	znDAqlisoP38UeZFXKIQzKMf/yDIxj1gzqZlj0hqQ=; b=Gq+hqnbCtewsUhGNsr
	U5lBOmzpj+6r0N96FT9v3yRXnxeXH2rGznXt2tuawjQ42IaJ1wJCsY+vYbLumQTQ
	S53yMhJRn2KR4Mpe+9xXOd/yRVU62QjuQ8Q1m7Xba4IxteuoxdUL2NzaYfSIi+cx
	IEFCqLDInWnrTk5eSePumrqWc=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3V0gVQHxqVJe5Og--.61922S2;
	Wed, 12 Aug 2026 17:42:46 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: juri.lelli@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	longman@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: Re: [PATCH] sched/deadline: Fix DL server initialization for initially offline CPUs
Date: Wed, 12 Aug 2026 17:42:01 +0800
Message-ID: <20260812094159.2209320-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb>
References: <20260811100612.1408592-2-sh_def@163.com> <anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V0gVQHxqVJe5Og--.61922S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryUXr47Gr47tw4rtFWfuFg_yoW5AryDpF
	Z2qa1jgws2k3yYk34UA3y8WF1Y9wn5X3W3Arn3Crn7CayYkr90qa17trWagFyUKrs8Ca42
	vF4jv34I934DtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwRbOLmp8QBZEowAA3Q

>Hi Hui Su,
>
>On 11/08/26 18:06, Hui Su wrote:
>> Commit 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
>> moved DL server initialization to sched_init_smp(), assuming that all
>> CPUs are online after SMP initialization.
>>
>> That assumption does not hold when CPUs are intentionally left offline
>> at boot, for example with maxcpus=. sched_init_dl_servers() only walks
>> online CPUs, so the fair and sched_ext DL servers of an initially
>> offline CPU never get their default DL parameters configured. Bringing
>> the CPU online later does not run this initialization again, leaving the
>> server parameters at zero.
>>
>> For example, boot a two-vCPU QEMU guest with maxcpus=1 and then bring
>> CPU1 online:
>>
>>   # echo 1 > /sys/devices/system/cpu/cpu1/online
>>   # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
>>   0
>>   # cat /sys/kernel/debug/sched/fair_server/cpu1/period
>>   0
>>
>> With a zero runtime the fair server cannot be activated, so fair tasks
>> on the late-online CPU can be starved when higher-priority tasks
>> monopolize the CPU, potentially causing user-space workloads to stall.
>>
>> Initialize DL servers for all possible CPUs instead. For CPUs that are
>> already online, preserve the existing initialization behavior. For an
>> initially offline CPU, initialize the server parameters and keep its
>> bandwidth reservation local to the runqueue, but do not account it to
>> the root domain until the CPU becomes active. A subsequent root-domain
>> rebuild then publishes the reservation.
>>
>> Avoid updating the runqueue clock and setting up the current CBS period
>> for offline CPUs. The configured runtime and period are initialized at
>> boot, while the dynamic runtime and absolute deadline are initialized
>> through the normal CBS wakeup path when the server is first started.
>>
>> After the fix, the same test reports:
>>
>>   # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
>>   50000000
>>   # cat /sys/kernel/debug/sched/fair_server/cpu1/period
>>   1000000000
>>
>> Fixes: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Su <sh_def@163.com>
>> ---
>
>Thanks for the fix, makes sense to me.
>
>Acked-by: Juri Lelli <juri.lelli@redhat.com>
>
>BTW, while reviewing, sashiko noted a related pre-existing issue in the
>init=false path of dl_server_apply_params(): __dl_sub() and __dl_add() are
>called unconditionally with cpus that could be 0 during CPU hot-unplug, when
>the CPU is no longer active but still online. sched_server_write_common() only
>checks cpu_online(), so a debugfs write during that window could hit a
>divide-by-zero.
>
>Could you take a look and consider posting an additional patch to address it?
>---

Thanks for pointing this out. I will take a look at the issue and post a
separate patch to fix it.

Thanks.

