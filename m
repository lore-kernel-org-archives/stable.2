Received: from mail-oi2-f23.google.com (mail-oi2-f23.google.com [74.125.231.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0304E1C94
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647491; cv=none; b=W7ebE6Fhn4/g6e2gkVTKXIoRi5Jv3KxxHS6Plp7OpHAqKWuWIZ/lf+aQm9rhIWXfiO5rXdYfsdIRb0mi5P3i3/Q/xFPs7G/dQIhZav0PFiwDjVAzLmo8hUJf2//zm7CkwoaA6j8faYiTEo/zLDIQAM3hOVOACEiBLzJmedaRP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647491; c=relaxed/simple;
	bh=jxxrLK1RVTIembjFJi4fT/dtsvhHsrbPFHD5t5ovx+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGcGrS6ah+qjJt5/9JyJyhNF/vyg4Q8SnqsJs+Xr3P80No8mmOHcCdjTfWMfHprbjKF8XwM4pMCaBusmkRQ93oJjloou4FhbY7gxUAOASU93zprFdpw4+/w90MwXENaj/RwNpFUDslBUi4sUc98lwmi3d2faJE4AC6zRjoGnUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=brwS8Gzi; arc=none smtp.client-ip=74.125.231.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="brwS8Gzi"
Received: by mail-oi2-f23.google.com with SMTP id 46e09a7af769-7f4f0d37dccso431123a34.3
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1789647461; x=1790252261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/CnLftEvKl62DKetab2YvCs3DqAzBULF24/3TZ0i+E=;
        b=brwS8GziG2zICsy+/ioB/6JStxIhgk1QG8R9AIZ4BT6wcDuuef725e5/d0dRyWzPyr
         4hFoyHKX6D7QwoIL0ItSrgbWcOElOZDFKteQP9tHT69O/KceU2klTdpttHHvmCm9z2qV
         4tCUo9oTUyOTvmwNtsCVuMwdDpzGrWosoOZUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647461; x=1790252261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/CnLftEvKl62DKetab2YvCs3DqAzBULF24/3TZ0i+E=;
        b=qq6OfJKr36Yvic12+C+x28BH9oQRei/ZMYMSntT7RW6C19uoZJbes3zM+JAFFYkcGg
         4HJXDUA/XgKQEfQENNOjdOyA9EkwhSnzV3Tp4ceQSpCy7byOpcYuwtoL/UzbXif2J5KO
         FeBGHjy+5cMV+Gci7e7VSg2tVZsi/ml5qku1GW7/GaHX34r7w1iMMsq5gb35ut6rPUud
         bJvOuYVgJqp4eul0zZvFUX7c2bWPeXN/FKMmn5foh23nbYuZQLz3HWvjAecxB1FJgS5u
         /wRVlbnWOSjWJ6qBkNZ9tV2TSwvnwuAj+2rcAm8OFMZRJ8Ndw9OAtLbq/+/sfO65wGGq
         eqAg==
X-Forwarded-Encrypted: i=1; AKwUvBw7Ug2ez/6OQysBNbGd3NsHEIsnPUwE1Ghkm9tVgskj6pQuU/O7nKoJp5o8XlwrILjx1f9zqcQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k6wkfgq5Yg4f9fZ6Xs7Bw7yq0OGIoy1Ka+0SC07kGGtlijW72N
	Ug0uWitZr8dvzXOe+Dhi1m8wJAkD6bgKss7bbV/NW4ditirudkBIFCRUolUBh2ztsA==
X-Gm-Gg: AYBFou1Wn4ZnUjFTV6zKbfU0lQ5O1vvqjuRi97JOcBULiM6OAZmiVhiNRY74WlPiJaR
	jLAk84uGeQsFKJb3cSaQ5T1hybjUsQiNK8WyOIO+lYUIcAqc6D7NM0dT1wp0YFWOO1mDXw8Dt4Y
	2RGdMwMYKCBeTBfzj/FqN1JmCbyVSIfu14GsA0K0q3EFhEmIPb0zae+2QXXTuH1kq2frLC8ua5A
	Jovvspg+R424+Gdy2l4NCqen5CStfzFHQlRVG1w+3BpzYn+coMKMgVyZP/b81vBVHvJqFgp6ltK
	CJJ5ysoOrscl6FQEvSHPBO4bjdhQHVpr4pUkr9olP24BoGyi0OmuOLB3TGK17IsJozn5rd0dWxI
	3tK0mPEWdSc8sxPrO5NRXKppdwWlvLtEVMZWub6ZDkKZFl8GGA20S/aZnyVWyWgnViCcr9kGJpQ
	Rgb/Q1LkdX7wKS9HQ710cYT8Ml+6qHc4bUZetwqLFKsv3ux7DeiuI/SDSnj/jGDPppwNsp2xt02
	sY/
X-Received: by 2002:a05:6830:83b2:b0:7fa:ac4f:785 with SMTP id 46e09a7af769-80b2dc1d7d8mr6835533a34.17.1789647461009;
        Thu, 17 Sep 2026 05:17:41 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-80c46cb6675sm2805680a34.16.2026.09.17.05.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:17:40 -0700 (PDT)
Message-ID: <692ed9ca-fac1-42cd-a514-517f6903f8d8@ieee.org>
Date: Thu, 17 Sep 2026 07:17:38 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: Fix enabled_state leak in ipa_smp2p_init()
To: Wentao Liang <vulab@iscas.ac.cn>, andrew+netdev@lunn.ch
Cc: davem@davemloft.net, edumazet@google.com, elder@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, stable@vger.kernel.org
References: <20260917115216.2149867-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260917115216.2149867-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 6:52 AM, Wentao Liang wrote:
> qcom_smem_state_get() takes a reference on the state, but
> ipa_smp2p_init() returns without releasing the "ipa-clock-enabled" state
> when the bit number is out of range, when the smp2p structure cannot be
> allocated, and on the error paths that free the structure. Release the
> reference on all of these paths.

Where did you get the code used in this patch?  It doesn't
match what is currently present in Linux v7.2.

This issue was reported and already fixed:
   96ca1e658ae45 net: ipa: fix SMEM state handle leaks in SMP2P init

					-Alex

> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ipa/ipa_smp2p.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..78f6df2cad76 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -239,12 +239,16 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   					    &enabled_bit);
>   	if (IS_ERR(enabled_state))
>   		return PTR_ERR(enabled_state);
> -	if (enabled_bit >= 32)		/* BITS_PER_U32 */
> +	if (enabled_bit >= 32) {	/* BITS_PER_U32 */
> +		qcom_smem_state_put(enabled_state);
>   		return -EINVAL;
> +	}
>   
>   	smp2p = kzalloc_obj(*smp2p);
> -	if (!smp2p)
> +	if (!smp2p) {
> +		qcom_smem_state_put(enabled_state);
>   		return -ENOMEM;
> +	}
>   
>   	smp2p->ipa = ipa;
>   
> @@ -288,6 +292,7 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   err_null_smp2p:
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
> +	qcom_smem_state_put(enabled_state);
>   	kfree(smp2p);
>   
>   	return ret;

