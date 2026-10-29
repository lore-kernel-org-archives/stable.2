Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793287583;
	b=X59HQUahuTT7GD8OETozaAjlg13EQXKRJCnnK40hThcJo983fvq+8veDMUcHd9GBj6NR
	 9om/sGKjRrhXL+Zp1BgXrwNOL+nI4ZA0RojPcYZNuqb4oPOzRVl2cJpX3aRTpWjHkDI39
	 iUOlC+SYOh3KmBVGmRU27xal3Be0eALb16pVATtjpf1cnvs/yjvJ5z1rR/ZPnnRu4uO6d
	 eSxzUSK1KFEwdrDPhGzmv4QI55R80tExSQO/qPXv1YYOBHlj0aGxBQ2aS7rZHAJ8WznR1
	 vVPn2aLvh7mvEokpefQ3cOGWvX5AKVPcljmafqcPiN1VwWjmI6kqTe8pcmdMnU6V4ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793287583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ABoTDXyOtvkcn7EUfVmTDlnC7sq68l91R9Ze2UwYLLQ=;
	b=CejBPy+Bu0DIf+nH0LTz59yvmZhZZbWPxlM1v7pZTolEyWgOHnwL8DSSSPdWBNmfRn/7
	 Xdcl3W2G61qbyuU034LwkLY5GR7mFyyU3g9jl3jyS6Tz6HdEXA+hWNfuX9Ny0yZL81Sk+
	 VRbs1zIMNFGRhn3i0vtkcz6eLax8armMUZ6agWWjyh5Z4fDhrwwxSWEeAj4WX0Ox+jXmR
	 98en7FWXKfvTaz+mL6x1buR7wwEYkJOl4YNbT0zH2jEjecUcAOC75bQtNbhirPZHtlGyb
	 BqQihJvS5wXth9FmlyKL/bq6/YOQQ/NiQN54kO7CmTIRpVa+iN4JSemYJ2wvsw0sDzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b="YXVJ/RGI";
	arc=none smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C82606A320
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C82606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=YXVJ/RGI
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-5326cdde017so722489b6e.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1793287581; x=1793892381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABoTDXyOtvkcn7EUfVmTDlnC7sq68l91R9Ze2UwYLLQ=;
        b=YXVJ/RGIq7/qk0n7fsJn4kWm5KE0pNRcpfbCAQ6lTB8cHKmx6WeLPP4RvldpW5hBEZ
         xj1zozDJRuW8t0keGI1RgvA0Do8zlKNgUFMOdNIJRwCTJZ8gHtQVOPXlzKHormMpJkgN
         m15uciVLgJ7JiySdGCLTgZhOEJjhbOV47wOAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793287581; x=1793892381;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ABoTDXyOtvkcn7EUfVmTDlnC7sq68l91R9Ze2UwYLLQ=;
        b=tKwg4wDcWwGh9qC8IX5K+sX8cpcUiAmrEgwm6fYlvXT1IvjBDbQ/WVLXPHkyMDRIzy
         3rRGAreqsbyct/GRD74iELUKBACxZ8FXnSPqw1E9OwpQzxC63Pg4tdF3BREyamQmrVx6
         7S2fCyV5/iW5OaxPpc/T+yphQj9Get2nk2vzXlfrYprwWxvvBBzk+bfzwNJ6Uzpz6ruG
         Kd2F83hj9xOQTK4+P/OusyX8BlaSYNnHa4BGS3C/AZbwHzWj0NBwM+8ybJ998+jgEcM5
         TLyNZzXqou5dKC1s1YWT6UiXrEtyocfbksFU7GWPz8M62lCVkQbj9aIDOWR7INvFEueV
         yyBw==
X-Forwarded-Encrypted: i=1; AKwUvBwojXs6Wb2/qPkFC16vibAHw0PgZxxBQsy+aRSHKVAoRixWvVcnaVc6wkCMD/hzAJbVbEcJhaU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrJpTSlNOMtxlUtXLHCkhJJemRl+thadcU3MOj9MfztNlNZgau
	w2yblZWnDGnM5o/m8t2iNCDqMAANW57KIGOqZF1NujpCpjktqDzbGiSXYlK9LlKtEww=
X-Gm-Gg: AYBFou16yHEg0k6f5TInwy/U9cdGa+PpGp6PwMeOLwZOr0y6ol91+f2noVhLx5vMGOH
	843P6kpYNS9hGH1EJ+WG9MSDmlyGuYozgxP82lxRy60fKEnykLr8hylsmFj/SnQTfV7r+fZ5Ucg
	zMMQVPaNaTM954qaSacjfPKsBe52Q6CXTuW+fK5oT21oVKkYmzvkphZWIl4n49iwYAM2u5c3lg4
	tpnYRZzR9fexyH6cWKCLvNbvE1Fe+nkIipnn7hnqgKDPPbDFhRW/89xHTmERnMda4tpkDfjEDW0
	gyVRTSOFSuXRtDnWNAEnghVOI4vpOnKK9EWxkiGFPXkys84Hp0vOwoIAiZm/FCbjPOCc/gOWwOS
	NmEMDuOTI4Wa070cP3mNg9tdZhsHG6kHcwo2rW37knt0BbgJjOXU2PZXdE3OwxlGxQrmp2DPks6
	ptQOP+ZUoJe8ZphpJq4L2vxUaPD/aYck8ARxI2Xu8j1Zt1qIINMIShNy7OnbaMi5IG24w8DF+iM
	f6qhl02Hew8RKnBJfw1qDAqZZykt7PCExZTX4MKwS0576RoyWvdunnRnw/HMlLKbP6Etpc4PNSu
	A6orEo83/G2wbxXsU7893fWusGI4rq1o3S2lMLdXPjK4a9lT4P80t1IyAeI=
X-Received: by 2002:a05:6808:178d:b0:4e9:eb70:b98 with SMTP id 5614622812f47-56382680c8amr4552456b6e.32.1793287581613;
        Thu, 29 Oct 2026 08:26:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c5a4d8b7sm3701051b6e.8.2026.10.29.08.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 08:26:20 -0700 (PDT)
Message-ID: <554ef84c-a307-4385-b244-007adeeb8fc1@linuxfoundation.org>
Date: Thu, 29 Oct 2026 09:26:17 -0600
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
Subject: Re: [PATCH 6.12 000/247] 6.12.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261028165947.349197979@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261028165947.349197979@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 10:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.115 release.
> There are 247 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 30 Oct 2026 16:59:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.115-rc1.gz
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
