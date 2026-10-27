Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109060;
	b=WKCWs4fM/txzAoSnc8e6koYEGrUHZebh5pjWZwHenRUctW7UUsJRWittA2omkLjGdfOw
	 fRW/wAHxcmB7Dxwt2IQZ9t1rMbSRoh/Kiw9BBnTuw5heOFap+WM38CsQR7lW8eW86EuxB
	 a4JVx1tkyaUyUzja6DUb4SnHHNDvvRMH7Jn69NmuajJu6ddVqxu0kDcyGXQNxMQUoOYvC
	 fImHsOIy+YhgHlJuehVRE0fgt9HSWBACgtqKG17DD9mlu/JvFhMvFSxFvLlHxA14VNOuN
	 c1bb1XISh4/V/a6jxROqNOhCi0AP9Kj1GvCzPGgvKyAop4y1y4FX9VzRrMnDXPH1xYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109060;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iDpeC4vAedQvXqYDjDb5n7gsefa3gXa0pHuyMumuaJg=;
	b=iQUJTiO9L/xDmdaACr0HZHLwQWwaOfjdAsXlDJm7jaKUKu4TwjxgnQF4u4EGbPRLAi8/
	 dImBGK2xFta3sMl+JDIL/BoG3NmVRo3tr4CLxuezJufOtz2IXVSTa652PQO1gDcgfWqXe
	 PhU8WCj7KsN+MU4bYmiCGAyE65SZAZd3lGGOOhgMHHW1FPIKrwSdSLolYwDLrp0b1Cz3A
	 nq2dF0yD51n9VFSKZyfktDtNV3dqoIRuy59xIahrWAzgbrMEMJHORI4VrVfoUNN5I4vaz
	 JWiNBQqUJdjuAELTCjtUAJfKs0wpIRf2Lql1UkXE4c8U7I2gHrbOc/Ce9sxkI1bdM0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ea14WwRR;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3526C606A322;
	Tue, 27 Oct 2026 13:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3526C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ea14WwRR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793109058; x=1824645058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K44EYJ+tSE+pgxSxW23nPIYPzojqHbOOSxq0BfMNrVI=;
  b=Ea14WwRR7SqS5KOhieOwmc4O2uh+1oZbUWQj6kH5aItlLizfGhKLUdLd
   nrhEqaSKvdrgNNEl/mYOh0T0CU0/1XcO0JxBRMO8qdsjzG8gDkdM/hsdz
   kLQyMeFJOfCwXlJbIg06lItxbr5ZuG9tUv8zamWzOIKOG8LjgIuX4PY2G
   KBI/u+GtZbWztYqe9or/XkXsdFkWplkF/KmpPQCUPcp7iRPDjcfkoEsCu
   bvxF1AmoaK5Bjun0VoBJ7JvcYJU2EzY3lxt5QRlbVkEyOuq6JyA3zOs/r
   Qrt2nYUPavelTFebw59Anylk9pTdE2JAHks/b9jdAdodtynPIpYjAC2QZ
   g==;
X-CSE-ConnectionGUID: dx607dAQQVaKQlu3exNpQg==
X-CSE-MsgGUID: LWdroOMsRpWgW++aVFN3pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1686232"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1686232"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:50:58 -0700
X-CSE-ConnectionGUID: fJsaj7XAQDGmmauUEdyIXA==
X-CSE-MsgGUID: Ab3HNCNHQya+uxSLtVYLsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6424319"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.140]) ([10.124.240.140])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:50:55 -0700
Message-ID: <47bbb569-985d-4d48-8193-616685c76fcd@intel.com>
Date: Tue, 27 Oct 2026 21:50:52 +0800
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
Subject: Re: [PATCH v3 1/2] virt: tdx-guest: Fix timeout detection in
 wait_for_quote_completion()
To: moe@flashbots.net, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Erdem Aktas <erdemaktas@google.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dan Williams <djbw@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jun Miao <jun.miao@intel.com>, x86@kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
 <20261024-tdx-guest-quote-poll-v3-1-6a83bb767314@flashbots.net>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20261024-tdx-guest-quote-poll-v3-1-6a83bb767314@flashbots.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/2026 3:17 AM, Moe Mahhouk via B4 Relay wrote:
> From: Moe Mahhouk <moe@flashbots.net>
> 
> wait_for_quote_completion() counts the seconds it has waited in i and
> reports a timeout when i == timeout. That gets both outcomes of the
> last second wrong:
> 
> - If the request is still in flight after the last sleep, the loop
>   condition increments i once more before it fails, so the loop ends
>   with i == timeout + 1 and the function returns 0. The caller then
>   returns -EIO instead of -ETIMEDOUT, without the "GetQuote request
>   timedout" message. Before commit 0f409eaea53e ("virt: tdx-guest:
>   Return error for GetQuote failures") a timed-out request even
>   returned success with an empty Quote.
> 
> - If the VMM completes the request during the last sleep, the loop ends
>   on the status check with i == timeout, and the function returns
>   -ETIMEDOUT for a completed request, discarding the Quote.
> 
> Decide on the Quote buffer instead: the request timed out if it is
> still in flight when the wait ends.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Cc: stable@vger.kernel.org
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Closes: https://lore.kernel.org/all/atoHWgQF-0vlTRK4@thinkstation/
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Signed-off-by: Moe Mahhouk <moe@flashbots.net>
> ---
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 11d741da3b35..a5a53174f9d9 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -282,7 +282,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *buf, u32 timeout)
>  			return -EINTR;
>  	}
>  
> -	return (i == timeout) ? -ETIMEDOUT : 0;
> +	return (buf->status == GET_QUOTE_IN_FLIGHT) ? -ETIMEDOUT : 0;
>  }
>  
>  static int tdx_report_new_locked(struct tsm_report *report)
> 

