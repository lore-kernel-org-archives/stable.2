Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D28E3AEF51;
	Mon, 31 Aug 2026 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166770; cv=none; b=QvDjqBvLN3OsX551KbBQeCal/IFch6IK3e2UjxB+yO8snp5VAND8qrPapYa/pK3F6X/n2loyJO0qzhmaPk0zfi441GnPadJi/pNTGFSxIQB41mGkpM4Gt5nW3EhBqOIlNsUGO7ebR/IQgK8vDJCjG5yuSLEty71RyF6UqjTyoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166770; c=relaxed/simple;
	bh=yHLKqiHSMi5Qlqfrv8B+hAHoBuBgiRFfvw3k37K+JYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZMzweN1m1g1BL8wIag2zqgEMw8P45whg+/Pc4S3BYfVFjywiRONZZx7eIdkqnTdNAiEwspJHp5F6Fr66itkIOulQrlTKsFCXXrFNK2/x+WLUMkPBnV3wjroaK7h6VrWcbLUonuFbdO6cvme7GAS1C334pcc6noGTB8P2yW81ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bmOFRAo+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bmOFRAo+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788166764; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9v0BP3GeNz1fpDytGFvCV40/reEzfB3yIUgJeq3tQxA=;
	b=bmOFRAo+8KNfd69oRQnJc3vAzY7qCxh6ZwTuroaTVqWs/6raZgrzSJUNZEecn5mhu2icK5Bm1WtJde6AfRUJ+oIT9AXHOv6H7CoEfsVp4e0VodQ5Y0thbp2uhOAsCVEnOpgH20M7xMYCnkWjDsaqwUUJ1u3hMr0+CqfIkjgrkI8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9vVcQ._1788166753;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9vVcQ._1788166753 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 16:59:22 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	xin@zytor.com,
	luto@kernel.org,
	jpoimboe@kernel.org,
	rostedt@goodmis.org,
	akpm@linux-foundation.org,
	rdunlap@infradead.org,
	elver@google.com,
	andreyknvl@gmail.com,
	glider@google.com,
	gor@linux.ibm.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event stacks
Date: Mon, 31 Aug 2026 16:59:11 +0800
Message-ID: <20260831085912.2485095-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260829094207.GD776954@noisy.programming.kicks-ass.net>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-3-xiangzao@linux.alibaba.com> <20260829094207.GD776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 29, 2026 at 11:42:07AM +0200, Peter Zijlstra wrote:
> I'm not sold on this being a CONFIG symbol, we have far too many of
> those. [...]

Fair enough - v2 uses your pattern and drops the Kconfig symbol.  The
fallback goes next to its only user in kernel/stacktrace.c; putting it in
linux/stacktrace.h would make that header pull in asm/sections.h.  x86
defines the macro next to the markers it tests in asm/sections.h, which
also gets rid of the arch/x86/kernel/stacktrace.c hunk.

> This is all confusing at best. __fred_entry_text covers all entries, it
> cannot distinguish between irqentry and syscall. Why is that not a
> problem?

It can't.  But the only consumer, filter_irq_stacks(), does not use the
range to classify entries - it uses it to find where the event stack
began, and cuts there.  For anything entered from ring 3 the entry frame
is the outermost frame of the trace: the unwinder follows the pt_regs
the entry pushed and stops there because user_mode(regs) is true
(unwind_orc.c, "End-of-stack check for user tasks").  So the cut is a
no-op: the syscall trace is stored whole, same as under the IDT, where
entry_SYSCALL_64 sits outside the range.  An IRQ hitting a task
mid-syscall cuts at the inner kernel entrypoint and drops the interrupted
syscall frames, which is also what the IDT range does today at the
asm_sysvec_* stub.

Only ring-0 events and the IRQ/NMI forwarded through
asm_fred_entry_from_kvm() have an unrelated context below the entry
frame, and those are the ones filling the depot.

The existing markers are not irq-only either: they wrap the whole
asm/idtentry.h expansion, asm_exc_* stubs included, so this range means
the same thing they do.  If you would rather it covered only the ring-0
entry, moving the start marker to asm_fred_entrypoint_kernel (+256)
makes no behavioural difference - I went with the whole block for
symmetry with the IDT side, but have no preference either way.

Thanks,
Yuanhe
