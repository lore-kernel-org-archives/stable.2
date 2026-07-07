Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905843B6C7;
	Tue,  7 Jul 2026 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446320; cv=none; b=uaLjyuxok/E2DcXIpezSxeu6ieiXJbHZUCguJPqCFLXhA9aOFAjmBPNUfRkcWpGpE1L8psSMKuKXp46WnizHPZ6n5G0OfCpshVVLKD7FX8eWPvyukCsWFzXXhq6P/Zdg+BP5M5ATNVI3ALmCKUvGncluRqJwK9lxu4SQhS7SK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446320; c=relaxed/simple;
	bh=5yUOIZ0ethZqCmfc85wQas6meqcD1uvnoYMkHTIN744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byg0GMabzqBl2r/afnWhRGl0rZ2IpyjA8Ny8x1nnagkzrQhfKAgcKlmtp7LKyL4q0se03JJtGW555qYn89q7fAZJpKh2SempW6kTC1uT0g8zGTwViWAwteoojOQs9AwTdNejeofq/btllJq7neQOGexhOV8fjP2jPytlfxO6obQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOMe5IQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOMe5IQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E241F000E9;
	Tue,  7 Jul 2026 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783446319;
	bh=ArZcjnqxXY4lFXsA7ciAkqOLPQkDIBG41FVldd2FM9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOMe5IQzEGa5vA5o14v7lBTr4l+/MkALdb30ZUydO6V/RZb/g2c4WEIMq4hO4ptZz
	 BaqlwELwS5BFZJnDFxW3tU7BXZ9jgiPb/PiAbl1RHIL+ntYfiQV7on0xvieDJ8VOBv
	 qTKY9I/WtmujKcaaI3BuHSBDGi7JjQiDfYq/lBMvT121Bmjxe2utEwFszGoqJqTlin
	 jd7RfgVc0L+Koz+z9Ri6E3D76BIM6IeEJQ8g8YPIebJx49XFLqpe3krgSXkOd5cv/A
	 CWPoQqaGZVd9bOiDYTLUUdeBABY6rYF1DgD6lTSC1NBQNlck/kw8X3V0IdzTN9YFAE
	 neO4Bl08JEUow==
Date: Tue, 7 Jul 2026 10:45:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wende Tan <twd2.me@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv: vdso: Do not use LTO for the vDSO
Message-ID: <20260707174513.GA1256227@ax162>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>

On Wed, Jul 01, 2026 at 11:21:21AM +0200, Thomas Weiﬂschuh wrote:
> With LTO enabled the compiler assumes that the vDSO functions are not
> used and optimizes them away completely.
> 
> Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Thomas Weiﬂschuh (2):
>       riscv: vdso: Do not use LTO for the vDSO
>       riscv: vdso: Simplify cflags remove logic

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan
