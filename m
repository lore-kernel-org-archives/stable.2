Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206875;
	b=QeYSHBSRAA4xWF0uwGqqO+5sPqWtGFOgV3MpkPMK80JkxVV7t5jF7UbSdrBGloxO8vcA
	 ZtjmQTgpy7R5MCwORiWvkMaVayY531m36eTAZt7MruozembcR5jNH4CDPWJ9dmGRwMpGV
	 k8FuoQx39QVuKGEeRckzfkGvsCEav0xUvtjyWz9Spl6Cco2v0qHKMnOZ8OdLeYQxVtIqS
	 fNySKBOs4XomuY3vEM/QfwGPhOhAWVBB7Wa48lLUXI5SgZe+Gvp1tOwFmQg+WpYpK+mkE
	 cbMZkM8NGTPpQGAnmGTB+8rx0PN33Z4WW17/xaO1CaAiPe1891fvkM6Hkd56XfAcNZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206875;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iLuHEnofLXRagkivBUEutlqFNLXaK9y1FiyGQUmV64Q=;
	b=YgOGax+E/4TBBcRcHScEr1kaPaTsFDeRza7QirlqLJKFRLbj2B4hi270AJZ3DFU3r8dL
	 0QlWkraX2EAqZWB0vnYhQQmhzeMMyddPE2YaiH665NXvuZ0yJPLPLhDr3NRXFtpYmhDQr
	 Xd70Ycgx8ZmYu/7wDEsPkLcJf2ZpNCeW4D83q/uMUsqtIMcncwrR/lkjOVvsaSBZ4mFnr
	 WhbEziMMXXZ6nZWPjnlm79aD2qah/wQWqKx03ZUNdE088MLyvk82wsUjt6xlZWMoU8czf
	 jZfe6CZNsGbWkQ4Q3IT4YK1wC5XQqy9JKDeE5YFnvi6kxjW0pBtP9kDjd4Yin4qCR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+O9p15q;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZ3mVv1L;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF4606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25BF4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+O9p15q;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KZ3mVv1L
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96A4XN2540097
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 06:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iLuHEnofLXRagkivBUEutlqFNLXaK9y1FiyGQUmV64Q=; b=d+O9p15qzs6fgCYy
	ICqMQd1xHBVks6uFg4VJ9g4U2MuB0zw/pk0dtqlO/gGQgf4Yvd720TUdutxyLFyx
	bT4E2YrSgruGx7nbkzfGtXA8O8eQWt3c75q0FiEJf3wj3cOhr9u9c98qzFx617Dv
	mG1cEIjus0fUFMj8Y1jj2wsYxvoFGdwQI+wg7gwZpERbRnGqacCi9mTYA6MMPPbB
	09yffzPkJZOFLZXxvX8rjfUowwqqIWxkl7C1TTJxPjmXYDR+cl2B31YmmAq8TMz2
	IIXV2EWuuK2txnoZqQ/6aPEb+h+M9P05SZrj+Sye4s4BqnGxRbs+SegbgLM2OqLf
	a0DePA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6n28j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 06:47:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so485026eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794206872; x=1794811672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLuHEnofLXRagkivBUEutlqFNLXaK9y1FiyGQUmV64Q=;
        b=KZ3mVv1LDAIuwFwYRyr2nXNyWsAXZx499ZblnsxkCGGRQ5/0ys0wDcAaKgvHJr3+kp
         p1NJlnPIlTxBnIXWfJ8qa7qnn1wn7etsRIWb2pK8boR3nGlMUEfoWr3UbOrwf7KOPIDH
         0ZpOb1Ac6NcYAoOWBvNhDZUiJQjj/+E1mf/sNNmB7ohK/dkUxuHC+26Ia9NQ6hF31pa1
         AkeiNKe+3x79pC/SNQWRAz8Ag5eUWXjg/lJdmOrIuJlXGJYSatH5uh9nbFd1TFkOSJK5
         xOx3K02yR5HRBqkPihL8cIydHi4oAyjpPpyhZyFSRLMun+OuCdP/PScjYXyYC6GSvzl3
         nfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206872; x=1794811672;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLuHEnofLXRagkivBUEutlqFNLXaK9y1FiyGQUmV64Q=;
        b=eMn1gy5RWBNlxs+85yrm8vMV7wYMWcFeLPyabVlE4sTwwJQu9JVN8hgCFf5HrEvCmx
         May8by6KYO1uLqE6sHOjw5Cy5bC9ZFs2QkvGGTV+v+TxIQYBJZJ2JSl8uUNNSrKl+yxm
         p1p0WZGJG7Jgd7b6qgLmc24zRCN6LNS9kH8DiQYDbCgMkAa1lEiH1UWafLsJ+sy8xJ14
         OWacqJ1GsDbXIk2/YyMIrpGP7vJACo+jL2DdMbeYH0fF2XHipmoaS3NTmsTm8pB/PxLy
         zXf0jWK0I0vbBf9Rn3pNqIxoGyN3pFsWMFYsCyeZUX9K1nH8ITHmEBzYpiHYL18/NAsX
         27fA==
