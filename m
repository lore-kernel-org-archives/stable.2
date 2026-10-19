Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792421711;
	b=FJN6lX1l1Ks60EyJMfW7bK1PbE1P4295lGDKh1wY66kP8mYjibnAzEO2fr9LTnjSs16m
	 7vIQfp3FtSitcQbCUSOBqdY9+29ZDtDCc7XLB5oo/wVy6S0Ngz//ZPSaS69GEY5vIoozV
	 ZWTXrXjpNqinevj0qvWsnLRo460XX5/tGHCvTgnshUMuvIw3RduytsJS03seVht/6DqV1
	 9dx+Cu/h5H55WZpbWop0tQQkzwZiXqZ2lNPFIAfdsOZubA3Hv79n9ZgfeLC1FXQalPs4t
	 gV4uky7CD+PePTgSqpNGAyyq4TlxZ33yi3a700LKSjYWc0yh199V0XHgtj68jtjO3+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792421711;
	h=Received:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=S4hxhJmvPn7AcnQ/ZWKG7QsPda8INusHl4ZJ/PDgaQU=;
	b=leJazWCODmRRMIYBOs4IPE/2hNbVJZtrtmhU74jBK6euknkjAhUoRvW+9ZwEbxJQyyYE
	 rq/r5KYqWwmURzr9iongc0scMaH4te32u7ArftlzcDLacr/SZKjDCdPTbPPTKr1XGTrtF
	 MDr1rMe4Glu3CwpdERFkYeELw7BbSbdYJ8o6ra6OBqGgzblXEkwEhFd1qRTDwafHrfx3c
	 yF1cLlgDmDEaSyqOuzL6EtSlK7WPIC6B27zbiCQEeIIR8k/XnWCT75IxyDOI1h12QuCKN
	 N99V4ygovYJUzVuyh2QiO98oYTZwPg7KSe+65YkH6A90mzn0RqFeR3T+Ip9E+OBucaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dquZ0zsb;
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF9606EFEC;
	Mon, 19 Oct 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dquZ0zsb
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D543451CE;
	Mon, 19 Oct 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421710; cv=none; b=J9/QY/7TJyZJSbVqisQHHL+7FLACYr9i7VJrXd9savBK7QFvIpwYYNbtkuENSDfCT9XTosviZlnmUI2THjYAMxan42uoAARVLB7FtMLKd32mLBDEFe4EuA9uhCGIDoz+wErkkb1JbmnVXy0YTrniB5E1PD9BkPC/Kpplm9bsl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421710; c=relaxed/simple;
	bh=JePCMnx8/su8AAS/ZVIThUJhxAH7QCVSw2VlUvAcrQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TApFiCU0fnVHU1aidQZRfZZpe1EsI5dXVVMqwlQjGBh1p63mWlbCoM9lRZLXM/WKPdyxl64ZlXb1+eNhpA5rhHn49FaaZTuP77B5FnyTHniY5aWELNVKS8K5+mxwVzw3DD253nVwAEu/wdKQiaFkMNARy1hdyv3GJWGEM4TEepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dquZ0zsb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E01D34;
	Mon, 19 Oct 2026 07:55:03 -0700 (PDT)
Received: from [10.164.19.55] (unknown [10.164.19.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637A23F673;
	Mon, 19 Oct 2026 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792421706; bh=JePCMnx8/su8AAS/ZVIThUJhxAH7QCVSw2VlUvAcrQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dquZ0zsb8TUxQqrVKFHzKecjJPxmFn9BPWmSPeUt4pp2uBPq8APeVyzMisLgssh1v
	 TZU/WEC3H5pP58oL4cP/OjMccLrvXkUY+5HU52USqCNbPlN+hEGwvXf1yR7AkaGpR7
	 gskM7Oy6PccGDnhdnyilm74wYQa3HEvySaszSEwE=
Message-ID: <45c5ebc9-a4d2-44e6-a08f-79676ecb0579@arm.com>
Date: Mon, 19 Oct 2026 20:24:57 +0530
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
Subject: Re: [PATCH v2 1/5] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-2-hao.ge@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261019054531.87652-2-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/10/26 11:15 am, Hao Ge wrote:
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and BUG()s on the huge
> mapping path, or gets -EBUSY with a WARN_ON() on the small page one.
> 
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
> 
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---

Reviewed-by: Dev Jain <dev.jain@arm.com>


>  mm/kmsan/shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..2166086d3dc3 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>  					    o_pages, page_shift);
>  	kmsan_leave_runtime();
>  	if (mapped) {
> +		/* Undo the shadow mapping set up above. */
> +		kmsan_enter_runtime();
> +		__vunmap_range_noflush(shadow_start, shadow_end);
> +		kmsan_leave_runtime();
>  		err = mapped;
>  		goto ret;
>  	}

