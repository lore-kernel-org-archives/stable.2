Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F323793BA
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788238213; cv=none; b=Uov+PaZiv8fwAyKeLvwZF8yRNBUfZ6MF9vU2BSs4Y7kIUM54bv8z8Mf3secjgX3ks1eYJ3gtKvP5ADAnCDlKOT3CE8CMrV1o0tIpIyN4WqGLipmml0weYj5ABH50Lock6PxQARrrbAzwSf7emccNANTv6H6oByh/BmzaargMbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788238213; c=relaxed/simple;
	bh=VGJGL8L9QC4kuEP/yBDXFyx7IFPt6JsipVhIMzL9c+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBm0u5Gcjs1FzmD1qX8kOoqj2HPi6LpVIF8FRjwCqO1djQBPnP3A4jX2J+ogmPX7Z1thHrRC8YzJnveKBu1oduTDkispYMWU28pU6YxR+wkzE4n2aDlUWkRjQsKCgZJcydCTGDPkXG9S64M4EBdBIyzRgR0pABK1sZ6woEwMLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofIwZ33e; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofIwZ33e"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso533111a12.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788238212; x=1788843012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t4jQxeaDZy/Unn2ivO5mM9MmmCneCWF8T+UGXcYEy+U=;
        b=ofIwZ33eVcIzBo88RXKqk+Y54XEtIYN+WWwh7wrANj35DhRg9AxnL7LaYdWuYuuGUg
         eFpM+60u2SAc5JF8CpJTekemNh48CD2mvL/lcIS/GyqpxvFclJXQmzP+V8sJ8ZRUZRsv
         3t8/V3hjk3mhuMNrd4P8mJ4XBo+fCS5WKr4HCP56jcmkkdVOYx502CmfYh82xvzM66cX
         Jox6Im5bpZ6fRDYvIpy2QrWe437JEAlXVNzb6/Pz5P3D9OP8Rq30mAFwOL8AAi1cYyYi
         ZbU3n3cTS7IPhQrGFdj896VB6AbagA5GrcgSMHIS0scPB8FnQf3x7oTmJGgE/d9Dd6Fp
         AkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788238212; x=1788843012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4jQxeaDZy/Unn2ivO5mM9MmmCneCWF8T+UGXcYEy+U=;
        b=APQSJzENFl6sJnUCR4T4N10mL6rPPaVXsjDkXMakI362eJ66lcl0/azoE5BWwX6BOt
         HVJ8aF5A9pegMnYnilokdpWgMGM8bQ4Z7bax3q0vkU0i1IA34nHwGqSPtY1n6Md129SC
         Cl4y98hxlkZGbo+gGMYwpSrw7djRs5C4HnbrTDwq1Dwqv6ocyqvuyj0DKgmDFYYA7TmE
         7yc1gqnSCXuoawRPIetZzOmnkNLxYP6nSOXs2KNVftY53nsREMgOxrOhB67ZKa6UpzCg
         IE3RWxK+bLd0pYNYE2dGp17RUoeNTp5LSRbAAmWBd+1FmgXVgfDhMay0plGzRO1vS/c7
         /tLw==
X-Forwarded-Encrypted: i=1; AKwUvBzmlRWIf6qoDbY0wzyiyzolsaKb+0CUPO/sPZr3lIS5ipnk021RdYY+BYkvXGWUPOoV5b8wQyA=@vger.kernel.org
X-Gm-Message-State: AFuF++mRZUWx8MZjCuEgq85NCLTASOQGn/A7xCudy69CZYp5ESAoEk9A
	5WeX3hGlGJGl2lOCNN2y5iFaS3Sh0GeiQK8OD+cF01v3sVbqBdhP9M7kFTHjLmolShM=
X-Gm-Gg: AYBFou0I2GNA0hTQczeB64F34Wxqk7kybKUWGsVmPg65LhH5c0riUmS1OmogQEJKJVw
	wbW2aAyV/HMyEGutEp7WBM8zAcHHMbGnEBh8exlnG9jPzedQ40n0yzWGbphQs/CfED/gvdhVrkx
	otv6gekN/4eMmcY7I6WS9+mJ7fnT7qDgSIJ5ItA36agh9dPG12Gp7xh9VWKndjR4iCpSTESf+GK
	eFrIAjYSPzB2aR/0u/OafLdG6UFrqr1URXZD5q+AH/+4/WyRlJ5aVG5JugS9rlJFHZyw84nKB/v
	0tlJgjOZ0qQj6Z8acVK4mIy4hjc+OINHvnjfFhhAcxSHRWIX3XCFgvjiY40p8D7EdTRqP7LD68F
	CUj26On8kD2GSDUPtOFR/ZtQO82NAZsn63v7/iZVE6/VismJO/aO7pou06XgI2/gwG5LvYMOEKk
	ANTGMC8VPxqNyIw9eh8GGSWxIWj0myYD6lGOUBervv5YAZ1Z7MYvsi2USQqs/WTtA=
X-Received: by 2002:a17:90b:4a81:b0:399:1f8b:d255 with SMTP id 98e67ed59e1d1-3991f8bd96bmr1896599a91.5.1788238211608;
        Mon, 31 Aug 2026 21:50:11 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm51016251c88.4.2026.08.31.21.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 21:50:10 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:20:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: initialize policy rwsem before sysfs publication
Message-ID: <apZZf21vsqy3o_WQ@vireshk-B250M-D3H>
References: <20260830155301.2713780-1-runyu.xiao@seu.edu.cn>
 <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>

On 31-08-26, 20:13, Zhongqiu Han wrote:
> On 8/30/2026 11:53 PM, Runyu Xiao wrote:
> > cpufreq_policy_alloc() initializes policy->rwsem after
> > kobject_init_and_add() has created the policy sysfs directory and its
> > default attributes. A sysfs access can therefore reach a policy callback
> > before the semaphore has been initialized.
> > 
> > Initialize policy->rwsem before publishing the policy kobject so sysfs
> > callbacks always see an initialized semaphore.
> > 
> > Fixes: ad7722dab729 ("cpufreq: create per policy rwsem instead of per CPU cpu_policy_rwsem")
> 
> The tag should be 2fc3384dc75b ("cpufreq: Initialize policy->kobj while
> allocating policy").

Right.

-- 
viresh
