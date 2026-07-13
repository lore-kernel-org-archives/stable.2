Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24227F4F5;
	Mon, 13 Jul 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966498; cv=none; b=aiZ0GZQkP7mh1oDQmeTpkz+vJOzFggHt31dgr+2GMrzUnJJ239CbBQCUsrqvGsHkdexDDnVJwQ77AOQVonSlFWnPFuBVk2pSv+TyuDTSYC6RtKpY6WqGmdcpJJRAcq1kHHnUZH90Eb1FkrS8mDtkLCbjgDngoWWXOoWaQ6hI19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966498; c=relaxed/simple;
	bh=p536q1fZMhD4VsIbp+AlHkFIuiGVNiIk3+r824wk/Ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=H5CoEOy1L49gK5DBAIBernT5qaDzsxGfJAsyGRcWNJml4TTghUmfRqmYCaDrmhe7QPOMSgR9gpsxJ/N5rDLK2Cp8fy2Z9sZUN9Fe2oXGo+nuGf3GPipMETHow2Mxlupbumv6ocpU80aDTE7p76JiFSN2iN2lDVY1KjF1vBCRAdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byb5BROk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byb5BROk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F1C1F000E9;
	Mon, 13 Jul 2026 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966497;
	bh=JyASWAKAD6ak8FJcxWdDEg+sFNwuVoRQymBg/98oo+M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=byb5BROkJpBcOzvzYTSnccebRDOp9+OET/OpjUZrjGZHZfc9R2wq7LMXGJdJ4XIjM
	 5PRtd3cH6rYC9RmoqhiVrXGZjALT+HBoS6chP/efteMPq2MqXr4uLIWxbAy/tVcQSd
	 cOKktWOZjtp4JEMNgjY5Mm9iYDH7CwVeoQ+2m16MSP24r6FkMg6SdYj55by4peeO0f
	 fCwkbY6m2uGhHW6LX/kurmyI/FwWVvfY1/pUV1P9PeuiGIuOQnCPDWTXXoGnT38Ku4
	 4cI6pzCGcqW+gHcc5Dy+LN5iB02lqDx5uXBiWRAeKCrLeXW8xlfTzJNCN12S+N/s01
	 zVZUFJfR1v9/Q==
Date: Mon, 13 Jul 2026 12:14:53 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>, 
    Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
    kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: vdso: Do not use LTO for the vDSO
In-Reply-To: <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
Message-ID: <541aed79-b153-726c-87f9-cfd9f9304c46@kernel.org>
References: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de> <20260701-riscv-vdso-lto-v1-1-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1762691194-1783966497=:1536112"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1762691194-1783966497=:1536112
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jul 2026, Thomas Weißschuh wrote:

> With LTO enabled the compiler assumes that the vDSO functions are not
> used and optimizes them away completely. Currently this happens to
> __vdso_clock_getres(), __vdso_clock_gettime(), __vdso_getrandom(),
> __vdso_gettimeofday() and __vdso_riscv_hwprobe().
> 
> Disable LTO for the vDSO, as these functions are hand-optimized anyways.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606301855.WvkSC4kD-lkp@intel.com/
> Fixes: 021d23428bdb ("RISC-V: build: Allow LTO to be selected")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Thanks, queued for v7.2-rc.


- Paul
--8323329-1762691194-1783966497=:1536112--
