Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915809;
	b=qfRmTDR3bf1FGLEQDZ5FUwGt2FjZYpn31QAWhZvAAl2v4+821IJ3NICVmVsoNsJfUeoe
	 RqSnMZMGmu1a8YrfuJTLghIRW+VlH7S/kwzZeeuY78/GhxB2GjGjOJi8p/jcfSHVmz4Nc
	 hRyEJPm4bp8hKG/bLZzi4wNH5kiAUqMACXgFTOWmfpUombtlaSOxE/3r9CfPRQhsiSmBH
	 fWw8A9IB0P/ZKUIhD58wVVBTmhJTxqnuY8tgDJqdt5C5NSUmbipND+lXHGNpulT3TP3qt
	 xmZmZm4e03/bF+B58cv5i9isFKltAcRCKfNyQ5TZB/1yCBvrcALJFhyGu9PZXHtXUeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CPyUJuu2yeOSTelLItaNsxminWyw+/YBw1HOW8wGPck=;
	b=fJXd7sceOzfYadDCUDPMCbXVVgFzrzS8ukjDi22lUKgEyJmVOqnkBKnoORXG7GE0G5eu
	 2NRrp5+uLmwtkFQyOFeTvKsK14UvZQS+EEpZhvMRj38e5FBM4lRzpguixj7YPVK4N7az2
	 hXpUXP6CA1xDCSG1r4xsgohrb6+Fi0dhab5+/3+nkXzCif0XMR+ghIWbrYmxZy6YCIGaI
	 HqSmmQX+eIg0sAcmF54oFtedxVU6cz5Odj25FHl5f2WmxUJdxUiI0jz7oYWRy0MP2IB2U
	 EkzwCV5c95JIsaijR4kbymxEygdZO8cHG/1uNAhq8saGvrGawqPXXcy7kU1wNHIC6yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8zcnrW6;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384A606D802
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3384A606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8zcnrW6
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a1947498bso92581eec.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793915808; x=1794520608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPyUJuu2yeOSTelLItaNsxminWyw+/YBw1HOW8wGPck=;
        b=P8zcnrW6mWnaxoyc6Z4odI5ZW3ufC1DKRm0R3fv2ovHISY6QKwLK7MTWWElGe14nsy
         +VZiDBWbTvnjoQZ0yJ2n8NfO59f97nM4m0CZhNQiYuDOLrJd95NFQPgRmAq+JFKgFrIX
         R7iqRL2PiDuZ2qmKBNfo+2YC6qHRPDZMLP8QBn1g9ENbwqS/j6/DLlz2SFiyJEPFF7kj
         N1/Q5EciLtgaP9RvPIyIr+ZLc4CR5VaMBavsGqglPGln6+u9qyLE7ohzSf9bXtWdzHM0
         iUP2oI/ycLvmhj7Scz2AsfDGsUKlWMqy4LQnhNFBlAhPXNXbz3MxkgdisG9HVYQ5EtdM
         odIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915808; x=1794520608;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CPyUJuu2yeOSTelLItaNsxminWyw+/YBw1HOW8wGPck=;
        b=UNAEWvEnaVEWZf+QdTk+qO12XAXUAl8CA4BQzYuntBhjNY2OscxN2RrVdBm4FOhCgF
         QOyhQ4So5/qWLH/eiUjS4hI1JhQRw7dvCmgtfNKUDuPFrd493brX7gbnbwaFVmGLFp2S
         naH9raURpcz7idWSXzg5bcQmTa7J4cVMwv6AEdbVlo5++hoZq/NNuwCRQop4Lh6GtDwF
         rnf3hAY20aOQG7PcfH3nKYxcVF/KwZ0SeLy8qKHmAzoxcNbJAR1YcNkEntlJ39pP6Pp/
         YYXDEst2lDu81Fk2Yhi5EwgFk4RVoKnuXpgIipjigpKO+f+3L6MzHZs7flm4vu/cP3kQ
         4OCg==
X-Forwarded-Encrypted: i=1; AKwUvBywmsI7S0rScdbYDw6clXx285LYjFaus4QhoYR6KLFNxKWk1Dsx91QLEHWI7HQm6tY6gzdF5C8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hLjFlcOXPGIz/QzgYxgqLw/LPlcEejQWhlkCnS+Cvbz+5os8s
	+Fi0/ys6769u6/rK7Udt0VfR02mJD6jO9mhppWVcEOEhAltQNkWbpVIcvtRL/g==
X-Gm-Gg: AYBFou0bJ8u2aJnb3ggtmph6keelfByhoBcj76u+5SBnqm1nNHIXwdZg6nbgkc/ZJaS
	ODnc/TuMeJNwuga9WsBF7rVXJMXJAVTOVbqeGeWnHzLM3goeIi76a3Ro8/HapTNRmjONjiOC2CJ
	ptb/sWwucxGSmLrz1cQYaaHLNHANVKNf6QpfWHo7zQqsC2Q+6+/gJ8XTyOUY1/2swcWbjuJ1L+g
	5+Y1MGGrHEsrmvttUchESkSNHk7r0P0GdYeaH1yzcNtUtpPAsgo8yjY5My+ucP21ShMC74O7MX8
	HDqdxhU4G98kMPQB9b/h8VeOWSr9bdSvgicHoukJKbssoSKtevIxRVXyctGldZXIaD527LJ7uof
	mDF9r2jpfbVC0nV4oRVVPdsr25XeMagk2oF4Pb6uJD+EkOTchbeaYli9Dog0Y9Zu+7oAqeGmt7k
	DFPMdm22a/jPEIaRv8B0XMpH3DzFiJo/a1RJZjM1YB1G0Z8cQ3DK1ex6N7XBQxHnynqmYAanXpj
	GdGpjJOKeHmvGmCHU4VzBn1hhb4zGibRCDIXjtJ3QW87VJso/glu3837qQIKZr5XWORs7/+XHQd
	gNhRCKgxgoPwNRWQMBb35lFBslT3ofq4ONGMAZV9Y9d8C2f4etWhGf8jhsiHXIVeMSoKofUZndq
	f
X-Received: by 2002:a05:693c:40c3:b0:36d:a465:b38e with SMTP id 5a478bee46e88-36f72cc18cfmr774374eec.5.1793915808199;
        Thu, 05 Nov 2026 13:56:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f736a1da4sm1053048eec.7.2026.11.05.13.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:56:47 -0800 (PST)
Message-ID: <99b56b59-a1f9-49cb-96b8-6bc844a878f3@gmail.com>
Date: Thu, 5 Nov 2026 13:56:45 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.3 000/547] 7.3.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20261104211038.406938024@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20261104211038.406938024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 13:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.3.2 release.
> There are 547 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Nov 2026 21:07:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.3.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
