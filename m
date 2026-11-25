Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636999;
	b=OWO9AW42p4iVKPqIug+tAjcPy5i8Nk263HUacC3+SL1efz5TU12BBn0WWBUwT9UorXP2
	 PzpyVg0MZs9flYni5OGS8VAD5RP1Gjq7RSL/BcUEZeHqmcuc8c6it/xE/k2lLbQe60Fzf
	 Rshm4VUxAhBp2D028pSOQuNbwRbfforjIbOrRhlrcnF1s2gv8oFREO5vrRneV7sHjV6bd
	 5uiGWaGOxFKmzLLEHa6mpkrD6rVE9+qt01SzoIal2jVjI69Wqow0kDZMp5CqH5iX0E7l+
	 lik62i5oHa4aEbvXdzeSoz3x20bdHYHpwUI/nNdoTpXN+4ouNy7IQkgOaMZDju9VlEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=A5nggYVq+8giAUpJT5r3lz72dFn0AiuWFrRV6uAF0kA=;
	b=0AUcr0dgxQxBHvwwqEvqzn9163CDp9nG138tgPQb3Ou4y0hYDEW7KVrgkO+F0uozq4bX
	 +3tgnwa4L7cLeNLHXlpf6lvzBpXcFqEJ+W04qvOp7UYXDh6Mf+xsPxiaDGiOmw5QZ3bvy
	 Y3n5XuAMscNV+7neLIm0NeLetQE9XBaK3KolP4ueBJjc04hNcPbnDuBxYsk4gTOcdqYo7
	 ZM48hQgc9JA0YsUKnLU3mZ+2WjDegRajCWKvLGeVa8PklyBNSUI6gNoHKdJldvVLjzPrr
	 8NlJOHqSFVySVvYp7HCTobrzpvJ2tWjp4EcmkBIhgZvJseMOLQT7tOMkAeNT5ePrK4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcYoE0Lp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE31606A31E;
	Wed, 25 Nov 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcYoE0Lp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5621F000C0;
	Wed, 25 Nov 2026 20:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636998;
	bh=A5nggYVq+8giAUpJT5r3lz72dFn0AiuWFrRV6uAF0kA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OcYoE0LpMA0MY8ILZ0Ho+IuI9QGNvJilswpaMoS4wS/KCLSN/ZJu3lKMPrx9Yednv
	 NW2hZsfEr5YHIF44Yv9djyKjZvg5THecugBnDJ9wPEIF8ejjzbIc/FFG8Jpw311Aet
	 4zuZbaK+2FlNA6n5iBzFxYYfiOE8Kpb6P7Iix1XOfjVzJLT3+Ex+2YOOvUv7SUc407
	 3TvwZxKK7SH/YTVD2BgRvrbjwZBwKGKWzLaZage9DVR3SEOcoPN8a5534K5BmO6nHr
	 sXZX8pHoUU9RXVg63EeFKD7r6w3nk/N/zzWOWCK6kVL7NSxEaJTImmBt0b1QVDQYxS
	 PnoRrPk+/LzVQ==
Date: Wed, 25 Nov 2026 13:03:11 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
Message-ID: <20261125200311.GA3625068@ax162>
References: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>
 <20261125094643.GY2668804@noisy.programming.kicks-ass.net>
 <CAKwvOdmyGdn4ES6Ku+Yovd7a5imzmtmYtd7KB=OMCqKpv1X8rg@mail.gmail.com>
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
In-Reply-To: <CAKwvOdmyGdn4ES6Ku+Yovd7a5imzmtmYtd7KB=OMCqKpv1X8rg@mail.gmail.com>

On Wed, Nov 25, 2026 at 11:32:31AM -0800, Nick Desaulniers wrote:
> On Wed, Nov 25, 2026 at 1:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Nov 25, 2026 at 12:23:35AM -0700, Nathan Chancellor wrote:
> > > Clang's warning is ultimately pointing out that jiffies may have two
> > > separate values in this initializer because it is volatile and accessed
> > > twice and the order of these accesses is not specified. This could
> > > result in unexpected or inconsistent behavior depending on the code
> > > author's intent and whether they realized the variable was volatile or
> > > not.
> > >
> > > As two separate accesses is not necessary here, add a local variable to
> > > hold the value of jiffies before the designated initializer so that a
> > > consistent value is used for initializing both members, clearing up the
> > > warning.
> >
> > None of this tells me why we should not just disable that warning and
> > get on with life.

See below, I believe this warning has general value (but maybe not
here).

> (Could also do ugly pragma's around this code;

Comments could obviously be adjusted.

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99878da03bce..729171ccc9b2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1973,6 +1973,9 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
 	sd_flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
 
+	__diag_push();
+	__diag_ignore(clang, all, "-Wunknown-warning-option", "Next warning might be unsupported");
+	__diag_ignore(clang, all, "-Wunsequenced-volatile", "Doesn't matter for jiffies");
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
@@ -2008,6 +2011,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.child			= child,
 		.name			= tl->name,
 	};
+	__diag_pop();
 
 	WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
 		  (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),

> disable it for this entire source file via -Wno-unsequenced-volatile in the Makefile

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index b1f1a367034f..c1b2062d7356 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -30,6 +30,8 @@ ifdef CONFIG_TRACE_BRANCH_PROFILING
 CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
 CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING
 endif
+
+CFLAGS_build_utility.o += $(CONFIG_CC_OPT_WNO_UNSEQUENCED_VOLATILE)
 #
 # Build efficiency:
 #
diff --git a/scripts/Kconfig.toolchain b/scripts/Kconfig.toolchain
index 1d68075f0469..dfd76b05b6bb 100644
--- a/scripts/Kconfig.toolchain
+++ b/scripts/Kconfig.toolchain
@@ -236,6 +236,9 @@ config CC_OPT_WNO_STRINGOP_TRUNCATION
 config CC_OPT_WNO_CONSTANT_LOGICAL_OPERAND
 	def_string "$(cc-option-str,-Wno-constant-logical-operand)"
 
+config CC_OPT_WNO_UNSEQUENCED_VOLATILE
+	def_string "$(cc-option-str,-Wno-unsequenced-volatile)"
+
 config CC_HAS_COUNTED_BY
 	bool
 	# clang needs to be at least 20.1.0 to avoid potential crashes

> and finally this diagnostic was forked into a group; it's now
> -Wunsequenced-volatile under the -Wunsequenced group, that could go in
> W=1).

Moving this to W=1 won't really solve the problem because many people
build with W=1 by default so you'll still get reports and patches trying
to fix it. It either needs to be this patch or one of the ones above.

> I think the warning has value generally across the tree, even if this
> particular single instance "isn't a bug, per se."

Hard agree. Just because this particular instance is not a bug does not
mean future instances won't be. We pay a small cost to silence the
initial instances then we get to see what it flags in the future. If it
turns out there are never bugs, we can just turn the warning off
globally (we've done it before) but I'd rather have hard evidence of
that first; to me, these initial instances don't count. No maintainer
has objected to the other patches I have sent for the other instances of
this warning and there were not all that many for how much code the
kernel has.

-- 
Cheers,
Nathan
