Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357293;
	b=Ia/UHGjVqrr19Cm3gcG1k768hrGKZQGak/aXx5MMtxxFaAYqFi47BYR1cUfzL0+ny2r7
	 3t3LFr5q+7Vm+92OUpZy0r8V1mSHZgkHkq+znZKPkH63fbkrlyUs9+K0OODOdvdyxnrf9
	 GbVETjKaMnYsCc6RmNujTKX4Nbrm4+7ZPNS00cahGY3XRc/c8Yd85NYhPT0JcNHAOBuxA
	 xiYq6xXs+ya6Wmz2UKS22An/TEur2LHjq9OtH9ryg53eBFuia6MQHwPZMYCoFpinO1lfg
	 93cna8A+Gni6QEzasKDuBwMe8YGBTVIII0VFBkY7/01X7uRIwWfRYEQgw/T5rIdPkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357293;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Y/EYB0/9MsM5P2ptIQrhRFyMMNFz7gDKfR7zADjLWVc=;
	b=PTk21ETlW7UlE1OoT/TDnrysU3nBc0ZiOn47pPw/+uyQ7745oyR8+yTQp4kivSmOesCo
	 FqDBoXvGPlBByB1Bihd4EF04wbqeatMG8bV/ECitE7NuIAHLOgXR8ToRVGfSIdDh1bnip
	 WkZo9h0672SM855zMfAeADlU+hcVdc5IjriN+1WbAFHScr6irOJTlOHSKzMkCKCQSumci
	 8yBwsleJNN4OWadGlo4p9pykczlHRlOL6dVXEAU0VMY9ecx6Bj8Zxv26TmU6wJ+4HfCg7
	 hINYC99/YXn+rEo4PhGWJ4V2UGArYRgGz9Oyac3Vh7rwL5ecxz5erGQmtv0iA/5kItQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+ErgFMb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7A606A31E;
	Fri, 30 Oct 2026 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+ErgFMb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA91F000C1;
	Fri, 30 Oct 2026 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357292;
	bh=Y/EYB0/9MsM5P2ptIQrhRFyMMNFz7gDKfR7zADjLWVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n+ErgFMbwCPIcU9V0z9/u98FGG20OmGSFWjLu7X2sPtSYYyhk3dpHEWEJ5hT4a+JO
	 1a6+nIShM1Llo5RSqey0aIE8YsfOzC/xC9EK2cVElujM4rmoDtmzQgziyxbwhcCc1Y
	 68lfBTE8fh4KjEeH2yzvNNuWTwC+/ZmAzOIr32XAQ5NPFDIv4GwZyrSM9ZtEvJq2e5
	 u/ocT1pa6p/z92jJRcSOs/uzs7J15RikjKWtmy+IU11cn6DfdLjM7fP+seGLP+gE+n
	 f3n7ydd0+uPcBX8m0isufuo1SC2qEsb+AjCMDtRTseWMwEkrlrv7tlkTw1nIVZyGVe
	 ox90c8Te5gsxA==
Date: Fri, 30 Oct 2026 10:48:06 +0000
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>, syed khasim <x0khasim@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on
 teardown and probe failure
Message-ID: <20261030104806.GC3774906@google.com>
References: <20261027093306.2812695-1-lee@kernel.org>
 <20261027093306.2812695-14-lee@kernel.org>
 <20261028165003.60d0c033@kemnade.info>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028165003.60d0c033@kemnade.info>

On Wed, 28 Oct 2026, Andreas Kemnade wrote:

> On Tue, 27 Oct 2026 09:30:42 +0000
> Lee Jones <lee@kernel.org> wrote:
> 
> > twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
> > and checks for a non-NULL twl_priv at entry to reject multiple device
> > instances.  However, twl_remove() and the early error paths in
> > twl_probe() never reset twl_priv to NULL, a failure when adding MFD
> > child devices bypasses twl_remove() by jumping to free instead of fail,
> > and twl_remove() tears down the IRQ domain and dummy I2C clients before
> > child devices are unregistered.  After devres frees the underlying
> > memory on probe failure or unbind, twl_priv remains a dangling pointer,
> > causing subsequent exported API calls to dereference freed memory and
> > blocking future probe attempts with -EBUSY.
> > 
> > Unregister DT-populated and MFD child devices at the start of
> > twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
> > reset twl_priv to NULL in twl_remove() and on probe error exit.
> > 
> > Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
> > Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> Hmm, couldn't we use devm_add_action_or_reset() for resetting the
> twl_priv pointer? Feels more clean for me.

Nice!  Thanks for the suggestion.

To keep this fix minimal for Stable backporting (and avoid resending a
27-patch series), I'll take this one as-is and send a follow-up patch
converting twl_priv to use devm_add_action_or_reset().

-- 
Lee Jones
