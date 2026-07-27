Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219933DEFFA
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139340; cv=none; b=RYElGHQL1CoEh4NXK1rMhlDvlPhbx3q0LSG+KXuXsxfGeBtX4bNr/U+XyjmjdBcJc6Upz+5m/dSk3erLFF1KH2LZLz24gTiRkwaWhHrrCfpfX3BqAb+qow22lzIwTyqq2XefR6kVhDBNR7o065smvZzajukBDWBwUW527O7cy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139340; c=relaxed/simple;
	bh=pGRRkLOovQKXGIVL46U0Bymbr48B32n4icpDQJ4H2Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4pUNbx9EWnewaNfccC7/YjAsUp5WGSb1c9XxWBvSMOrrmOFAfbVX4lWancj+iVTQlmsYCD7eU5YuyY8LafWt998FfR+WI32MqKPwv6oK0Y5vzhTeZQSkoIvBoQgU3VFVqaWc7GQKdJ/dnZQxyT3NAOop/nJeAJh0cBYhqP3q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX2b36h+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX2b36h+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2341463a12.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785139338; x=1785744138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaLoWGkEcB7GzSZ0TXQ17OSV0J1XYO8dorJLUXwgL5k=;
        b=kX2b36h+EDxNVOu2jAubOtSeBlpSXMI226b3MRICXr5GlztshI3vwa6ci6I+TdaZ7F
         Q3Lfi0pklkQePGPnPnK5pv33oK4ZhhAb2UgGrbPBVwqugPiCNj9dtoHVDHBwEC4sufxO
         Ln/3c0XKXo2elN43qe9ff1vpYvnSkw+uRS07ZokkucH63Gp8+IonYXyICPsBNfSgPGWi
         CQcjm9oMPEMrp4XoDAX2JOw5jIF4RYpy/fcNntmZVhJHK/Zf+F+DcW1IKoB24zu89PkP
         31yfn7QlpiCjYiycipzSdnZwdmn+BdMQEz6wnr59eIutIJUFpP64OUXmSAGn4d789oPB
         kjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785139338; x=1785744138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaLoWGkEcB7GzSZ0TXQ17OSV0J1XYO8dorJLUXwgL5k=;
        b=N4e9Iq7/H5ovOPvSPlhsRNG+GThdRN3YovLdNIXIzYQuNbyz7QFBxq6Tes3zAgwIO/
         Du6dZ+lcHcZ/dObFQWKLy4yYFLFmRUDGFnAuHKKtAOhW7AAXq3AtHP7C8YA7l97IjDha
         8IxVsDaVp6gsT/QFYQBVxdZAnmInPqUlC8fqEcPq1KY8eSRLxA0/6FsmXXrHNQUweA5f
         ZWGPVcJVZhWnSdpCRB5FhMxpVtEacSpkfTRbHnJ1p+qYGESJeW8HgO9hxhB47VCYTrFn
         lO3WfiVIRd21NvxQ7tLeRNPSvKbJZ3ROn8QGJCEjm96XIIDDt6iqdZGES4iAGhFBmCbn
         ikRg==
X-Forwarded-Encrypted: i=1; AHgh+Rok43rn+484/HU10Blep0MDJkK1/rAw/ysh52CKGK58dCtIgx8UPXVl3tVWqCWUmjm3CV9pJSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yQjrSJFrb0sBPnATB0IdthrfHAKH4EZTZQuGNkDX9ND/9HJG
	dO/MlE6/I99x7Zp81tfvr0NQdkDXQjO8YCI61IOhuQ2WCLe8rPMxRvOt
X-Gm-Gg: AR+sD13jI+A5BAKClorcBhAIU16Bq6jhSaz2A1CCaPb7X+aYoMniJszupMaWvfoVaBL
	lAFO1QVbxRsYZHRKjbx8tra/xl/qIbYvyxX/Jnq16JXV6KTl2PIVNSZQXoQUzp/YvEDX98sZHG3
	swaddYRPE8H4gjsiQBrupK2DRfYmYeR+Admk8g3SeRxCzkTbz8zCzFTM1eaZie/WZfv7fsyRtHn
	+x1UG367Z9j/UZAGV2YVMq7zAQXcCsVwGkjPKCavAQiaZTMsEqkY6hWV+HvTgzO6aKlXCuOA84a
	fWeORKRvgss7OVUkHLfLfxDzT+JMAr/H5LJ3b67Zwie4mUMEoFlVZ3SUYSBRqqeuHBkTFwAtf0p
	LBT1JyidcNmFaiEpAmHmIgi3x7apjO1J8okZDH9VI364dYOeaWibX1hXdJe8PY2OTDDPLfAQUwj
	+qk6Zl0F+UMxa0bLKuJXQk6I5JzC1hJCeO7WyFVHzAv4Kxsn9uGhGhzFOBbgJ7YdjNtNJA5v08J
	pJAjDiXEdYJnNUFPN8fES2cFLLT3QID
X-Received: by 2002:a05:6a21:139a:b0:3bd:3591:2457 with SMTP id adf61e73a8af0-3c67dab46a2mr7637709637.4.1785139338288;
        Mon, 27 Jul 2026 01:02:18 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb6623294sm2814443a12.10.2026.07.27.01.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:02:17 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpio: pca953x: fix cache_only and IRQ state on restore_context() failure
Date: Mon, 27 Jul 2026 15:02:05 +0700
Message-ID: <20260727080205.16353-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

When pca953x_restore_context() fails, cache_only is left disabled and
the IRQ left enabled, even though register synchronization may not have
completed successfully. Restore cache_only and disable the IRQ again on
failure, matching the state set by pca953x_save_context().

Fixes: ec5bde62019b ("gpio: pca953x: Split pca953x_restore_context() and pca953x_save_context()")
Fixes: 3e38f946062b ("gpio: pca953x: fix IRQ storm on system wake up")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add Fixes tag and Cc: stable (Bart).
 - Add Reviewed-by tag from Linus Walleij.
 - Update the patch subject to better reflect the patch content.

 drivers/gpio/gpio-pca953x.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f6b870b7b352..0c94630f3160 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1369,9 +1369,20 @@ static int pca953x_restore_context(struct pca953x_chip *chip)
 	regcache_mark_dirty(chip->regmap);
 	ret = pca953x_regcache_sync(chip);
 	if (ret)
-		return ret;
+		goto err;
+
+	ret = regcache_sync(chip->regmap);
+	if (ret)
+		goto err;
+
+	return 0;
 
-	return regcache_sync(chip->regmap);
+err:
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
+	regcache_cache_only(chip->regmap, true);
+
+	return ret;
 }
 
 static void pca953x_save_context(struct pca953x_chip *chip)
-- 
2.43.0

