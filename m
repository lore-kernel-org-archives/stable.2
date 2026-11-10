Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280186;
	b=ihQmabVJuH/E91egW0MqnmWzfm4UD7ZMKzE+hokYtx7c/ULtoxFCgNKwYQR2rYDfiAAw
	 QYMrheTCAONZwp6suJ8M6COOww4CuiMqud78VIvVGrDGS7e15BnRslVC105Uj89NJxBJF
	 2y8e6lLgcAxMKC9Z1wI4tVa8AbLIlxwcTlAismPYQNr6skc7KyJlhbpptUlJmcCO/bVsX
	 91VZkJnQ0U+RNLv+Mamv6Av2AZNqYNh3AHZCOTvZM4U2HZsks1AKErOflf00VMl3e40u6
	 H3uh69wN9lGvYkG8gBWx2gpxTxMFC/qfxj1OF0ebYf621isBsJhXHv/r7+hJVY64LQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280186;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PTsL5cLPUSLTpnCZzOaJvncyh24f9pvYBOUtBZUjJ0U=;
	b=tFoS/4wS7m+e7NhAWOAUNb9QD38+krGAVWw+mom/tlbWDGXHb4hQUPIdMGSageR1D6Ut
	 GAa1RhbF3WygCJNlyGkThOMkr8W81i+rKfFFjm5OzeNmKx9QiZhVuZmAaPBASFvot+rbw
	 Jy4zfkotu/YvGGRW1vzd6uOAvPmHW1yxHI/6Do9QRgxb1TVJ7RJj2NmZ+udTDtZd4q2z5
	 x0Db4qVWXgKhN7wyrpT8ZzhlS7szT6+G4J9iqkl8q05ktmuOGkGLpSp6u7Xnbu3iG4MDI
	 qBUsGDmEHKsLQb4YhajEsWFOouJyJozFZjcDpdWCjpCRjF1oP3Z5RNcFhzTJAHzVcTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZvrvHhQe;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a8O2rKiU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFE606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZvrvHhQe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a8O2rKiU
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0irwI887512
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PTsL5cLPUSLTpnCZzOaJvncyh24f9pvYBOUtBZUjJ0U=; b=ZvrvHhQe2GQLOtJp
	cNm7eI4cj1LPIcaaVarLlrCQjCNAJwZpuOtC1PdwJrDn2XZcSs0tJ2/YnsnaPCxQ
	wJYiK2xWMnwzI0my/vtr6TiNuPo4tnPyutg9+TlEd4GOo9V1ENlCivhxWLp6qzBa
	gMVD9RfukottPjPnWNH0//8KbElm3lQRIzajHVQve89lhy7dI74roywm2NULlF4c
	AVLUjERbm0Cnh1j/38+Rf9zAeZIq/GZqKl3EX+EPfFRXq+KxaubGxONs1aECALCl
	ubULb1uUhiMaKrezzlkiW8kPgjUOnmREE1E+h4JzagOPcFzw73AJbOS8Vk6seT2w
	aHjN4w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjb57s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so3689858eec.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 19:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794280185; x=1794884985; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PTsL5cLPUSLTpnCZzOaJvncyh24f9pvYBOUtBZUjJ0U=;
        b=a8O2rKiUNMJzbmmIyxzXLoXnk6QQ/5QtULGGD/8nIB/a8/VdpynlcJuFk8NjEgT6KC
         EiWVZHl0xV01BgenOYC3QePEY0XDTeOOmKv44rehOyE8TIaG3OMRMLy2GSXGpW11oWjU
         GJ3DO5VHsazazZCubH8e5taRhoqYx295IfSNbIxT0RIezcZu4dnHZ4e1Vy5Wo35PmaXM
         2I9noVwGM2ndy2b8Migcgy7hm2HglZlR3zmkjmko08B0ly75/dfNOmyUXmqW1+pyOqBa
         PuVrlN3zrNGQ93JbUzp49nZ9llIsl+kNvztWbTZgHcOfyD/MlyQpHeVinbDIVljM/jZg
         +dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280185; x=1794884985;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTsL5cLPUSLTpnCZzOaJvncyh24f9pvYBOUtBZUjJ0U=;
        b=0dwJUFxDYTUrpRTwqJ+WTVahDfo4F4OVsW++MB1IFiIrRmhammYBuqbAA11JkBiUGa
         FKWyEy5xL+V4etPyKfK0omyozkIQ9DpYXblRQ6d0TyhwMXlSUvQJCen/UgsuyZvnKbdt
         e7Allq8EezGfiw5BWLf0KZ9yGdUqcMGnBsT2NfOeMdmqAq03Pd8qMafmXrNg89qa1N+O
         bg1/cN7xacpDHYq+aHLerojxuy1FKXj0nvbFI8VSh0aoqBaNJVAWPAKJc+bX/ojcecGf
         kxzdjnSxYlfBPbePKfh6EwlVDA80K92FQ0R2iyMSI6HXHfqA44tYj8HxJMKHkfnogM5W
         PU7w==
