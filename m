Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601250;
	b=d+dGgALh2CfoI5/LtFq2AE3dRlPmQf+XCPZKFZUVBdZ/am5lqqWlAwQ01Ezhh7SCO/As
	 8lAzkVNBU1xP6C4OWalv32B0vHCnQ0b4IPDwvntab6kNmWg6MTVh8JZzzDblaWmvxdtZ9
	 SccbPf/Pq9hmq9ZHcXWpLcChm50i2Ko8WFxsBfyyfnYNVW7RLwr3mxCUoojAE03kkK4q3
	 c8xT9T2lEXk5gMFBEhm4ZCG0b7BJtnzzoVYodVBp2vbV/5ZNZumFEQjdumTl5aLsL1xcx
	 NcVgeuNUh7U6lInM1MeadecP3A6arJ0KpdiHuEE6V0iH9LHGRQ4jUsPbYw6ma9LFu+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601250;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lDAm+zBD66b88hz5K7F1FDsYw+RIkjC9cHi9f3iS4y8=;
	b=T39ovgJbcVPWRjJhL6DCyp8SqJmoK3kVeXM13FK2XaI7YHbsubzksJXySCTSojKjKBVj
	 wGtzFbN5f2nParJHIIPB4V0GXyCRnQoLK1EZVbEto6dXIWzZP4jPukxZF8vncSV4XYBHK
	 nO894kOSd+QWNfiwNqOigt6YHn5Y1WkXWHAdO/DKqNz48fsryLFN43y9SnAgK5QAS+Dee
	 Y5PkTlrv+aIf0hoVpRFOJWaVfmScXdbi9/l/oo2xpwciL2BHDYsd+j8JTF4zDrSvJmMAV
	 zX+X6Td3vyntth+d/T0ru/6t09A5MgWsEB7Bb4yaYVHKVhZ5gXmCnqApJM0nNBV8dDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7ZFZGyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0342606A323;
	Fri, 13 Nov 2026 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7ZFZGyJ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EF9351F000C4;
	Fri, 13 Nov 2026 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601249;
	bh=lDAm+zBD66b88hz5K7F1FDsYw+RIkjC9cHi9f3iS4y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D7ZFZGyJQXMWawyYsmDGFMzswQ9j6Aevq/SNOuHwRx809Bf/ZTxaitWJZrNI2+Rh6
	 hD1kHONqfBmuMRZnMtq2bozUvHa1QPt94QYnhlc2mnn5b6sWUNQYR6wZJzpFDtuKNA
	 mUDaEFEl+HNy725s//wTx85CURGa0YUOEsy4/S6z+K5Wh8/RwNxbwiu006YV2tAuSF
	 Tm820A1tX4ElFYz7M5MYxblO8aJ3v/r/xu7ZwIHxS0iXPCfPBx944QNBX2G+DeRUX0
	 nf8SVYjNbWC2zJ1X5aKvm4EBnBLGf3hMFYSityFxtvWOT6GqLBjiC+V4CjPNs9VljV
	 jtq1ViTjK/ZeQ==
Date: Fri, 13 Nov 2026 22:20:45 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>, apais@microsoft.com,
	rlmenge@gmail.com, hargar@linux.microsoft.com,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tpm_crb_ffa: Only register driver when ACPI
 TPM2 uses FF-A
Message-ID: <avdxHSKkqubIrAZ5@kernel.org>
References: <20261112233807.70664-1-sidchintamaneni@gmail.com>
 <avdXkLKJwuNv0vZ4@kernel.org>
 <CAE5sdEgEFjGz6W0e5g4uxRVC2Otyvr4Pak-aAZogObWaFtNsTA@mail.gmail.com>
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
In-Reply-To: <CAE5sdEgEFjGz6W0e5g4uxRVC2Otyvr4Pak-aAZogObWaFtNsTA@mail.gmail.com>

