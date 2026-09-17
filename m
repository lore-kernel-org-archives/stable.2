Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECA4E0206
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658981; cv=none; b=g5wTOiB2Vvx2mNL+9j2hkbaAX/W14tvaBpkQtTc7n5V3pa2/suXzJ4Z82AR6y9K2LA4RXHo7ZJDPk0kzV9ohaYi5lKWU7If0z+jhiWwqYc5qcGKem2KbEEDRoKYPEiuOdIXiNiWvDBEG2gwptFMGr0Fi/6meJVeBN9iPqsfOS+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658981; c=relaxed/simple;
	bh=afCLU5fxI03J9D9nLtH4Td2enen0wBmzqGDH5gE8voo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4/iYbqO9cdkj7bI9bXDT1kcNXDf2+TRYxjh2H/CYNCN5Mdfius1KfNpRf/KN9Oxiy95ovS9UjUVwhMvIQSSITchB1P4rRliF0pgkDn1Biafk1dFy51/9kpcFvKquZOpNHMTrmDM0FI9bvbgv5hIHsYf/juxBnQJLVsIe+J6IMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jnpRfSJ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZCPAdat; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jnpRfSJ4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZCPAdat"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HECobJ2496813
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8OUOF3KkA/tkt+9vyyn8ikxcgLqvceoLwvPfCfImShY=; b=jnpRfSJ4rjCbNWS0
	xiiILtPf06hva7AOteF0kErGZPSFvTM1Rr0T6xNf+48zRaxmx+mz67Z0W4Oty8he
	RV8Di2Bno/stUGAU2ulD0ECZ/OkEXnhj6c2/6Q9ADh3CYU/IMfgrU+8r1yHwZMqa
	NwVd6xUsxpxV3IJXI0cNNZ7OpWj6bW2SCqyxIhmf6/ENZIkWZtv1nmo/g1FLu4J6
	sWon1lqcxblCkr5XNIXyAgtn90Yj2e30wJsDqnaRNYJ+LAQgfBBhaR4o0ve3IHNH
	uqGFGcsv0zajuDmDmqvOwk8gyfuRyC5UmZX8lfnSvEp/riMFO3mjk/FHkXrHg2G/
	2wZbpA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grhs6gc57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:29:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1334580a91.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789658970; x=1790263770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OUOF3KkA/tkt+9vyyn8ikxcgLqvceoLwvPfCfImShY=;
        b=aZCPAdata71evZclEsf91hqJnw14MYjX7UfdSECnr3Dmgg5u+UJFix2ZNZNtx6MYpK
         8RC1IdfaAwNNMz+cDtbcIUbMyvLhM791kHRDMS5Dik4nLB6t1FQFVkgPx8YyUhBWVdMx
         ioGMGnscUrNJJYYLezglMGfwn6uvVJqB8PpNoHOiM8pSNJv21rrogXbAJSzGe11SPqtX
         ha9xDxxSdICXmnYlrDAuE+EfhzHts/DvzRVafGwLWoygupo5GBpvBgnSjQOv9M34yesJ
         lXUXYxl3SPJSYXrtebr75s3g1dK5TA7Ob9JD1fECFsVyQGBZWgttblLHKVZs1/f6h5eQ
         V6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658970; x=1790263770;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OUOF3KkA/tkt+9vyyn8ikxcgLqvceoLwvPfCfImShY=;
        b=aiRppOpbYVLrR626UvMMbsyAQkOKKQWDB5ItIui+52NuMh7ZmQq4KRi5OyBxUjiTlu
         IbAhGVgSP1yl8EAVU6HYyc8pqw7e2qtvZuUqcEgp0M2QN/9zm3i3gqBEi2oJW/O5sQ2d
         Oo/ZDmt04aGIFBhC3mR27hINgwRrNBDEQua1S4k9PVdUnIxWSwHEWobrx14m2Of5qGnP
         HyJqsJpSMtR03X5NrP6uw2DO9gyfVyh7N8G5FnI5VN4IHgp8dwHNKHHrgXddFfDankat
         l8SSBjtte0eSTp9lIVJxbf7gEj5bisHkS3a/zCzDcmBLtgjE6RQ2Sih1/8qhATuNORnK
         oZrA==
X-Forwarded-Encrypted: i=1; AKwUvByikK2oPlO9nk61xMUQHPSSzmkNdPOzy445yH/6WpXH+XHXXjYdRt8Mu0eIilNQFhwM0Fc5UaE=@vger.kernel.org
X-Gm-Message-State: AFuF++krbFk1Yo7QnIOKgboGmMl55585CWOtP6pu18bS7aMhexVGpWy3
	aIeS1PVKvbA1Z5hakRiaDCHWR+0qBWyQO5i/cVBRa3iIjbTKvqisCtpZymFNqvgnPtcavtLT6vj
	hhLbuW21bfqtmShROlj3udDTtuBt0hp1KK5L/wPxtwJHkP4JWpV/GO1kru5U=
