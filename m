Received: from mail-ej2-f0.google.com (mail-ej2-f0.google.com [74.125.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0F535E1B7
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062752; cv=none; b=HXxmedmwIIOzDqBS+R6ob5WhutqSorb+WtthFQXXZd2f8n9rjVYWa9fnCqkrsqay1GHahnyc4tBIkV6i1LZXwLVPitzroEtJMckUe+QomrA30Yzb9VgLxDaUB4jE6KFeB4pyau7LrSVllPQfAyaPC1ciY/dvbihwIT3CaHfoknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062752; c=relaxed/simple;
	bh=k26oyNLe7oaY1TxBbH+N02NlyvD8UBx9AAtBAS5OF6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kObno7J4t3PKqvZkN3pSmRhwaIl+terGsT2/ZR8EkqPEMk/t2RkM8HwAZUCEYNa/Tan3ZLtqxSe37hX0WjOg7pJ17vDvEZwII/HQlXRDUh1DifhdJtBqFOelMByCaoVurouMlqt0HxiV18tiCK+AqdMzG3Q3zm1idl2X2Dgw058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PZKFQIxd; arc=none smtp.client-ip=74.125.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PZKFQIxd"
Received: by mail-ej2-f0.google.com with SMTP id a640c23a62f3a-c12618690f0so9396766b.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 00:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783062749; x=1783667549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+v+uN4E0FpVcvfrJ8/BXVZoE0D8aQOHtMFPrkQ72Iyk=;
        b=PZKFQIxd8w1Erz5IhkFd+fcVJatgVejzQI732PCldSv+So4wYFse6+Nt3b3y3UC7yq
         Ax6mal3tSoTN6+dMntTFPp8y/pUuyM/nuGQx6TOO3t5/Oopkt94LxP4aJgt3SiHSUEhE
         Kt4Vd0ax6uj1StQ7CnMD15/JH7i+9XorXLmZXSRkZNb+jjUnz34DtXoarsaOtEBUArEB
         cUYUNqUdScBOm55IzH2nZ7pePlAx/WTZrvm/vtSs2BzzZoOUTL6Cv42JywfoMRuoxsmV
         nuatOxetMGbrvVkd0fn5WZRcwXC1U15Fr5Xx3DV/i0IUlGJkedPJzdSDOEJBJL4cikTn
         9Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062749; x=1783667549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+v+uN4E0FpVcvfrJ8/BXVZoE0D8aQOHtMFPrkQ72Iyk=;
        b=nwrHlao1o/2opEzFNs0LY/pHJiB4OKzcIuL3txdleuXXEKHS1mpbEH55vW6OT7yLiH
         55Qj2lGKRSbZcW8OgHOh1yPFUEVwnncgKCfAoj6FLbcXvp8OjPCKwK2+R23EA63ROt9+
         pU17Fmzvxrt4m90NR9FG6Fqwz2UBnzQr6Ai9hdBpXiUp20S10fybfV00t6uzX0ajA+W/
         8N8vy8gi+gVmjt38w/S0Q1wYvCe2IYCJ/LKTK/Siu7hWqhQOinuQTVS8AX5yuq9Aq+se
         Lw4ARCaHKKYVTATk8d6JaadKj9TnzirJC2wcDldshEzoZg9C0lBLWEkkqkNYw1YzSVsF
         q7CA==
X-Gm-Message-State: AOJu0YyW3mpvxw9OHlLY0jbwm3P6TpiPozSgWZ2CNwPIZX3myCwK9tsz
	f8YurfK/8Z35gj1l6vmdR7hLecs7qGiQUx+tCS3kturgnhrqWCEULuCCD3IBeZp2zL8=
X-Gm-Gg: AfdE7ckkJHYhYEW+i09ru1cOIOQs03qe3gwHxkAH7j3J5JNUNTV2AoJFZvrrwwyDZcD
	Eyt/u2iy80vnTWy38tFILY4ACU7CcYvXwU6fipiQsdayD6vKRtVpTmr6ic32pFcUDRgQZEq5qeN
	c3kUvMrt/8l3Lmoawqmw9uPRMUgcJllS9DrlK7MqgJcsqdYmCV5ghdCj+LGW3tOA8oYJSk/9Rcc
	2DHhu4Kg6pzF288nDOpvcw5XSE6U6ft2knaRZJeBOgpoB9ZhVrXm4ZxvNSncYDOaTIdELZAZNpx
	doufs8QVzOBaLm22zsysiZp6RivWl5E0puJqMx5dyFUbwWiWWI+ixdz3rJgSNWOgZ5FRu+ZgR4o
	k54z+UoZviUGRFTgr7+57yXQa5aVMrXywBCV7FgOq48g5ztkY0XUPOBsDvE0uZ96kre0FbDxhOc
	yWVNH5fIsiif7Pa24yk6nT8Hi6iIjldIWe
X-Received: by 2002:a17:906:4791:b0:c12:c939:5fbe with SMTP id a640c23a62f3a-c12c93961e6mr154386766b.34.1783062749437;
        Fri, 03 Jul 2026 00:12:29 -0700 (PDT)
Received: from u94a (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a32132dae4sm979112eaf.1.2026.07.03.00.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:12:27 -0700 (PDT)
Date: Fri, 3 Jul 2026 15:12:12 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/204] 6.12.95-rc1 review
Message-ID: <akdgralrNXlV1NWa@u94a>
References: <20260702155118.667618796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>

On Thu, Jul 02, 2026 at 06:17:37PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.95 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 04 Jul 2026 15:50:58 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps, test_verifier
in BPF selftests all passes[1] on both x86_64 and aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28642679003
