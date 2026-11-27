Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754849;
	b=lBdLfVZcK0Dnb0HsLI9SBUaaCrAU8L/XradJKiTG5FgT1Sg6d0CL/rNfPyWNgvOKpvRg
	 T+W2JBgmdqF5jf2zydTPOLSRuE/rPnuee2kyCfnNGCmWxfpZakn4nU9SM3ZfImJ/AfrGr
	 VAP/MZG2Svd6DXt5b52qJNWAtYz94hdJo70nigh74l1GujN+zBk+livGwYGhZkMH84skN
	 epoOMn9UpVoMhB80iTKPlCF9uLJ10n9H+L0Mxnzx0eJFIec7Aakt4AO+rD87UUhSb5Psf
	 ueZ8bRv4kWYpvBdmmUKpHWPy+xL2bl7XTxrXoX2RWEvx04KYWUkJ17uxogfW+8cRqWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
	b=4UC07GYdbxwy1byyB2H/6Pa26QPy8DgNsgUuxBXq94TPupdKDFlswenBSgeendcyZfuI
	 DzFnTgoRQDEE1svA6nGP+yTVxcgilILbmhg5Hca0xwnw4ilOVYb1Xnd3CynYfuDB126AI
	 ZEhw+j2BLrbt19TufCY++3nkJufuLPp3dORRzMuiJNJtozu7lcetwtc6svAs7WVQa9oNZ
	 e/ylI6wVYwHKMKy/8KWRpWFrIxUOkwqUmlyEy7rseWr/9DmNVPOUSdOi5k+Qa/nWjSt10
	 R72tqGPeYdcYdKcpkU6hxP1ZwrEHCo5DxSSDjHWFhuhFUc1JK6EtW91n7LV4cAesltQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMG77+b2;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F14606A32D
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99F14606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AMG77+b2
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-386ab9ab619so10414433eec.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795754848; x=1796359648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
        b=AMG77+b22JuIdGerH9kErHw+7ek4I23A2vLZan8A+0NggyvcIxby4Tg8V6DMuEOkzh
         QtT835xYS4w5Mt5xmRwcrbosW+/E3hW77ZNASyEn+0x3nsWmFAgiWh6aF3UFj2uAnhkH
         hf6k5JiOyqRvUoBTjzBLPgdtEIYrpXm24q1m4fqptOeV6KOmRjDCQ6nuBtlfuh+2hoJs
         iIZIYWiADDbAK46bGZe7RYt2mtxWipnFtQ80+mcPcM0zwFLohV610QHbLYAWJ99RioiW
         YNxrRRj439oYxpDSTBIc47QJTYVuq+VVu3yCKzyKvByYwsxjyuheD6+YUKDtlveYqtJJ
         /OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754848; x=1796359648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhWbnd1GeIVZ9hq0Bu34JgMJF0xS6SzA2+sYatBHwFs=;
        b=26rULW7zz/OZxlZI4vm4+5VAnCxjv5Nww12vy/eSg+dhhQ3lu77AznF9K1wYeCkWzJ
         1picLJTp0CpuC92AK5JhgsE+GGwcP6t4wiAP5nPCD/9gZjseiSyZVTDQwAyzIjdlYLqX
         4XF7h0eZpKpzh4GBPoTUtWUSf42z75/twRhhzWzprqfI0vTHzoK3tTek7jyO2ObmQzTk
         MukTLAH8/AsBl0RYBiyTjofDg5yoJlY+9LVNR+f4h9+HSXWnUetjSNH/cigVKv5UAzzF
         L9ba9Nka4o4dNcreDvVt4xBe5Wx/eldDS0JGU6kpVAH0SRw7npntLtswN8hygfrOy+XC
         jGJQ==
X-Forwarded-Encrypted: i=1; AL+hErHwGsGpnoy7k6PjL/z33qbwO/in7NzAIn+t+hJIKubC4Y/bG1Ay8VLifx+HKr4DuNLGT0b5N94=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fuLQdH3GtwzlA1s52mla4DOUqT/MnnJ4X58skN/kehnq5ajKk
	e5vyCKLgEXrYO1PyXjUoh5RMWPDaPyAPhYQhgCnn8rp5ovn/O6u/PXL+
