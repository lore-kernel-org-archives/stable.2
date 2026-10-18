Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8468392819
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339806; cv=none; b=MeareinVBzdH9Oaz9yvs0qTX5tkUbYbSdgBqagLiMWxU+gmIDTv/w5TxLNWccwybZvpUTs5cHnlG2tlCiykljjb20LPDR2u2hj7PjFEdCU+RIznEhggW5A0ScrUTYlFrMGq1vU10C+xxOr919lWK3cK95RAGOO7f3CpfEgeE310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339806; c=relaxed/simple;
	bh=VQitwW8668axt1jlAMynhfzocbSvfmdtsxX5ALSir2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouLC+Sls2xsE04jGCMHnG7tUhoHC03jDGQfTxyi1iQXPq3b2jotE0awIzx1w25+GS2vEX8noyPIa0dhTaG8hR8343NcSGg9hpOnqJ/iDMFcqEBdZwnHy1glLQTymx0O476HwndHhrAlUZNMwMthHZPVhUNdwpd9eIr0aHir8VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1PVo9xn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1PVo9xn"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so825839a91.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792339804; x=1792944604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRGX2ggnqWrM9pq9wLLTaVpGHvzzAa1T5Vqo2gzWucQ=;
        b=K1PVo9xn06aMOl37Uc+kPUxjdQafE81WvXpzeWNYyRQ6buJRAsxVRo/il6bF6n7771
         Ui6Ab84DwJpflwu+kSm3uYdaMMr4ZORlfsSKiYBaJhrx6FcAcMymiKxQNAVS1+cToVnt
         bVd6wLdMYtUqUOSgaUa2dmqeYVA3zPTUlHnaqMj9kmK/yttG+5Kd3ttr+IsRppAe4ybk
         wY4yNS8ioFxNxMAzMwFF0mS7mcyRIuKnVyVhilE/qnKv3RhSXlhwdEQBKb/ejZmtNuRj
         EpAmZelb5IIre1ztSY1AP2Ar6EsJ7QMFcWBXmIIU3eQGga3y34N4VGSiqj/bkb9vCQPa
         55gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792339804; x=1792944604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRGX2ggnqWrM9pq9wLLTaVpGHvzzAa1T5Vqo2gzWucQ=;
        b=i7MbskDvLRlF5PrwVHH2gx07RFhn2iRw4e4a7AnLgGm63Hl2mQY8IywjEPoB6dNEUr
         G8u45ScEhu2dXsJiqvAbUY+hhsuWQUBLB9rJ5FH2qg3KJ+Bgd+fs/HjtFNP5QE72rrZ2
         EY9LZgP6m+kaKxwSNnNBG76DTFthFBKkUJfH3SkMe3IKT2i3BRhUIEa3mnX+jMZPXaSr
         nwMyfsMgqWz7nNTjT02acrSQNWXgRZ+Oiu+mr5hNGETc9xATxHoZMadGSGCuJir+vLwh
         LBxJZHlINwRb5AL6Zc6NP32spJH6pk7c7i1p/UsxkjiuX8Yn/+w5OyS3HoGqVtR4z5BZ
         g2UA==
X-Forwarded-Encrypted: i=1; AKwUvBxNyImMnTn9t/3hIZeTppZFpcetfXaLualjv+n4jIsZPXvKZ/VyUNMD+op9KjD/JyvrHFj96Cs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuQhkmfn4AkzSnLpv2nl6YtxJgOZlIVZQLgb242sH2pfeSIyYn
	rAiV74zB0+bUzd7wAWIq18+nBeYh5XqjYWTWE75jyHlRKaLnKvJuRGD0
X-Gm-Gg: AYBFou21bjpYk9LOOTgpjtZ+vqvPC+q6rChT+yUDSa0eBULJkT8B4ge/HDV2q0R4XQ0
	QFcoSzuKdPQfbBUnS/4OxhDmUwdwVZQk1JghtH8lLfkg7uYTbP/m3MI33yftxVtrfBD3uIciME8
	lrUZEzkRKS5rjmY2VbYm/S1YBPptpXAkylitljIH9Qgkhesf5HnvOp10+J2N/zok6XlcBwvHojV
	4HXXLVJjyuJEfbcMwUC2gRUbBZXNg/zSErF4FYArFLpGIv/udtRupx06CyoTHq5+ltC3piuwSdK
	w0qlIT+54Z52AycgNFVp87AqTc5iCLenFdyC1D/afrK6gdRNlcDgHeg45oc8XS9A1XngcasMCJJ
	htTk/qmxaVMP/KkmBZvvtgR8FFvLv2dtDdwt4Y6KygpWcKTeL6DYjgE6YxN3YavsewNC44zF8/7
	o4RVkl4hkDjbal9hgm7ppF/nejT1Q4AK7ZWmg8hqUq1vQoyCLyiYykqdvk3da85RZzp8ky8Ux+6
	tTCnad1xjDVrs2KT7KOo94o0f3Jc/ouJCY7K7xRYXBNJk67JA==
X-Received: by 2002:a17:90b:6cd:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3aceefbd2fbmr2879731a91.11.1792339804188;
        Sun, 18 Oct 2026 09:10:04 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm12140533a91.9.2026.10.18.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:10:03 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure
Date: Sun, 18 Oct 2026 21:40:42 +0530
Message-ID: <20261018161042.3298045-1-sahaj123.sc@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pca953x_irq_set_wake() updates wakeup_path before asking the parent
IRQ controller to change its wake state. If irq_set_irq_wake() fails,
the IRQ core rolls back its wake state but the driver's counter remains
changed.

A failed enable can therefore leave the expander marked as part of the
wakeup path when no child IRQ has successfully enabled wakeup. A failed
disable can make the driver stop retaining power even though wakeup is
still enabled. The suspend and resume paths use this counter to decide
whether to disable or enable the regulator.

Update wakeup_path only after the parent operation succeeds, leaving it
unchanged on error.

Fixes: f70fbc15bae2 ("gpio: pca953x: Configure wake-up path when wake-up is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
---
Testing:
- Built the ARM64 kernel with the TI SDK, CONFIG_GPIO_PCA953X_IRQ=y,
  CONFIG_PM_SLEEP=y and CONFIG_SUSPEND=y, containing this fix alone.
- Signed the FIT through the existing development signing workflow.
  U-Boot verified the required signature and RAM-booted the kernel on
  AM642. Confirmed release 7.3.0-rc7-00012-g1b4d5b76f7e9 over SSH, both
  expected expanders bound to pca953x, and an untainted kernel.
- Ran the isolated exact-function harness on an AM642 CPU: seven checks,
  two failures before and none after. The same isolated checks passed
  host ASan and UBSan. This harness simulates kernel and hardware APIs.

The boot test covers boot and probe, not the wake failure path. Neither
expander has IRQs configured in this board's device tree, so the parent
wake failures were exercised only in the simulated harness. The board
was returned to its original signed kernel after the smoke test.

 drivers/gpio/gpio-pca953x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index aac9ea7520b6..869ed4264d48 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -838,13 +838,18 @@ static int pca953x_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	ret = irq_set_irq_wake(chip->client->irq, on);
+	if (ret)
+		return ret;
 
 	if (on)
 		atomic_inc(&chip->wakeup_path);
 	else
 		atomic_dec(&chip->wakeup_path);
 
-	return irq_set_irq_wake(chip->client->irq, on);
+	return 0;
 }
 
 static void pca953x_irq_bus_lock(struct irq_data *d)

base-commit: ac46dac1613a7c971e28e16d3a7a6ad4b1ae6c5a
-- 
2.43.0
