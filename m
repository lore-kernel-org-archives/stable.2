Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304710;
	b=s07W9dPCRVc3RfwWKFDjkhL1y24nU8jRf5MrzX0PBTaz1YwDoY0aTu2kMLF9i4FdDCTC
	 ugec+T++aI4eOnOEQ1RZRGaVcgU8JMZiXs8nHU5Q9x0svqYDdf7jvCLCAGIgYNyReIS30
	 b8TZhmHzjpYkbplztznoytyW3Y+D9Z5ujzxa97fhJsIXV1xf2twnc4WuGlUckz5PuLn/y
	 3p9A/s3ai/o4ZxvusbnV4EeDY2raocsgzPPkse8l9hzPaGYeq8vYNLZ0KXjHay/9RgWsD
	 iExwtb34R0HBYNJwFRzn5R4wI790M1wYjfDNoMs8VQwRHAdgThrqt56Z4nVUoXXJGLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304710;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aKWtMimAzs9FtFLNAxoB9LpXG09KeXXS7v1Lqn6/z0c=;
	b=YQvfwHiPKkwcohR6m9szJoUznKwUHs6NDH773gM9imRmj7FVtCyf8ROkMD9O29uLomte
	 9JA60x34+iqHv+q4JeG9sqkNVfHeGMgPFyAE1QMub1U8bntLghJEm8yMq7CInSwIwnFeK
	 gb6tu0WaVNs+rkw4MUggE2rHrlJixIgiQY2AcHFUROZZnyD/aYULJEp17WdrZfDHUGF/G
	 ftlTPCCX0Znu5B5L5VJ8ipJUiGSUDr9OYHM3jjLnUgXNT717fBxiRp5id5BbZUrmiqozA
	 /K/0TxHajtLhOTGxNGe8eQUE0lBMevPfrhAKu5vitf/1zjOa/hg2vvZFUcbXRBEC5zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LyTjt6KP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579D60A3824;
	Tue, 10 Nov 2026 09:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2579D60A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=LyTjt6KP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247FB1F02;
	Tue, 10 Nov 2026 01:58:25 -0800 (PST)
