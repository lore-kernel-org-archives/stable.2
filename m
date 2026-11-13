Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608922;
	b=s8HlGeOZ7wzjbC5cjQ/AUaB5DOx++AbgiMchonbd5LEDkmZslIpx2TCvsLTKEEBEBI/C
	 WJc3kdeMEJkxMCxKrvKCfW0UpjiG0Li/xTNRtTY2w2Bgkse9O4/O7YiXKfwBkwb5km6J3
	 wsY67D+aiyPbcm0ZxnguoNCRLI99u38eTLO6buXvCUbR4ZZLE1jqQy7jNpfTfYoB4UBA0
	 WK0ruVBLhqQvAcvC/Qqcykj4qkmWvFuCevZwt4neqt4+nS78octPcUgv1jV4Dx9ea6wld
	 lM+rbEOQOjoybKBlGH+deDPnSkBBkySiZh8D1RAB4L6hc9Z/ra230tMsYT6XhfKh5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=f8Yyu14PmVzE14sqQ8IHgz22ahJAxs1j9mX0HpcMRXc=;
	b=WKXnQsa+9mmrQ+NFAMUVo6dgeoM/Q6erxomYz9/q7pZUSXHnIhtTz6yDye4ZumIsJT+c
	 UhgutD8k84YIXr/jSG+U4ZmoaRxYbkc4GLYCDo2HlrI3bILBzdXWkyxMziB7AtCnBHGAv
	 4WpaEpTyA10JwgQGR/rJhoe1GJ6OYR/ml2gW/VYvuXFHrcM9y3CHd7tlwOlLijWs3g+Mt
	 6cfbF3s3GtJNYsKNGclGZkQQLVtK2Be4SzPvZgqe3yJ8/2N3ze4pFB1vMS6yokWpOUAKY
	 Oq5hCUlHxAn0BUbjvJUHQVLQ+63kcxL2hp/a7OC3/D20Me8DcXUkGHh9T7+yiRFwnCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fD4Rzlh4;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF01606A8A6
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 22:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFF01606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=fD4Rzlh4
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-843ea301d60so1695806a34.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794608914; x=1795213714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8Yyu14PmVzE14sqQ8IHgz22ahJAxs1j9mX0HpcMRXc=;
        b=fD4Rzlh4SOf+qn7cQa3+U4U7FnQpmRbMeUH+EJBfZl5XIBR2UfdITSAhw1J0PADSPT
         u7x579MUqcDS6LuueeZe3WA9CXiOWumX7kEOltxZThWV3nUdE5028o5LJJ9WfyERMAWt
         dE2+YD8cM9X72ni31r2n41mEqMC/ozw71ss4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608914; x=1795213714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f8Yyu14PmVzE14sqQ8IHgz22ahJAxs1j9mX0HpcMRXc=;
        b=TEroea4mFBwq/vKE9CLY59xMwhWr2kpUTNp2C15jH62W2YiKq8UjtrnqV4lszjEHK6
         GBv9MBQoPmkp1iPea8YkSTH0jAd4MsgI1NPhypZ1/Ij87qMJricRH8twYCOHAWhdgKwh
         V2waJTFSdq/aESW/tLe4AYtcQ1oA/sBecLhMErJ47ca7SXm/vrNlHPES4K2JMzPy5pQw
         aFNfhJgD8LJ1PmfHTiZVFTVhXakoz0kHSme1zxiWUKm0wJP7Mr498n2wfbiVOVh+LIen
         q8hOGadjssUJUqh8irVZWzsF3N82/qpNz947FLuLpB9uLYv0GFRrQRPMtGbTWqw7amtT
         kIUw==
X-Forwarded-Encrypted: i=1; AL+hErFAIK9nDofJRwF6ARdd5DbMMsMpD6juKEpQbwnYzGvuGJquDoWYLM04o4N49id6CvmSKE886Aw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xcYQMopYKeInbKW8T4esze3n0t/CQ8GKokqHkmquW/9kXGxGz
	vnuufgVtflIzloVIyhiqeb3GD1GLUwWb5psjxECJb3gUV3gkoSFaXT1aVbI7YFhsIIwL14nB/C7
	sK4e+mzc=
X-Gm-Gg: AYBFou3BlglMRa1SfRYrDqseNsY4Af8/VhoUH1cTUy0Rh64waZRAcnWNRE5IaqeJ70g
	VE9ivuzgpjB9KdMsBK2cnYLPYvoMJU7mElHxbdA8iVO3nPbSdl4aEWVYp0lErR/UG4w0LUkA+pV
	lvpJA7e19bFmGCrnBu6Ouj+3eg0gUF9ftS0JBeFNe+b6xaveExAUy1d1X9r6GPSg6p1wRrDGL7p
	4zrm4Svzqpi/T3varS8imPhTFGtndhWkEaw46itcCChVyllykM0Wc3uW3C/6jPDRsUYemOETK7s
	9jLtxTlcXYsRj+9sGUGfFJ68IiKGFBc4/zUkzE2sc4WHFmj1Eh1wO2OkPfVRI/lEqoqK8D3Q0hZ
	5bpNh4JaX9DEMiELTYciu6BNt6JBhwmD63/d/MEl/8JiUCa8rhS20I3CKa27Om+2mvSkDj5a7fv
	fmg5eCjc1smrLBrH6tbxonfANHDZbb8aHLbFW0WkOxn7A16JbayRCADd4cuD+91AoEQoPDao6Zp
	5m/iRtuk6Y3+rMjLIm0ox7/t0PGyUryD2KyY4HoIUO8LWuheiqaY8KjzI1xJ0wai8ax2p2hWYvR
	m4nzVkz96GsJK3+3CmYtYRxQuT7ygl/hQozqZQ==
X-Received: by 2002:a05:6830:2692:b0:829:2af1:a07d with SMTP id 46e09a7af769-86289818d7emr3591229a34.5.1794608914557;
        Fri, 13 Nov 2026 14:28:34 -0800 (PST)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862880e9abbsm3427767a34.9.2026.11.13.14.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 14:28:33 -0800 (PST)
Message-ID: <278205d9-75a9-4f0a-86de-fac192db4edb@linuxfoundation.org>
Date: Fri, 13 Nov 2026 15:28:30 -0700
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
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261113153811.177190860@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Nov 2026 15:36:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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
