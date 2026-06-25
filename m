Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E566C2F8EBC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408658; cv=none; b=j6I5Mm2P69dpuVivhvgbEzfBK9/KW5ukE4D+KZoNTvQius24SyRKYbkztqNVjzcOzQFTYSsCiT7eBTfXaMyv962wuEHZUNokRLXyu+0kykmYmVo4Z1jeYhuc+nsc27Uph8mViXoFneKvX2j4WuhKI8WFTuKC8dpJorU25nn67Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408658; c=relaxed/simple;
	bh=wVpHIkn3RE3gC/nfpVm3k2hccIIjRg0U8XV2yLjOTIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO07mojDKa8zXwIQzny0EDldfIEdTjGkIcMGt8Caaj2bETI/Fyq2ac/3DYS7pP/c+R4zV/0eFOLd8xMUXfYU83K7zHxzGVApAxNM7brNycM2ZD9FgACZhpWtUfx76gjuhnCdvAP9HsI2dDtMzL6LCBIbm+GeO4VpZJAI+QhhYZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hDK8bw0h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hDK8bw0h"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c80d215169so1674865ad.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1782408656; x=1783013456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ns9Na0/3PBHaGaylTzimtteynQsaE2Wv7+sI3PG6dw=;
        b=hDK8bw0hh4t69qZU2QfTUgGmXmA8Jvd6xVmAEvOB0xBo29O8MCvx2zTEQzvYSCl6x5
         ia8juwfK98DGGgfFcU5EMyUMJCJMJ4eu3id1u3Up7hFy6vV7wx93K/rnKvuNGFPbbwR8
         xY1491OoBHvtS8T5prnJNySobHevK4mwJJrsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408656; x=1783013456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ns9Na0/3PBHaGaylTzimtteynQsaE2Wv7+sI3PG6dw=;
        b=l6OTaXKj+niOcGcQqWVNVBkR5L53z27x+bOPMlpPjajRGMBTad/gZdz69lW8MGdirP
         +WticWyvAARJuUAdpj/fdzCHvi8G1AwIvnLHeCNSCpfV7uOekMsgisEap7zaHQN3QsGp
         xWGxppGFIcKnH1gfOOGfx5Bh1Ja5A9Q8svC8q8mAyUmx5KNVK0KQCw8O12Np6Rb2Q6Xm
         AOaxB91uU13V11ZCCgVGvlFnFrArTBrwh091bMc4H7ejhZGR+g96fqkC5JdatiTSdl9G
         nyNUwLwJU0amFCHzZt/JbYP8ydl9DkE50cwInalxO84/ALhO5epKFfhPSMkqSufOgr6v
         wRQQ==
X-Gm-Message-State: AOJu0Yy088vEyr1PCQSauSyegpi2Byoj0B+3jQpIb9lo07KuUiAc+sL+
	e08nxVQ67nRBQfB6HeZrSmOR0wi5c9iZCVcevvoEI4R0UcgYdptpW6VPiYlaoPB+pw==
X-Gm-Gg: AfdE7clPR9ymHjJErR3KcEKKqnOKR7wje72IM2m7ebOJ1GkjN+0xKA3zW+Yz61Jll8n
	JHBsxBYA+qTTmBs1P4kOvyF0thNT03Y+RpVK8qO0hB6PHMXu7zFlw7lxPCuTpRBS+R4L0At9vDm
	O19LozY2eP/OtptxgU6YSpkckjc9iQ1OedqOB8sP7oDIZav1fKW0sH/Dz2NHyWGHKRX+sa99B8I
	9qxmj5ofdoXyxlvWxby7DiLxEgVRri9RNHNsdnogd90Z5S+Chh7wJ1j89n67j7MObwByBtmUSHo
	YRpurB2YglUlmB+6YgYblophgZ5Zrch7p5HLqWthbapaDgT+8D/4uOA4iwCl3Bj8Z5QkxtllSxy
	xuQLXjb6Lip3C2Dl7tpdlRGKcB7MwL31U4i5MWss+fuE2j5VGubYRI8dyuEq4mqU/1FudK1I6yt
	Lrbr+tlfcRTXldnCAmMlJ3WpBX6XbIuURwU3HLkmgs
X-Received: by 2002:a17:902:f650:b0:2c0:db23:4c1 with SMTP id d9443c01a7336-2c7fc63261bmr39873245ad.5.1782408656107;
        Thu, 25 Jun 2026 10:30:56 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8e3csm24377875ad.10.2026.06.25.10.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:30:55 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jun 2026 11:30:53 -0600
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
Subject: Re: [PATCH 7.0 00/49] 7.0.14-rc1 review
Message-ID: <aj1lzVpxbxFz2x0F@fedora64.linuxtx.org>
References: <20260625125637.527552689@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125637.527552689@linuxfoundation.org>

On Thu, Jun 25, 2026 at 02:03:12PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.14 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
