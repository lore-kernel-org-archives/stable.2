Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396262;
	b=MSb+fHzA9EmLUU9gMom4JweKXyhn086YTcy6WcpuW7ing+SKan3B/firFcRboaRgAiQM
	 u1SvIH6gH7KSl7xay5faKp9LA5bxHI8V7qpEs29EjptSI2CsiPuRB+SEsmo1c4O8E5gvW
	 LbKXAAwKeZ4mLPn+Zyv/ad72vTXIn3RGQOQGkNld22aW47OQOfzriF4x6iadWCjaYxE6Y
	 tTDOKBk3yGVq4QlnjWpDF1lomr2878uIJeL2gWPmEOWnkAZf110tRnEfAAtMOIP4xqM7Y
	 0KtKo6a3YRRZLtZGbvY+GTHTQLL5iWawEx8B6HwgRqlKzjfkO5bHXRpVtByVPnsCyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0BGsaxqGQ83uYxmvtGEO80x5k9YZgZjP7ShltYyXW7w=;
	b=x8sqdENxbuflMqx0rxD/mqjZOXPQrpGp7X1oKoLyL2vQYf//Y4Gygxw64shY+ePdpM0u
	 4tjsyFVx+Lv3nfZEt533krHBClP+ndPkhY7ByXv5WgqQ4AY3sBhEX/mj7gGByN22WMOZx
	 WaHZ+0ASP/0kg1Wka+//OGQCdwvUo5poGB7oZBHGWD56iQt489WD/uInFuAbz3OduVtuo
	 +xCtz1djNXSxlV5lQbxNJkjJAGRxdrDDOIo5bK+zHstUGGz4xX/4P3qjkV34BAtNGFwRs
	 JGtdsECUuihtkYJMm0xe9pVt1kg65UIFG+41wCyBB/jl6oeEXit3MUQ+47C+3S3LE5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BLnhe28P;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G6+x5tKf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238C606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4238C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BLnhe28P;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G6+x5tKf
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABBDICw1409621
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0BGsaxqGQ83uYxmvtGEO80x5k9YZgZjP7ShltYyXW7w=; b=BLnhe28P7wHn3n4Q
	zlv+jWimYkWSCjpPnfpEKCE8cNuB5CSneFtJMLRXSB6C5yqGtXCiyaaxXNR8iGIm
	mU++hLOS0IiLDHd3DZ4J6aJDV+gt/82x60viQhCX0TlNjHolXMY0zfmnrz7cQv7z
	0TPGZw7mjeTY512mpseLXodnlVYcbww17Xvybwm3wLA4ZSOO93OCV0J+KSCKb9vN
	1g7ri8t5JNMLTjAMacKlLf2/husKzM6mnOG3Yo/tSDnoqlO6dZqU7AnSaBlX3yfH
	uxpt84EMqHqhi1CLreP2uJv+KlnDR5MzCkPQno3+1uOkGaInrcEkrQrUdTV2wOxx
	h59aOQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdhkkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:24:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdba0aa55bcso1914110a12.3
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794396260; x=1795001060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BGsaxqGQ83uYxmvtGEO80x5k9YZgZjP7ShltYyXW7w=;
        b=G6+x5tKflBYwltqVUhk42R8dUm0hq+gRuY/6WbCzM04DrwJy48dkagp6EUAHkMRi4N
         vn9uYRr7ebgjI6r+oVEML6vjZOwBKsE6FuM/WrEN2fWSQ2e5rI30k0rWd8gi8ZwMKdWJ
         w07BsVF7maolUmtv6mxJGpdeAnobttmHtH3JMkk1XTOdKOIwQW8+gLkGOTMqDY4aIs01
         AxiUHXebHOohj+y8Tithco28uSEU1BvHg1pGT8+QvEBB+65LAZp9jI+pdTZbM02GVS9K
         wEg9elhYnD8ZttzV5LEOZqpnHktlJ6fIBgOqzA4QW3G0zfLO2K0PevEXUolZNTLMkQ5Z
         4k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396260; x=1795001060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BGsaxqGQ83uYxmvtGEO80x5k9YZgZjP7ShltYyXW7w=;
        b=kVkNP1oYakxmICoM1BCGfhgPCWBO0ChD18vttmf726qjq/7XuMuxaB3VGZ1A+bOUX1
         PP22wbIZalflg+KQSjo3edmCWQakdlR28LTKLj7LaOSiTYqfusN0R7/h271gwWjmNq7D
         +4vJH96iEMFdAr6zGlM0ibitchQWBVyxyCLT0yrTcpzoqLbqwdfnGfIpX3Zo+q//XHND
         qXPqtf1b6fL1ehXoaqV5py4ywwdURLEJX1mqQB/G/XBdbYAzTrOtoDANQS1cxV8fCdB/
         Uy92iMik9bLpWhIWdMDr17Q+pY8B2pN6w1oFUmC2pKxietHNcy5K8vEbNpVrkTfIpGqV
         W54Q==
