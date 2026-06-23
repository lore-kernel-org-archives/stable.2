Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37382FDC30
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230035; cv=none; b=pqMBlzDwUSqlGkmUwOGYL4am8AbW5M5YWPysOsFdojBqOMJTFuluP+vuPzjuhJn5WWaUHzDcackt6JCVJ1gXhl2pRLBWxM8vApPz3LVyfGY9yZd8Weav2xixgywVQbk2PiY6doDcm2NrQkNaZvlRYS93x6bt4mZXVLrNmH76HYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230035; c=relaxed/simple;
	bh=zYXd6ReU2WdIxJbOFNrBVnjOGqbTxv1cNEEG6ENsyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOBLkPseWQ/pR1PMccWUIRTaEX9IjHHrNTln9aLa7Qmn6L0u5mikCPTrzvDgSh8SF7zUKvoBDBI+tgXJcLtkCcLfafwk7LAmys5Ze9+hpkeq8DHjpu2K6J+vZZomnNIwabsk/+YgW78o4uXa5SIFPW8wRgK/rAwV/6f6nq18Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=TplHOpRx; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="TplHOpRx"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d0db9372so46754921cf.2
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 08:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1782230033; x=1782834833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqPTCm5YKqWQJxJHEkoz96y23iqGtdrjAIIsxTeKqR8=;
        b=TplHOpRxxkKEVbj69AkhMrHVomYawMCyP4bLfnOyq/jBZrXkIekITaun9qKutsGkS1
         MjiW19zEzdDDcdZHnY+Ji+ZyQUScG/8t+67fLBI6HA3KCcpg10kEqULJsZe81e9s9Z1h
         3t9FnqjKHNO9b1BFIkC7caopC7GFCAC7hReQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230033; x=1782834833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqPTCm5YKqWQJxJHEkoz96y23iqGtdrjAIIsxTeKqR8=;
        b=AApwMbvGVzgXhpUdMJxWwkz20qs0EOK3K2opAnxpj4nNhJHgk9+2QORRwJM7TG3eDD
         SWcc8LFW8pl5r24PyvE53lVhVI2KrMaCQ8FJbCJIyKueseHb44mG7qvGjUzT3w4dGUua
         y8+J87Cc2+V94UTOrDaaOvlKAyxc/Fj0MkSIF9PXmBM53lV5AE3bB3RSqdwQ2R1BYjl7
         hNxK7TR299VOdIfBIsGTI8S0Q3Te8L7jYmaTgcQ1GSc0hYsOMIkFGFSIW8Kl27FZ0XgS
         w3Dkuo4VHpr+iI/RAOH7NNGauxPXnGrlkwbhxdCxSpfae60xr87pDjKHDL4PCMjZk4uQ
         vGiA==
X-Forwarded-Encrypted: i=1; AFNElJ+bzx7xdd7HMbIdvTKICB1lEdFdgv3fPv3p70tc4zJlFM0c2HtHNawAv/Ac8xYVrqXnA3Dr7yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOUyefzGuofhg7Jrm4RxE24h+5WTXwRoXp3kaOEL/4DoIffiV
	qbDaLgB9kwmiskNpMOisOxoVMpCfbojFEVWNqnFk3c/bs8twl23p3P69casj+XBI/g==
X-Gm-Gg: AfdE7ckOrTmikj7eWDtatgqCezgPKQH7IMQAmvla65zEGcSnUP1JxqTx+osLX5k1nzJ
	kZelaic82NsHIm2nXif+3X8F1eVL5XZZ2RfkBDH05CX7XKT6XTJLAdQjAl7Vh/B/XveyqsOTiiG
	WMMg9uFSjyZDxzT9xzM7LaF9782QYSxD9xb38ZcVyplUQjMAfw7OL4Iw85aUk752fBkJN0G2Y8c
	wUns8EQZe8gkaSCjzMA+P48+8lgkoFSeJsmS3DJrt1+hZD/QBs2TRuue3m8d9NWxAwUt3kW6p3t
	LosI/K7D3jLqNWPVBx0xQjOuCVZpKKCS7uVVanVGgfYrRLLz2X17piVkA3fyAP597B4atniDXYx
	mBVNodcS+kyy9qH2phjvX+c354viYTQwSLA5KiFCO4o5gux4ZHb4OlREGg8tbm/KAtlhhhQnMR3
	GoZvMaT3bR
X-Received: by 2002:a05:622a:91:b0:517:9e5b:919b with SMTP id d75a77b69052e-519e4c8ed1cmr286911061cf.47.1782230032727;
        Tue, 23 Jun 2026 08:53:52 -0700 (PDT)
Received: from [172.22.22.234] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-51a514b4f5dsm26143431cf.1.2026.06.23.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:53:51 -0700 (PDT)
Message-ID: <526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
Date: Tue, 23 Jun 2026 10:53:49 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
To: Haoxiang Li <haoxiang_li2024@163.com>, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260623031831.1788454-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260623031831.1788454-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/26 10:18 PM, Haoxiang Li wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Use devm_qcom_smem_state_get() for both state handles so the
> references are released automatically when the platform device
> is removed.
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

So I guess they were never "put" before?

This looks OK, but I'll just mention that the IPA code
doesn't use devm_*() (managed) interfaces.  So it would
be more consistent to just call qcom_smem_state_put()
at the end of ipa_smp2p_exit() for both ipa->enabled_state
and ipa->valid_state.

					-Alex

> ---
>   drivers/net/ipa/ipa_smp2p.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..d8fd56949082 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -228,15 +228,15 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   	u32 valid_bit;
>   	int ret;
>   
> -	valid_state = qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
> -					  &valid_bit);
> +	valid_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
> +					       &valid_bit);
>   	if (IS_ERR(valid_state))
>   		return PTR_ERR(valid_state);
>   	if (valid_bit >= 32)		/* BITS_PER_U32 */
>   		return -EINVAL;
>   
> -	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
> -					    &enabled_bit);
> +	enabled_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled",
> +						 &enabled_bit);
>   	if (IS_ERR(enabled_state))
>   		return PTR_ERR(enabled_state);
>   	if (enabled_bit >= 32)		/* BITS_PER_U32 */

