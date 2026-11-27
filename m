Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804623;
	b=mg6I2r9ci9E2zJ6eBRFnv7cLkBKmdDZZePdP9zRx4zZ8JZdtwKYEVFvjed68fhtAOMGl
	 eVDZjTUQ5KCFvBc3tjqZH585BOVHdXWjFM27zhBZEPhrZ6NaWkKufHhqMoian5chLFUaK
	 tvh9VwT1fe8oDiGEpO+89GE9heT2sXi47TokZ49a8fmf2DC5H+6kQOtWQF5Z62SYyOWYS
	 wwv38/W8CscXyQ9qOrcQx8pgDvYE4fnHQXsF+xIuUpV4V+u34oNo1GCsWpLjReLu2douD
	 sSR3IFv7ybUcRUwnjqIH8tgwiRo9vEAzK6gC3uVgzFEzl2lXo7btqEIemYA9cTaSdBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7wNO/2SAjk2HWGew8OVcyB8LY1h3AHDSFTLuG0VTk3Q=;
	b=dJvXAB+O9EQkYzPdQaxmKOs5zTt3vKV6poFydua8S90wQnC57azRFxulgVi43s+8hh1/
	 3dwShiLXTupeUhcwX0XDU8Ov4tas2DzdECuv9K98/nqUPC2zib9/4Y5/m2NH/zNPFPLz7
	 T8P9Lm0Y/2U0e7zOCt9AGoXBbgDdJyzCSUeieWoATOaeNVr2OENk46pAG6B7EwLyRblsE
	 x1u14mGgokDOVvqcGDOevQjut3pemzDlWaLggn7ASuO3WgfZn2L0gKQGxkdRdtyAERRCR
	 M/s3wSAbKvJHt3Ax7Su9BrolaQnT/SKJyOxaqAVLolnfikAU6dmcZ7bsLSPSm8DtFPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnID26PE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E9606A32E;
	Fri, 27 Nov 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnID26PE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5771F0089A;
	Fri, 27 Nov 2026 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804623;
	bh=7wNO/2SAjk2HWGew8OVcyB8LY1h3AHDSFTLuG0VTk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WnID26PE3CPZbfOBOkKR6pAAqV2OIkdg9Aw8BeAmMP/2l0FFYdJ2r2zgDTTeKvn6i
	 X+USlQBmjCIIj9t7lzGvNdaDfZRLJJN4QPQ88JU31/Ops6MGKWzTWYqkaZ6L1m91jR
	 C8h1iIZwiCei4x6QABgEi18GyMuMlTDCBeMx4U81W8gDphtoA2i5gVXxAgA8YInM4J
	 H2ax74k+iB1PGjo3ET9TuWjpzZYF1yAhl6qGOrnRBjqPKeBUjcF6jLCCbXmn83jYp1
	 8dg+INg7ZaaZw0LGB6icVVvWAcmMHIDb6mPARx82kz5ZxK8yFqyIlQS0P503nkUxJ5
	 mbo1O7eq6F3DQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uday Khare <udaykhare77@gmail.com>,
	Jerome Neanne <jneanne@baylibre.com>,
	Mal Nadar <m.nirmaladevi@ltts.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 5/8] regulator: tps6594-regulator: Bind IRQ resources to child platform device
Date: Fri, 27 Nov 2026 18:35:45 +0000
Message-ID: <20261127183624.3341010-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127183624.3341010-1-lee@kernel.org>
References: <20261127183624.3341010-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tps6594_regulator_probe() and tps6594_request_reg_irqs() allocate IRQ
data and request threaded IRQs using devres attached to the parent MFD
device tps->dev, while registering the regulators with &pdev->dev.  If
probe fails partway through or the regulator platform device is unbound,
the regulators are unregistered and freed while the threaded IRQs remain
active with dangling rdev pointers and block subsequent probes.

Attach the devm_kmalloc_objs() allocations and devm_request_threaded_irq()
handlers to &pdev->dev so LIFO devres teardown frees the IRQs before
unregistering the regulators and freeing the IRQ data.

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Closes: https://sashiko.dev/#/bug/linux-5557312d-1058-44ee-a8e4-cb48dab3566f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/tps6594-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 66052753610f..dab4bd6b0282 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -549,7 +549,7 @@ static int tps6594_request_reg_irqs(struct platform_device *pdev,
 		irq_data[*irq_idx].type = irq_type;
 		irq_data[*irq_idx].rdev = rdev;
 
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+		error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						  tps6594_regulator_irq_handler, IRQF_ONESHOT,
 						  irq_type->irq_name, &irq_data[*irq_idx]);
 		if (error) {
@@ -738,7 +738,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 
 	reg_irq_nb = desc->num_irq_types * (desc->num_buck_regs + desc->num_ldo_regs);
 
-	irq_data = devm_kmalloc_objs(tps->dev,
+	irq_data = devm_kmalloc_objs(&pdev->dev,
 				     struct tps6594_regulator_irq_data,
 				     reg_irq_nb);
 	if (!irq_data)
@@ -828,7 +828,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 			return error;
 	}
 
-	irq_ext_reg_data = devm_kmalloc_objs(tps->dev,
+	irq_ext_reg_data = devm_kmalloc_objs(&pdev->dev,
 					     struct tps6594_ext_regulator_irq_data,
 					     desc->num_ext_irqs);
 	if (!irq_ext_reg_data)
@@ -843,7 +843,7 @@ static int tps6594_regulator_probe(struct platform_device *pdev)
 		irq_ext_reg_data[i].dev = tps->dev;
 		irq_ext_reg_data[i].type = irq_type;
 
-		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+		error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						  tps6594_ext_regulator_irq_handler,
 						  IRQF_ONESHOT,
 						  irq_type->irq_name,
-- 
2.56.1.839.g22a8290db9-goog

