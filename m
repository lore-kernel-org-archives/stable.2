Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492A4DA550;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001772; cv=none; b=eW2My9OqaLqxLVtR3asKJ5wYC+zm9GeWn9PmHFbEM4/QjTJl/bSxcrYQWpz+IIrb5VzTRPrr75oO67vZKjhnw8ljamQX/EP85ixM6oRR1O06pDMabyxiepyR2cA2hHUjhtN/TyyS9xQEEI5fBeqPLP4YvkbqgL3hTvYIxkmGPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001772; c=relaxed/simple;
	bh=rt+hTQljtmTKZB3seaFCTOOiXTvilEYPyHN5EZGxnKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1vjkY0cYGm8oBd4Of8XkkC6jkUhrA5g6rXywHQgJfl3N1Gm1lmhY+8PFJpx/k3LngS2ueUSo9m25NNxyS7Hmi/tHyBGkepjPsm4j/zxC6Eeq22rt8VU/PimJdpZ/phY4i2p7pb4lR/vCeZOYzbyzwwCKyazJnlAPJBUZ4hPEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWq9ghV9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWq9ghV9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0751F00A3E;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=MhBTAqbX+6ddORWh3uOqJPTx4/35gVXV/hnc5cvGL/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IWq9ghV9ePdP6Jv1QTUqpDdm/5QFTr7+Be5rrPQUiptDgFHFD9Gl9PR9JhKsdnoyT
	 tzfxxQHEVO3WAqvmaeswEZjQgnjX7+4/+I5ulGvR2dw0CekZ83mIrdtxtoncdXkz3/
	 CFmpmBuDRvmbpfPZNTQ/tBS0p9QGkYKBqmW03QwEBzWTswsjH7iL0IvZUbHRxLQZdI
	 svZHG1tIRsiEPOyc4zMM1OGqzUoc4quVUzIQx3KOUaPDk37MvEvrnhn2oZKCvDtpNp
	 bnT1HxvVeVJuVAzMyInZOfqMta4HF3CbkxZO/ngoUDhXx+roSdST9tEsgIuANrHbqN
	 pywL2OgZVBRNQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000Nea-2lTM;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] USB: gadget: fsl-udc: fix device name leak on probe failure
Date: Thu,  2 Jul 2026 16:15:33 +0200
Message-ID: <20260702141536.90887-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702141536.90887-1-johan@kernel.org>
References: <20260702141536.90887-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gadget device name is set by UDC core when registering the gadget
and must not be set before to avoid leaking the name in intermediate
error paths (e.g. on dma pool creation failure).

Fixes: eab35c4e6d95 ("usb: gadget: fsl_udc_core: let udc-core manage gadget->dev")
Cc: stable@vger.kernel.org	# 3.10
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 600ce8cc0fef..8c5b2f42ff44 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2474,7 +2474,6 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->gadget.name = driver_name;
 
 	/* Setup gadget.dev and register with kernel */
-	dev_set_name(&udc_controller->gadget.dev, "gadget");
 	udc_controller->gadget.dev.of_node = pdev->dev.of_node;
 
 	if (!IS_ERR_OR_NULL(udc_controller->transceiver))
-- 
2.53.0

