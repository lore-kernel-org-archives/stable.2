Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546F03093B2
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220930; cv=none; b=sjXvCt1JuYzsl8XZAj0o512BzQHMz5xh4lEqAbpzkXpWLYYkEUQhfJQXUIFb6Ss3voITWUZ2pZ2jPfOsVcA85xMm81hRQ1mPTOGmyzbjOc92ThsZ4O3nlEuTpX1qrVk7xrPKZ58UBW5xkJLCQGKxBipXx9XX5JYKqjfeGBtPLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220930; c=relaxed/simple;
	bh=yi52HTwj5/V8AkISUNtnecpfAfVpbB7rUItTur0eknE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axZIyyEq9jKQfPBLzsh1AXtHt6x8YnuvixowcgFTGmWfDYkRo3FBwnD4o48tdwi25qxVbNdbstDkfVr6KBGi5rYsb5byi3FrmWvSC4ZVIeKNN6W+OqRKzB52TXpeG+Caiyy1SFieLXo5aj20gJue/T6v7SuDFuR4S4JbsLZxPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gp7LaGCT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gp7LaGCT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1164284f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787220918; x=1787825718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=73EKv/y0Hi9qvT6SwJd1WZqVvHE7yq7MtYlPP4tI3D4=;
        b=gp7LaGCTV9mM2p67TAdnwWtXn1B05kzyGKw0YbXpsvQx74eq9Z+uzLc4yofEBbYOLd
         iOeHcUJc47HgdJceYgvAuXKqk0oWV87ZmPdPwPTR6gC0WhM9pjbpEnLzwfRoa3lw6j4g
         HtW47v4NzHcs6suHdtmbYaiSXgFCFuQrq+It2+BcdmhzpAv/uXlHQQLEwjX+jFBVfPOD
         JGT/WpR/Whca6xcgE6CgT3mVYHbZn9qe+X4RCL/FFPytFSFMJYGpYoRQKrm9A7jRQplI
         rg50XcsnVlkRDDAQbz8HTrJaRuHRK5PNf8b0dj7b6IG9iVO245VNE3fgRFo6Xswazztz
         MBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787220918; x=1787825718;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=73EKv/y0Hi9qvT6SwJd1WZqVvHE7yq7MtYlPP4tI3D4=;
        b=tPYWRb8sNDwlFeZrrzC37wu6l49eiDl3vApPIdwxFlQeLSBc8woRTuy1L4SAU/x9MV
         Y+Hjuhx1UJOkDjmKmUVpPp8wJnab+61OXkY6vk2S8Ueim8P3AYITX+EToeRD6RMy9j16
         IpmJtinYT+jWfBTOiEw4dS0Rb1xrjgCUy6YA5YX526++9eMMF9R5zqRGBQIbbdWg3Oxl
         DRvO7EUCiS39lL65LjL4w3IXS8UR6zR44/YLE5YsJgE1sCfiuQhn0MYNe5Is2MZ/Y+zg
         zbVAT71bD3blutsOIQ6VylACPe5LVrkVGp/HekjLbdres1VMLayQPlhvcC/BAiSzJuDm
         5GnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4ZZutoZHpezC/rEe32FoB5Xp435sxnE1q0RQmRav3l+kliP3WcB04TX5gqzpYjZpULZorwrY=@vger.kernel.org
X-Gm-Message-State: AFuF++nDE9hT/i9Oq3/d6OPywDrRD60RyvHjx3xHzedQZyllpmHfXaSO
	HcRHBaiwvR0i4CzLzst2U2rzG1o3rcppiL37h3qPIDDypdpZue/zVqvibXfj8Tdu08I=
X-Gm-Gg: AR+sD1390qL1Wy02hZ7MyfaqXwNmuzWXUdBceo65my98qkrcNR8K5/xq38IE4eauJY9
	V063vaaL19gJc+KdMvVj3bkqAAPODEP7dDmbQcEXy+Uo0qrSSghcSiAPP+r0G+7T4j8xELaNgUA
	ojrSrYgrsWD8VagIDdKk/QNWcWDC9b/QhhQ1HapHPCiYJ02CfYBFXOJjAOjDytDP9VZpOEha3KB
	y/tuBehEKzl9CmxAyXl7jnhxvYqNNx7d2mpAUPZ8B9j3gj4Dq8b+RAsuK2unitKzZvA9tIA8bEZ
	GANuuwROP0MQ47KRSXM02HJ3Bi4wyw1iK3WM5nOZF99XbQlW1bxG0pWh6LaNJaddbLdmm0E4bCb
	TdyuXCu0+Y24Hn+RwtC0V5FRUHj8UOBYrKrCz8OhXgC2rLntxL3mJ8IWSnZlDz5eGnVWDcfoAjw
	/a+z1VjhbkKqrO+Hfw9CuQAz/eACJf+lWJEI74jYSsLYTICaMfq/hm/aQWg75uJNVBHlxBbP90
X-Received: by 2002:a05:6000:468c:b0:482:b813:8315 with SMTP id ffacd0b85a97d-482b8138536mr5738861f8f.21.1787220917614;
        Thu, 20 Aug 2026 03:15:17 -0700 (PDT)
Received: from [192.168.0.163] ([109.76.167.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d9783sm11601123f8f.37.2026.08.20.03.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:15:16 -0700 (PDT)
Message-ID: <f8d660b2-965c-4955-8ce1-3871f84b3811@linaro.org>
Date: Thu, 20 Aug 2026 11:15:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic: cancel reset_work on stop
To: Fan Wu <fanwu01@zju.edu.cn>, linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260819161448.76597-1-fanwu01@zju.edu.cn>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260819161448.76597-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 17:14, Fan Wu wrote:
> pdphy_stop() disables IRQs but leaves reset_work pending.  If the IRQ
> handler schedules it just before disable_irq(), the work runs after
> remove() frees the struct via devm.
> 
> Call cancel_work_sync() after disabling IRQs to close the window.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index c8b1463e6..abb9d0321 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -544,6 +544,8 @@ static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)
>   	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
>   		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>   
> +	cancel_work_sync(&pmic_typec_pdphy->reset_work);
> +
>   	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
>   
>   	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
