Received: from mail-lr2-f7.google.com (mail-lr2-f7.google.com [74.125.230.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5C49EC67
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474012; cv=none; b=mEZBnPspN2BDnGzwMTTTMXE72WRy6JUOEZbdyibD1RLu7UoopPRYSajYCQ3BLUMpszlHtYuggdTk8bHeo1uWH9jICjs0iKBC/cY2LuiezA1g8HJs8FDwjgtbwrpnZZJufuku9A6tjfqsR9y042Jj5NUhixS1g9wV7om7hYXiufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474012; c=relaxed/simple;
	bh=L9AoZUg7lEsdWbn9aFcpecPRtNZEeODiYUAjDtG1t9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qDepeHMWcsOAupYalCk7v4lXSRwyDbY5to0OV2Ej+ZaVvQ5GCvP0cwUmennCZIcpf/rdIVQM//Mti3snKAQeuafv1mDIG0Gufn3Q91sQpl8isbIQW1tK9M+1gxhbXyGNAt90p7QRj5SszERaYAbC7pVQHL8k6rejpJIfteCH3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkR7rBVb; arc=none smtp.client-ip=74.125.230.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkR7rBVb"
Received: by mail-lr2-f7.google.com with SMTP id 38308e7fff4ca-3a5abfab93bso24816651fa.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474008; x=1790078808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eFfWz+2LeAhbePcRVlXxpTMeg4HmBB87xS+6UiQNubs=;
        b=WkR7rBVbqnZ5oBUu/1vwE6nlZTs4ZglV4Ucbh/J/cxiS101L7mtuOWrtPOp5lKReTF
         Vz4IZWy4RcVchpOpQlGxwN/Inr2n/8Fpc2i6FiCJPp79fAI5PCQR41hOJsxkUgKBp7rZ
         zme0nSmRPFD8t63mNGm6wgT/c3ekzoRawlivIsomIHK5oM0Hhbcwx0CRh/l5FcLdMIey
         7YNnv75GD8I5d+1r3Q6HdaD6iaZQotRaXcdWNCFmlL3hdLOQ7qQfa9cmVeSINfyMP5sI
         i7Zk8r3TUzgIuBc6eksLCsO9oDJLZAvKKQLewrjDfROdm6GqnShQNSOn8G70bnnIl4yX
         JBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474008; x=1790078808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eFfWz+2LeAhbePcRVlXxpTMeg4HmBB87xS+6UiQNubs=;
        b=J9Qfo7wuVLYWaPdLnjABa1VOpw9AVBTNYXEu3F8mFmFytat+s/FOsREj1bt+a5yY6F
         k4/qksvv+BAUlB4tupqu4D4YvAXexbL7McJFmtwOhzhByR0qgbPvxNGk87lMqa4AR38W
         hq4HXcs4pmZmIVDT9T5AsYXo8MymIb4V6bsuRlD4ei+ZFJw5xfoTNg6XrSUXwhJQeLvI
         LhMCaAOlDX0Y3uKoCFpkvW9XSgSWEZXLFUpfjNF+YzwhhL5VAp36yFz0eE7kPIMAVmhX
         G89e+bq8i2YDwW2YQGtOfOqkfEewRkzWw5HkZ/gzKGDZLNM8Btwh9jshuVuk3CivYJH4
         hVxg==
X-Gm-Message-State: AFuF++msUhdPQrxogCtLTkP7fgdYVKuxn/aqxn/qL8aSDSXlJTWdFoaf
	lJfLrIE+c/BgGV1lmKQ4HOYbOQj1Rm09SE+BdUUT6iKgo0d0uaxQXmO6JyUjzGAtiaE=
X-Gm-Gg: AYBFou0OSmPFDBmzwfQsopsU+OXevUwkhC33wNYBIbc2q/wfzzO7VIlVgJ4f4NnGRjc
	x4y01iFf6Nl80jy+0US2Ip44GQIJSBk2qOfSni4QfNWMIXaNHqcG2wd2QpPcf4ZYsnAtHQtz4nb
	xYLXFvGCQgZUTv8WtVEvJz6sGuslU1O1/hbo7zojNYro9nUezBUwRA1BtyoZ8k//F7sYWXgdWlS
	G27HUzrJ8m7qZBRxWYvIxPVfySTvntfomM8d3DjW7hpFiED+V0emKEENnlH879rEPCIUBFp7nBZ
	as7/J+Ewjek8UDUYgSZRQG67MovBiy3VHRHfUM8rx0fuVqOt1xQcuvhhKCeL/+XSdaFwFNiA1hv
	BJ4k860ojELeaiA5qYbCGNM/K4bGmvGQ6BwL8AoO6BlqYMkyopgrwnxp5EDtt82mZ8TzqBwgckA
	vltDSrliQshxbmIrOuEE7OpfHuZVMZaeNkQz3/99zXV5q8fpiM7AQZvAEuZRBBdFPIJKYjQHdlt
	HkeAptGd+Pdc4dOyg==
X-Received: by 2002:a05:6512:3986:b0:5b6:183c:5c8a with SMTP id 2adb3069b0e04-5b8ae699f7cmr1629054e87.40.1789474008404;
        Tue, 15 Sep 2026 05:06:48 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457238sm3226327e87.16.2026.09.15.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:06:47 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.1] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Tue, 15 Sep 2026 15:06:29 +0300
Message-ID: <20260915120639.106692-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

commit 11d7cfe0c119691b2dafbb699bbca90258c678aa upstream.

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260521142153.2957432-3-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2026-72147

 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index d6b5e2463884..e149575a6127 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -151,6 +151,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int err, nr_irqs;
 	int i, mask;
 
+	if (!pdata)
+		return -ENODEV;
+
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
-- 
2.53.0

