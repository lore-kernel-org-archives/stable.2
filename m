Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531345;
	b=yXsa71xPS2ZXckUjl0USiANX45zf695jM50JTqHKRjjLQoaGuOuECbtk7xn4E/WkG68r
	 h81a4uUxmgcqThB+yCD450Aamlg14lUk62JzGhiMrP068YSdFMmUDm+ORvNcMFDaxMKKY
	 JLtty0hHskvZzaIjuNyOKgSu38S57lZ0F2ttdgKPGswrUX/hLOueuR9HMRrzSlQlCgls0
	 MPuGbiwRWQG3DbBAKo0nWthjOIsybsqy5+LlZDEtFw/rcYQDdqgeBPJE1S3SvjOFeDQA9
	 pRu5oNeYE/KImKq/YZyp22XreL0iLti8RAHUGmZq4iY25LFKwjcUpacFrHTyWx+OeIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0tUZ/r90AwSeslzGso6dCb5vC4FbswESQba0fvf+Foo=;
	b=jG+pxzseqtY/LaTY7hzbdAFyyfqCifDJn2mwHUu/hHt5gjFprBcAtoVMBVBQap44r/fY
	 jfWb7uJDyrO1OS4UZlbvrOk8ghLwCX0amwZgCPjSClftXYnqrlxxfbP9aulfimu0sQ9ag
	 xcmF82czt2pShMFiks13yAO5tsIHiNla8CrKM09HzyEbHihPRjTYdlD2PHWa8qWzdPTVT
	 9pNaOecbhMjn4+oWLX31P4EHYy3JTvs1LLbIfibl3hQjs9a6kjl8efXY/2vHGDYk2BOYh
	 qB9i1/KFCwVDAz8q6IUL3z7L0/S4gttcx/UXeTouNryxkOmQHp5unWD6l5tKCR/VlKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OMa5Bljr;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39333606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39333606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OMa5Bljr
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-490f38e9688so258042f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794531343; x=1795136143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0tUZ/r90AwSeslzGso6dCb5vC4FbswESQba0fvf+Foo=;
        b=OMa5BljrZ/zWdrykDtBxCJNhTBjgkvLtFHgjdZ3C71uX1VsZRq+tfkDFCVU7XuYta9
         omMI6L1D3fiSb9wOSnuK+OAWK/IOUEuSDnW1UduCCvIdklxI0U4oGrb9G3W2/A8OehDo
         OpCfvro5dbMd+YgnYxT+OOsLl5OAAD4KfQx7BOylNlNaFkQ55qJOSs76Jzmh7CkeqwJp
         qFMmlvEi3bQkdlL7KTzCF75S2334nI8fRrEuJ5CI7CjYqMltxQShWqnsPNpA2wlhD94Z
         wBrtKkLC0M86+OWxBWsBdq9EsTCPlOMD+5SKMSido/MjbTPeoIc22aNY2apAqBLKvCRc
         h9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794531343; x=1795136143;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0tUZ/r90AwSeslzGso6dCb5vC4FbswESQba0fvf+Foo=;
        b=gwClLYsJHkC7QQUkJR1G/3Gyfemk/UFU1H1yzJtW33iNMbmLiGpUevYkfPFQ/iOCjD
         HDFQ7ffCn3LBmaj9IRABUMMtYyxlyJR8SuwBAonDy9QuB2hMGI2C9U/q26Wre6zGUs8o
         KTCsn9zgpsSjDFJhpvCpJwq/VEos5X5+1TOPedUNXfj3czULuH9AgreAAa45dytS/obz
         dfSEstV4cG7QkSbMgJrQOYjec4ajPCzqGsoGMeHBf87oJWqNfJeOhhgOz3jrh4P6pbE7
         sXzuW9cohJEWLfcgMREsq3lFUAOTtItnJ5O3lmFM/KTEXvsgLsQph27nwAdwYO4aumQz
         Qg3w==
