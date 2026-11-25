Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600011;
	b=JpBX6EgmL/zXBigkOZVLMq6qMn834/aDdMMvFkPJ1vqYxjHX4inR929e/u0g/SX+lPWo
	 8NeMguaI5XqB6qv0uQwq2hgYn61zxnJRW/wBrm2kIlqU8Vx6TiW1JhG5jP0oMreUSxxnl
	 Av4RkzWnNlcVJGnX+tJd26WKhpWnWwazvhhZjF0V8NAd40xafr4Q4PRtO2xQLpx+pfZEy
	 8R96JjG45rvb7iX/PaXuxzSb1mw4M+O2pdf3PRI2EUaYR4owbV90P5eIyiHrNOR2eQCs+
	 eTDiAh15uqnhkC8wAI7gUpKb9R4qrfneESdbjOYSbD77vXKU1HLexNONS4vNrczCvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600011;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=8sTc2bCjctzlaRsbys2WSDh+IM60pvW2yIGOU2jAXq0=;
	b=TSsLHR9F49Iki8S+ZBRR3acYSMX2Y75GNL+rDXK+lnkeL1ZoR5Fq3B4+f6js9iNzje1M
	 +t09zAu7D1y45iewNd09VOeMqoCLpZzkiLQAsoNBSTTZk0r46c+bA7bD4jfmBI6tV366L
	 g/M2bxj2io3HPGdAWQj580RQ6e1+mRJnU/2BV5tMYr5aa2NV4fxzX8hLhpT+Fa9kUuVzj
	 dC+TCAKlqCXK9gPLj4Zr1w3dhjhj7XzbiAn7XI6z49UE6G2OjkLask8AER/rfPI52SZKN
	 smZEoRMvqEjDE2ClkoKuH6aTzHRAKwK/h9C+oN+Fiydv9zdxHAbP4GEvwNmpJgE/jPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LVJHJRJD;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD94606A337;
	Wed, 25 Nov 2026 09:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCD94606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LVJHJRJD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8sTc2bCjctzlaRsbys2WSDh+IM60pvW2yIGOU2jAXq0=; b=LVJHJRJDGjJaw8cvgz0hSzdYba
	k8XwHqFV9Q/pHOVyFLJTWjUit2DxPbr1VDps7/EtA2FqOGGkPEaPRsBI7GfiQmn0cFj8jLDlsDpAH
	1qPVqpPyLeAaQ2ttIFNqjiYu41DFnKwJZRmoeckouK/CjTX44j+pRvaxrNBHHY6olIhnDCWexjo8X
	IdNpyinCjTfncIOliFucyuV9WF6yNwVGwNE0qpeOi26s2sPYve1GiElj+XOyx0XCcEpihFpz8HTcT
	PoIhP8ePVTi8ownYMkKw5fiJx+jRwNHbE0iHX9GauYM74Mnf2wMOjq5F7PKSbAYpVIdKL6DOrZbEJ
	14Z1lk4Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9aO-0000000A1BX-2R6t;
	Wed, 25 Nov 2026 09:46:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7A3E9302186; Wed, 25 Nov 2026 10:46:43 +0100 (CET)
Date: Wed, 25 Nov 2026 10:46:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
References: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>

On Wed, Nov 25, 2026 at 12:23:35AM -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in sd_init(), which can
> break the build with CONFIG_WERROR=y / W=e:
> 
>   In file included from kernel/sched/build_utility.c:86:
>   kernel/sched/topology.c:2008:29: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1998 |                 .last_balance           = jiffies,
>         |                                           ~~~~~~~
>    1999 |                 .balance_interval       = sd_weight,
>    2000 |
>    2001 |                 /* 50% success rate */
>    2002 |                 .newidle_call           = 512,
>    2003 |                 .newidle_success        = 256,
>    2004 |                 .newidle_ratio          = 512,
>    2005 |                 .newidle_stamp          = now,
>    2006 |
>    2007 |                 .max_newidle_lb_cost    = 0,
>    2008 |                 .last_decay_max_lb_cost = jiffies,
>         |                                           ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.7.9.23, the evaluation of the initialization list
> expressions in a designated initializer is indeterminately sequenced
> relative to each other, meaning any side effects in the initialization
> list are unsequenced.
> 
> Clang's warning is ultimately pointing out that jiffies may have two
> separate values in this initializer because it is volatile and accessed
> twice and the order of these accesses is not specified. This could
> result in unexpected or inconsistent behavior depending on the code
> author's intent and whether they realized the variable was volatile or
> not.
> 
> As two separate accesses is not necessary here, add a local variable to
> hold the value of jiffies before the designated initializer so that a
> consistent value is used for initializing both members, clearing up the
> warning.

None of this tells me why we should not just disable that warning and
get on with life.