X-Gm-Gg: AYBFou0J4Lgc1ZJaCk/Sl+tCRY2YV3oDGybn8oCP52Y0eldUkHsEYUQAkfv1f71kFpP
	QNKKQXJB3ybWJoqtC9lEljEvwk0qTihRn1Qy+4yBoeYPwXccEt9XVx6uTzltxAsWr67nMJei3Je
	nF5lGrnRB28asECKjDPdDKEf5T5FGX5h5hErQFl7dEUvlLRQ+gsVO9mjeeMu0CZo6tGqMI6W9St
	lnGtso/WmHRPQHdp6Zq4IUYMqo9Vm3wLw4h81lJ/KTGVS7rJ7qvxl2dapAc8yblj1MmpYCq8iS4
	w44JOaKC+Ddsbl4uq3VQ18khCCaoRhMQpkSqiKQY7JcnWpXkRZmXu1ZX6o4PqhQ63Fwvkm1q+U5
	fY+hcKRQdkQgLfJushiF4jzzLOYaTdTUd
X-Received: by 2002:a17:90b:2744:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39e1e30240amr14285375a91.9.1789658970035;
        Thu, 17 Sep 2026 08:29:30 -0700 (PDT)
X-Received: by 2002:a17:90b:2744:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-39e1e30240amr14285316a91.9.1789658969424;
        Thu, 17 Sep 2026 08:29:29 -0700 (PDT)
