Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE13890FB
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062853; cv=none; b=k9Wlf9lCwS0w0BMdm6Xw+T1VdxtTbJBpMI8/YV0EqzhytsAZpnnj5ryb02azDjaR8jlPBha5I0chaXceHY7LDFNZdNTw6mBp1407GR9g1HxEnD3mo0Fvqjx+XV8/HX+IbvQUmf02chKB6ZngjqdnxwBgLr2flB6c0dXa7/ne/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062853; c=relaxed/simple;
	bh=YeT+efPB8SN0Ble6knLseD936dKAeHF4GuXCsQVS6MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSc+HuKAV2vZHHuHEE0rtuAShIn6DgfhmFwGb3filBAB7Do2SK2SgPqMUo/e38RTwoYgCz6jCjw8SShXYYchr1x1sOHVTnXbGK3984/P6GFGjyT1cl1wxeXB9CBaQNQwXyLq7MgwS0vrq230KMJHHMNcQamUuiQoWK25e/sXjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B1M0k66I; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B1M0k66I"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c12986ea776so7249566b.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062850; x=1783667650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e43GFmd64lmRLV/cd5SLNbiPWjf6jygsiKOe7E5GoMo=;
        b=B1M0k66IrQjQzgU1RMp0FFkA2VrVX/0JZcUqC+MD5UaiOFBW/bi7Bnmici72lTo6Ut
         crEfkQmu6zmwfyq7bUscnGSd74SVVjMSBRAUirmS4JUUPrNh184RNlx0yl8B8WlkT1LG
         cSfi80SuQwgITC0LgwIX8BknL9Hv+3zYlc0OOGwxLlQXQvGrsHFusyWSN4tKL6tAOujD
         h0Q97wghTxReruVYTl9k18vsMVlYNbS3Bc48w/QLUSbomEmCJUwsfcK3VnkmOQxSkwjP
         KVoyVxzL4PQAU3JdUUJla9YQp03CBM1EUhfL4wqSjydzTVdBYDslKA7H0isgl7eG57si
         8tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062850; x=1783667650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e43GFmd64lmRLV/cd5SLNbiPWjf6jygsiKOe7E5GoMo=;
        b=m+d0o7HSDaxCWjdunfIv0Z7pYxza4nRsHazrVDR7tipP5sx/8HWPMBHiPjrWN5IakW
         xcUl3pPz+9iSnIjPV5HCtBZzsD6qSIZYl1sthMuxFp1VbD+iLetRtO5KlDm6wYFD/eYR
         1cuqcP6xyrPjM0Nz0Xn0zn6V7UCO4k7dsx2+2govaxRRUba3v7nC28b+zTc9fq44f95F
         p0bI/w8MmuRYuWCEUqllb6kY3g7eCHYo/LaDD0uiVgh5vdDGOJ44ay6mXzI4FuiyRCqV
         IPbkf8iqrJv/H0661QC51n4itEzO/23bcDRjYSjrlk4xfVq3qDHqSJAwBcBT9l6UQ6hd
         sPFA==
X-Gm-Message-State: AOJu0YwYgvC9proJOfAR9dHB+GlT1vrOHTSYJsJcsbS2p5Jbx+C46kNd
	Ao9c5vyRoCtdAoq56Gw0IpbpVm9bC3RTa/CyRQBXOFsG85TfMItETTpiPu7G3tcNpJY=
X-Gm-Gg: AfdE7cnsBmqqsms5VmXB16sIjrdu0Rq6ZRzkVd1paoKuUwfDdEylNjPCokFZvo0nsSZ
	o5m5PaPSq6FZLRhOpohOwPpPaQ4KWZV065baEXPrclcI/yJ+Jq3b3m74NRVaUxy5DHTWPE9moVZ
	ajBw3E9WUp6WYDrd/GvdRXY2CoX6VYnJTSPT5bWZJFJhAXQxmKjJsK/32fBObKa+q4r00GS4RZI
	sovIJsAD/rXy9sxvBHSwqvm9vBVy3o5GC7uC7yi7xa0WWhXZLFUI11RpUXyiq4kfPiImo8mtUf0
	7Sxx3DZxw+a5rOGuL1GUnmd5bDh8bN4EPztjlfYiQWZCTLXkoF9Kba6MVzHxfX95ivZuBEvlQTu
	gGmIknWutMyBKCGZanJ8QhmJiG4hznDaV5aLjd/fxH7M1cOucHFgGwuYjx6Ff8cq7Js/tbLTHxr
	3FiQJhM7pKSt9iE77aL7VKVJ9aAtUXgmga
X-Received: by 2002:a17:907:c244:b0:c12:4a17:ef04 with SMTP id a640c23a62f3a-c12aa13d082mr470072866b.33.1783062849984;
        Fri, 03 Jul 2026 00:14:09 -0700 (PDT)
Received: from u94a (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a3103ad433sm3724083eaf.12.2026.07.03.00.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:14:08 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:13:54 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 000/175] 6.6.144-rc1 review
Message-ID: <akdhD_Z29wdMWxG3@u94a>
References: <20260702155115.766838875@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>

On Thu, Jul 02, 2026 at 06:18:21PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.144 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on both x86_64 and aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28642644980 

[...]