X-Gm-Gg: AZFdTZcEftAOmQ1pVks0h61F4oJl/IwxF67QA7xakOKxPkyXIz6zl/bRdp2rM6E+uue
	qIeqtxPPpIU/m1Okj7Al8SbW33SVTIH9GXTIWL2FUCkVlxJRm4Ki/FjAWveL8YCxuygYx+TExp1
	oZoRXN5gPHwrCFKtdu+sFSyV+84pRiwVd6/OR0DPC/MoeGlhDBjqHWuwqkk/B3xe/bJ3TJzF6n5
	WkP/NqvrD5P8KtataJELrrRUE/teQ05mem1dg5CXy3yLZ9P9/6W22UW9pvDnidHnYT7wAKHkaLO
	SIsRyyYHi/10cyrnuidruek5LQ+NMZx7frcKFWinWyjcrhdYj+T5fm6wuN/Jdqk2BsPw5JEB7jR
	wn+P6SIeMUBU5D11fcO0UUc+AsZso4m3s1OpCmmrWtwfOKzmXTKqPf81lHrzhVPORAZ40YbAFWE
	al5p1OelCCGAeex6QFE+NMZ8fkabX2jEGlagx8xFiCox5mCLtSEpSyvu/7YBRAdXZf+S5gpBLYu
	ByPyl4SdF5VmKQ9aCgPmWbx5kjlAp6YNgLeGMqt9G1MlRG2IWagDU84RWiQAQGsmaViMK5IhF4p
	Wu8YGDfV4DwQr8XHntU/5osqPQWwbkQp
X-Received: by 2002:a05:7301:d809:20b0:386:b070:6f1c with SMTP id 5a478bee46e88-386b0707151mr14752841eec.21.1795754847629;
        Thu, 26 Nov 2026 20:47:27 -0800 (PST)
Received: from archlinux ([114.79.176.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm77084648eec.26.2026.11.26.20.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:47:27 -0800 (PST)
From: Gururaj Naik <gururajnaik166@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: amd_sfh: Limit DMA mask to 32 bits on pre-SFH1.1 MP2
Date: Fri, 27 Nov 2026 10:17:16 +0530
Message-ID: <20261127044717.129941-2-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127044717.129941-1-gururajnaik166@gmail.com>
References: <20261127044717.129941-1-gururajnaik166@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c45d2b54cc73 ("HID: amd_sfh: Use dma_set_mask_and_coherent()")
switched from dma_set_mask() to dma_set_mask_and_coherent() with a
64-bit mask, allowing dmam_alloc_coherent() to return sensor DMA
buffers above 4 GiB.

On a Dell Inspiron 7405 2n1 (Ryzen 7 4700U Renoir, PCI ID 1022:15e4),
enabling sensors with a coherent DMA buffer above 4 GiB (e.g.
0x110ff9000) causes MCE hardware memory corruption faults in active
memory. Limiting the DMA mask to DMA_BIT_MASK(32) ensures buffers are
allocated below 4 GiB and eliminates the MCE faults.

Set the 32-bit DMA mask only for pre-SFH1.1 MP2 devices (mp2_ver <
MP2_VER_1_1), leaving 64-bit DMA unchanged for SFH 1.1 and newer.

Fixes: c45d2b54cc73 ("HID: amd_sfh: Use dma_set_mask_and_coherent()")
Cc: stable@vger.kernel.org
Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d129f30b48a..fafba3ec9ced 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -484,7 +484,11 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 
 	privdata->mmio = pcim_iomap_table(pdev)[2];
 	pci_set_master(pdev);
-	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
+	privdata->mp2_ver = (enum amd_mp2_version)id->driver_data;
+	rc = dma_set_mask_and_coherent(&pdev->dev,
+				       privdata->mp2_ver >= MP2_VER_1_1 ?
+				       DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "failed to set DMA mask\n");
 		return rc;
@@ -498,7 +502,6 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (rc)
 		return rc;
 
-	privdata->mp2_ver = (enum amd_mp2_version)id->driver_data;
 	if (privdata->mp2_ver >= MP2_VER_1_1) {
 		privdata->sfh1_1_ops = &sfh1_1_ops;
 		if (boot_cpu_data.x86 >= 0x1A)
-- 
2.56.0

