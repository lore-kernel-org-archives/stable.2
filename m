Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B22E4257;
	Mon,  7 Sep 2026 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774318; cv=none; b=UTQ6tdwVA16rjUyxbquWWJP1Ew0XJ8ac4OoyLHkLqwykxlCXAvevzm0ru9fDBmFE7+7C9TB3VN30Jzh6LPqz+GNYXIZnwAzI+gFvUuTTN/gmoZxEox929OytMEYXxMWycJmNy0ojT6hO8aGWvCxeOXSX4XIAiw4k+N3UdHj2K6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774318; c=relaxed/simple;
	bh=QulMtI4ceP4x8mHEkb9qFFuaT4z3oTepjm9z8xEWagA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezaiTiII8K43hSl+7pHIwNxQx/Up78D52gNK8H/tJd0spufWrw1GXO7aScQ97XCuJH6ysg1TJ174z4mywcZhO7NJ/o+U6dBOikzMPC7uK5HSuL5YFrcaTyS2SKJ6wJ2xdGkFlw0utFnhl/MM/8ucJi0UU496h1/gigSd1GSFa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjdblaSn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjdblaSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FC11F00A3A;
	Mon,  7 Sep 2026 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788774317;
	bh=Ng0muayWWjw6g2DxYAEFys5pXOUfKx7shtKSJ8X6pxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NjdblaSnKikkiedYP09hXyxIwVPShiPhId1lAdrI/ae7x+vuyqX3/d95/p5Z8HVI5
	 yIao6+F9Wz++8CHrAjIkh5yaobpSGuLauhaxPxhm860iszNHfvgW/t01tnOnO1iyXE
	 ZksPoI9MdCjx1vnvl/NKN4wFnt3GiYgNCrSO7NQs5qSHT1cPlcMLa6syH5ooKVPU9v
	 7X2PrSgvu7orrWwFBGNfiwbdtzIkgVxm5g1a8w7znResfoFvrZMeM7XBFCktL7jz+u
	 hu7OnXCSvBW6uv9AWRhsGLbqjFW3aGkqENK3837Xy+eAeXzSNKrrlb7/1ZkJ87Xy71
	 oDY710N2Suk7Q==
Date: Mon, 7 Sep 2026 11:45:12 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	Pali Rohar <pali@kernel.org>, stable@vger.kernel.org,
	risc4all@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
Message-ID: <ap6HqG5ZwCxfb8OJ@ryzen>
References: <20260831124303.920391-1-hajo-linux-ide@noerenberg.de>
 <178818641418.216562.3155723702033731494.b4-ty@kernel.org>
 <aprZi3G9Yks1Gq9-@ryzen>
 <1fed10ef-4a5d-4c49-bf23-34c4c30c5884@noerenberg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fed10ef-4a5d-4c49-bf23-34c4c30c5884@noerenberg.de>

Hello Hajo,

On Sat, Sep 05, 2026 at 02:30:14PM +0200, Hajo Noerenberg wrote:
> On 04.09.2026 at 16:45 Niklas Cassel wrote:
> > On Mon, Aug 31, 2026 at 04:27:24PM +0200, Niklas Cassel wrote:
> >> On Mon, 31 Aug 2026 14:43:03 +0200, Hajo Noerenberg wrote:
> >>> ahci_single_level_irq_intr() services the ports first and clears the
> >>> global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> >>> 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> >>> for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> >>> PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> >>> looked at again, and the command in flight only ends in a timeout.
> >>>
> >>> [...]
> >>
> >> Applied to libata/linux.git (for-7.4), thanks!
> >>
> >> [1/1] ata: ahci: work around lost interrupts on Marvell 88SE61xx
> >>       https://git.kernel.org/libata/linux/c/22f2ba34
> > 
> > Decided to send this for 7.3-rc2 instead:
> > https://lore.kernel.org/linux-ide/20260904144228.1473602-1-cassel@kernel.org/T/#u
> > 
> Niklas,
> 
> thanks for moving it to 7.3-rc2.
> 
> I spent a lot of time on this bug, mostly because I did not know what I was
> looking for.  Now that it has a name, searching for it actually works - and
> out of idle curiosity I went looking a moment ago, only to find that FreeBSD
> has been carrying the same workaround for years.
> 
> In FreeBSD's sys/dev/ahci/ahci_pci.c all four chips of the family are tagged
> AHCI_Q_EDGEIS:
> 
>   {0x611111ab, ... "Marvell 88SE6111", ... AHCI_Q_1CH | AHCI_Q_EDGEIS},
>   {0x612111ab, ... "Marvell 88SE6121", ... AHCI_Q_2CH | AHCI_Q_EDGEIS | ...},
>   {0x614111ab, ... "Marvell 88SE6141", ... AHCI_Q_4CH | AHCI_Q_EDGEIS | ...},
>   {0x614511ab, ... "Marvell 88SE6145", ... AHCI_Q_4CH | AHCI_Q_EDGEIS | ...},

Thank you for the information.

If Marvell (or anyone in the community) cares about these controllers,
patches are more than welcome.


Kind regards,
Niklas
