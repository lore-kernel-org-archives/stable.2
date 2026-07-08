Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA76403126
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500158; cv=none; b=Ihn5V1qD//JCl4+YKyImsiK/fHSSugS+1acmtNKyrqQt4moHuQkst52twZ6hYr995fu5pjQnILqXSFYgWMfBoBp+QuCEKIhAQy5W++kMMUmuB/72RF/fyE64VOskZQSBXsWD0plqriAYOIqTllPLyKxG/5HxJPAXsMcUeEp9OQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500158; c=relaxed/simple;
	bh=3S54tvLnJDDcjJDxOOY+h9gVuveFhs2NHvH6IYwnHRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNYySJgEbR/hEiv5HWYFBefe4pfhX54jb3gMEgd3CQwQjktgZp+eBewe1jTYHuBcXwpe+R4GtDuUFwiqguX6EC0JvsJXKfFskTy2E07a0XPWBjjsHbnW2iCo1vSW6/5Ruv6CLb50qwzn8J2NfrdytHxbPXb/1x3Eepfhsn4TUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nNWDn5qx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nNWDn5qx"
Date: Wed, 8 Jul 2026 10:42:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783500155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WfJsk8jFI3Rg6L7ThuU45KGpVrVhFDnsSLp+u4bja+4=;
	b=nNWDn5qxCcOVN3q1dRbmb6q3bJxLvNWNqCU+MHeMeT/7w4i0Wpx8qcVQVfHlbdwGx/oTVR
	hIO98IIq4rYDHjJD4rlL+y/82m5q6tOrSS7KYzLXZQj4b0qs5oRi0CxEvSaP5aB4OMbl77
	LoGEZERYslR5C93XajB1w5zTd9amZ70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	stable@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD
 init
Message-ID: <ak4NdJSK60zKD8Uy@linux.dev>
References: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 08, 2026 at 10:29:37AM +0800, Binbin Wu wrote:
> Use the validated CPUID entry count when parsing CPUID data for
> KVM_TDX_INIT_VM.
> 
> tdx_td_init() first reads user_data->cpuid.nent to size the flexible
> kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent, and
> that field can differ from the value used to size the allocation if
> userspace modifies the input concurrently.  setup_tdparams_cpuids() later
> passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
> the array bound for the copied entries.
> 
> Overwrite the copied nent with the validated count so CPUID parsing is
> bounded by the number of entries actually copied.
> 
> Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
> Reported-by: Sashiko:gemini-3.1-pro-preview
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ffe9d0db58c5..b658b03e7750 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>  	if (IS_ERR(init_vm))
>  		return PTR_ERR(init_vm);
>  
> +	/*
> +	 * Use the validated entry count, as user_data->cpuid.nent may have
> +	 * changed.
> +	 */
> +	init_vm->cpuid.nent = nr_user_entries;
> +

Maybe it would be better to check for a mismatch and return -EINVAL?

	if (init_vm->cpuid.nent != nr_user_entries) {
		ret = -EINVAL;
		goto out;
	}

That would make the mismatch explicit instead of silently accepting an
inconsistent userspace snapshot.

>  	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
>  		ret = -EINVAL;
>  		goto out;
> 
> base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
> -- 
> 2.46.0
> 
