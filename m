Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA443438B9;
	Mon, 31 Aug 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175554; cv=none; b=n10dVy4Jg6dV3h0goABdps+f8w7H8mCKMklctzTmRobTJgFINyaF+HxZXHmTKP+wcxVKfqY7rNthuMSWXUh1pgc8B6mycgMgy2JswSYarVP4es7owLtQDRySRo4IOGwCTeqBWRyGzTqR8hKNLBcIs1YxAqV5whKy7cHlejYFCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175554; c=relaxed/simple;
	bh=rgjjUs9qpiN7mOVY/HC+xscrZHQdwqkYyxE9tTCkVrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYqUzOy/ptjiYt6cQRstjfc/x8C2VIQPvTfb87db9xi0jMrYZLyBFMLUulwvACyw1UBHIhSMvKcOgRQ9TtHFNSwbrmbmAtngMWsAPEgki+EqCUeeBrSZTAM/4qTqllbX7nZy/Rt5ChsO24a1XIK1yTXWvRMO7mYuYmi7mhok3vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YOYYFYd4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YOYYFYd4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788175549; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=spH4at2NavJ3nhBs7x+ktUtl+HoDKu/ldnHrm+nrOa8=;
	b=YOYYFYd4AvBfk+KvjMXOGtFqlbgnz+V0nn8+PKPLe5vbOPrzQ30vjj53Sm8VCAEBAmAHKYMUU2EYDag25vHl0vx6JpURHA3oeaw9gEhQ5dB93C9J9YRo6LwWLU+PZUIjLOoFLhQKylQquz62rIDh1tGo25RjwvB8lq9XXYE1ySs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X9xxp-B_1788175537;
Received: from banye.tbsite.net(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X9xxp-B_1788175537 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 19:25:46 +0800
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
Date: Mon, 31 Aug 2026 19:25:24 +0800
Message-ID: <20260831112536.2803657-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260831090124.GH4120091@noisy.programming.kicks-ass.net>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com> <20260827150022.1618235-3-xiangzao@linux.alibaba.com> <20260829094207.GD776954@noisy.programming.kicks-ass.net> <20260831085912.2485095-1-xiangzao@linux.alibaba.com> <20260831090124.GH4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 31, 2026 at 11:01:24AM +0200, Peter Zijlstra wrote:
> I would still argue the function name is incorrect, and the user might
> want a comment explaining this.

You are right, and it predates FRED: the ranges in_irqentry_text() tests
have always covered the asm_exc_* stubs, so it has never been literally
irq-only either.  The hook inherited the wording because I named it after
the helper it extends, the way arch_nmi_enter() is named after
nmi_enter().

v2 renames both: in_event_entry_text() and arch_in_event_entry_text().
The helper is file local with a single caller, so the rename stays inside
kernel/stacktrace.c; filter_irq_stacks() keeps its name since it is
exported and used treewide.  Both the generic definition and the x86 hook
now carry a comment saying the range is where a trace entered the kernel
and covers syscall entry on some architectures; the x86 one also spells
out why matching it is a no-op for filter_irq_stacks().

If you would rather have a different name, say so and I will respin.

Thanks,
Yuanhe
