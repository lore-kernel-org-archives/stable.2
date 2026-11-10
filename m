Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322567;
	b=rUPa7628yfROWioRf1xesGVc8K+lQBrgI0JGrVdobvCqmNhkKcLj6P7ZkIi9dHlt1EA0
	 n1DAoSKJ1QsjmNs018CbuMZtTPf4wnRYl9Vb2t9Nvw/shIKgeES6snmhotK9BF1AMUUVN
	 GWEvhJweWYcqzTWk0YxxSAwXbLF+VxAVG42utG0Z45o60+V/k5UAWfhzwh+BR6LsrObX5
	 a1gUIvVYQePkqcTncND3YonyeSLsNb5+Gs+TsWrCJBSePMW2bJiPaZgHE3ie68C3C5Yyu
	 lSh1naINwQogWTVmwRXXlHSUfTsYjFkXB9MjbBgSfHY8ghWjZuU3p6Lyjnz3MX5+evQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322567;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kBSuW3DJj66pWv9LhnTXClJVrp/4F7tizZPGCuZVtlU=;
	b=hvgPvotaDEt5B/7Ka24Aid0E7X5+fwzmyVQ68JOVzHc3IIXwDHKiT0uT27jcMUIehI3m
	 yHKro0Y8tcO3Fazz9w2Ti+JbJVqERfdUdsQtL+3wDVIXXSern+6hvWMFi2D5YYg7W5SjG
	 9qHjTXJz8cqPYGtZgMpofiHW6QkgEi9nUy9xp9g5kKlD9nCwlnaRmpttidl+9Nc2hs+nU
	 0Yp/lGJAifEqo/ZKBy15dxnrJujD0gh801k35WNcKAQRka8qxENa0UC6POHZ/TciQHKcf
	 EQaEuhMrw3x46Iz/aXZQeez3fhDERzqMr8SNMLF1fLXlxvzXhCC78IzZ1mCJaeVY2Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jvd4w0At;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a2WL5baf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ACA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1ACA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jvd4w0At;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a2WL5baf
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA5ut3216958
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kBSuW3DJj66pWv9LhnTXClJVrp/4F7tizZPGCuZVtlU=; b=jvd4w0AtVDDY6hFh
	LiVK7tYp/2YXmymDlxhtHlCyAZSSvjiSDUMVzU+wdQ3aCK2ybKFXB723eXzKst0B
	tn35EummHhkTZcAQy5muxTHja+2W4hJ7yowhKKcg3z3AabUBI9wUk9Cvw0mJ3UvS
	g+Itlk7ZqfFiJ64ebGHHBn82ZsLInb7A1L9E/c7d9mYi79qcnEhdtb2k0IPKCcGh
	12sdS27F1It1Y5PzY9dUcRE3Nt/FRO7etVJbSH2cxFnjFKS/PdXsNFAp1uejEG0C
	Ci3ZURyKJA//mdqp6mKHmO7H4vUZuwVYVhBAM88XTL7Gi8BUEhv2I88E9AK2JtV8
	Woc5VQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtda61w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:56:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b847ab3fd3so2796491b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794322564; x=1794927364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kBSuW3DJj66pWv9LhnTXClJVrp/4F7tizZPGCuZVtlU=;
        b=a2WL5bafQrNipdbZxvs/LTPTCmHGqm8LlkN5w2R+WHp/ZM42CbSJM7tQM9gKNfyeG4
         jlO4FIc6ES2X6YObIFs5f1CdYESIPLUxzMs6eABL2mBK2WVUAd4VhFIyEvRluIgxcmeV
         F1aWpUrP40lGTskPyp37lsydUZ0uZdfuriINAe5ZjQMmPv3vnFvxEJDj5vVpydryS7MN
         fmXD3/M7Iddsz5+HUeWwKVZchBvg0iicFcm1Mlc+YJrgJBtWJ/X7cASTzBfqxqnbxPQE
         io5jKDQejIOG5ut4K31vJRnRDuS16UusjVCExPOiE50D6lzlx5Rve226iNsngo/WX8r1
         1WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322564; x=1794927364;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBSuW3DJj66pWv9LhnTXClJVrp/4F7tizZPGCuZVtlU=;
        b=YwS//4zv1G0F19NsM27GNqVQffYRJPXFbO1XJUnJQz/9lM4RkxAF/4OKvhdAtzcWHC
         ylCVofbjigse6xNiQjYWz/sOAb+LkSHq3rQEy/yNgYBjvYHZSbL3R1+lK6Jhah4PfdRg
         ZMYi94M5GNEDQUow+m2w5JtGFR957ufCUJK0Ii9xdRIpSuBCxt+6AorhDBQbYOk5nzul
         VyOwO5i60YFO1Fj1skRu5ZOpg0E6saeul0bBKK+/6pHmruAe+uu/Uoeka7/MDoDKUGY1
         mPr8ShjE7c6KUFzypZOtmTv0sQFAKCUOXs9jNaQ1I/5igcDG2WPzA7VuSzwcHrfu33In
         z8tw==
