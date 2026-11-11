Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380262;
	b=mwZ3zZ/8SIZYItO5Q7ojCZNjDLrfXLDyS00ktQZuTngkwwiFBlAF2iBhi3eXYopQnhNW
	 uObIlrSspcETwR/m1atTpW/CBtg/TD7/GDyit+z+CKgSdhD+jFvh++p8AdsebBdLQZIrH
	 YmHZ5QofLKSdbDE8DeD/lSrbljym/dzwWNxRwz7o3j/Nfiku5WhXRHAJUHICBVTnDdhY0
	 k0oTPASbb2jC0+G7zYWBs2aOur46tgzwf8JsVGUhX01fyZ72v9Oa9seJ1SdbT0h3mTc3Y
	 3BChBvG+fZPsoOYk/iWImA1JVPam9m5ckGamFEmDajThf/ZklzdLF/qLHDEx2MiH/Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bORCzwP/EzjbftvRISTpV4GpT4mJpkqK0oNTCIloN1s=;
	b=hD8Mfvy8jTOijQMcf99b6zJ9Y+mETqvmoLql8V9t5GVzKnwYddygunrzqPyLdaX73Ntz
	 ZakeHHjWx7PE+xUP55PP9uo017kbQivK3qLKnZkxcLH7O3AHLp8LpCNj5zh+saew8HgQG
	 rh7PNsiGkdcsRvx1Dj7RU+tqcSIPJxeC4BVCzqxYRA6JSkAAq4wajZPiCt1sr7C5zBurD
	 Xx9196tgTMuAkB9/WH+U+73KsxEcsPnihPhogv+61DjlL984uJ/TiNhfTS5tbSOGsKNje
	 dIFTjjNRYYVIT4VQ4+77fHxirYQ8TMRZANMCTQChaGYl5n+vx8Ac3sSdiIsyOTJXcBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axXQ16DA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fsRYDQ6X;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7B60A261F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2E7B60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=axXQ16DA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fsRYDQ6X
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5LBtH1052930
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bORCzwP/EzjbftvRISTpV4GpT4mJpkqK0oNTCIloN1s=; b=axXQ16DA8WQV/U2s
	x9ZEvqdayTXPXdLznvqfpZoY2iO9ccV0Gfy4lLUkWz6iUe45A591S43RqhQPqZ3R
	grtFvA1DuHJ9Ma6u4d3ZTLdg2wngGwLaVX65z/BaYmBByy2b5esbQ2ojAfdcJrXF
	FjJhd4Ct0QEuRMvz8IOmwtrTYcYn6+fwikmPYIiHqVlEO04+3fI6USiv1hJHYcXQ
	ht2DkF2uW7wNfFoTkDoOlhmqfRj92/7nz8hn3vF10L0Uyv+cDswY3xomf4ArSsmu
	vZ0b91hL7Y6d0ecqxEfKWya/w9YLkM/insgJ7Fy1QObeY0bnr4pSZD0/o6u46InD
	LK5odQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh18s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:57:40 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8b5d8de9619so3575353b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794380259; x=1794985059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bORCzwP/EzjbftvRISTpV4GpT4mJpkqK0oNTCIloN1s=;
        b=fsRYDQ6XfaADkpH0BAu4o+G+96/vlz4HmIJuTTUcxnlSQi7PUQSBOb2nFmAvRCYqbv
         gi8+vTLUI+9f5gxGVhHeCWJJHMa+yQ13A/dMYuaZkTt30/uC3csGyXVtsySbnoifV29G
         eevRGs4Qd+eoEFFc0FuseiFdT0V7cU/4C4ChAqND+NhZLPw2D7HmwzGVJ/vnWE9qh0Oi
         3iiXLuVgZt5JA7VOJ+nUFKfhLfvHDzaO5OgXl2xYHu999xO6jhlKmPRucx9deda2RhEX
         zWlDZFu9C9Gx1MW3ZCnCFZq1IpmqLoIwXX4T/FLKY6ElWPsMq5rCI4Zix8MPExYP7nRe
         p2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380259; x=1794985059;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bORCzwP/EzjbftvRISTpV4GpT4mJpkqK0oNTCIloN1s=;
        b=bsaLr1h3AAajv0zuVHVdgYj6m7z0zDglPwgpt8PO3N9Rl6cvc3aOHTW1Pp/U14pKl4
         06xyeHvHvUE/kyc7oYQVAsFhYg42dZ4VAShWJbDZ7rBaG1/Sk1QU8ZqPT5bdRnGHa0CQ
         BnxRuyAngzCRGsef77dy0okDrXINuZlqD/jLBITuQngapiK4/5i6maYrI2XkK45brlti
         UPrl83763vRqQQho19AHUAT/Z0o1uXpk8qgdTKj+J5doOFNdvTJAf9T2H0ZWyqygB0fk
         Veg52nrq7TEqeGm5G4vsfJS468tTqLAdntHDmIsD8DaTsaYp2pePoYXFS6JpRLg/1WZa
         MXdg==
