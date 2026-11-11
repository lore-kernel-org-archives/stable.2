Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389457;
	b=UWxj0rlbdNVWmFo7CaXLpFf+g6yW2MOSCnESznlKZE4BIL1+4A7YNXbLc8KraUrb+USB
	 y+uSeBr3zoXc551ZbJtiwisHBbtJY7b/bWrW71W5tCeM6IUQAMcf7eOZn+kPItFuVEqkt
	 FMbNpj62LMomcOmSzCu48RISAabKfSE6jZ16p5SQKGd/II/veYadJ/G6NwTqwGS4/Yzpp
	 oswMId0RhK7NL3D3ibqpMPg+A6m57ygyXa64k5Dh1DTSfGS1H1l28K/ESpcZrATvVHmGv
	 0lZFm6wvVKOtFKadcT8Ma+LfRouW9k7zFlTuEH1bmj9DlNyiXXIsDd5B6iYAW+6Fszg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rI3fyWPikHC3KnbTk+u+776sCpBpqD6BG00/t5fbWDI=;
	b=Jwji7JJDcMMHSZL1+hDYfXafpV4HlebVl6oUiES7Nx7GINC/UfNUiQmjuDUnOXmb0UmM
	 yEt5luxEztMdmAh4Myfy7bXzUgOSMT+xJbh15IJXty/4kTxr2TitSgbr97lSJe0VjXdCp
	 kY92pLAnzkDFu0EU7RQsbYXeU8Kc/qHNjkNq+eWFW36+ijWY/QjUMBr+9N6MkWRtj2rK8
	 Xhfaf2TxAwy8CP0nMRLjH+VQ8E5akPiWuSL9fULvkBPCnsfsuL1BVbIvU4vfDOUsYRxWH
	 CTDBaaAgT4vQtLCJLQxKMdQofvEUgnFxqmN2XsAMoBuIxS7S+wpa5Ul//gEr7Fyii9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ki+k69Rv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C360A3809;
	Wed, 11 Nov 2026 09:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803C360A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ki+k69Rv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 888971576;
	Wed, 11 Nov 2026 01:30:52 -0800 (PST)
