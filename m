Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6043BDCD;
	Mon, 12 Oct 2026 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791879; cv=none; b=rD6vx+LKBhJMf9nepjfiyxk4Z2BP1udWohcIcNmS8Is0lPJJ5uVS755Kobz7VTrTqaxMfEaBct1lqj4Tvqdu2tXFX1DN42HMqxTU+3BB/gVf6lHU7sE0IAUramWv3DOPL+4NYSrsmyIP+SBBVPWc8DLbev1QYsaN2cOP+X34500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791879; c=relaxed/simple;
	bh=7JqLAOa1EyGe4HapsMeO5QWw/F4ZSfyXto1wc+DnCZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AB57urhgHGV26pgyse1J2iRT49ywn/7QFojunaV73z9RUWf5ffoArC3xw+omw+laNYcyDZ6x0ydNu8m93+I7V+eCThZ1up2+e31ROSnYcnBGZn/T5vnES7ctiQJbu6tvZtr9cwKu4bFbaDLS0vp9ldjSn+vm+JpJWk4umgK5zsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a5WY6OZL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a5WY6OZL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E25951650;
	Mon, 12 Oct 2026 00:57:53 -0700 (PDT)
Received: from [10.57.12.163] (unknown [10.57.12.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F8023F882;
	Mon, 12 Oct 2026 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791791877; bh=7JqLAOa1EyGe4HapsMeO5QWw/F4ZSfyXto1wc+DnCZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a5WY6OZL8ew1myYgDvp9xZewbEw+qBNvGPS9d4rrDOIgWKOQb168Ovj/Dba9lI22k
	 kZSTKA7wyaLV1aacZEl7e0Oahxf80O2iIxS7INjaTDQfmqUeUXNTOnI8fPPP4plO+d
	 uszowVYnU8Ye7EWwRDZEj5LWP44Jmjzaa//AikDY=
Message-ID: <117bc415-6bbb-4739-81b9-d2bf718056ba@arm.com>
Date: Mon, 12 Oct 2026 08:58:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: EM: allocate the cpumask for every perf domain
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260910205234.5392-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20260910205234.5392-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karl,

On 9/10/26 21:52, Karl Mehltretter wrote:
> em_create_pd() allocates space for the trailing cpus[] flexible array
> only for CPU devices.  A performance domain registered for another
> device therefore has no storage for its cpumask.
> 
> All performance domains are added to em_pd_list.  The netlink interface
> does not distinguish CPU and non-CPU domains when it calls
> cpumask_weight() or iterates over pd->cpus.  A request for a non-CPU
> domain reads cpumask_size() bytes beyond the allocation and can report
> bits from the following memory as CPU attributes.
> 
> KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
> against a synthetic non-CPU performance domain.
> 
> GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
> request can reach this path when a GPU or another devfreq device has
> registered an energy model.
> 
> Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
> empty, as required for the documented unused field.
> 
> Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>   kernel/power/energy_model.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index e610cf8e9a06..fd07c564c201 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -439,7 +439,9 @@ static int em_create_pd(struct device *dev, int nr_states,
>   
>   		cpumask_copy(em_span_cpus(pd), cpus);
>   	} else {
> -		pd = kzalloc_obj(*pd);
> +		/* Readers expect pd->cpus to exist and remain empty. */
> +		pd = kzalloc_flex(*pd, cpus,
> +				  BITS_TO_LONGS(large_cpumask_bits));
>   		if (!pd)
>   			return -ENOMEM;
>   	}

my apologies for the delay.
The patch looks good, thanks for catching this!

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
