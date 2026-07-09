Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2F2F7EF9
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604423; cv=none; b=vDLRacSERPWQFMGJ+2SZgBUH9bOsv3a/HvpvcshBG5mwIu85t+MERFoUvjUor6NhFWhwZ7aTXdfGHDKYl4A/4QsHqiqqv9ZhqZRfh0mn6+S5Z6jfpzYKX2Md2FGua1iaLGZxHK6NfV1uITKVbYFpOetlFNHg1VYGWP5cQ4cZ63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604423; c=relaxed/simple;
	bh=QXagd0Uz7fZfcdhazpgZGPt/2+NclByuQtbv82lvBt8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ff8j9so4DxnlFq+8lbR2xdsT31ltdivbVfd9WKB+c3S0LZjstRmQJChQLP3fbECIcnlswpyTlRYaLr/Bqu32pUnUNwxtWgRLrWkUZPPLTOpwABhASebqwQXY28flMJBEanQyuDI7lOedKMWFz71+UZiooDmYC5ptLmHW2sfsCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCDOYthF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCDOYthF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so13913095e9.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604416; x=1784209216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hO6rFDb2GEle/din1RNG5/7y3MiX9cRgUxR9gEATaPw=;
        b=FCDOYthFUNjDoxdUeeZTmBG4R4g29+SgfUYzK2wwvVgKldgmQrS9/LrfGiueS/lcWX
         m94RpCMY3fR4fGdgqPSUNOLyOcbdZfdcNTjAjxcdSXRq9PlvWnsulE+FBMV+d+VR36BD
         r9fV0M3+8IMqI7wyhpKK9SFdYhAYej37DMiVRV1Std0kXc+xrawHhGLtEUWHE8o6J/Vm
         ifMxKkbGX/lV+RlNoMAKEUBt4wUGXskO/NOUPs0QovJLJO2w86uWwpR5kboo+VHBWjgY
         K+UtIWNeejaA+7Ibu+XmZZC3gRvzO2DstQDsoAzbNsZwn3aKtWoWuH7sEDpDyatYJkjC
         IRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604416; x=1784209216;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hO6rFDb2GEle/din1RNG5/7y3MiX9cRgUxR9gEATaPw=;
        b=UHXSUpVlWbBdSGk82qi/xUtreJs9XP/8r566qKP6kJBsj0h5LJbYvPpWl9fZijYtfS
         uB/vX6b8t4O87vBgJax3Lu0tUgazW0V9ZOtekF8cIqtvgHa3E3QSNZnOtXuY5kmkL7za
         wk1nPRUuiLWLgshdPmp3fSmuNKu/jfviHlcLlGLHjaSdxGlw+TRmpRNPXo6ysW4bul0w
         Z7Gsd3L4ug7fU1mXL9AjeTLpy0dE9BG7ybfLVaoCmw1A9yp84QZ13c5N40TOHJ/3hALA
         bQCKMcj5gZqbaH4ZC19DhYpHG3xVdbdqEN6gBNYX+nwawKMAFw19zjGafyCY3mrzIjco
         PVPw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3edWxR7OkT4aFx/2w3zDx5F0j/DfYxBGQtOa/qZwm4QHoNAAkn1OrBv1ieqr1BTGwcw4peRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5kVANRQr/rp6ytuYB2GFIOTUWCgxk95zkDOMA4CkriVw7GLh
	i6FiMd8LX/4QhrDAseTBr3r43vtyjYWUNGS7OgxoFHP530rQAZHTy8If
X-Gm-Gg: AfdE7clb/vyc1RLCiXZDSxpZFsCEpkL8uMDpwaYEqlv3PPL6eJYI4/sgsodhPVhQqDN
	iOlo4eARQuDa5200jDKR7docW2SpfQPk7EjSAelfUmIMO7zq3zdkmCGc/G94iZdfJ6wocWgDdf3
	oY+WVl92znsNLwWlIpvpo5LHkMhKJlUCJLrhz/1uhQoaEism66w1+t3aLnNUo75Wt1r5+KPY1L6
	6akld3FgK9iDhNXTIWu0z745uhghMHvCamKjFY1OIKZD+XuU9CSLf0hOQFkN7zplIbKh6SyOZvp
	xpA0V2lggJWYdq3u+O/l4dyno/ttKhC+eI7E3/SBSx57vH15lyl/lAfs9Kcs6sMHnTPLun7qYCA
	+OrDER1CObF3HRyGs/rnZIU4YU736SbH8+TGxUE9vwvCMEZ2qMpBpu0dDgbVjVpWpj1n2KXp3oN
	VmhXdgpPipzLltHWcfynHf8XpfRdKcFPdrxhWRTuzLICXOffs981oZLqMg/6nQsw==
X-Received: by 2002:a05:600c:8b17:b0:493:e6f7:ad75 with SMTP id 5b1f17b1804b1-493e6f7afb1mr67726295e9.11.1783604416401;
        Thu, 09 Jul 2026 06:40:16 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb70a372sm62769235e9.7.2026.07.09.06.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 06:40:15 -0700 (PDT)
Message-ID: <b2a52387-32b1-4a4a-9cc9-c3ec83a313b5@gmail.com>
Date: Thu, 9 Jul 2026 15:40:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/204] 6.12.95-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260703072825.068705122@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260703072825.068705122@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2026 9:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.95 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.95-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, please backport 
7ee7f48413c42b90230de4a8e40898b757bc8e82 ("perf trace beauty fcntl: Fix 
build with older kernel headers") for the MIPS build of "perf" to pass.

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