Received: from [10.57.10.132] (unknown [10.57.10.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838663F632;
	Tue, 10 Nov 2026 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794304708; bh=OaSSUQ5bjaPlPJgtFjZgGOlZ6nsuLWkgpygjRXS19rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LyTjt6KPKYpVruT5LpmqMU9EEUTtg3VIZAp9Cs4wi1EyysJnb+//1Kd+fdLpajyfT
	 3pvEOD/LBNPpMlhQwf53+T6vlSv4TiEkpSpPTH1bbmWVsSa8g8x+3nswLd1etgKdK9
	 fszQY5e4Ej4XdXajga/AOWVG+FP0Pw2pjXxINXkg=
Message-ID: <6b0ee061-38b9-413e-9a83-90446b484859@arm.com>
Date: Tue, 10 Nov 2026 09:58:58 +0000
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
To: Guo Chen <guo.chen@oss.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Vincent Donnefort <vincent.donnefort@arm.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
 tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
 <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/26 09:49, Guo Chen wrote:
> 
> On 11/9/2026 5:40 PM, Lukasz Luba wrote:
>>
>>
>> On 11/9/26 06:47, Guo Chen wrote:
>>>
>>> On 11/6/2026 11:15 PM, Rafael J. Wysocki (Intel) wrote:
>>>> On Tue, Nov 3, 2026 at 12:21 PM Guo Chen <guo.chen@oss.qualcomm.com> 
>>>> wrote:
>>>>> em_compute_costs() ranks all the frequencies of the table, boost ones
>>>>> included. A non-boost frequency can be marked inefficient only because
>>>>> a faster boost frequency has a lower or equal cost, e.g.
>>>>>
>>>>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>>>>
>>>>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
>>>>> skipped by governors rounding down to efficient frequencies (e.g.
>>>>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
>>>>> the best selectable frequency. Several frequencies can be affected.
>>>>>
>>>>> Exclude the boost frequencies from the ranking in 
>>>>> em_compute_costs() and
>>>>> keep them all efficient, using the highest non-boost frequency of the
>>>>> CPUFreq table, returned by the new helper
>>>>> cpufreq_table_max_nonboost_freq(), as the boundary.
>>>>>
>>>>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
>>>>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
>>>> Please see Sashiko's feedback regarding this patch
>>>>
>>>> https://sashiko.dev/#/patchset/20261103-em-rank-boost-separately- 
>>>> v2-1-5a13d1b38d37%40oss.qualcomm.com
>>>>
>>>> and tell me what you think about it.
>>>>
>>>> Thanks!
>>>
>>> Thanks for the review.
>>>
>>> I did consider this case. If no policy is found, max_nonboost stays 0 
>>> and
>>> the new logic is bypassed, i.e. the ranking falls back to the old
>>> behaviour, which looked like the least intrusive option. I also thought
>>> about warning and returning an error, but most of the in-tree callers of
>>> em_recalc_and_update() ignore the return value (e.g.
>>> em_adjust_new_capacity() and exynos_asv_update_opps()), so the update 
>>> would
>>> just be dropped without anyone noticing.
>>>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Drop prev_boost and keep all boost states efficient by resetting
>>>>>    prev_cost for them, as suggested by Lukasz. Boost states are no
>>>>>    longer ranked against each other.
>>>>> - Retitle the patch to match the new behaviour (was "Rank boost and
>>>>>    non-boost frequencies separately") and reword the commit message.
>>>>>
>>>>> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost- 
>>>>> separately-v1-1-238a6b2bb888@oss.qualcomm.com/
>>>>> ---
>>>>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>>>>>   kernel/power/energy_model.c | 16 ++++++++++++++++
>>>>>   2 files changed, 40 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>>>> index d3d0d9d02aa4..c93316141a11 100644
>>>>> --- a/include/linux/cpufreq.h
>>>>> +++ b/include/linux/cpufreq.h
>>>>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct 
>>>>> cpufreq_policy *policy,
>>>>>          return -EINVAL;
>>>>>   }
>>>>>
>>>>> +static inline unsigned int
>>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +       struct cpufreq_frequency_table *pos;
>>>>> +       unsigned int max = 0;
>>>>> +
>>>>> +       if (!policy->freq_table)
>>>>> +               return 0;
>>>>> +
>>>>> +       /* The table may be unsorted, scan all of it for the 
>>>>> highest one. */
>>>>> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>>>>> +               if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos- 
>>>>> >frequency > max)
>>>>> +                       max = pos->frequency;
>>>>> +       }
>>>>> +
>>>>> +       return max;
>>>>> +}
>>>>> +
>>>>>   static inline int parse_perf_domain(int cpu, const char *list_name,
>>>>>                                      const char *cell_name,
>>>>>                                      struct of_phandle_args *args)
>>>>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct 
>>>>> cpufreq_policy *policy,
>>>>>          return -EINVAL;
>>>>>   }
>>>>>
>>>>> +static inline unsigned int
>>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>>> +{
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, 
>>>>> const char *list_name,
>>>>>                                                       const char 
>>>>> *cell_name, struct cpumask *cpumask,
>>>>>                                                       struct 
>>>>> of_phandle_args *pargs)
>>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>>> index d19a65461ae8..5b1d095fd376 100644
>>>>> --- a/kernel/power/energy_model.c
>>>>> +++ b/kernel/power/energy_model.c
>>>>> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device 
>>>>> *dev, struct em_perf_state *table,
>>>>>                              unsigned long flags)
>>>>>   {
>>>>>          unsigned long prev_cost = ULONG_MAX;
>>>>> +       struct cpufreq_policy *policy;
>>>>> +       unsigned int max_nonboost = 0;
>>>>>          int i, ret;
>>>>>
>>>>>          /* This is needed only for CPUs and EAS skip other devices */
>>>>>          if (!_is_cpu_device(dev))
>>>>>                  return 0;
>>>>>
>>>>> +       policy = cpufreq_cpu_get(dev->id);
>>>>> +       if (policy) {
>>>>> +               max_nonboost = 
>>>>> cpufreq_table_max_nonboost_freq(policy);
>>>>> +               cpufreq_cpu_put(policy);
>>>>> +       }
>>>>> +
>>>
>>> The lookup can be made more robust though: on the update paths dev- 
>>> >id may
>>> be offline while other CPUs of the performance domain are online. In 
>>> v3, if
>>> dev->id has no policy and the performance domain already exists, I 
>>> will use
>>> an active CPU of the performance domain instead, as
>>> em_cpufreq_update_efficiencies() does, and only warn and fall back to 
>>> the
>>> old behaviour if that fails as well.
>>>
>>> I did not use the performance domain for every lookup because at
>>> registration time dev->em_pd is not assigned yet (it is set after
>>> em_create_perf_table() has returned):
>>>
>>> policy = cpufreq_cpu_get(dev->id);
>>> if (!policy && dev->em_pd) {
>>>      cpu = cpumask_first_and(em_span_cpus(dev->em_pd), cpu_active_mask);
>>>      if (cpu < nr_cpu_ids)
>>>          policy = cpufreq_cpu_get(cpu);
>>> }
>>>
>>> if (policy) {
>>>      max_nonboost = cpufreq_table_max_nonboost_freq(policy);
>>>      cpufreq_cpu_put(policy);
>>>   } else {
>>>      dev_warn(dev, "EM: no CPUFreq policy, boost states are "
>>>                          "not excluded from the ranking\n");
>>> }
>>>
>>> This makes it much less likely to miss the policy, but cannot rule it 
>>> out:
>>> the CPU can still go offline between picking it and calling
>>> cpufreq_cpu_get(). em_cpufreq_update_efficiencies() has the same
>>> limitation.
>>>
>>> Would that work for you?
>> I also thought about that possible racy corner case, where
>> CPU can go offline (or already be offline). Although, in current
>> usage this should be OK, since we do this in boot phase and
>> platforms are sane.
>>
>> We can can add that step with 'cpu_active_mask' to play safe,
>> but no hard promises it would be atomic.
>>
>> The warning also would help, for bring-up phase, so engineers would
>> notice it and address the racy hot-plug booting system when it's there.
> 
> Thanks Lukasz,
> 
> I’ll add the 'cpu_active_mask' check and the warning in v3. As the
> overall approach is unchanged, I’ll keep your reviewed-by.
> Please let me know if you’d rather have it removed.

That's fine, please continue.

