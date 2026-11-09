Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183664;
	b=OpHSqMvpWZ3AW549xUvtAL8nKSt6HfEhY69gz6Ub3UvRnrJTferVKaSR2OO+l06Gm+uD
	 GBU6b2VRGE7jbcU7ATPuGgoZJ6qOmQGuf9mIRDFz6LOEeVzGtrAt7aq4Ox2ohYBsZqiy7
	 ruSVB1l4AER2xkgrP8vFmS6o8ADPGUb4uJaxStcwBuColmqTZeWSF0CUdeFT3HOtrPwP8
	 ME7osrc2L/54A200fYmlB/jqtK0sDlGDTnHosLIf4kVQeAeAPGZjgcNuawH6VtjyyxVDr
	 AEWAVvnhZYLLCpPu6vmwqo+fg5TOVbsPkHM3q+KZI0dhmiFxR2eWMCLub6GMQlgcLIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=GeBJObAnqhNEGePn+mfWF29BOCD0obOgEYIt4FeXOvI=;
	b=ab2gUcLBpMkDvayqW2dGHne8iJ5Z8kazlOOO0llDiv/ihHq+viHT/XGPmBs67qMpo0Ka
	 KazMSScP5vjIr+qvv/DQLpWHXpikrGe3ddpq91RS/lJYFf5kl4QYcv2tT5qC1jtwzSfwi
	 qXXyDA77gyE5P6pDjKCbq3TVzGgseNc0HEe4//7rY4X7xKPakRG2ehI4keQIm+Tp/wNle
	 O4wJgWGtPdCiFP+jJW6jCFDEmFmB5A5AIRPyMyITUKeoAgKucKfxkUfxg6P/nGnOre0fv
	 +xCeQRxNChpnXC+DkGwkRAU1uKdfgD8HwHOfWHXotXo2oKSzue2xSKzmdC+QZS2Vahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TErODvE9;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33910606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 00:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33910606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TErODvE9
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-716b58a4365so154560eaf.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794183663; x=1794788463; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GeBJObAnqhNEGePn+mfWF29BOCD0obOgEYIt4FeXOvI=;
        b=TErODvE91a25YyxDD4pdTWA6d1isfYiXbLBk6ESYrVvMnDhz3kygoaubhfo5QoZhEa
         wAEtB7/53EqglPpfHHc6UEuQpftxO7KuqfuiTHtPYPeC3melo46Xs3kpiuWmKb+ytONL
         8q+m12f4Tw8F2ybBNidO54nIO3uneGqUH5oeEKPPhGQBGba4mVIbL8Yvg/1qjvCAy3A5
         eDSAAh2sCA3o5R5/bz2+g0MUMsV0AfHItrRcCiTgr2NT5ELJkb0kEUGvROyIe7fSzJO6
         EkT/IgQa0i4e1Rdrbfgm/U7TVkDGPaBmP4ZulFdnMCuBK7DW6NJH2DDeampXXEOQfKBv
         oByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794183663; x=1794788463;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GeBJObAnqhNEGePn+mfWF29BOCD0obOgEYIt4FeXOvI=;
        b=tFsJ4z0tWJlv1WU/YRs6BsQrFmbddDkfw1X9L2Y5pyCPWEg2Dmsf8G70HREs5bZhUM
         Ik2pRbF2NAzms+KNaBHMrU1jNQD3ggVp33GF3kM2dJIzEPIH3pBb8UUESeJtol3magVm
         ZMQ3wTiTd0xoGZbtYy72JwbCeRbcgyP8sQsoWj36YHlsheKHZtXyGk40kGrDbNh4ijdV
         40k66NgFgDI9WWYEip9st3Hho4XdSMXmj6DitcIRP/TpCvUc1V8JtkmZLfIkqY0bX3c0
         KOYP2QP74ZhePHSUJsB5EdgE1kcFna5rTGi6lB+/+TZ7EXA0H7Pxddcb9uqZ7H0T1xUC
         wUKw==
X-Forwarded-Encrypted: i=1; AL+hErFCkv14GwPViSEgDXpgpQt2yhWCXwwpX+U6o9QreEZ7L9w0y2SPQKnIV0n3Pune8pYysV29o9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IGqcwWL6Ji38BnR8r+ZzO94B7gQd+PQEfC5jle0eMtDrKtbdt
	KpltLgigYiKaRkjhaBNiyrlCoy5WBJtX+TO+2eXSttKFPRES8ewLQUr3
