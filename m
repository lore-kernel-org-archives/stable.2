Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200947;
	b=oI1Wpe8caq3dWBdpgrBFw2u85mqpNOzGppOsjtDvx6LkgN3dPM8jyuTpxCj8qbh4nFvZ
	 bIVybRq4B4exJ8ZLcO7W4LroA+ADG5YwhYtkt3dOs+l/Jb9Uew6Q/jbqRDQFfkpziHKXM
	 85rHTok5dbdqd7n4utlQA7HFNE8nWbxRJH5DM95pvHIPK+VjYSduwEOYPBnWDPhDybePl
	 A6LnpgsjCjtKiF7B0hhiguvp0SLMogXNhgbpySoj6S+ewmd8zTZ7jqWuFYQm4Jdc/hr0N
	 zOKnKalGSa+O8ZoyBx4TGmROnlDkNRBCtuHljJ/f8nxAoXkYxCicKWtWcpiQM57HdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200947;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BkcR+ZLxe9zkWgjsfqjrBRDG0Uq1k3350+T8Vgf63os=;
	b=cmucXTah8QyfLXNB3p8QNIYIOkZ6+9PpGeXHwP536y856gPxXYLI9aIqTqaD81UyNq98
	 y9QxX/EHtjxswqf+XOaN5Vkz2XG4SsFCTFDD7lnN+BAP33A7ggX5zn+eE+HpCSM1vAjJc
	 7WjnRakDyvb43DFOvn+VBxGcRLm38TZ86zWz6SY2ZGsvjokiBnf3Kp4Z0Hs4lJQE5hPUH
	 PVMvQCH9siYkFT1l6mfa2VIIaE20V/WZsbs6yS8Def5K2vgYJx8DIrukO2Ns+bEpzUTMM
	 fcC0mY8GkipFtq54/HMdmZmCx9ksUSM8MSyhsDdR2Lv7xunF6f6n0XXwqhY1YZzRW/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFONTcJy;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aejwbafv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71E0606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 05:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D71E0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NFONTcJy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aejwbafv
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93KVo41650103
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 05:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BkcR+ZLxe9zkWgjsfqjrBRDG0Uq1k3350+T8Vgf63os=; b=NFONTcJy06KvrYNb
	kPgmVLAnfo9tslTRz08wE5X8JMZb4lR5YbIdbZzRF5aveTd0TftSx062FELQzi6c
	IfHRD5hn68H0kORzitp8SCa1xOncIabq/qhPaFbkgWG1zCEVW88K9SqrCYB8oC5V
	Vx+QscZ1aBVgGVxUQaoI2jYqRe5gHqVc2i2CYEvO/pqyKjyQE24kyfhUQ7TG6yJw
	Dp4fRMoL08Rce9q1RL3lE8L0+8arwi8SJLwD2REXpzffLc8vu0BK0Q5FInzPMC8k
	uzaPHxpIR7iWSNVTTTBpTuC50dQjOwt48tCFTJT1v40CsaNLF8QaPsw/k0buIEdY
	eoBcQw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw5k4k86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:09:05 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36fe0b57d91so590058eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 21:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794200945; x=1794805745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkcR+ZLxe9zkWgjsfqjrBRDG0Uq1k3350+T8Vgf63os=;
        b=AejwbafvTvZqvQtYsrWknIjFUJpMuC9QMmgYNXnKxU7oOpTSPKlm1RJcadc4iVGXRc
         cNSg//g4BJgpyap7jlLv01fAD3N75FlopMm2TezqQYSEUnTT7xsbSHFXNkbO57bGfaxq
         yuQD7gwjoIg7JCgeD9jP6MK7RNJl+DEMDaKuI3T9X5XhG9+ZVjhqSoN07XssEmE+j9H6
         tmbIJrWm5i1XJMiSt4B6eCBbA1PUq4nG4GhHSKy/FdrVhnpg4/mDPjHBwQaS71Mnwq+E
         wbl1KvgByrYxxAeYCxXHfFtcdqRjMw6eRTx1LJRoRb7dT+wb1W97PbLsqXMN2l5b8Dz6
         Dipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200945; x=1794805745;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkcR+ZLxe9zkWgjsfqjrBRDG0Uq1k3350+T8Vgf63os=;
        b=BTD+ELCFhOEwFt7g1xbWZtxPTq4iVh9fvpL9cWU+wrKZ3+diXW019+NOJiYiOxOYR8
         /rAEFNSXt9kOYv4ABuud4KIeTAB8QIjAioEqMSYmQ0eJteeFUTQD5wqdIKq+fZGYAlIF
         4ORtFletI/gGwOV2Dg3ExeFB8MA0n85WqYnikidx3aNrzcRTlz0OGOCkmZUcx5sMdaoo
         neT7bNPmvPfBLAmCAwQnQTSvgWMQ8MAXWPP3ZI9e4Cqj0noWNIDdNAjmYiHFW+LjrlBh
         l/fZ3sDVE5/h0gvD8x8jABpi7LOgL1yyvV3wSo3dkgYAJNevd2GaX3Fu7plzm076vkF6
         2ZGw==