X-Forwarded-Encrypted: i=1; AL+hErFONdoHSiJf2/L+vEJr9bUyozNKJRCdldbZNNTfEWFW6Uw0KYXqrU+U65ccvjo5jV2t+IqFcIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H0gAPTxBhdJTTaUaKl83Ny/zYIkEIv1ogeq0jvf+rSFTLVSBV
	xj3l77jOBvZCF6IOpyFKYPM8HOYDprusjtv432THvN77utiMb1Q1CC09BJXPYRwhaF9GUkhGS5o
	2IzQWKqygZ3JPAx5UWg/XwLDOyDHbBmH4FJqsPi61v7jmdzUGGnq6zInxJ8A=
X-Gm-Gg: AYBFou1g+4LHUXZP+KaSg21AtHZVyzEEF7fXTTTzlzv5EasN120w9blsmvKbbXyhWDL
	BikTN4JJXZtljEfqopPAApOJS1cM2mO+7GrLI0uphjt2VbE9pf5f0PLJIswZZrMcHokRYexhejq
	lDFKcTn1eRHTtLkOttfEsfrs5qW6KGlrAlRJsgusZsjibVbZ3/WROtbw2yoK/NXB+ANGlpJ2X7g
	SADUxOfZKBKwNttqlCOstpp1mb/JyTLYRUU8BFFm1HSdg0J964MyE2AQ4sUpHyhZUYM8dgkLGNO
	XAvKBLjbYx/L+WFCvMhAzl6XUkDq3xLdrQPnR0ZrR0zF/V5+f8E7Qhnxn0p2ZFNaF3oriXVPdHG
	m2wrap2P8wqykbKDdKDv+oUJRUysraD9Mg0YskO7AZxKWBUi7j4c2E2mFd1SHQDnJvUVcRdc=
X-Received: by 2002:a05:6a00:4187:b0:8a0:3ed7:939f with SMTP id d2e1a72fcca58-8bc1bcd5240mr1595137b3a.30.1794380259242;
        Tue, 10 Nov 2026 22:57:39 -0800 (PST)
X-Received: by 2002:a05:6a00:4187:b0:8a0:3ed7:939f with SMTP id d2e1a72fcca58-8bc1bcd5240mr1595118b3a.30.1794380258747;
        Tue, 10 Nov 2026 22:57:38 -0800 (PST)
