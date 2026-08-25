Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF373AAF44
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694038; cv=none; b=pILbDI4OHYS+cc0AAY3fW6fh+LIN+9K31LnOUjMRDWr3DmIFjVmwbLxdzx5btFcsCqkJzlWJtUeayx7JiVsGfxRmQjYLCRHQotUrWwaZAbWjVH+RHbIczPWF4hFG/C5hnbIHfwaKzZbzMdgsOj6t2oBcr6AXga6Vig8lpm1q7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694038; c=relaxed/simple;
	bh=+p1s7ehtBm/Xh6QxoMkumt5Y7ogq0/1iBvyp8TXickA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QasbDi8KMryK15DYqTDQyqhaUnLZm9NuKzzL8IVs2lvdkUf8k+g5tKZQINsxHkVY0490+a/sN4GqBHWuQ2iLNU1f2pzt1+aPtrDt6scaDpNvvdajkAahruJWwL79BnDdTM+VFBQBlU4TRryxvHMfdkqcSSqlrzbq6WIt3yTH7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gskY6jMu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gskY6jMu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92edb12cdf2so14667285a.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1787694035; x=1788298835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DlsjZF3WwriA427R4ehTn2/RfPWu6IO9jwWcYt6es+Q=;
        b=gskY6jMumf5fZxSiv5ZP5e5JzlUKsXqkn5AcfON5PpC6saim+QhkASns3G1zw1UWvA
         SN/nxvmFRUXFeobX6ARJgSY6BuKgEOLw+uytCy4+d9nPuDJsEbOC7/sQKrFTFRrC34/Z
         ZLzyQykyDTQEXSKaubN9ih5DMzbqw6rga5muY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694035; x=1788298835;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlsjZF3WwriA427R4ehTn2/RfPWu6IO9jwWcYt6es+Q=;
        b=HhUZrIdpmCYULErWMPYYoLm+OyflnoDHInpA2ALog0YqMBcmjTcGcGrE2ZI/2prPI4
         wgserIbAJW5TprOkrJ09ltnQ7S58xLat3sw+eisCBVFcXanZsagFRjv056ssppH7E2sm
         TaCiyr/+/cFkhifINt/v5z47qmbHbLKdyhDN7CR2+deX2gTPB4HN9dGavV5dGFTg/92Y
         xqZiCY8dQi0yZ21s9imdQfnmpFUjxiDKouXl5WZ2FHFT8qfX9jYj4G7FMgUUoymNV7I5
         7Tq3/aTbzmRcKjLldBpMA8Ntip2u1BBZfSSZmunoL5wGCzKaAeuXnDY/7xBuRbGm8D7K
         X4hg==
X-Gm-Message-State: AFuF++kTxuo1GyjTTP0TAZDSBgYOu5xzvoc3IZ9xpOuY/21f4rYS6gww
	pIWA8X4lQgMb6WpA+tyLbrNQksWVcLsB4PBMXuPFWhdachLK2Nk9bxgT2n0NRqJK4A==
X-Gm-Gg: AR+sD12zovsqHrN1YI682N4hchLeGmtjVyGnoAO3OcuUs+4Zcge96+A1Mg+MER5D7wJ
	PEojXlge745rlN4lYI/SfQz6UOFjds18rbIwgSnnxRAMK5noFeWxbNrgB7uaD7DP/QoO/iwytB7
	qcSe5V+cd0qI67Zvicz8mcWfv0dovLZ+dfweIz/wibJclZ9hriHl/hgh0MSoDTPINZWBR6ujHDX
	83qwPUBH8Hgc3F8XA48XVFhRnUdYyzEJ9zutcoVGLorKxWZea1KQq0kGefIy9q1m6dgaGzudjJ2
	h/KBzh3JX7P/RD1jOjcIvUhxU9aIPH54BwVWISbMvM0JNq4zdQO668zaKETOT2OnxjSbx953Djq
	qiA3QqBWCnDS4oW9RQnabgD2ZyOh5Na5XxLTf6PSM4ZtsNzx8CVNJX7GTOShB/AYbyDFoTR2R0E
	LGNeTrQeKZxzbuy+aLUuu6yLgr9LaQ0br7yeETXK3AaAmGa1g1amHH1Q7d1IExXULW0CkyEw6k/
	EgeVhYNObUGDKs=
X-Received: by 2002:a05:620a:2546:b0:937:3d64:6608 with SMTP id af79cd13be357-937803d153fmr163839385a.23.1787694035517;
        Tue, 25 Aug 2026 14:40:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.3.217])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e61a098sm70013085a.23.2026.08.25.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:40:34 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 25 Aug 2026 15:40:31 -0600
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
Subject: Re: [PATCH 7.2 00/82] 7.2.1-rc1 review
Message-ID: <ao4LzwbQ3ElF_aS3@fedora64.linuxtx.org>
References: <20260825132541.560541185@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825132541.560541185@linuxfoundation.org>

On Tue, Aug 25, 2026 at 03:24:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.2.1 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.2.1-rc1.gz
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
