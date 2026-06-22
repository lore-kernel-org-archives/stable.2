Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9303ACEF1;
	Mon, 22 Jun 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134366; cv=none; b=oAnE1oWGQpBAKyzBQNtoXoYjszhRTAQ/jRCiz/yEQ8XP5LXENigoxf3KBdZa2oVF06vqeCrz77+VmaBUo+KrqaFjQNSH3utXZSd5WOpamdFCQ457U5IFRfYe1DqJkaBcVfom/J/4l0ZB1XIca3aJHrN3leCv2o9bgC68k7rJ05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134366; c=relaxed/simple;
	bh=8bGBKUF3m/qOLK0ih9wizlpj0BMxuCtUnhKDwkzW51g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVHwOAsstwC26K09R5FX2D3EBk7yKoB4LjDy2bw4Bsn0iAnb9tDMjqUpIOh2SngBc1ZhLaImVKKEmq6QfRHccLT/g6JiZJtcyvFtM73lhmjSsWK7MzSPLBeWbeJtu5oac033OwvHkN9WMKU245YD/tr1nrcvSEb9j/j73HJ0rus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cslyHsxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cslyHsxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DE61F000E9;
	Mon, 22 Jun 2026 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782134365;
	bh=gCuyjH8s4uo18v3YVLGfAenBgSN8rOqxr2/O5hTYl38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cslyHsxacOJ3QXg4oBPi3fC1KSr1icF0qmff+EZiuEE7m5nhhpNsNQYq/2nQfNc96
	 dCDRTwvzmPf9A9uTK8dTtufOfivXPKSKPo14Hwpfn0ouyhLeFeYOAielyVbMpnM8D/
	 pGWgyw75dbR7QtPhJobc/T2ayOqRCxeS3kbE3iHtDOZorwHoXHS7PQX0DT1m7zFofQ
	 6UFcADMR/OtXeNuOI090MBf+BdaQ3aUvGUs7y+5nvyq1gbku9jL4v8g8aJr2cbhOrq
	 stTzAjxd/X6p8SXKSZByAhXBj78GyIXVidj/bYcT448j7nbIEtmlwc9fgvPPMm6j/+
	 x0dGfb76mPsgg==
Date: Mon, 22 Jun 2026 15:19:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Alvin Lim <alvinwylim@gmail.com>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <ajk2WIzpNgQSJ2dh@ryzen>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
 <8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
 <20260622140257.113f2275@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622140257.113f2275@pumpkin>

On Mon, Jun 22, 2026 at 02:02:57PM +0100, David Laight wrote:
> On Mon, 22 Jun 2026 20:31:54 +0900
> Damien Le Moal <dlemoal@kernel.org> wrote:
> 
> > On 6/21/26 19:08, Alvin Lim wrote:
> > > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> > > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > > transit. Reads return different, wrong data on each access. SMART is clean,
> > > there are no SATA link resets and no MCE is raised, so the corruption is
> > > invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> > > or, on Ceph, mass scrub errors across multiple independent filesystems at
> > > once - i.e. host-level, not filesystem-level.
> > > 
> > > This is the same failure mode already quirked for other controllers that
> > > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> > > The ASM1166 currently maps to plain board_ahci with no DMA limit.  
> > 
> > Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
> > this adapter bug is the same as the 1061.
> > 
> 
> It would also be worth checking that you get the read fails with a 44-bit mask.
> 
> I'd guess it also requires that you keep the controller busy for (about) 8TB
> of reads - which is where sequential address allocation would exceed 43-bits.
> But that is just conjecture since I've not looked at the iommu code.

The iommu code will by default try to allocate a 32-bit IOVA by default:
https://github.com/torvalds/linux/blob/v7.1/drivers/iommu/dma-iommu.c#L780-L799

Only once a 32-bit IOVA allocation fails, will it start using 64-bit IOVAs.


It is possible to to set iommu.forcedac=1 to allocate from the full usable
IOVA range immediately:
https://github.com/torvalds/linux/blob/v7.1/Documentation/admin-guide/kernel-parameters.txt#L2619


Kind regards,
Niklas
