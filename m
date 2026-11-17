Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903449;
	b=WSyLrtWeZw8pRS596rdBvckxzC9vnhwV+2+tcq8sCVjthb4e+jmk3Wo+jJ8/4xLBXpBD
	 dZz7gDYO4kJ6BwdnYy/4uJJyYHpimvvvvKRGhPnHxyfXb/5k/mC5u/08BkDCvJ7orM5QH
	 3C8dc8VS9vAzLDxKt0F5zSAyOpehuSweDlF1+xRv0pMTNAObz78ZEFd/q0qucVEc5AF1J
	 OlE2WwxN8H0I0En/MMfAG5506rTHEJ5qFkFUH4vUx6cbqvBu7sqRWnb7SnhYCBMi6vtLQ
	 8l850oiYDuot5w6vwpmWllpNxYEFm8TipmHPYAtn49FgyKf1gW9nUzmrM2kEaQMORBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903449;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VnUxqPmAnyktQW8ngvTXIcHsZ0VltHWVTOS3IQEC3CA=;
	b=LO8g4yn39qSGf4731LPMo9ospegqoM2+XXXBrsqdMsY4tcb3cNQDqVH4QryF1zIV/Loy
	 KPkdDoqKe/JDhCUks0SXWIQeATqolscOrM+tf2jHa7A57T6e5Ik/2IHHCWHn8YX7h2Z/F
	 WH5z/H5tXGICISgKGDs/EI5KU3Gp48/sSbHWEn/76xt8jy3KCiQtypTwGGp0tB1LAA4gw
	 XyLVh+rTx7IxRTmfVzuZzqvzQ9dBA+5kTKb13H+RQen6yhfBmo4Yfelh6f19Xnq57j0Fs
	 mUlAJbG45MVbmOrX6n9EbBscMauMi8LIGNFBX3NyEwXg1+lePwBLCzRHWisiy8E6+9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=loOySJJL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsYUXt3B;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDB606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CBDB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=loOySJJL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PsYUXt3B
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH2aBD63624145
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VnUxqPmAnyktQW8ngvTXIcHsZ0VltHWVTOS3IQEC3CA=; b=loOySJJLdkkjQ5T1
	Q8tq73YjFGgr1oB2njcFGFzehW3yTonyFFkHLOsTpcbNcVSIC5xeGlBaL+RvsuIW
	fEDWCNXm6ItAA9Ora6R35NVQgpqBcGiCdCbn0bSC3BshceC9nttMm1Mg1aFf2TG8
	+VnpBmzSDilLgn9Yqk0hmo7MCWRVp9TMhUqmGWTPROLd3jik36+oRbYEfxKlJcXU
	MVkFJNgiQTR2PGrbdL2IcJjYreQt7wsyQfDQ5dz8zYZRs5lkElY7yGm45mxNTAMs
	gO/uMz/uwQodnby7CG7HpDYnOGvKrlszkjqUC8B1lAJpVTWgDqEH/5cCP3XJ8Z6T
	1qh2pA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07rejjcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 08:17:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-375f0fd31f4so2980479eec.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794903448; x=1795508248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VnUxqPmAnyktQW8ngvTXIcHsZ0VltHWVTOS3IQEC3CA=;
        b=PsYUXt3BZH0zqWeZsyamgIJMkRULCPOYJtgZBaUObipB/VuIcTgQ3sFXZR06Z6J16l
         1E4cokHrI0yAEKKmuSuYgbwbO/hz1UIWslwpeI6/XXSNWaZlWCD9uIYNzKmk/WsA4dUZ
         G1jck+jCOGYWhMj2eWoo0rwSjeD+Sk4SiY7NE5HRKaAJj2PRkl3KJlsFjobeTk/gU/HO
         PUEjR+ChQ9lDCao8Wyw4lf4mo8MWeWcp0+dT/NeQqqWYeprANFp5pT7dUliy/jxBtan9
         /RD+SeOYsqHKgr6yNdPG50DYB2kHy0GnkNnuLOdF5TvH+3eAu5s6eUYtimqi/QUptZVl
         aI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903448; x=1795508248;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VnUxqPmAnyktQW8ngvTXIcHsZ0VltHWVTOS3IQEC3CA=;
        b=WH67CbYz0C2QTIbNaDr41arWdThb+VnNyW/qKzC/N/jnUizU2naT29QD1jJ+COd4Rl
         fMdpGEDH0Tw39wHHGVBoAEgegYx3JNGBG2xtaKweLp2UH6TB7ne/cO4ySe2c/Pu+W3Qb
         uOXICw2iJjDstdhg3n2tmUlHar6eVnIeTCVwmhVlg8aqIBPixrbKXGWdggrxTWU0v1kO
         lA6Lna9nZ4dCbhlV0cJ0zaj3CXY1moJw4aGgCGjFT9oYbTQsV2zmTUL8BS5g8f4LHDVA
         MgxcSM/ALVYvVfmJZspBMZsvUyT7hAWTBt1o3HDx6MgPozTyQ6em3T4gN6bjZaOvIoQj
         t84g==
