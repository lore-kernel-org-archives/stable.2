Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A847C41A79D;
	Mon, 27 Jul 2026 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158679; cv=none; b=mPaeVW05lm/njvy5Ru3HR21w3jxzOAnC0wNojS7oXAdb6gP0wdCR+2+QRzybCLEMtq8J6DpFTvK8WJ736MEWA6tEyCL4Q+H1lYYtpLm0XSjdU0dIlaaxUuxRkiuNQ5PJChjONkayQ5N28YQIiVirlyWLmMsnZYsi+up/TBJNYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158679; c=relaxed/simple;
	bh=tstkdTqzQ1U1ryk/rWMRalAc6TfPVElTNK+bjK/2WFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVLDUwjY8NR7udLYAPZl7gCHX3r7esc44aaIFjDlKIzxojdqJNE9zZyI+Qmir3fDWTOqr7iTb8MF0IU7MyuLQvNndCwUsLYwybWRf36MlFvror/wprDpRNBLwJjKdG5f1CUvvYj0Wrf6R15zfJdvNd1kh8lyEP29Qo9KSnwQA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET5+2F9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET5+2F9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD11F00A3F;
	Mon, 27 Jul 2026 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158678;
	bh=9jHAEifZrj6ftwXkMYiczDvhxJELIXSkIsKCleMkp/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ET5+2F9oaEjAd4fnFIl23g+H73ABrDJKfsTceaKSTn10btVjBbqxw40QlEI03ReJx
	 lGLXcwY6ak47UFTlzj4WBD0B7gis5mPdk7h8ClkJc2oifO3lNozAo7glvCjMqnWlu6
	 SEFfwnQh9rQr2vOZl2+eqDLsRwtVy2OxWoaUStaWUPbpoLVKaxA8Ooq/JLndZqiZub
	 svN2SsWSeQgl32cCBrPt7h4i9UPyJ/Jo9/tZEJdsiPkYR1V3umDpg4tEGmNzeL7kOV
	 lzF7Fx3TKU+AgV+/IdH/DGmB1UHJlR3FGDLGoPqYiZ9/ZoDEbq3qDOM9o02DFfUobY
	 kqMxjKP1U2pZQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 08/10] EDAC/altera: Skip ECC memory init if already initialized
Date: Mon, 27 Jul 2026 08:24:14 -0500
Message-ID: <20260727132416.807230-9-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260727132416.807230-1-dinguyen@kernel.org>
References: <20260727132416.807230-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

altr_init_memory_port() unconditionally triggered the HW memory-init
block, which clears the entire memory and ECC data. On a re-probe (e.g.
a probe deferred via -EPROBE_DEFER that only succeeds after the
protected peripheral is active, or a rebind) this would wipe live
peripheral memory. Skip the destructive init when the INITCOMPLETE
status bit is already set, so it runs only once.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 1166fde93d5b ("EDAC, altera: Add Arria10 ECC memory init functions")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8d2adc9c39ac..5087aa5ae5612 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -930,6 +930,18 @@ static int __maybe_unused altr_init_memory_port(void __iomem *ioaddr, int port)
 		clear_mask = ALTR_A10_ECC_ERRPENA_MASK;
 	}
 
+	/*
+	 * The HW init block clears the entire memory and ECC data, so only
+	 * run it once. If initialization already completed (e.g. on an
+	 * earlier probe or in the bootloader), skip it so a re-probe caused
+	 * by deferred probing or a rebind does not wipe an active peripheral.
+	 */
+	if (ecc_test_bits(stat_mask, (ioaddr + ALTR_A10_ECC_INITSTAT_OFST))) {
+		/* Clear any pending ECC interrupts */
+		writel(clear_mask, (ioaddr + ALTR_A10_ECC_INTSTAT_OFST));
+		return 0;
+	}
+
 	ecc_set_bits(init_mask, (ioaddr + ALTR_A10_ECC_CTRL_OFST));
 	while (limit--) {
 		if (ecc_test_bits(stat_mask,
-- 
2.42.0.411.g813d9a9188

