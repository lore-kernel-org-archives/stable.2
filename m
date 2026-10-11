Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829A38736F;
	Sun, 11 Oct 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791711575; cv=none; b=G3N0XXV2l7h8eyQtSGT5Hkh97nUBiPYvbWigqhRxJDSvaAkZich2EXjZ/om6jzNAOwcTcl3azuLhbrTWfIooVu+yeovaPF4+rw1h1hqb30WyoUKP1y+jCKuO2wC1bIVHnXqeU4beYwKD5NZqCZWT5VKUhsYrTfuj7DXNOvcsrNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791711575; c=relaxed/simple;
	bh=F4vPbkivp07sxBitWuaNUQrXJFZKufdHm5Xy3jIvwS0=;
	h=From:Date:Message-ID:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1Wkc/rbQMLe/kTdxuGIT+2WiOmyfQawXLiI92+mj6MTWisdmx5596mX3zH6D/164DcEGwBOIob+/I1d/9LL6zi5X2o+GXrB+FgG9aqLPb74R0mgdu7NS3EXjvBEC19m+DVwg1JRo7P7SUUbnzAm82CMa3MQGPePG3Hc0ghz5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JVkzkBF+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JVkzkBF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Message-ID:To:Subject:MIME-Version:
	Content-Type; bh=F4vPbkivp07sxBitWuaNUQrXJFZKufdHm5Xy3jIvwS0=;
	b=JVkzkBF+Lt5mmYu/i28r8d7F0n6EPxhICJchCYd7VQblu47FWgeEAjePSArQO1
	tZU1psfoZHIybV2MPGr4ThPaynJQcjlOcjwiwLfhhf/u3a9lRcHlHDog08+oyw9M
	t8y0x+OYmqllTuo5/Jb3C9XhQJ9f9tzjS5JCArhH4sczk=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHlwXZWMtqKGnGDg--.40124S2;
	Sun, 11 Oct 2026 17:37:30 +0800 (CST)
From: Hui Su <sh_def@163.com>
Date: Sun, 11 Oct 2026 18:10:07 +0900
Message-ID: <20261011181007.7245901156-1-sh_def@163.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org,
	void@manifault.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Respect task affinity in restricted CPU selection
In-Reply-To: <ass0dexwariQCOtC@gpd4>
References: <20261011025256.4180374-1-sh_def@163.com>
	<ass0dexwariQCOtC@gpd4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHlwXZWMtqKGnGDg--.40124S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFy5Jryfur1xGFy8Jw1xAFb_yoW8AFyxp3
	ykK34kKw4kJa1Iy3Z3uw4DGr15Awn7Aa4Syr1fGr1SyFW5Kr109r45tayDZ3yUCFs5J3W2
	vF1UX3s3GFs0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ut3kNUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhrZOWrLWNr+MAAA3V

Hi Andrea,

> The fix makes sense, but I'm wondering if we should derive the candidate CPU
> from the task's state instead of relying on prev_cpu. In practice prev_cpu
> should be always considered a hint rather than a guarantee that the task can
> still run there.
>
> Per-CPU tasks could use cpumask_first(p->cpus_ptr) and migration-disabled tasks
> could use task_cpu(p) directly.

Agreed. prev_cpu is only a hint, so deriving the candidate from the task's
state is the better behavior after an affinity change. The restricted path
should use cpumask_first(p->cpus_ptr) for a single-CPU task and task_cpu(p)
for a migration-disabled task, while validating the candidate against the
task's effective affinity and the caller-provided allowed mask as appropriate.

> And could you also clarify in the patch description that selecting the CPU
> consumes its idle bit? Without the affinity check, we can claim an idle CPU that
> the task cannot use and later dispatch validation doesn't undo that side effect.

Yes. scx_idle_test_and_clear_cpu() consumes the idle bit, so the affinity
checks need to happen before the claim. I will make that side effect explicit
in the patch description.

> It would also help to mention that per-CPU and migration-disabled tasks skip
> ops.select_cpu(), so this affects calls from other contexts, such as
> ops.enqueue(), leaving the normal ops.select_cpu() path unaffected.

That distinction is useful. These tasks skip ops.select_cpu(), so the
restricted path can be reached from other contexts such as ops.enqueue(),
while the normal ops.select_cpu() path continues through
scx_select_cpu_dfl() and is unaffected.

Thanks for the review. I will incorporate these points in the follow-up
revision.

--
Hui

