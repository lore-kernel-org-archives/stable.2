Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367530;
	b=oxX/iAynth/lgQDPEWDIiydjBwPDxHMHxcjQFBz2OA0jRdw/Y7nfxD+788GpQXZCHbiJ
	 IgAStyfsB1FsIlzn8wd+XSY24jC57UsJ6ZRAPYJClVJdgF0ylbLP9644aDbh5VDRBO+EW
	 MSK+yGbKDQClAOsrI9nBy274/5Fnz1BsZe5kSZmor1IOv2ryPJYNtXW3qAiNR3TtbLck1
	 lmdeP1C2dMCHNY63hlxEoI9nBOwCtDAQdTDh0L9RicMOklVrqvZTZ3H/BjntMKI47w7gS
	 IGnS5aea1wqroebgMvnevIHPEJEGEnLKXifOJzRvYbr7JyEoHFNrFFr7vK8mb0S+wyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AomCtOWxOdmlR0sUoqk220RU7FjG0HPHL1G9AKXfbu4=;
	b=FFSGa5LzJNFuPHORwcELNJeOsJRDC27xV56VsCrFBvCIszXaCqMNaoLZmwjUiUzF94i/
	 troCZHPwBkjwawzyVtoTs6MR+JAJfEw6FA/hRuEiQxEElJPcPSbTTlZoBW0ZzLuLWdmi0
	 HpXnRAdGDSsXspVMrIQvDK1vkxJOAn0UCcScG0GFbOSPOsWpP3fQ6aumf1EwF7pwtrN0f
	 LO2GSDci2n5TxrwwWThEaIiiPWNQ/JuN+CpCoD4JTOz2JL+xYONGTEekVLN8g4cocS4i4
	 71c/gyHGj549ai+rxRQP88qotNVvOBUCX7jfvpgFr4B5lZaT5eRwQlOiS4GYG9CMyOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fb2KX2wd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OtZCG2fg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38125606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38125606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fb2KX2wd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OtZCG2fg
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB1tSsf4050294
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AomCtOWxOdmlR0sUoqk220RU7FjG0HPHL1G9AKXfbu4=; b=fb2KX2wdfJiGUbio
	yo0qBEH0nfT476LGmDRJqeyj27F88zaeuEPSAD6EICAl73s5DeOo3s5UHciGejLg
	p3yD6JpZxhTa7M0WWrPWx7ZAOJnznldjCpmo1hjJQ1W5zewJVvGuyXaEgDsi9SFw
	UPVhOjYbBJuutWRklCfXt+pMJsiGFXkwQaQuE702RFtZrkaSWNFl4szxoq6dfQGu
	A33evsCYMxR5lTxjRVkASgxaiS/WvblIFxI8B5jujsZ1SsdMY1WwSDQwQkLYmORJ
	hPDiRuitXJdbNAcK3ruijNkKV7F60gczmbNv2LrN9s4PBZUpe6ZFpF3tJb6RYwV5
	vwcu8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5j7x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:25:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-375f0fd31f4so1496161eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794367527; x=1794972327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AomCtOWxOdmlR0sUoqk220RU7FjG0HPHL1G9AKXfbu4=;
        b=OtZCG2fgn0UcbGMApCWXw0tou4eHe2j6hlP58WEU6Z6wZjWWPnvwyONvVzI6S6yFdb
         IaHPdVDsPAGb7dU68pZF9PaOW2feDML2JdORWPmVszLzyu4DIzbO01pXxc7IACK0tYVg
         nP/ZBka405mEoo3xftdNu5Bb0bbvJ/l3z95HwxZTV5D789IlO82/x+aGew5JcbjzUVPC
         s+neuq9zCHPCGvJSE+Z20tdKVaPMvMCbifPquuLl/6MG+BAzZW/qOtNbHhe7jllL4Cg+
         J2vkW/XBXFOnon0CTZIifuk2pceP+GHWPUIrzmz7lYyexq+pWiaUP441ourHC35XqpQZ
         0Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367527; x=1794972327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AomCtOWxOdmlR0sUoqk220RU7FjG0HPHL1G9AKXfbu4=;
        b=D6wbRohFiekzEbRyDDoy50UVdWpJpcvE5KJmUz2fQHk/JeqGIeFDNy442VlOljdg2a
         +xQ+Tv9v9DaeiFdG7DYsxOAT7nkNWnAk9fmz56QXRDDskgabrkBKyuushyiAHiTqJHYe
         Cz4rilks+1TfcAoBeLfw4WC7JUuvCWO7d+cg+QnFaMQXPZkzedPhI4okIFdI70krrr31
         nQabFYsE59nCDeM93rPq7F+BbdrIBYzVEM5IfSdlwjKV5HPpI16RPiMdlnXVU2DOkoyd
         4bwFdWMKbpzvKv1uIkCeoapxCplx8GjOCkvZAX6IDzgtcBuJeizLjN5uRxxkAlr5eABJ
         5Hcw==
