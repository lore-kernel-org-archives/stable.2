Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C14F6483;
	Thu,  3 Sep 2026 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456739; cv=none; b=SRk8sGodUs5VBO7iZmvaMc19wdZ7smQ82VSG3jcYnFMWYDGi/QHo3I4AVrUKBpZ3uJn2gVcfcB/keV2wlVQe8SEVqyMLxczRj1YtnNJh1BRqS8aXGKQt91vMM6ei86nVXS2aNXpimR4hu6phhNLTPamRTb7LuFjOT9Q5anQ3KCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456739; c=relaxed/simple;
	bh=C2dtyGWleH+LQxHEKXOFxlwhFA4tnVVoqVowQ5MLR/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vqep2XUsywBH5ZXKEO8CK/MZCYM9MePo8AMBFQg15H7C8VajTcE2brarVqqI7VhjCNiVF/n249ufBm8t0b0MHymVe4cYeMHCz3vkTgHksbUeuTYWhBY4xHU178LGmdjAPDuuMZkdvZ/czn1nblMTVHcjQRmYxhD+nO3lhopqOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgKlJcvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgKlJcvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A7B1F00AC4;
	Thu,  3 Sep 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456737;
	bh=bMhH/hE/pnJgXYqZniH3Mt4q4k9Csq6W2rGcUAgRJzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UgKlJcvEB1XNu8rHu3zzpL+kF2MmxPslNR5dMa487nrbIDDcKLyjbe7KVx4gSCAtq
	 GvUx7KbZVva/kQf8uT3NDf21mAsvtrnJstZSvkCZ7bYq5uS2gnNie5aGTv8MOsTF8v
	 VtPBxf4KNfcujaU1Sin2vx06QqtssTx2xi1Ux6N6vUYmYuu4/W5UwiWXtPx9+BfYYk
	 uHmaoXUMLzZjvnT4MHCigw6z2vZh+23RxTk/0Es5+u8mfcKNLQWaYlX+fRmpe8k564
	 gBohx24LfZiZPqdctl5ghmmZZRZMT4v3ZC7A1DyYLSiOGuTHCTaFmnUj5UkYYzhAsG
	 RLytiO21nMGdg==
Date: Thu, 3 Sep 2026 12:32:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Ziyao Li <liziyao@uniontech.com>, Rong Zhang <i@rong.moe>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-ID: <20260903173216.GA2145418@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>

[+cc Ziyao, Rong, Huacai for similar Loongson MRRS issue]

On Fri, Aug 21, 2026 at 04:05:51AM +0200, Marek Vasut wrote:
> R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> must not exceed minimum MPS of any element along the packet path.
> Force limit Max_Payload_Size to at most 256 Bytes for each device
> connected to this PCIe controller.

IIUC the PCI core already enforces this limit, and what this patch
does is double-check that this limit is observed with this check,
right?

  +	WARN_ON(pcie_get_mps(dev) > 256);

More below.

