Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995253;
	b=Hq+/MYJ/3cP25DMBhIPUYwq7J5fsFL0vhlOaisXcjsqxEVqdtlQsLWemaWcdeZRN3MqA
	 3MNhhoWbXLsYU6k3VuryCRrMYko6w9ZBUHRsLmh0mh6S30I7qO1yg5W1sNrE63zTQR58y
	 sPMekOStabHX/JBEizPGUIqap7l7R56X2xq1QE35d+XrmAJjDwnLFt56OW+yVHCoZVDvz
	 qrH4hegDJMN20jEkjvv7yHEyfl7tFRJz2dW6yXL6hN0/x43bgpWh4igpo11NOx2TbP5xm
	 UExaaxvRLyh38I8gNB13osM+ZJukJffzdwN3dziv4Fpe244WYPj4AGj8Cda6Mdn2whQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995253;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=XLt3LNagC3p3W1cQVzPcPQlpUU8JjJOhvQQAMn7LWL0=;
	b=w9razx2XufB2PNQjBoRy8j1dWeM9BvPKNBxFuuMLJQqn1ZF2xTDk/5KDwOZgI8h2dSzb
	 OwTWd7bK/FKpqynrCmKGL+Nsmny2tNJxftap0pKOhxiYj0gNtMvExj+kD8EoocrhY556H
	 jWGwy06TQ0KXq9J7OV2QELhNHGg4yqb2h7LDs6VhO1WIXPKWJQi+8Vvzy6DL2T5mRvr6X
	 584i7xBd9eZs9aLvyfp45easl4VjIbbwWFySXoKPwffNwLt5lLaIDNH05svfJiSNsdcKG
	 DeHYUCuMH+bwhRonvmaXFc28PBL7ei6tQhN5KegEUofRAOQo5+XrBSY0vab+zIlp6Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jU2lFV2S;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15617606A31C;
	Wed, 18 Nov 2026 09:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15617606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jU2lFV2S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=XLt3LNagC3p3W1cQVzPcPQlpUU8JjJOhvQQAMn7LWL0=; b=jU2lFV2S+o7g2QF1SeTqfT7QMA
	W+1H37jOi0sd+4guZE/2eKqnmkF6yjD2VUUHdD3zw3SSCct4MoH89Dspp5tZbeDKTlLOd4+JVXVHO
	TFlHRq7SzXMpbNOFEMpj5nQUZN9Vs3R2Tf1jdrSAnosYnUGNs/LR1hNVBTuSWD5rJpXkppO1X+Jky
	OCve/jxF/itYuaFjrueijIjyPIJAkHxCb54IlSIgn7a7dbC09pCoDbnLJztbOcyL8lx7DYh6hDPXF
	2cX3gPrh/yfpI5h29WAIRoJkYw3lIigoEHu8JVI757Ila/Lk6xSNx+cMBTskDZ2tuuhFkA3wUKL/f
	lKotaS4Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTcGF-0000000Bwcy-25c3;
	Wed, 18 Nov 2026 09:47:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6D3CF3004C9; Wed, 18 Nov 2026 10:47:26 +0100 (CET)
Date: Wed, 18 Nov 2026 10:47:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261118094726.GM1813469@noisy.programming.kicks-ass.net>
References: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
 <20261117183043.GK1813469@noisy.programming.kicks-ass.net>
 <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=9pjhCnreMvoAH_0PegYg60ouaZL=BAjB242bE48J23g@mail.gmail.com>

On Tue, Nov 17, 2026 at 10:39:15AM -0800, Nick Desaulniers wrote:
> On Tue, Nov 17, 2026 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > I don't speak enough C legal to actually understand the Changelog, but
> > the actual change seems daft. Is this really needed?
> 
> I would imagine a delta of the disassembly here before/after the
> change would make it more obvious (one less volatile access, which be
> have arbitrary ordering between initializing other members).

Could it be fixed by adding an explicit cast? Say:

	.last_balance = (unsigned long)jiffies,

> But I guess I'm also curious why jiffies is defined as volatile
> anyway? I thought the usual guidance was to use
> cast-to-volatile-qualified pointer during access, rather than declare
> as volatile?

jiffies is ancient; it stems from before we had READ_ONCE() and friends.
It used to be that task_struct::state was also declared volatile, but
I've since fixed that.

Mostly, you want to always read time, and not have time optimized
'away'. Like lift a jiffies read out of a loop and break the timeout
condition and all that.

Also, the C people are daft and want to get rid of volatile,
irrespective of its many uses, so perhaps this is a subtle act of
sabotage or something and we should get clang to revert this weirdness.

I think the thinking was that with _Atomic there is no further need of
volatile and its fine to break the many billions of lines of
pre-existing C code or something stupid like that :/