X-Forwarded-Encrypted: i=1; AL+hErFOoxl0rYiAd+PGZwItTWtZtRADhm6rmtZbB5oHmpgABQlWaHaNF9BFTacz3/V4Vr+VPvebKwU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/G0/C1A6eCdXXiey+1PuOvRpRi/nMNBlJUZwt1tB7IRTBGhtzl
	S7ndAFatRUhvPmhEFcMaAdanDxnfvbSQUKb1Awk/Q+fVXeN0khjoQIN7oQCqRsHaDO93VsSzsWO
	3tdZtymZvaF+Uw5OOHiJPjQVmZTEjOFCw2AA8ytlJzpPjemD9PPDWDF0RH6I=
X-Gm-Gg: AYBFou2oqFJeoGfXOQGXyeTE+JmUEW1eUwVfwk+P2ntz7ZzvcoqR9kDY1QNGsoVquEq
	d2BHSEi3gYEkQYJdN3fXVARmHrwwTtMquM9y+nU6THxnZsnme8wKxUvfANy8W0INMA2sBxFZlJK
	KnbzHOcvWb6I8KTHVB0diJbsGmv69YzOnYYtAvwnIskzNMm1H0xjZUP5PJRixqcXHepgeZvvar9
	9vBK2Ewo+R/VpmDb2aF2obBC+21mANci1Ma99vh/FfO+TeMyPKqzkysi+IooLC1Fdc1vaeKSFlg
	mml+mWJxFMqsrw1noswqZ25Ari9yHgnFOOcXMASLHEVDwwv5v4CTiGcB9Q6Dp8MZ8eNr94MWHkD
	0JcCbIyjZYqmE/pMPw9CUHCkVJfgEqxaGbwhF9PeFPpIQgwANXVxYuUrHV0Tpy8pZ5E3aJirIRf
	CpvIXc
X-Received: by 2002:a05:7300:c00f:20b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3751f561930mr1731415eec.26.1794280184439;
        Mon, 09 Nov 2026 19:09:44 -0800 (PST)
X-Received: by 2002:a05:7300:c00f:20b0:369:1401:c5c2 with SMTP id 5a478bee46e88-3751f561930mr1731364eec.26.1794280183687;
        Mon, 09 Nov 2026 19:09:43 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm2980455eec.21.2026.11.09.19.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:09:43 -0800 (PST)
Message-ID: <cb4cd5d7-492a-af47-6e96-33a7de6c4d41@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 08:39:36 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] media: iris: Fix use-after-free on unbind with open
 sessions
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
 <2rWHCgRwgvQ8e4bhpYnYDjIzh1pjQNSNjdBFELmGe_h6iZzVLuoQDpUPAD64feN0mYHgyoDf3AYwIu-5ilkZdA==@protonmail.internalid>
 <20261017-iris-handle-unbind-v1-3-7809148eb90f@oss.qualcomm.com>
 <46e9506d-1eae-48d4-803d-d731d85fd376@kernel.org>
 <831090d5-57c6-46dd-559a-bd6abebb982c@oss.qualcomm.com>
 <7a2e44a7-41af-461a-96c6-ea91780bf524@linaro.org>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <7a2e44a7-41af-461a-96c6-ea91780bf524@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TMIJJfCnAsnWhkA0HqmYdZxcXBYbUlmZ
