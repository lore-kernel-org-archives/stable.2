Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1F27AC57
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787803617; cv=none; b=dCEHlsteOA0zrHC/N6Jwd2i3EU+fHv/W0ac4DkTbcy0m6m810D5/TONsCtk7UVaov9rYZaewZMAgTc6e3BOFr7N7Ec3mxc4HflrhfDh0gHMQWqHzJFCLucBiTdK3SyfLkyuiZo8uw7M1eYKreofzeeAahp0Yxtnf15rym4xPH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787803617; c=relaxed/simple;
	bh=kEI9OvVbWJ7wq71P6L9MVOAfwamjGbck54SdcC+yBG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9d4wVtDJkdkjTfYHHGel0g8mnN35Us1e2jM/8drU3kYTQu9VdCPZOScyRPzqVOqhH7RgASbjms6+dulHGmM3vFXRpuXWrkfF/Db5hNaqxNK2bN87FWNdvnSg6kxSOUQEduYqd2TeUrKVRLyz+GHAEhK5QlRgF2sQHcHEKbCCH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeoU4gv1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeoU4gv1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso14328555e9.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 21:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787803614; x=1788408414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=leRlXbqgKULRfa+v/5YQeWOCF+c2KyYlCCc0f3p+zUs=;
        b=GeoU4gv18qe+m5EXpyWtKQn+QXoF6dFXTcxTV3Gs67lZ1/jOX2N1Bvge6NQBbi8wIM
         gRUDBfgwvUFNoDCd0LvaxIr8pg3TRRPGDbyCcQ56EvqxtkKdPAi+k5RSCbLljGXeTwFz
         M4U7VXSJPbVJQfAzmanBK/aHR2+H8ROOK7TbKbDYYgDi/TWNFWT71i/2BRHHmxUWaZMt
         Laq7nGPqyZSgUrzucE5K+nm/yFEue3pGOkNr8tilykxfmFeTOfAYClG2p/1i2QEGf1xM
         RYOsL9UYOBdrhI6/7VzTE+FRW79Te3v64c2ERxNMMoL2u4oc2WtNox2g9A6OkCSnlp1h
         ZuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787803614; x=1788408414;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=leRlXbqgKULRfa+v/5YQeWOCF+c2KyYlCCc0f3p+zUs=;
        b=lp2TT+0d5hZhnadTYmvxnX4rnMcUOaZo/brXCpGAM/SGwdV0R/dCoxZwfEUtKQifIQ
         TtWutIf2C2PhYf92SRapjQWCu9B1qn3LGE4vj2y90UOhhVBRw8YRymmpnja8l61By1Rd
         ezpgKcrdj1EG8Dtd+FL9uwWarTDgoppd2AfvZGzIzVrXiCsFZ8Aw1q7adnjy7S/uHpY5
         pLDtOW141EjYYlQHOMm236IvBnJA3+SO7Pjo5cu94CPJpyGExsNWmF93Ge1ahvXr4Cx3
         GYbyWdf+FYJbPVe3bKfyEaAn0tfp3n2pda31AiA0DeHqp9YtJRJuXBrl3YFwOV6hvlm4
         hIbA==
X-Forwarded-Encrypted: i=1; AHgh+RqLWiW1WBCfck1Pg2i5EjrtS7PhQy3WaV0vH7MaROYZ8mz284mzXHxCe4TEN+mvXFh70Zxw6vE=@vger.kernel.org
X-Gm-Message-State: AFuF++lC3aX1h4KoJaQtgFnPL8vZ3+wBsu/nPT1faIcVUbIwR1adgPU9
	V5PmBmgIF9WoULXcUGvgoI5ULKXCPLjf3U1wbkF1hnZdwoHUeggRH3Xj
X-Gm-Gg: AR+sD13T6AcOPnr8oSWVuSzPLlgHYCMSnk+tSFxieRQkuLCPyclr8BXmD11UwVhl52e
	VacICqALBr8d0kbtS0G9e8UOsplv02OPsURRQtkZiByVpRqRTnJQgYUOzK2u7sckikAFCwM15GA
	ptjjCvmaGNc7slQjv3P4eZEoNTWvjcGCVOmBnd7qDX6daY7X8b/B0l30wjtS12dW2bLC+794Q16
	eUm9axopNoZCQL0tzMynN0emAqZUiTYDn+8lUk0R2Lp97Zpe6akWdL2BO4dVv8NnOVNcLPop5k1
	yfBI2/vWPEOUzzL2bWNfPIlMMAsa03A2L7k+ApNbbzxYBcs34JQCUNBd85NTNPB8sCailLUYUFE
	xSEj2dGpEHAdCZsnsAM8iHb2JuBGQMIDxL/JSVaLmnL75IeVAHIkD6HA7ViZqzRIUgGnTRJFgAy
	lOQxfzs7ayJVwmzII+dbwwSr0w1lXzfFEd48cZrRC0HIw4kbUWsmvMQyj3jUg5l3FS7zsRX/e9q
	gYVeIV0K50H2uHxOoZXPW6R7W0tWeqPS9tIlrtcpK96sGH0E9hyygREzo52C7X/lZsZWR9/cJUl
	PZYH8d9sz6wQvhqdqsptVvg=
X-Received: by 2002:a05:600c:c118:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b0c8e0911mr59314915e9.0.1787803614027;
        Wed, 26 Aug 2026 21:06:54 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-154-097.95.114.pool.telefonica.de. [95.114.154.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499fa55f458sm31127865e9.0.2026.08.26.21.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 21:06:53 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:06:22 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>, 
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] microblaze: Fix MB_MANAGER build with older binutils
Message-ID: <ao-3jrT0aP0_fSBA@gmail.com>
References: <20260813024026.5402-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813024026.5402-1-kmehltretter@gmail.com>

On Thu, Aug 13, 2026 at 04:40:26AM +0100, Karl Mehltretter wrote:
> The suspend mnemonic is an alias for mbar 24, and both encode as
> 0xbb020004. Use the underlying instruction, which GNU as 2.30 already
> supports.
> 
> Fixes: 88707ebe77e2 ("microblaze: Add custom break vector handler for mb manager")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310310151.UhB396Qs-lkp@intel.com/
> Suggested-by: Michal Simek <monstr@monstr.eu>
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Just a friendly ping in case this got missed.

Thanks,
Karl
