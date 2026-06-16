Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF03CDBA9
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587599; cv=none; b=LWh7WlRKBOrqP9bgJ6VvHdXkPnaI+L5XsOuh50SMeS6vK6G4GIArq40yAtJTnWcIhpnMHRmlFQsFykphQ9QaSi/T0dlhY85QkXKmRbH8FJi8rSSXTKmaqXsrsdD6uME5toShio/8vXQpxOAKIxYqQNbdl0e346xF1VH1/iv0J1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587599; c=relaxed/simple;
	bh=VbHprg1QVzIP6v6MioBeYfJ0zmyqifa+xT/hcVOtUBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWozxAbIGhFIO5eOHlHcX7hQoEZnCPRHqtyZ4D79G3v82BNARmqkmZniPYg5sSdAegv/iBlJZ/WYaLjVWFWyOwJEc6OU2cbR+fBSlEZImFpHE8E2fABQrtgT4obTRwulHw1ox0D97gQG6rFPEpRc5ePYf2MIJDffAdx4h14EwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZRmzy4U; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZRmzy4U"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36c68964315so2263480a91.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781587597; x=1782192397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4n6qBl+KTq7TdCOLaPzBA6e4TkFS/AdafSUnLDct10=;
        b=rZRmzy4U2+GmsLPrkBRs1KIGP4DMClqgfS5Y2Qcl86nxpQpBhmjypWvbGu6yU0CeZJ
         v8/s48EJ917DeFJwdHXU3PQ7AECtGxWk0S1c6yROXKOd9i3yil2oGuPW7zQvsu5GO2ci
         NYI8n2a5g23pmTSEKatKtRYIUc6NgvTUFsjDqbutQehIl89HKPjL4d2cR3+gbk2XS5h0
         hLUWBU3sl2idTfrYoZAvaqaKlkHKAHrKoRFZKmbuHhOU9W5yjYDh2yifEmkRgmrdl6wf
         NGQVxC8an9QnTgf2pwzvDRfkCODCyZEIs5IhI0if1P4OXCTUd+BfbmOTUmP+NaIQ9z/u
         10OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781587597; x=1782192397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4n6qBl+KTq7TdCOLaPzBA6e4TkFS/AdafSUnLDct10=;
        b=nRwFrY8QZyaZKl9/ffu+5nR0l/4OvZN6pd/0Hv4HxBoH7KHNMZlZz+kTxweOEYnXbX
         eKjcz5GDBFLBo1zx5fWdmoMcBavxcKspGW9e2/xba2snw0134Zrz0k0+VK0F8DrKodWJ
         u4Gs9pBUm0ILyDtbUTVVjv3BtY5HD3/8UKRFleo6xotkI6oR/E5OmVeP5IiAH0hm454L
         5KSQHbVBv3DmRAUTTtadPaz/HtuCsmlVscSDWIFl7LzhoBT0dego6RvkTM0nKpxN1hse
         sWEDmX3oL/208KhZTUDEE2iXiTFyeXMU54IrO2ZuC7OH6E5qZNTqW0da3HCe3jrpkVG4
         PIfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p2y6W0l0DoHgoZKKzK+Hq7396f1TVyxib7fH+HEOzdJynU+f2Pryc2PbirFVOZ4ykwRd8F84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSAMAqwsImrMMjkdyL3d4sBNzW5HdT2/ILM83No0Du6WQIMdx
	LXyDg/7Haemuevmrri5dVU63YduPomD4aSlZJgGW5uHaZ32rdF9HGbttQV977A==
X-Gm-Gg: Acq92OHL0cKoP8uHS18bUTI/+8HAqjevVmNKLvjPWOgZ2cmjHdjygm5sa5TpCwb7WV5
	fQy7xd0hwxcirvAZksBuJFi6LeR5k8MuNlxTAOt37nk1VJLad3JdgO/QMkCnaKxt5DHwUXAtOVC
	nQBsYBUv7raGwD4cfXLuqf9S1xbomOrF8VKM0gqfT7vv/NlBAHJ1FntSY0NxgS99Hh5kNkUseSm
	OvW2Pkz/ygY5DjYj5WW84RMYhWjCTa9oIi0qDlYzZiYW52yYCJe7MIaVe/Tfu7O84BuN6/4UaxP
	eiv55ynjdfV51egQtwYui4sPikH1luYpTt0MLVd+Dcv3Rgbcwbw0X7XyzYWLkZ6vBwIJgbdJWXK
	O/9H8Ql58ADYZ9mHghwWwbTBv5+G20+kMEEzT7lJJr3KuSvDx/3xJiEZxV3CmClG1R/paCH3oCK
	d9dTpkLsZRb035ZbaJ66UVdTkMMs7dHCZHVWVJwn9l07m1yKj52xl31nKuNB9q100Nwp9sNCQ=
X-Received: by 2002:a17:903:b06:b0:2c0:b5c1:8e22 with SMTP id d9443c01a7336-2c69a14a408mr22728725ad.12.1781587597232;
        Mon, 15 Jun 2026 22:26:37 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm119203765ad.71.2026.06.15.22.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:26:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:56:29 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
Message-ID: <ajDeMuSaHSyJuZ9m@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>

On Sun, Jun 14, 2026 at 11:04:37PM +0530, Amit Machhiwal wrote:
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
>  arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 3af6c06af02f..e5853daa6a48 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
>  	if (isa >= ISA_V3_1) {
>  		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
>  		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> +
> +		/*
> +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> +		 * Power11 and later processors. While ISA v3.1 is supported
> +		 * by Power10+, this flag specifically indicates Power11+
> +		 * for code that needs to distinguish between P10 and P11.
> +		 */
> +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
> +			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
>  	}
>  }
>  
> 
> base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770
> -- 
> 2.50.1 (Apple Git-155)
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
