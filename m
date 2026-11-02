Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793640768;
	b=XGj2FMXqRVSQ0FMD6KVubVlq1MOkdG5GQAXJeeEwGJcc679Ail98vrVnB1HWfb9upefp
	 m+Htp6bbgDOLW9mCU2aUjd0w6YNgOesrLgrV1E0meTgi8jF2YWkotfvFi+CnRsUGf7DRV
	 gprYpgQuA/DU1scPyLlZOS0tztnoAPa63lbvGNnHNey5eNnztQU/VMrTCQ8rXCQdg3fTU
	 XPQH82YgWEr4U5Z7uufS2LcBTbKBhrDFDA9oauhb3eHpyfNK5eRX05gSXab1XnKgFsA7z
	 MseSZhQZ1FNXHaKuKXclCjAlk1PFD3FTax3bnUWdA9Qj8Xg7ewGsuwn60NtHwa4OBKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
	b=VhGFkEjPyEt8Ov+vMEAI1Q16F06HczEIaNVp+gDV5tmGn7VKV/+83FHLqnI/adzPUMLQ
	 YVOorumWPCSUOnzhoKHjfE1SjYD5ljjQYMemCBWboXyS4GKHXBaaZKQYAXLsmJvLZUAvX
	 SEU3VVoI5xiRkQJbh8ijmKcufsDVawRXVO2qkWVPYdHA6Zw8ScziKuGpmXFBWnD+kzWja
	 eOkj+TaPXhYcs3jYaH9rtXXpFtw5yOAiGNDZMyg5rtTIsCJMbnq7kZo2OZSd/SEICCtuo
	 j2y1KC+Y94RKGfwE/I+FPvh0sIXs4EzojkoTGGfVxShT0UtVfVEPKc+1GM2bAYKWUXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9u6NCxj;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA6606E02D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DBA6606E02D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9u6NCxj
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so2747891a91.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793640767; x=1794245567; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
        b=U9u6NCxjVhkQwuGcWx66GAOCDWPiOPNc0aRhBiHc6EdbEc0Wd0uvKTupJIGhp41tRt
         jdvKM8tqp2sTK7mylRgtAYxWR4iGLC9RS9/zFsUU7L6b3ZPr4Wl+7DG3P/KziQYvM+Yj
         x2NWnUpMMIW44ep+gzdRlBZUjE4DJNiACdZxMM+jqKdTLzYC/VEWW+6Q+3KWc/+mF6q9
         A0xr04gIiSd2s4IPtnLolaEb9YGHxe6Cziu67tyl1qFyItm3n4JXU1OG2mjAv+VPgst/
         X6Ki18eBlFIP41C6JFzBogJ1VxsK+RmPrySxVDe0gXmlO7u1oJufLiYzogOoVBzFk2XM
         F3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640767; x=1794245567;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IkAPkFLbTRtEJ98IuWKTdP6Q3cksIi32J1uYLTtOYaQ=;
        b=b+1CTH8Wt2USXq8hZqYSm0Ncbb8OJ/yDxzlMopNAT9grSsaHMGPHgRxrGrKTt+8kAh
         8QkSdtxfP0NCUu9ykBDqqjDUx9BEVm/Wf6eqHBQULRN5KzMrX9B0txAKmtKWS+qUYuOO
         xPbbqdMGbdS1W8wXf2U9aHtlWxSRHPAtaoqbj1W6eeTlpIvlKq7jQ6+WjfacmBTFQu1k
         DJMpT326ok0Na9aAFxzCzEcy7tb3kFkcECR6ga/lHYKQoA+oyzLIRCgSNK7yBoXUmAZ7
         RC2rXF2dNyLhoHczPNvYklxjBuvLK7FXRlJ+OtAcxLhusuPWdLMD6PEKwhLlFwCWIC/R
         sNKg==
X-Gm-Message-State: APuU4Z9r1ON04wsZgNDxH0FJECGRVKciQv8crbwL1U3ulDRJJn+4/tUX
	KQgoM4FNBBTBakcvHUSb3J8e1xSFvMZbWk2jYQMGXy3r8SBzcVqBJY4K5I8uxEcEb2TUySjPafz
	eFRsdzA==