> R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for
> MRRS (Max Read Request Size) states:
>   Please set "Max Read Request Size" to 128 bytes or 256 bytes.
>   If "Max Read Request Size" is set to anything other than the
>   above, the transferred data will not match the expected value.
> This limitation also seems the apply to devices issuing MRd TLP.
> This limitation can be triggered by using non-HMB NVMe SSD with
> Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
> Any write into the SSD (MRd TLP issued by the SSD) longer than
> 256 Bytes wraps around at 256 Byte boundary, and the same data
> are written into the SSD starting at offset 0 and at 256 Bytes.
> Force limit Max_Read_Request_Size to at most 256 Bytes for each
> device connected to this PCIe controller to avoid this behavior.
> 
> An non-HMB (Host Memory Buffer) NVMe SSD can be identified using
> the following command. Affected SSD reports 'hmpre' field as 0:
> "
> $ nvme id-ctrl /dev/nvme0 | grep hmpre
> hmpre     : 0
> "
> 
> The symptom is a read from the SSD which wraps around at 256 Byte
> boundary. The test for this symptom can be implemented by writing
> 512 Byte of random data into the SSD and reading the data back. If
> the read back data repeat after 256 Bytes, the device is affected.
> "
> $ dd if=/dev/urandom of=/tmp/data.bin bs=256 count=2 ; \
>   dd if=/tmp/data.bin of=/dev/nvme0n1 bs=256 count=2 ; \
>   dd if=/dev/nvme0n1 bs=256 count=2 of=/tmp/readback.bin
> "
> 
> Expected data:
> "
> $ hexdump -vC /tmp/data.bin
> 00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca
> 00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b
> ...
> 00000100  7a ce 3c b2 e1 d5 d9 11  88 63 10 59 76 3c dc 32 <-- random
> 00000110  72 32 2a 7d a3 e1 aa 13  7c da 58 a1 7b 21 11 50 <-- data
> "
> 
> Faulty readback, collected without this change in place:
> "
> $ hexdump -vC /tmp/readback.bin
> 00000000  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <---.
> 00000010  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-. |
> ...                                                          | |
> 00000100  97 81 b7 3b 0e 38 2b 4d  a7 d3 e0 47 ff c2 4b ca <-:-+- repeated
> 00000110  c1 85 98 f0 4a ac 03 a0  3b ab f3 19 44 dd 06 8b <-+--- data
>      ^^^
>       |
>       '--- Repeat starts at offset 0x100 = 256 Bytes
> "
> 
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: - Dispose of the reprogramming of MPS/MRRS altogether
>     - Dispose of the entire fixup quirk
>     - Replace both with bridge enable_device hook
>     - Limit MPS/MRRS along the entire packet path to follow
>       MRRS limitation requirement
> V3: - Set no_inc_mrrs to prevent periperhal drivers from increasing MRRS
>       over the limit set by this PCIe controller driver
>     - Warn on MPS > 256 Bytes
>     - Recheck updated documentation and update code comments to match
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 51 +++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..e38cde2257bb4 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -411,6 +411,54 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pcie_rp *pp)
>  	return ret;
>  }
>  
> +static int rcar_gen4_pcie_enable_device(struct pci_host_bridge *bridge,
> +					struct pci_dev *dev)
> +{
> +	/*
> +	 * R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> +	 * Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> +	 * must not exceed minimum MPS of any element along the packet path.
> +	 * The controller reports Max_Payload_Size_Supported (MPSS) 256 Bytes
> +	 * for header type 0 and 128 Bytes for header type 1. The PCIe core
> +	 * will not allow MPS to be set higher than MPSS, warn here in case
> +	 * something went very wrong in the core.
> +	 *
> +	 * For details, refer to chapter "104.1.1 Features" in either of:
> +	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
> +	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
> +	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
> +	 */
> +	WARN_ON(pcie_get_mps(dev) > 256);
> +
> +	/*
> +	 * R-Car Gen4 Reference Manual, chapter 104.4.8 Usage notes for
> +	 * MRRS (Max Read Request Size) states:
> +	 *   Please set "Max Read Request Size" to 128 bytes or 256 bytes.
> +	 *   If "Max Read Request Size" is set to anything other than the
> +	 *   above, the transferred data will not match the expected value.
> +	 * This limitation also seems the apply to devices issuing MRd TLP.
> +	 * This limitation can be triggered by using non-HMB NVMe SSD with
> +	 * Max_Read_Request_Size 512 Bytes, for example Crucial P5 Plus.
> +	 * Any write into the SSD (MRd TLP issued by the SSD) longer than
> +	 * 256 Bytes wraps around at 256 Byte boundary, and the same data
> +	 * are written into the SSD starting at offset 0 and at 256 Bytes.
> +	 * Force limit Max_Read_Request_Size to at most 256 Bytes for each
> +	 * device connected to this PCIe controller to avoid this behavior.
> +	 *
> +	 * For details, refer to aforementioned chapter in either of:
> +	 * R-Car S4 R19UH0161EJ0140 Rev.1.40 Jul. 31, 2026 or
> +	 * R-Car V4H R19UH0186EJ0140 Rev.1.40 Aug. 7, 2026 or
> +	 * R-Car V4M R19UH0217EJ0110 Rev.1.10 Jun. 30, 2026.
> +	 */
> +	bridge->no_inc_mrrs = 1;
> +	if (pcie_get_readrq(dev) > 256) {
> +		pci_info(dev, "Limiting MRRS to 256 bytes\n");
> +		pcie_set_readrq(dev, 256);
> +	}

It would be nice if all the platforms that need no_inc_mrrs could
apply it the same way, but I assume you saw loongson_mrrs_quirk() and
loongson_set_min_mrrs_quirk() in the process of finding no_inc_mrrs,
and chose a different implementation strategy for some reason, e.g.,
this way doesn't have to include device IDs for all the Root Ports?

Maybe we should rework no_inc_mrrs in such a way that drivers could
set a max MRRS in the struct pci_host_bridge and make
pcie_write_mrrs() and pcie_set_readrq() pay attention to it?  That
might let us get rid of the FIXUP approach.

> +	return 0;
> +}
> +
>  /* Host mode */
>  static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>  {
> @@ -418,6 +466,9 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>  	int ret;
>  
> +	if (pp->bridge)
> +		pp->bridge->enable_device = rcar_gen4_pcie_enable_device;
> +
>  	gpiod_set_value_cansleep(dw->pe_rst, 1);
>  
>  	ret = rcar_gen4_pcie_common_init(rcar);
> -- 
> 2.53.0
> 