Received: from [10.64.69.121] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86e030sm1800660b3a.27.2026.11.10.22.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:57:38 -0800 (PST)
Message-ID: <58dbf12d-dae7-44c3-b7da-b65a4800c3b0@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:57:32 +0800
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
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>, Viresh Kumar
 <viresh.kumar@linaro.org>,
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
Content-Language: en-US
From: Guo Chen <guo.chen@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfX2py0JWLLCIAT
 9USevWA2kmvmZFb5a2bRMygm+Od5Kw+DMtiRr6uxSJbopvx9D5t9dEVfuCzt1QrrGKzkOnm1x6Q
 VHol87NXsZLsqe9fF+wped+vHk5Zi4s=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af411e4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=PXZ8zqEZW9EwPeroSyQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: G4uAyHuD9FAOeCfjC-vO_6x077Igh7Cf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfX4JYB4E+tlpy4
 4zxbJ46JzqeWjI9VxBIxahI5elCobLqdKeT4zpV9tA17IWJewwDIdvVv6TnrFR5YeeeFBeon99f
 j1ZWxl6ZNbdHx5w/VUQdVxneocuwBnR2BHavXLUSDE4YEutHNRwn/AgvFplWuJ0FT5Kft8HZwdM
 We83+NFRHIkYbx13UoFzisZ5ltPwzD22p4g6usq38QbuQ/sLqVgEzKuQ6LmDs+0Y9yJePLkPw12
 d8sis+GTzSZHvm9Rel6U5dq3jf2dYJzVUWK4hW5fy36wUrt6Iv9CBI0irDlyPiSWT7X4AVQGq29
 zWF94vWsmSVvFr8D9sCgxHdCkAlGhZjDZ05/BcDocIW8xnHDwVkmyE9wZ4U/xjp7oHVlM4hLvkE
 h25iPStr4ph2yVtCtE12wqFhUJWDSBFL/da5DfK0Y4MsZa7sFoZ7Nn7SGNL6ikVXUkVUERoLWTH
 aZvTjwc/Ijb1F6Gt5pw==
X-Proofpoint-ORIG-GUID: G4uAyHuD9FAOeCfjC-vO_6x077Igh7Cf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110027


On 11/10/2026 10:59 PM, Rafael J. Wysocki (Intel) wrote:
> On Tue, Nov 10, 2026 at 3:56 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
>> On 11/10/2026 10:05 PM, Lukasz Luba wrote:
>>>
>>> On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
>>>> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>> Hi Rafael,
>>>>>
>>>>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>>>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com>
>>>>>> wrote:
>>>>> [snip]
>>>>>
>>>>>
>>>>>>> That's fine, please continue.
>>>>>> I have a couple of questions though.
>>>>>>
>>>>>> First, why is the ondemand governor mentioned in the changelog?  In
>>>>>> the mainline, the ondemand governor cannot work with EAS, so it
>>>>>> shouldn't matter for this issue, should it?
>>>>> The ondemand is affected by the EM setup code and set 'inefficient'
>>>>> flags for some OPPs. The EM is also present for cooling devices
>>>>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>>>>
>>>>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>>>>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>>>>> In the EM code we have:
>>>>> cpufreq_table_set_inefficient(policy, table[i].frequency);
>>>> So maybe this is the one that needs to be fixed?  What about simply
>>>> skipping boost frequencies in it?
>>>>
>>>>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>>>>> pass to __cpufreq_driver_target() with that flags as well.
>>>> Thanks for explaining and all of that needs to be said in the patch
>>>> changelog.
>>>>
>>>>>> Second, why is the issue regarded as a defect in the code and not in
>>>>>> the energy model?  Arguably, boost frequencies should be more costly
>>>>>> than the non-boost ones.  At least the idea behind the boost is making
>>>>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>>>>> treating them as boost OPPs is rather pointless.
>>>>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>>>>> It is affecting more than just EAS or EM, since the EM is working with
>>>>> all generic code and all cpufreq governors.
>>>> To be precise, the EM initialization may affect cpufreq in general
>>>> because inefficient frequencies are used for CPU cooling.  Fair
>>>> enough, but I'm not talking about this.
>>>>
>>>> I'm talking about a reason for giving boost frequencies lower or equal
>>>> cost relative to non-boost frequencies in the energy model because
>>>> this doesn't make sense to me TBH.
>>>>
>>>> And I get that such energy models were there before the commit in
>>>> question and now they are not working properly, but IMO they are
>>>> broken, not that commit.
>>>>
>>>>>> TBH, I'm too comfortable with looking at cpufreq frequency from within
>>>>>> the EM code.  If that needs to be done, something is amiss at the
>>>>>> design level.
>>>>> I think this edge case is special, as I described above.
>>>>>
>>>>> I'm happy to hear your view on this EM influence to some global
>>>>> setting in cpufreq. Maybe it was too far to establish this
>>>>> 'inefficiency' flags in there for many usage?
>>>> There's nothing wrong with using the information from the energy
>>>> model, when available, to amend cpufreq, but the patch goes the other
>>>> way around: It tries to amend the energy model with information taken
>>>> from cpufreq (in order to avoid making mistakes later when amending
>>>> cpufreq with the energy model information).
>>>>
>>>> I think that cpufreq should simply refuse to set
>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?