X-Forwarded-Encrypted: i=1; AL+hErHLzT5BLnafhcrbf0DFKbndRuwXb2Gg1drHVg1PyLs8vc97PWCFH8ql7mhiAwZQKQOsBPacGHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G07fvNv6RnE8IuUP4KGJBHUMo4Pavip1DWYMeUFmVrTZufLGv
	vhtK8AdEzkH0f19VpTArB3iXVWzSLSttMy8/d6bvy3j8UXsLgrskEKlBbTSHu7Ow9YTFxJNta9C
	1cpidIRq16roV0LZGVLVthBrCxqnuSYQmWHeW33lzU9lyaKAGZCaepf8XbFk=
X-Gm-Gg: AYBFou0nKhM+oDzjDxff17baC3eK3j6bSoybEo25k0OEmjcFIDHtCl/YZhKsimZcUbT
	pi+8MB5zyAl5cXhBbZRX5tupsmykuYZy+49kwcQxw0ILNLjKUDqi+ZRFAqlAygvudVkU/FtuOIz
	O8hTyWTsaPQaK/RTa2J5Gp1CmGZtYylYpen6jz5P4JntrroNw07xSa2SxHACwMghbAKDR4Yd94e
	acTXnfwy5Rgr0cBQtmAprGIrAgDaNqSd39OQxwH2BhtQ3t+lWx3z4gYvKqkb9ceqik4zsPirPc1
	YZ6iWJDlLGfeND5CZC4eWQj1StF9FjFOXJ/d6/XkvmqfxbeLGBXDeFifHnVh7givyZu+tSaBMQb
	Ed2SF1luG3407zypB8I0Ar1x3UFcxPRNZxHmrxBDDOCrk5aYYnAc9RNyufLi54BVnBlzTvGcrer
	ltlkKy
X-Received: by 2002:a05:7301:77c7:b0:376:ce6a:a499 with SMTP id 5a478bee46e88-376ce6aa7b1mr857770eec.36.1794367526791;
        Tue, 10 Nov 2026 19:25:26 -0800 (PST)
X-Received: by 2002:a05:7301:77c7:b0:376:ce6a:a499 with SMTP id 5a478bee46e88-376ce6aa7b1mr857749eec.36.1794367526185;
        Tue, 10 Nov 2026 19:25:26 -0800 (PST)