X-Forwarded-Encrypted: i=1; AL+hErG7oJwTHmxADUYERKMmHK+QH64Hb+HfL08/T+La44CU70ETqiB2Rr5piaV2vDl9pSqM9299rLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zn2z+910bV7SXeLJJOPKTXOOrDvoZpEOmr4/Oe9Kl0//Z8wFr
	QX1bTcYRCAY0cB1s6satvkZYsKFNiqb25525AfJoCVvOsQJaF39naBPwmAzCpNv/jkdLVwduD8N
	Hs6T71BJ4cSpKCajJLY9uvQWpekRG+A/yUVUzcifPP7bV5FKFsl7+ADJtqEk=
X-Gm-Gg: AYBFou1T0xldpCmQ2InaFIPW8peXBjatEcALZOip9nPVWpz4e3+ReC7VbgdAlAbRnR3
	hMzTim9rhFggIBg34KZWOaWJaDtlKRGsJnQI5W3CwbH9sYL4ejtWg1ToXqfsReOYDhcq4WBdTlJ
	XAEZ6dgEfrMVpmVcIXm5Xhopj+jYvYsiJ0I4C3KtQVawPStDyhRhi+ur6wcT649NCp3B3mZfSOv
	DvYUW90l129LhAmAkt6iFFrMyoHnAepACUjAuC/ShOyaOB2FK1XjCALuj9oLOy+/k2Swi8yqts5
	E56bbwsQYEVl05wEd+u9UrWEh2M/eBdtX29Dv3Py6xqV7BKzcISy6BC9EQ6vj4q/WwiQ4hpGhF3
	UGzLlCdAaqevbrC5iSAHcK5T1CBDnM+OHnMh/MnqDmLx9amBQ2QCdluMAUX8VeRU1xq70ot/sah
	RNQQ8CUfwteSg8n5EO3m19lVzrg29JzxIi
X-Received: by 2002:a05:6a00:9289:b0:886:c8d1:632f with SMTP id d2e1a72fcca58-8ba87647402mr2915904b3a.42.1794322564299;
        Tue, 10 Nov 2026 06:56:04 -0800 (PST)
X-Received: by 2002:a05:6a00:9289:b0:886:c8d1:632f with SMTP id d2e1a72fcca58-8ba87647402mr2915863b3a.42.1794322563587;
        Tue, 10 Nov 2026 06:56:03 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa1b1bf1sm1005284b3a.12.2026.11.10.06.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:56:03 -0800 (PST)
Message-ID: <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 22:55:57 +0800
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Guo Chen <guo.chen@oss.qualcomm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        xin.liu@oss.qualcomm.com, aiqun.yu@oss.qualcomm.com,
        tengfei.fan@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <bb99aa3f-fd15-4bdd-9319-ccedffc281c8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mgbcjJ_tcV2VuDmDAMYCV7B1SpQ9afUu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1OSBTYWx0ZWRfX7hiO53BzSK/M
 Sk/PkzqSDwVB5bjbJMoGoUgj+//fm/7j8yF22lPj4VI9hZLRY0aXX0Dma1F9rMgOtddIhOodsIR
 osHzYJB4U8P721KAuyYYInM4inNe9XM=
