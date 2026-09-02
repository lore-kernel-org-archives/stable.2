Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337F33FE15
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314168; cv=none; b=pbENpXMge8T83FsAb9OwjV2ewct50rSD8KAOkyl9ucahtfE6IQIzxex0mdRULY21PCARa0HBxMLg9TPQ/ytvPHmQJkX1kGYahXb5nRgso6dxVX01vTYPgY/b+/ryc41XJ+5BaVLD1M/fPpCT/1Y7FHKixLIy3qGTr8iqMQe0/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314168; c=relaxed/simple;
	bh=BLFYJfElxSI06RtEtw8byJqBKIWSSSLCxfBzKw7BQVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIMRTbmECnVDR0aRge3/nhEqCZNHYZQwxp36AYtFlvNqRzSjD4FACkqCDDw0dRlDgkVXMRrvtqfnoSyf7J6ov8FM3WPcKAk214faIrFsgzXdqwXX2nzbR3vl+hJpsbdVz6iHjgPKT57g3/PmXAYT/PYuf1CUzv+Oo3Ldxp6AweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=e1mI8kXb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="e1mI8kXb"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d5bfa4bafso5130581cf.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1788314158; x=1788918958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpF3RtJ2s86zgT91pBwtMVnJoKBYW+etBqjKLDzF/lU=;
        b=e1mI8kXbaDBK4WG+5SyHGhGZHsgd3BQ7XzrpkgB6H6S6AHFs8Rw/pCrOUfCZf+27oo
         awbtnCPdcK6+zuM1wEIY03qMOfZeiEApR0vPcOfrc/bfByBwW/YpQ+1J2kNvHvjquhPB
         ee0AUDUScYc6Oo61MZznnmEwC6MR1BIqOX4WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314158; x=1788918958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpF3RtJ2s86zgT91pBwtMVnJoKBYW+etBqjKLDzF/lU=;
        b=qudi17JrTudBYnrS30fNRQLegRvvNu5kigyGxgQRGikkv4R8/AR7YagV0lA4aKVRb0
         NrlXJadhrLEEL9n1nhpFgxETFMi991mmtSbplDO5tmTV4dy5Zp1N4ZZke1u/NwAcRQ28
         ToXFYINEyfn4plWDHjK6nOa256+N4Wl/u3ZRpvNew79Tvp+VW9rALVKenlcY1uibukWs
         P9wgIYJa9d/F/IjnD0p9ryXnzEfc23vmRuwWSycRWK3Y2ZcRbmJn+AhMUVvApqYoDrNj
         A5namH5oe9XYkAclFGqYbDp8UrOkL20OFTa2hQ9bz2RiQi9sTWYrM5sasSi/cmYkpTEg
         WUHA==
X-Gm-Message-State: AFuF++lCKheuPBoKyQ0s8IVWYPU0Vu8i2NveTCKj+5sYtC1eBvbfLDi0
	tlovqTpz1sIhY5MuaC7Jbz+XItndEVM+xGRyfC+ylu1VP4xRMr+MN0iTW+2NAjzAuw==
X-Gm-Gg: AR+sD10D53VoZfC9GMEZfmP3nvO7jZxIkCMRPyBSSJPnOom7RMQYn0RahZVhV6COkjv
	ZA9My5XVfcJRjuiHq6seqqKra2t+POnPRtezzWTP36JJQ3yqmwT4QxrEl48qPVFfL5ICbV2RObZ
	ensWfkG/NBDmpwAweagGpd9mq40yV5VE29T2Qzk3YNcf3XOHyx1CGpgjtYTPwt0Gu321Ms+Ap7S
	EfNtBQO/TLRwcJMLDGxNkGNtAFMsZ0RJTnKW9YzznsFs73pT3KZ8XMO8jn7KA++yNVViQMqNRz/
	C+BiNJ8qBJaHVeHnYrfVWjanlIsPbP26DMUtp/d0WVZNDqTyyqapjrT0Q6iZ/hHGmAOwQedVBXA
	hLBm41N6/iIIsNy9CAhsIhA+4cSxuKmjnZztQGb0ogkSxJXHbMuO113O2A8TUIgv6qp/Qg5ZBew
	uxmdleey0lZP/N++2nrI2avaXFhAPuX2dIio9cOMw/q/GQwFCHKwPJFJxbztZfE2HATS5lhUvO3
	lNnag==
X-Received: by 2002:a05:622a:1b2a:b0:530:15f1:b16c with SMTP id d75a77b69052e-5303699f76amr16580421cf.0.1788314157512;
        Tue, 01 Sep 2026 18:55:57 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.106.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec848dsm7240066d6.28.2026.09.01.18.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:55:56 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 1 Sep 2026 19:55:53 -0600
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
Subject: Re: [PATCH 7.1 00/76] 7.1.13-rc1 review
Message-ID: <apeCKeB4TxAWlTDI@fedora64.linuxtx.org>
References: <20260831133359.185608553@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831133359.185608553@linuxfoundation.org>

On Mon, Aug 31, 2026 at 03:33:32PM +0200, Greg Kroah-Hartman wrote:
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

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
