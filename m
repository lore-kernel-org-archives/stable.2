Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304198;
	b=FDK2DJTr7NLzwu1jSrnD/hSBO6/Jyq5EWfbN8uTHnSwdRhzklyjr0r+LGX1qzVKaVNGV
	 gdWk3TH9CmSWitwE7NXgm1xNaWX44DvVi+kg23FFjqO8Lg3n7hhefmtOqbM97JMBxRz5j
	 O5QBBq6j0/uLXzJnFGa5twNi4RnnWJo8vgCoDxDlWQSssSg2txFMfBStAY30HAybjesgR
	 1vrdl6WQlu6sXewg73+vXU0QlbuH6/huZLXB2W9lWca2ymYHqifO19pOeGAWE08B0Sjxj
	 obTJsCfTsQZ4IwX79JSOATdFa9YZV60W0UPcYioYOPyk9dM2liHUy+UmvMSYxlAmKxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304198;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
	b=NYRATdcGL8wMfxTN96M3hCEpuJXoLYVt4FlaUQucM4MSPuDhc2IIDj1NEWoQIA8rzQDO
	 PJZid2N4gjLQ49lSg3flIwmgXRfhZ04XtEH51Mrwcjk/12ZIYYDxGc/oYBEyjr5fJv03q
	 qK9M+u9ro5NnF2dNHeapUgfWZDnwJPVyGS9lyQ1bWJEJNzrp2rsYvysGlmINKmsm+DVQK
	 KjFuy5ZDhznGY6QjPurLn1MtpKearb7LRKVRr7H1i1q0yXZNH4LPXpEn2guJKil7qfzWi
	 Dj/NQEvD1mWFP6JDjwU2LBsvVCBLzj/zjoKd/2gyRvjm0RhPT7wapvie+XyqpNFP/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAglhyjb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kQJU5WK/";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF0606B9CD
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84DF0606B9CD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hAglhyjb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kQJU5WK/
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l4321155030
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=; b=hAglhyjbR2WEJdBt
	ZR/CDPRhVJaEv/OX6ZrMDlwlsULdY/DXOdvBHnZkXtwhKSv3dklvWzLTnu2ACsg6
	65IcBTegkXuw5IUm/10ODGX//18V+aD0nY4BZZE00ZR8/IhR+2IJZnA98FEFxVSZ
	PvXGwg3Ddyd475rgL5RLGfZsU63TCCo6hplmXWomFoqmIOtM1xQkcLHLvQzHnPR2
	tbDoDp9rKNcrTdcQ19EIa9ZkEs+dNVB4Udg/+9IYGJQ/I2qaYAuX6DD5HJfpovJd
	N8dgdP9ogQiYxjjrmjQe54PQLPRwyLh3Siv90Prcux8nc+oFASdQxYrbvkZxKANG
	LOTgHw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv49hta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:49:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1990946a12.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304196; x=1794908996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
        b=kQJU5WK/NhNnatNvjfbCzHj7+q6P3MarceXZ/X3gk3OvIdiKpUWVzG7F09hbePCMzi
         FLsST48oVaRi14lITk/RvIDfy5+P0Cyukzek4TJr+etAhr9ZBbbP/r/W+Vz4vjmn23Qj
         0ixF6GuuQiOYemCYDv8etnkZLsCxgUVdGk0eHXYBMshhB3/7FSyS/IYZ3glV7Tc3XLLJ
         BaEHkOJZN/xVNnYpUB/h1V0z5yT2HkPIey8+pXEf4GEnVx1HWVSKL7sT98fWBN7pQeMO
         vuBMf51Jn45Qn+INsoh7dys+GX22CgXhQDFigyc8jdiLYR0nr8U3DiTESIJKBHt/xlgS
         JfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304196; x=1794908996;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3y+sTdFUbt/uQljUyhxFdhCIKZlyrlBK5Yk/ISfLD0o=;
        b=x+NgF1g+RTtMvNrYhZ9xXIx8bM3H8oSzSktWvDnF2oT52lSJMjK131I7WGDrU5LHfk
         656UZ/md+USiEs1w3RkA6vcOUKPLC5r4JlAu8dqSzV5ud18QE83gdoZTXAYCUtS+vn3W
         StT+GTZWdzuA9zFI39/4RpMhB8/YoVAWIqYdjvYKTBrmz9DntrXyjf1Rkq6S61Ov46do
         DlcmkdZPh7W5ZzaqMxLm3GHnC+tLAfcWMK3sj/6bij67boD55joOzLvqyND809m/mKM4
         Ug1pOfFhkEruXbdSSBioBraaIO7IEpRN3XGxcyG+V5hmc/MEv2nvcPQHJBhNSQ8Pan3n
         CSyw==