X-Forwarded-Encrypted: i=1; AL+hErFMaCr33Tmx9Qh/hJ8F9InxMyXWj4Q0FrGXvZDC4AU2znOx0adVsx8kvu1Tb0TyZ8/8/NRXh9U=@vger.kernel.org
X-Gm-Message-State: APuU4Z88BejHlEEmFjqgR5McnwvufS3m9Ar1Ja1C7+9HpF9h/LF6QVWE
	uFG/s9mmBDzqTwTWW1whg1SsW1hx++b70vu22BD1VYjdCbnIx0Y5CFB0KgOlaPsJdXTnA+ftRwP
	6mGWyOz1H1Xr9FawySgLKgJbxXSs9gasBHFwQ9KEwpinVtTnfksn/9Kq/fi0=
X-Gm-Gg: AYBFou3JpyKmZJmRHCUX0ZFBvixdgk83BpQLTFxoB1UbrPcvBBYccvLv6hStHyXObQW
	pp+BDhXkJbNxDPF5kB2ad0dPmMCCyPL6XbWEosAc3eG+l8oTGX0jojV5bb1ROf6f8jVc7wPS8mx
	vOvJar+h5XsYl0WgdENT2YwLZMhAKdtUmcxnfLltZ82Ejy6alVB/FeYtFVUhoaqf8c03r4Y9NGj
	KYYnLtr8aUihPjngGHgeq7n2L6Bs0jaAKBckfn7g+o+5uLRC2ZxFCfsD/38u5nFd/WqWRrxYu/e
	rAfOjkRYBRqfNgZn8ZisJKVA0KAIIrvuuAD+AeSzy5NKQV6hqr7kIJOfwEFe8XzN0+ZAkhFxpFN
	Wh+KNY0lAz8regbqGP/eRx6yCzLP+sfF2vwHQBnPwxfvJ0AFRyMyzFb107GLxUkaNJ6ux++YOYi
	sLhIttPajyciELSlSqHpvDuDCyvNQaHgC5
X-Received: by 2002:a17:90b:37c3:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b18300a02emr2265344a91.55.1794396259464;
        Wed, 11 Nov 2026 03:24:19 -0800 (PST)
X-Received: by 2002:a17:90b:37c3:b0:3b0:c11a:9026 with SMTP id 98e67ed59e1d1-3b18300a02emr2265316a91.55.1794396258835;
        Wed, 11 Nov 2026 03:24:18 -0800 (PST)
Received: from [10.133.33.220] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1846d5684sm1343389a91.2.2026.11.11.03.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 03:24:18 -0800 (PST)
Message-ID: <f238e73f-6439-4849-b044-eed4242a1dfd@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:24:12 +0800
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
To: Lukasz Luba <lukasz.luba@arm.com>, Guo Chen <guo.chen@oss.qualcomm.com>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
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
 <ec04f795-6cc6-444a-bbee-70c7982932e3@oss.qualcomm.com>
 <CAJZ5v0js0pbcKRp-cNVu_aPstT4meF-u_z012Q-AA=pvvOY=qA@mail.gmail.com>
 <58dbf12d-dae7-44c3-b7da-b65a4800c3b0@oss.qualcomm.com>
 <cdfaaf7d-8b7a-46d4-bf40-e0dc5300eb08@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <cdfaaf7d-8b7a-46d4-bf40-e0dc5300eb08@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af45064 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=jD-XxpPmXfjaOs7YLlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: prn5lIr20dobgd2U3GOqzHceA5XplfEr
