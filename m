Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068EC4B2050
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444029; cv=none; b=uewcQWmVaS9XkSkeQscB1KfdVE+sKTudpsf4Da23Ff9ZxPaM15RxSTy87sSmrnJDKSUPKzsLsk4G5Jkmwfb1weySJOVGWpQe1OqSC1y/xQ/WaVDfK1svmoE9lofznMwvBvwDJHMP2tlh5pu4ZXXts5uHTTZDSNZl0OYpwDrJXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444029; c=relaxed/simple;
	bh=FjtcxQDS3soBj9IDfIhk0j1GKjqT9WRyMUwdeko7VUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRiM0vRxFhH/XzpA+Dqzz912qW+qP3hz0gIuxWIqbkvHAM5fJsMOiMcV5bmis1S4x6uAFOTovsjr04SvlqOn7Vn0wlKFYSwwJeGUWjFiPCooxUlQd6C9NITf7CY1P3kipsOG+x4LblbB/d1FNGy5fCe847G5A1QWqNF3UVNOX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=i+mWn83B; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="i+mWn83B"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-86162c086f8so15445037b3.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1788444010; x=1789048810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q6ffg0EsM9Oq53XXehfd0nBgBXlCf1MLMwzSPDpkFdE=;
        b=i+mWn83BU/HWsqbUv4DI1g+BtYxIXy+uxw3xAtuZjBjuoZwUUymRn3K0ArjuuQFeJF
         Z4ybYB56Kku2XDJf3WUTzkjpl2G8TtBOdNxTpZkLA5WenBaLBiXKzC3+jHSuRgqL4uQI
         XoFxkmSgAQtl+m2NmxGUDYnBr2dnOamGtId2sYNBSlRuDLgmLsUdUz9nOOqmKa33GMab
         t4VTDSPEYQ1Ulz7LAg/qYprc/Q1ZW0DEhit6VpOj7/FwX0ldz9frFCfOVn8TL2M48det
         2IXiTUxZbiSCQB/VrUPjr7ikgFycdKsN50YCduVVb3cnwmTgXDcQyQCSXJa4+va5vXUi
         x4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788444010; x=1789048810;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6ffg0EsM9Oq53XXehfd0nBgBXlCf1MLMwzSPDpkFdE=;
        b=lSiWnuQTbkv2QtlU1F2+9Xft8h7JSL8ScK66vJkxrukyDfFfSxecPzBRm22sW3FS1F
         mlLSjKXBaJM+zwernUqE74XkpeZJZ/jrY+ujCkYshvnCTuOWJ9M1YKJsEPP99anxFSD/
         7EB69IvU6bYKW7+vTosEwKF0BfDxQiBEkdFduwSIc5x4S62PFfKK2L9w9LsAPZggqmSV
         m6fVKoX9P9tSUUr032jaHRahr6uZilodHI+81AsmUjmMrTdZcGu1OnUmR96Jpq6bJJm6
         9ZussKMLlyzAbdfmYGSTN0i67CIYQA2M3h9K8DLEdJc2nFNfbEx86i/ixaZtZimGgU9x
         IzTQ==
X-Forwarded-Encrypted: i=1; AKwUvByuerCKHS3UydGKR6awBFPy7MP2R9JMrEEfNJnHIXXjx1V+hGtPrJdtASyB7tR+mepZp3HXJPs=@vger.kernel.org
X-Gm-Message-State: AFuF++nl+OAC1X8TddmxZcMk+JPF/pyDbYbruEVe2YmEDJwLXyjVW2bB
	t6fNKfo+xRczfAPk6CnOs+X05f50q6ig1wCLUSIcHquJJgTbkGP1MtETdFHFLwea/zU=
X-Gm-Gg: AYBFou0Z6lk4KsFFXHI8s9nVTJ/YIPjDF5pnHMhWbFFtQGgFXV4CkfHPhdC8rTKLCX6
	62HEidvz1AR9Zdf603hE/yEVc7wfbMd12uRLl/yYxPsiMJfdm3U7OF3/hCT9qpzKw+Md+9RLucS
	VGownjDuy25pCZ4bbAGLmDlvOjlXt16zD3QZBGYrZW7yhGpWj4fJPbUW8JPyQFgYtxylHzsrHAy
	Kx+CCxvlJStkGrHau+4CIjgA1WTN+5BoLxinckZXFYWWVMeacetdrrfXzv46sWhjurT+DGSgmEX
	gXAHWgcIzWeWtJfPD9rWvcSzhvN4+L3DWENoME6E2x4Z0wMvI7xn9qKQZN0SR9pD1oxU7jK5Ds1
	9HRelqZAhdx4aK+P9FjxxU7eVhXEDYmUDbdtcpz+GCd4TGUEyQs5OCdjUssys+XH2X8u0ehsMHV
	f60jDDBGbloN7DM/pMcXs+vybo0xuVG9UGRaDvQD6yxh/HRvdRPbP6ifWVE6rV
