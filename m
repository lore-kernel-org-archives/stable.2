Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893544;
	b=puCqfc10g79GgW/HYWkvF9DKidUfjRepz8nqw2n1FEsuETqlG9CAy/Xv7QxoGFnMB4x5
	 clKSR1UTQDsZjHmNT4XJ9wZCC6LfhGnszEb6bWpkMa7MYEPoygT+Ywb/YpHJGCi9GcDqr
	 9Bz7537P6lryhldh0ewlav1pWHS4gr+3kH8pHwjbTbM1TAjSA5VWZDWW3iHfpzqbseM0z
	 cOfYz4dZMV4mtu4+naWC4I1acR09TMe79fcWIlILdEpMIsEkJEU3nnzEoHKDBe57TXqNC
	 vS7JvqTCC79ThxpwzxftLNg6t4FVcZOiFsHvxeQcaBhd975dpqMuMUVvaezZThIX1uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893544;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KYFfEzPSkLd+vp7+a4R/fnMFNlM/Tj87Skq1X+PiAfo=;
	b=QzjDzpOf1FBh2UqAAbVyBGnRTYoQiP/xF8UBYR+lHegHCYxBOAQjc+W/ykY5IAq+WUns
	 NuUrUf8z1x7oDlNM/IQHwt0AINZ1TiBOXIAzk7kdCGTmMai1l+jjX2h0Fs3gZlNCvQgiT
	 fJ8AHyZTzTIgze/uC+44n565H4uOrG7cExczcrHsRpkCiVrZBh1GxavPDT3A0GgbHnsLe
	 pR48Sb0nnvc3Cn7AMwMzTGThYkr/P6EpnoJYl4IBPm5tDW5/D4idOgNRnOyVJnyY4wCSx
	 ZVNBc+9V9pFYQWmReehwTNbc/89BXaPShyUaYGsLy9CHKlWQAnopSwbIREhBN7wpZaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E936606A336;
	Thu,  5 Nov 2026 15:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E936606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xOzeh-00071j-00; Thu, 05 Nov 2026 16:45:35 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 43714C0669; Thu,  5 Nov 2026 16:26:24 +0100 (CET)
Date: Thu, 5 Nov 2026 16:26:24 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] MIPS: sgi-ip32: Leave MACE PCI control alone in
 config accesses
Message-ID: <auygIGW4c9_eBTT7@alpha.franken.de>
References: <20261021192418.7246-1-kaloz@kernel.org>
 <20261021192418.7246-3-kaloz@kernel.org>
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
In-Reply-To: <20261021192418.7246-3-kaloz@kernel.org>

On Wed, Oct 21, 2026 at 09:24:16PM +0200, Imre Kaloz wrote:
> mace_pci_read_config() clears the master abort interrupt enable in the
> MACE PCI control register around each config read. A register read
> followed by two register writes can hang CRIME 1.1 under DMA load.
> 
> Ack master aborts in the error register instead, and follow every
> write with a read so back-to-back accesses cannot form that sequence.
> 
> Fixes: c990081bf87b ("[MIPS] Fix IP32 breakage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/mips/pci/ops-mace.c | 26 +++++++++++++++++++-------
>  arch/mips/pci/pci-ip32.c |  2 ++
>  2 files changed, 21 insertions(+), 7 deletions(-)

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
