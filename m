Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27737C93C;
	Tue,  1 Sep 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251529; cv=none; b=WzSwHSWJwl8NxfjyJeBM6jHynGhGOyFUmOEBidDI4koGWCaXaJdODs2N5Nd6/J/cg0jLTmo8055VbDIqYc2PsVts6TeJk1q0F6+bw8jypQERG1HGZimebmhUmK2PV4FDDCYvpx7sxRFL7xEaPdj9xrS7nsY95kLqn+BASVQHMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251529; c=relaxed/simple;
	bh=e/xZUdbse/D+FLRUhBwB4asp0UaLqtqrg4y1E0Nl1cE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gUIw3cuvKC1RKD6CX0hnZBCmWIGHXJek1Rq9p6McRvGV1ZXbw+hwfujnm+WFcFWKUZtK8UGHox1GLj7M96J4i1BYM5G3de578r6PbEbW/XqBWDUsHcW1T7aNyTeYz31QVdiYwF45unhHvGdWLjVhhAxWmnMJzLaCvy/NW85prhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6901F000E9;
	Tue,  1 Sep 2026 08:32:04 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
References: <20260829-wip-obbardc-drivers-pcie-qcom-rb3gen2-usb-fix-v1-1-337821131a99@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Only check bridge nodes for PERST# GPIOs
Message-Id: <178825152456.51373.601616976219776003.b4-ty@b4>
Date: Tue, 01 Sep 2026 10:32:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 29 Aug 2026 11:36:00 +0100, Christopher Obbard wrote:
> qcom_pcie_parse_perst() walks the PCIe hierarchy described in the device
> tree below its root port and collects the PERST# GPIOs from each bridge
> node so all PERST# lines can be driven in unison during controller
> bring-up, reset and power sequencing.
> 
> However, the recursive device tree walk currently visits every available
> child node without checking that it is a PCI bridge. This allows the walk
> to leave the PCI hierarchy and collect reset lines from children of PCI
> enfpoitn nodes, where those reset lines belong to other drivers.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Only check bridge nodes for PERST# GPIOs
      commit: 1b3b0bc2b3672e928e06997444528f8797579eb2

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


