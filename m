Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC541244667
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323233; cv=none; b=PnResRMgWFenfYbyBtRAYG68ZQHIxzQEKANvUWj0zveesiOZ8G9e/aOClaIVm+Ro07C/09X88VGB3T5VKz+XqSgB9zrt9VDnxZsveYVROmW6QrDYva5NTsqT6PpExTgiy0r8sOkwn0GU7OsGcqdrMgsB+0CUB+PtfgqHHSbxD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323233; c=relaxed/simple;
	bh=/oGcSd7Y7Nz5jNpRmR1Y/39Pm+VKD2rEKV0PfmrNMks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTmcNRdxFSgvQlaS3x+/LU8lMwzGgw3eOSfmaztvFykFjGvKwFLSZbhC34hpDoRp4yvgBzOZuCYIjbaN0HYu/4rfS5VmwF9JFbpOp4nScaskJCFAElSJp9zg0QZ2nriQigRpk8TXlplp0nC24FkXMBIMLxDupbVeHdfawrDKsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAhE/kYB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAhE/kYB"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e041ea211so590611a91.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788323231; x=1788928031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OCb5pthu2o4M37AlowY4EfuVdlPIuSHyLISBEANaF0U=;
        b=CAhE/kYBK31sM1tkPP9E6WKzniQq8gSGYH+WNsYOgYiEwKMM+GIcI5kr4YEQZj9s/V
         fDEZRX4HdHFdkoxNio7nm2iaC+gfjKc4cnn6pOyGmrPrTT7nTN5GLE+NO/M17qFabQYo
         vNs4x4NhJHhrzodI9u8k31Qz7b8hjZ3P0MPGQqCpcA9+lCTRZBGFxS8i6RBQ2+ENvjmI
         lnYTB6JILkcxKGB47A6bRXCZPtpqgkm46UY8f8aZJgbDf/aT4fCtc4mqMoGBTDxWpfhJ
         UQK0f7urm3+LECBQqDWssdFWmoyggSZ63K0UeR8o/uPr/lx0TYpSuFGri0e08wSrW4ZE
         CX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323231; x=1788928031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCb5pthu2o4M37AlowY4EfuVdlPIuSHyLISBEANaF0U=;
        b=qmawEpeFYkxdssNy8PbXZrPoDqlH43BheLCkw5n/MPvfNQRD9EAieLpC5VQ0FByqmO
         3AdDoB+yluvf32TxdgM1g4FI56H09riRqGQ0MuZrTJsVt44WjZ7+4w2sVLXhrBy+fW1p
         YdJhfNhXTmBhWBAylNyJnkJzAjCk8ZrOph7JeD33tYNVTkVhYuTCNFK6WcPZ2wqV/Bx5
         C6neY5hXdpfq1KzZ6sg5mLXWIONVSoD/YZLaJSI/iUKQVLCpTJZtqleVgHMSZBW0CrYX
         rvrKLXLWsJqYf6Hhj3wNtorlczLj9S6D/LXkVNBqNv53jtIFq2JMkZG987MbRHFYWLYp
         XaxA==
X-Forwarded-Encrypted: i=1; AKwUvByVeeHr6VWvzqA/hjpJRYyMg+qWkR2hvcpxrGN+so7RrE9hh03vMfcPkFxA8HkJnLDSP4JNow4=@vger.kernel.org
X-Gm-Message-State: AFuF++kLX/OvLYyqt56QENWNI4MpeFDEOvMtYcnTBhq6sQeoznGY8R3N
	r7AHiiBSVjftOHj/ydgB4l6pG5wQ4+jdTtRedUb6YpiZmHgog3odzT3Ez1Iq610S3mk=
X-Gm-Gg: AYBFou2H+deO54pHkg6ud1hX6LcRNowOdaJG62dHG7pX0qAu4l4eno3FdfpfLggXaun
	uGDdLHZAg8/oeLPwvIBXrnOm0m6ocIOsLtVL0UEg6ctwD101X31vvptI876FTYC5IboDGS+kzrF
	hWojM1JIJT/J7eXhj4LtNnOjiaIRPEJAzMFsSWlzckjSJQ1GlNPSlcj258Bmv+zD4vk8KIGFVZa
	yTRxcrvxYJQh1eJ0n1m9YOoHnazfvWS4vezYYqecT0aCDfWzeLlawUQ1547OXog0kxTMh3RoeJt
	gVFBWeME4kGMChNo1jFVRAJ6WaZCuygG2Ze9n0lAjFJCIOSLmmlqxqgfgvSDvV1scH6qSthEDq8
	W6CQIm5BuCiK9v4jDiLMrM9Iack9la8F4CBP2in4C+6WtG7puu7cKw8sptX+vWRYfLefNRVrt8R
	mmr8Lp/trkVMvCopT6maulBemksDgRVyPWYaDR6biI1WC5SKmwjFygPOqbHe5jQ4w=
X-Received: by 2002:a17:90b:1d4c:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39aedf0956bmr2969675a91.6.1788323230970;
        Tue, 01 Sep 2026 21:27:10 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07baa594sm3578295eec.22.2026.09.01.21.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:27:09 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:57:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v3] cpufreq: initialize policy rwsem before sysfs
 publication
Message-ID: <apelmtFEMcyXle8m@vireshk-B250M-D3H>
References: <83f87db8-fa13-41d0-ae52-544d22e228e6@oss.qualcomm.com>
 <20260902041915.3453421-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902041915.3453421-1-runyu.xiao@seu.edu.cn>

On 02-09-26, 12:19, Runyu Xiao wrote:
> cpufreq_policy_alloc() initializes policy->rwsem after
> kobject_init_and_add() has created the policy sysfs directory and its
> default attributes. A sysfs access can therefore reach a policy callback
> before the semaphore has been initialized.
> 
> Initialize policy->rwsem before publishing the policy kobject so sysfs
> callbacks always see an initialized semaphore.
> 
> Fixes: 2fc3384dc75b ("cpufreq: Initialize policy->kobj while allocating policy")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260830155301.2713780-1-runyu.xiao@seu.edu.cn/
> Assisted-by: Codex:GPT-5
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
