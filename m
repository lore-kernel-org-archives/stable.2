Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806305;
	b=WuhEfEoBI0Es3VhnjcsvDwRt4ZRt7gLfag5M1DoqF9Qw5LTK1JyVgPR40Ctna/hVT7nD
	 STOGW4B+nIASJMysUA62sWGARs7ZRXQXMdOJbg6wrDvi1JwzmRK3bRvSbqoTmnia9dvA7
	 HREP3YFVxwxsrDCBZp194kYZX5ANmqE4ktQpouc9MU1fzq0ipFOiYjFizDtmdmn0Etz+x
	 dvlrreZNGkF2/ezOdsjGdnU5ngkz2LpojklG10d3ANEx46nCZysTklz/F3dSDZwFmDlp7
	 HYEDKmpTVZy+kvtRugpiO5/YO84ZSNXbN/8KzT18OLjvfo4PR2Rkerc4Hm1I/yksbMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806305;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BbsPBio+Oi/xjMetnaljYPX/wuA13D25oo61h67SSDU=;
	b=mcLyfu2HIiYH3V7e2A/TaT+k1hj1aIMVUubBrdeRsgsZv4npwMNhkRjgSeUxCxxxK6pc
	 Ocuw207JBUiA3gUFfutYrD2B4OnaBAW0wP3jNJGUj0k8c9UBE8P85zKcqxjbtFe5DyQr4
	 TuVqJFoVh8WRh7xR6mTEaJToa8Tl5DbQlqRwMeMvBtfYKvSXXXNB+si3zQgeBZdwTrikC
	 EGGBTiH14jI09UQfcmXiM/qoHVmUpgoQZkaVzuFoz0jr31oW33z5VwYt49rXuPXpTJJm1
	 SrPtm0lYvbQFQnp6GqoAqyDvbjfwFVaNKwmhr9WGvxK7zBJNBtol6MvHPFMuSliy+GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y28sZgTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457EA606A326;
	Wed,  4 Nov 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y28sZgTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBEA1F00919;
	Wed,  4 Nov 2026 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806305;
	bh=BbsPBio+Oi/xjMetnaljYPX/wuA13D25oo61h67SSDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y28sZgTeh32lyjy9/v4jGgSg5tYNX2dB5uW6e8Jgp5bOOWnfUO8J3iDnDmdJZXmL5
	 bxsT7bcvSFfswUkpXDSv+vMnUiFg/trE9LxdVv6Ln75jfGUzg/CkSPuM295rzSqm3u
	 zIxEHZwf4UcfbJ3G8EMYNAgMBK8SUrS/D8g+brBRZ2DC7agrujCn1A8uUvXitnePb7
	 b/h+egSL7WRRN1bczwqsHOyiyHo6xnd36UEZYYWoRQ1NLN1B7woLQr5uEGp8cw+pvX
	 6m5PF5+CqyaAQvAJleJW+xzqr70F7/rVhSApysM8OVsCA5wWjKsChXmmCwdVN+UwD8
	 tsxhFKCeYPIzg==
Message-ID: <a64878d7-c765-4311-8c59-fa855fddfbda@kernel.org>
Date: Wed, 4 Nov 2026 09:31:42 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Don't print reset reason in VMs
To: Jason Andryuk <jason.andryuk@amd.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: xen-devel@lists.xenproject.org, Ariadne Conill <ariadne@ariadne.space>,
 Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>,
 stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20261104013026.185392-1-jason.andryuk@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261104013026.185392-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/26 19:30, Jason Andryuk wrote:
> print_s5_reset_status_mmio() expects to read FCH MMIO on baremetal.  VMs
> don't have emulated FCH registers, so there is nothing to check.  Add an
> early exit when running on a hypervisor.
> 
> The real motivation is Xen PV domUs can't boot on Zen CPUs.  PV domUs
> PTE contain system physical addresses - they don't have concept of guest
> physical addresses.  domUs can only map physical addresses they are
> assigned, so a domU fails to map the FCH MMIO addresses.  However
> set_pte() does not return failure, so ioremap() returns a pointer while
> the PTEs are unpopulated.  print_s5_reset_status_mmio() faults when
> reading through the pointer, breaking the boot.  This change fixes Xen
> PV domUs booting on Zen CPUs.
> 
> dom0 can map the FCH MMIO, but it has X86_FEATURE_HYPERVISOR set.  With
> this change, it no longer prints the reset reason.
> 
> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> Cc: stable@vger.kernel.org
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> dom0 could work, but that would require a xen_initial_domain() check.
> 
> I've wondered about a different approach:  We can't directly check for a
> device for the FCH_PM_BASE memory, but maybe we could check for a PCI
> ISA Bridge with PCI_VENDOR_ID_AMD.  That might be close enough to
> indicate real hardware?  But it would still be a heuristic, so I'm not
> sure how much better that would be.
> ---
>   arch/x86/kernel/cpu/amd.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 40463bad1078..580ccc2ce5fc 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1357,7 +1357,8 @@ static __init int print_s5_reset_status_mmio(void)
>   	u32 value;
>   	int i;
>   
> -	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> +	if (!cpu_feature_enabled(X86_FEATURE_ZEN) ||
> +	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>   		return 0;
>   
>   	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