X-Forwarded-Encrypted: i=1; AL+hErEqhN1s+QAhLLQt7CbtArQZrmTedHpkZZfUuohxvM3qVQ/bntByldqqVJd52UI6FQxMuZEl/wo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h0KCrxjW4auFDzXRQpRhWwyONFXcMCXyyAAylj56MNDjz9gFf
	ceuhrnwh9Be8NcMRvBkDr2HzFz3irzV6N0pm7lXuFVUNoczbFFMRGBjjxTg6oGQgVZSbyXOGlhO
	3AqUu8T0uOFD82mR76w0tug47lkWhLa7UjRqp7LGVOB8aha9caqar9TQrkXU=
X-Gm-Gg: AYBFou1uDowoawKL0kZbidr2vmQEZWG/P6m1feM/dhCP6eTxWnjGaKbF20SJMYjNJay
	+8YuezjyO4pWWxlGQq4ngZHyor9U6fNbQE2DUQlv0SxeM8d4NJhWjOWOvCwXZnqR7gPUXluXvwB
	UzSXd2iTdNv3Fw8XBVgpPVEi1DS1P5YzznEtKIjVGnrJU9RI7iQM962KzeyOzqKxtAuzpVeFS0q
	nIxe4VoQMwEqgr/5zyUlCWW2DTn7xAzoFBCwbmUZWj9UfQDMZApH7ulG305EfJpQyNN1EhC1H+z
	zor5uVrrEIFMOIDWTZcWyZ4uLIzJPIGvsrw+dUBNnLwS3CYer2D8P6cuzdmxmt2ZO8dxr7dlNd1
	dcAK2wCbW80zYWf/FWVJk1DKjbiXVSI8DR9PfhEX/mzKqdh1+wepmuPHfBuGvuyj9cHu+xYFCgK
	frv4g=
X-Received: by 2002:a05:7301:fc0c:b0:369:f961:ccf8 with SMTP id 5a478bee46e88-37256bf3bc4mr5155115eec.19.1794200945087;
        Sun, 08 Nov 2026 21:09:05 -0800 (PST)
X-Received: by 2002:a05:7301:fc0c:b0:369:f961:ccf8 with SMTP id 5a478bee46e88-37256bf3bc4mr5155084eec.19.1794200944468;
        Sun, 08 Nov 2026 21:09:04 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d2826sm10522367eec.29.2026.11.08.21.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:09:03 -0800 (PST)
Message-ID: <831090d5-57c6-46dd-559a-bd6abebb982c@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 10:38:57 +0530
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
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
 <2rWHCgRwgvQ8e4bhpYnYDjIzh1pjQNSNjdBFELmGe_h6iZzVLuoQDpUPAD64feN0mYHgyoDf3AYwIu-5ilkZdA==@protonmail.internalid>
 <20261017-iris-handle-unbind-v1-3-7809148eb90f@oss.qualcomm.com>
 <46e9506d-1eae-48d4-803d-d731d85fd376@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <46e9506d-1eae-48d4-803d-d731d85fd376@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfXzcVV/q9Qfa4i
 W8bBPkQhLGWaKWahN5KD94ITICayq5E35xqz8mzs552URHREtT8fwivvnwbDSlbL9QzHdrUTDdH
 dLAaERYt5BnY8AqHOcHZmh5oeFj3jn9wZlAiroF+EMs26EqkN6q9pfqfteZ/26cV05cg3itG5g2
 oXewUJ+uxxGNr/APmBVF0v8T7xEK4+nxriOZcE3dKOrWVckqbWuNw95Xte3hkTKCac4bj14W1bG
 8ZRkEk1voI+KHL9x5vspKeWZBvt2xGVIEosuZKFFSNVU9UPJyQHsBhWBWmXIoUd9BOzfwiotcAv
 nfTpuJEOAEl91krklz2W0B2g2R2xu/cmN3C0nLhfDe3hJ/LgTbwobw5tMMSTyZiWgMF25/nY83s
 oNwKOqqGZVRWMzfwD0eCjijTTeAKykdIibapctH55Fc80sZ2Tbh8X1GeaAS1Pl0+rtDTdVe37Vc
 GHFU60ZoyaF5w8FeSTA==