X-Forwarded-Encrypted: i=1; AL+hErFSrmvRE8uGpcim+dXpSImxHybakhHvXmua9gRHw6JTjEiv+2fYFftu6NSbcBh2BZTARD9i/jw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9LzO0W/MBBZUVgPCiL7LXhuJyZFctmt7MyqIjwVVDb/IPp013
	fVKx4PI2id429syZhtyYQzvxJG50i0r8YQY1h0EgnKPtEfCqxnYfnqmtEPc4tC2B1GJ4HZeCPOb
	JbN193EEDdWBJWmjskAoZLkaIBnacxwM/bzJPl7aqzjxT0AnsesCXPit0S8w=
X-Gm-Gg: AYBFou3++RAvcTlKxmSLMumebH1NBtRLN2zZeGmlq91aJ9XEeWmQvWwRUGbjNXkw3Px
	JAlRngxD5HetBL+zi7JBygCXTadFE3xFezw0TP/uvaH1p5RzIbGe7GQcBcSrp1p/08/A/9UnyXq
	T/ydwxOpK53GYkr46qgwLtvqbXUrZZ6kXbbJ2sYmfGhOR/sL3K6XM8N8rahvNracnn16VdaWZvK
	sh9NSXSeDPXffVvp39qf1wwxZwPfdipzJU39n3+KgtLSoE/nE82NB1bqbPeJQDGPgrCtMqCLomJ
	CpvtSnSBfE6YeTGMWmhKYQpKhtOgjfqoBhhrVInhSGT/GxFZtbbO5pE3qoWynPQyuetOOjXiTbF
	xYPMYeQuA6DEiWVpPK21subII+Vl8XvyC1zh+8EZsz8zHWzFXFNDruzN6+oKLFRS4emRMcLJ6cS
	pnXkYNKxq07U99O0mG6gs1FQ==
X-Received: by 2002:a05:7301:4288:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-37255475803mr6079545eec.13.1794206871723;
        Sun, 08 Nov 2026 22:47:51 -0800 (PST)
X-Received: by 2002:a05:7301:4288:b0:36a:12bb:7f8e with SMTP id 5a478bee46e88-37255475803mr6079500eec.13.1794206871064;
        Sun, 08 Nov 2026 22:47:51 -0800 (PST)
Received: from [10.110.22.78] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f444csm16133467eec.19.2026.11.08.22.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 22:47:50 -0800 (PST)
Message-ID: <3e7c3a82-6a99-4c2f-9568-2382ea77ba0e@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:47:44 +0800
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com
References: <20261103-em-rank-boost-separately-v2-1-5a13d1b38d37@oss.qualcomm.com>
 <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
