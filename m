Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915510;
	b=zQuA20sOwZLOF5m/TZC/QZUzo4QNZ+/5xz5Z+FJffuU7Y+3p+hqeSGoXVTiXwlP8CmXw
	 AUX2voxyUOiEE1ESWDq+fgKrN4+nk0MfXvDBJ7/rnjsBx+ecI/ju8XXUph+uFKqpb1QqX
	 cU47UYfhKCVlDZHhZTWIVKBYfNTWYYpXbQo6EAl0JgQ70sTm7Tr+v6aQ4MaYXRQovUeud
	 /QIBKFPTM1ASd3mtJjytfJ9JnHTssU8hLlNc7miQr0+sXx5cuAdaDHCGIBNpHiHb9N8kz
	 3Kfg8oV7YBnTeipC2c1JPvPxO/GNRhd7Us3gKjwUZ08DxB19Tgsct3bd1budrNoM6uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915510;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nn59pGKdS6ZAYSfKCAK/dFr8+eqz3gwLAlKcsw0ScZQ=;
	b=Aw817pnO+EbSijbq7o2Dk87aZYYmGMpcWsEh9IKlmRb3xl1TTCw34HbCan6KidQ7yWuK
	 7eBefxDVKcB/ryAhavc6zRwLOcTbKZbaEmpIRE0M7B5OY+9TpPNNIHRaH37dXYJgPlpcm
	 KkFiTsqRh1B2gOkISGnq5h3qyplK0UjA8A2vSPPZYmTrx31Rh73hgPANj/4gCvGSwSpDi
	 T7ljURFaWY6hpJy1WY/nLm9e88LQVvrbEpEPVOGeS5YxX+nS4ZLBR0My6R5bDFFjEfm9d
	 DabTEr9Spwk8zezL8GK3HY+4aS/IHSz3gOIsa10XAZNx8LrmEZOjEoq2LZwRkZjbd9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9QWj46W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92D606A326;
	Thu,  5 Nov 2026 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9QWj46W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE521F0089F;
	Thu,  5 Nov 2026 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793915509;
	bh=nn59pGKdS6ZAYSfKCAK/dFr8+eqz3gwLAlKcsw0ScZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=e9QWj46WJmqKLLHeKyw0Yzz8G+RXC61IrMhy4Bas55drdXiGEYmRQwQhTbxK4pkW0
	 ULAdE7Zd3tKO9VjaEfwhGmrchm/7jbCRDykhKwCJiPJeRaK5x/6JU+ok47BddiGFBD
	 JckEzm0lGhIZT+uY0Ue+jHI2Ex2oKTbQVsk94uOrqei9hBITFU/dP2ngAyMlsRmSC5
	 6wYQkd925iKUwnY6Z8gVHlhT9YMx1gxI4OBlnEJSMZEoaJhfcjQsB6RC6rRBCX3F/h
	 d4YejkFDWeJkxO7LBAi/W9Nrs7G9zA6AeVd9hGTjGaL0pDwkuX7FmQB/etKrZtFlOA
	 VgrBsWSQEU2oA==
Date: Thu, 5 Nov 2026 15:51:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jennifer Chan <jenniferchan@meta.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
Message-ID: <20261105215148.GA1566818@bhelgaas>
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
In-Reply-To: <20261105201010.2297078-1-jenniferchan@meta.com>

[+cc Lukas, author of ac91e6980563, Jason in case NVIDIA knows
anything]

On Thu, Nov 05, 2026 at 12:10:10PM -0800, Jennifer Chan wrote:
> On a Supermicro HGX A100 system (X12DGO-6), each of the six LR10
> NVSwitches (10de:1af1) sits alone behind a PLX PEX 8725 (10b5:8725)
> downstream port.  "nvidia-smi -r" resets all GPUs: NVML unbinds the
> switches from the nvidia-nvswitch driver, resets each one through sysfs
> (reset_method "bus", a Secondary Bus Reset of its port) and binds them
> again.  The PCI core waits 100 ms after the link comes back, the switch
> answers config reads and the reset completes.  When nvidia-nvswitch then
> probes the switches, one fails in pci_enable_device() with
> 
>   Unable to change power state from D3cold to D0, device inaccessible
> 
> four others fail to initialize with -EIO, and the NVSwitch fabric does
> not come back.

Do you know where the -EIO is from?

> The same systems recover every time on a kernel that sleeps 1 s after
> each Secondary Bus Reset, as pci_reset_secondary_bus() did before commit
> ac91e6980563 ("PCI: Unify delay handling for reset and resume").  Adding
> a 1 s sleep before the link wait on the PEX 8725 ports of the failing
> kernel fixes it too.  Config reads already succeed at that point, so
> pci_dev_wait() does not cover it, and the switch's state there is not
> known.

Ugh, a second is a long time to wait.  Does the kernel you're testing
include e8df1d194c39 ("PCI: Don't treat ~0 as ready in pci_dev_wait()
with RRS SV"), by chance?  It only appeared in v7.3, so it's pretty
new.

> Give LR10 a 1 s d3cold_delay, so that pci_bridge_wait_for_secondary_bus()
> waits 1 s after the downstream link comes up before the switch is used.
> This adds 1 s to each LR10 reset (about 6 s to an "nvidia-smi -r" on
> these systems) and to D3cold resume of its port.  Resets issued further
> up the hierarchy keep the default delay.
> 
> Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jennifer Chan <jenniferchan@meta.com>
> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee4..4a84095e736f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6569,12 +6569,14 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
>   * after reset recovery or resume from D3cold:
>   *
>   * VideoPropulsion (aka Genroco) Torrent QN16e MPEG QAM Modulator
> + * NVIDIA LR10 NVSwitch (HGX A100)
>   */
>  static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
>  {
>  	pdev->d3cold_delay = 1000;
>  }
>  DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x1af1, pci_fixup_d3cold_delay_1sec);
>  
>  #ifdef CONFIG_PCIEAER
>  static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
> -- 
> 2.53.0-Meta
> 
