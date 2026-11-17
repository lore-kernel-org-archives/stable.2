Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913604;
	b=obHPxaFcwFQYwGHLx8Y2lv/dV+FwW9tP/pUMh1GmJNanXkBzYTWOkoA5NEVkb7B+d5FA
	 3iN+8obg/EM9v9pKfG+EtqE55uVuQLeLUJZShrX8f91fje7wOtUqU02haIc9hCEwedtZX
	 sCdx/SpR8KOnh4A807zaUSB+DDPTDP5LGDQcgMK1kq9hyoqfxpPrGUxupfHHMaM0oafnT
	 bVOSFbAZuQ1b3UAwtjy0LqO7/aiiIfWJFDtOv9rQ3GeT5crBnj4SDiWHlyXW3H/nYfkGy
	 PcxbXLxkhxgih0jo7L+2EVrqz7MWmzttudnSrAhiyE6K0E51IYnIfKi1g88P9DLNT1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
	b=BmthGW1QKSeiRgihdnAdmk5NLDyhvU9TyzRzZISv5Sdl4IkWrWbA66RW9aKBqfDQAypX
	 PVm3I9+9rUcSMkPFsh1+WeO9PT5br7wfqhPlhueSWs242Wgc8vErvqtU9GtDwgEVMe7CM
	 XmsRvhn+SRTRJ2icNAL+F06sab/W3iLH39sSi8qQ1Ehzn8QNM/V0qG1DMSxAMRm1ZX6Iy
	 WmmvahqEBtsGMxgyL5EOd5HyBobSf1rRWJNwzuAVKv5/Riw2sE0ybdajuIJDukmiSv6uC
	 n7HKqv3LAnnACNJpHKgsF017phW11yoX+YHsR4EhrrLTjRkNQhaFGkkttOQfw0d4+Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fZGLg0sl;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B806606A32A
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 11:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B806606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fZGLg0sl
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so6265917c88.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 03:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794913602; x=1795518402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
        b=fZGLg0slbOqiT/LgH+j+6JL3838bVPAZoUKYPPR5vYSOWvED3b6bDzIquyykaT1Qt9
         qzL9aHijplMBTNi2OHnkxnadG0EjX178DfCzHuh/SK+NOn3HKTIeU9nfMJh/6Y4EPHni
         TCC7eKQIZ4lalbs6xnkiO5YYdzm6e5vCLLy9LwPHc6oWTnrfY0lGrv4FB/xLEEQciJQy
         3VO/z4yzqoulFpi7H02jGqebsvBXp60V0EBEVyl4i8b+CazGVgBJOCihUwOVTgqszfsZ
         rim7Jdpe748KgiWtnsG5GLdr7ao869tjNHgOGaKyf10CGcBr0uMr8KgYWvV+mUYWI/4v
         IQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913602; x=1795518402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4s7yJbpQX8syBD03XjGhRC32jwUYZoWTRv+UwUgeKs=;
        b=Dx8LVmCrZkooWpciCKxY3H67Onq/Nw7brv1AAq5R8Wvpy9YTBoEhvZIgfzANPnxRKP
         4zy2N+wboEYgyxrfoh27wmO5J6lugdm6Q6gSO/ZXakNWylX+0kfzvqISxPpi/HEFpPYl
         H3W107n3Anz1mPGywi9I4PH4XnFl/oLyUdkNbFOSUXNT9+0ctNp9xchE41dIFlEp3UOS
         OUYSuzCIDs8+ts+FQCFQR53cxbZ3uXYtYzMXVoPKm3cNBsxRB+h6uHCHQA4KwGeX2sym
         wwWJWYQIO5UbjKcf/SnsdfBuE2syBv1wS/H3h/rDFRBKUhwKSHb+EcLYCTQjVdv2QTrF
         CIrQ==