X-Forwarded-Encrypted: i=1; AL+hErFSFT8IV1vbLN2PI/nV9XAUOcQMVdt5n5kTKaA33cL/A6zl/FGQMtSQNxGRLw7c9PkJACRW4J4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qvxUMkIjOF3fTGPhW72Q7CO7KzOdwgWHZg82KcaShszYQribw
	90Dt1h9zE2EaopOQkSU7S9UOXaacICydkcKNdG+l9mf9sVclKg7Z554kt9QiPR+dNrS7tl0kty/
	Lc2FjA0r73Q6ZKRNmNgbhgz1pa1v/Ac2QrwcarqLhxyy0X+g+fTSkJ/JbFIY=
X-Gm-Gg: AYBFou0+dFRHoaymLLj/J5fV5YxFbQeNRCODeYvs8G6bK3Yrnt7L0vmjchvDodawSfa
	WITO73RiMEgE/tdm6QARTCbIB4x1zv55ki+3odogQ19f01Qg9NsJc5GqefSU6GtJP65jrdCxH3F
	zHzKYBbkCTjosJeRpYemzgY1rFd5ceIKw6L240OOxWXSOjqfLYwFcS9yAh4/BOWvFIFNctvlRKq
	iI6jX4zHfbjwOROdc4eeLcl91Lp9xOpUOiQ3UGkd5dMJKsmCEGkDn5dbpiZireTuHVbaET429su
	xdaNQSX276yU0PROfp8dH1aNNDZRu/dNcG9EC5wLJ+HzfT4JJ736qMxyjhJdpEoOyj2MeTQ2NB/
	212WNpWSqPIF4diUGib9tMIv+7up+5ZtRn0AnD6mgl4FUpS2BZRQwpwD4GRcNGFDI/4zuU20=
X-Received: by 2002:a17:90b:4e86:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b166cb9a9emr2260509a91.1.1794304195857;
        Tue, 10 Nov 2026 01:49:55 -0800 (PST)
X-Received: by 2002:a17:90b:4e86:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b166cb9a9emr2260483a91.1.1794304195253;
        Tue, 10 Nov 2026 01:49:55 -0800 (PST)
Received: from [10.64.69.121] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676d83absm3212483a91.7.2026.11.10.01.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:49:54 -0800 (PST)
Message-ID: <901516c9-d1be-4918-840e-e3617f2a1782@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 17:49:47 +0800
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
To: Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
 <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
 <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
Content-Language: en-US
From: Guo Chen <guo.chen@oss.qualcomm.com>
In-Reply-To: <1dadcd02-19b0-482b-b16d-293430227c5c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX6anIuFBEqBdk
 d2kOShlyJXcBeo741i8snJPVMp1oLJ7QvqUn4KYNpYWdTLSvw3drNl8jcTVmMNR2DBZ4oOK8quC
 6m176KgmyIlAkt+MWvYLCt4flTqniL8=
