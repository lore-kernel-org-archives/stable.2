Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D037DEBE
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487876; cv=none; b=MMSGv5hB9CXGqYEo3UORHI9XxKjGuWk2J7QbsB3TFnCVqd3Bi5fCQj23DRbzxCH3yKZ466vWoxUYH2DUm2n88leUXrNgyp29/WsLdWgOTXPuG92aPNJkFEgUIM0G2b4R6h8gNzjqko6cC8PXLX5+nfWz84jO2RGP7yREusB+E18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487876; c=relaxed/simple;
	bh=tBmbcWBOxRB/KGcfDMzhMHFt0EK9TotdSB1CdL8k/vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tn0PxEb7fhK1NVSbrMihjMXZuiphT4Q/MPJPDbso3AiGACL3mrdq7dZlu8nGdb6lzLjoYOjGwF4qhqSPEPlNff3/OcnTFthj3F828XacR8HecMNLxWUxMJrdhZeU2KCgGKkWSAD0JQMUMRqghDyq6YLoyT54fgLPFytjKHiJyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fUonJIRq; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fUonJIRq"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8e855bb8216so5690216d6.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1782487873; x=1783092673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Myp1/AJ7+f45jiO/7vpdpmC9cty6oWFhDB31tMdKwqI=;
        b=fUonJIRqCCj1KNtD2vbj9j32mKhBUCCve5SkhNzZ0+nUqE3YE7bwoyGCLrcHuZp8r8
         jcy4UtnLR0ybfpVVSMrqncv2DNspfWWsx/a3S0lqLMykoWh6B5tSQ+/m1pQ8/fXFmWvJ
         Jdiq41x+oSimz5b6ska3vnpn1bB6UlhXZPwXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487873; x=1783092673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Myp1/AJ7+f45jiO/7vpdpmC9cty6oWFhDB31tMdKwqI=;
        b=Kh8hm72JNw/gyz+fLcWGVLGJ7Ym5V2bvSQ/WzrFOwVSGOfjtjtiRgxks7UYIyXd99t
         wmlPoB41+kWMFD2LPyk3wNYB5vobpa0Z4Scbci7GcnH7kL7JspAe2WM3NvlHUbxb76v9
         z8XJyth1ORhtzrXrmUKzqXo/unM4dv3LRvYH+VWWPI08WS7M9ONE5CCzBuXzSiPsJRCX
         TX2SWawpzblIDlvJPd7aVTiaP63/ns+jpK5vdK40NE478dmLJVHKIE/mnsGF/wtODFZl
         X8Il9hO7w8pcgUxhYms5V2t6hkvZV9BJttgQS+ZbBs+IgWhleqLH3Cl6GBRgA782p3E3
         igew==
X-Forwarded-Encrypted: i=1; AHgh+Rrp8RKKRgRdsZzb1sDCZ7VTtaKRoz0LSqn2Y8lxsZZjNv+erh9ZLL5yYfyKHKXgc2ou/XHJf9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQ/urFKNDQG4ecBgW4RZiUuSnkfOKIIrtaB8t3BOZgOQefXXu
	8vP0rrU+Xtw3W4HmLnEAxpVcbogBHt5LjfBi05yv2KXG3TOBWy4LEzmgZ/scCahGDA==
X-Gm-Gg: AfdE7cnCoZYNFMp33D9o9MxcIZIgowQgm6PtKJb+/HvXX/LuxcJcVnsU717MOUiU4ad
	rNvztPY1PF9yPypGNFtAh85HRoffW5SMuQSVjr5TUU86LyShKi58UQV4k9Uc+uI0636s0Zunk/x
	I/Lw7qyh9yT5PUaj0GnMWlggNJjIHBrcBr/uPns5wjNClSdVP9UeHOLyxPbSMa/7b6GlTrL2NSt
	4gSPWGvyBwDpPjVAetJ1ZGpwdxqm8WXXPWwXhYqG7r63r3nZ8h85FbgrdPlurDyDOGBo/FAI6zG
	15SmBl0WwMIA4228d31oQtR9LhNwtx1tlx5ha/4rh+XkJA3oQ+/7tl2QlAaj8q0ATsw2uTV6cBA
	AJCTU+9pD0H2ef4ajEectyRpG8Wn23ViFEYNG95JchfHbwDRfBv9aYJIw4RWk5VmPyumiul3nvn
	hypQGOMO0=
X-Received: by 2002:a0c:fde2:0:b0:8e9:f62b:8fa3 with SMTP id 6a1803df08f44-8e9f62b91ecmr6028596d6.56.1782487873049;
        Fri, 26 Jun 2026 08:31:13 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-8df7ef1fe40sm213750836d6.4.2026.06.26.08.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 08:31:11 -0700 (PDT)
Message-ID: <51d2934f-0144-4303-af34-c7257ea02f24@ieee.org>
Date: Fri, 26 Jun 2026 10:31:09 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P
 init
To: Haoxiang Li <haoxiang_li2024@163.com>, elder@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260624065955.2822765-1-haoxiang_li2024@163.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260624065955.2822765-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/26 1:59 AM, Haoxiang Li wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Release both handles with qcom_smem_state_put() in the init
> error paths and in ipa_smp2p_exit().
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

This looks good.  Thank you for the fix.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
> Changes in v2:
>   - Use explicit qcom_smem_state_put() calls instead of devm helpers.
>     Thanks, Alex! Thanks, Jakub!
> ---
>   drivers/net/ipa/ipa_smp2p.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..331c00ad02c0 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -232,19 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   					  &valid_bit);
>   	if (IS_ERR(valid_state))
>   		return PTR_ERR(valid_state);
> -	if (valid_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (valid_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_valid_state_put;
> +	}
>   
>   	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
>   					    &enabled_bit);
> -	if (IS_ERR(enabled_state))
> -		return PTR_ERR(enabled_state);
> -	if (enabled_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (IS_ERR(enabled_state)) {
> +		ret = PTR_ERR(enabled_state);
> +		goto err_valid_state_put;
> +	}
> +	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_enabled_state_put;
> +	}
>   
>   	smp2p = kzalloc_obj(*smp2p);
> -	if (!smp2p)
> -		return -ENOMEM;
> +	if (!smp2p) {
> +		ret = -ENOMEM;
> +		goto err_enabled_state_put;
> +	}
>   
>   	smp2p->ipa = ipa;
>   
> @@ -289,6 +297,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
>   	kfree(smp2p);
> +err_enabled_state_put:
> +	qcom_smem_state_put(enabled_state);
> +err_valid_state_put:
> +	qcom_smem_state_put(valid_state);
>   
>   	return ret;
>   }
> @@ -305,6 +317,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
>   	ipa_smp2p_power_release(ipa);
>   	ipa->smp2p = NULL;
>   	mutex_destroy(&smp2p->mutex);
> +	qcom_smem_state_put(smp2p->enabled_state);
> +	qcom_smem_state_put(smp2p->valid_state);
>   	kfree(smp2p);
>   }
>   

