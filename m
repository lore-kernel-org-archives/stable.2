Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0ED3921E6;
	Wed, 15 Jul 2026 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153276; cv=none; b=SDqBfPj3NDaxnHDDJZrd8ru7Kz/q2V9QGPbojRrX230yEN9H3TeUQPDOl6JH+Nhh1DdtW8VjB8ynXH4GO+DNMDxrAn/J+Aro1qadp5yK00/mI/ASRCBD8NAcQl5xgSdsNdXGFS/9K9i6kx4nrhpVnp18LciEhNZwi/Hw6gwkRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153276; c=relaxed/simple;
	bh=UM5YmNqawtdJxKYSNHIPkObRJsglOJFxe9cAFfr8yXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPi2zSazNQEaP6tFoJxwGoiWyKV4hVpK0j0mk57+Egjnr1hArAVm0+z0eHvHfRVCs5jycHml4BEVjo0XyePisF/Fwo5A248D6zMfrnhtfPkcm29TL8MwEYcIrTi3Td2Vw8fRTfvKcKMCFM6613TDbR3uDZh9/lbCjuc7QzUtszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOSHirvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOSHirvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6953E1F000E9;
	Wed, 15 Jul 2026 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153275;
	bh=XZ8j5ko3SBMcOhTx5nY5j6POZAkn3H5+I4qObTvU8XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BOSHirvft5AohynF+aPFvID2k4C+dXQHRxmBeJZFFJqF0AVF33UToIQX9gNJplXiK
	 /DXoJtAgCjZAVBQZXSa1IOqnJE0XjTGf73KFPbd/HabhaMHYvRKH3pzlUPnlnB1OOy
	 Rz1/JDuvU2+uOjRwqQE+Vy9l4xk0XZJ2a6aKVI3BDCID7/TqT0NoK7ty/R7hcjZfxQ
	 87ZBhKitW6UgGUY96Y94rwd61Dvo5sOTpPZIk4JdE+pWYwOHF9BtXAkVcli1dhbATA
	 +zKyIndP2nu0GngK0nzohhmTIfjqHtaEewm2H7jnypcaIvepDppnsViWyOxYfEGYsW
	 irRnB2bb7cvOw==
Date: Thu, 16 Jul 2026 00:07:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: jz4780: Cache clock rate at probe to prevent CCF
 prepare_lock deadlock
Message-ID: <alf7rSWaLBO8WBkR@zenone.zhora.eu>
References: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69ca6511780aa4759a428cb7fb70de43ee5211b.1783666715.git.hns@goldelico.com>

Hi Nikolaus,

On Fri, Jul 10, 2026 at 08:58:35AM +0200, H. Nikolaus Schaller wrote:
> Fix a severe AB/BA deadlock between the Common Clock Framework (CCF)
> and the I2C adapter lock, which triggers when an I2C-controlled clock
> generator (like the Si5351) is registered or modified under the CCF.
> 
> During a clock frequency change, the CCF acquires its global 'prepare_lock'
> mutex and calls i2c_transfer() to update the chip registers, stalling
> for the adapter's I2C bus lock.

I don't think caching the clock rate once at probe is safe.

If the controller clock rate changes afterwards,
jz4780_i2c_set_speed() will keep using the stale cached value and
calculate incorrect bus timings.

Andi

> Concurrently, a parallel transfer on the same bus (e.g., a GPIO expander
> handling LEDs) can hold the I2C adapter lock. Inside the transfer path,
> jz4780_i2c_set_speed() calls clk_get_rate() to dynamically calculate
> timings. This call attempts to acquire the blocked CCF 'prepare_lock',
> creating a circular dependency that freezes the system or at least
> the involved processes and workers.
> 
> Eliminate the synchronous clk_get_rate() call from the active transfer
> path by caching the peripheral clock rate once - inside the private
> jz4780_i2c structure during jz4780_i2c_probe(). Update
> jz4780_i2c_set_speed() to use this cached value, decoupling active I2C
> transactions from the CCF internal locks.
> 
> Assisted-by web based Google AI.
> 
> Fixes: ba92222ed63a12 ("i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780")
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
