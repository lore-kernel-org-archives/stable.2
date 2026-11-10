Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319486;
	b=WDiX/+riF7K+xGUSiS4j3QHNO7N5gz/rAHwiUkJ1CaC7xVjGkXmvWddptHRblK/2/XnZ
	 wt7w8iCrHIGYohEwNbvRl0DuCt6o+Lkl8osAWUfvA9wI54NjDoX5pSoaEZs/NyczS+WnG
	 yFBiHzcHu3xcMSm8dbggUY5qqVYejLwZqQo9oHVgpiUdHpAMQzlchkNcFqjQekQHkO4NH
	 nanzhN++lOVuRQAfvaYhYBN+N3UhWOQ4EOIXz79p4cfdAhOd053mh67VK8e0cyG3Y/Yfa
	 wn6Z4jEpCQebU8T5o88qx8mbUEsT4aY33hvPwucGJBxdMSb9Wouu891OLHoTUdRM/QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319486;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=i3BnkwwX1QpJuZSXpGnT1o2/p8maiFIvIlJFgd8ousU=;
	b=0ZBwK/bditIvjGJ7OgSs502h/yV/xhtqNsULRZEEUpcAKUMmB0POXIxbFhJuexLA0oXx
	 aaiLa0+Jf/wqIUT4CBr5lEiqDUXbXZ7TsJhYEifGaM8D5W7BXTltsDlURmGB7OTxBhzYn
	 oyqoftahnQNpRCqlFuT7lnW+/NeKnNwGDfOVNEy+925GMIUQtmokw7odvnfSS2BJhRCQ8
	 7HJIbCl7bGrIOjP9ngbsx8u8+8YCiHp8hKDWsPAcGwb09kUeiCaXjwRf85yuYj+Pas9VL
	 UuMh9PEdIRq+brPP26FwQOfTDsSAaMLBRkbBqmHb/pNaQdMJyUskWO+p8lz8LeFUp1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="dv/Ghu2h";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CA0606A32A;
	Tue, 10 Nov 2026 14:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71CA0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dv/Ghu2h
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B314F143D;
	Tue, 10 Nov 2026 06:04:41 -0800 (PST)
Received: from [10.57.10.132] (unknown [10.57.10.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51853F632;
	Tue, 10 Nov 2026 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794319484; bh=BlHcBR7XX57WikFwdYmvtykbeUsCkBngls9+R/yKh6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dv/Ghu2hcXhyZsdzum0Qj+KYMSpRnrdxXFCaVwePrPvToPowei/9jMA30yVCil2dK
	 49YFj+/dj03TnWCuz3fzCHb54refDhICi9kVBS42rqgHZdXMjO3Vmh92IDnY4sG6/s
	 sg7dxeAcKd5AvJ2pG41DCd3as0OkbuWM47N62woc=
Message-ID: <bb99aa3f-fd15-4bdd-9319-ccedffc281c8@arm.com>
Date: Tue, 10 Nov 2026 14:05:16 +0000
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
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Guo Chen <guo.chen@oss.qualcomm.com>,
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
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iX8wYDUo9uUjkqkKq1tpLAu7iaZk+iQzWGigNAqfrsNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> [snip]
>>
>>
>>>>
>>>> That's fine, please continue.
>>>
>>> I have a couple of questions though.
>>>
>>> First, why is the ondemand governor mentioned in the changelog?  In
>>> the mainline, the ondemand governor cannot work with EAS, so it
>>> shouldn't matter for this issue, should it?
>>
>> The ondemand is affected by the EM setup code and set 'inefficient'
>> flags for some OPPs. The EM is also present for cooling devices
>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>
>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>> In the EM code we have:
>> cpufreq_table_set_inefficient(policy, table[i].frequency);
> 
> So maybe this is the one that needs to be fixed?  What about simply
> skipping boost frequencies in it?
> 
>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>> pass to __cpufreq_driver_target() with that flags as well.
> 
> Thanks for explaining and all of that needs to be said in the patch changelog.
> 
>>>
>>> Second, why is the issue regarded as a defect in the code and not in
>>> the energy model?  Arguably, boost frequencies should be more costly
>>> than the non-boost ones.  At least the idea behind the boost is making
>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>> treating them as boost OPPs is rather pointless.
>>
>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>> It is affecting more than just EAS or EM, since the EM is working with
>> all generic code and all cpufreq governors.
> 
> To be precise, the EM initialization may affect cpufreq in general
> because inefficient frequencies are used for CPU cooling.  Fair
> enough, but I'm not talking about this.
> 
> I'm talking about a reason for giving boost frequencies lower or equal
> cost relative to non-boost frequencies in the energy model because
> this doesn't make sense to me TBH.
> 
> And I get that such energy models were there before the commit in
> question and now they are not working properly, but IMO they are
> broken, not that commit.
> 
>>>
>>> TBH, I'm too comfortable with looking at cpufreq frequency from within
>>> the EM code.  If that needs to be done, something is amiss at the
>>> design level.
>>
>> I think this edge case is special, as I described above.
>>
>> I'm happy to hear your view on this EM influence to some global
>> setting in cpufreq. Maybe it was too far to establish this
>> 'inefficiency' flags in there for many usage?
> 
> There's nothing wrong with using the information from the energy
> model, when available, to amend cpufreq, but the patch goes the other
> way around: It tries to amend the energy model with information taken
> from cpufreq (in order to avoid making mistakes later when amending
> cpufreq with the energy model information).
> 
> I think that cpufreq should simply refuse to set
> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?

I see your point now, about the direction. Yes, you're right.

Since we are taking the information about 'boost' from the
cpufreq, then refusing to set OPPs inefficient in the first
place makes more sense.


