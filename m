Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172605;
	b=K21rC7zMw8az5nE7lQmhvO5WyN/tNGImk549d3cS0sA+BVm8rC4iQu4oPQfoiObQk2Yz
	 ZsCMDI3PtvY1F42CWahQ5aECnqpDtPWUK0UzFWnZv06dcIfeklI8TCoMZnmc4WhHLuALX
	 i0PmYr/FU/sA/RtYypvck1bVf8e4Mu9WYisQBMC1KF8BlpvNKk9FGDX1aVEI6a05sKz8W
	 UtboAH4beftmOqIjGsEvxoATB9Ejm7XAiFNc2T+UhPWaP26ic5L0+VyI90OuMUw+wPFns
	 f6O9zfIJxjmTatI0Sv43k6VqlwxKqRcrVfe6k9zKKeZf20x2OlzGYYQw0FQvGvm2OYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
	b=JciqIm9TUpRwm2e9/Xfab0gru6CewUPA0ekBn3/BxXrHa1If4qJpbdFb8yb7VNhqFMtU
	 eWq9vSgyhlwpscp1ECV0l0X8pW98YBVcxuQTjJSXT2bV1e9PtoSFJnxvgx1wky5rY9lfM
	 +d/y3XTErEC5PrGGGtdhLA8hlOt4pT1OqkIJtumBykWmuzplpQSrkTXvHgGwLwXBXW420
	 OSHeGe79bHSvMnnf+smFTiJfGS6oDHKFjBhzHnOf6NWGYFhJofgqgS6hINEIVFVmbk6KA
	 LVddG3DGorwk95BqTOJJvonDBgX36AvfghEF9jpXglxSQ2r8ncKQgFv2SiQQJ3ZFzzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gjh5ETJg;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E09606D804
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E09606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gjh5ETJg
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-717034b331dso154915eaf.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172604; x=1794777404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
        b=Gjh5ETJgttZxG2mF8evsbAwLJ3GjkEAy1jrx5pHGUifMlHZbZ/aRG/9t7kzuCZy2YT
         IoCcF9EcDPklzfhwN4lKbeau1ssASVIAO9+YEwDGqsVtVrc7bQKNDA2oJ9RPlgRTFGPm
         9RNOH/wVC25C9JUFfkjNFbB9omFoKfH9ZY90Tfkmb3LvNUrGTFnlCmrWvRTjwFpsPNR4
         8zeDjaZ25FoCP/wRiR0QjdIiwPxUor82lLp3viYCTm0h0rL2LHt7yNrz31uNWKvB4rim
         W72JXuV4fuwgIcWb0VlcSoG9KysFWAu+osxDFjzdufgvCYbffSwt0Tt/SP9uKVb5u3TG
         O33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172604; x=1794777404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
        b=y5TJS2R4iVWcdyiOj5kRXfvVg0xGeVALzdvxpAMz3DU/WlONSQA1iO8p++9iMOiJvQ
         C8ckVbpI0DGB1cyC4WxRR1I0s7NoVDOkwduogzhPQwboWUXC/hvn+0RAFmwZGQ1xAHOJ
         9GdcocJq6SluPkuL0AMirVaNRfK4C27wlH/Av73/O5sf2WeWq/nJq9WBfVpO4P7u6iL4
         ivovId+LNiFrcm8AVid46ulb4DIYeGgGCz4aYGGnPUEbkjy7eaRky6BY2NljKpfOm9hx
         aT/dV6NGIK/Z7MjQhfEjPwUdhd5U0j+RO6Pn4QsBjwpJXVjqtY7XToSVvKPW/9RZPMwP
         EOBA==
X-Forwarded-Encrypted: i=1; AL+hErHGnFMDhEUggkS0/7fHY9gZ1NfaRX057KpYEFCSc+9/tnynS0yKQCuxlo4waRvwf2WITxmLmfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aKUWuo6q+OZYhtS5H3lAu7a3KoUYWZttqVDEJTkTBqUNYlBUJ
	yDjXZTlO/GniQubtt+jcCwU/FhipTN2vbNNpmYGqFdPIXh3K8NLkX3I/
