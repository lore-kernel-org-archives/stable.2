Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED16282F03
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661696; cv=none; b=ampRPuQKQ70l6a3Mx9hZyQy/MgQKrgT8SvPVwYuJ8tRH09zH5oXwO408OHR2VOpuDvspVoxLNZHXmcAvB8j2/Gec8BdmLFyjkXkwUUnadDBC9X7HbvSBYNUXNuR98uYYKGTZRwxeC6sTd57pWTD4+O9/N21XqVr3bWqvdwYLMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661696; c=relaxed/simple;
	bh=iXaY6QzEtxYygAZCiV8AZoRabJqbvJno7GdjGaSiqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8FITr92rxWUyTFNzl12RhiNEgh+diSeURixfgXUaUIzMYy4Scf+rR76l1zoKDyufMafJjlLdEJISnJjQfAvtrtHqNC7s/WOI0YrkuLBBWdFV13uW2EyLbN9X05K7yotfrMMfrvdmJ2iKKQ9xkq2koLb46pxVwX1Nqhg8HmK0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WIivJMnG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WIivJMnG"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so10148982a12.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781661693; x=1782266493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWA1IEbx+mpOnundKdVvEVYP0eJfVw5sHeHLoIBZwuo=;
        b=WIivJMnG/Vb2Nmm3500Qe7ejNGG4pV0mY9wrh58Ofmytxd2cjmRlAGErJgkTI+8ycv
         EBiUg5l1Z6cjJG3sy64LGVtWrvJnEGjdGq7QTomzKFvNAnsC91B9iCMgfZOZjdGaQIDw
         FSschaDk1vK4KZHcYk2lWIG/yIfSWqsOnht7Ql34itYaT5indEZEPPfuf8XVBQbaMzD6
         5v//JNVsvSTxy0FKqIYcfoYnw6E86cKscGzxKRtdLhWqUz9aUE+KurBeIdVL7kSi1zh4
         jBkPwgqS/fafbzfrmzNUO2/mkFatbkEkT38uIzpTP236dQ28vBZCBm5h4KZnoXIVP0Tw
         f75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661693; x=1782266493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWA1IEbx+mpOnundKdVvEVYP0eJfVw5sHeHLoIBZwuo=;
        b=aQMn/prYoX78yIjK2QVIjIEppMgsg56nuLelIHOrvoFrB/JNyC+e6XyJtACwqu9x82
         8O2nGLLPshneTV1ZWwguIRjVHBmg4CzzFMv9WQzEfFc+uFfX3xHzlD+olG+OjbaXyvuD
         IvVOjuV+ph+Jk8Yn9nxk7OKSI6hxORH0ZwIoMI22uIJ60dGzZ/xULpunL79NSfCDCC5h
         u8/8rJk5pHjWoU1l3bcR9kuggUWxhCgYiEJyxfmvTTJyCWNBB3YOvHkyEcl7r58wD8D0
         /TwXypKZfqBDjiRr1UNz3Rp5jK5Puyhq/KpLjicu6KIJK2xmM7YBc5B2YWfwdzhmJ1Mu
         WjEg==
X-Gm-Message-State: AOJu0Yx7ViGh97icfNZt6dAlyo1n2rYWBf2C1HlYlxV8uQe9rx+O+oKh
	0oR2wtv/cTNzRP2zysIZ4VSZhkpgKTTrPPzuYxvYRBkmGZlL7qClhu1nQNJYTxeWxfE=
X-Gm-Gg: Acq92OFFSb05TLQhyj9C/LGi6vRjlanInXTZhcig89oAuKN+H9sw1N4H8b85ZHxFTs5
	yuR4Qi+kDaDsjPAdNfPPl9aaj5/Hzp8P61US4ahmgF8nY+/Sho4FtTNJMYQ2cmpdWX1H4DHQW12
	rGn/omP7vFS5zP1SbX7p1BJ1nddt4ItmvPA62ni56yhtFjAtBnBvwtBD2u+Q+EfVnEP/CfqzyFZ
	c4dhdOSO6j8t2nnVxSmyIbg5albno7RbzoWc5VL4Yva8vE6W8tCPIzJTbGLiK5hp+XJs1Xuwj8R
	yKyLW/btxS04pLE2BNn9dyupkhgOdCOmV4dnB1zZS1g++YCOUodVSqpHqOeJA27Rp3RWOWu7Pjl
	k5Iy1NzMVRXhZRCUirmLkW2MsNW2o2v6tFULbQeypS1r3uBwtTJbU1v+bP2rs630vYhdm7JjWyz
	+iVTDYzkg+CUXgiPHYe8c6Daj/ke9UWYEklnL/ig==
X-Received: by 2002:a17:907:9692:b0:bff:334:1fe1 with SMTP id a640c23a62f3a-c05d2158c8fmr68094666b.12.1781661693393;
        Tue, 16 Jun 2026 19:01:33 -0700 (PDT)
Received: from u94a (27-240-202-183.adsl.fetnet.net. [27.240.202.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e52c0sm149949405ad.13.2026.06.16.19.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:01:32 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:01:23 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/522] 6.1.176-rc1 review
Message-ID: <ajH_0dKVcvGaUfau@u94a>
References: <20260616145125.307082728@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>

On Tue, Jun 16, 2026 at 08:22:27PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.176 release.
> There are 522 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/27647340765/job/81762433305

[...]
