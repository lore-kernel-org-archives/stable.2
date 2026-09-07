Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E74435537;
	Mon,  7 Sep 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768028; cv=none; b=kWpIhaopdgq/9BIi7iK9lnIGSJYdTJMCFgxjG2/3s+1tpjwzx7EPTRb//mOwaxUURDFIQClW2A+gWmiysih3KLN3Tyl3FZMr7kYWAc+YlnXdMY589k/QzTtjkuPIJ7bN+XpAMp7fPTHPwASaTesuAQPQ4WuTPdiKvLZTqOB2/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768028; c=relaxed/simple;
	bh=S5Dj3dy+babxMTZ/ffJ5H6c2DLn63XlmlJwcbxNrIQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpqXTJq6Xio5iKSGuiE8z8X38Mi+XCXTz9m/foajkSMYWQ2CfMog1at6e8GRvzNKAJF7K83Rlg5VsKZoZgE14WCUVh7TQYxKWOZtoo1lSbuUytHAjgPXV8MM/II4YrnrEhwn1usUO8pYEjz3bQg/LdKuLVt/F4evTduknTV8Ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCr/s5lB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCr/s5lB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBB91F00A3A;
	Mon,  7 Sep 2026 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788768024;
	bh=bTN70k/xFuZtgpBT3cRG92womfN5G6d4sTAzvaHkyi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LCr/s5lBzoQWo9eF/diAjxfGt2wHCGqsBQYFqg3oMGMV8/L+lbA9u36/U4boBFvSR
	 7ZJFJ3BPA4de9/lKzQHqYURnx6g58s+uhLPRApJmRguePlpYMP7k9G95/3SRHuUe14
	 uHR0bDZTnNPLpcbU4BAoWFBjI/qZoIeqmCE5j1b5FAjg4WOoiTg6w3piNWUb/cVhJh
	 LKLi7aW94R4PrMLF914fzD3pofU+lgjqEDPwj5iGtf7fOD+wGESPPjelJOix9j0cdl
	 rz70e+bB59LHvLNAG0vQLUCy7kEbb6dOXEoMDPQrvjbrdX4yO59LmyTdc6s0bqeVKG
	 z7yKed/pDzJxw==
Date: Mon, 7 Sep 2026 10:00:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Roland Waltersson <roland.waltersson@netinsight.net>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ata: libahci: clear PxCLBU and PxFBU for
 AHCI_HFLAG_32BIT_ONLY
Message-ID: <ap5vFBMRkoe0NF73@ryzen>
References: <20260904134310.1465051-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904134310.1465051-2-cassel@kernel.org>

On Fri, Sep 04, 2026 at 03:43:11PM +0200, Niklas Cassel wrote:
> A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
> JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.
> 
> The failure is seen as soon as the ahci driver is probed, and booting with
> iommu=off does not solve the problem.
> 
> Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
> for HBAs that do not support 64-bit addressing.
> 
> For HBAs that do support 64-bit addressing, the registers are read write,
> with a reset value that is Implementation Specific.
> 
> When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
> addressing, and a 32-bit DMA mask is set by simply clearing HOST_CAP_64.
> Thus, in this case, we need to explicitly clear the registers to 0.
> 
> Fixes: 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585")
> Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
> Cc: stable@vger.kernel.org
> Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
> Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Hello Roland,

Any chance to get a Tested-by from you?


Kind regards,
Niklas