X-Proofpoint-GUID: prn5lIr20dobgd2U3GOqzHceA5XplfEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0NSBTYWx0ZWRfX4rMSLt+JkR92
 cYMbXnO7lvicbeuHZNK0rN75w1n6gdYODhMTgRSX2Vpfi9UvLXMqMtLKHj1z8GKlWaKgcaZYGwN
 sHvpf4PTzBfhaqSd8BlQYFAlA4bHgX380GbNgA9DuipPvnSVR1PfWyRyDFO5kR1qbqF0SFMRSEF
 g0KbU2f5CVqVDalMSPhFcixQO7XoIhJ7vP3HAACtxeHC4eA3Fjx8PrcMd4z023DFTkfYi8vXF90
 WGpIfrtU/sYiW6c/g1WtXJ5JQBGQtX0/tU2yaSTiW9WUuXmielY14y/iiEPDWPF1sIsMKhrz3w6
 nQ8FEpIdKkfJlgR3uiikqvR28KOlJCCx94slxu3/AipqqVrtd+ZG9HZlkuMg9TLN/h+xnPGf7W2
 8CPACSJ/jpsaOMgKtuhH7WS/IuSvTkGdgTjqqi48MEMixCzCNNwwLBpSj6OfFuYFUwt4Vgm5eYF
 wMFr+wVF3Xx1iHIO7og==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0NSBTYWx0ZWRfX6dUhBlkU/KzU
 870ybsolRwLjtjXH09bTHb2pSHk0bfiIiQ8texNpMh4n8xOkjuDGt6nHTAhfqQJR5zZiklMb8k3
 3EYeOrr5l+o4usHoNTpIa/ZAv0hND5s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110045

