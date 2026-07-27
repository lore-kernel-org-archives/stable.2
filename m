Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674CC3F39D4
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147652; cv=none; b=kU1OPsF6aKr4KoHgPYI452s6omjLKXRN1E2Jh5P24aUVSNCP3+oKvJJWf7vRIsZEC71ZwYL2laJwpBFfK7fcuNHyvpXl2zH3uTcoHdXbAIOgwiYjQQmdZ1afZ2aeyRipTmxsMQgooCnUjuPWYTbWn6yeWMY0zXsg9mwm6hWUDRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147652; c=relaxed/simple;
	bh=VoXS2qISjgbEj7DrZplv9UdB9S9LcMbT7fAL2IrBvoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7SAQ7J5vN1RVGolFxUfqVLZWBznlIUvBiZgMciOUNEyAM0cRhUHxwZKmMufe5a6hGyQQFR3yhyarZn6sTnbMWl0XTyC5SXw0tRRBjnCPJjGTmzbkDdDxDNMJI5RObjpXUUFVJWMhMkTQsU75SfAoft2vwXR7+OmLgm6+zfsxPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a67h0+/l; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a67h0+/l"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1835071a12.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785147651; x=1785752451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uMEQZfc1c9H83jiVzjz2a7rMNH747ZhRmD+viGRTQsc=;
        b=a67h0+/lLQW0OFGmTVtm5p/QujWnIYEgX8qY6aYqv9fbBAiGhfkXPQ+dsnMzGlU0yg
         pfAtHD2tjAk6sPie7jSGTd+ws6TBa8+rkixAvGeNmBg3Zwn336/Onhbzubovkbrz9LZR
         JML0gR4hghUtzJrFMZhS1nELzPJsfQLGI95qvPWgYxi9eGBBEq9/9X/TNibZacbj2e3G
         vXsZZrni1fCaQ3axT8rsA95ynlMG8F3Ibo2PwX+YtgYxz6x4v2EKOfc49BpfSb5Yf3u5
         i3Z5dXJF++ESXDjOco34vg1iEcsS2WHNAc4evH/DYKw79JSq7rqN+lTZzgeT6r68xirg
         8OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147651; x=1785752451;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMEQZfc1c9H83jiVzjz2a7rMNH747ZhRmD+viGRTQsc=;
        b=T/HO+pzFuDOchv7vvQT3MKKuAK9tDY9AHJGxFTxpBNiC9SZ0DXvMZG1k+WKl0SgMrX
         H/TXvy3O0yXB1PL+g7BD32Xe7/Zek7Hyo0sbvEEfEyqM6gHwrqy5RiXpKceEJeuo1R+K
         b6Sg7VysCOliW851nIVUUPv7fiEF/6UWnsZOggJU8dqp0tbrf6xe791+mGLh6/7qAepa
         UVOTH6XCB3xLIt3g6mAcwNZPaqxZ2SkhkL0ONtkfKPYGsqyPIXk0II2QzT+Bb7WaXQa8
         89QuvIBJkB2UvOBWPVV29ffQnLfuSORgPPezLFAkjEA+UBpzUyEEBMVPpB249mMtY4DR
         WPCA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9vq4r2d8Tj3IAW4KW4lwur/1CflTscl7pUjUwGAA1hgOlh/aRbj4ICVqA1h2xA1C5S6T5Oy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvaXN1wSC/etAYJ6MMI4a9zhi21RM+chaL5XtNaDiOR3PQFT4
	SU0avSDgpgbPW0z05UwsnSDWFuD7/oT021tzS0zDIpuzof/XTWMxRs9aqB5s0igOKNU=
X-Gm-Gg: AR+sD11PzE0BInyCBjWUf4BZt3+vWw6BfhxpufmB4Yt0xrxdIAWtne+S3xrzrDScdUI
	Wf2Hngde0YalcAVQdu/AZhKdhuqLCW9VjwcBmvPIJoCZqB2nzbqPUWE/2s5Gl6sDhzvrY15sRVR
	jxY/JY3QuOlcEfJiFB6DIK7TYFc+OB/+f4q1JMLY+xyLB3wa7wa2lmxtOLN4pIQ/EssgFftJKMJ
	zpXQ2F6PJTYlOO0DUExu2QmnEvy7axd+HFiDq41ORGX9jwXDIQdY7fS7O/C8i+4b3z2EweFkVC1
	NankdZ82vH/SIXHLNEhSuS3/RiKmwjVX/WJBTtctPMPEVjrQXmRd7PB97adoRbjuhpTn7HxneBX
	Z62aAmD5b/bEmLnE46eLl5lBtNWOyUIO9wtNGTN34GKdIrnTd4xfW+OqaHZZWAsTD9zoGMib335
	9fHky4zf+uv0ks
X-Received: by 2002:a05:6a20:d497:b0:3b4:8f18:33a with SMTP id adf61e73a8af0-3c67dadcc25mr8054267637.1.1785147650540;
        Mon, 27 Jul 2026 03:20:50 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc593b57sm43881131eec.25.2026.07.27.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:20:49 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:50:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix possible memory leak in
 powernowk8_cpu_init()
Message-ID: <5zxdn4jnqu22k2s7roo3wxykwsusah7mp4telybmzlc5zgilac@pf5svblpx7nj>
References: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727093553.98246-1-nihaal@cse.iitm.ac.in>

On 27-07-26, 15:05, Abdun Nihaal wrote:
> The memory allocated for data->powernow_table inside
> powernow_k8_cpu_init_acpi() or find_psb_table() is not freed in one of
> the error paths in powernowk8_cpu_init(). Fix that by adding a kfree().
> 
> Fixes: 1ff6e97f1d99 ("[CPUFREQ] cpumask: avoid playing with cpus_allowed in powernow-k8.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only. Issue found using static analysis.
> 
>  drivers/cpufreq/powernow-k8.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index fe1f499b4fc0..c9bcc6f0ab7b 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1085,6 +1085,7 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
>  
>  err_out_exit_acpi:
>  	powernow_k8_cpu_exit_acpi(data);
> +	kfree(data->powernow_table);
>  
>  err_out:
>  	kfree(data);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
