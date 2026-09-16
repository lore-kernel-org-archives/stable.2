Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C04908B4
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549314; cv=none; b=Aq+ovGlOdMfqvIVgnBwPxswQ6wrjdaFXgMsLoctz+dUNe2W2RC+stN/MCFClQTXDxi86E3XtOqaIT0B4YiHk++2KVxHy82fT6gkZfFHgklbztcCP3xtz5Q6Ykn0FEbHyIw6y5qcGES7sI1kO/N1GsXRveJVIsCHYmXn/3MLPuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549314; c=relaxed/simple;
	bh=74+NXWRLulW42h8LCDGQtUqGGw4TZyZ6WSPtQhdY/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXRl7nfOYB8hJXR3bXdTwAaufQoFbeWOybz9nEYDAirERMs3negysXxzHPNJfJ5Dc38SaOHrF5xSB6+waKwm/qvtOs43ntMdLM3pHQkLW7wTPVAPBY8EDIvQWZyaMjO/hqbrGewm98gabSzHl8oRv8p8xUdEAGvVhVOAJ8saOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDfjua9P; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDfjua9P"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso729386a91.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789549302; x=1790154102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6tQdqZnuOU/60EvuEJ2W5w4uMx9pH4irbJ1JjeHep4=;
        b=KDfjua9Pfabyus4iUkLuEbwaH8RqIk4642tFlU9F326OxUY2IXPaixt2PpQ1dHrqMo
         PtpTOu9wwhWUXwKSTbwpdHRbCzaanWXS+CabwFJroa6oKndYx440PeHOm8+ZYOPv2Te3
         S8ud/y1XoOQGbTr+JWDXurNKM8kIcc5BSk2T/cH2sj4A04psErV+zs02J9prcGqSP8II
         BlzXeGqBw2k4o1clumzPfBY7iTVc8xxGdnsdSvp+qO/Tq5AyVxtKQVK+vPHRj8tLTROK
         JYjE3BDWCZUJZ1rNixPB2GzSVsIRwdosV5WMGaM4QhCl6v2nqN0igQSwp3EgpSaHfDhI
         OsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549302; x=1790154102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6tQdqZnuOU/60EvuEJ2W5w4uMx9pH4irbJ1JjeHep4=;
        b=Bp5ofEMYqHZ8bDI+J3YzdjcP3UlzFF0CkZyQRcQmdeEps8iaXep90sMHvs67ibqtwU
         78aUJNs/W5QJoc4+DESu5dKkRCxUJRWUB6nvgf3W8uHUXP9ymn1lekEGQ2bkZfKnmtoP
         aRitOjizIs5RflL6ddyRpGw50hriRghCzMO1kSjBF7jwPatpMb15rdjW+pnH9O6Xo/YK
         K4bd5HnsJevo2v01iJh8slYnMVHB4Jf8E1RdxHaYh8yx1102vQPLX6EDwa6PRsi7lLwX
         AStFRC+vheMn5wzhPBjT/5ukqjzzuWYHLqwryQWPLcIQvN/MBOcfIDCPCqfgavm8fdQw
         IimA==
X-Forwarded-Encrypted: i=1; AKwUvBxBo0NLxBr7ibhdsh9TkSz4clUnqez+ygj4Irxb1zSQxA4+q4z7swiAAol3jdhqJWKSb/goGe4=@vger.kernel.org
X-Gm-Message-State: AFuF++l9yy6285ZhtYBXDM7MH5QwmZOCJXcGw5tla5pfqKSsHSyeTb5R
	0YF+VcpVE+d6446Os9lDpoL25UYMFcDHrs522gFkeHpTGc/lnVeWIAhK
X-Gm-Gg: AYBFou2CE1asu9QzQkdn2abcEawupAauy4Yg9DyWYaQx61Q4BevH6ptkLY5tJID54kV
	Isl/xA45v8Vp+Ug+Ox5/i6qqmzLfJo7yQh0oHMzrkxySSJnz157r0/tP4sGzbyajlU42RbqKClm
	UgL/hRJeR1KUNWgHlBfffCx4lfnB2HOJR2hArXNMGNnLShEMk/jdbRSHcIPRLNQye8o+uEH8w13
	kVaURsDxAhdQcKsx0I8S4nwL4ujwtq5OxoILKHqsXYDoDz6lU64s3KzY3+MOE6Wb59YjqgUMtrP
	l/85ArD4w4bSISjDPs/qLb0UonXtSnW+UGX/MdWdPspoCc19GqIRknL1ZvDYl5nN0zwzxJOCqoY
	1aN4dq5kM+S6od9Vb0NrApz8IACVzCyY6BufNSKYeoBLouln885bMTQVpK+TJlHxgYROKvSmSYL
	JA12Fa+LXQ+dqi7IpVZ7FKv5K6rvFO8Vbq1u8UUrBBnV2S0Ai4M9Lv1pE2h/b4wtmaUc+3kw==
X-Received: by 2002:a17:90b:3950:b0:396:d27b:89b9 with SMTP id 98e67ed59e1d1-39e1e31e264mr4511213a91.10.1789549301596;
        Wed, 16 Sep 2026 02:01:41 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbe3e62sm3609040a91.10.2026.09.16.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:01:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: qcom-ep: deinitialize endpoint on remove
Date: Wed, 16 Sep 2026 17:01:26 +0800
Message-ID: <20260916090126.2963064-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_pcie_ep_probe() initializes the DesignWare PCIe endpoint with
dw_pcie_ep_init(). The probe failure paths call dw_pcie_ep_deinit() to
release the corresponding endpoint resources, but the remove path does
not perform the matching teardown after a successful probe.

As a result, resources initialized by the DesignWare endpoint core can
remain allocated when the endpoint controller is removed.

Notify endpoint functions about EPC deinitialization and call
dw_pcie_ep_deinit() before disabling the controller resources. Keep the
existing early return when the link is already disabled since Qualcomm
endpoint controllers depend on the host refclk for hardware cleanup.

This issue was found by manual code inspection.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 56184e6ca6e6..28949386b0e8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -944,6 +944,8 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return;
+	pci_epc_deinit_notify(pcie_ep->pci.ep.epc);
+	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
 
 	qcom_pcie_disable_resources(pcie_ep);
 }
-- 
2.43.0

