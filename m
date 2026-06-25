Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D930C15C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431764; cv=none; b=O6EYYxs0MMycdr+LtfCJ0ptotX+uov9TRHSGGzugMmcHzFy946z8jYVHvup0goG/q3VRM+cUKrnEr8ywqFl5YMZYY5GvECAPVnfDOga4DDGlbiW2fqd2PdQnwMNeTZTj346+xwhUJQAiu/OFxB15mxNenH1sRZ1QZR9O4SFY6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431764; c=relaxed/simple;
	bh=v4qQOSfEsJBEAiTB8bNtCsmlBCLgcXgtDRs+K1rY+Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9AK6rvFMDbvKnbz1u0nXDEx24LLMHa1v0YsBE9S7gryc8+bLX2K/UGNYLFtvBiEmErWS7ycrw+cowVsAOx0NrgqLSF/ACA1IVLQrracYS318Jk1mV9w3CW+ANP8cWJjy3+Jx2FcvX7h+KGxCOJGSvDdL+8C+lcnT4+KfOald4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ipdt+DsK; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ipdt+DsK"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e94c26f9e0so182160a34.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782431761; x=1783036561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se3VN4EIvD6SLhtE53lIkfV7dyEZn4T4JlYolPRuK7Q=;
        b=Ipdt+DsKQlwznU3M6GlTRoIu0wIPX27zTqclUQgyeQKfO/th9Ugaea4PfM0iW0uuJF
         MLhUdLHL/aqS3FsaaM/ESAYvW0dSygU3NKaMFYxHVhgbGtxPN8TQm+tGjN/5g8xn5FeR
         z7qW6moXlGx3sQus5TbafS1yJ3v7/lDOnkxPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782431761; x=1783036561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=se3VN4EIvD6SLhtE53lIkfV7dyEZn4T4JlYolPRuK7Q=;
        b=ibm4pz4sCInohImGVOZM1NCMuIXgAsNPWgj6Mm1gzCjjDDLHnPLhwyumwgGSxfh9WQ
         GSvw5sfEg3D+/FrHjATPQ2jIvrh6usKY9hanZliM2y144c2HxfUEVBpZGImNHHyW7Ugc
         xwwYVOx/wFG4ohndge2N0TdWUXurvTSsawsYP+tykzibWChrvaZZ+/twm5GER6JgCSdy
         D5kV6EIKkU8zYm+ha/NOGytPSNo3NpT/RkzgsNWf2VXY3b3u8M2yKJU3wqJWTHncy5L8
         RQ6fNi0fqy6e+qShb2WMjcAAmVKB7QtntIT7w5de6QsUi1w7t9/fIhTOJ7s4w2VgNHsY
         Z82w==
X-Forwarded-Encrypted: i=1; AFNElJ+o1Dv3ZiQ0tkTZYKfqCTopf/6ywDz9SWPP1epHIUxrUQDIS9/DwzEWe9gYg4aMhDzc3El8tLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWq1GX2brmO8Qn1yVQ1haMteuXORF+gVpyU9p1OKAHZ3aNoYRE
	Tj8xCDyjJRo/M26uoi0CSgzJifthgtTUDCrMNxvSYiqo1ogwgJRuMIUq8oCI4lkQVWw=
X-Gm-Gg: AfdE7clOI32wEQCxaMI6gW4Pfesg1ZxY+TJEf5XoXy+u86j6U3yvLtGAsjaTxx2ZBKt
	kAi0s3mMpAWPHLm1WQJRi442TvZXSJKJmlvaagUXgOeq1UnC+m58S9mx0/nM40R989TYyrcKomi
	vOdoHjyqXFfaQVCSzMmlQRemsUBrIHjtVvwInNvcDvEGIU+A2bJxCZXkItB4SkKkstogLt28Kfb
	7xJRfZyaqpmTShkIDTfYZOZpUKlrr+t4XePii9CFhaKd4leAawbN7vFDqxtK3IR96nWRDb4CP/E
	z/fORfZIcOPRI5Eop+VDfQcBXLylLAGsFBOPA2hy9njiDPPE9uoUBxQ+rbkI7HGDINvv3ezM2Ex
	wE1cGk/Vp1wWMDEx//zr9qt3JTD8PGk/1lel95hA24tS7udLaeMoBbX1Y1J7E01KZD3ISHMPv1+
	7LhMklA4LfH5j0UaLfDyguRdT2vWOeoSU=
X-Received: by 2002:a05:6830:6383:b0:7dc:c4ae:a689 with SMTP id 46e09a7af769-7e99bf37bf5mr4066834a34.2.1782431760999;
        Thu, 25 Jun 2026 16:56:00 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa7bfd54sm378845a34.21.2026.06.25.16.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 16:56:00 -0700 (PDT)
Message-ID: <0d5a418d-4ee4-45a3-9ef2-79fe77afec2c@linuxfoundation.org>
Date: Thu, 25 Jun 2026 17:55:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260625125613.243729608@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/26 07:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
