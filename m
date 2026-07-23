Received: from mail-ed2-f0.google.com (mail-ed2-f0.google.com [74.125.228.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E2E3E49DD
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784795839; cv=none; b=YEFzvT+A5QZRpINiUvrN6lLirAJpT5HK6qk1hTpGrAS0BaABbhlAZlXNdv+HeR/BNsZIngjl/rpTuRs8mFQ83Yeg4cSmJl2r/4YHYT5/QeLeHONQT5upGZcwCqLgoGQ7LHSuW15MxkQMNi7oJdXq8RmYpsQsgkeMH+s8GQjN3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784795839; c=relaxed/simple;
	bh=rYCq3Rux7nq1YFxRc0XFo1MDW/UFjDG68g2Y9h0HDcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmwAW5ANwYs6kLOkWUDEOizltAuMl6A6pkWBVTV+K5PEpcwcOTIx3Ls2dfGjL8uGhgArOKfN8GUoCzShZANfT98bkZVGWQe9Z/AGQv8Gft6CWH4b5KICjDGiOQvFL/3gnYAZ8qwzcUtIDTKgZ0QAV1FdCTAbxu12UN6v8Bxel9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KkJqsLBZ; arc=none smtp.client-ip=74.125.228.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KkJqsLBZ"
Received: by mail-ed2-f0.google.com with SMTP id 4fb4d7f45d1cf-69a760141b8so249113a12.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784795836; x=1785400636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MoMNc/FFoprTITsRfG0L5TdIxxhYdIk+KGTLx1gAHdQ=;
        b=KkJqsLBZrL76mD6AIykR9RQWI8ZgoZG+lvy8Yg+BBS0wN1oTO5uy1PqbKOe2WDf6PU
         9sWooM7LQfuDNpzjmlVCi4LQ3chAQ5bI20ZiV7w09ASxSf8w5xfhTJcEQLMbkkRZisCn
         Q1ghLLxAdTVjAVqCy+uC89nwLuxGONMkVWZnvaj4CrRPQt9kVjb9FbEBTEDPIKq0mdun
         NVSELr4aZsPonJc9+dtU4mwAg/1hSKfSCdn81MvoyPhXW5gh5BC2UdYHsCinThX1MWi1
         OddP2awpxJviOjTALXXMRhU1NNgq0e/LbOvJcF7p90qtZHKl8k5v2nm0gvDCOGtJ99FU
         Gkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795836; x=1785400636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoMNc/FFoprTITsRfG0L5TdIxxhYdIk+KGTLx1gAHdQ=;
        b=GdhSgfisNghmYpkKssYkdt1xUbfagxgdELpxmeJwpDo/M4fZdFaX5u7IS1RqQeZVp3
         97U3bw9OLy8H/1nNlrDfUK02yCho+h+uhA+aoYc5oboX9iW1NyZkbEetWf4fE+tSoJRt
         BkGxy7BkcvHODCIy8L4e61FR5RSFXsTja+6qqpEUykjBsV6P+CiNC+cUooL5OprIFV7R
         UmrpQ0T6cIf2CYxu/mHgbCAACVuy7RLJyxkT8LeQQQHGeO5YQsTpLb4gsEVNTtqyqAj/
         AuWTPlhpSjPtj5BvGpwmoEbFW5LzX4yo8HRuGRNtEJTbYNjZmctzlo5esMfo3Rsnc0UY
         1RJw==
X-Gm-Message-State: AOJu0Yyt6y5wEOaaREKlWoeuCx++ETQBRPI3qkE8vd6Wc0WMNwSpcvo0
	eIbEh3akkhuK2ysNcYSGjrMLikRh/hXO6LrFiERTwZC3x3+6Cn2arYXAUPqI6JwzYAs=
X-Gm-Gg: AR+sD13VqMglAi1AZbIAdintBwuSbbizXtj4CpbDKIgWq5S+9AtLNJWom4W8feMpytT
	3HUC/7wHVSehQUe+JvCcZBjXvEBUQzaLBUQwmtrUYyC9cpNcFMsLLuMXX/EhnwXlrNCzZFer06v
	4TTY+t6cYsSmYfSdfsqS69WscRf+Tow2+q02LSRMnNIM5SH2crNWdLtsc2aLGwuH14KfwN5/QGa
	zjHNiw2DOR7s76WMFwISCExu0SUefHE45FshGhxZ8hQp96SrTpPixVKb8QFeWH1ODXzaPTN0cv7
	dm7LKQ+xE3ES45xMjHyFBxfxzhU7SeMXW3dKAmx/liQeScdFfHsbA2pa5IE+SPbz5Cop8boMDf0
	fY/YIWTYAK7XW3fkIS/vOH+R4JzpBgvIaMc2FpC8hfFEzZ3f3QTFsoAaQzHHzMDdkH5b5P+yQZ2
	s2NHzs8/utoaBM855h9duNz2LbsxZGxA==
X-Received: by 2002:a17:907:9629:b0:c15:de33:a018 with SMTP id a640c23a62f3a-c1c50c335cemr97901766b.45.1784795836249;
        Thu, 23 Jul 2026 01:37:16 -0700 (PDT)
Received: from u94a (27-53-97-40.adsl.fetnet.net. [27.53.97.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f38757esm28977445ad.75.2026.07.23.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 01:37:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:37:07 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 0000/1226] 6.6.145-rc2 review
Message-ID: <amHSEwZcutUhO5tL@u94a>
References: <20260722143258.264584003@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722143258.264584003@linuxfoundation.org>

On Wed, Jul 22, 2026 at 04:33:42PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.145 release.
> There are 1226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jul 2026 14:31:21 +0000.
> Anything received after that time might be too late.

BPF selftests compilation is currently broken. But with [1] applied it
will build, with test_progs, test_progs-no_alu32, test_progs-cpuv4,
test_maps, test_verifier in BPF selftests all passes[2] on x86_64 and
aarch64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://lore.kernel.org/stable/20260723071334.39630-1-shung-hsi.yu@suse.com/
2: https://github.com/kernel-patches/linux-stable/actions/runs/29987147891

[...]