Received: from [10.171.1.18] ([106.221.191.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ac978esm15988035eec.18.2026.09.17.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 08:29:28 -0700 (PDT)
Message-ID: <70a79153-5acc-7826-b08b-6fd869ec34a3@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 20:59:22 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: iris: prevent sys_error_handler from restarting
 core during remove
Content-Language: en-US
To: Fan Wu <fanwu01@zju.edu.cn>, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com
Cc: abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260705032529.2439425-1-fanwu01@zju.edu.cn>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260705032529.2439425-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfXzWHMzrx9MkTJ
 yeOWJ7HhNYFg+edJnDHViqmPYfNtTpzU8XGs+dtNkqMTBIuKo6a0L2/NXT8SsQVcdankF6vFL/V
 dZxtDIzM6JL6BvbC8Lb1d6GFPK8p+IRHohUGPaEbr0t8lChitrzbm8imUhGko5yb4MHPJrt+35K
 GlN2190nc+kpgyTxkdUGHCGEnMjAvZe8aU4Wf+Rq/hDtr2QkXHJgSw85yYHV+zr3XNmRwyqD0CN
 7l+e1pHmr0/R1kmriiii3UEe5er7U3uOIc0MdtwdJxBJQpD2r2YXpqGqofDMvx8pOzdCjZsD5mO
 sJcdVldstQSMyWHPGDXtRBLv4ZL9PUD02kB/3Nhi4WOrYRw6LkKEiLMBassxxA8jhheO3KuCxkG
 GsG2ErLX4tu9BcXS8pacIKca7OEZu01g9LEH9rtkyI/Bp6OhCzPubtDL/E+HJL+rur1loR47EqG
 7GHwdlmZhykqunEEF8g==
X-Proofpoint-GUID: aNVox8ZXSagsT1ICgNSKMy6s4cZk0Qwv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX72C05lU2v0J0
 MzHh0STK0elL82fUzXmminoYuSlRaT5rCu6T4Eqjnwdpo24F7DR7FxFsi1kdCbGdTQyh+xmDqs6
 JWXpKJSiQUcYk3ZZGxG+hPK5xxEDCPk=
X-Proofpoint-ORIG-GUID: aNVox8ZXSagsT1ICgNSKMy6s4cZk0Qwv
X-Authority-Analysis: v=2.4 cv=cvwOAF4i c=1 sm=1 tr=0 ts=6aac075b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=BDBwzOTuoAJfZxoRWNzZ7Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=JVhh-pDQcx9uSaxsvHEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170220


On 7/5/2026 8:55 AM, Fan Wu wrote:
> iris_remove() does not cancel the sys_error_handler delayed work, which is
> armed from the HFI response path on system errors. The handler calls
> iris_core_deinit() followed by iris_core_init(), so a pending handler can
> restart the core after iris_remove() has started tearing it down.
>
> Set an unregistering flag under the core mutex and make
> iris_core_init() refuse to re-initialize the core once removal has begun.
> Check the same flag while holding the core mutex in the HFI response
> handlers before arming the delayed work, so a system-error interrupt
> cannot queue new work after removal starts.
>
> Cancel any delayed work that was queued before the flag was set before
> destroying the core mutex.
>
> Fixes: fb583a214337 ("media: iris: introduce host firmware interface with necessary hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/media/platform/qcom/iris/iris_core.c           |  5 +++++
>  drivers/media/platform/qcom/iris/iris_core.h           |  4 ++++
>  .../media/platform/qcom/iris/iris_hfi_gen1_response.c  |  5 +++--
>  .../media/platform/qcom/iris/iris_hfi_gen2_response.c  |  5 +++--
>  drivers/media/platform/qcom/iris/iris_probe.c          | 10 ++++++++++
>  5 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
> index 52bf56e517f9..b843ab0d484c 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.c
> +++ b/drivers/media/platform/qcom/iris/iris_core.c
> @@ -48,6 +48,11 @@ int iris_core_init(struct iris_core *core)
>  	int ret;
>  
>  	mutex_lock(&core->lock);
> +	if (core->unregistering) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
>  	if (core->state == IRIS_CORE_INIT) {
>  		ret = 0;
>  		goto exit;
> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> index 24da60448cf2..a52d2a1f07c4 100644
> --- a/drivers/media/platform/qcom/iris/iris_core.h
> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> @@ -74,6 +74,9 @@ struct qcom_ubwc_cfg_data;
>   * @core_init_done: structure of signal completion for system response
>   * @intr_status: interrupt status
>   * @sys_error_handler: a delayed work for handling system fatal error
> + * @unregistering: set under @lock in iris_remove() to block core re-init
> + *	and sys_error re-arming; checked under @lock in iris_core_init() and
> + *	the HFI system-error handlers
>   * @instances: a list_head of all instances
>   * @inst_fw_caps_dec: an array of supported instance capabilities by decoder
>   * @inst_fw_caps_enc: an array of supported instance capabilities by encoder
> @@ -119,6 +122,7 @@ struct iris_core {
>  	struct completion			core_init_done;
>  	u32					intr_status;
>  	struct delayed_work			sys_error_handler;
> +	bool					unregistering;
>  	struct list_head			instances;
>  	/* encoder and decoder have overlapping caps, so two different arrays are required */
>  	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> index bfd7495bf44f..c9100112d07b 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> @@ -230,9 +230,10 @@ iris_hfi_gen1_sys_event_notify(struct iris_core *core, void *packet)
>  	mutex_lock(&core->lock);
>  	list_for_each_entry(instance, &core->instances, list)
>  		iris_inst_change_state(instance, IRIS_INST_ERROR);
> +	if (!core->unregistering)
> +		schedule_delayed_work(&core->sys_error_handler,
> +				      msecs_to_jiffies(10));
>  	mutex_unlock(&core->lock);
> -
> -	schedule_delayed_work(&core->sys_error_handler, msecs_to_jiffies(10));
>  }
>  
>  static void
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> index 25162ae71357..7f0c121866f2 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_response.c
> @@ -285,10 +285,11 @@ static int iris_hfi_gen2_handle_system_error(struct iris_core *core,
>  	mutex_lock(&core->lock);
>  	list_for_each_entry(instance, &core->instances, list)
>  		iris_inst_change_state(instance, IRIS_INST_ERROR);
> +	if (!core->unregistering)
> +		schedule_delayed_work(&core->sys_error_handler,
> +				      msecs_to_jiffies(10));
>  	mutex_unlock(&core->lock);
>  
> -	schedule_delayed_work(&core->sys_error_handler, msecs_to_jiffies(10));
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index c2dcb50a2782..c8553bc7619f 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -200,7 +200,17 @@ static void iris_remove(struct platform_device *pdev)
>  	if (!core)
>  		return;
>  
> +	/*
> +	 * Prevent the system-error work from re-initializing the core once
> +	 * teardown begins.  Then drain any work that was queued before the
> +	 * flag was set, before destroying the mutex used by the work function.
> +	 */
> +	mutex_lock(&core->lock);
> +	core->unregistering = true;
> +	mutex_unlock(&core->lock);
> +

Calling cancel_delayed_work_sync() before iris_core_deinit() is sufficient. It
already cancels any pending work and waits for a running handler to complete,
so the unregistering flag and related checks are unnecessary.

The patch below is sufficient to address this issue:
https://lore.kernel.org/linux-media/20260604054708.42426-1-dennylin0707@gmail.com

>  	iris_core_deinit(core);
> +	cancel_delayed_work_sync(&core->sys_error_handler);
>  
>  	video_unregister_device(core->vdev_dec);
>  	video_unregister_device(core->vdev_enc);
