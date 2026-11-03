Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720979;
	b=T8Q0Me0I1zKaZBDd6561aWP9PaXb8t58QCTMnJV4s6Ewo3n/g9ZVl6+fwQKEVHseROp7
	 4dGIXcc4tCT2I5fSLPajv/GTp/z/n4l7gHrhrL9YRCnPv1zJywoaqMpO8sDvE05JqN63M
	 cULhkf5Zu1lbXn7+uVJJ8wZkWSoRlUvbTXp4ZSrpZMAFcld1LUYQ0myIoLNQmGkmzymnV
	 GVEjqTAA1wabQz2l/UHw3nGN4OO0hY8rf2roSbweIR21H5+MCvs9Tu/cQJJ5uQnJdBedY
	 9DK9AepkNT/hS97f00u61c9RvF0SYz/YYg2m89zZcgGowRshyORs5u2fS8ey+ZXDEmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720979;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6P0PHr+n9Ve3fxg8VsvgwFjBRTqtcr54xk6mXcgcgeU=;
	b=Nx7bSymlkfqJasqTWyP+SzE6usJC0mBXV9SuHr9yOEwr5Fg7WGQTlmRqpjAn/HjbfHzt
	 /Z7XQDt//K/i/RryGSb6TeymIdHGTlYiBnfEO+Y4+r0JTQBmPOMsGIZIM0ITCyyAz8Dpc
	 KKRP9XB6Uu7KJmlDuxbjI1C1EFYJCz8QRHx2pcDkqowR/NdleBJ0v95bNWJs3fBkbFaX2
	 UDGykdIbEdin607NYDrivPU4uEHP17JZ48nmgX7y2nLIWKoWFm+CYpR/sLtrOuLZCtJq1
	 2rDZDqOz7OM6ZSszdqMrMHRd3z3tMxO09n14SqksEdfSc8uYdS4p1s0jFsz/WOtlKoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="M/7yHUfQ";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39F8606A338;
	Tue,  3 Nov 2026 15:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D39F8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=M/7yHUfQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32C9F1595;
	Tue,  3 Nov 2026 07:49:35 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03B563F673;
	Tue,  3 Nov 2026 07:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793720978; bh=BID+rQWcre0pu+Hc8/Ybye16P1LYmsxhx3QBHIdrvHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/7yHUfQ91gZ+q5qgdzem+UFmbdEMxBYyz+CL9oOvdC8qU9gEx1QByMs0dBh+bV/c
	 zNfL2nWco0s5rbt1FNC0ZHZmFsRdKEgL5t9QFmJHt83yp55KIPjWcZ8E56qPdA0qmM
	 H+Xuz2havdng9mdabhglVmV5KYNVjHwcLv4/cOug=
Date: Tue, 3 Nov 2026 15:49:34 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Wei Wang <wvw@google.com>, Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	wei.vince.wang@gmail.com
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU
 suspend
Message-ID: <auoCjmMnzRE8c1cN@arm.com>
References: <20261102234813.1069156-1-wvw@google.com>
 <aunKa8uBZJTCzVjd@willie-the-truck>
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
In-Reply-To: <aunKa8uBZJTCzVjd@willie-the-truck>

On Tue, Nov 03, 2026 at 11:50:03AM +0000, Will Deacon wrote:
> On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
> > On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
> > the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
> > context-switches it eagerly in tls_thread_switch(). While a task is
> > running, the live register is the only copy of its value.

[...]

> There's a lot of unnecessary (AI-generated?) detail in here. Please can
> you trim this down a bit? I don't think we care about the firmware part,
> the stuff about idle or the bionic crash. The bottom line is that we're
> not saving/restoring a live EL0 register across suspend/resume.

I should get an LLM to trim it down when applying ;).

> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 7afbece885a3..c7b7fa6491c3 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
> >  alternative_if ARM64_HAS_TCR2
> >  	mrs	x2, REG_TCR2_EL1
> >  	str	x2, [x0, #104]
> > +alternative_else_nop_endif
> > +alternative_if ARM64_SME
> > +	mrs_s	x2, SYS_TPIDR2_EL0
> > +	str	x2, [x0, #112]
> >  alternative_else_nop_endif
> >  	ret
> >  SYM_FUNC_END(cpu_do_suspend)
> > @@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
> >  	ldr	x2, [x0, #104]
> >  	msr	REG_TCR2_EL1, x2
> >  alternative_else_nop_endif
> > +alternative_if ARM64_SME
> > +	ldr	x2, [x0, #112]
> > +	msr_s	SYS_TPIDR2_EL0, x2
> > +alternative_else_nop_endif
> 
> nit: We use msr and REG_* for TCR2, so it would be more consistent to do
> the same for TPIDR2_EL0 if the assembler is happy with it.

TPIDR2 is not defined in arch/arm64/tools/sysreg yet (for some reason,
only TPIDR_EL1 is). Since this is a cc stable, I think we can leave it
as is and do a TPIDR* cleanup going forward.

-- 
Catalin
