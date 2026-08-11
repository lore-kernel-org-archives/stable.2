Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E841F349;
	Tue, 11 Aug 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441187; cv=none; b=j7kdI+Vj0qQu03POPEvD5fsbht3P7matTQ6su8/+1UFBxScoEjCMBRAcz3ZOV7fQKjjHXeanoLkeQQlIxdlwnGI9OnBGPuyT6yLuVxZfDW7PLefN6zM07akI4F3IRo1zJau2msfo3nhbyDjuG+z2OpdvAzHDzBXyg6SjhScka9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441187; c=relaxed/simple;
	bh=+b04SFo3N7vH3m5+7j5ZqrHaU2uYA4DoKPzuq66oQ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=c0Ocvho0GxfVXWwaY6ezO/02rR1B/MXbmJZ2lwSvDPju6wk+YxOUAVU2W4VhzzfHlnK6SEQtP2RTEf0nPvYssgjhcGF45L6hL0oF9gF1Aw+5QMt0mUsBI8vHohbJc8MPcmbtH41r0xLtkycCRQbyfeWCCYmEBbDbFOqeKgkq+70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU4cjAYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU4cjAYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9000F1F000E9;
	Tue, 11 Aug 2026 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786441185;
	bh=3UuzdTW7kLUcwK4FTVmcoTzCuQz6a2hx5g9LrqWdmlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JU4cjAYx1H3q06sAr6W7bos2QQOnd6kNVh017PHspftE5AaZ4bOCkStC17Caa1k00
	 OKBf4LCHRW2yOy+97HexYtEdXEdBxB3iIaZxAGO33RQcJgIdG0h7Ktwmt712wVn/nQ
	 MFqPu5q4kIzFWTgR8/cAGXt7HSE6BxM4giqYAh0bviq0lrv5LXRudCXcZruXrxohpT
	 90b4vMphI6yDtvJXbkKyDa1kNLhW2Pn8cZ90dNBzKlKQt9KjqbqTTyZ2DzTexTIyeh
	 hpuPtNPzNU6U0n1Fj7ujKtSnulon9hM5ojB/t2D8Y5DhBOArmXZ9N2ayTLukHP/fCH
	 Il+Cr7dVNmb6A==
Date: Tue, 11 Aug 2026 04:39:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Max Lee <max.lee@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com,
	mani@kernel.org, kaihengf@nvidia.com, victorshihgli@gmail.com,
	lukas@wunner.de, pandoh@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Disable ASPM L0s for Realtek RTS525A
Message-ID: <20260811093944.GA605422@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707021527.639611-1-max.lee@canonical.com>

On Tue, Jul 07, 2026 at 10:15:27AM +0800, Max Lee wrote:
> The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
> Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
> HP ZBook Power 16 inch G11, the Root Port received tens of millions of
> AER interrupts from the RTS525A even when the rtsx_pci driver was
> blacklisted and the endpoint was not enabled by a driver.
> 
> For example:
> 
>   pcieport 0000:00:1c.6: AER: Multiple Correctable error message received from 0000:58:00.0
>   rtsx_pci 0000:58:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
>   rtsx_pci 0000:58:00.0:   device [10ec:525a] error status/mask=00001000/00006000
>   rtsx_pci 0000:58:00.0:    [12] Timeout
>   pcieport 0000:00:1c.6: AER: Correctable error message received from 0000:58:00.0
> 
> Testing with OS-native AER control showed that disabling only L0s on the
> RTS525A link stops new AER interrupt and counter growth while leaving L1
> enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
> storm.
> 
> Prevent the broken L0s configuration by removing L0s from the RTS525A
> advertised ASPM capability.  This avoids enabling the non-working ASPM
> state instead of masking the resulting AER Replay Timer Timeout reports.
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Lee <max.lee@canonical.com>

Applied to pci/aspm for v7.3, thanks!

> ---
> Changes in v4:
>   - Add an AER log snippet to make the quirk easier to find.
>   - Reword the RTS525A comment to describe this as a Replay Timer Timeout storm.
>   - Add Reviewed-by tags from Lukas Wunner and Manivannan Sadhasivam.
>   - Add Cc stable tag as suggested by Lukas Wunner.
> 
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc0..ab94bd7f3a34 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2520,6 +2520,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>  
> +/* Realtek RTS525A generates a Replay Timer Timeout storm when L0s is enabled. */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_REALTEK, 0x525a, quirk_disable_aspm_l0s);
> +
>  static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>  {
>  	pcie_aspm_remove_cap(dev,
> -- 
> 2.43.0
> 
