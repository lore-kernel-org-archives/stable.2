Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C333E168C;
	Mon, 31 Aug 2026 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177137; cv=none; b=I3OZK4bi/fDCk5zc0Z8iFQn8Q423iUbEj59BP0aUZWrjYZPr9VLgJzcxoNDOpC6ktbV3ycnUxXdKnPVDIP3OLJ7PaoCxerpapMMzDyGW/87sGGZ5Lk+VrsWtwADAYlQxeZZq1qxtRSOFUdN5iluciwt3Z/8NG3m0JOAHzZES/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177137; c=relaxed/simple;
	bh=71qqC2Mhno3qkJqICbv36R/oGqOhMVsrid5usbAcB/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZePIEidPqk8qUYiZZEB6EmQhs8cwFVuOhEx2S1kwEmQgbTMG14eZIGUiXhDoBk/2l/hVfyM+yYULUUb+Wl/ofxh2cN12MTilLZA6IM1paunGr4nJXCGz/6XUTUhOj3khkX9nsgemG+DysohkvfkM5t4O5lDdffF0F+zA+IimiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BczrIMIS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BczrIMIS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C6pg2Tt4huKP1NoSl24rKpsZJa8LxH2Q2ZCkBPqYpFA=; b=BczrIMISR8K4SCrEwUy1k6Dlcu
	dp+3ksdsMYg+j43sHOtqiZRKNpCJzIRwsEhB8HINnwz2bYMNKuKBbqCpLFgCEyELrz/XM0j1x09sn
	3gE74qjMvYxYGRvMR9Dxs0b1yCeAqGRFaibmIHLVO699kvRPhrPKoK+HVUu+EegjISE3xKMeMk8rE
	6zFTJ7OzH/BUUMZlcavGd9Eb7MUtOQCipbglhohIpYXHrjZ0owPukdgU+iYsSe8IAOZjwOnWGh6bU
	eEx4rA1rVqR+BroIOZriHE2VBL5Ba0EqUz050tBQGNJ8eXOE2RdjRCy1xnWBA5ixx6ksvbw3nhhtH
	+RrSjWsQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x10YW-00000009pOp-46j0;
	Mon, 31 Aug 2026 11:52:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EABB0300E7E; Mon, 31 Aug 2026 13:52:03 +0200 (CEST)
Date: Mon, 31 Aug 2026 13:52:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	xin@zytor.com, luto@kernel.org, jpoimboe@kernel.org,
	rostedt@goodmis.org, akpm@linux-foundation.org,
	rdunlap@infradead.org, elver@google.com, andreyknvl@gmail.com,
	glider@google.com, gor@linux.ibm.com, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event
 stacks
Message-ID: <20260831115203.GE1837346@noisy.programming.kicks-ass.net>
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
 <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
 <20260829094207.GD776954@noisy.programming.kicks-ass.net>
 <20260831085912.2485095-1-xiangzao@linux.alibaba.com>
 <20260831090124.GH4120091@noisy.programming.kicks-ass.net>
 <20260831112536.2803657-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831112536.2803657-1-xiangzao@linux.alibaba.com>

On Mon, Aug 31, 2026 at 07:25:24PM +0800, Yuanhe Shu wrote:
> On Mon, Aug 31, 2026 at 11:01:24AM +0200, Peter Zijlstra wrote:
> > I would still argue the function name is incorrect, and the user might
> > want a comment explaining this.
> 
> You are right, and it predates FRED: the ranges in_irqentry_text() tests
> have always covered the asm_exc_* stubs, so it has never been literally
> irq-only either.  The hook inherited the wording because I named it after
> the helper it extends, the way arch_nmi_enter() is named after
> nmi_enter().
> 
> v2 renames both: in_event_entry_text() and arch_in_event_entry_text().
> The helper is file local with a single caller, so the rename stays inside
> kernel/stacktrace.c; filter_irq_stacks() keeps its name since it is
> exported and used treewide.  Both the generic definition and the x86 hook
> now carry a comment saying the range is where a trace entered the kernel
> and covers syscall entry on some architectures; the x86 one also spells
> out why matching it is a no-op for filter_irq_stacks().
> 
> If you would rather have a different name, say so and I will respin.

That seems fine, thank you!
