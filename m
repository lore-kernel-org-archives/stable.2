Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC63446C4
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781959944; cv=none; b=T1yMfoOZIT/oWJS6s6A8in7at+mn6DsHtgUsFdWjwrF0ccwoWWbfp1seXfvtdL/el6x6ctJjmwEn6Qp732skrx3u7pALQ1StqJL/yWjgKOyZ6tWBjwLn/vQnNIf9gdfv4KYuHSvnN8rf+NZ0X9Ni08VN0Uy3YpqpcbQKDmPpvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781959944; c=relaxed/simple;
	bh=stbQZGWE9wDARwA40v5ODAZ+1YNp4dtsUwOKYsuulPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMHecr5exyieVo47HYHiSP2V9OwwJyhv21LiyIkv12zqwpccWOBw7xVLYaBULRn4hCuSLo2iHsNcV94J7k2x+woVRbEYGOPbxn+8+OJ2iJv/gpgiSUphUu4auO99V3Z41O52thVvn1ZSbCymtGkwsydBGziCVpTlwkd6cg2c26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dOi48S+M; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dOi48S+M"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43cce34c881so2172244fac.2
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781959940; x=1782564740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ls9q+kzYHt5WJU6dHfJgOK6gz9sjzNIdiYik9UxPBWY=;
        b=dOi48S+MlaeEBcgkHrT4lQBQJQkywEnqYNEEZ7unTRCmVyWhGPRpzZ8tN4/nu+oCVo
         Ee1RlJA4DeKe3vPHeaWXvypQjd/xvgtnZQuCNiretOjO0+hSKQ60poWOIxpDNa3IOwKh
         QWRgTbkiHzfBNkkM7p+qJ3OKtgZFME2QXS2TjyTAA/tOdAOr4m6/n6CMZpC+5GL/VN0L
         ap4UXLsXR+vZugw7ERmBr9b4BZ2tHf9lCegeU/4PnQ9P455Kqpjag91iZdTylhD0mYx/
         6h/JlYUuAkJLZ1G5ByKrN4D9X2gaIK4YLBTIg1OBdDS78f9CQQC1Kdz0rqhAQ/vZliml
         MXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781959940; x=1782564740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls9q+kzYHt5WJU6dHfJgOK6gz9sjzNIdiYik9UxPBWY=;
        b=a6Y6tArkNeJku1iHundFHewmUsfghtEAacTTF5HuDFv124POdhaRAHiIgZjxpA20PI
         pARheM40AB3THsVmQ996LDoVtAX4jqm7CP+LmUGcX27t9f9pKmCI7ceHHEL+JWURKdtp
         QbUQ+mzF2CqPnfAES0MdKKTQfP5FYPWi+zOHELrsmBYR3egrSnXmOSdPZZ/m3xGwlBa4
         3o5PrqEVpQrcs3D6Ti5DpciPIuBFEYLkPnx8XhBYu+CszsvXbOUoWKE+cEDBh+yPsW/J
         bBJ31ENSaEzjfK8nUMlwN7cF0w9SKMQnbBVtlQPj0PwX9glrolAup+FlrpJqA9g0r4Sa
         lxXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MxhtbqkwDumMj/2gAPhJVHWJYmV9Z+HtZZClhNUYEW5v6AcWcFbqCAr5sOWc0fL95YBgS0w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOB/lWx/LM+ru6MCaSyk//HDVcoEaB9qabn+dxiJ7h3sdUjzc
	K0r4/1Gw9fQcUskeEE6L0IMhT5Uz/BLj+rV65Hnv4zY8oVRQtYzuqztQ5eUmb/FeYJVfoaGf3wP
	+EOEcKO4=
X-Gm-Gg: AfdE7cnvZsTV4+mZmT7fHRXN3ZETZnAhg2F6P6jgrP87963J8C3gl1xTJUaTKjwbl3+
	hAEQZPnzMVuRxXXhy5VMLxh984a5tKckfeLbnnrcrhB6/VYhY1zJxWKUa+C8axAnkPFke7yfCHi
	cPs8q83lX7DL8ACFPTgR+tZ3081FArHybEdwQbtje6wjzVJYtc9YGIoO7CaHbi6n5F5BvYUQbFK
	3NFdOVbiKy6GMiNU0MyjLHmD3Ts78yiTJhwVh2dIDJxDhsjHnBjv2ivDrNGo4p6dc9VbnMu8i5s
	9F/VEJXag2xT9Jd/yIBEKmApa/r4eEkUYVgOzj/e0kbGW9ELoDsGOY4CHCDhoIbUngMGB6Iw1Kn
	D3+ah+i099XelhdzlEWMGQQrUWy75RZzQFMEmcm8SDKfiQN5vje1X+6Av7wDFl5yJtHNidaP8FZ
	QYDICYUU+fVydoNPfZKrh30yt444duRYFiuhlBqyedai84BK9aUT6gxrWHPDEvwmZPvB8fTyyVJ
	ILYFGVTpfZcyzidOom8xaBobIewMiY+GOZ253/iPYecrj4=
X-Received: by 2002:a05:6871:a80c:20b0:447:ec0:3e38 with SMTP id 586e51a60fabf-4470ec0a075mr3850461fac.27.1781959940140;
        Sat, 20 Jun 2026 05:52:20 -0700 (PDT)
Received: from [192.168.12.39] (74-39-22-146.bng01.plmo.wi.frontiernet.net. [74.39.22.146])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0464a6sm1927601fac.15.2026.06.20.05.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 05:52:19 -0700 (PDT)
Message-ID: <ccfe8e7e-f9cf-49e9-9c64-4a8754d16da6@kernel.dk>
Date: Sat, 20 Jun 2026 06:52:17 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] io_uring: possible CQE32 overflow flush inconsistency in
 __io_cqring_overflow_flush()
To: Cyber_black <Cyberblackk@proton.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "gabriel@krisman.be" <gabriel@krisman.be>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <M9uVHmN1uFTdPdbQOITkChFjcJWO_U-BCOz4466zskh0n8rukyrE2nK4vlBcEQ8JBMyGZFPqBKCPyfZxYa0LdG5nkfxFBIcIOcSlAjrn1pU=@proton.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <M9uVHmN1uFTdPdbQOITkChFjcJWO_U-BCOz4466zskh0n8rukyrE2nK4vlBcEQ8JBMyGZFPqBKCPyfZxYa0LdG5nkfxFBIcIOcSlAjrn1pU=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/26 12:30 AM, Cyber_black wrote:
> Hi Greg,
> 
> Thank you for your honest feedback. You are absolutely right that
> testing is essential.
> 
> I was able to compile the kernel without issues, but I cannot test it
> properly at the moment due to lack of a suitable test environment (no
> KVM/QEMU setup, limited hardware resources, and financial
> constraints).
> 
> If this means the report is considered invalid or cannot be accepted
> in its current form, please let me know clearly. I will revisit this
> when I have the appropriate infrastructure and resources to test it
> properly.
> 
> I don't want to waste maintainers' time with untested patches. Thank
> you for your understanding.

Yes, please familiarize yourself with the process, just about everything
about your submission was wrong. Currently OOO, but I can take a look at
this when I get back next week.

-- 
Jens Axboe