On 11/11/2026 5:31 PM, Lukasz Luba wrote:
> 
> 
> On 11/11/26 06:57, Guo Chen wrote:
>>
>> On 11/10/2026 10:59 PM, Rafael J. Wysocki (Intel) wrote:
>>> On Tue, Nov 10, 2026 at 3:56 PM Zhongqiu Han
>>> <zhongqiu.han@oss.qualcomm.com> wrote:
>>>> On 11/10/2026 10:05 PM, Lukasz Luba wrote:
>>>>>
>>>>> On 11/10/26 13:43, Rafael J. Wysocki (Intel) wrote:
>>>>>> On Tue, Nov 10, 2026 at 2:11 PM Lukasz Luba <lukasz.luba@arm.com> 
>>>>>> wrote:
>>>>>>> Hi Rafael,
>>>>>>>
>>>>>>> On 11/10/26 12:15, Rafael J. Wysocki (Intel) wrote:
>>>>>>>> On Tue, Nov 10, 2026 at 10:58 AM Lukasz Luba <lukasz.luba@arm.com>
>>>>>>>> wrote:
>>>>>>> [snip]
>>>>>>>
>>>>>>>
>>>>>>>>> That's fine, please continue.
>>>>>>>> I have a couple of questions though.
>>>>>>>>
>>>>>>>> First, why is the ondemand governor mentioned in the changelog?  In
>>>>>>>> the mainline, the ondemand governor cannot work with EAS, so it
>>>>>>>> shouldn't matter for this issue, should it?
>>>>>>> The ondemand is affected by the EM setup code and set 'inefficient'
>>>>>>> flags for some OPPs. The EM is also present for cooling devices
>>>>>>> and can work w/o EAS and schedutil, w/ just ondemand governor.
>>>>>>>
>>>>>>> Because EM marks the OPPs kind of 'globally' as inefficient, then
>>>>>>> they become CPUFREQ_INEFFICIENT_FREQ entries in the CPUfreq fwk.
>>>>>>> In the EM code we have:
>>>>>>> cpufreq_table_set_inefficient(policy, table[i].frequency);
>>>>>> So maybe this is the one that needs to be fixed?  What about simply
>>>>>> skipping boost frequencies in it?
>>>>>>
>>>>>>> Then ondemand check for CPUFREQ_RELATION_HE will skip them and
>>>>>>> pass to __cpufreq_driver_target() with that flags as well.
>>>>>> Thanks for explaining and all of that needs to be said in the patch
>>>>>> changelog.
>>>>>>
>>>>>>>> Second, why is the issue regarded as a defect in the code and 
>>>>>>>> not in
>>>>>>>> the energy model?  Arguably, boost frequencies should be more 
>>>>>>>> costly
>>>>>>>> than the non-boost ones.  At least the idea behind the boost is 
>>>>>>>> making
>>>>>>>> higher-cost OPPs temporarily available.  If they are sustainable,
>>>>>>>> treating them as boost OPPs is rather pointless.
>>>>>>> IMHO it was a bug in the commit mentioned in this patch fix tag.
>>>>>>> It is affecting more than just EAS or EM, since the EM is working 
>>>>>>> with
>>>>>>> all generic code and all cpufreq governors.
>>>>>> To be precise, the EM initialization may affect cpufreq in general
>>>>>> because inefficient frequencies are used for CPU cooling.  Fair
>>>>>> enough, but I'm not talking about this.
>>>>>>
>>>>>> I'm talking about a reason for giving boost frequencies lower or 
>>>>>> equal
>>>>>> cost relative to non-boost frequencies in the energy model because
>>>>>> this doesn't make sense to me TBH.
>>>>>>
>>>>>> And I get that such energy models were there before the commit in
>>>>>> question and now they are not working properly, but IMO they are
>>>>>> broken, not that commit.
>>>>>>
>>>>>>>> TBH, I'm too comfortable with looking at cpufreq frequency from 
>>>>>>>> within
>>>>>>>> the EM code.  If that needs to be done, something is amiss at the
>>>>>>>> design level.
>>>>>>> I think this edge case is special, as I described above.
>>>>>>>
>>>>>>> I'm happy to hear your view on this EM influence to some global
>>>>>>> setting in cpufreq. Maybe it was too far to establish this
>>>>>>> 'inefficiency' flags in there for many usage?
>>>>>> There's nothing wrong with using the information from the energy
>>>>>> model, when available, to amend cpufreq, but the patch goes the other
>>>>>> way around: It tries to amend the energy model with information taken
>>>>>> from cpufreq (in order to avoid making mistakes later when amending
>>>>>> cpufreq with the energy model information).
>>>>>>
>>>>>> I think that cpufreq should simply refuse to set
>>>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies.  Wouldn't that work?
>>
>>
>> Got your point. Having cpufreq directly refuse to set
>> CPUFREQ_INEFFICIENT_FREQ might be the simplest approach. Let me
>> summarize my understanding. There are two cases where we can
>> simply avoid setting the CPUFREQ_INEFFICIENT_FREQ flag:
>> 1. boost frequencies.
>> 2. the highest non-boost frequency.
>>
>> However, there is another issue. If we refuse to set
>> CPUFREQ_INEFFICIENT_FREQ for certain frequencies, I think the
>> corresponding EM_PERF_STATE_INEFFICIENT flags in the Energy Model
>> also need to be updated. Otherwise, the EM state would be inconsistent
>> with the frequencies used for energy estimation in the EAS path.
>>
>> I think we also need to update the EM_PERF_STATE_INEFFICIENT flags
>> accordingly, something like the following:
>>
>> for (i = 0; i < pd->nr_perf_states; i++) {
>>      int ret;
>>
>>      if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
>>          continue;
>>
>>      /*Return -EOPNOTSUPP if the rejection condition is met. */
>>      ret = cpufreq_table_set_inefficient(policy, table[i].frequency);
>>      if (!ret)
>>          found++;
>>      else if (ret == -EOPNOTSUPP)
>>          table[i].flags &= ~EM_PERF_STATE_INEFFICIENT;
>> }
>>
>>>>> I see your point now, about the direction. Yes, you're right.
>>>>>
>>>>> Since we are taking the information about 'boost' from the
>>>>> cpufreq, then refusing to set OPPs inefficient in the first
>>>>> place makes more sense.
>>>>>
>>>>>
>>>> I also agree this should be fixed in cpufreq rather than by feeding
>>>> cpufreq information into the EM. However, refusing
>>>> CPUFREQ_INEFFICIENT_FREQ for boost frequencies seems not help the
>>>> example in the changelog, because the frequency marked as inefficient
>>>> there is 4.0 GHz, which is not a boost one. The problem is not specific
>>>> to boost either: with 3.9 GHz, 4.0 GHz, 4.1 GHz and a 4.2 GHz boost OPP
>>>> at costs C - d, C, C and C + d, 4.0 GHz is rightly inefficient, but if
>>>> policy->max is capped at 4.0 GHz by scaling_max_freq, thermal or QoS,
>>>> RELATION_HE for 4.0 GHz still resolves to 3.9 GHz. I think the lookup
>>>> should not skip an inefficient frequency when the next efficient
>>>> frequency above it is beyond the max limit, which can be done in
>>>> cpufreq_frequency_table_target() without touching the EM or looking at
>>>> boost flags.
>>
>>
>> @Zhongqiu: thanks for the example. I think the two cases are different in
>> nature.
>>
>> In the case of the changelog, the highest non-boost frequency of 
>> cluster is
>> marked inefficient because of the boost frequency. A sustainable 
>> frequency is
>> being affected by an unsustainable one, but it is not really 
>> inefficient: I
>> don't think these two kinds of frequencies should be compared with 
>> each other
>> in terms of energy. So I think this should be fixed at the source, by not
>> marking such frequencies as inefficient.
>>
>> The case you describe looks different, as it is dynamic: policy->max is
>> changed at runtime by scaling_max_freq, thermal or QoS, which would mean
>> ignoring the inefficient flag every time policy->max lands on an 
>> inefficient
>> frequency. Whether this is really necessary seems to me to deserve a
>> discussion. Thermal and QoS limits are there to keep the frequency 
>> from going
>> above the cap. In your example (3.9 GHz, 4.0 GHz, 4.1 GHz), if the 
>> frequency is
>> limited to 4.0 GHz at some point and ends up on 3.9 GHz because 4.0 
>> GHz is
>> inefficient, the original purpose of the limit, not going above the 
>> cap, is
>> still honoured.

