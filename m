Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838348167D
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281077; cv=none; b=ubpTVUce0dMl6Fk/uZXIx1iiCYeCj03rsVt59YKeimG82VUBQvqINK3ewHOaIpgSMgvflY4nxlT0cGd2ZX/QYqgHhNZCg7COhG70mhhtFxvvZGtzT4p6YUPtniyvoBlWLMjRqP01pDR73ThoZIO/6AFWeNSb+NaGcown3WKawlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281077; c=relaxed/simple;
	bh=BE8xFo1k60gypSs4ssodFBplGIq/3pRV/lXZBQbcfQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxNZ/vf5RtjlO40SzntKFecnEaL179Kk6V5EcnCs7I5Y1rCfXVcunnC6Wv8LkLIs+7cnA7Qp6l4ChhS5mJq+h+eX+00BWhSztGRvMSF0PaTUDLjw7UJUP4aleuyMa5omnU7oHU/O5Jtj+K0vluyGeVMfn6hI+9I7E7SSzygS8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dBq7QZEV; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dBq7QZEV"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b0496f4bbcso29111eaf.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 09:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788281074; x=1788885874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2GA62kqcT+ePnUyibTOPCdIAFiDj+kwuH2zWieDVoT8=;
        b=dBq7QZEVUORHNH8cYSv82kNJHveQP+WjfZc8xhxuYD8HjMfDMuVsQTAqDS8KKFcwMN
         HczzW6fD++PAjT9IKEZTjthUfHJyA6ru/AOsxMBxiEc+ebI66Iu/b+fivuCKYJtpYGUz
         cmIHqb1TtovpENaK0Q2nuT1a4zhl8K4CRpt60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788281074; x=1788885874;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2GA62kqcT+ePnUyibTOPCdIAFiDj+kwuH2zWieDVoT8=;
        b=IO1jnsYTr/PACIyiiq3Yy94oaX79ORwNPOb+lH4AciTETX/V2C5ZwEq1L6QGmhsuDc
         NHgoDbzlQ2FZv9N3QukwP19JeBgXeQEbnIcaGMWcehpJPF+u/2AUFacOYxjDNz0Hber8
         OTSMVTUgBwI05C3AeIpM3yU7Dy1LzENjbyz+ck+nw8SUaieuQVHnxbLpJCHrkwzCIT5Z
         VTnwTKdeMTm3ePYKASN813AXfSXv9Hr62GczVJ9EbfhqdDoVX7LRkMEumRBM8eHLyltD
         4jOXo6vidVl26ZkCIiFAMElT662kYf+Cqx4+DRpK8jx1ecvXNfrzBRzEgbLBFANKmyxu
         RoEg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/iyZBHvtxx96zYEessgbR6Ph10uxnkZ4WM7aU0+cbEvxVX/dZRWKQsJrCAugDc/BVnECnKic=@vger.kernel.org
X-Gm-Message-State: AFuF++mr9sbIcdzfEDa1B4aa5JOLLTBwcov0P8hUlFrBjekYPO13Ruek
	Z8VQuEpGJOUkdj8JB2NCxlV7UCzwC6pUJWDStq2v7XCTFkQM+B2cLh6vgvHmigsKQcLYIPLCboj
	LC164eI4=
X-Gm-Gg: AR+sD11HAaLIGTd5loN7QCEos8SHQOzcetZWGaPv3pLQiu5K49Wg/6aV1wPlmbG85yN
	eoTtm35Vdwxh0su8DdwoFYoV6bxZGX0xLdlBkZR9RGVYjeQ15WDgAdF1dJP7oSkvsgpWh6aRXxx
	+7uVidjJXL9OmcZrFi/2MfYVVsoKOkFMKg6AxHRdugw1RNz8fvl5ocghvS1L6XwVJkyPGeycaaf
	HOsuRNiFnhs1BUtMW2ca/MITwUfI2rgFROTOQAOaXhcOOTWNMtk3umc3AO5XzVBbRdcAVGBP9Fx
	Z5GkH4HAgNbwG4vT1zdXwTm12vA513v89n9qyHGuZ/RLxpMC5jxX1g5tS/+AEjrLnz9Prge/NCP
	Faaipq9dJQ+UgFwkKyOFGLSTLWIb8joM9eG62slMjy685K87AX6ruIbw2tHfoswu4WfT6Demg8o
	6vJXt9mon/mfTbK4ReJ+Ezuo0hB1b/lw8AlrTssGyaAUXekuFh0Bek5I3UsARsEV7h3hbtuA==
X-Received: by 2002:a4a:e90c:0:b0:6a1:47c8:c86 with SMTP id 006d021491bc7-6b1c667ccffmr35159073eaf.10.1788281074439;
        Tue, 01 Sep 2026 09:44:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46f30cb5a17sm187699fac.8.2026.09.01.09.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 09:44:33 -0700 (PDT)
Message-ID: <917c59b8-d3a4-44f4-acb8-7d527f36dbc2@linuxfoundation.org>
Date: Tue, 1 Sep 2026 10:44:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 00/76] 7.1.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260831133359.185608553@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260831133359.185608553@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 07:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.13 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 02 Sep 2026 13:32:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.13-rc1.gz
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
