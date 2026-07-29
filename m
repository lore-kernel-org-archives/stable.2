Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFC3AAF48;
	Wed, 29 Jul 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342693; cv=none; b=kVbSLcwOEZGBJL9niB8A2FBhhxQ+xz0tcR5oDYhL7e8skvMhH7Hh3fmT0AEhhjoKslM4TnH9gzAjzlwDXkFVwMAmMZmm+p6SPF+kyB8kps6w1ZO4XnbLkInCUM/5Hq6SZbZuCN/xBzspbDOKR8gZPY9L3p1WsRg+tt8F58HtLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342693; c=relaxed/simple;
	bh=uAkjA+eBQaWAXEy4QZR19DGlmvVQcDfOqZbzMFcB/j8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=epZ8URaWFr4L9M8YvS+1CrAkovTW81dKt7rx69ZagcLEnUuHCgviKs8O1d/PP7w4BqpOzSln/GF5dogtBbPxBxiiuJWUe1faoP4wYE4FBL6wfTLfc9LniThopaSJaHJtWxnZai4BxxiFqfybD08FhGvHpJtC0N5Xv+zbxYTEGxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3DE1F00A3D;
	Wed, 29 Jul 2026 16:31:28 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: daire.mcnamara@microchip.com, Ali Tariq <alitariq45892@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, minda.chen@starfivetech.com, 
 conor.dooley@microchip.com, mason.huo@starfivetech.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260723140434.675512-1-alitariq45892@gmail.com>
References: <20260723140434.675512-1-alitariq45892@gmail.com>
Subject: Re: [PATCH v3 0/2] PCI: plda: Fix IRQ teardown and error-path
 resource leaks
Message-Id: <178534268823.893302.6699748097504009093.b4-ty@b4>
Date: Wed, 29 Jul 2026 18:31:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 23 Jul 2026 19:04:32 +0500, Ali Tariq wrote:
> This series fixes two related IRQ-handling bugs in the PLDA PCIe
> driver, both originally found by automated review from sashiko-bot
> during work on an earlier, unrelated patch.
> 
> Patch 1 fixes a use-after-free: plda_pcie_irq_domain_deinit() removed
> pcie->event_domain while devm-managed event IRQs requested from that
> domain still had their free_irq() deferred by devres, so the deferred
> cleanup could dereference an already-freed domain. It also hardens
> the function so it is safe to call from partially-initialized state
> (guards IRQ fields against being 0, and disposes of IRQ mappings
> before their domains are torn down).
> 
> [...]

Applied, thanks!

[1/2] PCI: plda: Fix use-after-free of event IRQs during teardown
      commit: 26b73bae01d6eb81a4a38f36101812f20b2639de

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