On Fri, Nov 13, 2026 at 11:31:31AM -0800, Siddharth Chintamaneni wrote:
> On Fri, 13 Nov 2026 at 10:31, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Nov 12, 2026 at 11:38:07PM +0000, Siddharth Chintamaneni wrote:
> > > Prior to commit 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed
> > > when tpm_crb_ffa is built-in"), built-in tpm_crb_ffa only registered
> > > tpm_crb_ffa_driver from tpm_crb_ffa_init() after crb_acpi_probe()
> > > confirmed start_method == ACPI_TPM2_CRB_WITH_ARM_FFA. After that
> > > commit, tpm_crb_ffa unconditionally registers on the FF-A bus at
> > > device_initcall time (and when loaded as a module) without checking
> > > the platform's ACPI TPM2 table.
> > >
> > > A platform's firmware may expose a TPM CRB over FF-A Secure Partition
> > > for UEFI boot services while advertising a non-FF-A start method to
> > > the OS in the ACPI TPM2 table. When the ACPI TPM2 table designates a
> > > non-FF-A start method, Linux has no consumer for tpm_crb_ffa and
> > > should not probe the FF-A TPM service.
> > >
> > > On Microsoft Cobalt 200 systems, the ACPI TPM2 table does not use
> > > ACPI_TPM2_CRB_WITH_ARM_FFA, yet ffa_init() discovers the FF-A TPM
> > > partition and tpm_crb_ffa_probe() unconditionally sends
> > > CRB_FFA_GET_INTERFACE_VERSION via FFA_MSG_SEND_DIRECT_REQ2/REQ SMC.
> > > That request wedges the calling CPU in Secure World (with Non-Secure
> > > interrupts and GICv3 pseudo-NMIs masked), hanging boot with an RCU CPU
> > > stall:
> > >
> > >   [    5.507519] ARM FF-A: Driver version 1.2
> > >   [    5.507519] ARM FF-A: Firmware version 1.2 found
> > >   [    5.507551] ARM FF-A: Notification setup failed -61, not enabled
> > >   [    7.150580] Freeing initrd memory: 293640K
> > >   [   65.515248] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > >   [   65.521346] rcu:     10-...0: (3 GPs behind) idle=dd9c/1/0x4000000000000000 softirq=37/37 fqs=5262
> > >   [   65.530031] rcu:              hardirqs   softirqs   csw/system
> > >   [   65.535589] rcu:      number:        0          0            0
> > >   [   65.541146] rcu:     cputime:        0          0            0   ==> 30028(ms)
> > >   [   65.548102] rcu:     (detected by 66, t=15010 jiffies, g=-951, q=1384 ncpus=132)
> > >   [   65.555228] Sending NMI from CPU 66 to CPUs 10:
> > >   [   75.560686] After 10 seconds, these CPUS still haven't responded to the NMI: 10
> > >
> > > Check the ACPI TPM2 table in tpm_crb_ffa_driver_init() and return
> > > -ENODEV before calling ffa_register() unless the table is present and
> > > specifies ACPI_TPM2_CRB_WITH_ARM_FFA, matching the check_acpi_tpm2()
> > > pattern in tpm_tis.c. This ensures Linux only issues FF-A TPM requests
> > >
> > > when ACPI advertises the FF-A start method (for both built-in and
> > > modular builds), while preserving normal FF-A bus probing on platforms
> > > that use CRB over FF-A.
> > >
> > > Fixes: 677042afb97a ("tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in")
> > > Fixes: eb93f0734ef1 ("tpm_crb: ffa_tpm: Implement driver compliant to CRB over FF-A")
> >
> > Pick the older.
> >
> > I attached a prepending patch that caches the start method, which can be
> > later used in tpm_tis and tpm_crb.
> >
> > So that totals four patches:
> >
> > 1. My patch.
> > 2. Your fix using the cached value.
> > 3. tpm_tis update to use the cached value.
> > 4. tpm_crb update to use the cached value.
> >
> 
> Sounds good! I can put together that 4 patch v2 series.
> 
> Two quick notes before I spin v2
> 
> - Module loading with CONFIG_TCG_CRB=m and CONFIG_TCG_ARM_CRB_FFA=m:
>   As Sashiko flagged on v1 [1], because tpm_crb.ko directly references
>   tpm_crb_ffa_init() and tpm_crb_ffa_start(), returning -ENODEV from
>   tpm_crb_ffa's module_init would prevent modprobe from loading
>   tpm_crb.ko on non-FF-A systems. In v2, I will move the start_method
>   check into tpm_crb_ffa_probe() (matching check_acpi_tpm2() in tpm_tis)
>   so both modules load cleanly while still skipping the FF-A probe on
>   non-FF-A platforms
> 
> - regarding the location of caching approach -
>   tpm_crb_ffa never allocates a struct tpm_chip, and both tpm_tis
>   (check_acpi_tpm2()) and tpm_crb (crb_acpi_probe()) check start_method
>   before calling tpmm_chip_alloc().  Would it work for you if patch 1
>   caches start_method once in tpm_init() (subsys_initcall in
>   tpm-interface.c) and exports a small helper (e.g.
>   tpm_acpi_start_method()) so tpm_crb_ffa_probe(), tpm_tis, and tpm_crb
>   can all query it before chip allocation? (Also noticed a small '||' ->
>   '&&' typo on the header.length check in the attached patch.)

Move it to tpm_init() and store the result to a global variable, let's
say tpm2_acpi_start_method. There's only one of these so it's all fine.

You can then mark the resulting commit as:

Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Co-developed-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I just put those tag because it is easy to mix up with Co-by tag,
when using it.

Br, Jarkko
