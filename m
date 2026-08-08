Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D72E762C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786171040; cv=none; b=FTza4W8z90mvXNwzotCRfWaT3fkTECJZlnSN6ZE34czgSKiltbFxC1UUqCwzQaakT2pnFWPnjizkRg+IRkixYnugBzpoYeULyOb7RUKl+2zfIH3Br7keYTO22z/+P82yjdsC57y4ePs4im4QaKsQAAaGplwRHEsn5c0YgoFPUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786171040; c=relaxed/simple;
	bh=3ebgjBAUsHDL5aSLBAEDQetZe1n1aC6xwo33fb9arHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7uNr7E37kCUoOlnNwwpNjr7CtjTLzFRaiEHu2T5t9p1rYgDHw1v/0YDal0S7D64RwHCQqfpQ3pz9h0yrHdAg9PGVOIa+WJyB71HkG8abAoMj7YPLC+1/5kK05+G4dCNccAiwa8gEzkvUbUtPRUR5KWFAoHDqjkKNecmksGrFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Gy6oOG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Gy6oOG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so167882a91.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786171039; x=1786775839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q983uYDsq4Xe9yOLC9LdYCCWYqVj2QLw2dxzgl89ls8=;
        b=O8Gy6oOGgY1SHFJWgAB7Pgoup9HuUKPdg/W/0Nf00/+iBsnhKWxFobbEIcuXD5pppX
         HfNSbYBV8OzGXleqnXfQFExLCW9eeYhfQG0B2zd3mKasTIaP3zBL/4OqIUPCRpkvAPGF
         knUtgdMWUvE49IxtID8lKemm50dlSEOiPRqZ2b93vvrlIFO9DEdJ0MLi5sYciH2vStGN
         aRuvB4L/n6rN7USzWognpo9ey0Dt+IfOGOqwW6RK2xfLtD1MtIw4mQb9SISYtNPSbPDH
         CZtwf+qtjZCn/aszvd3RQoPIGyhACbJaUROBDjrb7q1JozfcvKZKiXToSv0GVaTlXJFs
         2BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786171039; x=1786775839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q983uYDsq4Xe9yOLC9LdYCCWYqVj2QLw2dxzgl89ls8=;
        b=W45TMXN1sYMt5sHg/o1MMB9NmbLrKhrYl/iCvxmoMl5VX/5+BaLeedTEie5FQG38ls
         /Gg7Ye9FcPH+gt/1Zpx4ByFhLpRKItLu74a7vHqQuUcxNcKPLJuf0XHupH36KVZPz/Ra
         mvWL2rKv/5k+RyIraZiu7I0fBna+PRwxzhFUisgFYiFOzlrqSltaBELE0xwHioQ2UEu0
         lrZMnrGwucwuK+ClCGHGN9NqmvZ2gJIFlrlA/jyvlU/MihBqKC36Xp2jhLzhGOcIC0Y8
         x05dj1whgea8FnxHE1Va2lLkHqerxARq1IFCv0HUcCnnmoxyIVGJidY+1ttz0ASRW6gt
         ovzw==
X-Gm-Message-State: AOJu0Yx6Krge9lJHO03MiWfWQshCI5OADOZs9S3u5CPql578jTcF43k9
	j+GVqw/ckezDboLRV5CysFWtO82F2tcS/7L7LckzQ0IIDw2lMaKOz1Vy5WGbMwZFod4=
X-Gm-Gg: AR+sD132VLbag1HhbSFOSxuMn0clK+RP9O8FxM2td9OZ+6CncLNYAgRKl5wKBPQ6HC0
	IBqClTj1Va2teG9fQlZPqq+inv5YXNqZTjGLTNnwuia0PTq/O8frymg4/NGwwwPYCDyyrTlGTiU
	9MTDnLtBvCuuMq3ttOv48k7urcT8X45kB72jZ/+wSlKt80bsPjN55n+hnfrusoBcxwUEwYPcVyG
	HvjbbKs4mRmZiEmFwIvsJravNWgjfk2d/UmGgJw0MsxIfNY6V9BJKTbFiSA2aqS347hyJ1a9yj2
	/GdIHKJGQjrUXrK4sA2zpgnCKlwjWhOZ7sKb7059IH7FAJrFx2K3bvx4QlzlHPMOAa2yI7AGfLY
	aMZJrEuU3tFlSH6CYbxsneUgQ/nml40xvFbaelCk1PCBYGtROWru9ejc8xpocpqN12fBdAXSTAd
	zZ3UFrmKrctpXHsWENAOlGI1P7PO41AlF9zooTaR7H6yM=
X-Received: by 2002:a17:90b:3b4a:b0:38f:23d6:b4ad with SMTP id 98e67ed59e1d1-3909d8172edmr13381640a91.8.1786171038869;
        Fri, 07 Aug 2026 23:37:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95c40sm5015659a91.8.2026.08.07.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:37:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] hwrng: atmel: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 14:34:58 +0800
Message-ID: <20260808063458.2609136-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_trng_probe() calls pm_runtime_use_autosuspend(), but neither the
probe failure path nor atmel_trng_remove() calls the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and remove paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: c4f51eab6ce0 ("hwrng: atmel - add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/char/hw_random/atmel-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 4ebbc44fecf0..6265d9a8d140 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -150,6 +150,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
 
 	ret = devm_hwrng_register(&pdev->dev, &trng->rng);
 	if (ret) {
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
 #ifndef CONFIG_PM
@@ -165,6 +166,7 @@ static void atmel_trng_remove(struct platform_device *pdev)
 	struct atmel_trng *trng = platform_get_drvdata(pdev);
 
 	atmel_trng_cleanup(trng);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 }
-- 
2.43.0