Received: from [10.204.100.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm12427852eec.21.2026.11.10.19.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 19:25:25 -0800 (PST)
Message-ID: <6eda82b7-c617-fdbb-9fe8-adb0f1206acd@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 08:55:19 +0530
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
Subject: Re: [PATCH v2 3/5] media: iris: Fix use-after-free on unbind with
 open sessions
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>,
        stable@vger.kernel.org
References: <20261110-iris-handle-unbind-v2-0-86d5f6f1dea8@oss.qualcomm.com>
 <20261110-iris-handle-unbind-v2-3-86d5f6f1dea8@oss.qualcomm.com>
 <ee2aedde-6688-4cfd-9f92-3703b081247d@linaro.org>
Content-Language: en-US
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <ee2aedde-6688-4cfd-9f92-3703b081247d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfXzynPm5IRZNlC
 zr/dWIQlo1hDsKtQxJR7rMCkGe9cTldUbnxECELm1rvyzp5mXyji914txhIDd+ESvZwCy3tXrjM
 KMMxZsQKbpkzMTMJmhlKva/gV4EUQLVW/sy3aOzLucrdzLb+y8NpJGFx9mM4QZVhsthchZyBhK3
 TOYteU7QjkwyA3/LWeQiDr4nkc8oLUxutM8VEQj873c09ryLlDHjeZ/EGg0QRdJXU0oKv+y+s4Y
 LSul2xojp/3l8Wdf6FMalladBtcM9IdRuOd5azFM7ljYFRAyzEdsWUwUQ2fCWZflRpUa+3BNPLs
 0jKhhWE/LvVme/pic/v4bqAXn0QOwtxvrHj+2IGiJKxS7aShW050vNh6fDwaqpIDsYAXk1u08Td
 c081fhGOtcn28Sae6jXw9OIB1pT89K3Gg2Ud2nRQmuly28YVqBQRhlBJUoACL45ji+hJTkuUk+i
 opnWT/bc3yLO5Gcr44w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfXyq20c7G3jwjx
 vuSrUgV35s6Q6Lhn2rWGlMCiZ2y3P5ymr6ThGPHiwtnvUkiTCaIfR/7e0/jbZOIwGk24js9lY1Z
 vNVWQUw2nRiQ/BTt3ugdkedSFDow2qc=
X-Proofpoint-ORIG-GUID: FcRuxnTnq47252hW0zTJx0KtoqhudgGO
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af3e028 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OCzWoR2KFpuGU18DyrAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: FcRuxnTnq47252hW0zTJx0KtoqhudgGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110013


On 11/10/2026 8:12 PM, Bryan O'Donoghue wrote:
> On 10/11/2026 14:09, Vishnu Reddy wrote:
>> The driver can be unbound through sysfs while a client has a video
>> session open. The core is devm allocated and freed when remove()
>> returns, so the open sessions then use freed memory.
>>
>> Only the core structure needs to outlive remove(), because it is the
>> only thing the file operations of an open session still use. Allocate
>> it with kzalloc and tie it to the reference count of its v4l2_device,
>> which every registered video device holds. It is freed when the last
>> file descriptor is closed. The other devm resources (register mapping,
>> response packet, clocks, power domains, interconnects) are only used by
>> the power on/off sequence, the clock and bandwidth votes and the
>> interrupt handler. All of them are released with the unbind, after the
>> core is shut down.
>>
>> To make sure nothing uses them afterwards, set a removing flag at the
>> start of iris_remove(). It makes core init, new sessions, command
>> writes and the clock and interconnect votes fail with -ENODEV, so a
>> client still holding a file descriptor cannot power the hardware on or
>> vote for resources that are gone. A client waiting for the firmware
>> only times out and returns an error without touching them. Runtime PM
>> is also disabled explicitly in iris_remove() instead of with devm,
>> because its callbacks use the core.
>>
>> Fixes: 38506cb7e8d2 ("media: iris: add platform driver for iris video device")
>> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/all/20260926064921.976721F000FF@smtp.kernel.org
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_core.c      | 10 +++++-
>>   drivers/media/platform/qcom/iris/iris_core.h      |  2 ++
>>   drivers/media/platform/qcom/iris/iris_hfi_queue.c | 15 +++++++-
>>   drivers/media/platform/qcom/iris/iris_power.c     | 13 +++++++
>>   drivers/media/platform/qcom/iris/iris_probe.c     | 44 ++++++++++++++++++-----
>>   drivers/media/platform/qcom/iris/iris_vidc.c      |  3 ++
>>   6 files changed, 76 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_core.c
>> b/drivers/media/platform/qcom/iris/iris_core.c
>> index d558475986ff0..bdac6b8c98e44 100644
>> --- a/drivers/media/platform/qcom/iris/iris_core.c
>> +++ b/drivers/media/platform/qcom/iris/iris_core.c
>> @@ -43,7 +43,10 @@ static int iris_wait_for_system_response(struct iris_core
>> *core)
>>       ret = wait_for_completion_timeout(&core->core_init_done,
>>                         msecs_to_jiffies(HW_RESPONSE_TIMEOUT_VALUE));
>>       if (!ret) {
>> -        core->state = IRIS_CORE_ERROR;
>> +        mutex_lock(&core->lock);
>> +        if (!core->removing)
>> +            core->state = IRIS_CORE_ERROR;
>> +        mutex_unlock(&core->lock);
>>           return -ETIMEDOUT;
>>       }
>>   @@ -56,6 +59,11 @@ int iris_core_init(struct iris_core *core)
>>       int ret;
>>         mutex_lock(&core->lock);
>> +    if (core->removing) {
>> +        ret = -ENODEV;
>> +        goto exit;
>> +    }
>> +
>>       if (core->state == IRIS_CORE_INIT) {
>>           ret = 0;
>>           goto exit;
>> diff --git a/drivers/media/platform/qcom/iris/iris_core.h
>> b/drivers/media/platform/qcom/iris/iris_core.h
>> index 3e4cf652bf39a..379f0666a42cb 100644
>> --- a/drivers/media/platform/qcom/iris/iris_core.h
>> +++ b/drivers/media/platform/qcom/iris/iris_core.h
>> @@ -62,6 +62,7 @@ struct qcom_ubwc_cfg_data;
>>    * @iris_firmware_desc: a pointer to the firmware-specific descriptive data
>>    * @ubwc_cfg: UBWC configuration for the platform
>>    * @state: current state of core
>> + * @removing: set when driver removal starts, blocks core init and resource
>> votes
>>    * @iface_q_table_daddr: device address for interface queue table memory
>>    * @sfr_daddr: device address for SFR (Sub System Failure Reason) register
>> memory
>>    * @iface_q_table_vaddr: virtual address for interface queue table memory
>> @@ -108,6 +109,7 @@ struct iris_core {
>>       const struct iris_firmware_desc        *iris_firmware_desc;
>>       const struct qcom_ubwc_cfg_data        *ubwc_cfg;
>>       enum iris_core_state            state;
>> +    bool                    removing;
>>       dma_addr_t                iface_q_table_daddr;
>>       dma_addr_t                sfr_daddr;
>>       void                    *iface_q_table_vaddr;
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> index 545bbe75e1740..e0cfa5107d1d9 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
>> @@ -128,13 +128,26 @@ int iris_hfi_queue_cmd_write_locked(struct iris_core
>> *core, void *pkt, u32 pkt_s
>>     int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt, u32
>> pkt_size)
>>   {
>> -    int ret;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&core->lock);
>> +    if (core->removing)
>> +        ret = -ENODEV;
>> +    mutex_unlock(&core->lock);
>> +    if (ret)
>> +        return ret;
>>         ret = pm_runtime_resume_and_get(core->dev);
>>       if (ret < 0)
>>           return ret;
>>         mutex_lock(&core->lock);
>> +    if (core->removing) {
>> +        mutex_unlock(&core->lock);
>> +        ret = -ENODEV;
>> +        goto exit;
>> +    }
>> +
>
> This locking scheme is looks racy, what's the point of this granularity ?

The first check is an early reject when removal is already in progress.
The second re-validates the state after resume, since iris_remove() can
start while pm_runtime_resume_and_get() is in progress. Without the second
check, a command could be issued after teardown has started. Also, core->lock
cannot be held across the entire function because iris_resume() also acquires
core->lock.

>
> ---
> bod
