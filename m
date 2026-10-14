Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C153ACF14;
	Wed, 14 Oct 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983659; cv=none; b=gy0N6Mg8wqNzoz0zCPtcdhvUhLT9R7HnquVVC+4N+MlunVC3QAwMjXQ0Pi5S1x6Brt2piy2SXHPNraWle6pnTxigOQaXbgZWQ6xolyKFQAGaNwKuuNLUCbVJen8Vm80JeE8U+7GO9RzXOqBemrq7SbA1pCvQYtgIxOqS2PMWId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983659; c=relaxed/simple;
	bh=scxTO8txJo3gaoljr9fQkU1xb5nzMznSl9EJnERHruM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mZ/s4xbXmAUkwBto3dVKF0RPaGUDCCpWSarInFmcEB8dbNw/ZUPExMMDruoqNnUpJcG1ISvYhZtEirXiEeutGd/EnutYjkju7Bf64HlII0OGL5v1/6xhJFxHrHX/xSuvZopwuxXB9WYwBzXSh6FQ32mQ4DqlI8F+lPYGNQR2wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gowA1ETv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gowA1ETv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5117F1F000FF;
	Wed, 14 Oct 2026 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791983658;
	bh=I7YFVkl+1ZY0Rlco79QQvPL2GmZjYoCSWldgOSgBE0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gowA1ETviZIbeOPX37NjJNoUbu6SKjzQEUpmGJRw//cMc6B6dUz/zMF7EWOxDxNvE
	 eCx2UVu0C5gJ/vMEGHjbCc6ruoLZW3YcbR4lXb1ox3BVAGaMe6a/ll9rhuuz4SqgJv
	 sHdsubFdzJjEBsLG/J3m2o4TAz588YPFSlBQkQLVteZF3W8jzGZbIw2mZQpaslSNUS
	 LP7gHotvN9PmUiWKPfEQK87R/H+KgGyzyqDALntgNb4uDapQvnlIhwMa2qwjLFQIYR
	 lUXh6ZckrQQNeLSWX8oUt79HGRQtYb8SyrM0n3TVzxbmD38PX3fe5/Y8yNu7nh5n0z
	 /voxp8/HWnF0g==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bharat.kumar.gogada@amd.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, michal.simek@amd.com, 
 robh@kernel.org, thippeswamy.havalige@amd.com, stable@vger.kernel.org
In-Reply-To: <20260917132459.2153240-1-vulab@iscas.ac.cn>
References: <20260917132459.2153240-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] PCI: xilinx-xdma: Fix device node reference leak in
 xilinx_pl_dma_pcie_init_irq_domain()
Message-Id: <179198364237.63727.8742689610493287096.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:44:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=399;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=i3FYOq1i3QlPXoQPHaC61bAAS20NIkq1j8Z6OirDM0k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4Afqsb4QVGnp++mRm9p8UiFbL4MXqOSS+q06
 aq2bAoZrmuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+AHwAKCRBVnxHm/pHO
 9SFQB/9xhEgM7VvjikxK9eNqB6b94b4qNPxE4sYUYay9NXIP/wPr/h1dJSjmIwiRTDEMg7nM/jI
 Jq3ylqhnL3W40Tx3C/WQ7x874Glp3YJvSrTRF1L7B9OQfbwp7Yb1MGqSEBQIN2T3nn+fkoJqDZK
 uCgc1NwPtkZt5mK+i08bw2j/bpign6TtlDfgpSrSysRB/+cPrQKyt2PXYtCil2j3QAHZyo6bDVe
 qTH7QNul7pqbxfdCkBj4TZN89VCMX19780GXoIQZurrA0k4msPD0heFZe74Rl8LwmX+NdcYXT9J
 Y4t6S8SB4ivukeK2B9bb0+MMF0h9yyoNqZY7wZfIKLhyxbyQ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Thu, 17 Sep 2026 13:24:59 +0000, Wentao Liang wrote:
> PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()

Applied, thanks!

[1/1] PCI: xilinx-xdma: Fix device node reference leak in xilinx_pl_dma_pcie_init_irq_domain()
      commit: 0346bd527dff238db0acfe8ca6c4dfc6c2ea1c52

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


