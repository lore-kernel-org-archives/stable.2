Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BED49D59B;
	Fri, 18 Sep 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727603; cv=none; b=qv/iso1WJAVeIgTq2NZHCEKAgkw/GVxbw0UQHglSGnWV6dD4TMinhi36b4MQKHorqbyBLaBjNtaRDFbfwvNxCRexuhdj7QHSgZq9VjMWA+Em+HcnZx+VAba9ow+sGny59c42FAQ0D0gBqlMgcMQupqs4GM2avxBS7iwdhDZtgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727603; c=relaxed/simple;
	bh=Pp8+qYV14aM+8W8YxzWRx95w9FPTwKpIBNo9Up4J1BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgJXDdfOX275Zi4O9QHJuiYg8A++iJwYK18wfNvL9kOv/F+Jx8w11UE2SEsQ1YTo2Go4AZHLN27or0vNObAlNjvtVXf+tN/JS7UZP/8J5Cp6N4K/kNBDWiLHCdd/zXQy5uN6Et9FfY3T2xlMO7Hqg8VdEiFlLZqSwwsLC8FzQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnSOAEVN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnSOAEVN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hg7QkNef5zMThE+MRw8udQqkGZAjpML9pXHh4uxv5K8=; b=UnSOAEVNKYj/W3EgeF6N+/mXS/
	sTndR9zyc6HFJY+aOzLsorEmd/dUtVp4iaVerhqfpAZGewFUgvV8FCOelcRLyw+Ti8HHUYO0RLTTC
	okWxf1cF972zBGB/x97EtpSA0w7JdHX4omJjiJcsyIDfSneZdPSJ/T7lUQSPauWJ829E/mo3slvh7
	AVvOf2gGlp4/8L8VXyimdliN3zf++rvpabQJTiBop+lIfaEQ6b9qIWJcThLgfalyCyiMAgKRJzv96
	Uh7ZkU29r22Efp9HmRKN3orQ+m4Ov1hR85gsH6hSTuXqDUKvKP5TUc/3VeAuil+j6tj42heWdIAGL
	1wv4mqfQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7Vtx-00000009w0D-3SuZ;
	Fri, 18 Sep 2026 10:33:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 377FB30057F; Fri, 18 Sep 2026 12:33:04 +0200 (CEST)
Date: Fri, 18 Sep 2026 12:33:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Paul Gofman <pgofman@codeweavers.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/fred: Reconstruct the #GP context for rejected
 INT instructions
Message-ID: <20260918103304.GK776954@noisy.programming.kicks-ass.net>
References: <20260917230907.2080792-1-matthew.schwartz@linux.dev>
 <20260917230907.2080792-2-matthew.schwartz@linux.dev>
 <6141901e-b7a2-4b8e-bf77-eca4a40644e7@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6141901e-b7a2-4b8e-bf77-eca4a40644e7@zytor.com>

On Thu, Sep 17, 2026 at 05:07:45PM -0700, H. Peter Anvin wrote:
> On 2026-09-17 16:09, Matthew Schwartz wrote:
> > FRED event delivery does not use the IDT, so the gate DPL check that
> > rejects a user INT n falls to software (Intel FRED specification [1],
> > section 8.3). fred_intx() rejects the same vectors as IDT delivery, but
> > reports a zero error code and the IP after the INT. This breaks the
> > signal ABI. Wine uses the error code to recognize INT 0x2d, so the
> > changed context turns a handled breakpoint into an access violation in
> > Elden Ring.
> > 
> > Rewind IP using the instruction length in the augmented SS and
> > synthesize the IDT selector error code, (vector << 3) | 2. Set RF in the
> > saved flags, as the CPU does for a #GP fault. Section 5.2.1 defines the
> > saved vector, instruction length and RF state. The supplied length
> > handles prefixes without reading user memory. Limit the changes to
> > already-rejected software interrupts, preserving the accepted INT3, INT4
> > and enabled INT80 paths and hardware exceptions. With IA32 emulation
> > disabled, INT 0x80 now reports the same #GP as the DPL 0 gate IDT
> > installs there. The rewound IP also stops fixup_iopl_exception() from
> > inspecting the byte after the INT.
> > 
> > Also clear the software event flag. Section 6.2.3 specifies that ERETU
> > with this flag and TF set traps before executing any user instruction. A
> > tracer that suppresses SIGSEGV and resumes with TF set expects the next
> > instruction to run first, as after IRET. The sigreturn path clears the
> > same flag for this reason in prevent_single_step_upon_eretu().
> > 
> > [1] Intel Flexible Return and Event Delivery (FRED) Specification,
> > revision 9.0 (346446-009US), sections 5.2.1, 6.2.3 and 8.3.
> > 
> > Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> > Reported-by: Paul Gofman <pgofman@codeweavers.com>
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15745
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16132
> > Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/678938 # [1]
> 
> Reviewed-by: H. Peter Anvin <hpa@zytor.com>
> 
> This really should go into -stable.

It has a Fixes tag, afaik they really good at picking those up. Let me
go queue them in x86/urgent.
