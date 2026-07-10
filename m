Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F963D5252;
	Fri, 10 Jul 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675112; cv=none; b=ZqYtbdva9CVyrBa4Xy1Kwd9EQ2+H1Fpf7XotE+4+vV2zxu+9gAM8q+4VqV+PjGzpjlXAfA2Vkb9bNMJZzbcVQkOyytNQc0AJMJUQw89Z7SYQB/iBCoqxBBeiC/+biDEBoeui1C1QM5/X31gDqQ5o6crRtqxvGEBiKMROxf1g48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675112; c=relaxed/simple;
	bh=0LWkBvkq+clZyL3UFWfc0EGD8a9iy5Nd0NsaJ+2qgLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVxJkVyaniZ+SEKMz0l/mZgfVi2Ol0gi5oqq1eumJKdA6dkjIQO349NqA1TXYXA9Inzc2J69oXV6sInozoHmNERheV+DbKU4N9q/jZyJVpN93Dv8RNcix6n4A03HOw9rn7H5UXSbRgLTHUuwmL2y1k+uZNzH3w6CphW8EIDPfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C2pxHdCN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C2pxHdCN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783675111; x=1815211111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0LWkBvkq+clZyL3UFWfc0EGD8a9iy5Nd0NsaJ+2qgLE=;
  b=C2pxHdCNITMVqRNgg+a8W/MSQQeCSbcb8CD8eA9UUOUGngsOHCaC2Few
   N+PzyJeBC7CjBZ5G8mu7RU3UhvNYXLSeJ4XhI3bBBmUMA9D6J1Svd0EpM
   qrk7v70UP4+wQkghExP10o9oxUhfc4RbLH2cjqhkJOhjTj4/503Lo2I4J
   YM88rQOnGzjYgmicuKmvhw8cJ54ZHDizFPi0U5/hslMyRHJ7kwArsRhCX
   8rpyzOtSZnpJr4Rlln+XW2T5sB6MQIUT2l78O4SJd0SS4v6txirFLkR60
   BOOs0zuig+y096M3AhBx3mRRWhjwVj0UpWUyb8fj7XSeSL+yD4/OzyCvE
   Q==;
X-CSE-ConnectionGUID: nvDbXgezQ6ae6TBXKbAtpA==
X-CSE-MsgGUID: GCCh8bGzT2arg8+p9F425A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88202507"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88202507"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:18:30 -0700
X-CSE-ConnectionGUID: 2cbdx7+XRjmP0C4kY9uSfQ==
X-CSE-MsgGUID: pqUIQ5X5SNKLhd2rBTJfmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254936618"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 02:18:29 -0700
Message-ID: <95a7462c-3c25-429f-9aaf-ef6969a2ebe3@intel.com>
Date: Fri, 10 Jul 2026 17:18:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry
 count
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: stable@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, thorsten.blum@linux.dev
References: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/2026 11:53 AM, Binbin Wu wrote:
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

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> v2:
> - Reject the request if mismatch instead overwriting the value. (Thorsten, Rick)
> - Lump the check into the existing sanity check on the cpuid field. (Sean)
> - "KVM: x86: TDX:" -> "KVM: TDX:" in the shortlog.
> 
> v1:
> - https://lore.kernel.org/kvm/20260708022937.2465796-1-binbin.wu@linux.intel.com/
> ---
>   arch/x86/kvm/vmx/tdx.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 6ff1469e91cc..d1af0a752e97 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2797,7 +2797,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
>   		goto out;
>   	}
>   
> -	if (init_vm->cpuid.padding) {
> +	/*
> +	 * Reject the request if userspace changes cpuid.nent between the
> +	 * initial read and the subsequent copy.
> +	 */
> +	if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
>   		ret = -EINVAL;
>   		goto out;
>   	}
> 
> base-commit: f1e5ada5ab62dbe32350bc161771c9afc6a896de

