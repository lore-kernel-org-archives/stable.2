Received: from mail-pz2-f30.google.com (mail-pz2-f30.google.com [74.125.228.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCCF49F108
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399891; cv=none; b=VqYxYzh/4G2T/h1aqeSYnxbqxqwSJLYTd4qI/BLnxJUB8iJBegydYPqogi6ZnrC+683jgDUl4Pj7dv66LuQHN+5LPPd9vIjMZcB+A8eEU4i6Df1EedoUmZniAGEtlCVUOvfJDcDs6STM1Zo57hXGdlehSxjGW2L5l4IahytCLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399891; c=relaxed/simple;
	bh=NMWkk7VqLSEb5X08dhPbCYxV9CArNelOzi5HrhzTRB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRwCKmVKb13nsGR3x34g4JFJUDAoR/DrDhKzq0j5xgcN9rTnRgIOY/y2BY0bWQVuesIhSomQXQV7FCPPi0+m9BZSGEV+gZQbjeKGH+z41qf2p4Da9yaGo2/c1pp9ThJlTry/BCVtupMOFMcJfNWJ4mbDOBmZUvg/Da8nk8uUKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8ZpZK4x; arc=none smtp.client-ip=74.125.228.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8ZpZK4x"
Received: by mail-pz2-f30.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so699907a12.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789399888; x=1790004688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=80/p2r+sK8JMp9zNzEgv5gzx5JVorvjEM6vLrigBwZw=;
        b=h8ZpZK4xMWTqOqn0FwqEmd00rSPtXSkB2uXS520GtEXk4X547vQ5wSCxBrYebbPUw+
         VDjHsKUDZ8pCxo1fOZRsIavf90DRgWetwNHC1o9t3Kq+VhNGLzYuDF88iCpr5AOJw9xc
         190C1rRzIXf4Y2qkhJVggnqzwC18TkBNdit0LqMe/6RHusZxwmNA7pG8Bh5t70SFln5Y
         miHSF5EMxZOEpNgCRLTPlfofSRzFG71XZA0Rihyc2YWqUdKhRKeaOrXi8ek9QBcM6SsD
         fRzT3wrTuyl7SRyYwaqSOaj/EdpzPJUDXEAAfn65v4Qa9XtNQDaP2hs6o2OLEJTHh5GU
         SXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789399888; x=1790004688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=80/p2r+sK8JMp9zNzEgv5gzx5JVorvjEM6vLrigBwZw=;
        b=RC6w2kk9D3Tqoh7gJpsKCwtXfBex1DV9q9QG28bUdk7kw39TnUtgXxCMvuIq84d3PE
         gib0qMe9ETBkNIHJ4QRHp8CCL8WqTI59IIbbU5d4Gj3VNEhpvQ1tYFL1tqLHKm7X3ts8
         LKQX4OXVTCbiPIlPBnFcmnhJXd605alJS1rD+ySSaFlLl3INiCB0apAyQhEp7lSt+jMh
         NvflRSZjad/v9gEdKC51r1pjMM1jSXeE9TxMyfSNpupR081d5GfiRotZb8J0UXyGbkjI
         nvsSnmsRNKusQCo1CsDgVfMun5oZJMHiw11AJ3AR/NXcfBWeOxiD3J7cUSaOOGGjg5RO
         ih1Q==
X-Forwarded-Encrypted: i=1; AKwUvByprg1lGyHOOomHloI6fOozfksfjLZjn/k8sh9b3b1YpzFDeHlvWK04zqTi1TiWXanOVQEOSCg=@vger.kernel.org
X-Gm-Message-State: AFuF++niRfnkRUCnPJyHo3ios9V23c5opgrWODTscUT++TlrTlniOKQu
	lzjHHu6KamWP7G06qXUIeBGGLWBzsgxIGJUq8gf8DRRVwd6FRhegBEQVsHWT2dBi
X-Gm-Gg: AYBFou1gOMt2AzLvPUYrjddnyuNLXigufncN3FfAnJG5Orrip0FHMdicIj01E4Vs5x1
	vL1EU57WMQvVN9f49f4QWUwiJZNjHUZVRoOnrjWbzbM/VVx7wYu/cW4YPCidVTFYCU6FnlkjG1H
	OxadN5az+fRFSh664oIbXKUN2VBuE5EmBZE1Dw4CjcJ6sXhVZhan5VO2KU48ElQlIFJPKIxJQIM
	VfOLshZWDX/lQD3PWbjH1DB1RyEjet2AofYPJFNxQYakHyBUlYtlEDqW6JysjyfI7m0qdbhCq5E
	1V3SaWbBylqw+zSsloQwlkOabTK9q6kw7kRY3pYhcZDQ3xnUDZ9Z06KNFz7LaCiX4+pFWXX+cPl
	hGOYtEJHkQxvO0e48/NjIay/1A9lz4v7tctquAqaAlpTKhv5WkcabygtGMb3iQF4a1d+QQWQg79
	VvvQRblzv3jKvD9qD39xCTrr+/z0f0HYZy78HBtSv04+9xOCqv8RK4cO0nYaAduFclGmf0xgMC2
	KY/69gin33+OA==
X-Received: by 2002:a05:6a20:6a0d:b0:3d3:af86:fb94 with SMTP id adf61e73a8af0-3db406baa5fmr6579605637.26.1789399885429;
        Mon, 14 Sep 2026 08:31:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29ebc712sm4804163b3a.49.2026.09.14.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:31:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 14 Sep 2026 08:31:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, Sven Anders <anders@anduras.de>,
	Jean Delvare <khali@linux-fr.org>, Hans de Goede <hansg@kernel.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (w83793) release probe data through kref
Message-ID: <49f5d298-e250-4d18-b99c-aebbfe0ef458@roeck-us.net>
References: <20260914073638.1662500-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914073638.1662500-1-lgs201920130244@gmail.com>

On Mon, Sep 14, 2026 at 03:36:38PM +0800, Guangshuo Li wrote:
> w83793_probe() initializes data->kref to manage the lifetime of the
> driver data. The normal remove path drops the driver-owned reference
> with kref_put(), while watchdog users take and release additional
> references through the same kref.
> 
> However, the probe error path still frees data directly with kfree().
> This bypasses the kref-managed lifetime and discards the initial
> reference without a matching kref_put(), leaving the reference
> accounting unbalanced.
> 
> Drop the probe-owned reference with kref_put() instead and let
> w83793_release_resources() perform the final free, matching the normal
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 5852f9609d21 ("hwmon: (w83793) Add watchdog functionality")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Applied.

Thanks,
Guenter
