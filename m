Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206935E92B
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786211009; cv=none; b=TP0ECy46y9SQXesV+A4t6D2zEvhzuc3wqKjG/UpsIKB6e214QpuxQsh9Hy5V3djdJx9hDVkuLc1fOcCdCN/KMN8QBFq8QHi6eraYzpnxUgaAlbhbIGJ0Xf5e5Vvg3bJLYAjnPZmdqEW5FN60/uVzE/+9JuSOJF4+SgjzZwRS3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786211009; c=relaxed/simple;
	bh=mNPWHO3u8YNjRnTPnJXaRB7br7scZ66jpkkA9bLN+yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGBP6yWJO48UbvYdOUPvfJeFGfYbGa7rKce/PbsQXrDAF/kDYwO3U9RqGk7JYzlgsuSsFclAvlldq4WRxrgWqaABjuud0hHQmEo9lptNySAiEXgVyYKtvrzc49Ly69+SYL/BzNc5kqlSWQB+yLzgoFKcsAAQn60FjmoJ0b6TDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=VrfphHt6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="VrfphHt6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92ea24a2dbfso49154085a.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1786211005; x=1786815805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4L9T0gS9wO3bG4LXruqEBUbaoDyDnucdPr+CTkX3TcM=;
        b=VrfphHt6ln1TfWTiIWq+1OXRzsB+j4NvqahjcQHbmGHVlXshA7oUYH1jHTsahZrIAe
         zVA13jYa5NcYp84nLVpSZjIrm7zh1BH/TVIlxkYap3mh6uuMduS9PDhSVYctiyYjnJ+x
         aRxcuwWZ2ktJrEueUWtk4F9mI9ILWfAFlZSoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786211005; x=1786815805;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4L9T0gS9wO3bG4LXruqEBUbaoDyDnucdPr+CTkX3TcM=;
        b=FShwAReVUJg5ykSncAgwxl3iez/uPFzfV+onLxP9K0mwlIod/smCaJtElKZ4HDMqis
         RKLPxXnkXOaGODJwGrRBIjf+kmMvAvcm2aiCj9qqOnPKi7ygha2tZQaD6HRD8CHURoX+
         LFBHNPSQXBWemAr44CrIXU1emciyxKOno9/YFQ8wQaTvtyyZdJHOYvcbrnoIkWC5PHCt
         tyaWyCI7U2S6SNxsKgZIx5hxt298ipzRWqAGsPEkeizksNdp3SLWbP3B05R3kCOzfBiR
         5pQBqvl1008SK/WaVcx7tn0g6HY1sqF0KM0Ok1twqcoM4dhjAL+sIk4+i7oQx4/YZ11m
         MFiQ==
X-Gm-Message-State: AOJu0YzgtYetxpryORdez7jmXZsTN+iEbvtCKs4rIm4/f+RcBMb8ITNc
	zDoaBVvtxYKZ/kUnhDjzWGc+3WMpfShStkt1n2EBQx+ZIos4YEuOj/9OxrZ3Kxo7yA==
X-Gm-Gg: AR+sD10VrwZYv1myqOGcB4cC9RmhIDeMIV7wUpzXnC8mRrhby4GMdaSAG/DjL+NBX+Y
	KFsYBqyFEDvn9KJob/xz++gcIrVFZcU6wEeWSruBchSi83zyG4tJuaKt/L28C331kHFrvJH4FAL
	2NR90dHAYiqpq4vfURY0RlUFJSbZ8Ael75agBeD/KmB7b+97aSB7L0BfLXewo1R1+9lYaGESZYk
	OBH1xh77W5asgNRaIUwD03ul7Zy2vwa2ibT1him0FTw5oI4zh36cT22pcW8bicCiA2devaXAPLc
	gZ6ueyNiezai3/ozoOrUE04RLKY7MeDH8/WJWeCFXE3cuLI9LyAJR5s1dxHDRaj4ymidiB0C3gr
	yTnUZIMFe8WvBM6lIyDvMOTXyAXphqWL77+fo5byUhyzub5ouEfR8zKc+GiGQUEBJBOsXWWH9B4
	Xa8hftinvEsufQkFqc+iMXaoCF+tk2hIu8/0IL7Y8lMlHJNADls+As5iwXjBlpMVOui/oAO3648
	2Nd7w==
X-Received: by 2002:a05:620a:72cd:10b0:932:d92c:1604 with SMTP id af79cd13be357-93649190884mr2597851785a.23.1786211005341;
        Sat, 08 Aug 2026 10:43:25 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e09dc07sm412856185a.15.2026.08.08.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 10:43:24 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Sat, 8 Aug 2026 11:43:20 -0600
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
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
Message-ID: <andquGZSWMCApb4t@fedora64.linuxtx.org>
References: <20260807143428.008222056@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>

On Fri, Aug 07, 2026 at 04:33:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.8 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 09 Aug 2026 14:33:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
