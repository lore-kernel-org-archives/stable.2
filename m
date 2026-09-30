Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05A367B9C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784638; cv=none; b=kzTrYWo7UDtbbsEeTnxXh5wdDWMdLOMClCm2mf7ay5vzivXkmKnRop8WOujoAGxHqsUiydbN8uCaYEAyhWq7bVHr6vZYPTraS2mK8S38Vjtu0dUn5EbHG+3q6gWE7G9kVHWtBcAIHCUmLQQxGPlJAoH3b7/Jcs/BbMA8aJjGQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784638; c=relaxed/simple;
	bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W+3Bn3OGRy0BFZHV3iBn9zbi5Zsy0tVT9/thuDfmF468qQoptCWBNn2T7oLCLkmpEuOLnHSmxOHzRLCkbHnFhmVwI5ERKJLd5WAFPkzSrVFXTWP7GbOC6FCWwBJ0lT49Fywc/8Mnu9ODw8cJQyPqk0u6EsNTbpIv619PGSXw1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=jHW883He; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="jHW883He"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b03eb33b2so273485f8f.0
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790784629; x=1791389429; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=jHW883He/aYjKuTPaDYwKqoIRHitas5T3tzkLnyyx1u8Ow0s6DfUXYpfWRXP2BHYdA
         OrKi0aSRX8Yo3Vh8qzLOilgBQJiUZVAvj36pSDT9YMAyZhq9hAGoZsVOi3f3vnqCETSn
         bTWucu9S82VbAQroxoLBdjg8yOXpdCksU2kojOlCyYlAo81dYA/6Dk++Sof8NJl1/wl+
         TsWlA5XSXLhGBXV1tg9mudc19t5MN7L2CAPksI2CIt7zDEh5AcRxJJxm/dUldqzg+GOB
         dQPxXft9USm+zUbcVLjUIag5RGjUYtTrKFKcsS1gHkfytzKBE4lr7kpgfXNGGGBMUlwA
         UrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784629; x=1791389429;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NGH+RfodRBv9yx6ICU4d+xVetnRppkeE15j3XlEUyz4=;
        b=nCDBGbnaf+ehM3lhrM0jRurxdr8tXx3pjvNqoZSyBAK0j8M/0BohpuQY3nztoGBBxg
         lWEqegp3fJlToUs2qDtHesTEGkGXDHYrbjHRzWxC00lqn8neQY2phebK3bA75nv0fKVJ
         6w954g/Y2mNqf/S+LkQoBc1Jqr2vIpMRSOVKYSrrX8rrcljZickJJ8epojMgLNwmsxb3
         RtUIf86+DzO2dDBUHfIDg2uykq92LNbGieYedJu95n8A7ftg98yLEwRFI6zVW8J+BiFP
         6sQJZlh8Z9gz4V1sDQokO+OuUEqte/bQETJNUpghimp0FA3wfTNq9tdMukoAEtj3lP2E
         NT9w==
X-Forwarded-Encrypted: i=1; AKwUvBwSL9NkeQCIleg/jy7ioLcazbmMSXL/qZquF/a+9gMXsnJBeHgNij4TGINIcUb4IQiSH9Zszgo=@vger.kernel.org
X-Gm-Message-State: AFuF++nprdAWwLGmcehNPf93ve/HYwCeWGYF1Udu8EwNUdHVdWRaZXxX
	FUOAuIqDkjR25ZSwJPaPHkMyKCUZqTh41OXsktGQRyNRulGPD54mcm0NK4Uj85IHS4M=
X-Gm-Gg: AYBFou2Atkt1UauaegYN0GfXqaV575zW51BImFyoc1Us2613RZZSzmMatf7sF5nLk6A
	/UyxjFSc9LSepm22MNGaRbVIqPTLeQwy9+Yj7/e2CZhn78khRBGLtsFaWjdMkzwjC7+U5PecSHm
	vIPQZjgnFMPREGN/IVIQTMl84Qv4L8kbA8cT3ivTX5e/h9kvaW918zZxMAKjjYsf1hyGlC7jf+T
	m4ir6USfVrgWtEqkn//AVCCbI79N/IAd8Nk1MDeNZiCvyo/2Hjj9UBLN8LE9/yS4KdrBxWBWmDR
	kKLaheHKRM4PFLsky3EozvOdaKC7DJCma8brB65mUXfZVvFCCmHSJNin5mHCIqU32vW5BRyLwPJ
	x3H7mpgGlFCRYmpcIqCbrwHfjMBmCu9HGanE5/BL6Ygr3s8IZgx8FBQe13mx4pVreQE4NHMUzyt
	1juHCx7waVAfuXGHKSkYRTsp6Bc1XwwoSLDY76IFiM6g4npPjGY5dVxxovk/B3Hu5GHDwuE2fCG
	X+cDLaZ72YYUdqk
X-Received: by 2002:a05:600c:b96:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a01eb03db2mr2531975e9.8.1790784629228;
        Wed, 30 Sep 2026 09:10:29 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01ccfeb2csm8578785e9.1.2026.09.30.09.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:10:28 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 30 Sep 2026 20:10:21 +0400
Subject: [PATCH] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CMAxF0a1UHmMpJFL5bAUxaMILGEQIdvlIV
 fdOgOEZ3DuRQQVG224ixVNMbqVhuegonYZyBMuhmbzzvdsEx1fP9aWGO1+yArxaxxRTiH12nlp
 VFVnev+Nu/7c94hlp/G5onj/Po62mcwAAAA==
X-Change-ID: 20260930-m2-pwrseq-kfree-78bcbc3b6f02
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=alchark@flipper.net;
 h=from:subject:message-id; bh=iZMpbAvuQm4kiaSjpijC/w3mG6fmevsG4tbgUmTW3Bc=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTtNSlqmC63gKM342H5FBf1K5b9/14q/L30SmvPV5mLx
 +peLtwa1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUW6Yx/OGbvfh7wv3ErCPSh5aznk61dOVxXpyvGOo1wbYgaCZz1xtGhvbSqfX
 HP5bEWFvJiB0W/+LM36DpptTqEXgkz0s30m0rDwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
pwrseq-pcie-m2.c never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Split out from [1] for easier application per Mark's feedback

[1] https://lore.kernel.org/all/20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 91916768e922..0febe4b3d980 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -613,6 +613,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 err_free_regulators:
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 
 	return ret;
 }
@@ -626,6 +627,7 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260930-m2-pwrseq-kfree-78bcbc3b6f02

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

