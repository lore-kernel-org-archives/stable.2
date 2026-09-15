Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FF43CF049
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437337; cv=none; b=nTYrvm2SZ72pE/GWiG59o8xOz9Zqux6ImkAuhgVcjt2a//58CrlrxOwUQdQfoFiQBNEJzD7gGj1ZuA05wt8lXlqbp2Eyru/56DOKN6k8Yzu3z1U2TzXjSbzimPA/f5u3yPxqkC8Y0Xi6e6GGYOG1aI7EXSmNLCAFO5XduhxXiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437337; c=relaxed/simple;
	bh=Xrq7jp89mGnekKQK3ThxX3L//Vp8Bi65jjsv4DPKdMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mon5VPmUUV14NSMpu7fYEylOULj0mqWqPrnAe6x5qUZB+Izr2O8JQyk1BzlAdpfpoTolZeWhUItt5pMZdO4ocBDT1j07t8IK/aFclRRglF01v0VnDr9rogevdut//bczReN9odWc/aM4Mn4BLiV2BHo+x0BGx3mTLX2rPNIria4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyclTsES; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyclTsES"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe20aso33769176d6.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437335; x=1790042135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+t2pOcypXggyoA3oDjVoOfkJNIX87WTFu1zXhjCgQ3c=;
        b=LyclTsES6m6Ir+dcgNm7EtaZw/ZhGSQsnflzrD0ogYh0SprlgK3aTBT3CKxjU7W5YD
         Ux7p+rE7AwKomEeoedD0+GRJIRoLm6D2vqPuoEfVtaSDj9Dio9l0L4AVYceT9rheiIxC
         1+MeTNqnL6JbVkLpY4trCf2Rlfv4xtqs2U0uCKHy+HtMNQe1cc+yhhZfu2CRip6kPug6
         s3unVN+BaAsFfAYdMEy4MavaDTfl0dlTCGasvlsq4DRIc7g/eVHMyT0YtAAGoZDtFiKe
         s8GamhjL7kelusn47mCPhb60WVGaHbQIOnA/KA7jJvu2RR8mrxbMozhvQF/MIh3gcrsB
         aSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437335; x=1790042135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+t2pOcypXggyoA3oDjVoOfkJNIX87WTFu1zXhjCgQ3c=;
        b=UvMjYiLyhW6CF7OBdN2Krm8VSXZheSKZh+JziksEtcQy7gIZbPLCO7ZInHdUylZc4K
         0gNKJoPJtuQDEwc82sxIqom7PgJBBLFJCOUUtofulWAJ7ZLiHQcI3t+kOvMXv9KK93HE
         wjBhlm9JsOve6jgREAQmDmd9XoMaHXzcwi18lsRRMwMnhuk428Atvdclv+yKvPcuP4t2
         JE8X+ROTSupDPaZE3HLbtaWJIO3NPKgYNl/afx4lVisSYos6kyyUEXMd4DmyBwBmaVga
         2N3KCsCXsKdkQUAi3jM1ZEP28IVCb2h/+BrNN/bYCQbYFEiUf1jt2eG+pG888HuG+o7i
         ZGoA==
X-Forwarded-Encrypted: i=1; AKwUvBwWlsA9c+Kc3MWeKW0i8NgVOfWR4stp0hQzg4VeiGv1Xznz1HzdhE4LC1YlsCDcq2Bu6Zsi1q8=@vger.kernel.org
X-Gm-Message-State: AFuF++kouE5Wt13fomQ0M4Ew+iWVHiYsYWVlLBHx2EiqoQVYpM0IB7EP
	emj/YDKnRgR6ZvBfpwNtMze/gbB5RbJprJtSTBTuRTaILD1DItzrjfw=
X-Gm-Gg: AYBFou2WpJ46ePmwBl0M3wh2FKR3oJyScD4U6kwoI26ey9W40DJRpvZWqwIMHER2vDN
	zyVj2sUvQHW2/4gM6+FatUE7Kjd5FeMNnWwep64SRVq9APmIsTWoKIfzSoGdfiIKkCbZjj6/zpz
	MkSZ71rfJ3NXBBANTNu9tKWVTiqW9VPOvKk8V3aGhRXHOBFSWsLK6ry1pKPD545x8YcvS0YORqF
	w1DYnxlTI/E1aU9i8TuoFHta0AyVt6NcgE7jD/aQN9Qvw9RE0iVP3ijEvF3xqH1tn34oee5La3i
	4mhNYzhT1FB/nq1hsRkp1uTaKFRQz4jIF3DeEl2/FUS5PUe/8/WdSttWHsoD8i85TFtiVyOY25V
	VgOuCzWJ7NTH6u5yicmvCmRzpMCznhGPDp7ZU3qlIYstHrjC+06P2NoUSwNZ252O4MZ4I/gXwgI
	V+oxXreIKPhkcicr+ruXBHzDgSiIoUTa13zQeMcrGqwTp28MHBUAevP+y5xA08bIwg39+2XRF9s
	JD+gfqtO6O4QqaR57XbGOrCD/2Z4vANuFHytSaN9BYow9SZDnf8etnU5IE6BYl1vbgtPiqE0Tcz
	LKqBCb0gAVVkHr9/PdGt9g/ASys8mdei8UeEq5lrrdX6mmeyu41auaPWtpzFx87w1wqj7w==
X-Received: by 2002:a05:6214:3c9e:b0:90e:98e7:4481 with SMTP id 6a1803df08f44-9122e67604cmr95381566d6.29.1789437335040;
        Mon, 14 Sep 2026 18:55:35 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5ebc79sm109264546d6.48.2026.09.14.18.55.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:55:33 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] EDAC/i3000: Balance PCI device enablement
Date: Mon, 14 Sep 2026 21:55:18 -0400
Message-ID: <20260915015519.83833-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915015519.83833-1-mhun512@gmail.com>
References: <20260915015519.83833-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i3000_init_one() leaves the PCI enable reference held when probing fails
and when the controller is removed. Disable the device on probe failure
and after removing the EDAC controller. Keep explicit cleanup because
module initialization can call i3000_init_one() outside PCI driver binding.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 535c6a53035d ("drivers/edac: new inte 30x0 MC driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/edac/i3000_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -461,6 +461,8 @@ static int i3000_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EIO;
 
 	rc = i3000_probe1(pdev, ent->driver_data);
+	if (rc)
+		pci_disable_device(pdev);
 	if (!mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
@@ -480,7 +482,9 @@ static void i3000_remove_one(struct pci_dev *pdev)
 	if (!mci)
 		return;
 
 	edac_mc_free(mci);
+
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id i3000_pci_tbl[] = {
