Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1742466B73;
	Fri,  5 Jun 2026 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643334; cv=none; b=UOGrDOxUbDFn4js85qA4Wv6xbO+zKRTstepenriws/O+dGPZlzu6VFbwzd8/KF+A87ydngBx2rGVrmNoaF7+ESfbC3K/i99I63rXdb4Zqu6VsItUlLze4Q7slR5iShyiub8L4qSItf2PAixnhZ66OLIC5Zo0MvOpaXLamBNW9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643334; c=relaxed/simple;
	bh=QLYgE3faB0Y4ODsuMCvTJ5m9OPKO6/YajYcQVTdZyvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LubZnyFNVSFm0WKvmBNgLAYy358RuiSsRXpzo6jJPiTPjwRulooDlALCIGNZKr+M9nVZiGoVdzCtUjkxZKr0W7TuuzvQyzuoJFN74wmKIFDkk6BhFRtrA+tahIwXiEoaMLuvlf0Pz1cpIz0joVKAncWSPwGK5OenbBjrZJhjeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAYxB+ba; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAYxB+ba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643332; x=1812179332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QLYgE3faB0Y4ODsuMCvTJ5m9OPKO6/YajYcQVTdZyvc=;
  b=XAYxB+ba01yS/bRteA3g4WUmi1Sn2OHivwNEXko3Q4M0Hbf7RRl7+Kg2
   fYsc0toIDGY1Cseux1lsirchyyQbAqGoKndDruzE+rn3XkWLk9dLtsmm+
   /DRPDLpFkWokK1l9rlyh5POXtCy3ShUXEFvukEcaA6sGFA8GP2O3O6Xex
   JnUNRDkF9KSvfz0IlG1UpiSuBa9dZ83EhnX7s+BZSDDf/8BXgbtCLADJl
   jNlcOyY2XafzR20ruzGy0tXsZNKQJhWuLbTInAZOmHypcaVxQ4Albj2FO
   PSAEyTYm2pZeA+zSTZXF6DyCQwxKSdosZqoPYmfQXLnc/cqm6usrfd+0e
   A==;
X-CSE-ConnectionGUID: Of5pXinwTzG4tIoG1Wtacw==
X-CSE-MsgGUID: Qrkby6PuSaSSil/Lwf6UhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92850545"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="92850545"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:08:51 -0700
X-CSE-ConnectionGUID: a8p7PPSQRjyJvTMi1Hb8lw==
X-CSE-MsgGUID: 2HkUb3ZhR06wlAk7DXrOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="268701891"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.124.241.59]) ([10.124.241.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:08:46 -0700
Message-ID: <d3d30aba-a39c-4b8c-af35-5c238d530f96@linux.intel.com>
Date: Fri, 5 Jun 2026 15:08:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/tdx: Fix off-by-one in port I/O handling
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
 xiaoyao.li@intel.com, rick.p.edgecombe@intel.com,
 david.laight.linux@gmail.com, ak@linux.intel.com, djbw@kernel.org,
 tsyrulnikov.borys@gmail.com, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1780584300.git.kas@kernel.org>
 <e5a75bb68a6a778c95cac2ef77acd55cfd24d389.1780584300.git.kas@kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <e5a75bb68a6a778c95cac2ef77acd55cfd24d389.1780584300.git.kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 10:46 PM, Kiryl Shutsemau (Meta) wrote:
> handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:
> 
>     u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> 
> GENMASK(h, l) includes bit h. For size=1 (INB), this produces
> GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
> bits). The mask is one bit too wide for all I/O sizes.
> 
> Fix the mask calculation.
> 
> Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
> Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
> Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

> ---
>  arch/x86/coco/tdx/tdx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 186915a17c50..65119362f9a2 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  		.r13 = PORT_READ,
>  		.r14 = port,
>  	};
> -	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
>  
>  	/*
> @@ -713,7 +713,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
>  
>  static bool handle_out(struct pt_regs *regs, int size, int port)
>  {
> -	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
>  
>  	/*
>  	 * Emulate the I/O write via hypercall. More info about ABI can be found

