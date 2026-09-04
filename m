Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079113D1AA6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508953; cv=none; b=ej3vO5bhFbd2dbnH66WuRmqLfaV9Mgf69q+UXAywsqZ8xLOjkKCa2z40pVVWyrNRewIRCLicoxgr39iLnE0xv1siURmcRPIyVplCx9flFtkuTp6gFZOrJnrJJECkF0UK5+yOncFFn6dFVfUuGRzzfXvloNGN7mHRDh6uGWndr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508953; c=relaxed/simple;
	bh=IWGp/NWkgG/a5CvbWg4n6hVzBMccA2mG1yRRLqy2pl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZE556c/GbO5Vcszq05Le3/lopM0Ueak+Omx+1X1qx+fVwXs/CPsw9fq9GYefWTJUyZIG43RRalHSnnh5+OFGQFe2Q2BqoPstb8J7sLb+1CasBe69SMrUO/asQCb9Tgpycmg87YfPxmCmOAuZLcDCrVKE3ncW6VRgi5bD+dq/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAPZWyM2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAPZWyM2"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b13496112cso561851eaf.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788508951; x=1789113751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LxXdH2O4yqJZkq6Caw3eDtnAXG7jVWIM1Lm/pGgl0f4=;
        b=YAPZWyM2Ovy2duq5ZRJ7oCvZzUMRIk0DgNiA4QA0RZ4yeSvoc1XsFHs4JtN4Kg/paB
         OeVBE/SDd+6jeImYNCnzP+RrpSufqQavCpFl/fvkMgc1nQoPJV+3+bY+YoLOuQVSRAnu
         r/lw10l7Gx+/KLMomN6fAwLGF7H6ycgXrLWohQONPx4eu7inVPUbiUZB0Pf9vRyLSPy5
         vvZP2LFiYff4uLo/ttCsfwP/2EFzIm8WLCkfYlq95y9A7/Wh/FTV3U/DcwKSPQ2IzJ0L
         /jI7XIn8QUTXE6p84j687ta3j+ftK7nXR7qxgrR/eWoHFSv9IxpT+Z9T0/7i8+26aUt1
         sVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508951; x=1789113751;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxXdH2O4yqJZkq6Caw3eDtnAXG7jVWIM1Lm/pGgl0f4=;
        b=WpXLKwXM+oRclO50LiP/hRbkMFhvDOChC7u7QggoJusciyhM8+/0F15ZY5iIoESQcg
         SU8Lw6l7MORghBG8Z+1CFNITt8zUJcHb1IuQtTB+G2FKKC6FyecTSCcaYtlmmd9+MmEC
         lmDrOBRIB+Ugdwla5X77JTR4F7GqvxDFdbNiBXBOYDvP2n96/m87zNNs/Nj1Wu1Ib1kK
         +cWzqtTlIrYuf60q6JhTx/EwOgFgzdAzFM6qceE84lBWTNFh6bxdpN8ZiVk05yTF1ORj
         d4LKaw0Dnzd8bGoWKOu3tsbVCuy5Z6QFZZALuP6ut1/ntztXyRmodRQv04PJsgulPlqH
         L+2w==
X-Forwarded-Encrypted: i=1; AKwUvBxxGVBT4L6SpE9y6dWGTnUs5pl+gvxzgj9ddyxZuTkX7P1XDBYfN8u9mxZ+X6HChNQpMdDK0+0=@vger.kernel.org
X-Gm-Message-State: AFuF++m5S8SoRNsTnRRzpmIXsBihGo2qDl3GjgMFvtbdKhjPEqBP9FPx
	6XNGIlyQKV+6ceLkL8zkokFB1YVA0qWUh8lhKwSXYE84N3j33dLAFXf/0aaGdYBHB78=
X-Gm-Gg: AYBFou2nT8ZtgcDmHtpd/3MF+tqnvBnZNr/StwMqn7fPvc2MRQJWcT7lHEyGxyMnjPI
	buy7mePJoUuWX9Y48sNr6aS+N969IkfR0Go1r64CyWjfFDSRiQI0QseuZUkEyX4NhezD2Tp2niN
	B/QkO0ZjbIntfcPqSzN7NCPyeTHoOZ94McOxoUbKQbuv55GUhABKjHP0icYAMXTjasYdj4wf8UW
	DivdU8V4yGP0HQFV+0y3Ootua2xugCxtmxDfvRcYkUReJFmXepqHvkIgoh8jCNeBnAqwEXn2ghw
	uW7Y3a7F30BK7kIf39zpp7iP+8kDv47DqTT4SID1xxjoCq743FASWkFFvZs04js6byrJXzKtgdF
	spuujUtBm97lgVoD0K0R/M3pz5mtUGtzl2CiucbsEyFIu3wI0uaaQkWKEZrxdgjkHPEsk5vY78z
	6tUb1Vjzd0bn4Q/9HrfC9cF79kcGdvATIfv5jzX64YawhEDGAeJBxRz47TdIUfF6JVTyLez1Yxi
	vg=
X-Received: by 2002:a4a:e915:0:b0:6b7:46fa:16a5 with SMTP id 006d021491bc7-6b746fa1ae8mr1522269eaf.58.1788508950532;
        Fri, 04 Sep 2026 01:02:30 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm5356732eec.7.2026.09.04.01.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:02:29 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:32:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: rcpufreq_dt: add module alias
Message-ID: <app7EnFj9RMsdJcO@vireshk-B250M-D3H>
References: <20260904075635.14840-1-rmxpzlb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904075635.14840-1-rmxpzlb@gmail.com>

On 04-09-26, 15:56, Frank Zhang wrote:
> Add the missing `platform:cpufreq-dt` module alias so that the driver
> can be automatically loaded when the platform device is registered.
> 
> Fixes: 06149d8f2216 ("cpufreq: Add Rust-based cpufreq-dt driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 10106fa13095..32a508d82f68 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -219,4 +219,5 @@ fn probe<'bound>(
>      authors: ["Viresh Kumar <viresh.kumar@linaro.org>"],
>      description: "Generic CPUFreq DT driver",
>      license: "GPL v2",
> +    alias: ["platform:cpufreq-dt"],
>  }

Applied. Thanks.

-- 
viresh
