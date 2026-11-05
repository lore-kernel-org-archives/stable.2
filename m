Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893544;
	b=5MOr5JQH1Dt88wiDrUVFVZW6NYc2x4knlSgxPi8ZBrnVOIwvqmdg2CN4GY6lNh0KO783
	 ueyniLjlEbDOFzIZdRgQpZjm85rGqkilYAhxDIGe8vtAVhEpuO8xfYa4KZjyoKPFWrfPZ
	 nrT6BhzowLxkmxIMAdzsuzwdeuOBDdtCyo9yJ4gAmEJd+hveE1QlRi5svCGQkuIFsBGYG
	 +NWwuYNgIK8Ppi6gXlSgzemq/NYojEbsUsRVb4+qNwhyItfjQtL5qOvcp8TKidX4jV24H
	 qUzKn7leytde/XsHk1SbfVTqqHIcG5nnY9Aua01XhMVw0pBYHeVY1miTzYWU88+pccA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893544;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AKweYcaA3h7dBYyOM9H36OLhS4uCknlLo0A8Hm3XVj4=;
	b=1QqzGMBGuMonNZ/5OMOiwHZ2sNdi5thJ3c/ljteXHFqxzrlEfuMehsNpOYEYhhGWFwgN
	 tA+F8K7d74UAc+iVSLL7n4XJaWFa2NMN9VzDQLpa/HDz9CH9ZuSXTH3CylXhFD2ImzI0B
	 QBZ7FuJP5vTc90OBGc93cL7pQxmRhdJm+nJfBQU6ATJdEUAj3TrEhSMmfOUIxeXOw0bkx
	 tgcUe37/xZx0AnnKa5gX5Ijj4j8OF6tjkbbKOVbZ7sTLFWXoGTTKPsaYAW/3Xsy4fXntN
	 DU7qjanXtzKp+LJ+aNb2597TI5ZkVOAf+ot072LtUvCGvZZu1TK3qOm7oY6c2j57AZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C948606A331;
	Thu,  5 Nov 2026 15:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C948606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xOzeh-00071f-00; Thu, 05 Nov 2026 16:45:35 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 0907FC063B; Thu,  5 Nov 2026 16:25:59 +0100 (CET)
Date: Thu, 5 Nov 2026 16:25:59 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Imre Kaloz <kaloz@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: sgi-ip32: Mask MACE PCI interrupts in CRIME
 only
Message-ID: <auygB8VkI7rQMzX_@alpha.franken.de>
References: <20261021192418.7246-1-kaloz@kernel.org>
 <20261021192418.7246-2-kaloz@kernel.org>
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
In-Reply-To: <20261021192418.7246-2-kaloz@kernel.org>

On Wed, Oct 21, 2026 at 09:24:15PM +0200, Imre Kaloz wrote:
> Masking PCI interrupts in the MACE PCI control register overwrites the
> error and arbitration enables set at init, and a read-modify-write can
> hang CRIME 1.1 machines under DMA load. Enable the slot interrupts once
> and mask them in CRIME.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/mips/pci/pci-ip32.c      |  7 ++++--
>  arch/mips/sgi-ip32/ip32-irq.c | 45 +++--------------------------------
>  2 files changed, 8 insertions(+), 44 deletions(-)

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
