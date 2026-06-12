Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAE33123D;
	Fri, 12 Jun 2026 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300582; cv=none; b=C0hemYoM933FH7A+4cJVTxpMEEKlCgiRdr9+X4BaWYvLIw7RAH5CeRoz9F7BugXA6fEev1TQeJDRvbrjzlnOllg3sTWp3kHletLwhz3ya2QmXqREMWUL5fOtmFLzVVrEU80KNQPZTo62n6/Y7gyrJeJQP7p5zOY6HvwGm3Zb2u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300582; c=relaxed/simple;
	bh=DSXXG2/PsFZnBgEasfF/XlMUtPkTSmlZlT6FkSwZWb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOgzxeGI6HpOgF5WHngZeelD2jbGo6T0zfUAyEha+sqy2TODDlWBZWMpBYVFT5ihgsTQGK5DE88aFPV5oRh0nav/pVTJWE2E9JEj5/nAYIiC5hTv/ZvbMasfQ32RyQvsvcx7s+7y/ymBflEcSehDoGsypJa0ooTrk4XD7NCQon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6ZhBUbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6ZhBUbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B96D1F000E9;
	Fri, 12 Jun 2026 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781300581;
	bh=IZSmDwcQ8giBTL1YK6g+fOLdpwRyGLX+jBn9iBifw+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d6ZhBUbGHhoRTSm2pOWvXgbd3j80fOvxyXkEd8wv1fyjyp50mngJfhmmfz4pAI8MZ
	 ggwrEqqiZcxzty6FQNM/95cyT6WMwXJR7VOrilfJQQY+dGXfYwuYVQdTRz/SgDva5S
	 eLpPD4JzrWPypcZ0n5M8lJB77eOTT9gz4DILf9FlLfqkhl8D9Ggr4cwNrh9EYT2mBn
	 953SNFE+MMVPhUw9YScVJ1w3I+rpF65kocMAivaJ63sYYvLf4NmUVQzJxOhzCLAGR8
	 qiBVvPy97wsdE6Y+KQfaE5oLaYTeY0F1K9qlgkAx/YYbOIOR7hWMIxFln8+4iKybJF
	 vR2zygiLsi60w==
Date: Fri, 12 Jun 2026 23:42:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: anna-maria@linutronix.de, tglx@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] posix-cpu-timers: Fix pid refcount leak in
 do_cpu_nanosleep() error path
Message-ID: <aix9YrXp8K0-fpEB@pavilion.home>
References: <20260611161738.97043-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611161738.97043-1-vulab@iscas.ac.cn>

Le Fri, Jun 12, 2026 at 12:17:38AM +0800, WenTao Liang a écrit :
> In do_cpu_nanosleep(), posix_cpu_timer_create() takes a pid reference
> via get_pid() and stores it in timer.it.cpu.pid. If the subsequent
> posix_cpu_timer_set() call fails, the function returns immediately
> without calling posix_cpu_timer_del() to release the pid reference,
> causing a leak.
> 
> Fix it by calling posix_cpu_timer_del() before the unlock-and-return
> on the error path, consistent with the other exit paths in the same
> function.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

-- 
Frederic Weisbecker
SUSE Labs
