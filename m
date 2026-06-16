Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BC93D5250;
	Tue, 16 Jun 2026 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588360; cv=none; b=QtqF+7TPWq/CJqspGCoQN/ge8u0U8P89LcRlRobKzhdDQYb/t85/AJ8r/c30zS4RcuLJUIEY0DAHtiORlRXSIKF7ACCUyO5lG7sXvw5YpKTuB5TssVBRrZ7u96fhiCo76AJY6tmEsLbm8RwOrE1bRLXYmwjUVrLYzk8Ye7x7Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588360; c=relaxed/simple;
	bh=RrnAbk0HxpxtNPih57q6UzOQi/xIk22Mh82f9ozERM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTL2X7lGI0d/ywLq1MaKMcUxe4V2A88/E0P1hjlEPvrP6kT0mNWDekYYLHN1B/LFXI9HueYNJCoyJRXdAgtuGlG3vueNV/OS6aK4xQY6iHhndW+odMlHSVURlltKPg0g8FpXikim68n+XwFID64n8FJwyKrdS4VwSnEWE3R3z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKSXcyvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKSXcyvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1531F000E9;
	Tue, 16 Jun 2026 05:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781588355;
	bh=kIf5jcPlK/FXHU7GwogCMydsg42yt/iPtkSvM9+H/BI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GKSXcyvu+LE0qsL3QnTaDAzncwwZ2m/nhhOxeeWeAHbTB09uQJdFvQAcV+N3GHVzb
	 w1xgQ5db/ZypQkGjNdN7fBbPx9XYQk94GAkqYzMnQwwI4+c+aRU5HajeoEK+sw4kkO
	 RPxkRCiuEXTQW3R3TrrGeR13z0acza4vW/gQNlREHTLmQ6qZvChizlgIlgUHo57taX
	 UaMSPQFRRgN6RA8blnyzfMjaPFJIRSXMGmc0wnSFiYEOKONxLOzGMxdoUdPlqA2rfQ
	 JDubYHAoFeo8f9LO1Enso7Z9rKs6kRQ+PonNCZkqf0iFm6kN0j2X7Xn68LxnOSRI1b
	 JcbvFugQ59tXg==
Message-ID: <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
Date: Tue, 16 Jun 2026 07:39:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/06/2026 à 19:34, Amit Machhiwal a écrit :
> When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
> the traditional cputable-based CPU identification and instead derives
> CPU features from the device tree's "ibm,powerpc-cpu-features" node
> provided by firmware.
> 
> However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
> identify Power11 and later processors, and is not represented in the
> device tree's ISA feature set. While ISA v3.1 support (indicated by
> CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
> CPU_FTR_P11_PVR flag is specifically needed by code that must
> distinguish between Power10 and Power11 processors.
> 
> Without this flag set, code that checks for Power11 using
> cpu_has_feature(CPU_FTR_P11_PVR) will incorrectly return false on
> Power11+ systems using dt-cpu-ftrs, leading to incorrect behavior.
> 
> This issue manifests specifically in powernv environments (bare-metal
> or QEMU TCG with powernv machine type), where skiboot/OPAL firmware
> provides the "ibm,powerpc-cpu-features" node, causing the kernel to
> use dt-cpu-ftrs. The issue does not affect pseries guests, where SLOF
> firmware does not provide this node, causing the kernel to fall back
> to the traditional cputable path (identify_cpu) which correctly sets
> CPU_FTR_P11_PVR during PVR-based CPU identification.
> 
> In powernv TCG guests, the missing flag causes KVM code to trigger
> warnings when attempting to create KVM guests, as cpu_features shows
> 0x000c00eb8f4fb187 (missing bit 53) instead of the correct
> 0x002c00eb8f4fb187 (with bit 53 set).
> 
> Fix this by setting CPU_FTR_P11_PVR for all processors with
> PVR >= PVR_POWER11 when ISA v3.1 support is detected in
> cpufeatures_setup_start(). This approach ensures forward
> compatibility with future processor generations.
> 
> Fixes: 96e266e3bcd6 ("KVM: PPC: Book3S HV: Add Power11 capability support for Nested PAPR guests")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Related: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> ---
> 
>   arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 3af6c06af02f..e5853daa6a48 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>   	if (isa >= ISA_V3_1) {
>   		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>   		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> +
> +		/*
> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> +		 * Power11 and later processors. While ISA v3.1 is supported
> +		 * by Power10+, this flag specifically indicates Power11+
> +		 * for code that needs to distinguish between P10 and P11.
> +		 */
> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)

Are we sure this test will always be correct ?

For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1

Wouldn't is be cleaner and safer to just do:

	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11

> +			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
>   	}
>   }
>   
> 
> base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770

