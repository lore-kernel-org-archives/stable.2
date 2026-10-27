Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118744;
	b=wINac0cDxNkhA7ty9TbgisYHwoTMv94X/srzh7+GaHDwjaSLKJTkMWHkJaqmskOv0Nap
	 FyC5FWDrFlaJSpxwupbTKAujBDOFG+yaQOFTcNxY1AgE/i+UF/Sgscs3QY+2NFsSbNEEZ
	 d3yxIHShmylSZvh7BXyoRdg0m/kj/y87e1T6JsFAzVmVmr/EOZ2z4ONLqH1ZmCSgRsoqU
	 N3xYQmk34o0vR4Nz0r9pJiexmRTw9NiBfFG6PGhATmE+HXjRUAkyw9vrG7p/+Mr8H7O5a
	 2KIlxCYTtgybPCcUQcv5L7jMED6mQ+wyyr3aET/sCjwjM/cdVJIvzRLmCJ+dN5LNLfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118744;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=xevTPSb+55+TJBzOTJHueBHMyIEJniQWSfJqf76NMG4=;
	b=MquCWkMvr7E+mtZiE3PSDrLPPEQh0/lpEtrOHz0cNL+NPxM4VVAzF20BbwhfeiTPrIqw
	 8hhcLJim3OB1gaGevpIiXxCpd2eU2Mo8VwBmSypuLspHSLeJQ9eHoX6ZLIPQk23c37xke
	 a4vE/yrsOWMtecE4wrREKaahVYD+Gt/nlZ5gSlP1mNilEAfZ5zJ5vIxwyc0xcF5A3u6LD
	 zC3kENOIn2a7xTVxjkvGzcS/mwHm1CKN3Y4ubm+95xkDpwQfbm40jympwUiJzSgU+T12d
	 vS0KzgP1kBwglUazumjrZn6BYAexQAxywQEVDDB17+bjfHtyZm3xNPHsMoDeHoZ16UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BZn5onzX;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856FD606A31B;
	Tue, 27 Oct 2026 16:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856FD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BZn5onzX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xevTPSb+55+TJBzOTJHueBHMyIEJniQWSfJqf76NMG4=; b=BZn5onzXLCfaNBkHRKJ6z3d437
	cx9NUbBkHVcpT6A8fnwOLNoryUOBd7slA5WGRwr63H3b/M4dVw9L8nkKdyDG7Nk5M2HekRD6Te5vj
	GwQMggMVJ4AjvVDt3RvMaZ1nMc88gZBPC4QPgZtgy0oJF0iynyeN71snkVtAE9sJXDjDMvV2O8XOq
	+ljiibzQBNl4wkufeXLLhqAJA32UCw+9RjJaT/wOaAriPBYYtETbDLq719Q+wXtZoEnHJs29M+1vw
	rGIKnUjsYFvXRqE2K0+mMoeWEMKJiqK5ryU4HadLg7K+61kZpIV/6d8sCjTwtzjI4wK7xmb8lWI9o
	JWd7BLwQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLk5z-0000000FESw-313w;
	Tue, 27 Oct 2026 16:32:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3FA03014C0; Tue, 27 Oct 2026 17:32:18 +0100 (CET)
Date: Tue, 27 Oct 2026 17:32:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-team@meta.com, stable@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] x86/nmi: Ignore negative NMI handler durations
Message-ID: <20261027163218.GC1779021@noisy.programming.kicks-ass.net>
References: <20261027-nmi_negative-v1-1-b436a005eb8a@debian.org>
 <6455a4e9218729d68f73006ef532e6fccc0135cf.camel@surriel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6455a4e9218729d68f73006ef532e6fccc0135cf.camel@surriel.com>

On Tue, Oct 27, 2026 at 12:25:20PM -0400, Rik van Riel wrote:
> On Tue, 2026-10-27 at 03:43 -0700, Breno Leitao wrote:
> > I am seeing NMI handlers in the Meta fleet reported as running for
> > about 584 years. Over 30 days, 11 AMD and Intel machines logged 637
> > such lines, for example:
> > 
> >   AMD EPYC 9D25 (family 0x1a, model 0x11, stepping 0x0):
> >   [ 1650.616627] INFO: NMI handler
> > (nmi_cpu_backtrace_handler.llvm.9643156322683129580) took too long to
> > run: 18446744073709.551 msecs
> > 
> >   Intel Xeon Platinum 8321HC (family 0x6, model 0x55, stepping 0xb):
> >   [360448.230129] INFO: NMI handler (perf_event_nmi_handler) took too
> > long to run: 18446744071018.936 msecs
> > 
> >   Intel Xeon D-2191A (family 0x6, model 0x55, stepping 0x4):
> >   [81787.188959] INFO: NMI handler (ghes_notify_nmi) took too long to
> > run: 18446744073709.545 msecs
> > 
> > nmi_handle() times each handler with two sched_clock() reads. When
> > the
> > second read is lower than the first, the u64 subtraction wraps, and
> > nmi_check_duration() treats the result as a duration. In the three
> > examples, the clock went back by less than 1 us, by 2.7 s and by
> > about
> > 6 us.
> > 
> The comment above ktime_get_mono_fast_ns() makes
> me wonder whether for time deltas we should read
> raw TSC values, and calculate the time delta between
> them afterward.
> 

This is sched_clock(); that *never* changes slope -- after boot, on sane
hardware.
