Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72243BBFCC
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673884; cv=none; b=G6gq751ED6+3tN48O6bBspArQOJhiEkXFAyZcmVKEBJmtJOSX7Oxydqn53CT54im6GabAAPpm8t0vtJPUX9Ctl37eMAELAd2HS2hFz6gOrzJUx8OkurO7vhlDLTndsi9up4WKRZWadmkVnaMS/WISBSxzWvlT0B6AdWt5xIWm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673884; c=relaxed/simple;
	bh=8H/HsdoetcAOJZVv1k4ryiuDTR/E+4atDCtXI+XvUoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyvF29wcKoTBUqOe7WnurNX7IjgwpXuitMZeNBYQPnoqXKG6KP2DJtU33rHQYXV32z1zJbAgz3QmW6J8Lc99l+Bei6AQtmZhBbdjdOb2DpwN4PIUXrVrYcZ8pTL8a8QzA5pI+L8aYTFFlusXB/v9HyhALOct+qN3faOVpaDrwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BwL1XnJb; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BwL1XnJb"
Date: Fri, 10 Jul 2026 10:57:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783673881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V4lipBWZFiKZbcBCGrGNqJAdNSbDlvvBaJ40rsLV1ys=;
	b=BwL1XnJbI6qMhQVrMX9TiyLufLQn86s9X6401ev1gDRrnnT06dyPVqMOb73oRKpqsVGKrZ
	h43+rJY1hNASuum6AxXyJc4SokOths6/y9N+J9ohWW19GL8EARMDr5s6KJX1QKXEN07avc
	E3qc6rLE77JlG1smqFQ1NzElKY8jqEo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	stable@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry
 count
Message-ID: <alC0DpNDh7SrPc9E@linux.dev>
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 10, 2026 at 11:53:23AM +0800, Binbin Wu wrote:
> Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
> initial read and the subsequent copy of the initialization data.
> 
> tdx_td_init() first reads user_data->cpuid.nent to size the flexible
> kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent,
> and that field can differ from the value used to size the allocation if
> userspace modifies the input concurrently.  setup_tdparams_cpuids() later
> passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
> the array bound for the copied entries.
> 
> Require the copied count to match the value used to size the allocation
> so that CPUID parsing cannot access beyond the entries actually copied.
> 
> Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
> Reported-by: Sashiko:gemini-3.1-pro-preview
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>

LGTM, and thanks for fixing this!

Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>

> ---
> v2:
> - Reject the request if mismatch instead overwriting the value. (Thorsten, Rick)
> - Lump the check into the existing sanity check on the cpuid field. (Sean)
> - "KVM: x86: TDX:" -> "KVM: TDX:" in the shortlog.
> 
> v1:
> - https://lore.kernel.org/kvm/20260708022937.2465796-1-binbin.wu@linux.intel.com/
> ---
>  arch/x86/kvm/vmx/tdx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 6ff1469e91cc..d1af0a752e97 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2797,7 +2797,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>  		goto out;
>  	}
>  
> -	if (init_vm->cpuid.padding) {
> +	/*
> +	 * Reject the request if userspace changes cpuid.nent between the
> +	 * initial read and the subsequent copy.
> +	 */
> +	if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
>  		ret = -EINVAL;
>  		goto out;
>  	}
> 
> base-commit: f1e5ada5ab62dbe32350bc161771c9afc6a896de
> -- 
> 2.46.0
> 