X-Proofpoint-ORIG-GUID: 9wMa_FVCPVU1QpxKWlOOqu0CkEpzfwMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX0++VbrR4bixW
 KDrIXyPqQREBR71HS+BbWIMeDdWD6Di2KSWHl4ZdKYItVKTLaenefnfuLi/5dzeL3T+Qw/IDoyZ
 9QfpzYkm4HD3OlL3JxLdiiC4V9CxNSOhvHWYl5L2DRWbKxSUy9k8MIu3YBBCeaNd6nPYpw23JCs
 gSTMqcPtDGSlAZug0a6V1Ioc5iGl+fRSbBusxxSQWw3TPfDewCW9FayzOeRff2Hh8/RVFefuq4F
 5vI+vV7mVFehVbgIoF4rLQx9PMb6Y+aRMmWKCErc93hxv+5//+LoI8xqFyrWCpdMyyWsWx3/KXM
 BOVEDHugxBQhDUftolcLpiTWqLFs7b3uf6hpvCNfeXW1zfnFiTCEvM3vPaRUVcHZ11REFG0ZiRw
 ljzIJp27vl37d/cc/v4BcDcwxDumzBy9v6Gg2CfhDZuwipZHaMRGZ+Ld8yOEzIsG5GwnQ05IBaB
 ar5ar7xccW4YstDyVQA==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2e8c4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SYcPWxKpZSGen2qkHQYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 9wMa_FVCPVU1QpxKWlOOqu0CkEpzfwMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100039


