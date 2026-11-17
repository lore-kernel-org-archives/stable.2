Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794893405;
	b=jFuBPEHnGCjnJR/8kYCAaFeoZVqDktDjUVjTq4gkK62DzeFWAQcenmiytKwrwrq+Qg6J
	 37Kkqdi4co657mOm6pKOrJpDJRmFUTepdnCv/pvcK5ttzeWPee7xb+hyGcgjxH22fcTY/
	 eEBmb7p6qHcxT6wtggulywhVBPt0vkzVN3xjJ9TjwPiS2PIvK3jRvYuC8Q51SMxa7rDmR
	 649G88LnoIcSWha22q+SEGSRsZBenjfAaC0L0L4qqXXvBIE8yUQrI6A+rYSOy6icW4Thl
	 ftkGCN4nWD145K3vMMapm2LLeeUKZfjkvSHgeqIYagVvPqfr/Ghe4EDRQzcNURe/VOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
	b=svbom2L6dZoHfFHfLNNOkW5z24kwicumlev27vuwW3HP97rp/2smPwfqp1sVTGjyBHwb
	 FR/he50CAfCTCYYE4VvNCxQVXGNBXt1Rbks5uunQL320sej2QIsEbXhVe9nxeW/0qtdOb
	 Sgq8I5pQ4qHsDc2loPGpFhrksAsvmEGKCPtAHw8PUy1SamTTXsDwyBg44/wzjSkKTFy7h
	 peMNWNodzlPg9n4zE3D9pCwJvCvPzweqh6HIAUEQefMIBP762Ai/3y1yOEFzL5K7R/sWD
	 sMS7H7eG8MR9ufOkW2lu17CwC6cGSpFndC/sQtieeIulhAl2g8yxiHKSRCTXTQ4yVjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jx5pGRxE;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE7606A331
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 05:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CEE7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jx5pGRxE
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae58d17cd9so3423887c88.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 21:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794893404; x=1795498204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
        b=Jx5pGRxEn/r5S4/3N0yhzLTza9aPjKIstDeFKgSij5nK+aSlmAC86wdabmnPytAen/
         kxVwbjGlPYVnJBopzfjTvdRf0AGe/mTwz9tkopS2yB958I883j92ZadhqHMX4+Yjexf2
         Vz0NXVbpAR1i7P8EAYmA6xDiuz+JVh2Zj1v4OF/C6tf2VYGfjVaVcAQaqwWBIv3rWwOq
         qebu8KuRr+cQ/mJQ9ETfZXkafs/HTLzQDS1LwuJsLZsxEq8T1xRUxCWCEZ+3Y9Or1I7t
         cPXn2Y4iVfSC6C0gTujGvgEaJr1XTp2sFgNww6DJ5dtiHVV8biEK8U9cXdxZb8dZwAJr
         WsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794893404; x=1795498204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftrMizvuhIHObTCvAdpIahRgmk2EwZxg4CfQaHM/YjU=;
        b=EK6c67HfyDt5KA2WeJVjPJqnidWs/YKv+Z2DZP+xA5tLytTttSmZC70k3SrMxntuBa
         pU8m1ZS+mSQHprgh3M0JcgE1wLnnfkasSE76ZgzDL0IfhB9NP6G4lPf2/goGW19mvUoY
         0SBq2k0oYmX+mXrTR/teuzXimaXZ18lHpduc2G/WBA0Cm61LZbmdMT4u1itLrTtcmn/z
         6BZ/jBnT4RA1iHDRlXKccbGccnLggQz0X5LQfCEOZICyVs7AMiyoSwCGvYecWqChuZzF
         W2yxtOSD5JGC8oEusA0+1D3Z6RXv0cHHJLVE2qptl9twGPv9wg0CotK2yKPBf/Ia5LSE
         zGIQ==
X-Forwarded-Encrypted: i=1; AL+hErE6aP1NFIYxSFaa/aHDJE7b8SqaoUtO5SfbIOPAGOwehDLCkQrsJbwIU8Gn9jKAxLSzjqjiPEs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9iudPUe1cjaD2yWF8rYr0sODDFvuAoTTf/02bj6utJA6Kbxw56
	0PzdGa2k/Gsgi6+w7CSem467OiPnIZRGTy6e9Jr0AtFv+hC2EZ5uinWy00tPSsst5fw=
