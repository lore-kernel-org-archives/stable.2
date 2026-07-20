Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983F541CB5D;
	Mon, 20 Jul 2026 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552663; cv=none; b=NhDSIXbn/qlfVqrCdhoBYE9HcN0XU0HClH3IWp81rb/kvaySu+NyNqK+443rmYvnlGAkbXOzBd4u3tY9C8ufY4IhTEdTjApXdTPnkCG2IF0NcEuXuTdxdaFB4TRW3UF781wvxq2A8NA03TTfO+26ad8Y8NMwJyk5tvfBMdPsdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552663; c=relaxed/simple;
	bh=E+eSRnrW+NZvOpY9qVlKZl4QXonZmy3TyjCHW0pH0xg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UdddVgU07cMkAnH2UojcRlzQfFz+VF4sMM8M4XfNTqM5IPmDHw5hwkXkT/IIqp1P20wbeqxflVmK6DetCu0LxLlJ6jw87lx+59/McO+Gf7S6UMYbSTDdKz/qg24AMrT1hp93U16E9psapEdIvNc5Ka/cUUY7Rau7C7SJF3o367U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyLoXd//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyLoXd//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7201F00A3A;
	Mon, 20 Jul 2026 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784552660;
	bh=2oMscjj0OQ6r+QkQqnuEcryEB20ua4iBrqQS5thIYHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JyLoXd//Gv3nB8Q3RutCXxOJnNAFesU4ch11Fti8s5nAlDIl38uOjTV2GjL0KEiJ/
	 MsrRNN6LlKXP7h+OgvY6GdAvQDhMiSHfeIIg4f9+1n0uZoWszfXwbYnotxkgcls+uy
	 X2cj7FKn1/ClxCr9Nlz+Dw/+f03vaJFLiMFskNN3RxlTS2tOyvh3q+CPXVODT7whfN
	 9pVBGdhJIcJaf78O9CIeRYrrSqmKVYAl/kVKF5yvzYlIFwNEeDN5bA4aWRZIlsuXrk
	 ahIPMh/wA/6z7rMYWpO2Gd+chmXeto4eX7SQx5T4hWDRqYtn3Y+MaE6fQabKwzPqhG
	 mL8Tu8NXFDSQg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Will Deacon <will@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Steffen Persvold <spersvold@gmail.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260709122446.3151899-1-spersvold@gmail.com>
References: <20260709122446.3151899-1-spersvold@gmail.com>
Subject: Re: [PATCH] PCI: host-generic: Fix NULL pointer dereference on
 32-bit CAM systems
Message-Id: <178455265741.24429.4069285286269225213.b4-ty@b4>
Date: Mon, 20 Jul 2026 15:04:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 09 Jul 2026 14:24:46 +0200, Steffen Persvold wrote:
> On 32-bit systems the config space is too large to ioremap in one go, so
> pci_ecam_create() maps each bus segment separately and relies on the
> ->add_bus callback (pci_ecam_add_bus) to populate the per-bus mapping in
> cfg->winp[]. pci_ecam_map_bus() then uses that mapping as the base for
> every config access.
> 
> The generic ECAM ops (pci_generic_ecam_ops) already provide the ->add_bus
> and ->remove_bus callbacks, but the CAM (legacy) ops in pci-host-generic.c
> do not. As a result, on a 32-bit host using "pci-host-cam-generic" the
> per-bus mapping is never set up and the first config read dereferences a
> NULL base, crashing during bus enumeration:
> 
> [...]

Applied, thanks!

[1/1] PCI: host-generic: Fix NULL pointer dereference on 32-bit CAM systems
      commit: 008cb88edb41f3c7c8e0ed763ff9f26719830984

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


