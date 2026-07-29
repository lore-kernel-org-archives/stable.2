Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754504963CE;
	Wed, 29 Jul 2026 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343009; cv=none; b=LJvVcCjO8DQzlN6PTj4cl7JBkEP0TA6Ort4+RqBkSNTBH6hA2Jm9yLKa+WgY8gJcZ3u3X7lWL7BHTW/5G6l3P37iwoJuXOoe8e1h/KEv9z0WQD6nIprhThq9whL2uQUFIJvE/Xuhwwe1Z3Pyilc4Pnr19oW1wS1qdkD1+ck/bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343009; c=relaxed/simple;
	bh=qbwUmTtQQAo+r+AZ6TlxX5JIp3afhoitH9aDDbBuYUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FnfSCHc3Kc7LGwDfdA1kDNsgKZxu9JyKdXR9g3ereGFwU72mlPGWy3/qysqGluicsX1FeuTyZ4in8+igqKfXuNvZefgVR4/EV3ZeREaiFwY/PgPXtlWoy8pTlatHtdKyyKzBrvqDSjNMU9Zp1+X5l1EVFV7hRoQjhqMaJV94PgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D121F000E9;
	Wed, 29 Jul 2026 16:36:41 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: daire.mcnamara@microchip.com, Ali Tariq <alitariq45892@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, minda.chen@starfivetech.com, 
 conor.dooley@microchip.com, mason.huo@starfivetech.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260723142824.726655-1-alitariq45892@gmail.com>
References: <20260723142824.726655-1-alitariq45892@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: plda: Fix resource leaks on error paths in
 plda_init_interrupts()
Message-Id: <178534300125.893922.4864961261902881699.b4-ty@b4>
Date: Wed, 29 Jul 2026 18:36:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 23 Jul 2026 19:28:24 +0500, Ali Tariq wrote:
> plda_init_interrupts() initializes IRQ domains and creates IRQ mapping but
> does not unwind them when later step fails.
> 
> If platform_get_irq() or either irq_create_mapping() fails
> in plda_init_interrupts(), the domains are never deinitialized. If
> irq_create_mapping() fails, port->intx_irq stays initialized.
> 
> [...]

Applied, thanks!

[2/2] PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()
      commit: 19a30bbb6477bfd7e3109b7a2943e6597ee9de37

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