Hi Guo,

Boost can be switched on and off at runtime as well, so it is no less 
dynamic than thermal or QoS. And with boost off, 3.9 GHz does not go 
above the cap either, so if that were enough, the changelog case would 
not need fixing; in both cases the highest allowed frequency is never 
reached.

> 
> There are platforms which have ~20 OPPs and the difference is ~100MHz.
> Those at the top frequency they are inefficient but exist for this
> thermal purpose. The throttled frequency can be more stable and
> predictable in time, thus also capacity delivered to randomly
> scheduled tasks (which might be unfair if the freq gets lower
> by a lot and some latency sensitive task got a spin at the same time).
> Therefore, we do care by making each OPP (at least) available...

Agreed with Lukasz in this point.

> 
>>
>> So I am not sure that handling the dynamic case is needed, and I would 
>> like to
>> hear what you, Rafael and Lukasz think about it.
>>
> 
> This becomes even more convoluted now.
> 1. The only call to cpufreq_table_set_inefficient() is in the EM.
> 2. EM works with thermal and all governors, not only EAS and schedutil
> 3. CPUfreq fwk holds those 'inefficient' flags in generic, global way
> 4. Inefficient flags were introduces mainly for EAS, now impacts
>     non-EAS setup (as patch states 4.0GHz is valid but not reachable).
> 
> Here is an example from mainline DT platform. The goal was to avoid
> the frequencies which have the same voltage but lower freq, e.g.
> those from 200MHz to 700MHz and pick 800MHz instead.
> Same for 900MHz and 1200MHz.
> That was the main motivation back then and research we've made
> with a few platforms and EAS.
> 
>    freq MHz   opp-microvolt
>    2000       <1312500 1312500 1500000>
>    1900       <1262500 1262500 1500000>
>    1800       <1237500 1237500 1500000>
>    1700       <1250000 1250000 1500000>
>    1600       <1250000 1250000 1500000>
>    1500       <1100000 1100000 1500000>
>    1400       <1100000 1100000 1500000>
>    1300       <1100000 1100000 1500000>
>    1200       <1000000 1000000 1500000>
>    1100       <1000000 1000000 1500000>
>    1000       <1000000 1000000 1500000>
>    900        <1000000 1000000 1500000>
>    800        <900000 900000 1500000>
>    700        <900000 900000 1500000>
>    600        <900000 900000 1500000>
>    500        <900000 900000 1500000>
>    400        <900000 900000 1500000>
>    300        <900000 900000 1500000>
>    200        <900000 900000 1500000>
> 
> 
> 
> Therefore, I would suggest to tackle this is steps.
> 
> 1st, let's go ahead with this fix which is for mainly EM.
> The EM confuses the cpufreq and then the clients like ondemand, IMHO.
> This can go maybe into the stable kernels, since it's small.
> 
> 2nd, let's think about that 'boost' thing wider. There are
> already investigations how to handle correctly the CPU's capacity
> and to not confuse the task scheduler. This might create
> the right infrastructure.
> 

