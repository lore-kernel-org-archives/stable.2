Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177745;
	b=JopjwEtKl3RQSzjVwDWR24rnWrb504MbU+Xf4hc2G5CTwszXQD92D4KpmBfhQVjnMMdB
	 Q1f01byC5M9XM3Wzw3yuLFuiZKiqHDZ644pFaUq5RFKT2hscJ7MvTho9TaiSQ1FFgJWk8
	 BRQYfs8IiFTl9CZ+Ii/qanXEA8g6cEdstejulUJFSvcosNuOkjoDn1CDZ5Fx7rCCfb/EL
	 cfa5eWhkPDXbxwh7xJN2LtswzQSq4KBAmdq40govXiQvZvUVkXh9aH2ERqgbo/OSwVKmR
	 BNmR4dXa+hah10MvJxq+p2WOTbcTH1aVUcOruOsIvkyxYj3MBZftpz87lfGQZ93Ff4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
	b=DDE3rXm5eYvpQ6oV4SjYBiAyUY0X4rmZ1rO3ER2oqTff+aqnh0FDSDnOsSH30HV51KEQ
	 oSD1YYidUhZ7MkZRuKgNBExSP1zIGMuRqWVwMuTuPN0YqQjpdjtjw9nMmj2oXLYo3dOVH
	 5BQL78sKS5Cg7jYJpgDHn7P4wuxdqnIo5GurG731sm0Q7s2v7I1Asd/ReGOCF57juzIzC
	 Rj7yk4ZmCUDvSq6vhq8sW1u2TazJ74T3D00m2Ihz8vNQy20Y0S41nA2EILDnPrYBy9usb
	 LlVvPCf7nHeI1itNeWAZjHpiLdg+NRArKof8+KmqjzMtybKKAHsUzR1lk6OgXAScr6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8OzPKdN;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF73606D801
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DF73606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q8OzPKdN
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-7143451981fso203683eaf.3
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177743; x=1794782543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
        b=q8OzPKdNmdLYRq1zgFWwV/LaYGoCt86qNEDdrNZOhWW/F71jWsFH4YfWBtwve9rPVL
         6xEt0+knLMvyZe+34OrbRH64DftnHEmGQlv7xrReMfweNCdOH54J7L5M6b9u+cAjJjuT
         Tr+VEkJ30s6z7DAgwucuydppZG+yuvBFH4knG+BMrEQ3mlME3nnwMhn3P59efq+KY4ZY
         opSeJD2L/xjG8QWI93uib4QmDWXswlYuCmyzcEuZsmhW5l/drE4BbQWnDwiwe8HwC+R/
         eFYsbTCXoojKiZGhNHAf/iYYKVvCZF4M3L32O+7QBlFXFyLdZvX33lGqt2u7fQo8lxAV
         rNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177743; x=1794782543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2ySxSOrcSb7uKygDj4na05JonBIKAGAKmpgaBjQ4aTs=;
        b=N505FYdgOwuxTi6U1w1JK+en43w5Xo0BaIvYiDK2CQ/GKfPQe2uQjkR9dVQXu/Excu
         YPC2BbaI0LghneEac3EwZjZtPsEsGYtuDi0l6KdUxalry9qqUZDOfJfQjbnM7rDwOwS2
         ZyzJZaitq8b27+WdnccB4UPMDqBzrIlLf86JrkP+vrdLQJo4Zfr7rgJiGc7R2D3jw2Gf
         GEspR7brMHds7bveStTavbY+qh5hms+PqbKpF/bPtZQo9CIGpc371R1hPAra3PkBZw52
         Yj6SUS9vFuGN+otjIRdQrSyeBenkPUjgD8Il4w4gEFBDdrhHnx4CweQG3wvCUB+GJrqH
         1rxg==
X-Forwarded-Encrypted: i=1; AL+hErE4lsSlEhMHMxlF+rTc4Ytq5EiWLp3dN0uVT4UDpQCA5SChfOO1fzfg9qJBjaW+RTGdSZl1oQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5TAcpJZgQHDrK8Mo/KKkmj836nQxVqsCh3CIzJlTOAerU+u1Y
	PHh9TIgZdiYR5mG4U7I1qDNLv6ELbdplUJjik1WWf8cttiLd0fjV+bRW
X-Gm-Gg: AYBFou3H6DSlmSjb1zmUXomN4Y0OAsxvsG+0oCVbMfpkj39e8F4Q4P37hlfIakiHg8a
	WOF1TN18ZNoy1XRabK/Uez5Xcp81g8QpCIDyGJgtWt8NtNdLmiTfB6bkLzjo0iUwd4vSFIH21Ea
	gIZ4Cb9D9cFtLkUzw/uOrC+v6/xn3fRlLzKQ6+J09H6Imya7cA8gbaZ/Bkifqbgh50G06MRTTP6
	xHpj7WC1sUNKvrNdoUtgSFFPrDK2Pg6xQFCuChOG/GrVUfTxTaQE97lgvdIcvGekyDpZ8B6iY7i
	T/k8S0KKRBsMU1W4rbTKnEtxUDU7OLAVPWHptl3DtMNoN8l0+xMfJdoVXTMujuEA4VKR/IH4W5R
	pebXarMvjHGCdifxWMlRC7BIuQ2KGu78XsCSpVNgerLiGZ25S+1zJvTAxBbMU5QiCjG5plH9e3w
	UHkvRCwKRJiC++ui5l8Vow/WJkssXZ7MUDA+5V9xpF8EH6Q8ELlAbHSrFmSh2+SqVu1mpqcb1lw
	/8MLHmubGBLmFmgoMZcZYbewGgSlL+Eqfzt65rvG8fEQB99K1xQB1l7rLuT2e0DxJCL+3WOjhep
	fTTm7COQwhOamJSP3pPRileqg0b1uK425NjUMQT1rRrtstuNZ90y/5ZY3C4VjsiJt7YDJ2G8rVg
	/yFslnpHdG27cGkLMqnnsuSn/3jalvtDD3P2rkwbXhuVV4LkctSNd3ZEVI2Bfa5i4u01xeVwyzu
	3/RN8x7xbW9UFaCNI85s0VUMwOIQG9IrZIkd4oyGw7oxLSQfIXNNYY
X-Received: by 2002:a05:6808:2383:b0:4d6:90d3:e18f with SMTP id 5614622812f47-56814624be0mr1364853b6e.46.1794177743647;
        Sun, 08 Nov 2026 14:42:23 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54e39sm2859944b6e.15.2026.11.08.14.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:42:23 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:42:09 -0700
Subject: [PATCH v2 2/4] mtd: rawnand: qcom: retain the BAM transaction if
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-2-4a8704cbf7b4@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
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

