Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871817;
	b=a0/mLRSbaiqEV8zTvEBCyk4+vgtEeaFUu6FRFyFdJZC2lo4Mr6gpDWCvBpaSaZE5QFJs
	 A/RHxww99F0ZFNrmTVNR3Ze04s6Z49zUXnOxLGZiMDuDRek+IJ0f8+n3qqQ6iVImCEXgo
	 Zk/FOnDVdMKzRjyvv6IqsbUtc1o6j9Rr976NzmqiHXnvC9fXkJnZo/NjNPqefb6Dl4D8h
	 +HxXqxEaaQ/bUdPReW1TYyPNaHF5wxNq8jnM2d/9R1dzq9+4o/lagG/kwgoiBbAMo2ra8
	 xeH6hP064uw8Sen32adc7hwx/SEmbr7M9p3GsfvF0EkNzfCyNSDkrtBeVYfgtmbDWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
	b=MWW1Ku34+Mr/l79DY+yPk4RSca9PDjs+Q3MmJwMOl31dkDSGkqMgEMepjEUkCzzMbyAM
	 RdsCY96oZxuOKVv0hFYgZJi7bmtWRdpKtVtVoGfDy4w2gLI1mWUxgfv0r+SzVHBSbaIGk
	 j2vzw5dXh4R/ZahFiI4yEBtVdfXaHkDcmIJD75BzTR+IuqdDeFggLQIm8IdWMW9CdJ5u2
	 LgHq/oGxi8bmt2MO3/bEnIhp19ABPNsNUp7fKra9Myi8qCBd6BSGJQBLg2N05baxsmh+Z
	 JyMrbYNDaCkeuTIhy0zYUlS4jkJGw6h/N67mnn0g3Qu/K6JOvvAKw5r9iDhhFv7hu7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OBqfboG8;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5D606A33E
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 23:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E5D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=OBqfboG8
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a85c656c58so3306753fac.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794871814; x=1795476614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
        b=OBqfboG8yfgrjuTaEKrp2coI9OBrM/b6NybUkYZSEaanNfbvkjungjo6R+ITq7MkWq
         POiKAO+st9W9FJs++7oRlJuiU8VQBoh3JG5Qd/qiHP492Us+8Nzm5Nh/wy6GTQFcUMAJ
         s8rJoQuTHyoBxxue3mjfxIbQ4AXN49lnfNTlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794871814; x=1795476614;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Jvac7JX9KkPIGhfc6fkFsKH/kz8/M9SpUKhnHGt+uw=;
        b=sZxnJH2mGiV28THptifenOHhxtG4e2B3hDERhHpEOoztedNzJGoVTZMy7tLAjE4edH
         5zga8K3vwSp8OKq4hUn11tOR44ZOAUx3UL1UjpZRq2EuiTnnEOyFsVVc9PZiTb3TXr8Q
         Z54bPjyGq86j+ZJBA2Yr9L8474dGin6TRfaBwhadnW9jiXFv2B9dsZXyq/g1AloDrylQ
         /kB1pzIMqyVMmfS60KIlqVM5IhxT4ihQl0776ZAjmaY+U/pRGraBbn/2nweYYK/n5bJz
         frgqx99lqRSVj3PCZCG/+A7i3kuKY3wwlLMkdt2vSLRZPW3dTNofBLDBEi/zr26+SdqY
         o5gg==
X-Forwarded-Encrypted: i=1; AL+hErEH3qytygKASo8qU0mBhhi5z/T1B8kgkcBfj9osZBg6BpTc09IY+eUq8u9iT5toq9Sp8yt5xlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zhtT8XfI2J+drVJ7QxJlS5TRHFXTuUNworf40RGNbUad2DDnS
	T9A/TBsnKPvmgPCCi33Bf/fo2bUb4U20yCUezTeVRl/LsLXbqoUGb4cGVylj7MoICDA=