On 11/9/2026 5:40 PM, Lukasz Luba wrote:
>
>
> On 11/9/26 06:47, Guo Chen wrote:
>>
>> On 11/6/2026 11:15 PM, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Nov 3, 2026 at 12:21 PM Guo Chen <guo.chen@oss.qualcomm.com> 
>>> wrote:
>>>> em_compute_costs() ranks all the frequencies of the table, boost ones
>>>> included. A non-boost frequency can be marked inefficient only because
>>>> a faster boost frequency has a lower or equal cost, e.g.
>>>>
>>>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>>>
>>>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
>>>> skipped by governors rounding down to efficient frequencies (e.g.
>>>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
>>>> the best selectable frequency. Several frequencies can be affected.
>>>>
>>>> Exclude the boost frequencies from the ranking in 
>>>> em_compute_costs() and
>>>> keep them all efficient, using the highest non-boost frequency of the
>>>> CPUFreq table, returned by the new helper
>>>> cpufreq_table_max_nonboost_freq(), as the boundary.
>>>>
>>>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
>>>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
>>> Please see Sashiko's feedback regarding this patch
>>>
>>> https://sashiko.dev/#/patchset/20261103-em-rank-boost-separately- 
>>> v2-1-5a13d1b38d37%40oss.qualcomm.com
>>>
>>> and tell me what you think about it.
>>>
>>> Thanks!
>>
>> Thanks for the review.
>>
>> I did consider this case. If no policy is found, max_nonboost stays 0 
>> and
>> the new logic is bypassed, i.e. the ranking falls back to the old
>> behaviour, which looked like the least intrusive option. I also thought
>> about warning and returning an error, but most of the in-tree callers of
>> em_recalc_and_update() ignore the return value (e.g.
>> em_adjust_new_capacity() and exynos_asv_update_opps()), so the update 
>> would
>> just be dropped without anyone noticing.
>>
>>>> ---
>>>> Changes in v2:
>>>> - Drop prev_boost and keep all boost states efficient by resetting
>>>>    prev_cost for them, as suggested by Lukasz. Boost states are no
>>>>    longer ranked against each other.
>>>> - Retitle the patch to match the new behaviour (was "Rank boost and
>>>>    non-boost frequencies separately") and reword the commit message.
>>>>
>>>> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost- 
>>>> separately-v1-1-238a6b2bb888@oss.qualcomm.com/
>>>> ---
>>>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>>>>   kernel/power/energy_model.c | 16 ++++++++++++++++
>>>>   2 files changed, 40 insertions(+)
>>>>
>>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>>> index d3d0d9d02aa4..c93316141a11 100644
>>>> --- a/include/linux/cpufreq.h
>>>> +++ b/include/linux/cpufreq.h
>>>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct 
>>>> cpufreq_policy *policy,
>>>>          return -EINVAL;
>>>>   }
>>>>
>>>> +static inline unsigned int
>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>> +{
>>>> +       struct cpufreq_frequency_table *pos;
>>>> +       unsigned int max = 0;
>>>> +
>>>> +       if (!policy->freq_table)
>>>> +               return 0;
>>>> +
>>>> +       /* The table may be unsorted, scan all of it for the 
>>>> highest one. */
>>>> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>>>> +               if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos- 
>>>> >frequency > max)
>>>> +                       max = pos->frequency;
>>>> +       }
>>>> +
>>>> +       return max;
>>>> +}
>>>> +
>>>>   static inline int parse_perf_domain(int cpu, const char *list_name,
>>>>                                      const char *cell_name,
>>>>                                      struct of_phandle_args *args)
>>>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct 
>>>> cpufreq_policy *policy,
>>>>          return -EINVAL;
>>>>   }
>>>>
>>>> +static inline unsigned int
>>>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>>>> +{
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, 
>>>> const char *list_name,
>>>>                                                       const char 
>>>> *cell_name, struct cpumask *cpumask,
>>>>                                                       struct 
>>>> of_phandle_args *pargs)
>>>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>>>> index d19a65461ae8..5b1d095fd376 100644
>>>> --- a/kernel/power/energy_model.c
>>>> +++ b/kernel/power/energy_model.c
>>>> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device 
>>>> *dev, struct em_perf_state *table,
>>>>                              unsigned long flags)
>>>>   {
>>>>          unsigned long prev_cost = ULONG_MAX;
>>>> +       struct cpufreq_policy *policy;
>>>> +       unsigned int max_nonboost = 0;
>>>>          int i, ret;
>>>>
>>>>          /* This is needed only for CPUs and EAS skip other devices */
>>>>          if (!_is_cpu_device(dev))
>>>>                  return 0;
>>>>
>>>> +       policy = cpufreq_cpu_get(dev->id);
>>>> +       if (policy) {
>>>> +               max_nonboost = 
>>>> cpufreq_table_max_nonboost_freq(policy);
>>>> +               cpufreq_cpu_put(policy);
>>>> +       }
>>>> +
>>
>> The lookup can be made more robust though: on the update paths 
>> dev->id may
>> be offline while other CPUs of the performance domain are online. In 
>> v3, if
>> dev->id has no policy and the performance domain already exists, I 
>> will use
>> an active CPU of the performance domain instead, as
>> em_cpufreq_update_efficiencies() does, and only warn and fall back to 
>> the
>> old behaviour if that fails as well.
>>
>> I did not use the performance domain for every lookup because at
>> registration time dev->em_pd is not assigned yet (it is set after
>> em_create_perf_table() has returned):
>>
>> policy = cpufreq_cpu_get(dev->id);
>> if (!policy && dev->em_pd) {
>>      cpu = cpumask_first_and(em_span_cpus(dev->em_pd), cpu_active_mask);
>>      if (cpu < nr_cpu_ids)
>>          policy = cpufreq_cpu_get(cpu);
>> }
>>
>> if (policy) {
>>      max_nonboost = cpufreq_table_max_nonboost_freq(policy);
>>      cpufreq_cpu_put(policy);
>>   } else {
>>      dev_warn(dev, "EM: no CPUFreq policy, boost states are "
>>                          "not excluded from the ranking\n");
>> }
>>
>> This makes it much less likely to miss the policy, but cannot rule it 
>> out:
>> the CPU can still go offline between picking it and calling
>> cpufreq_cpu_get(). em_cpufreq_update_efficiencies() has the same
>> limitation.
>>
>> Would that work for you?
> I also thought about that possible racy corner case, where
> CPU can go offline (or already be offline). Although, in current
> usage this should be OK, since we do this in boot phase and
> platforms are sane.
>
> We can can add that step with 'cpu_active_mask' to play safe,
> but no hard promises it would be atomic.
>
> The warning also would help, for bring-up phase, so engineers would
> notice it and address the racy hot-plug booting system when it's there.

Thanks Lukasz,

I’ll add the 'cpu_active_mask' check and the warning in v3. As the
overall approach is unchanged, I’ll keep your reviewed-by.
Please let me know if you’d rather have it removed.

Thanks,
Guo