Content-Language: en-US
From: Guo Chen <guo.chen@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0hy1D7anTe=CXNXZyMNSN_yHh5hOt6B0bEHTEONRJFMhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyNiBTYWx0ZWRfX4nMkGKWOlbE7
 LwOtMmuSjep0NoCYfxrWeId5hvuGuFlKAlwkTxy2s9k9VpT804xYGWEKs0FR8CqSwzNmJMJX3HD
 2XZtAFH28CFnUaq5klNi1smUfhJbz3hOQvRmFAF19PzXTRd36fCMYeggUTaXVgmxg3j4UbhxaEs
 /Bh7kaUjVX4ShNUZq2Kza1e1stQsXHrbaGEDzinhcDlfgW/ApcoVwmExTi4hNB9pbbqFIoAo9sn
 15R1kvetbe6MnJUjqREqVOWPNjVYDbNkl8xP2KzjijHu6e0Suxq4pnLIhvF1rzvF3j2aDbr8X78
 dfTa7XvGup/luuyVVHe3zFiwdcCxJw32bHquYVzYbFJYeqLr//sDebrHMzslsguVN8KNR2kHGXk
 o+97Q2VBEZQSf1K6icMrAF50tVz6/FiGFwcM+BSsuPLEB2b445C9g7gtSiyvgMzj1SlefxSZrGw
 4M0qmoeUflHNUhQZ5Zw==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6af16c98 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=YtL-TgVjTbUiixhTrx4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyNiBTYWx0ZWRfX0NxdRJGOEjWQ
 t2dyZ4FvFgR4+pJrPQKJXGzP3HGyJ80936ZN7d1aL6Szo1h5bjBIDnxTH4lsKsoq151CL7GnRA1
 Z8k5W8fxzFKbsnVu3ALBYAm9eOF9/vg=
X-Proofpoint-ORIG-GUID: X2e7zfwwNeUO-lKZ9I6yi5Kx0wtoax1m
X-Proofpoint-GUID: X2e7zfwwNeUO-lKZ9I6yi5Kx0wtoax1m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090026


