Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207324;
	b=mbrJAxMF1U7rdyzqNnKt3qeIFhzL5IbG3P5uvgOZ5q4p8VpLLFpeRp+gedkB7mnpIBk6
	 DkMU/jhfEgIHVD8dLVEdjcQ0cO0pbxS6yhyEa6qtCZxAnbD7WNmdgeQ12AVRz8uhaRpmc
	 Yh/MPdUUXzxcdvNhH4iBrQNL4svRQUAS+cKrJQ6lgO2ngdMdc6bc+N83O4T8Yw5r2aqSp
	 HBP1L5ArzgbO/2/164nkeEmdzfxCuFSDtZDONCAF+v7fd+qiPHjtiG4PyIQPIBq4XYKU8
	 ox4LKqA5LA11DNbA4A8aEvou6sYMs10/y2Vr8XfTmFEIEDVgUjr2idwRF8Uuh5sYpEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5QxBvONaph7bgEQd2yve9sMSGV8Ex3XSmsjoj7Q3FaE=;
	b=z/K8N9/mO5StlOLXDXJ4lBjlxyk+o1I5tvnK66Ki3QEvPnPStwKKXg0L9q0gkLWD2QTy
	 KdYrz2P3DsBSFsWTTIoDWP3vXd0Vq0JQ3uVwP8hcyeXoCRNrir9Szkp4Jz5Wdee8o2yGZ
	 7IcGXDVlTMd2eauBBJMegjgMiEvyh5jWJd046G7SV6SftB6p/ZV08qmvgBKsl0/ywwbKH
	 jPKHBYAg2BWi12wOwW6QYxE/1ixgQM1jiULl+m8T/kkhlZFx3uwqWTUP/Pk+bBV6slENs
	 ts0LUu7YTYttDFk4zPi/B0i6QisTBiHWtmt/IR51p+G6dG5LID7sm4345kdD3sxEX5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Vl1HSM5D;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8723606A6C9
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 20:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8723606A6C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=Vl1HSM5D
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6df7f544919so814298eaf.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795207317; x=1795812117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5QxBvONaph7bgEQd2yve9sMSGV8Ex3XSmsjoj7Q3FaE=;
        b=Vl1HSM5Dg4a6MsPM4I93FkkgPRtjc3rWi3iATtBxbHp8Z4tHYt5JXwo9uspigYOcxu
         z/MeFF8aE4OfqsXT/npJlnN1NlT52TAgI0le4F3aEw6KDXZ1Wf7QWnqYPD47wOt75BZA
         MfAU2R20N+oMrvmqb8HYRH9jqlkY17mZzgQJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207317; x=1795812117;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5QxBvONaph7bgEQd2yve9sMSGV8Ex3XSmsjoj7Q3FaE=;
        b=JaeoOjX72OceOirHpQ39m0uj5QCauh2xFQWCmEtiCoUuKt/hMlw7UUkNNI/VTpTBzv
         lH99hY5pvK2ub4GcEwENbW/ctjjMRn4j1ncZQ3Cn5u6F3gcvsIO5uEDa9qYSn0Aj5Vf2
         wcL+SzgLTMOU1x7UZNonu2g0a8PnzBddvBkJ1Ay+OCrD9aDC3dV7DnPVa9cR7/lSLV9W
         C89KiIgyJ0HwYQEmo1KiKUgDLqPOFdzd7wPHu2rxYgCvpdEjv2x53yZj8MPwxHHbHx0d
         CxtUd/EsSYyf6rjv/ADQpRUd4KHXGooio9jcA59SrmN2Zv4REO+MfTEhbERuBdGLITn4
         JAbQ==
X-Forwarded-Encrypted: i=1; AL+hErFWxusnEOfVal4O8EzNEzoUXtIj825s+Lj7lgHIJhHCzJqGhaj+AdB8Gob/ZQn2f4z24pYAzVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zkF8R3TvTkxpV8RdqQ8vnioClxrX2aBkxsFObKxR4d6JVlute
	3SEfizwsBlGhQijX5xD+hgxmGic/w/awxgE/g/QzsVaItu0Sdw7IE/uQrR/Px3WZtgk=
