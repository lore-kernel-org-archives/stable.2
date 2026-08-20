Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC24071DE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221120; cv=none; b=QeYGfkC+2qighICxBDzH2gMRgbQsgR4nyyv+DvFsrj/Bng4r2JnreehfEf+yNIzyygaaiqW6Qhmwci3YDQL8eJq3jrwcz+In/eS/zJd/TITNg5OIXQLnrDxDtdOszceMte0KKImFIRUBXjZ2JGq+xJkfEEYzZMLi/WzEo6RkPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221120; c=relaxed/simple;
	bh=oU8Q8cxZ9N9b+kZmjkv7HR2+ZdQQqp1Cz2rEVM7YSDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=parvhZok7CARMw27Tc6cSUexDSHq4zqeETsVIYv3dYYaBLItri/03etlOlvPw4QMN3jGGCv0q1tcMcg0Jqka1ThSOPjJmZ3ERajOoXil7XDPnZAXteeq9jQ7A2V+yUR42BbTLTrlROJoyNCpH7o6ksWL7JOTcOb39VyN0Q3G2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dj2HhQg0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dj2HhQg0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fecbb7000so1085765f8f.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787221113; x=1787825913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jTRsDr3KJBScAQEjpdGgc1pnZRQT2r5s5VcOgpe4HIo=;
        b=dj2HhQg0Ugn/oZ0IO4A7m3B6+q3WUTqn2iVFeGDy5o6HM8tawbZ9BKIpZq/K4ex8md
         TGy0Uzt0rb/KterUNN61Hm6014ZcCJyNlSILbBOWyBHSPMDD6ER2tD3JIDtU4Wjpb1O9
         zjkDikGeYfdZkuu2et8GdGPVJkW+nWJFQeWooYsSPaxocu1Wn5q23AUvVg1xIyu/32Bl
         qlXh/bt4jOBKr+T0DuE5QwofJrrfDTdEko9r62+dqmIfrDmvwZ/2VLoS2EqAr95prRNW
         CqB+JPUP3exlldqo3zfz60Un18pxjw79qCL8OSvmSLgPjsQrOWa/HUlISosLYRlH95H/
         u+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221113; x=1787825913;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTRsDr3KJBScAQEjpdGgc1pnZRQT2r5s5VcOgpe4HIo=;
        b=aYQb31MdSn+ZITRI3E3LeP09RnJoI0QCCYNb9kvonIOvnY44Oe1XMDIduR7zaBs92S
         /8fjp0IIQVGSOGb8bKqf9G2MWRrAiI/AcMk8EpWdKF07LR5nfU/k21vxt8n/MXdef7/g
         PQNGKPlpX67gQDHasCu9QnqmObC3mCqt2EEEQ1X7KXKlo639dNTNr2OBdGLxH2SPqL94
         n24knGQ9T2em5Xh3dUD81hdlyxQNv8reRfTFSKvylfPCjoe3dkyEUjGfyPcv2kTxi9Oq
         JsiF2XnHtFrn+b6R7ArELcEIubAUFmN9/teGLRcMT2LB2mgl4cf8FiNUcHp5d0F6mAAn
         rXbA==
X-Forwarded-Encrypted: i=1; AHgh+Rpt6tIZBdEGn9D1FmwqBDmMGhQ11MLamJpiJPM0KMyEI9JguGxvUVmyBvH6TyIIbUC/J+Hwzl8=@vger.kernel.org
X-Gm-Message-State: AFuF++krf46KqsegH2JyI8nztCSDtahQARSNPXKyRUSuLxHHTadcVCuU
	u7VTqR1gsv1oBdPMKlx3ZVox8rgI+yTfwzmErIY+OJa5/gYXMxpJ+BZ/udxIbnzwYeI=
X-Gm-Gg: AR+sD13wVB9SAzpbGSj/ZrTuT33hTTsg68HGCIOPSeCEXRT2KVAR4bayMnkdjv1znl1
	iw1naKcSwnlVRJGwNh3wmGQ5tHb1/KPD5Z6thZuugsMzjLDaq4Lm/grT2ajkgz5ZmZSxS2Esh5l
	kf8j0jmGFtbDZMnxRtydfILnffI+QPWGb6FTgce4p5mliL2HJnmFSPTP/PoOHFFGxWBcQzkYVlA
	2hpDTMBr5PxKFfK0itGWz/lCCH2aqmioRvqBCCtV1JGnC3NU3hx/VWNJfshXZ22baaeTzOSB1iP
	KwQD7cIrwbYxIcq4ZpSc5w0csjAU/ohVD6akKyQfv+SXjxrs6hEARxAQcGahDL2D7PWg3otX51t
	MIg1hW3Ufjkrxd7mP96/dEo79EioXSNxoNNEp7s8Rb8wgOEn41vckwLivjzRPEKmfe+J2EsdSGy
	e70VgpvQM72248czNrdKv9Kgog1yIbrJg1EAUNWZd4aACkE0B5FN5Bt8+/L+DpntFnPs90pNn8
X-Received: by 2002:a05:6000:4918:b0:47f:8b9e:f44e with SMTP id ffacd0b85a97d-482b1fd48e7mr24038240f8f.12.1787221113240;
        Thu, 20 Aug 2026 03:18:33 -0700 (PDT)
Received: from [192.168.0.163] ([109.76.167.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm10947026f8f.27.2026.08.20.03.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 03:18:32 -0700 (PDT)
Message-ID: <3662ce56-7471-491f-b2db-7a87a4379099@linaro.org>
Date: Thu, 20 Aug 2026 11:18:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on
 stop
To: Fan Wu <fanwu01@zju.edu.cn>, linux-usb@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260819161950.77858-1-fanwu01@zju.edu.cn>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20260819161950.77858-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 17:19, Fan Wu wrote:
> cc_debounce_dwork lives on the system workqueue but is armed from
> tcpm callbacks (set_cc/start_toggling).  Those callbacks run on tcpm's
> kthread worker which is only destroyed by tcpm_unregister_port(), after
> port_stop() has already returned, opening a potential race window where
> tcpm's worker flush re-arms the work.
> 
> Use disable_delayed_work_sync() in port_stop() to cancel any pending
> instance and prevent future schedule_delayed_work() calls from
> succeeding.  Also unwind a failed port_start() through port_stop(),
> which otherwise jumps straight to tcpm_unregister_port() and leaves
> the same window open after a failed probe.

I'd prefer to see two patches broken at the "also" in the above statement.

> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Cc: stable@vger.kernel.org # v6.10+
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      | 3 +--
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 2 ++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index 35320f89d..f42c9e65f 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -101,7 +101,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   
>   	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
>   	if (ret)
> -		goto port_unregister;
> +		goto port_stop;
>   
>   	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
>   	if (ret)
> @@ -117,7 +117,6 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   	tcpm->pdphy_stop(tcpm);
>   port_stop:
>   	tcpm->port_stop(tcpm);
> -port_unregister:
>   	tcpm_unregister_port(tcpm->tcpm_port);
>   fwnode_remove:
>   	fwnode_handle_put(tcpm->tcpc.fwnode);
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index 429bd42a0..fdc379fc4 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> @@ -694,6 +694,8 @@ static void qcom_pmic_typec_port_stop(struct pmic_typec *tcpm)
>   
>   	for (i = 0; i < pmic_typec_port->nr_irqs; i++)
>   		disable_irq(pmic_typec_port->irq_data[i].irq);
> +
> +	disable_delayed_work_sync(&pmic_typec_port->cc_debounce_dwork);
>   }
>   
>   int qcom_pmic_typec_port_probe(struct platform_device *pdev,
> 

