Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1823395F
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408629; cv=none; b=KzfZ16iOaWkrovwfOAb8nEV0Ef+y47wWH7VvXrrwusj/UK9FbqXbCod/vbjSQ6I/p0Gi9eGcmHFZQXSLoMCKZoPdBaTYH5dU0YxkGMuJOMkCSqF6avJ1eBZA5uaWMm3RGtdKMI7Z8ZRx9Z01nbv/gBc45cVhmZideuCIkmDp6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408629; c=relaxed/simple;
	bh=NoGkKodnObKXJR0Us6UBG/b/W7A24gDDiTNloh0Qkug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS+trke+pYm4Oy2vAwQ0b6qRaNcdh7VzKLc6Wc1sZh/OojwWno58Yn1x9uOTibVMV2wPOeSaUlB1t6vj8bktoe38d8F/4jj7vHxFoaVXJYUCcJEevtEiZUOpoBfXnhDChTxG62YdenqgsQU1ISeYHmqAFXboxvPGdsTce3GGVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=SyfCW9Lo; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="SyfCW9Lo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7f3148705so1479775ad.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1782408626; x=1783013426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvlW1NLLHFTexM8JcQ2hd12AbG62cMkVNkCtboa04e8=;
        b=SyfCW9Lob+aiQo00NOrydHYuIfSjNPNZCXQQfM+NwJIPeuXlLfP1lGIfh3YHn7/HLY
         YzqAYkO/maxhsQ2XZsXeXsL82o3IBbfDy32R6ukmMSEQLdkRMbh+i5fjpM/NxNyqbe4a
         aTFfkmc+oIJHRTpPAuQmNFEZhLrHp5neD2gvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782408626; x=1783013426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvlW1NLLHFTexM8JcQ2hd12AbG62cMkVNkCtboa04e8=;
        b=hHLvFIYf9HEVjtdSWDnkNdKBTr9pSrgw4eSeI8b5bIjcEUJIla3ZjfOzpvb3vzWQaM
         Nh1U1lJbIPbiV0x03bJhkdzb1he7ZDyJ1BOmqSbpupxD+9G0hrbOyMoNiDd3a4LdzL0g
         ZD4tbcBpp05yuNeWe6lQQftIoENzYlxF+yhnbT0TCjeEWIhEsFikROpCqPMaDDeytEl7
         pM9qsze2C1IZ5SmRR6B5/f9eyc/IN9tr52xfAh1MD/5JkA2WPX5UbO4LV0nRoxKmn6Sm
         cUI9zUc3vFFa3Xyug+rUthgWx70noCVMphGIAbEq+Nn7zGqFtPvkxfXfMA+0XroJnNBZ
         nX2g==
X-Gm-Message-State: AOJu0Yw+/CeG2Ij6kYkkAzn/LzzyGfuVYJ1KvN7rmtUdIcDkC/8OE3Cu
	s7hb/UaHLm2b/bmWAw81LPuOf7ClK7Gr9GO/ypzNZVgp4sl32qQO3KQ07QJTQ3mAxQ==
X-Gm-Gg: AfdE7cnkCM5FjtGuu/QR5xkWaz1M7MPplMY/EBF+cQhkw7AX7ZD8er+ajLalr0V0PiK
	ZOivsEmhVBdtdMu5vavpsylE8PLCzfqURzqu/3oRGlJCWXMfjJ7E+qmDp8XuL/s0tZH51frH75G
	9R7OUCwbMdNXIB72s9c/zgDNE79yn8pqfQoXOA+IkT52XRNiCYS9QCx43m4Cc8tuUlfjkoo/N5l
	IVD3bjNj4ok3EJLAOmZVt4Zj5MKOManD3f3YGRdAK7bu52uJPDe+dgEHS1KJGSZRHCANj51RVkG
	MLq2+0VPoVI5L9ywLIlAK5OmP76SBnWypZzrlDfySbpmDRzzuCVke3A5l9YxciDTl2Vl0kJNTcM
	+Tpzm/TGkRnf+nHg8kiStfFlEkhr3wBJP6roWz9SRpTMddAlsIitxfh12n6oiSnPTYSlVojmDEm
	3K85BdsQIOTBevJWu3yBt/lvc/hfakpLpawyq75DiN
X-Received: by 2002:a17:902:ef50:b0:2c6:a2a2:13c4 with SMTP id d9443c01a7336-2c7fca716dcmr36835755ad.24.1782408625892;
        Thu, 25 Jun 2026 10:30:25 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5b0c1bbsm24633175ad.37.2026.06.25.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 10:30:25 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jun 2026 11:30:22 -0600
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
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
Message-ID: <aj1lrqp9Atxv39j-@fedora64.linuxtx.org>
References: <20260625125613.243729608@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>

On Thu, Jun 25, 2026 at 02:03:52PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.1.2 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jun 2026 12:54:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.1.2-rc1.gz
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