X-Gm-Gg: AYBFou1ysTTPuS/Nvq8xxuDQ206Lv0hW3yd0tuXF9ChQBRxh7DrFU7FIhaMzBuGjnO5
	ofiHWVO8gBaMzr7qSo1CTVsARPuL6O0WKrfTZF7wgdUw4ib4dgj8xGXCRkPUh0DvfEaxr/Di7o+
	/zeQ0rirlL0Vf+97e1X2yE8sfZz6lopB04WZupfHZgmRS5ri/8gLO8gbnzPsSURtmppBKZKyh66
	PRn3Gaczd0+mug5hK0hLc+F6FMU857tjBreSs3j9g1wU0h0d2hJfMqLXZSELRdTw+UptJI4zJBP
	SgHhPHxTYLsxTjcEzyAO67mJzHpKDKVJfhT1rDX1fmrmNkG5EvCsX1EnI2KE+Y9CTquptEPSXKF
	g377sD4Q4lotBEwqkilc30ijcU7ff+0eBuA/VQmSLl0lIoroutiWXc+kAPc8lyHVrbHCO3B3DCg
	rbr4Ob/TQUaKBMitzT7lH/E+ECgjiFwuZQvvEh+mpTtf9afYrUQMlaY9k3qVhdWoVvY9fgbm2tw
	fBkn/Fb9BylzVCZzk8NfMPR02CVnDHtGnQfNjh+D205ZRvh7g1q5DWJo8/iQHwwxg0LycluupS4
	c2jv4217MU2bw+1vH15BIJQLeMOWQg==
X-Received: by 2002:a05:7300:e9ce:10b0:368:7c2d:a612 with SMTP id 5a478bee46e88-37966c4738fmr12899653eec.10.1794893403702;
        Mon, 16 Nov 2026 21:30:03 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm77630203eec.20.2026.11.16.21.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:30:02 -0800 (PST)
Date: Tue, 17 Nov 2026 11:00:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gyokhan Kochmarla <gyokhan@amazon.de>
Cc: Shuah Khan <shuah@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] selftests: cpufreq: Disable the runner timeout
Message-ID: <avvmWA6YX2I-ovJy@vireshk-B250M-D3H>
References: <20261113163951.1510082-1-gyokhan@amazon.de>
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
In-Reply-To: <20261113163951.1510082-1-gyokhan@amazon.de>

On 13-11-26, 16:39, Gyokhan Kochmarla wrote:
> cpufreq_basic_tests() reads and writes every policy file, offlines and
> onlines every non-boot CPU five times, and then shuffles all
> frequencies and governors of every policy. The amount of work scales
> with the number of CPUs, but the test runs under the default 45 second
> kselftest timeout.
> 
> On large systems the hotplug loop alone does not fit. On a 256 CPU x86
> machine each offline/online pair takes about 0.5 seconds, so the
> reboot_cpus 5 step needs more than 10 minutes. Even with the timeout
> raised to 180 seconds it is killed in the second of the five loops,
> and the frequency and governor tests never run:
> 
>   not ok 1 selftests: cpufreq: main.sh # TIMEOUT 180 seconds
> 
> A larger fixed value would only move the problem to the next bigger
> machine. The basic test has a fixed number of iterations and does not
> wait on external events, so disable the timeout with timeout=0, as
> ftrace, timers and net/forwarding already do.
> 
> Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
> ---
>  tools/testing/selftests/cpufreq/settings | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 tools/testing/selftests/cpufreq/settings
> 
> diff --git a/tools/testing/selftests/cpufreq/settings b/tools/testing/selftests/cpufreq/settings
> new file mode 100644
> index 000000000000..d3e07370a7e4
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/settings
> @@ -0,0 +1,5 @@
> +# The basic test hotplugs every non-boot CPU five times and then walks
> +# all frequencies and governors of every policy, so its runtime grows
> +# with the number of CPUs. No fixed timeout fits every machine, and the
> +# test always terminates on its own, so disable the runner timeout.
> +timeout=0

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
