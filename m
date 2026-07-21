Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199946D2C8;
	Tue, 21 Jul 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651304; cv=none; b=ZKy+ybF4TrEe5cDRBaSuhCYXjECwrR6JoXOKkCk2FLaXTGxz9Cn1J4kWjY8pJ6g4opAnbrlwgO8CyM2GBp9patyHZQzsgGj2DRw5+VRIK4krSt1MJj7IUeJUWk7gVJaKDuf3+oVoKTEH2qqEk4dWtesHXuC36NNQa/VvO9ywnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651304; c=relaxed/simple;
	bh=0g1p8YKIE71TU+sqJW4vyCLd3WmftBg8dmFfLAjv/js=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=biIC7Gm/Y9Rm8iqNU9W+STVlhnzvOnVnMzk/mt+Jtnubb400hSNHYwlrTEiGP5Ks3n+lwVfS8/sqN9X0u/znMO1hgxeBOaObvzLBvGnGmuyXc3Hu0v/Wd19SasSRiyk+7db0IDcXDYyYtjM/1TJDlBO5SlUK8j8oP4ukc2M7sEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0uhu9fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0uhu9fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE92A1F00A3A;
	Tue, 21 Jul 2026 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651303;
	bh=6VO5TFovKdiYaUF1XpN9HMdtCIy6aNvr3B6X5YAjvcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=A0uhu9fPlgHS9/Glw7FYvYs7AE54IX9obz/o9Z67uON7wV9Ts2ERuEQyHbmU2r5xi
	 GuZNWat5HQ+rVFB7GOnFJfKwaCpKb78vxD8Ll3CSIW/jJQA+/LmEcziWrmk8TZs+/K
	 Kw+BHAe3/Xx0gkFAd/eTROvTUiVHOYOKxE/GRNzQU2uB5N3yx7sxPSIYVx2pPzQStF
	 3r5+kHjPBNEDAIPB6vH8preCZHQYx1S/zDIHtcJbYZGQ7fW/fSCu3wlX4iEQWVHe06
	 4zKBW3RXX5c3afktBxkIWjfmy2leCuJM2InQMmCyz0IHoT03J+c2mqzG2zcUq03R2v
	 pi2SBlBa17+cw==
Date: Tue, 21 Jul 2026 11:28:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>,
	Nathan Rossi <nathan.rossi@digi.com>,
	Nathan Rossi <nathan@nathanrossi.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G608 switches
 [12d8:2608]
Message-ID: <20260721162821.GA596492@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720215718.2139510-1-tharvey@gateworks.com>

[+to Nathan]

On Mon, Jul 20, 2026 at 02:57:18PM -0700, Tim Harvey wrote:
> The Pericom PI7C9X2G608 6-port Gen2 PCIe switch is also affected by
> the PI7C9X2G errata per the errata document:
> E2: ACS P2P Request Redirect Is Not Functional
> 
> Apply the same quirk to this PCI ID as well to apply the workaround
> required if using ACS.
> 
> Fixes: acd61ffb2f16 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to pci/virtualization for v7.3, thanks!

Note that Sashiko found what looks like a legit pre-existing issue
with acd61ffb2f16 ("PCI: Add ACS quirk for Pericom PI7C9X2G
switches"):

  https://lore.kernel.org/all/20260720223203.A30841F000E9@smtp.kernel.org

> ---
>  drivers/pci/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..27f7d56c9ac3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6263,6 +6263,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
>  DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
>  			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
> +			 pci_fixup_pericom_acs_store_forward);
>  
>  static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>  {
> -- 
> 2.34.1
> 
