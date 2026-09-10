Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48C489FD1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048324; cv=none; b=LbaRX/Jyn7om6wujI3vnY77WbdjLe8dlE9Lwh8+eytxwQl2vTVQ3/JkJAw9h6rfZGm2BDKX8GhNvOkFnm20JNFspZWX0rZ3cA357fNddGUPz8Z63IAdCgqNjA+xhKgoLSxfrBLrPCWhNrxOrJ4d2pdMJ+fH5HGnIFIbo706itc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048324; c=relaxed/simple;
	bh=QlSh0lMba9S7x+7oC4iH2LRXRIl+WzSV8mlor0TBLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJbLam0/D3jMoUV3xUibu7HcD/7g4amAjc3v2mqblsV93Xi2JBAGnwglhZFhYUkz+6ws3eZm2C9F5S6M20Pmwew3nQzJuHTNQ+pg+mjmVFuesV9kqQ1t+66AOII3tiOzo4mdoWlrjpBJbF1a875FSBVBjNZzjwPyKBZZfZB5kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=dwiyo1qr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="dwiyo1qr"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b568dae0e8so965194e87.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1789048319; x=1789653119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M1fkFxR9UHjQTFsOht+nEf8zm2sZ01COQeC9Wr8GY5w=;
        b=dwiyo1qrsnbmeLpdDV09K33CI2i5Aj4QPQ0QjdLhtWZIhqRKRbO8lSUlg32AL3njf5
         9hHSVjuytV11cgxmT5H9to6fucFMY3s9AFoG7QKdHfk40wykuqJJzeNOhAlGiRLjJrx0
         ULCcY+KuRZuL1xu2a81jlR4QmAKFRl3cRbFA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048319; x=1789653119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1fkFxR9UHjQTFsOht+nEf8zm2sZ01COQeC9Wr8GY5w=;
        b=LMPze5mucNyrwt6lpX5jmYQOa/PMRy/PccmWNX294YO7DxIu96+65CFiN0uLQUj6ue
         GMeP2JFe89x3Tf565lMyLBDrvaPQkoyyUEH8oS6ekPgS2N1QnlB5rLX2IcPJYYjC2Q3+
         PFPmDmrmfNcp936eaPjvwz8yXRPwdPvPu5LpqilyWAmDATs2DRbuH5MZ+8XW16PgF9Tz
         /85Zs2BHIecErS7YkJrI9NDPCkQDYqoH/i+dSRRUIi19sfh3euch+mhvoP2fVtwnwGtk
         9LXr17KSA/cOpascijWgSWCIYB4fsionxGu8Xh4XTyNLLPCzPyLjtr2mx5DTNvREVDFz
         pE5Q==
X-Gm-Message-State: AFuF++k64e2UHBgV8WKlHbrZiDC8FGSUkLqERtfd2FixbEebCGcj74Qu
	LsTVig3Z5WLT6yVpBDausqC3mfa4WZRCoEn8DHF8tlUF/QRBjJaeHnADonQzmhDl+A==
X-Gm-Gg: AYBFou0dMN/uN6pcUmDV3ZGr6VfSObnaSWldZdQhVVlHX3t8XNBMMlkgI3sPjO0dN2B
	wC8UoO65yG5HfxMQVKXSJYtODaYD0uBaeqhRQXlEf1kMoCPo3pj68e0H67rPviRGlq/w24QawQv
	uS5YKmjSOH8QoDASEUxLf3yT5bWR4BszWKhUAzg8VASf8JpVmv1AtJIi2hqd92z5m0uEhxMnn6z
	vblKUOjDfwT6SAen+dScZDCkKEvgSDFmwbSgiwjVT6/J3YtHZbRsKT0TT18Jk/2av93T27m9vVK
	nThO0nC9P3LZALyfJRDZwiBwLWvBXF3LnNKRB88UkyqFvFDqs5ovQMmgPr8i2uhflIe0601GbdS
	Y5ks1XjXXQ36zE3hwrfZsXu9xF4tznaPcaxT8RCk+5ngV83oupXuIUDg3wUoKxKdZNzuyKk1wSY
	+LtzkV1gTBBmEl45kxwuzgghL0n7lDcFV9V6FXUIlHFexxdVMgs49HR1QQ48nzzhmbvW8d5Sm/j
	J4s2JPlp4iTVOhonFEQwf5VnXk=
X-Received: by 2002:a05:6512:b9c:b0:5b6:1a7c:fd87 with SMTP id 2adb3069b0e04-5b61a7cfe93mr6974483e87.45.1789048318560;
        Thu, 10 Sep 2026 06:51:58 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.105.164])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6167027dcsm4473627e87.58.2026.09.10.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:51:57 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 10 Sep 2026 07:51:51 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
Message-ID: <aqK19316rNBHIHg7@fedora64.linuxtx.org>
References: <20260909134230.441546314@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>

On Wed, Sep 09, 2026 at 03:34:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
