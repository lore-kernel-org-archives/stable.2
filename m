Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8041DED8
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490058; cv=none; b=VjE9yl8FkWXsIhgGZM7C4LUyhDYiiCkiNClaOcpDNWHbQ6MddDuisK55QEf5Dch0rXrnzP/eNji7GcTTDEwMz4bFO6p5FA1ynatgdXml7DNCAfa1RQeNb78gXMgdBIolBmTzPsnSC6lG10YRbbggxkD0aGrBpLO1KNOfPfO+YgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490058; c=relaxed/simple;
	bh=w+wy3Zmnjuh4KzNyxe+F38tO+npeTxZQOTHLGalRLQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYpj9YL2EUV6TF45zQY2+kqJl9ceqCgkxeCiKEads7emkzOwppcNZNQ39zkLa4wCa9jSe4Zk+BiyHBFEzqE0Wqgl8rJs9wq6lohPCn8uJqCwF5NxuG5lJh7xk/gMB7tGT1Zth/XNM1qiXjPGf3FnaoVkTbBMCOKuAk7VhhmeMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX6othJU; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX6othJU"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a8568e9so2609063b3a.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490056; x=1790094856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P5PBkSmo/nkOEVN/SlyuYsHkoJMTZFtCBpXsEWdCJrQ=;
        b=fX6othJUdnCSkVl9v7DCCDAxyIVse17qto11EAZpCO/4p9Hx465fhJkbUN3yvxG1ze
         nSfAXGL3745D49oYZIPj4byw+C7/O7/Sc7yq0/NGL3z7/XsljDsb3pLg3NYc+Lx9c4Vz
         cKT4i23JSGwIpNshD5scDBYUaJHV9Q/oJiET/FzjMwUfMM2i8Byzt3gxJt0h1Q984VCo
         Q3wowoq6cEkGTjdhTxlEYHlqpfLcq5KHKvh+xpeCGM+SzqgNpQI1rjyT8Lo1Ee+0GDtw
         /lmxmwtr8HazXKu/BKb1ffb19DXO2xBNVKz1vbFUer/f3kh9iojDtHfTrKTtHS8olcSD
         c58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490056; x=1790094856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5PBkSmo/nkOEVN/SlyuYsHkoJMTZFtCBpXsEWdCJrQ=;
        b=iqjyC1l1hgeAx/nMve+dyPUpIhFiqA9V8SUzoLOi9u3CU/YTAsw8ZCqip/TF3vMnzQ
         0IM53iCAItPQao/4qttbSQiwa5g0hq/1JiQgfI4XwQTmrbM6sTNso9Pqme9jLsycXzUQ
         PHFMFsLAjnTBcruB28FRqV8MrPbdZklB+Zt2KqZXUfT+CwxVl69oaLmGzNgEolhBcqTN
         sZfP7/JmMuQfjuSCEt8PstlWb060z8cNfxwVbUfqp1eU6aRcPtHhD333WSgvdo9jbJkp
         pI/3Kr/Am0PtNMg/Z60+lMfyaOkCvAdXMmzuz8Pahmewg/qeISM8a0nN+i8aQOcyLHAT
         NELA==
X-Gm-Message-State: AFuF++k/ZzNIAn+Cvp6DQO2UsWotHB1+Ywh7LIHbXF8XpnqOh5cZoRkX
	iEDw92Q3Xc2jgGYl6PjbngLYS4z6kQRm0hrA0XEhVWcWYxQ8mMMZrf9A
X-Gm-Gg: AYBFou27NJGSHzuA1c8gwJCJG01dgh1pMJJqB7CJYtocMOScy4h0jtOjq7NJ7cJqIQ3
	mrQNiW2zg7NhgALCclLeGorQW0MDgoSl7d1VZjGpCkkvN2rOqUKGp+P8ZLrYvQoEjQcj5rT0i8J
	HRl18vqyfp64BGIT1wN+GN7i6qxvdPPxeUus3jAGuMwl7NKAKjliuX4FnY1TwsCQ6HbI3leSh3S
	TgyCqYKXMspjpi/p4KOmfZPLbtSrALkSt14zZoI0F4RdKY8oWfCVto6nChFkZwzZRrVvx0h4mg6
	0DDS0p33VxgoHDpJD7J+0aOPcyMEgPeiTd37SHmjbZGrjVz3o6AqiREBA/6ZWJ31dSbWHn7tOcq
	RGkrhYShNbN7T6ks9TUr/JJBK1M83dwD5nTnpFyS9IGGFF64GjrA7mVj/MsckIhlkPTviaAwYmZ
	ne169aRI6dzLB4IS3zq82fXdqEdQlzjbhOS/Vx5XPImRewphX6KYUmzA==
X-Received: by 2002:a05:6a00:1414:b0:868:ce97:b9f4 with SMTP id d2e1a72fcca58-86f831509aamr15268715b3a.5.1789490056334;
        Tue, 15 Sep 2026 09:34:16 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b286c4e5esm6888113b3a.19.2026.09.15.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:34:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: intel: fix OF node reference leak
Date: Wed, 16 Sep 2026 00:34:07 +0800
Message-ID: <20260915163407.2487869-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ebu_nand_probe() gets a reference to the NAND chip node with
of_get_next_child(). The probe failure paths release the reference with
of_node_put(), but the successful probe path keeps it for the lifetime
of the device and ebu_nand_remove() never drops it.

As a result, each bind/unbind cycle leaks a reference to the NAND chip
device node.

Drop the reference in ebu_nand_remove() after the NAND teardown using
the flash node stored in the NAND chip.

This issue was found by manual code inspection.

Fixes: bfc618fcc3f1 ("mtd: rawnand: intel: Read the chip-select line from the correct OF node")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mtd/nand/raw/intel-nand-controller.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index 01cefdaf115d..9f3e3a6cec71 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -711,6 +711,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 static void ebu_nand_remove(struct platform_device *pdev)
 {
 	struct ebu_nand_controller *ebu_host = platform_get_drvdata(pdev);
+	struct device_node *chip_np = nand_get_flash_node(&ebu_host->chip);
 	int ret;
 
 	ret = mtd_device_unregister(nand_to_mtd(&ebu_host->chip));
@@ -718,6 +719,7 @@ static void ebu_nand_remove(struct platform_device *pdev)
 	nand_cleanup(&ebu_host->chip);
 	ebu_nand_disable(&ebu_host->chip);
 	ebu_dma_cleanup(ebu_host);
+	of_node_put(chip_np);
 }
 
 static const struct of_device_id ebu_nand_match[] = {
-- 
2.43.0

