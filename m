Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1768412BFB;
	Thu, 13 Aug 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628034; cv=none; b=TrcZ8Lvo41RQJc0LY2Cj+ncmNbqAWB8411UtfNyxPMVT8JQhlVuBincxs3wbYT1yQqnDJYyIglZ4lQHUw9O2pDa2AzDPpopxUzCH420YMrVcziCnhz5kFkmZQNyxzaqucs3Y+RYGnccLLals1h1wN1s+X8+W/zrcnJlDEbE4f5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628034; c=relaxed/simple;
	bh=mvryYfPk6xan9iXAfWmk4+kCmkQXVt65mPUyB5k9Ebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufJwnPVUFtDmLM9rl/vyAQp04OuVF4l5ZROLdC5pxg3YchZlIQZ6NSf/kIrw0ElkqkEsMCzgZDX21JILnkzmn9yZ7DH8k1Z+yvRaiA9Vzmw7U7dEbZ1MNYgT0bi3oOqAW3lYLdM3nusxhzw0mWk2SPPbmiuiVfl0DIDYeQaAsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flKOaZpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flKOaZpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19A1F000E9;
	Thu, 13 Aug 2026 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786628032;
	bh=nSLP590tH+YrdMCZ3ykFZ5UctbQuGnKXxbm3iof4jgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=flKOaZplI1eVL+EvOd2ocj5LMKADV1j0JnLCz8Gat5bVdSlkgB2q9ssXUJZizXrXz
	 rrfDBMm/Fs22loTiue3RGUKHjotJtgtXH2gWJgCfluyEnTrLmCtkuk1wCrwNjUp+gk
	 3Oo3OSWQxgxbSVdQuCS+49XHH4bYQ957Wn8+W1KSUHf7kMTUsi4vDJE1n7CweiUiEa
	 Rp+8PtYDCKzarwMz2tka4v1f2zDh5meSrs/J5j7+vGlMWMAykiPvlAhKo29SIjNFe9
	 JwDrKtBw2e0kp5fjKvferDsaEyNU6/jjU01+EnjABnR0HyCVuT3Ywx23imI42sr+Mu
	 c+vfOxSy7wR2g==
Date: Thu, 13 Aug 2026 14:33:48 +0100
From: Simon Horman <horms@kernel.org>
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	"moderated list:AIROHA ETHERNET DRIVER" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:AIROHA ETHERNET DRIVER" <linux-mediatek@lists.infradead.org>,
	"open list:AIROHA ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: airoha: npu: load the firmware without the
 sysfs fallback
Message-ID: <20260813133348.GB265046@horms.kernel.org>
References: <20260811181717.19339-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811181717.19339-1-sochnev.v.74@gmail.com>

On Tue, Aug 11, 2026 at 07:16:59PM +0100, Vitaliy Sochnev wrote:
> airoha_npu_load_firmware() maps a missing firmware file to -EPROBE_DEFER
> so that the NPU can be brought up once the rootfs carrying /lib/firmware
> has been mounted. That mapping holds only as long as request_firmware()
> reports -ENOENT.
> 
> It does not when the sysfs fallback is in play. With
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK set, or with the fallback armed at
> runtime through /proc/sys/kernel/firmware_config/force_sysfs_fallback,
> request_firmware() hands the request to a userspace helper, waits out the
> full loading_timeout and returns -ETIMEDOUT. The -ENOENT test no longer
> matches, dev_err_probe() turns the result into a hard failure, and the
> NPU is left unbound after stalling the boot for 60 seconds:
> 
>   airoha-npu 1e900000.npu: Direct firmware load for airoha/en7581_npu_rv32.bin failed with error -2
>   airoha-npu 1e900000.npu: Falling back to sysfs fallback for: airoha/en7581_npu_rv32.bin
>   airoha-npu 1e900000.npu: error -ETIMEDOUT: failed to run npu firmware
>   airoha-npu 1e900000.npu: probe with driver airoha-npu failed with error -110
> 
> Clearing FW_LOADER_USER_HELPER in the configuration is not a dependable
> guard against this, because unrelated drivers select it. On the affected
> build the symbol was turned back on by LEDS_LP55XX_COMMON, even though
> the platform had explicitly disabled it.
> 
> Use request_firmware_direct() instead. It sets FW_OPT_NOFALLBACK_SYSFS,
> so a missing file is reported as -ENOENT whatever the firmware loader is
> configured to do, and the deferred probe path works as intended.
> 
> Two consequences are worth stating plainly.
> 
> The helper is not merely bypassed for the boot-before-rootfs case.
> fw_run_sysfs_fallback() returns early on FW_OPT_NOFALLBACK_SYSFS, so this
> driver's firmware requests can no longer be served by a usermode helper
> at all, including on a system where that is the only delivery route;
> having no second firmware source, the driver would defer forever there.
> That is a deliberate trade-off: the -ENOENT to -EPROBE_DEFER mapping was
> written to wait for a filesystem, and the sysfs helper interface has had
> no in-tree consumer since udev dropped firmware loading.
> 
> request_firmware_direct() also sets FW_OPT_NO_WARN, which drops the only
> message naming the file that failed to load. Report it from the driver
> instead, so the name lands in the deferred probe reason and shows up in
> the "deferred probe pending" line emitted at
> driver_deferred_probe_timeout. The generic report in airoha_npu_probe()
> goes away with it, since it would otherwise overwrite that reason with a
> message naming nothing; of the paths it covered, devm_ioremap_resource()
> reports itself and the malformed firmware-name property now does too.
> 
> Measured on a Nokia XG-040G-MD with FW_LOADER_USER_HELPER=y and
> FW_LOADER_USER_HELPER_FALLBACK=y forced on, two images from the same
> tree differing only by this patch:
> 
>   without:  fallback at 2.477s -> -ETIMEDOUT at 64.555s -> probe failed
>             with -110, preinit at 69.6s, NPU unbound
>   with:     no fallback, NPU fw version 1456.62 at 3.665s, preinit at
>             7.6s
> 
> Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
> ---
> v2:
>  - Keep the file name in the diagnostics. request_firmware_direct() also
>    sets FW_OPT_NO_WARN, which dropped the only message naming the file;
>    report it from airoha_npu_load_firmware() through dev_err_probe() so
>    the name lands in the deferred probe reason. Drop the generic report
>    in airoha_npu_probe(), which would overwrite that reason, and give
>    the malformed firmware-name path a message of its own.
>  - Say in the changelog that the usermode helper path is disabled for
>    this driver's requests rather than merely bypassed, and why that
>    trade-off is acceptable.
>  - Both points raised in review of v1:
>    https://lore.kernel.org/netdev/20260807024125.434055-1-sochnev.v.74@gmail.com/

Reviewed-by: Simon Horman <horms@kernel.org>

