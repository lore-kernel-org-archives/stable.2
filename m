Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CE50128F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676387; cv=none; b=baxp8NE+5WZBESeRkz57hXDYDa/s19D3Dmm9wgKA/oKcU9EqKM1sa4Cg9K3xslgt6odhZoWWLNd8vrAIjx5+BXh/WbJtG9BrLkyPbwszifCUo4+DtRJmeMBagF1lGFdmegdxvwMotJZNBwM0H8M79BpI8ktOMP+SSMxUHPMfCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676387; c=relaxed/simple;
	bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbYTglypzYwlYzOPMhwG3VHhNkoZMmDHPctNKOKbfj43twW3HDkBuRDgkJXGFCIpXn9hI29yQWdI9rFog+TjcudXJZCFR8ci3ju4VUurec1HlVhHZHGABFQcLDECT83xRmmLlvTO8PzAyg8U73/Im1QGbUB5oq90KvHipwVreSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=RvTe9qwd; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="RvTe9qwd"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso14400895e9.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676366; x=1791281166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=RvTe9qwdS1wtNDCbRIsnLKiGnXTSYhU2aArwaWST3kti5NAgzI9/ti+VrT0JvAfRUy
         EIse878ODl5LNjlTy77n0YsyRPZtmaf3zbrrpDUCKMUrcvxI8DfyuUXuxn6hsBRz8eav
         MofcGLgEhgR2cL4LSbyD27ey4vcmTXMRe16OVWPSYGXmvogqaP+xD8YT8xVb3p1M+BMV
         yvq0Nz7aBFW/FNB2Y+/hayCxVbXb0aQUrKZKEy5hOjVCIdY7+YSOE+k0oZjS9RZKlkmL
         4pD+ZxX/9Q+COGYbNcF0vMBJWrspteZ+G27rS8ku0uH77CX4/A0RJLCRobao4efjIA2r
         q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676366; x=1791281166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=nQymuGRh+iqrr3E+DcBZl3aWwgEWk8StB4KQ1fnn7C8QFeRx19Wu/RxcNVHMF3OvMz
         ByPKIl9XLSMScPOFitpt60mg9bfLcKezYOSaSEy+/nwagn0QMEsilZCDp9hLcaW/rap7
         ZGjHuuhhxqiEqhnTQaIxYVQ2bsII7V17x7aeH9CdKpPypW1TDjBTDZ4oqzwffEcpcP4W
         qhyPdLhPO/t7y944eUemQ5X8B/ow/H0nWpjPL5YlxMLTtus0YAuhul/Coat8DoCQh6p9
         KQR/cgHqWUvNbbr8MRa0jx4aTb5MF0vRUH/jUKU9qfk0+48vd3GNX0LRZND1n3Tc/CEg
         zSaQ==
X-Forwarded-Encrypted: i=1; AKwUvBywDFxGx0VLgPvvD44TYQldKK+GmDcw575uKE4HPOfigkGDrwSP1KamQsHxFwahSoYUNanGFfw=@vger.kernel.org
X-Gm-Message-State: AFuF++mJsdYITBambgLmHu7Pj511TCi04Opq1/Z54CD30n/mO4spgwbm
	EyhlonY272e51e650rOni3mg6pfBHabP8vFOp2j6Zka14/cbNcdhuh9cx62mdlIyYyk=
X-Gm-Gg: AYBFou3m/MjHkt3d54g29fLeYNZo2CIqtzcoWyFML1r2C1OfcPcs5z576U7EwHcfqkP
	nyWwM0gPck0VaBD/CeaR9pYBJ59lE2upMz1RSsCVsnGTcHW/uHtY6RSEuKuapAntoEHwollTrOA
	DH3/wo0UWSMM5Ykh91GwjBDKSPtnP6+sASBE5Zt5LA5Rg/h4hV/XUiboo/OCWwi8WhT32JBwFS2
	lpZL8tAvl5QDTorkZ7pTv3XurjhsGVP8Nx6qMyftkhhSob1vwnb0bKycUJ1487RWV9k8ct6nS/L
	I+74RqYEYObiF0R+0Q9lWKiPMYpOpjczea7rIue6F3Kz7+RvZwQ+MiIaoRxxsoJxDyCRxlSK6Qf
	pT+70jN/QdcSXRmjZIghQKlLNid6cHeSF+uIg91hogbEpgharBnBoyYtUG5jX7/ItedJ+h1DuPE
	fi1Cre2qArxCuS0ClBNY77PWZ8QGdE3HgL0EObolkzN3SKVLtQQTU1mx1OtucIS240owJsqPflG
	uIW7EhtRtZQCkIo
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr275023955e9.31.1790676365876;
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:48 +0400
Subject: [PATCH 3/4] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-3-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m15c+pMVMvP3nmVCzY9SDy54GzM04bw+nyrExdDN
 4lf7QwT7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqi68wMsxI18jebmlg+G2XWuSld11BNwUXLzhvdu4BV43+y3UyJnsYGdYwz2/
 +37siqnD9lao/K0uSyrjlHCKu6x9m8l7JoTqLnQUA
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

-- 
2.55.0

