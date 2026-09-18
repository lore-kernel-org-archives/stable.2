Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589D215075;
	Fri, 18 Sep 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690106; cv=none; b=b8lvCMu/JCLf/8JOKt+Rb+D/NsUx7nt9th7FAM7jqKMeNj8E0fteHTKwU+uqn2epBg3BP6Zh+ZsoLN8QgOAyWpiSFht/wKXjCpX9pQe0uzAysk6+YuXdBUEq5gVmdfjFyn63+t2FnoaG0Sf6u3zKfRGo2XUmhsdDUnmDWbE849E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690106; c=relaxed/simple;
	bh=bRpVdYQx6iYLeWrHXp9Ny4rnmAQ1K+WqtwYWne90iGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goJyEwq+JyPDXxkLLurKCpI+0OHzEucMLDtJIgBNqM0mOgLtkZsReuLvq5Tk/ZeJBkRJv7DZ0sfcwM4Qc5fCaKrtbQXyY5iLAYsHTGtNYJLyCYhq80NxTtzsJFem6U2IrhLP8ZYlDVTLr/G/eQOHYGwQ8Qp+AVOk1v2+/ac4aTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IRnmqpPw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IRnmqpPw"
Received: from [172.27.3.124] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 68I07oYR3566522
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 17 Sep 2026 17:07:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 68I07oYR3566522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1789690072;
	bh=6kBTD2Ow5ari7NgIizG1exdB4ovI+H1dTdCVAKQkXnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IRnmqpPwCOdvZf1J5qa6ajyPYLbgNept9V+/ToOvjJOu/8RtZ898S1hldNTP0p4Za
	 do9xN2Umq3TnPBvqNJFIBk/qQ9AjTvzvglJiL7W83y4dqko6/R5oB1Zu8kayXJ9oB/
	 uVoeSZGc6W5dmYQBKBVaKYkQrYML6Uh1kEkV+jhNRgQkxtCNzo+zoKsg1K6jtMUf/l
	 yJhkO0dQAZMmL3EWuKXPJpp1SvaFThBLURg1lR3HyAzzazdZltUK6iwWVLeTXCUhoi
	 +br4AUf/FM91fMhvgV86jU6f1FKTvIXPwVtfG/Jz7+nqIKJhk+IGVuTEXdV7BxI7JW
	 2W/yzuioxXkOw==
Message-ID: <6141901e-b7a2-4b8e-bf77-eca4a40644e7@zytor.com>
Date: Thu, 17 Sep 2026 17:07:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/fred: Reconstruct the #GP context for rejected
 INT instructions
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Xin Li <xin@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paul Gofman <pgofman@codeweavers.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
References: <20260917230907.2080792-1-matthew.schwartz@linux.dev>
 <20260917230907.2080792-2-matthew.schwartz@linux.dev>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260917230907.2080792-2-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-09-17 16:09, Matthew Schwartz wrote:
> FRED event delivery does not use the IDT, so the gate DPL check that
> rejects a user INT n falls to software (Intel FRED specification [1],
> section 8.3). fred_intx() rejects the same vectors as IDT delivery, but
> reports a zero error code and the IP after the INT. This breaks the
> signal ABI. Wine uses the error code to recognize INT 0x2d, so the
> changed context turns a handled breakpoint into an access violation in
> Elden Ring.
> 
> Rewind IP using the instruction length in the augmented SS and
> synthesize the IDT selector error code, (vector << 3) | 2. Set RF in the
> saved flags, as the CPU does for a #GP fault. Section 5.2.1 defines the
> saved vector, instruction length and RF state. The supplied length
> handles prefixes without reading user memory. Limit the changes to
> already-rejected software interrupts, preserving the accepted INT3, INT4
> and enabled INT80 paths and hardware exceptions. With IA32 emulation
> disabled, INT 0x80 now reports the same #GP as the DPL 0 gate IDT
> installs there. The rewound IP also stops fixup_iopl_exception() from
> inspecting the byte after the INT.
> 
> Also clear the software event flag. Section 6.2.3 specifies that ERETU
> with this flag and TF set traps before executing any user instruction. A
> tracer that suppresses SIGSEGV and resumes with TF set expects the next
> instruction to run first, as after IRET. The sigreturn path clears the
> same flag for this reason in prevent_single_step_upon_eretu().
> 
> [1] Intel Flexible Return and Event Delivery (FRED) Specification,
> revision 9.0 (346446-009US), sections 5.2.1, 6.2.3 and 8.3.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Reported-by: Paul Gofman <pgofman@codeweavers.com>
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15745
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/16132
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Link: https://cdrdv2.intel.com/v1/dl/getContent/678938 # [1]

Reviewed-by: H. Peter Anvin <hpa@zytor.com>

This really should go into -stable.

	-hpa