X-Forwarded-Encrypted: i=1; AL+hErExIyMAgUks5jq2w3RFmRY6L+rHH7DdmPxjDxXavYFwIACO4khjsbvB410A0sJ4Nz4w80Zh6e8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Pu+6/AtqVKa8J8msjUhFDskGY3XNCK4azQ/Xs3AQM6x8QaQnH
	Chw/rgKilnsRzufUQiJ0ulzsLb1ZGkLz1ptR1zPJRbl9C3dB34KonIE5ycpVZQodKMk=
X-Gm-Gg: AYBFou3YWWSjhZ7tdHkjB3G12rh/XSO+yAHG476xlnNxxvot/nzUaJRf0OqdcsZinvm
	1Cnc2O02O4l/bb5H3R98XaqtVe4Ih18l5T18fWmKSIRxTHPlMni2qbK4V3kjuzUUO3UL791gFR1
	hdmMeCyqzlLJ3aFJN/fmy7xddMqx9UhrHHFHfCsqJVVg+sNcg2fOhxfGJHjfWRe8U+JsE1mtEai
	ieN46CgflB47/GQBoIy+Oe6KwZ/alGN8qk7q85MEEULBnWk4JDHf/Z2csC0ECkdVFxjE24AVH8K
	PujKNKa9+T6M3IcS94v0NMe06t+/dwD6gTMhygtvVnXaBC2D5zxWYZ0acTa468DSTAsJyY1kKqF
	TM71vatBXPO11G6ny2X8wYFI74AMVCXP2o05P4QHm8qgRN1saGKh6Ld73ePqwogs95S/NONSJB+
	PPYaVGrO11E/Ak6UByYZTnJtXdx+VxBnQlqo3yU+8ag6HifsIafsN/utNty4xDt6OBVnQvwOKiv
	ZqCl4T/erJXA6X+VMptY7ql5eHnscjXwVngWJMaOteLcFL8P1p+FoyXHX85GwU5hAo2YhLuwq2M
	QW/ptB6Azhdr2BIHwu9bxLfxG76TMQ==
X-Received: by 2002:a05:701b:4188:10b0:154:fa0b:6df1 with SMTP id a92af1059eb24-1b5030fb7f2mr12989338c88.37.1794913602124;
        Tue, 17 Nov 2026 03:06:42 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b27dsm39194951c88.2.2026.11.17.03.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:06:41 -0800 (PST)
Date: Tue, 17 Nov 2026 16:36:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Milan P =?utf-8?B?LiBTdGFuacSH?= <mps@arvanta.net>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Shuwei Wu <shuwei.wu@mailbox.org>,
	Aurelien Jarno <aurelien@aurel32.net>, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: dt: Set the initial OPP to apply its voltage
 constraints
Message-ID: <avw1Pos5Je8piwvU@vireshk-B250M-D3H>
References: <20261111130430.10359-1-ncopa@alpinelinux.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111130430.10359-1-ncopa@alpinelinux.org>

On 11-11-26, 14:04, Natanael Copa wrote:
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index eb15650f99bf..2646dda10aac 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -153,6 +153,30 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>  	.suspend = cpufreq_generic_suspend,
>  };
>  
> +/*
> + * Set the OPP for the current clock rate, so that its voltage constraints
> + * apply before any policy can change frequency. Otherwise another policy
> + * sharing the supply could lower the voltage below what this one needs.
> + */

I think the problem is valid and must be solved somewhere.

> +static void dt_cpufreq_set_initial_opp(struct device *cpu_dev)
> +{
> +	struct clk *clk = clk_get(cpu_dev, NULL);
> +	unsigned long rate;
> +	int ret;
> +
> +	if (IS_ERR(clk))
> +		return;
> +
> +	rate = clk_get_rate(clk);
> +	clk_put(clk);
> +	if (!rate)
> +		return;
> +
> +	ret = dev_pm_opp_set_rate(cpu_dev, rate);

I think this works accidentally for now as OPP core could have
rejected a switch to the same OPP in this case too.

- We should add a new flag to `struct cpufreq_dt_platform_data` to run
  this code only for the affected platforms and not everyone.

- Perhaps we need a new OPP API, which configures the hardware,
  forcefully, to the current OPP.

-- 
viresh
