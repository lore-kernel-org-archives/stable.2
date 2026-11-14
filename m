Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665368;
	b=3+nRyA852+QkgxulsAOus9A5uBphUqSDhQVll8OKDkqje4yAmYaFLKDrWVaHKMQrx7oO
	 RLhDUQCJ+qMC/l4228k8n9lXcbpgamcVBj9Q9xcOLBX4p3HZGgjzZ62mB93SgaWOimtNl
	 4d49ZaEukiQaiPhhhTobE/DE+wmSLAF56t/flAqU7k3q8qmhYphSfFkLPrz+w0jOKoXZZ
	 hP9x29u9ntzJmQYAEoVz8PyXV191Kwh5j3ClBVEHsAETB+/UKauN+K4FRFroe+6NzJnOh
	 u5nOoCDGtEn5LEFYHTYF0di67urPqAmH6ewJi8oiBXtOtSx4GT7jSqZJE+j5hSlBvfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665368;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=KnQiD6fX/r8PsqpObs5NkuGJ85feklMhNeGaXyI/6aU=;
	b=WBRinwRQrIr77sX+YAmqgRoOZYGoq4A25G/cHvRaseUpn+2loN8YoxVCw5pwArFBML0g
	 aSKzErMfOLa9JLNoJ5UnRYBSNwMYJ1vI9dJmdzDzeeggu2wRbp5AN0P1vVNWjdGCzDeij
	 zWFJZZiZ/UCPLb1xSKLdy0LqMRAhY0/wIxWN4cvC6Uf5ASUMEs6RqkWKVcXSAEBDIOu11
	 JpSUkbi9+Wa9l+aI1ygy9Utd+zuK6arkjPTp6K6bwhhcEiag4GeiY+50SalPcSJEcKXnU
	 AP1nt3cGq57DpiXvaC07SZQdukiKWCundLqHnelCoSc2zsk785qVJmYSg1CZ3BGuiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TC5FL2lT;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB069606A327;
	Sat, 14 Nov 2026 14:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB069606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=TC5FL2lT
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jRbbL0P5RzKvsY;
	Sat, 14 Nov 2026 15:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794665358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnQiD6fX/r8PsqpObs5NkuGJ85feklMhNeGaXyI/6aU=;
	b=TC5FL2lT2lS0S2qysNX9Bkq/CtcVfSLBCXp51OuofG0N4qs10oP46L9CPPniucJT6fgJWX
	944MV4eXnzTN393hLcj4S+ZhOlh1fTzphFgXAtUHcUne4AKXej8S0kAt6r/HHtl2XFn1YP
	3xxZ7Pj3Do6U1jdXqffJzzWbGg8KHMzECZcgBK+sVXO04LEQ/58OM7Q8k95/n36Z/Fnl3p
	bN3ATPBDQzoGcsuVeB8JFDOJCpMc/RCWlTdPd9faNHpP5mRlgKoSIIoXpKpisvzMuLMCyU
	EnhNTThhHtJb5VLNWVaPy3MEYa8OoSWZ4DrtLqkI5Abqd9bqkInMWvr/NS2Hwg==
Date: Sat, 14 Nov 2026 15:09:10 +0100
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpupower: fix use-after-free and stale limits in
 frequency-set
Message-ID: <avhrhuLjzi9-V7ZY@lukas-arch>
References: <20261112-cpupower-freq-set-use-after-free-v1-1-4e0034927b3f@mailbox.org>
 <1bb7b407-0e69-421d-8ee3-81489abd1dda@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb7b407-0e69-421d-8ee3-81489abd1dda@linuxfoundation.org>
X-MBO-RS-ID: 7b4a42c4232717da541
X-MBO-RS-META: 8p5mh6jypdesokf6ojzqinwjy49keb1n