X-Forwarded-Encrypted: i=1; AL+hErFeL5DCFJhv0vPNRYSEo3+6hwrUJNr/xJMakpOnnkk9MWTFPN5L0j4V+cxs2yRhHUVwakPM+84=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xnlUtu5q2kncpIDiX/jiOlfkE2yVEavLiaNizJK/KAWSDpi73
	SU+ONKUEZR/ymKGdzZX1W47Jtv82IgmgamCtv06VgdcLOaMDdhp1KSd1GinvOgx+9bY=
X-Gm-Gg: AYBFou1WQ78435ppAOMxlaKsgWKo8mNONnXSERRQqxctmHYJQzCOqKfhNHmNdz+ONnE
	q0louCWpM3NE3Yk7C/UDCg/+77aE3GxB3GdvYfJM+Q2h2ujvn776f1fYHEVkDpxwkO6D82Mcx3I
	D9EIiRZ16VIoOeLsSCRdahBMThhxKjL0sYCvxcU14xND87jOmrH/WcgKZc1k+eRr8ce/H/Fi+Ad
	vtbvqgrUlxqQxXW7tm10jpqZQGQeAoyysHOLJ7Vfa2spxRChIV4/tEzH25Is3uDn+srNtr2kXrz
	9qs4JB5O7fKKNaRjTxLGqiMNHPb6CBHLdWhBmOC6EvTah6l6fZar/4M+f+dW+j2IS7X25sr3Ult
	eAKMiGbvyNdKFk1ZD/ALZzvbqTyZFaOas3ODypgFil6Otp56bePkM9gmSTHMpD0a5p5rhmAz7tI
	uCflK/oRsybIpjozBdLlLPuR5mTT9j6qLaBc/JNRW3BdH9coJgxLdOS4StHp5pVRR7P8KdUr/PO
	1hqEeE9nCNse3aNWpGvYliDZpt9jqw4+L7Dml3l9JSUaQpmNtU+VDaaOyBG3f/82jstoRE3J+KB
	jHhLkKpqTLwElxReXGuOaE9azQaKjhg7nKx0qPBX5mM=
X-Received: by 2002:a05:6000:47ca:b0:488:8347:a110 with SMTP id ffacd0b85a97d-49c6f5e9818mr1560854f8f.7.1794531343598;
        Thu, 12 Nov 2026 16:55:43 -0800 (PST)
Received: from [192.168.0.167] ([109.78.26.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8e794sm2106178f8f.59.2026.11.12.16.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 16:55:42 -0800 (PST)
Message-ID: <39881cfa-6f44-41fb-aade-041d9cdf2f9e@linaro.org>
Date: Fri, 13 Nov 2026 00:55:39 +0000
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
Subject: Re: [PATCH v2 1/3] Revert "media: qcom: iris: use disable_irq()
 during power-off"
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hungyu Lin <dennylin0707@gmail.com>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261111-fix-disable-irq-safely-v2-0-8e13f68c2ef9@oss.qualcomm.com>
 <20261111-fix-disable-irq-safely-v2-1-8e13f68c2ef9@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261111-fix-disable-irq-safely-v2-1-8e13f68c2ef9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 09:05, Vishnu Reddy wrote:
> iris_vpu_power_off() is always called with core->lock held.

This statement is not true : int iris_hfi_pm_suspend(struct iris_core *core)

And TBH as I look at the code I wonder if it should have a lockdep 
assert if that lock is a requirement...

  The threaded
> IRQ handler also requires core->lock to proceed. If the handler is woken
> and queued around the same time power-off is entered, it cannot acquire
> core->lock because it is held by the power-off caller. disable_irq() waits
> for the handler to complete, resulting in a deadlock.
> 
> Fixes: b9c2215bdedc9c ("media: qcom: iris: use disable_irq() during power-off")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 243bd845349f..1e183fc4e58c 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -240,7 +240,7 @@ void iris_vpu_power_off(struct iris_core *core)
>   	iris_unset_icc_bw(core);
>   
>   	if (!iris_vpu_watchdog(core, core->intr_status))
> -		disable_irq(core->irq);
> +		disable_irq_nosync(core->irq);
>   }
>   
>   int iris_vpu_power_on_controller(struct iris_core *core)
> 

Looking at the next patch I'm fully recoiling.