On 11/6/2026 11:15 PM, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 3, 2026 at 12:21 PM Guo Chen <guo.chen@oss.qualcomm.com> wrote:
>> em_compute_costs() ranks all the frequencies of the table, boost ones
>> included. A non-boost frequency can be marked inefficient only because
>> a faster boost frequency has a lower or equal cost, e.g.
>>
>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>
>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
>> skipped by governors rounding down to efficient frequencies (e.g.
>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
>> the best selectable frequency. Several frequencies can be affected.
>>
>> Exclude the boost frequencies from the ranking in em_compute_costs() and
>> keep them all efficient, using the highest non-boost frequency of the
>> CPUFreq table, returned by the new helper
>> cpufreq_table_max_nonboost_freq(), as the boundary.
>>
>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
> Please see Sashiko's feedback regarding this patch
>
> https://sashiko.dev/#/patchset/20261103-em-rank-boost-separately-v2-1-5a13d1b38d37%40oss.qualcomm.com
>
> and tell me what you think about it.
>
> Thanks!

Thanks for the review.

I did consider this case. If no policy is found, max_nonboost stays 0 and
the new logic is bypassed, i.e. the ranking falls back to the old
behaviour, which looked like the least intrusive option. I also thought
about warning and returning an error, but most of the in-tree callers of
em_recalc_and_update() ignore the return value (e.g.
em_adjust_new_capacity() and exynos_asv_update_opps()), so the update would
just be dropped without anyone noticing.

>> ---
>> Changes in v2:
>> - Drop prev_boost and keep all boost states efficient by resetting
>>    prev_cost for them, as suggested by Lukasz. Boost states are no
>>    longer ranked against each other.
>> - Retitle the patch to match the new behaviour (was "Rank boost and
>>    non-boost frequencies separately") and reword the commit message.
>>
>> Link to v1: https://lore.kernel.org/all/20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com/
>> ---
>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>>   kernel/power/energy_model.c | 16 ++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index d3d0d9d02aa4..c93316141a11 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>>          return -EINVAL;
>>   }
>>
>> +static inline unsigned int
>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>> +{
>> +       struct cpufreq_frequency_table *pos;
>> +       unsigned int max = 0;
>> +
>> +       if (!policy->freq_table)
>> +               return 0;
>> +
>> +       /* The table may be unsorted, scan all of it for the highest one. */
>> +       cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>> +               if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
>> +                       max = pos->frequency;
>> +       }
>> +
>> +       return max;
>> +}
>> +
>>   static inline int parse_perf_domain(int cpu, const char *list_name,
>>                                      const char *cell_name,
>>                                      struct of_phandle_args *args)
>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
>>          return -EINVAL;
>>   }
>>
>> +static inline unsigned int
>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>> +{
>> +       return 0;
>> +}
>> +
>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
>>                                                       const char *cell_name, struct cpumask *cpumask,
>>                                                       struct of_phandle_args *pargs)
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d19a65461ae8..5b1d095fd376 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -255,15 +255,24 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>                              unsigned long flags)
>>   {
>>          unsigned long prev_cost = ULONG_MAX;
>> +       struct cpufreq_policy *policy;
>> +       unsigned int max_nonboost = 0;
>>          int i, ret;
>>
>>          /* This is needed only for CPUs and EAS skip other devices */
>>          if (!_is_cpu_device(dev))
>>                  return 0;
>>
>> +       policy = cpufreq_cpu_get(dev->id);
>> +       if (policy) {
>> +               max_nonboost = cpufreq_table_max_nonboost_freq(policy);
>> +               cpufreq_cpu_put(policy);
>> +       }
>> +

The lookup can be made more robust though: on the update paths dev->id may
be offline while other CPUs of the performance domain are online. In v3, if
dev->id has no policy and the performance domain already exists, I will use
an active CPU of the performance domain instead, as
em_cpufreq_update_efficiencies() does, and only warn and fall back to the
old behaviour if that fails as well.

I did not use the performance domain for every lookup because at
registration time dev->em_pd is not assigned yet (it is set after
em_create_perf_table() has returned):

policy = cpufreq_cpu_get(dev->id);
if (!policy && dev->em_pd) {
     cpu = cpumask_first_and(em_span_cpus(dev->em_pd), cpu_active_mask);
     if (cpu < nr_cpu_ids)
         policy = cpufreq_cpu_get(cpu);
}

if (policy) {
     max_nonboost = cpufreq_table_max_nonboost_freq(policy);
     cpufreq_cpu_put(policy);
  } else {
     dev_warn(dev, "EM: no CPUFreq policy, boost states are "
                         "not excluded from the ranking\n");
}

This makes it much less likely to miss the policy, but cannot rule it out:
the CPU can still go offline between picking it and calling
cpufreq_cpu_get(). em_cpufreq_update_efficiencies() has the same
limitation.

Would that work for you?

Thanks,
Guo

>>          /* Compute the cost of each performance state. */
>>          for (i = nr_states - 1; i >= 0; i--) {
>>                  unsigned long power_res, cost;
>> +               bool boost = max_nonboost && table[i].frequency > max_nonboost;
>>
>>                  if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>>                          ret = cb->get_cost(dev, table[i].frequency, &cost);
>> @@ -284,6 +293,13 @@ static int em_compute_costs(struct device *dev, struct em_perf_state *table,
>>                          table[i].flags = EM_PERF_STATE_INEFFICIENT;
>>                          dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
>>                                  table[i].frequency);
>> +               } else if (boost) {
>> +                       /*
>> +                        * Keep all boost states efficient. Resetting prev_cost
>> +                        * also keeps the highest non-boost state efficient,
>> +                        * then rank the rest on their own.
>> +                        */
>> +                       prev_cost = ULONG_MAX;
>>                  } else {
>>                          prev_cost = table[i].cost;
>>                  }
>>
>> ---
>> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
>> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> change-id: 20261029-em-rank-boost-separately-a7e7c7d78058
>>
>> Best regards,
>> --
>> Guo Chen <guo.chen@oss.qualcomm.com>
