Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6F8367B63;
	Tue,  1 Sep 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269740; cv=none; b=MBSwOhnI9CZ1HTiOl83IbHx8TPKIYIazv7Mrt39sYBKBEvjvDkQipzycXmeO/a8YXdmNLTYTgOgLfvU+d0wO4h4eYRQLxqdoUlIytTWf7G7UCrEe2K4YpoKrhz/uCFyLrPtYPr0JFkOVN2yGNoD+TuIqxVgb/vUdQLDjuPEKYCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269740; c=relaxed/simple;
	bh=iwatsgcy2L3871hC0b2pUHzMd4A4No0ajGTFKxwg6s8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=loZH9qkTFwZmw+2yTwuGjAcUTiM9jL4ikWPQ+VT4zz7GxWCCNg9PBTnuO2gHqBOVBiIot5rkeIx5/2sW2hBcDt3TfrPWvwcJD9Ku8wiCYORpDmqZAg7gehLwkE92QG/1HK9ypnnREi8oOeX2CMDBS5dfhkoOYagVNzwQp8BsadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388B31F000E9;
	Tue,  1 Sep 2026 13:35:33 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: stable@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Koichiro Den <den@valinux.co.jp>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>
References: <20260821020636.111719-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3] PCI: rcar-gen4: Limit Max_Read_Request_Size and
 Max_Payload_Size to 256 Bytes
Message-Id: <178826973380.60509.4783762290802893861.b4-ty@b4>
Date: Tue, 01 Sep 2026 15:35:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 21 Aug 2026 04:05:51 +0200, Marek Vasut wrote:
> R-Car Gen4 PCIe controller has a hardware limitation of 256 Bytes
> Max_Payload_Size (MPS). PCIe specification indicates that the MPS
> must not exceed minimum MPS of any element along the packet path.
> Force limit Max_Payload_Size to at most 256 Bytes for each device
> connected to this PCIe controller.
> 
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
> [...]

Applied, thanks!

[1/1] PCI: rcar-gen4: Limit Max_Read_Request_Size and Max_Payload_Size to 256 Bytes
      commit: d1f8ada0815e247b52e5f9d4ff3a8bc9e4080bb9

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