X-Received: by 2002:a05:690c:a84:b0:7f0:38f7:6ca6 with SMTP id 00721157ae682-86e6d7905ccmr34387887b3.5.1788444009533;
        Thu, 03 Sep 2026 07:00:09 -0700 (PDT)
Received: from localhost ([2605:8600:200:1a83:fe59:7385:2855:8588])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c12d92d9esm40198227b3.22.2026.09.03.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:00:08 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:00:03 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Chris Down <chris@chrisdown.name>,
	Tejun Heo <tj@kernel.org>, Yu Zhao <yuzhao@google.com>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>,
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Ridong Chen <chenridong@xiaomi.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/page_counter: avoid integer overflow in
 effective_protection()
Message-ID: <20260903140003.GR3004@cmpxchg.org>
References: <20260903031952.1120321-1-ridong.chen@linux.dev>
 <20260903031952.1120321-2-ridong.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903031952.1120321-2-ridong.chen@linux.dev>

On Thu, Sep 03, 2026 at 11:19:51AM +0800, Ridong Chen wrote:
> From: Ridong Chen <chenridong@xiaomi.com>
> 
> effective_protection() scales a parent's protection by a ratio of page
> counts, e.g. for recursive protection:
> 
> 	(parent_effective - siblings_protected) * (usage - protected)
> 		/ (parent_usage - siblings_protected)
> 
> The multiply is done at unsigned long width before dividing. On systems
> with >= 16TB RAM the product can exceed 2^64 and wrap, giving a bogus
> protection value and silently breaking memory.min/low enforcement.
> 
> Use mul_u64_u64_div_u64() to multiply in a 128-bit intermediate. Because
> usage and parent_usage are not read atomically (a child is charged
> before its parent), usage - protected can briefly exceed the divisor,
> making the quotient overflow 64 bits and trap (#DE on x86). Cap it so
> the ratio stays <= 1.
> 
> Reported by the sashiko review tool [1].
> 
> [1] https://sashiko.dev/#/patchset/20260826133054.88529-1-ridong.chen@linux.dev?part=1
> 
> Fixes: bc50bcc6e00b ("mm: memcontrol: clean up and document effective low/min calculations")
> Fixes: 8a931f801340 ("mm: memcontrol: recursive memory.low protection")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---
>  mm/page_counter.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 661e0f2a5127..e8bd512069c5 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -8,6 +8,7 @@
>  #include <linux/page_counter.h>
>  #include <linux/atomic.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/string.h>
>  #include <linux/sched.h>
>  #include <linux/bug.h>
> @@ -356,7 +357,8 @@ static unsigned long effective_protection(unsigned long usage,
>  	 * otherwise get a smaller chunk than what they claimed.
>  	 */
>  	if (siblings_protected > parent_effective)
> -		return protected * parent_effective / siblings_protected;
> +		return mul_u64_u64_div_u64(protected, parent_effective,
> +					   siblings_protected);
>  
>  	/*
>  	 * Ok, utilized protection of all children is within what the
> @@ -397,13 +399,18 @@ static unsigned long effective_protection(unsigned long usage,
>  	if (parent_effective > siblings_protected &&
>  	    parent_usage > siblings_protected &&
>  	    usage > protected) {
> -		unsigned long unclaimed;
> +		unsigned long unclaimed = parent_effective - siblings_protected;
> +		unsigned long unprotected = usage - protected;
> +		unsigned long parent_unprotected = parent_usage - siblings_protected;
>  
> -		unclaimed = parent_effective - siblings_protected;
> -		unclaimed *= usage - protected;
> -		unclaimed /= parent_usage - siblings_protected;
> +		/*
> +		 * The usages aren't read atomically, so a child can transiently
> +		 * appear to use more than its parent, making the ratio exceed 1
> +		 * and the quotient overflow 64 bits (#DE on x86).  Cap it.
> +		 */
> +		unprotected = min(unprotected, parent_unprotected);

Looks correct to me. But a few nits on readability, since this code
already is quite painfully complicated.

Please don't do math in the declaration block.

`unclaimed` made a bit more sense when it held *this group's* final
share of the unclaimed protection. As an intermediate, it's *the
parent's* unclaimed protection.

Put together, it should look something like this:

		unsigned long parent_unclaimed, parent_unprotected, unprotected;

		parent_unclaimed = parent_effective - siblings_protected;
		parent_unprotected = parent_usage - siblings_protected;
		unprotected = usage - protected;

		/* overflow comment */
		unprotected = min(usage - protected, parent_unprotected);
		ep += mul_u64_u64_div_u64(parent_unclaimed, unprotected, parent_unprotected);

With that,

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