X-Gm-Gg: AYBFou0p8gqh+jk5vU0dab+XKe2SRQIXQA7tZ2GUwVqNrVXt/EgIoyxP/GntrXNIYnN
	oInw6tQHg8/9ylPM4p1OgETvi2L3foAo3epGg3hYT988JFaSocV0Kc8JTsHma7Ac/rCxDca8wjq
	0fLpY1uaGLTuuX1uvyGYUkVJtuJiI/Q2mY+cmleL7JayRfv9taG5K/bs+BX3qJfqflr/UyAn+F8
	Vn7ITy4+9FJ98V9LjJdbohFUpflA4iu9m4XkXAXXajUvo6q6/5NA4x8QxEFxrl7G8mPpnosLn9j
	t85Qq3MBP6E49kJzbbV7o0LB4O/DRoLyl2MxgaZBNJFXMT5ZzwfVkM2ASw7wgusnn3sq4s+kw9q
	xvs+TOcdm7OMV01ZSMFVdSuX0J48qQSCPVZkt3IIYIG7K2JBeEV6RfUNCvTSTV1DkoO9v0EpdMw
	zs8wsAHvQUfycDncqic/96ccHS+WfN0fuxPdEG07ulVoDFC0nu0BBGKZqSGdAjN2pd1rCOrVUR6
	65zIf1IaHV9USe98YL1NiWA+WBhl74gAi7NNOvKrGuCKARdD04SOXm53O13Oi3OEZVq4EdS58fB
	2quLiQtVkFx+DUGTjcX1hQkQhpcdaCPx/fkr8axZl0p1/2hbTh/0tDZCZcnfO874/DDYPOOcdez
	xavhxKJf51miQWH0E6VkY5qf/qwI5ULn+i0LtFfWa5wvhXXcEJjXaoFWb5t0uSLOEYlSl6E0K0I
	xE4o5X9m4k0UG5raM13ZbkS8Jw8Wy5ivQ+uUBIcGHwt6LSd5vWgVA=
X-Received: by 2002:a05:6820:1690:b0:709:529a:478f with SMTP id 006d021491bc7-7170f2dad52mr1144251eaf.60.1794172603603;
        Sun, 08 Nov 2026 13:16:43 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1896378eaf.12.2026.11.08.13.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:16:43 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:16:36 -0700
Subject: [PATCH 2/3] mtd: rawnand: qcom: retain the BAM transaction if
 replacement fails
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-2-509f30a9e14d@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

Attaching a chip frees the controller's BAM transaction before allocating
one sized for its page geometry. Allocation failure leaves bam_txn NULL,
although later chip scans and previously registered chips still use that
shared transaction.

Allocate the replacement before freeing the old transaction. Restore the
old capacity on failure so the controller retains a usable transaction
for already initialized chips, including I/O during probe cleanup.

Fixes: ba7542eb2dd5 ("mtd: rawnand: qcom: fix memory corruption that causes panic")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index f240d1effa04..062fba9eaecc 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1329,21 +1329,22 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
 	ecc->engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
 
 	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
-	/* Free the initially allocated BAM transaction for reading the ONFI params */
-	if (nandc->props->supports_bam)
-		qcom_free_bam_transaction(nandc);
-
-	nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
-				     cwperpage);
-
 	/* Now allocate the BAM transaction based on updated max_cwperpage */
 	if (nandc->props->supports_bam) {
-		nandc->bam_txn = qcom_alloc_bam_transaction(nandc);
-		if (!nandc->bam_txn) {
+		unsigned int old_max_cwperpage = nandc->max_cwperpage;
+		struct bam_transaction *bam_txn;
+
+		nandc->max_cwperpage = max_t(unsigned int, old_max_cwperpage,
+					     cwperpage);
+		bam_txn = qcom_alloc_bam_transaction(nandc);
+		if (!bam_txn) {
+			nandc->max_cwperpage = old_max_cwperpage;
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
 			return -ENOMEM;
 		}
+		qcom_free_bam_transaction(nandc);
+		nandc->bam_txn = bam_txn;
 	}
 
 	/*

-- 
2.53.0