X-Proofpoint-ORIG-GUID: mgbcjJ_tcV2VuDmDAMYCV7B1SpQ9afUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1OSBTYWx0ZWRfX5sClOR4zts3J
 iRrqCjFxo4r6lHxfIOlGCoGdRw/KW1/yG7vqZyM+I4dqO6D9RrUmsINQL5AVNxGsMbBobhtYUsm
 Q0XpQJEXBaU7YmXuqu9MzSfQVpKViP0LUFp3cLKMCbSqFs7taVBYVa8GH7GW+nE/znWWhzo1HnS
 QNK/Ve4nejyk1JP8mYK9smuerCSutpW1/N4rgXKvbdklmXGYeA4/2zHI1oARCdfcIC5qN2Edr/k
 KNH15i0TcyLadw5snY/qAuCh7hZUCUqFIfdPGc4AxCnQgdzIkFSYc3CFZ9LgoVvb1Vw5BNUFF4y
 Yj7tV/tYHRtjfcXotOyODXltB0XwcRY5kXjDSp3UAN0tLJDLdX8D+SpuJ6ED1HLotSm38o2qRhc
 y6FeKbCBERKZqWfkJyun7rxKJAUf0wMOCl/fm8dIqez2Ck9In8hBnz47oXLJbn0kG7sSOSvCzy7
 W9Ig7/AVD4iFJa0FNIA==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af33085 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=7CQSdrXTAAAA:8 a=rel-l89U2fr21mIbaAEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100059

On 11/10/2026 10:05 PM, Lukasz Luba wrote:
> 
> 
> On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
>> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Rafael,
>>>
>>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com> 
>>>> wrote:
>>>
>>> [snip]
>>>
>>>
>>>>>
>>>>> That's fine, please continue.
>>>>
>>>> I have a couple of questions though.
>>>>
>>>> First, why is the ondemand governor mentioned in the changelog?  In
>>>> the mainline, the ondemand governor cannot work with EAS, so it
>>>> shouldn't matter for this issue, should it?
>>>
>>> The ondemand is affected by the EM setup code and set 'inefficient'
>>> flags for some OPPs. The EM is also present for cooling devices
>>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>>
>>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>>> In the EM code we have:
>>> cpufreq_table_set_inefficient(policy, table[i].frequency);
>>
>> So maybe this is the one that needs to be fixed?  What about simply
>> skipping boost frequencies in it?
>>
>>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>>> pass to __cpufreq_driver_target() with that flags as well.
>>
>> Thanks for explaining and all of that needs to be said in the patch 
>> changelog.
>>
>>>>
>>>> Second, why is the issue regarded as a defect in the code and not in
>>>> the energy model?  Arguably, boost frequencies should be more costly
>>>> than the non-boost ones.  At least the idea behind the boost is making
>>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>>> treating them as boost OPPs is rather pointless.
>>>
>>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>>> It is affecting more than just EAS or EM, since the EM is working with
>>> all generic code and all cpufreq governors.
>>
>> To be precise, the EM initialization may affect cpufreq in general
>> because inefficient frequencies are used for CPU cooling.  Fair
>> enough, but I'm not talking about this.
>>
>> I'm talking about a reason for giving boost frequencies lower or equal
>> cost relative to non-boost frequencies in the energy model because
>> this doesn't make sense to me TBH.
>>
>> And I get that such energy models were there before the commit in
>> question and now they are not working properly, but IMO they are
>> broken, not that commit.
>>
>>>>
>>>> TBH, I'm too comfortable with looking at cpufreq frequency from within
>>>> the EM code.  If that needs to be done, something is amiss at the
>>>> design level.
>>>
>>> I think this edge case is special, as I described above.
>>>
>>> I'm happy to hear your view on this EM influence to some global
>>> setting in cpufreq. Maybe it was too far to establish this
>>> 'inefficiency' flags in there for many usage?
>>
>> There's nothing wrong with using the information from the energy
>> model, when available, to amend cpufreq, but the patch goes the other
>> way around: It tries to amend the energy model with information taken
>> from cpufreq (in order to avoid making mistakes later when amending
>> cpufreq with the energy model information).
>>
>> I think that cpufreq should simply refuse to set
>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?
> 
> I see your point now, about the direction. Yes, you're right.
> 
> Since we are taking the information about 'boost' from the
> cpufreq, then refusing to set OPPs inefficient in the first
> place makes more sense.
> 
> 

I also agree this should be fixed in cpufreq rather than by feeding
cpufreq information into the EM. However, refusing
CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
example in the changelog, because the frequency marked as inefficient
there is 4.0 GHz, which is not a boost one. The problem is not specific
to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz boost OPP
at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, but if
policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
should not skip an inefficient frequency when the next efficient
frequency above it is beyond the max limit, which can be done in
cpufreq_frequency_table_target() without touching the EM or looking at
boost flags.

> 


-- 
Thx and BRs,
Zhongqiu Han
