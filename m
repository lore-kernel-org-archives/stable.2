Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086499;
	b=UGl2B6vmzpxP1L8YNb2aDL7cKiu1wJ9NtJyCmOFarxpOc7+9pZcUYBLd+ZVsi+oQkAeC
	 kxYThN5Pwus7l8jCMRvItOlrSg1DyDyVVrVwoyPeO4Uyi23XFl7AuRqvA2x7N5dpxZpNY
	 8dnmXepqKHB7VwL6zWv8JteRMLYtw7iVvgE8V10GJF5lp+Lh4CIpLNDckcgVzz2vftHYW
	 J+AUIZDURrWHM6yryO7zS85hPRlg1lwOKtaPsvW8GclOWtUhZfGKQg3kamDVJuIWYVBql
	 xPl1pWHestn7edEwM5VPhID6dchrykwag19evNYgGmP/pRbpuskUN3pNp6ZfLbjBo0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=1gFFQM2dmDCAWo152jTDOkXj2oU6JPJwu8xp6zLm5EU=;
	b=3iarYLrhO1JqUlBYDywyjNsf34iZ3Y7Ol1W5vEhNyvoFyp+0SAiQOVT2Ex81zPzVG7In
	 Akt2UQC8qlwJM7Hy6c0aLUOt7Sd9pT98XtOznJn3PFTCSRE9OkQ0+TH+mliGN1DPdQh1D
	 lCc4EaNmvUs4IhXDTG+XoMhDK46IjaorvP6ZY3+dfEwIFCuJ1s7UbFzr33UwJP9UiOsSC
	 fhrrAyavVslt2x5U/dD4VK3s4DemB4qmN30YJ6p6easQQRs60VmYOev6v0cs4caCdIerG
	 tKsw+sjdeyPlParA+Ysa8eDHDnSrDNp9oWy7Mo8aTbCmDCw5H8tBqfyy51QltaEK/KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mt551NEC;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B7606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE0B7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mt551NEC
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so18399955e9.2
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795086497; x=1795691297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gFFQM2dmDCAWo152jTDOkXj2oU6JPJwu8xp6zLm5EU=;
        b=mt551NECXTbG64W5/NdkHegyk4ADIgTfNkwHizUSE7AbKWkGel0padE3/wCYjgnFnr
         bM+riGeE/5NQCZ1h5PER1SglfaAnPewcn9RgfPjEvsHn1cvGl14U7TwXytIsP0Tyhdca
         A9NaCUfxE/O2Yr2ZisoTTjymDBHXKOUh45Ea4LgeZVI90wF5kozULxfJ1b4eaTE6eu6c
         HM25CvZF+mgJizuhHgixxh6SAf3PFYN1fAHCq8Q43/wEW4fS3isql87SX2mnn4pSzkxF
         xoSN81GiHJdZKQm3Vj0/fi4MlrA0/3QW82lDE2IjChbNUHvmYrtEhVFbBkQ4cfwABkBA
         aYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795086497; x=1795691297;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gFFQM2dmDCAWo152jTDOkXj2oU6JPJwu8xp6zLm5EU=;
        b=jkOsTU1Nu5I0lfB8n7A4JPLAdocIToM4MjvQTZRpsc9QJCxZXSNJPYb8mSnqR25bAL
         qYGFSPGn+F2cOwDCfxjwDkvbPjCvrWDTvJOHsG0lroFXLFNUjIsHSV7Z0TqKJfCqTSmQ
         vSfeSeH7ipSaqGIz+gEEKHNzaIk3LxSxbu1Eg6g2Z1zkb9ubYCIWOPubPWHnZK7+y+hY
         dRRpfMWu7SGodFDbDErr2sy19Ty3nFOVDpG1rnG3zGdsbsLZNwJ89nGdu9xXcx3B2nfP
         SuqAhWiSo1h5EpDAouYAzwbun7FOwfBaVFXze53kt2TTF7TBCLj0UalWi07NztrVilbz
         6lmg==
X-Gm-Message-State: APuU4Z93C7+n4l6U4D6fuWNIbLwXZh9PiYXE1KFe776OE+X9mjsP8C3A
	kV2fmtDxtJUcj0n6jQs6LdWZ1f2UWga6/wMZhQy9cFEoWggbYvM2xpe7
X-Gm-Gg: AYBFou1NUy3NiQqujGO2/p8bvyMaGajSdXSASyXHrHHqmMORgcPxuy89qsHE2424fX9
	wc30HPm+5OqN3LZkmMNV+lal83fZcZiQVN4/lAlbNWi/0dabJxTreBalWVlYoukwjZBYGja9Vl4
	5i2+b4F3C2FyEJV9WCREnAIkMwCFG3s80ZuuLOucurz2TtJlXlOHCJGLET4aN8xnN7INSfKWTp3
	/xRsPJphhYaNMXzdOt1GHaGiygaOQR4KNI6jojUcIo+qDljg9R97+zOSLTGMFzhHWl8NTbONWSw
	GezOOgshw1Sc0GoaznGR1OkpMjB3peEor0P69pKGvtkERQWDDyGAmLNFbalv6Yqi4DHDgcBlP7S
	esRf6tD/1MqcMUKYj1dDae1JKZ6SV8bUy/i4q5tUVIuXoxH4VFjG9R3g5ZRWlpyyxs4wQQpP6lN
	/YAV9f2biZ8PKGJZyb40oXxxNW86FG3g3uSVN4E59h7bMyhDPXLzMofrxceA4p5GBiHGMVMQYum
	7R4Ph0ClFJq9q5BF4g3IdYKIKZMOZZZ3+lY4ebh8MYIv89co4qrYQQQ+5N4upV2Ves+FV1yHzwZ
	yGPG9eO1K+IZG3KHP7HumiUrqiMT5nZPBkRJTjMglcDrjmsMJNMd34YqwEj4/yk14xxNcHo/6cD
	j3/TaE/3kHA7W3EnLth3zCYuMQejC4Jxi5tsccr3o2xfx5jBAv/Db0ykiT9Wr+dJB0HEOGJc7hO
	R2CdTQ6RgfLSKn8Qsk8GPKluCySQ==
X-Received: by 2002:a05:600c:4e50:b0:4bb:6a5a:7834 with SMTP id 5b1f17b1804b1-4bb7da1edf4mr105406365e9.20.1795086496881;
        Thu, 19 Nov 2026 03:08:16 -0800 (PST)
Received: from eagle.home.marco.cx ([2a02:908:176:3bde:c85e:e9f9:a271:af77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b216esm29479975e9.12.2026.11.19.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 03:08:16 -0800 (PST)
Date: Thu, 19 Nov 2026 12:08:14 +0100
From: Marco Schirrmeister <mschirrmeister@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 0000/2151] 6.18.65-rc1 review
Message-ID: <av7WKeKW4NdFzDk2@eagle.home.marco.cx>
References: <20261118150121.603863898@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118150121.603863898@linuxfoundation.org>

On Wed, Nov 18, 2026 at 03:28:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.65 release.
> There are 2151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Native arm64 build on Arch Linux ARM with 7.3 uapi headers and
CONFIG_DEBUG_INFO_BTF=y works fine, without my local __u128
patch.

Booted on an Odroid HC4 (Amlogic S905X3). No regressions noticed.

Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>

Thanks,
Marco