X-Gm-Gg: AYBFou1JbhWMMZpfZRPAzhibVCxKXNg+opaz2aSQNvU7/zsjrKdCHStIhwofba52f7b
	t/jkwWpXr0/s4+YqgM0vrskSQPIuYBHCVLHGQ61cJV6XF4Ub05yQA2zHnvoT0nZx1HVtA+Tn1DI
	L/fP4Pc2MWJg3inF9VkASs1j95mXJOMbsPdJkmsLZPC6kuzpywZitxiNch913R6c8GckXb0pZrZ
	t9AwoXhscpa3AeaNprN+ltwASf3V8tAlnrpcveau/E4CqtMdklh254RJ3iKazZLTyWJbfse7l4X
	mHynT91I+bctpksUxn/LHQu/nbiSPorpI+ILwxoCz0imPu/Bf609cUjZFoKYpUvvomg/PpK1qDY
	6Arzz0mrveSGzya/LhmNwkJc6sEToqhRPLnX3Bhn9KCovRTK8Kol+2UTHe+IBys4y8bi39zohSz
	KnuxBEPWKIKorjmc/GMm+9uGO71MGcDAhNQRS7qip7dZJDhE7HOVh9IHdDaJL1E+Ubh+7sZibhG
	7BUTNQaEjZiMkCysWUe8lV17X9KuelNd23YLSgn3zGi4SBrEuiTIIzrDT1Vt+uFihcMiqORA5e0
	Gudpy1MJfyZ4kPrHyu2TXqcsN2/sC8ZggAL0esjmBg/dMJEtimCTPczB+HXvEQA8tz/er45aEik
	YJDdIBg+HUH4mD18k7U6L4yM+ggINGuDim+w9DDz/ADIGavKZhrKqlTHsFHZJytwoZrbOTuG1Pa
	jErjIqvgJTzInh9Mdnl4gpQ3p3bBrrWVIXX/dF022c3sOzFC+dsPlEfwfnHtWPqAL10JsMN3XR
X-Received: by 2002:a05:6820:1356:b0:6de:aeea:5c89 with SMTP id 006d021491bc7-7170f2b53ccmr1343158eaf.23.1794183663143;
        Sun, 08 Nov 2026 16:21:03 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8cbcb9sm2219207eaf.6.2026.11.08.16.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:21:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 17:20:55 -0700
Subject: [PATCH] mtd: rawnand: r852: disable the engine when card
 registration fails
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
Message-Id: <20261108-submit-r852-registration-unwind-v1-v1-1-e54be2c652c2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QqDMAxFf0XyvLBW1in7lbGHtkbNwGyk1Qniv
 69uL4Fzufdkg0TKlOBWbaC0cOKXFLCnCuLoZSDkrjDUpr5aa1pMc5g4o7auRqWBU1afywhn+bB
 0uFh0sYnUX4LzjYEieiv1vP6e3B9/LpYnxXyYj0bwiTColzge0ZS7s3gph9YM+/4F+PqjvqYAA
 AA=
X-Change-ID: 20261108-submit-r852-registration-unwind-v1-5c7cef4b5a70
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

r852_register_nand_device() enables the NAND engine before scanning and
registering the card. If sm_register_device() or device_create_file()
fails, the error path leaves the engine enabled while card_registered
remains clear.

A subsequent removal work item sees no registered card and skips
unregistration. The device removal path also returns immediately from
r852_unregister_nand_device() in this state, so neither path disables
the engine.

Disable the engine in the common registration-failure path after any
required NAND cleanup.

Fixes: 67e054e91924 ("mtd: nand: Add driver for Ricoh xD/SmartMedia reader")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-204169@kernel.org/
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/r852.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index 92c47d351c27..073f96f73be3 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -656,6 +656,7 @@ static int r852_register_nand_device(struct r852_device *dev)
 	WARN_ON(mtd_device_unregister(nand_to_mtd(dev->chip)));
 	nand_cleanup(dev->chip);
 error1:
+	r852_engine_disable(dev);
 	/* Force card redetect */
 	dev->card_detected = 0;
 	return -1;

---
base-commit: 30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85
change-id: 20261108-submit-r852-registration-unwind-v1-5c7cef4b5a70

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