X-Forwarded-Encrypted: i=1; AL+hErGA8TVG/95ESdEU1xxgrmqOj+HW7KbS+MAJ9JF/rLUS4upAu4AQVgp7lcSJGOgNv9hPdX+fS4s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gnq2kjwqDpUHqLa8ZJ+kb7HDYZ1nvDAfqW/4Wj/c2vDOBQd3c
	y1Vmsdu0ww2Mi83VmqJ5lfVWV09JbZraR9ZR/mmgQhGwVHvJr5oe1GiVSWzZ+XiuvcF8doCNSFV
	MZrjLzl5uRPsdflHoW81H7HG6xXWKSG+YPEiiM2azxwJje26rWlAcV6prfiI=
X-Gm-Gg: AZFdTZeMqgVhcuPT4rGYDOcmGrFk7IVTcdM23U3hO+LKnVTNWlWE+BHcaOMv/Uqqjhw
	a2qUIG2/26j16T0ZmGIkzuLGKo61tFL9rEtS+NQaNYSalF1w3pj11WFFJU0C46/OjmC7+hvOdyL
	Imq8DzHkw0D8LYAfVu02vExFt+OMMjAgIP3yxef0+jGkB2TLojfWF3DCHk2ry8gouWk1QDhWqOn
	xhqjMUXRNU452UeB8p67P6x5ibVPStEoeNBgjFF5NMwkGi21cnn3YmuEoldWsS5LUq3USXbL0SJ
	dMnrgAzOCM8lJTEyLkY9JNUDfARCiZe5Gj+lSTpPVx9rXGti0Nnwr9Itd0pBMa1G5Uw3zLGg8p/
	3N4AaTAOuiL5EdLQIXnxsZX48ueR2b9YNq3fi1dj0uYPOa+RNvYdH9lqnAwduq+NGEWJDbdikS8
	zqywsE
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id 5a478bee46e88-379681c99b3mr15052245eec.34.1794903447616;
        Tue, 17 Nov 2026 00:17:27 -0800 (PST)
X-Received: by 2002:a05:693c:4153:10b0:36c:9af3:22eb with SMTP id 5a478bee46e88-379681c99b3mr15052203eec.34.1794903447055;
        Tue, 17 Nov 2026 00:17:27 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm63388577eec.8.2026.11.17.00.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 00:17:26 -0800 (PST)
Message-ID: <b4a641c5-2e22-6216-7cad-ffeb270125a7@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 13:47:20 +0530
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
Subject: Re: [PATCH v2 2/3] media: qcom: iris: Wait for threaded IRQ
 completion during power-off
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Joonhoe Kim <26rote@gmail.com>, Birk Skyum <birk.skyum@pm.me>
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
 <20261111-fix-disable-irq-safely-v2-2-8e13f68c2ef9@oss.qualcomm.com>
 <c5444a64-ad14-403e-8453-0bb0a16dcfa8@linaro.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <c5444a64-ad14-403e-8453-0bb0a16dcfa8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfX4EKKvxoPe2/q
 4GV6HMVFsnkgPcYedqBEcmhDf5+/9U4eD5FRBy5zc6zQL67Dcmxm+Voq8L7rNkWuv9srfNnYDJ8
 9FiSdpV9f0Mp4mrPl566PnkshHSzCmo=
X-Proofpoint-ORIG-GUID: Uaa8XX16I7IyFLXVFgKn9QFFZbZ-Vv4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAzMiBTYWx0ZWRfX6wjl72nPpRz5
 X8mpeaLOkVaixtbqPqpRpBLvPmtKzLhk4guNPzMGOnNF4jZdjczyeElfd+VACrMTw6bow2hqBSl
 01TYuSQ/06rI8XMca0TQ2tYqWW0UyIh/xigQh+X+uxS2BVn0h5t6uBYPx5MOJ8UANEIIb6Z6g93
 qooQHL56fi8c2n7VszYk1mQQc2/Nja2fZkGJfU1kDVms8vprAhN7wObSVdXzNOxf+e6ifFtSTVo
 ediGuA38BsABJfjtQuS2Y5kQM/RZ8IlwALBncMhzFZ8WvBGFhiiq4XuS6r/fqKquNDR+wjjKZp4
 zLJjNsse/AvqaFk3ug5zeyIZ9rFWTVnFFKgprJK2HE4p2fq3ZAykN01ItQHCLOqbRXlAw+oj8QS
 pnXWqeTBoEgzizdzT4mpg3r7dKjy51Wfo8XtdXFEd4pMTSmCPi/xpqinqyeWJYIEZ76ai1rVbFA
 FklfcmkX53gB9bX4APA==
