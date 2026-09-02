Received: from mta1.migadu.com (out-73.mta1.migadu.com [95.215.58.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19A47A899
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349587; cv=none; b=eRgAiz6kc2aYihUGqJvXx8NYm6NGMWNngtZlP8wh9p+OSGhaRDcJo098Eiu0pUno0Ub7qFAp+d82KjXwuSsZoLdZMxy9LJF0xaeWAXONYSFgqGFGWcuNlEP3WoEdJNMtVb34SljqDWtw3Q+7Gh/GBoFWj+Go7DsQfrzImfaEkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349587; c=relaxed/simple;
	bh=wWMAcNmrAmsZ+u6qURkfvNyJUvvkqHqQ8/i9M/fpIzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DejF9MWbVwvwmwOT3j5dl3y2mSH03eAkjA6RKYBhQTGT4JIa9DArUk91rJQE+p3lRUoWqeupRdHYw7bpWL+UXXBXhs3mTtmCCfKsHyhozsMobGthpPfj4Z5+EDLDRJYUqIa7wBn8ZAXMysRwfx7ewvQLdw064Wy0OoWP4rUf4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q91snjZY; arc=none smtp.client-ip=95.215.58.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q91snjZY"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wWMAcNmrAmsZ+u6qURkfvNyJUvvkqHqQ8/i9M/fpIzU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788349578; v=1; x=1788954378;
 b=q91snjZY3waE9GdJpAKriw9pR+9Z8JJtkTRxrSlEJUEfC1cK3gCEhPmlDboaRXVdLkhnRoUS
 Ifjbth7fncOxxaekV+kbUW5N+JFBUcqw2p+z2ECroW6EhHLWGCtdmGzg6vMQh32BBgUrZ8VP8zg
 dZgwRR+exOqk3AJQ/2RGdIpk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b5cf6b654d3c87d5;
	Wed, 02 Sep 2026 11:46:17 +0000
X-Mizu-Trace-ID: b5cf6b654d3c87d5
X-Migadu-Flow: FLOW_OUT
Message-ID: <4a941947-04c5-4be8-9d69-3c131775d307@linux.dev>
Date: Wed, 2 Sep 2026 19:46:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: errata: pass REVIDR when matching target
 implementation CPUs
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Oliver Upton
 <oupton@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260831105444.4065831-1-khushit.shah@nutanix.com>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260831105444.4065831-1-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 6:54 PM, Khushit Shah wrote:
> When target implementation CPUs are provided, is_affected_midr_range()
> accidentally passed the MIDR as both arguments to __is_affected_midr_range(),
> so the REVIDR mask check operated on the wrong register.
> 
> Pass REVIDR as intended.
> 
> Fixes: 86edf6bdcf05 ("smccc/kvm_guest: Enable errata based on implementation CPUs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 5db8f0619e4b..b33dccfafaf8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -82,7 +82,7 @@ is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
>  
>  	for (i = 0; i < target_impl_cpu_num; i++) {
>  		if (__is_affected_midr_range(entry, target_impl_cpus[i].midr,
> -					     target_impl_cpus[i].midr))
> +					     target_impl_cpus[i].revidr))
>  			return true;
>  	}
>  	return false;

Reviewed-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Thanks,
Zenghui
