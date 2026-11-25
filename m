Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625063;
	b=fVaR4Ctf1PMtiLwRbOlTLqDyYK6xzZSTPZnfFf+gGNKHiqINVIeKTJOzfINVEjJbSB6j
	 X91SRqwB/KnaJpyqrqPvhOifhSKzW4aCjhXagOpkeRs3L2K/NQIfEQwcWn4nzLyPQxw0f
	 l4C0Or6iNXffMk4lSnkvorL6PwVc5n2jSBP7YNHQ1koEoueoNhMKrkByNcizbyW3/aVl2
	 GeIeSRf+JYKKuv7wBfwTJ0tnY+ovICIZ3d0fcmAe++ZoyTi4f8b2orCjPY5VZZogKjVur
	 rbIGgoKdB2g3MOAx0htOqH4UfQcADhzJiY3ahsVWBpR5E/1WF9zOoAQKODxC8fdyGmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625063;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Ufc5X5KPtSpN7LAkgIoRBGIIkQWdxqKwSyFbcVYvUyw=;
	b=xmdLQwUIxOVGCY4nh86rV7pIdbrhQTDbGSvll21ChgKs4enaMHp6yHxMj9e02xyOF3Cq
	 OXuH+nqaCiHBzVoVyYbyIyH9sc4dhH86tqK7KpR70/hsyeBHa2RMOHyBVNlmSfViqL8nl
	 vkOjl1hZ4+luDNBtn/Jlk+BYhLZQ+K0WylSNzWhAQm9svLKN/x4cANHXFpHQXRru+hJN1
	 ymcAPx0gr1+N+yB2JBphlvLvNIxhz10I4mcGpGtaCFx1L3Hxmfk1uzc6WoYQ3xh0aUykQ
	 3IFh3cgW0PFOmJ+pbNO8b4spBQnvLAfdlOpehSo4hnWiLpQxQVfs8td5UD7e+8GXg7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15565606A329;
	Wed, 25 Nov 2026 16:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72C71F01562;
	Wed, 25 Nov 2026 16:44:17 +0000 (UTC)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 04/14] PCI: rzg3s-host: Create the INTx IRQ domain
 before setting the chained handlers
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de, 
 geert+renesas@glider.be, magnus.damm@gmail.com, claudiu.beznea@tuxon.dev, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
In-Reply-To: <20261019065025.2146539-5-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-5-claudiu.beznea@kernel.org>
Date: Wed, 25 Nov 2026 22:14:13 +0530
Message-Id: <179562505368.5580.2150497706749194750.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=663;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=aXar4x2N8gQJTl/ZNKcihlhafecP6Nche80dL3tuzYA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBxBgJ5tVOCEmi1KWNu7mCRxmFtmxilxnXuP9L
 kBY8bO0SzqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcQYAAKCRBVnxHm/pHO
 9bbCB/4k9mZGKX6nhG0HCgb5ZCAGgrQy8JHmafqY14GtFQ+LkXDlSF4MW1BRMoBjZGAPUjrxfJL
 9gllCDF6w3rsFb0nD46Xkx1isl1vNuUNtaNjpk7eqEDspLzWKLxPEivM/G7twbNdH5nSmJfSRve
 FfG8Pf+4AVfL3JX640uFaclAFAtDs2KlCGXRq/1rdKbkyi3VBfXxgMQlAuQcWN9EZaSuraudvbo
 N7J5VnxNMBRQTgmrZPO5Li53OTZDSc8JDB3G+8fGZo0SDo4651ka30ZdHySqtRJkel+vsn0p6XF
 F53Hg2YEVZ5m8XGPWoR+/KZPiCPO72f0uuFvkeL0VNAgbRYa
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-19 09:50 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> rzg3s_pcie_init_irqdomain() installs the chained INTx handlers before
> creating the INTx IRQ domain. irq_set_chained_handler_and_data() also
> enables the interrupt, so an INTx interrupt arriving in between is
> handled by rzg3s_pcie_intx_irq_handler() while host->intx_domain is
> still NULL, leading to a NULL pointer dereference.
> 

Did you observe the NULL ptr dereference on the device or just figuring it out
from the code? If you have seen it, please include the log, otherwise just state
it that it could be possible.

- Mani