X-Proofpoint-ORIG-GUID: FKs6i1mZ6dXlaKfUFMPq1pN8aXi84Eiy
X-Proofpoint-GUID: FKs6i1mZ6dXlaKfUFMPq1pN8aXi84Eiy
X-Authority-Analysis: v=2.4 cv=G/aJgNk5 c=1 sm=1 tr=0 ts=6af15571 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=c2_qRZQ2Q0IXdIFigvUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX/FC4/CNcsdWP
 KEU5sV/gKOkgKRk0zFkrXwKqJaLqmkZZoX3WC0fgeymLCDyeXUjGk3+39xo5MvwactcPOXVzDgW
 annKbJm9faJMFC9xke4VsADUkjhFJbg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090020


On 11/3/2026 5:10 PM, Bryan O'Donoghue wrote:
> On 17/10/2026 04:16, Vishnu Reddy wrote:
>> The driver unbind can be triggered through sysfs while a client has a
>> video session running. The devm resources will be freed when the unbind
>> completes. That leads to use after free for the running sessions.
>>
>> Keep the memory of the core and its device allocated until the last
>> file descriptor is closed. Stop new sessions as soon as the removal
>> starts. Make sure the interrupt thread cannot run on the core after it
>> is freed.
>
> There's too much going on in this patch in one place. The commit log is
> indicative of that too. At a minimum the IRQ stuff should be separated because
> IMO its not really a use-after-free its a race condition that already exists,
> its just more obvious when you free in this fashion.

I'll split the IRQ change as a separate patch in next revision.

>
>>
>> Fixes: 38506cb7e8d2 ("media: iris: add platform driver for iris video device")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_probe.c | 56 +++++++++++++++++++--------
>>   1 file changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c
>> b/drivers/media/platform/qcom/iris/iris_probe.c
>> index 4cb678bd56f0..25876957381b 100644
>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>> @@ -243,6 +243,15 @@ static int iris_register_video_device(struct iris_core
>> *core, enum domain_type t
>>       return ret;
>>   }
>>
>> +static void iris_core_release(struct v4l2_device *v4l2_dev)
>> +{
>> +    struct iris_core *core = container_of(v4l2_dev, struct iris_core,
>> v4l2_dev);
>> +
>> +    mutex_destroy(&core->lock);
>> +    put_device(core->dev);
>> +    kfree(core);
>> +}
>> +
>
> What you would have here is an admixture of devm allocated stuff and
> hand-allocated, refcounted with custom v4l2_release() which might all work
> but, it's not obvious to me does work i.e. core is hand allocated while
> reg_base, response_packet etc are devm() managed.

reg_base and response_packet are safe: after iris_remove() the IRQ is
freed and the core is in IRIS_CORE_DEINIT, so nothing uses them. Only
the core structure must outlive remove(), so only that is refcounted.

>
> A much simpler solution to your problem is :
>
> static struct platform_driver iris_driver = {
>     .driver = {
>         .suppress_bind_attrs = true,
>         ...
>     },
> };
>

This was discussed in [1]. Dmitry noted it is a sign of a badly written driver,
and I agree: it removes the unbind interface to avoid the problem instead of
fixing remove().

[1]
https://lore.kernel.org/all/CAO9ioeUvV+3sME9P1bJTpDOSty=uojOKak659XCf337++vPVNg@mail.gmail.com

