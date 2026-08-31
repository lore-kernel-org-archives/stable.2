Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2D46A60A
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189286; cv=none; b=nRf+KkkVQ7zsrEYA+IMKTkYqbOPmqjyURPEKllyMYNpGlUlHZMH3z5JJZqs5pXKh4X/gm0MMI3l2QPfwu92XjVL6AS8yXSDIuMGx7k4dqsgCLJTUStfWdwVqWZ6jmiiicGevEMzq49+l86C1gszWInd/Viwjd+cQMYk/rs5/7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189286; c=relaxed/simple;
	bh=cejwt0JUMmTaEe/6hf4yPaZLkUUpL6MLW/yW+wKRMfU=;
	h=To:Cc:From:Mime-Version:In-Reply-To:Subject:References:Date:
	 Content-Type:Message-Id; b=TYTnT2B2zlds1TNOvQlPRyLQctYq8Rky9jhaS+lL5HLFDo8H1m8KR7AcNdB8QUs9cAKSy4dMxhLvLSjgwf2uNLW6athyruTZ1s2PWuo2LkQBvxQHanLOnVoVPnIvndNLRJHRpyz1gyMo6wwDljIJXnW9so9/oBCvz6IHL9rQH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=DnHUuOPT; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="DnHUuOPT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788189273; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uxEMR+jwstlMsJAEyfB2rSIbeFQCMXEJ0slmlwOKrrs=;
 b=DnHUuOPTAVacw70CYe0UwSPIopJeiSuu6GaojBjLCDf5h6PDn/qIlglkBB05YVy3Y1I++c
 0AyoYE/TYv75GrdR5E66P2r59JqaVD0vezZqL3yq7c8nBdRysjOB/zBSIS973uUlRrVJrI
 e3jVgPqxZ4o/Fdk/fwIacg/pJ4+eO1f1r1H9r6lQ4bQGPhQWAvXj+AAF7mudi5m635GmQ1
 cUDaokUjjrsfB+f9RsVZSo0n4oa2E7nolIEuslvCwNQHBbrnnQjG8KzcAdk1B1Y90BQWmB
 wprJwXBwya68/AxqrxgI2FxN+jXkDqVvi5ANhdpL5yMsBllK5KBvOtMNaqMJrA==
To: <peterz@infradead.org>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <mingo@redhat.com>, 
	<acme@kernel.org>, <namhyung@kernel.org>, <kylebot@openai.com>, 
	<david.lee@trailofbits.com>, <stable@vger.kernel.org>, 
	<bug-report@moonshot.ai>, <shiweiming@moonshot.ai>, 
	<linux-perf-users@vger.kernel.org>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260831133915.GH4121339@noisy.programming.kicks-ass.net>
Subject: Re: [PATCH v3] perf: Fix use-after-free when perf mmap() revival races with the last munmap()
References: 
Date: Mon, 31 Aug 2026 23:13:52 +0800
X-Lms-Return-Path: <lba+26a959a57+5003b1+vger.kernel.org+yilinzhang@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260831151352.1401624-1-yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Mon, 31 Aug 2026 23:14:30 +0800
X-Mailer: git-send-email 2.34.1
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>

Sorry for just posting v3 instead of replying to you here first. It
is your ordering, with one refinement.

In your version the lockless refcount_dec(&rb->mmap_count) can be
the one to drop it to 0: dec_not_one() drops event->mmap_count
without the mutex, so a second closer can zero the event count in
between.

That warns, and detach_rest is never set, so the last mapping skips
the detach from redirecting events. On 8 vCPU QEMU it hits within a
minute:

	refcount_t: decrement hit 0; leaking memory.
	RIP: perf_mmap_close+0x221  (refcount_warn_saturate(REFCOUNT_DEC_LEAK))

The rb drop itself now gates the teardown: rb->mmap_count == 0
implies every event is detached already.

> Also, you seem to have lost the 'helpful' comments that I drafted :-(

Sorry for dropping your comments and the Suggested-by tag. v4 restores
both and follows shortly.