X-Proofpoint-GUID: Uaa8XX16I7IyFLXVFgKn9QFFZbZ-Vv4Q
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afc0d98 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=M5-Xm-TX60NQkl0miT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170032


On 11/13/2026 6:25 AM, Bryan O'Donoghue wrote:
> On 11/11/2026 09:05, Vishnu Reddy wrote:
>> +void iris_acquire_core_lock(struct iris_core *core)
>> +{
>> +    mutex_lock(&core->lock);
>> +
>> +    while (READ_ONCE(core->irq_disabling)) {
>> +        mutex_unlock(&core->lock);
>> +        wait_event(core->irq_disable_waitqueue,
>> !READ_ONCE(core->irq_disabling));
>> +        mutex_lock(&core->lock);
>> +    }
>> +}
>> +
>
>> +static void iris_vpu_disable_irq(struct iris_core *core)
>> +{
>> +    WRITE_ONCE(core->irq_disabling, true);
>> +    mutex_unlock(&core->lock);
>> +    disable_irq(core->irq);
>> +    mutex_lock(&core->lock);
>> +    WRITE_ONCE(core->irq_disabling, false);
>> +    wake_up_all(&core->irq_disable_waitqueue);
>> +}
>> +
>
> Ouch, this is some mad amount of jumping through hoops.
>
> As General Pierre François Joseph Bosquet said of the Charge of the Light
> Brigade in the Crimean war "C’est magnifique, mais ce n’est pas la guerre" -
> It is magnificent, but it is not war.
>
> Why do we have to hold core->lock over iris_vpu_power_off() at all ?
>
> - What is the data-structure or
> - Logical state (the state variable I suspect)
> - Or guarantee of atomicity
>
> We are providing holding that lock ?
>
> These are pretty much rhetorical questions - the above locking scheme can't be
> right. It implies we are doing something wrong and not really fixing that
> wrong thing.
>
> Holding the lock across power_off() seems to be that wrong thing.
>
> disable_irq_nosync() seems to be a correct fix - so if our locking is so
> muddled we have to go to the above - there better be a fully reasoned and
> unavoidable reason why.
>
> Perhaps I'm being overly reductive here but - why not "just" refactor the code
> so that the power-off comes after the piece held in the lock ?
>
> i.e. push that into a worker and then do a synchronous wait on the worker ?
>
> The chatbot told me I was wrong about the worker because "it would deadlock"
> and I can't be bothered burning the tokens to tell it "I didn't mean hold the
> lock in the worker"
>
> It did make the point that it thinks the only thing being protected by the
> lock is
>
> intr_status = readl(core->reg_base + WRAPPER_INTR_STATUS);
> ...
> writel(CLEAR_XTENSA2HOST_INTR, core->reg_base + CPU_CS_A2HSOFTINTCLR);
>
> Which venus does like this:
>
> static irqreturn_t venus_isr(struct venus_core *core)       /* hfi_venus.c */
> {
>     status = readl(wrapper_base + WRAPPER_INTR_STATUS);
>     ...
>     writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
>     return IRQ_WAKE_THREAD;
> }
>
> i.e. power off in the IRQ.
>
> Perhaps even simpler - just do the power-off directly outside of the locked
> section... once the IRQ is quiescent ?
>
> Either way I don't think we have a good reason to hold this lock and can
> certainly find a way not to hold it - assuming the only thing we care about is
> kicking that register - do it in the IRQ why not else do a worker with a
> rendezvous or even more straight forward.
>
> void iris_core_deinit(struct iris_core *core)
> {
>     bool power_off = false;
>     int ret;
>
>     ret = pm_runtime_resume_and_get(core->dev);
>
>     mutex_lock(&core->lock);
>     if (core->state != IRIS_CORE_DEINIT) {
>         iris_fw_unload(core);
>         power_off = !ret;
>         iris_hfi_queues_deinit(core);
>         core->state = IRIS_CORE_DEINIT;
>     }
>     mutex_unlock(&core->lock);
>
>     if (power_off)
>         iris_vpu_power_off(core); <- this ?
>
>     if (!ret)
>         pm_runtime_put_sync(core->dev);
> }
>

Thanks for your review.

Moving iris_vpu_power_off() out of the core->lock section can lead to other
issues:
- A queued threaded IRQ handler can still access the registers while the VPU
is being powered down, as disable_irq_nosync() does not wait for it.
- A concurrent iris_core_init() can run while the VPU is still powered, and
the delayed power-off then shuts down the freshly initialized core.

I will rework this in the next revision, using your IRQF_ONESHOT suggestion
as well.

> ---
> bod