>>   static void iris_remove(struct platform_device *pdev)
>>   {
>>       struct iris_core *core;
>> @@ -251,18 +260,20 @@ static void iris_remove(struct platform_device *pdev)
>>       if (!core)
>>           return;
>>
>> +    video_unregister_device(core->vdev_dec);
>> +    video_unregister_device(core->vdev_enc);
>> +
>>       disable_delayed_work_sync(&core->sys_error_handler);
>>
>>       iris_core_deinit(core);
>>
>> -    video_unregister_device(core->vdev_dec);
>> -    video_unregister_device(core->vdev_enc);
>> +    devm_free_irq(core->dev, core->irq, core);
>
>
>
>>
>>       v4l2_device_unregister(&core->v4l2_dev);
>>
>>       iris_unreserve_iova_region(core->dev, core->iova_state);
>>
>> -    mutex_destroy(&core->lock);
>> +    v4l2_device_put(&core->v4l2_dev);
>>   }
>>
>>   static void iris_sys_error_handler(struct work_struct *work)
>> @@ -281,53 +292,64 @@ static int iris_probe(struct platform_device *pdev)
>>       u64 dma_mask;
>>       int ret;
>>
>> -    core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
>> +    core = kzalloc_obj(*core);
>>       if (!core)
>>           return -ENOMEM;
>> -    core->dev = dev;
>> +    core->dev = get_device(dev);
>> +
>> +    core->v4l2_dev.release = iris_core_release;
>> +    kref_init(&core->v4l2_dev.ref);
>>
>>       core->state = IRIS_CORE_DEINIT;
>>       mutex_init(&core->lock);
>>       init_completion(&core->core_init_done);
>>
>>       core->response_packet = devm_kzalloc(core->dev, IFACEQ_CORE_PKT_SIZE,
>> GFP_KERNEL);
>> -    if (!core->response_packet)
>> -        return -ENOMEM;
>> +    if (!core->response_packet) {
>> +        ret = -ENOMEM;
>> +        goto err_put_core;
>> +    }
>>
>>       INIT_LIST_HEAD(&core->instances);
>>       INIT_DELAYED_WORK(&core->sys_error_handler, iris_sys_error_handler);
>>
>>       core->reg_base = devm_platform_ioremap_resource(pdev, 0);
>> -    if (IS_ERR(core->reg_base))
>> -        return PTR_ERR(core->reg_base);
>> +    if (IS_ERR(core->reg_base)) {
>> +        ret = PTR_ERR(core->reg_base);
>> +        goto err_put_core;
>> +    }
>>
>>       core->irq = platform_get_irq(pdev, 0);
>> -    if (core->irq < 0)
>> -        return core->irq;
>> +    if (core->irq < 0) {
>> +        ret = core->irq;
>> +        goto err_put_core;
>> +    }
>>
>>       core->iris_platform_data = of_device_get_match_data(core->dev);
>>
>>       core->ubwc_cfg = qcom_ubwc_config_get_data();
>> -    if (IS_ERR(core->ubwc_cfg))
>> -        return PTR_ERR(core->ubwc_cfg);
>> +    if (IS_ERR(core->ubwc_cfg)) {
>> +        ret = PTR_ERR(core->ubwc_cfg);
>> +        goto err_put_core;
>> +    }
>>
>>       ret = devm_request_threaded_irq(core->dev, core->irq, iris_hfi_isr,
>>                       iris_hfi_isr_handler,
>>                       IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
>>                       "iris", core);
>>       if (ret)
>> -        return ret;
>> +        goto err_put_core;
>>
>>       iris_init_ops(core);
>>
>>       ret = iris_init_resources(core);
>>       if (ret)
>> -        return ret;
>> +        goto err_put_core;
>>
>>       ret = iris_reserve_iova_region(dev, &core->iova_state,
>> IRIS_NP_RESERVE_IOVA_START,
>>                          IRIS_NP_RESERVE_IOVA_SIZE);
>>       if (ret)
>> -        return ret;
>> +        goto err_put_core;
>>
>>       ret = v4l2_device_register(dev, &core->v4l2_dev);
>>       if (ret)
>> @@ -368,6 +390,8 @@ static int iris_probe(struct platform_device *pdev)
>>       v4l2_device_unregister(&core->v4l2_dev);
>>   err_unresv_iova_region:
>>       iris_unreserve_iova_region(dev, core->iova_state);
>> +err_put_core:
>> +    v4l2_device_put(&core->v4l2_dev);
>>
>>       return ret;
>>   }
>>
>> -- 
>> 2.34.1
>
>