X-Received: from pjbir4.prod.google.com ([2002:a17:90b:4684:b0:3a8:74c5:5a5c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8a:b0:39e:6c69:7777
 with SMTP id 98e67ed59e1d1-3ae8976c86fmr8030769a91.32.1793640766778; Mon, 02
 Nov 2026 09:32:46 -0800 (PST)
Date: Mon, 2 Nov 2026 09:32:46 -0800
In-Reply-To: <20261030103643.573356-4-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030103643.573356-1-doebel@amazon.de> <20261030103643.573356-4-doebel@amazon.de>
Message-ID: <aujJPohZEMZMdWFW@google.com>
Subject: Re: [PATCH 6.18.y 3/3] KVM: VMX: Synthesize nested EPT violation
 GVA_IS_VALID/GVA_TRANSLATED bits
From: Sean Christopherson <seanjc@google.com>
To: Bjoern Doebel <doebel@amazon.de>
Cc: stable@vger.kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 30, 2026, Bjoern Doebel wrote:
> From: Kevin Cheng <chengkev@google.com>
> 
> [ Upstream commit 96b067b59ad9ccede585fcadab27543188353bff ]
> 
> When injecting an EPT Violation into L2 in response to a fault detected
> while emulating an L2 GVA access, synthesize the GVA_IS_VALID and
> GVA_TRANSLATED bits using information provided by the walker, instead of
> pulling the bits from vmcs02.EXIT_QUALIFICATION.  The information in
> vmcs02.EXIT_QUALIFICATION is valid/correct if and only if the fault being
> injected into L1 is the direct result of an EPT Violation VM-Exit from L2.
> 
> E.g. if KVM is emulating an I/O instruction and the memory operand's
> translation through L1's EPT fails, using vmcs02.EXIT_QUALIFICATION is
> wrong as the semantics for EXIT_QUALIFICATION would be for an I/O exit,
> not an EPT Violation exit.
> 
> Opportunistically clean up the formatting for creating the mask of bits
> to pull from vmcs02.EXIT_QUALIFICATION.
> 
> Signed-off-by: Kevin Cheng <chengkev@google.com>
> [sean: use plumbed in @access bits, massage changelog]
> Link: https://patch.msgid.link/20260522232701.3671446-5-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [doebel: no advanced EPT vmexit info here, so the mask keeps only the two
> GVA bits; set GVA_TRANSLATED via !(access & PFERR_GUEST_PAGE_MASK)]

...

> @@ -509,6 +509,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		if (fetch_fault)
>  			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
>  
> +		/*
> +		 * KVM doesn't emulate features that access GPAs directly, e.g.
> +		 * Intel Processor Trace.  Assume the GVA is always valid; when
> +		 * propagating faults from hardware, KVM will discard this info
> +		 * and use the EXIT_QUALIFICATION bits from the VMCS.
> +		 */
> +		walker->fault.exit_qualification |= EPT_VIOLATION_GVA_IS_VALID;
> +
> +		/*
> +		 * Accesses to guest paging structures are not the translation of
> +		 * a guest linear address, i.e. GVA_TRANSLATED must be left clear.
> +		 */
> +		if (!(access & PFERR_GUEST_PAGE_MASK))
> +			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;

Yeesh, I was going to say I'd prefer to keep the original:

		/*
		 * Accesses to guest paging structures are either "reads" or
		 * "read+write" accesses, so consider them the latter if write_fault
		 * is true.
		 */
		if (access & PFERR_GUEST_PAGE_MASK)
			walker->fault.exit_qualification |= EPT_VIOLATION_ACC_READ;
		else
			walker->fault.exit_qualification |= EPT_VIOLATION_GVA_TRANSLATED;

but I don't really want to decipher whether or not that's needed and/or correct
without upstream commit a8827c1961462 ("KVM: x86/mmu: introduce ACC_READ_MASK").
So yeah, this seems like the way to go.