X-Gm-Gg: AYBFou109aGu97elvreOwLdsDBkoOeKSQc++8KcGjnaWvpWVn30dkGAFqajx1walhI/
	6/OKNjghOGcWb7MfcHteBjKCmzvKz53Z0P0FgjiP4O+WOYJme3x1q0ezcfwfWY0tO5gmZkCmgE1
	wL2345Jto2Wxir3fvJUCW2z/I5If/icWdE6YnpR0Dum15dhE0Zmiw7LjNwUFUJ6igZCYxcNLKym
	txDnAHwUEKCBhjwPPCfFg/dmrq6VZ6VChvwzNwpPugamUjUk9ON+LMdtDopDMieRPphzKlIUgsX
	RY5xd5qGYntYa8vA27ULT3brLr3kLOTEJJekA54TmfS6wGw2lakkdTZNgzjZreuM4J87bir7Bqz
	KhDW4QsgVMphy26flMEtJ8sv4XuW/L5Um06iHd0gx4D57369f14zrv9GNUaXj+vHq1TyxkviDzq
	tnyof7FfoInt+ko7oe6bm9407tkquhFoGDYvGIADU5xSAhOT+k7lyjE2hSKeXdLMDZPRTRMPuP0
	7wi3gAjRman3KbbsDc0pdWSOjrBP+Gm1NgTlZpltjh9KiU1yym/oGP5+GzWUVM0+jOD1UY+JxSG
	J++ryGqO+I+ALTaiOJF+kz1odeogQfu3w1E4JA==
X-Received: by 2002:a05:6870:c08:b0:4a6:f705:25a with SMTP id 586e51a60fabf-4afdf497cfcmr9471729fac.21.1794871814468;
        Mon, 16 Nov 2026 15:30:14 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2288f59sm7859996fac.9.2026.11.16.15.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:30:13 -0800 (PST)
Message-ID: <94e8f3c9-5162-4717-8063-f5c2b4828456@linuxfoundation.org>
Date: Mon, 16 Nov 2026 16:30:10 -0700
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
Subject: Re: [PATCH v2] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/26 03:03, Lukas Beckmann wrote:
> do_new_policy() directly fills the unset fields of new_pol from the
> current CPU's policy. This is problematic because do_new_policy() is
> called with the same new_pol for multiple CPUs by do_one_cpu() in the
> slow path. This results in stale values in new_pol being applied
> (starting from the second CPU that should be changed), and even a
> use-after-free (for the governor string).
> 
> Fix this by building the target policy from new_pol and the current
> policy in do_new_policy() instead of filling the missing values into
> new_pol.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
> ---
> Testing and minimal reproducer:
> 
> Running the command
> 
>      ./cpupower frequency-set --max 2500MHz --min 2500MHz
> 
> with ASAN reports the use-after-free before, but not after the patch.
> 
> Run the following commands:
> 
>      # set CPU 0 to a different maximum than CPU 1
>      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> 
>      # Change min and governor (but not max) of CPU 0 and 1
>      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
> 
>      # See if max got changed
>      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> 
> This shows that the stale maximum of CPU0 is used for CPU1 before the
> patch, but not after the patch.
> ---
> Changes in v2:
> - use a shorter changelog and testing section
> - build temp_pol from new_pol and cur_pol instead of copying new_pol
> - Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
> ---
>   tools/power/cpupower/utils/cpufreq-set.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 06cd4b280132..674e3aabd31d 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
>   	}
>   }
>   
> -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
>   {
>   	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
> +	struct cpufreq_policy temp_pol;
>   	int ret;
>   
>   	if (!cur_pol) {
> @@ -151,16 +152,22 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
>   		return -EINVAL;
>   	}
>   
> -	if (!new_pol->min)
> -		new_pol->min = cur_pol->min;

Why can't you leave this logic as is and set temp_pol fieds,
  if (!new_pol->min)
	temp_pol = cur_pol->min;
  else
	temp_pol.min = new_pol->min;
> +	if (new_pol->min)
> +		temp_pol.min = new_pol->min;
> +	else
> +		temp_pol.min = cur_pol->min;
>   
> -	if (!new_pol->max)
> -		new_pol->max = cur_pol->max;
> +	if (new_pol->max)
> +		temp_pol.max = new_pol->max;
> +	else
> +		temp_pol.max = cur_pol->max;
>   
> -	if (!new_pol->governor)
> -		new_pol->governor = cur_pol->governor;
> +	if (new_pol->governor)
> +		temp_pol.governor = new_pol->governor;
> +	else
> +		temp_pol.governor = cur_pol->governor;

Same for all of the above. Make just the minimum changes
to fix the problem instead of changing the logic


>   
> -	ret = cpufreq_set_policy(cpu, new_pol);
> +	ret = cpufreq_set_policy(cpu, &temp_pol);
>   
>   	cpufreq_put_policy(cur_pol);
>   
> 
thanks,
-- Shuah