Received: from [10.57.14.48] (unknown [10.57.14.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404C93F673;
	Wed, 11 Nov 2026 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794389455; bh=iQV6cbskz8rW4tIn0+/kGZ2A6niHv3407z7apgiZQPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ki+k69Rv2i2f99td1C2vOKbmx0eIsxakkK4RJ9rTu6ArE+ObEarzlhaZiigTLSXWW
	 WJCLwoPjFWnBeAf7cWMTQ8Tjw8ISg0hd+At2+G46C+msHf1QEykjG3p29Uw8epxIkV
	 H6LLKNkRrr0brKEIvxtJNKG9JdjtT9we3LUwNM7o=
Message-ID: <cdfaaf7d-8b7a-46d4-bf40-e0dc5300eb08@arm.com>
Date: Wed, 11 Nov 2026 09:31:27 +0000
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
Subject: Re: [PATCH v2] PM: EM: Exclude boost frequencies from inefficiency
 ranking
To: Guo Chen <guo.chen@oss.qualcomm.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
 <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
 <CAJZ5v0i8a98rjFdQ2Jhu_Xk=qCGiNafMfhzNs26cEJNCYB6Xdg@mail.gmail.com>
 <4f0c8581-a8fb-4bc4-82cc-d30f2f56d2ce@arm.com>
 <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
 <bb99aa3f-fd15-4bdd-9319-ccedffc281c8@arm.com>
 <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
 <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
 <58dbf12d-dae7-44c3-b7da-b65a4800c3b0@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <58dbf12d-dae7-44c3-b7da-b65a4800c3b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 06:57, Guo Chen wrote:
> 
> On 11/10/2026 10:59 PM, Rafael J. Wysocki (Intel) wrote:
>> On Tue, Nov 10, 2026 at 3:56 PM Zhongqiu Han
>> <zhongqiu.han@oss.qualcomm.com> wrote:
>>> On 11/10/2026 10:05 PM, Lukasz Luba wrote:
>>>>
>>>> On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
>>>>> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba <lukasz.luba@arm.com> 
>>>>> wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>>>>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com>
>>>>>>> wrote:
>>>>>> [snip]
>>>>>>
>>>>>>
>>>>>>>> That's fine, please continue.
>>>>>>> I have a couple of questions though.
>>>>>>>
>>>>>>> First, why is the ondemand governor mentioned in the changelog?  In
>>>>>>> the mainline, the ondemand governor cannot work with EAS, so it
>>>>>>> shouldn't matter for this issue, should it?
>>>>>> The ondemand is affected by the EM setup code and set 'inefficient'
>>>>>> flags for some OPPs. The EM is also present for cooling devices
>>>>>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>>>>>
>>>>>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>>>>>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>>>>>> In the EM code we have:
>>>>>> cpufreq_table_set_inefficient(policy, table[i].frequency);
>>>>> So maybe this is the one that needs to be fixed?  What about simply
>>>>> skipping boost frequencies in it?
>>>>>
>>>>>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>>>>>> pass to __cpufreq_driver_target() with that flags as well.
>>>>> Thanks for explaining and all of that needs to be said in the patch
>>>>> changelog.
>>>>>
>>>>>>> Second, why is the issue regarded as a defect in the code and not in
>>>>>>> the energy model?  Arguably, boost frequencies should be more costly
>>>>>>> than the non-boost ones.  At least the idea behind the boost is 
>>>>>>> making
>>>>>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>>>>>> treating them as boost OPPs is rather pointless.
>>>>>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>>>>>> It is affecting more than just EAS or EM, since the EM is working 
>>>>>> with
>>>>>> all generic code and all cpufreq governors.
>>>>> To be precise, the EM initialization may affect cpufreq in general
>>>>> because inefficient frequencies are used for CPU cooling.  Fair
>>>>> enough, but I'm not talking about this.
>>>>>
>>>>> I'm talking about a reason for giving boost frequencies lower or equal
>>>>> cost relative to non-boost frequencies in the energy model because
>>>>> this doesn't make sense to me TBH.
>>>>>
>>>>> And I get that such energy models were there before the commit in
>>>>> question and now they are not working properly, but IMO they are
>>>>> broken, not that commit.
>>>>>
>>>>>>> TBH, I'm too comfortable with looking at cpufreq frequency from 
>>>>>>> within
>>>>>>> the EM code.  If that needs to be done, something is amiss at the
>>>>>>> design level.
>>>>>> I think this edge case is special, as I described above.
>>>>>>
>>>>>> I'm happy to hear your view on this EM influence to some global
>>>>>> setting in cpufreq. Maybe it was too far to establish this
>>>>>> 'inefficiency' flags in there for many usage?
>>>>> There's nothing wrong with using the information from the energy
>>>>> model, when available, to amend cpufreq, but the patch goes the other
>>>>> way around: It tries to amend the energy model with information taken
>>>>> from cpufreq (in order to avoid making mistakes later when amending
>>>>> cpufreq with the energy model information).
>>>>>
>>>>> I think that cpufreq should simply refuse to set
>>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?
> 
> 
> Got your point. Having cpufreq directly refuse to set
> CPUFREQ_INEFFICIENT_FREQ might be the simplest approach. Let me
> summarize my understanding. There are two cases where we can
> simply avoid setting the CPUFREQ_INEFFICIENT_FREQ flag:
> 1. boost frequencies.
> 2. the highest non-boost frequency.
> 
> However, there is another issue. If we refuse to set
> CPUFREQ_INEFFICIENT_FREQ for certain frequencies, I think the
> corresponding EM_PERF_STATE_INEFFICIENT flags in the Energy Model
> also need to be updated. Otherwise, the EM state would be inconsistent
> with the frequencies used for energy estimation in the EAS path.
> 
> I think we also need to update the EM_PERF_STATE_INEFFICIENT flags
> accordingly, something like the following:
> 
> for (i = 0; i < pd->nr_perf_states; i++) {
>      int ret;
> 
>      if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>          continue;
> 
>      /*Return -EOPNOTSUPP if the rejection condition is met. */
>      ret = cpufreq_table_set_inefficient(policy, table[i].frequency);
>      if (!ret)
>          found++;
>      else if (ret == -EOPNOTSUPP)
>          table[i].flags &= ~EM_PERF_STATE_INEFFICIENT;
> }
> 
>>>> I see your point now, about the direction. Yes, you're right.
>>>>
>>>> Since we are taking the information about 'boost' from the
>>>> cpufreq, then refusing to set OPPs inefficient in the first
>>>> place makes more sense.
>>>>
>>>>
>>> I also agree this should be fixed in cpufreq rather than by feeding
>>> cpufreq information into the EM. However, refusing
>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
>>> example in the changelog, because the frequency marked as inefficient
>>> there is 4.0 GHz, which is not a boost one. The problem is not specific
>>> to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz boost OPP
>>> at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, but if
>>> policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
>>> RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
>>> should not skip an inefficient frequency when the next efficient
>>> frequency above it is beyond the max limit, which can be done in
>>> cpufreq_frequency_table_target() without touching the EM or looking at
>>> boost flags.
> 
> 
> @Zhongqiu: thanks for the example. I think the two cases are different in
> nature.
> 
> In the case of the changelog, the highest non-boost frequency of cluster is
> marked inefficient because of the boost frequency. A sustainable 
> frequency is
> being affected by an unsustainable one, but it is not really inefficient: I
> don't think these two kinds of frequencies should be compared with each 
> other
> in terms of energy. So I think this should be fixed at the source, by not
> marking such frequencies as inefficient.
> 
> The case you describe looks different, as it is dynamic: policy->max is
> changed at runtime by scaling_max_freq, thermal or QoS, which would mean
> ignoring the inefficient flag every time policy->max lands on an 
> inefficient
> frequency. Whether this is really necessary seems to me to deserve a
> discussion. Thermal and QoS limits are there to keep the frequency from 
> going
> above the cap. In your example (3.9 GHz, 4.0 GHz, 4.1 GHz), if the 
> frequency is
> limited to 4.0 GHz at some point and ends up on 3.9 GHz because 4.0 GHz is
> inefficient, the original purpose of the limit, not going above the cap, is
> still honoured.

There are platforms which have ~20 OPPs and the difference is ~100MHz.
Those at the top frequency they are inefficient but exist for this
thermal purpose. The throttled frequency can be more stable and
predictable in time, thus also capacity delivered to randomly
scheduled tasks (which might be unfair if the freq gets lower
by a lot and some latency sensitive task got a spin at the same time).
Therefore, we do care by making each OPP (at least) available...

> 
> So I am not sure that handling the dynamic case is needed, and I would 
> like to
> hear what you, Rafael and Lukasz think about it.
> 

This becomes even more convoluted now.
1. The only call to cpufreq_table_set_inefficient() is in the EM.
2. EM works with thermal and all governors, not only EAS and schedutil
3. CPUfreq fwk holds those 'inefficient' flags in generic, global way
4. Inefficient flags were introduces mainly for EAS, now impacts
    non-EAS setup (as patch states 4.0GHz is valid but not reachable).

Here is an example from mainline DT platform. The goal was to avoid
the frequencies which have the same voltage but lower freq, e.g.
those from 200MHz to 700MHz and pick 800MHz instead.
Same for 900MHz and 1200MHz.
That was the main motivation back then and research we've made
with a few platforms and EAS.

   freq MHz   opp-microvolt
   2000       <1312500 1312500 1500000>
   1900       <1262500 1262500 1500000>
   1800       <1237500 1237500 1500000>
   1700       <1250000 1250000 1500000>
   1600       <1250000 1250000 1500000>
   1500       <1100000 1100000 1500000>
   1400       <1100000 1100000 1500000>
   1300       <1100000 1100000 1500000>
   1200       <1000000 1000000 1500000>
   1100       <1000000 1000000 1500000>
   1000       <1000000 1000000 1500000>
   900        <1000000 1000000 1500000>
   800        <900000 900000 1500000>
   700        <900000 900000 1500000>
   600        <900000 900000 1500000>
   500        <900000 900000 1500000>
   400        <900000 900000 1500000>
   300        <900000 900000 1500000>
   200        <900000 900000 1500000>



Therefore, I would suggest to tackle this is steps.

1st, let's go ahead with this fix which is for mainly EM.
The EM confuses the cpufreq and then the clients like ondemand, IMHO.
This can go maybe into the stable kernels, since it's small.

2nd, let's think about that 'boost' thing wider. There are
already investigations how to handle correctly the CPU's capacity
and to not confuse the task scheduler. This might create
the right infrastructure.


Side note:
I personally don't like calling some frequencies 'boost', because
such frequencies were there but not labeled that way and they were
OK. In this example, 4.0GHz is non-boost freq, but 4.1GHz is 'boost'.
At the same time 4.0GHz is 'inefficient', which can only happen
when 4.1GHz has the same voltage. I have seen such platforms ~13years
ago and the 'boost' flag wasn't needed to handle them properly.



