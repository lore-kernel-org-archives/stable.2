Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717951;
	b=shTAY5Fer8d5aRaNR5r9Q/rl5e3pgBktcXN6npdnTkwQRprPYeB35hNPstxX5jlzi7UY
	 lSJvmIE2JpwrKx1lV5BwrgVLRKPEAPOhlsgmLPyh/ukzjIYpPabURnJKjs1bOhmZlPBxD
	 xqXwl/zNBe04RRkDW3MtmaDGrGHneFBrZ0ZdioepaVxUurktpdHVdxhaG/eD9YX5eIMGq
	 mqnaZjaEFFHIQqClpFCQgGTurlHp96oSe2s2s1Ba08HSfNHLqCzCR6OGsg5fmU1m1pTiv
	 SQVSA6Fj5q5AyCdlBRjbx/dkZJ+tKOGxrZua9nJ5Hctsx1KhJwh84d37Hhr/MtlZT8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717951;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SfHKgTJOIchjt97/Xu1pcULxY2i1puSQDcRhp56IYTg=;
	b=fwrFtMUKNCL4qVIvBRh4gj/e+Zn0/MueVfkwEZtmwrCrX4YAZaETkO3E95AdUM8cTXjA
	 toPQ6F4Hv49XqpoE5M5zSwRLdohCNtd2N5SYKP3x0WuEyllNW3dKI0aN5mWwcnWSxiTXh
	 N3v1202nbh6nr9D+ltKc1FQZa3rPOUISJ9SG0TpSSrMPYxD9e6+DYFIDEjVJvFDzY9FIh
	 oNeNCW1Gk/WlJv+Bw3a75LqlehuZsNxQy1Y4xWhvagm9Y+FIRViJRG+AS9FGyIx1he3kX
	 9bSQEZvLZbpFT3i2zBfl76ASJQOjXbQb3DC2hC+k2RwIOYBKo4bf237oAfrCPIwUkXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOn3XXgq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E86070A94;
	Tue,  3 Nov 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOn3XXgq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B857D1F0093A;
	Tue,  3 Nov 2026 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717950;
	bh=SfHKgTJOIchjt97/Xu1pcULxY2i1puSQDcRhp56IYTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hOn3XXgqNhEw7G/eEEQ1u82epDBE0Bq2OxxScCHiy/xNOIzR7j7Q6aEl4QdUERqAd
	 NZgK04EENSO/I5/iFveizGAPwGdtCtC1SyMAuf8ZwUjSguCBVEorC0wdt07dOiHxgI
	 i9ADTV0Ol4GH5B9JENQ6qBtEtF3iNsniubWtaVlsdaDG2f6+744H/vL2p2XtwqqXuk
	 twesbQ7cIt9ObgJCRJLYbjzk45I44/DIfDl0ae+2x7nCdbutUI0BA1ECYarZCT7qrj
	 ahwvrw606xfMaWDPnFJwd1L7F+JPlDj4bNWdCLJh/uMFy0mIkTfs7qewzCg6M+ypCw
	 G23SLyrZxkkLA==
Date: Tue, 3 Nov 2026 15:59:05 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sascha Bischoff <sascha.bischoff@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH 00/10] irqchip/gic-v5: Fix misc IRS and ITS host driver
 issues
Message-ID: <aun2udtwaIo2RiRC@red-moon>
References: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>
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
In-Reply-To: <20261102-host_gicv5_fixes-v1-0-743b61626fc5@arm.com>

On Mon, Nov 02, 2026 at 01:32:53PM +0000, Sascha Bischoff wrote:
> This series fixes issues in the GICv5 host IRS and ITS drivers.
> 
> The ITS invalidation serialisation fix addresses Sashiko's report of a
> race between event and device invalidation commands [1]. The other
> patches correct IRS allocation and routing behaviour, serialise IRS
> synchronisation, and fix ITS L1/L2 table selection, cache maintenance,
> ACPI coherency handling, and resource cleanup.
> 
> The IRS changes:
> * Reject allocation of an SPI without an IRS, preventing a null-pointer
>   dereference, and warn about low-quality firmware.
> * Only program IRS_PE_CR0.DPS when 1-of-N routing is supported as this field
>   is RES0, otherwise.
> * Serialise IRS synchronisation requests, as the IRS ignores a request while
>   an earlier one is still active.
> 
> The ITS changes:
> * Serialise event and device cache invalidations because both use the ITS's
>   shared DIDR register, so concurrent writes are a bad idea!
> * Select linear device and interrupt translation tables when one L2
>   table covers the full ID space. Currently, this selects the wrong
>   path, then the L1 table code rejects the attempt to create the
>   table.
> * Check the ACPI noncoherent flag with ACPI, rather than checking the
>   DT's property.
> * Correct cache-maintenance sizing after limiting the DeviceID width.
> * Invalidate the device cache before freeing an ITT.
> * Use firmware-node names in initialisation warnings.
> * Release the reserved MMIO region if DT-based ITS initialisation fails.
> 
> I've CC'd stable for the IRS/ITS locking fixes, the ITS table alloc
> issue, and the ACPI coherency fix, as these are the most important
> changes to backport.
> 
> The series is based on v7.4-rc1. Thanks for taking a look!

Thank you for fixing these bugs Sascha.

Lorenzo

> 
> Sascha
> 
> [1] https://sashiko.dev/#/patchset/20261016155741.979985-1-sascha.bischoff@arm.com?part=11
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
> Sascha Bischoff (10):
>       irqchip/gic-v5: Reject SPIs not backed by an IRS
>       irqchip/gic-v5: Only set IRS DPS when 1ofN routing is supported
>       irqchip/gic-v5: Serialise IRS synchronisation requests
>       irqchip/gic-v5: Serialise ITS invalidation commands
>       irqchip/gic-v5: Use linear DT and ITT when L2 covers all IDs
>       irqchip/gic-v5: Honour ACPI ITS noncoherent flag
>       irqchip/gic-v5: Use firmware node name in ITS warning
>       irqchip/gic-v5: Invalidate ITS device cache before freeing ITT
>       irqchip/gic-v5: Clean the allocated linear device table size
>       irqchip/gic-v5: Release ITS MMIO region on DT probe failure
> 
>  drivers/irqchip/irq-gic-v5-irs.c   | 22 +++++++++++++++-------
>  drivers/irqchip/irq-gic-v5-its.c   | 29 ++++++++++++++++++++++++-----
>  drivers/irqchip/irq-gic-v5.c       |  9 +++++++++
>  include/linux/irqchip/arm-gic-v5.h |  1 +
>  4 files changed, 49 insertions(+), 12 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-host_gicv5_fixes-1eeea29d2ea4
> 
> Best regards,
> --  
> Sascha Bischoff <sascha.bischoff@arm.com>
> 