Hi Lukasz,

Thanks for the explanation and the DT example. Real platform data like
this is very helpful for this discussion.

May I know wouldn't it be better to handle this in cpufreq alone,
without changing the EM? The EM change may not help with thermal capping
in general: your DT example has no boost OPPs, and if policy->max is
capped at 1700 MHz, RELATION_HE for max seems to resolve to 1500 MHz, as
1600 and 1700 MHz are dominated by 1800 MHz.

When the target is at or above max, the highest frequency within the
limits is wanted. If it is marked inefficient, the frequency that
dominates it is above max and cannot be selected, so maybe it should
not be skipped. That would cover boost off, scaling_max_freq, thermal
and QoS, while targets below max are not affected.

Something like the below (compile-tested only). (Please  let me know
what you and Rafael and Guo think, or if I have overlooked anything if
you would like)

diff
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1077,6 +1077,7 @@ static inline int 
cpufreq_frequency_table_target(struct cpufreq_policy *policy,
  {
  	bool efficiencies = policy->efficiencies_available &&
  			    (relation & CPUFREQ_RELATION_E);
+	bool capped = false;
  	int idx;

  	/* cpufreq_table_index_unsorted() has no use for this flag anyway */
@@ -1085,6 +1086,16 @@ static inline int 
cpufreq_frequency_table_target(struct cpufreq_policy *policy,
  	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
  		return cpufreq_table_index_unsorted(policy, target_freq, min,
  						    max, relation);
+
+	/*
+	 * A target at or above @max asks for the highest frequency within the
+	 * limits. Whatever makes that frequency inefficient lies above @max and
+	 * cannot be selected, so inefficient frequencies must not be skipped.
+	 */
+	if (efficiencies && target_freq >= max) {
+		efficiencies = false;
+		capped = true;
+	}
  retry:
  	switch (relation) {
  	case CPUFREQ_RELATION_L:
@@ -1102,9 +1113,18 @@ static inline int 
cpufreq_frequency_table_target(struct cpufreq_policy *policy,
  	}

  	/* Limit frequency index to honor min and max */
-	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
-		efficiencies = false;
-		goto retry;
+	if (!cpufreq_is_in_limits(policy, min, max, idx)) {
+		/* Fall back to the regular lookup over efficient frequencies */
+		if (capped) {
+			capped = false;
+			efficiencies = true;
+			goto retry;
+		}
+
+		if (efficiencies) {
+			efficiencies = false;
+			goto retry;
+		}
  	}

  	return idx;



> 
> Side note:
> I personally don't like calling some frequencies 'boost', because
> such frequencies were there but not labeled that way and they were
> OK. In this example, 4.0GHz is non-boost freq, but 4.1GHz is 'boost'.
> At the same time 4.0GHz is 'inefficient', which can only happen
> when 4.1GHz has the same voltage. I have seen such platforms ~13years
> ago and the 'boost' flag wasn't needed to handle them properly.
> 
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