X-Gm-Gg: AYBFou3OvOqN5ARBEtZCCylWX5In3VS1bqcJFHbZ0KvJ25x3HgMeG7rHxlpOUAAOkUI
	99x+QrGLHqVC0sJTXDsrL+8jbrpEyg0U7M95N3gvWY6uXfp2Otwvgnkejuq1K6BXxri2l54iCVQ
	U6qxZ+NG5DgJSyxyZjsslMCut8qNHNJ/lXtxKrbbNdzPomTv2/t3arAAIngB9wqc9lY8AyDAGO9
	fTYv74ratJbSPQCryeRGAxhGxHGMY/3r4qWFMdMsotDsi7feunUpKAw4w9tzmRzVhf2HIqkNeVc
	SX3cZk//Tgfkr/fUcxSVfvszbhEMJQUG7RC8H+otriB1ruRJay5WhoiHJbktLDhqv+dUUfPp8oI
	tTDhAwy+A8+ZYnzRmPnsKwKD8NXQxL/v+lPe/0W+ptwh9aOI50QBaP16pfsKnR2E13d+osm+LPt
	cUWhNBb9MtgOLepSiDpZwoFQe+p9DD2PiAp/BUnHtkYnJXPai3yEwghCX3tb6xMs2efRjeE18kK
	kb20Ve7rJxaxNjLcrnz7Cn4h4cGaHnVtT6IcY6Mm5nysNKvw+uH0z9Fo8LH3DhMlmXsVn1J87LS
	aSC+Ymr1TaQUAIghzKEzYqiUHMMsXn+iarQrvjI=
X-Received: by 2002:a05:6820:55da:20b0:71a:f228:3222 with SMTP id 006d021491bc7-71b3957e687mr3021698eaf.77.1795207316762;
        Fri, 20 Nov 2026 12:41:56 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dd6e7sm3198832a34.12.2026.11.20.12.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 12:41:55 -0800 (PST)
Message-ID: <69cde473-bd68-4bf5-be03-c68f411ec116@linuxfoundation.org>
Date: Fri, 20 Nov 2026 13:41:52 -0700
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
Subject: Re: [PATCH v3] cpupower: fix use-after-free and stale limits in
 frequency-set
To: Lukas Beckmann <lbckmnn@mailbox.org>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261118-cpupower-freq-set-use-after-free-v3-1-3e021315b579@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261118-cpupower-freq-set-use-after-free-v3-1-3e021315b579@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/26 13:06, Lukas Beckmann wrote:
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
> Changes in v3:
> - Keep the original if conditions (no functional change)
> - Link to v2: https://patch.msgid.link/20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org
> 
> Changes in v2:
> - use a shorter changelog and testing section
> - build temp_pol from new_pol and cur_pol instead of copying new_pol
> - Link to v1: https://patch.msgid.link/20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org
> ---
>   tools/power/cpupower/utils/cpufreq-set.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> index 06cd4b280132..0bbf303d3317 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
>   	}
>   }
>   
> -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)

Why do you need the above change?

>   {
>   	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
> +	struct cpufreq_policy temp_pol;
>   	int ret;
>   
>   	if (!cur_pol) {
> @@ -152,15 +153,21 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
>   	}
>   
>   	if (!new_pol->min)
> -		new_pol->min = cur_pol->min;
> +		temp_pol.min = cur_pol->min;
> +	else
> +		temp_pol.min = new_pol->min;
>   
>   	if (!new_pol->max)
> -		new_pol->max = cur_pol->max;
> +		temp_pol.max = cur_pol->max;
> +	else
> +		temp_pol.max = new_pol->max;
>   
>   	if (!new_pol->governor)
> -		new_pol->governor = cur_pol->governor;
> +		temp_pol.governor = cur_pol->governor;
> +	else
> +		temp_pol.governor = new_pol->governor;
>   
> -	ret = cpufreq_set_policy(cpu, new_pol);
> +	ret = cpufreq_set_policy(cpu, &temp_pol);
>   
>   	cpufreq_put_policy(cur_pol);
>   
> 
thanks,
-- Shuah