On Fri, Nov 13, 2026 at 04:09:23PM -0700, Shuah Khan wrote:
> On 11/12/26 12:49, Lukas Beckmann wrote:
> > cmd_freq_set() currently has two issues:
> > 
> > 1. use-after-free
> > 
> > When cmd_freq_set() is invoked with --max and --min, it eventually calls
> > do_new_policy() for every selected CPU with the same cpufreq_policy
> > struct. do_new_policy() first retrieves the current policy and copies
> > the governor pointer to new_pol.governor. After that the policy is
> > applied and cur_pol (including the string to which new_pol.governor is
> > pointing) is freed. For the next CPU, cpufreq_set_policy() reads that
> > already freed memory leading to an error message (because verify_gov()
> > fails).
> > 
> 
> > 2. max/min is not retrieved for each individual CPU:
> > 
> > If cmd_freq_set() is invoked with e.g. --min and --governor, max is set
> > by do_new_policy() on the first selected CPU by retrieving it from the
> > current policy. Since the same struct is passed to the next selected
> > CPU, it is not retrieved again, resulting in writing the first CPU's
> > max to all selected CPUs.
> > 
> > Fix both issues by using a local copy in do_new_policy().
> 
> Good find. The change log is rather long and confusing to follow.
>

Thanks for the review,

I will try to come up with a better changelog for V2 (including your
feedback below).

> > Issue 2:
> > Minimal example without the patch:
> > 
> >      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> >      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> >      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> >      2000000
> >      3000000
> > 
> >      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
> >      Setting cpu: 0
> >      Setting cpu: 1
> > 
> >      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> >      2000000
> >      2000000
> > 
> > The maximum of CPU1 is set to the one of CPU0.
> > 
> 
> The real issue here is not that the maximum of CPU1 is set to
> the one of CPU0.
> 
> The real problem is that stale new_pol is used for all cpus
> from do_one_cpu() slow path when more than one policy value
> changes.
> 
> Please re-write this in your own words in a simplifies way
> describing what lead to the problem.
> 
> 
> > Minimal example with the patch:
> > 
> >      echo 2000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> >      echo 3000000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> >      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> >      2000000
> >      3000000
> > 
> >      ./cpupower -c 0,1 frequency-set --min 1GHz -g performance
> >      Setting cpu: 0
> >      Setting cpu: 1
> > 
> >      cat /sys/devices/system/cpu/cpu[0,1]/cpufreq/scaling_max_freq
> >      2000000
> >      3000000
> > 
> > The maximum of CPU1 is no longer set to the maximum of CPU0.
> > 
> > [1] https://lore.kernel.org/all/20250827-power-memoryleak-v1-1-e4baf7b59a41@uniontech.com/
> 
> The above patch doesn't make sense. I need more information
> to determine, if it is needed.
>
The memory-leak is of course not noticeable by "normal usage".

However, tools like ASAN still report it, so the main benefit of fixing
this would be, that someone who is using e.g. ASAN to find a different
issue, is not side-tracked by this. I will drop this in V2.

> > ---
> >   tools/power/cpupower/utils/cpufreq-set.c | 17 +++++++++--------
> >   1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
> > index 06cd4b280132..d9f6ca522fe5 100644
> > --- a/tools/power/cpupower/utils/cpufreq-set.c
> > +++ b/tools/power/cpupower/utils/cpufreq-set.c
> > @@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
> >   	}
> >   }
> > -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> > +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
> >   {
> >   	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
> > +	struct cpufreq_policy pol = *new_pol;
> 
> Don't assign new_pol to pol.
> 
> 
> >   	int ret;
> >   	if (!cur_pol) {
> > @@ -151,16 +152,16 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> >   		return -EINVAL;
> >   	}
> > -	if (!new_pol->min)
> > -		new_pol->min = cur_pol->min;
> 		pol->min = cur_pol->min;
> 
> Use new_pol in the if logic using pol as temp - changing
> pol to temp_pol
> 

Okay, I will do that in V2.

> > +	if (!pol.min)
> > +		pol.min = cur_pol->min;
> > -	if (!new_pol->max)
> > -		new_pol->max = cur_pol->max;
> > +	if (!pol.max)
> > +		pol.max = cur_pol->max;
> > -	if (!new_pol->governor)
> > -		new_pol->governor = cur_pol->governor;
> > +	if (!pol.governor)
> > +		pol.governor = cur_pol->governor;
> > -	ret = cpufreq_set_policy(cpu, new_pol);
> > +	ret = cpufreq_set_policy(cpu, &pol);
> >   	cpufreq_put_policy(cur_pol);
> 
> 
> thanks,
> -- Shuah

thanks,
Lukas