Got your point. Having cpufreq directly refuse to set
CPUFREQ_INEFFICIENT_FREQ might be the simplest approach. Let me
summarize my understanding. There are two cases where we can
simply avoid setting the CPUFREQ_INEFFICIENT_FREQ flag:
1. boost frequencies.
2. the highest non-boost frequency.

However, there is another issue. If we refuse to set
CPUFREQ_INEFFICIENT_FREQ for certain frequencies, I think the
corresponding EM_PERF_STATE_INEFFICIENT flags in the Energy Model
also need to be updated. Otherwise, the EM state would be inconsistent
with the frequencies used for energy estimation in the EAS path.

I think we also need to update the EM_PERF_STATE_INEFFICIENT flags
accordingly, something like the following:

for (i = 0; i < pd->nr_perf_states; i++) {
     int ret;

     if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
         continue;

     /*Return -EOPNOTSUPP if the rejection condition is met. */
     ret = cpufreq_table_set_inefficient(policy, table[i].frequency);
     if (!ret)
         found++;
     else if (ret == -EOPNOTSUPP)
         table[i].flags &= ~EM_PERF_STATE_INEFFICIENT;
}

>>> I see your point now, about the direction. Yes, you're right.
>>>
>>> Since we are taking the information about 'boost' from the
>>> cpufreq, then refusing to set OPPs inefficient in the first
>>> place makes more sense.
>>>
>>>
>> I also agree this should be fixed in cpufreq rather than by feeding
>> cpufreq information into the EM. However, refusing
>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
>> example in the changelog, because the frequency marked as inefficient
>> there is 4.0 GHz, which is not a boost one. The problem is not specific
>> to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz boost OPP
>> at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, but if
>> policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
>> RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
>> should not skip an inefficient frequency when the next efficient
>> frequency above it is beyond the max limit, which can be done in
>> cpufreq_frequency_table_target() without touching the EM or looking at
>> boost flags.


@Zhongqiu: thanks for the example. I think the two cases are different in
nature.

In the case of the changelog, the highest non-boost frequency of cluster is
marked inefficient because of the boost frequency. A sustainable 
frequency is
being affected by an unsustainable one, but it is not really inefficient: I
don't think these two kinds of frequencies should be compared with each 
other
in terms of energy. So I think this should be fixed at the source, by not
marking such frequencies as inefficient.

The case you describe looks different, as it is dynamic: policy->max is
changed at runtime by scaling_max_freq, thermal or QoS, which would mean
ignoring the inefficient flag every time policy->max lands on an inefficient
frequency. Whether this is really necessary seems to me to deserve a
discussion. Thermal and QoS limits are there to keep the frequency from 
going
above the cap. In your example (3.9 GHz, 4.0 GHz, 4.1 GHz), if the 
frequency is
limited to 4.0 GHz at some point and ends up on 3.9 GHz because 4.0 GHz is
inefficient, the original purpose of the limit, not going above the cap, is
still honoured.

So I am not sure that handling the dynamic case is needed, and I would 
like to
hear what you, Rafael and Lukasz think about it.

Thanks,
Guo

> Good point.