X-Proofpoint-ORIG-GUID: TMIJJfCnAsnWhkA0HqmYdZxcXBYbUlmZ
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af28af9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=fbYITomgFRZv6I7M4EkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMSBTYWx0ZWRfX2KYNS/Quk+av
 smu6gc9KI8e1cgVOIzyr+LRCsG/vIAfjKF/MQr8mdfEHrfXK6rPWfgkQD0JE1YiwDPeQd/Y2nDf
 gxsO7jpyrpVKgMLtzFGr+AVJgDpWA6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMSBTYWx0ZWRfX0ptaH6ZsAzJd
 NlkcKpy2RKwJIRHHEEPKt28wxqNn0z7foqlXYCXyxcK6B49Y8Ut2PfAVnkj0RvxqYJkFJx6eSrt
 3vAYyXy00XxBGR2EcN5Ed2Qmin4L9q74O6JlxMOYniGzozjyBL+VLLwvp6YsXYqOq5Ysfj+GqTf
 auecDc34RNQ9qhL/0mhLMu0kpXQbXD7GGl8R81egkJ/OM7NXwMmRO3PYIm5tMRjmi8BUFnehU82
 zVZRaOg48uqAcPxmi9RdS8JOzlOP6fkqvRvyk5VKWZgCLv0QQOSt3sK0Z5Sg7uzPeg+NJUyMckM
 Xv8eTZOtg5DWZwCEJme8djTs1BxLa2QWpuHaBJz0bbmPG/SBIRVsagsy7NLHzB/nRepCIQvckfg
 b6gOrQfM71w1WmVrA2IRzuxh9yFZ+r85yTUURkKYQpJ3nkvcbNWmID88nWy7a3ZNSfasF0ZlArW
 orDQRa/GfqcpzuSdbAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100011


On 11/9/2026 4:52 PM, Bryan O'Donoghue wrote:
> On 09/11/2026 05:08, Vishnu Reddy wrote:
>>>> +static void iris_core_release(struct v4l2_device *v4l2_dev)
>>>> +{
>>>> +    struct iris_core *core = container_of(v4l2_dev, struct iris_core,
>>>> v4l2_dev);
>>>> +
>>>> +    mutex_destroy(&core->lock);
>>>> +    put_device(core->dev);
>>>> +    kfree(core);
>>>> +}
>>>> +
>>> What you would have here is an admixture of devm allocated stuff and
>>> hand-allocated, refcounted with custom v4l2_release() which might all work
>>> but, it's not obvious to me does work i.e. core is hand allocated while
>>> reg_base, response_packet etc are devm() managed.
>> reg_base and response_packet are safe: after iris_remove() the IRQ is
>> freed and the core is in IRIS_CORE_DEINIT, so nothing uses them. Only
>> the core structure must outlive remove(), so only that is refcounted.
>
> Right and you can confidently assert that for clocks, regulators, power
> domains and ICC ?

Clocks, power domains and ICC are only used in the power on/off
sequence and the clock/ICC votes. iris_core_deinit() powers the
hardware off in remove(). Will handle this more precisely in the
next revision.

>
> TBH I think this is pretty hacky and unlikely to be safe.
>
> Another way I don't think this approach works is an ioctl() waiting on
> firmware do do whatever. If the ioctl wakes up after the devres() removal -
> then what ?

The wait times out and returns an error. That return path does
not access the freed resources.

>
>>> A much simpler solution to your problem is :
>>>
>>> static struct platform_driver iris_driver = {
>>>      .driver = {
>>>          .suppress_bind_attrs = true,
>>>          ...
>>>      },
>>> };
>>>
>> This was discussed in [1]. Dmitry noted it is a sign of a badly written driver,
>> and I agree: it removes the unbind interface to avoid the problem instead of
>> fixing remove().
>>
>> [1]
>> https://lore.kernel.org/all/
>> CAO9ioeUvV+3sME9P1bJTpDOSty=uojOKak659XCf337++vPVNg@mail.gmail.com
>
> In which case I think you need to do more poving/reasoning here about
> admixture of devm and hand-rolled allocations.

Agreed, will explain more in the next revision which resources are
devm, which one outlives remove(), and why the others are not
used after it.

>
> Like what's the use-case you are supporting here with the unbind exactly ?

Unbind through sysfs is generic driver-core behavior, and remove()
should be safe whenever it is called.

This series started from the issue reported by sashiko in [1]. Will add reported
by and closes: link to it in the next revision.

[1] https://lore.kernel.org/all/20260926064921.976721F000FF@smtp.kernel.org

>
> ---
> bod
