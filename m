Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138338B7CD
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062687; cv=none; b=GWsStFUR0GZ0qF6LBheZS+qZ4hjLljxXOyQva62wTVMBWivOWv5mmpogz/n5lW1EtO0+r5SfGKfKBk7Brl4c8GpfbVI2EZfu2Q6PMMOPBfqzHq4HY88Xikm9+mCB56/orTLy58R6KEcBsstkYsYLAQFLffeznjwhW3qDVN8YLQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062687; c=relaxed/simple;
	bh=m0fzZSXhmolsQTU7jiJJ1fg5focc3B9g2Vl6TkxHH68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWmiIqHaaTDf3eEnXD8rrZ18Kkh2K46Sr+izLRZt7NElYHMXbRJa9m+ibMVxJn/BoKat9K7LM91aSyUmrZJST08+DrimS/SYrMjJupyz0Cjer0+aT7VZ6oZFOkA4wgTQh2BDe86rvdTXS31uF5cdicM7gELtddlbLtPXveLdIo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ERekLoeK; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ERekLoeK"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c128e8a16e0so6339366b.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062680; x=1783667480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh7LfPMfH4JgYDvymV3bp0NHK78NqC1JYzCZO861AkE=;
        b=ERekLoeKJ+hu51krWyfYKy4CPGUOmrQwFqzrcAp4Be/kr64GKJJNVNPuAC7WxQA07l
         3Aw++WbsKGdKRDuwtBuw9B4jsuswTAbQrXaPy/pEzWNKggDsO8cso9Mb/4zghhFet00G
         W12sObKpcxvCHkdAoBiWKDAj9W2MsLxwAt0DlZC9TxXviU3Okj+D7GVbu7ov03x8zjsi
         pg3ICuXS8RC5kNadyClDFVCpWCAcSgl2nVYxk71UPZsezBum7wFYlE4i9MwbgDg4Ow1+
         mSWanp09FPBsNhP9BDdHFagz6X5DPv0ITQUktbeKEvt40IBUHh0yk0cnQd1OWghocTI9
         h8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062680; x=1783667480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh7LfPMfH4JgYDvymV3bp0NHK78NqC1JYzCZO861AkE=;
        b=YAZpE+kYK3jZroRr37DirgntFZe6vxsqsISgnSFUvLnSvlpOysyh9cDN3epfhtt4Za
         Ex3+dZBN0E5dZN8/bQCSdu3k0iiZ8YnuhdCojDO4g/XaH2vRV18qP2bszb+QhPVUZKzs
         ryYyA7d24hxNe3A5uMQ7nPmNZlh0/DclKIYiH76enHSpf7vY4MPnzIT8Y0fk51MQyOhr
         h+QutS7uTX5b5aasAThIgudYtfo8LDb0XxzFitmJFFXljjBjUINreXyrroadZX/XcSPy
         eg8NFNRHNnhwnMYzPY9XUXXTc1jUC0Gk1IerGhsyJfLtn4WX+9DPvr8/YLgrm7ZA1Qyq
         4oow==
X-Gm-Message-State: AOJu0YynhxLF3TD8I97KPQchLvr2lXAVW3r1kahXyl6mupcD757njFdN
	E/kD6egi32LOXq6NsJzhLauzp/pa1x4TjhvOgQff3pyMdca3CULcxQ6HmmjbDRBZRos=
X-Gm-Gg: AfdE7cmF8tLg3zD+f0CncnGMgv+Uo0PWtV4nNMRvwmoBDFPJHE2NhP2FKDTXMKurULr
	Ch6LQnGud/yK4ysoCz3G4ownWD/Lq5b2fsOwhQ1QmEtUtoMy7EVctrcyR0nkRVbXyIoYzEkq5w/
	cV2AtusxmbiBkGIiN5VObgZfxTbyQX0n2MygIIU3t2nsHkzL+M9qNByvYnQu3a79+H6RfVvwEZf
	FS6LclGmqg25ar/gLbaArWXa3KTkS3ZpMgvFSDsKI4tQh/o7KS8axa3MJk83Vos5D38vVL3tQ4G
	fGd+3n7Pb2fkVbeF9lSDMCMg2lMne8XzlEsqfhFdUhpqXHXqUSPbTjeyUZNbgZ26YWCI1eRjyDx
	Vd9psNTOEyPXixy3LhO5FTjkoQ5qXiEkeWy+r2z/Vu3agTKVZt9D+apuqzApKd/6+12ZNsS2szq
	3VwameOs4hxkxVCt4d9LRLtBrLC5/rkE6h
X-Received: by 2002:a05:6938:a08a:20b0:c12:b31:65bf with SMTP id a640c23a62f3a-c12aa1371b9mr279916166b.42.1783062680239;
        Fri, 03 Jul 2026 00:11:20 -0700 (PDT)
Received: from u94a (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54292d4fsm4484862a34.4.2026.07.03.00.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:11:19 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:11:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/108] 6.18.38-rc1 review
Message-ID: <akdgRyDpGXUnWFeP@u94a>
References: <20260702155112.110058792@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>

On Thu, Jul 02, 2026 at 06:19:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.38 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on both x86_64 and aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28642657596
