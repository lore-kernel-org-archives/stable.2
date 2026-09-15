Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com [74.125.230.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1054BD0ED
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473981; cv=none; b=C0uX0ar0xuOqZg/TKdVpLc4N2VNvrRlfGTgGDUU5GgZHUNcmyt+h/O1d178ErP0lTv5iu9PrEItyvXjey/IPyMnua47Zdc920Ge6ZAbwy+uSqhj7S9tokoEhMbF+9I50WmiPB878t2vNXVMG6FAhf0/brQ2GD8Vprtn6KGsf0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473981; c=relaxed/simple;
	bh=xLj+jM2KSSSCsF3YlCQPUNC8nNLiz+oGj3+E5AkfP+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEGwU6VxbFB2vwD6fwz8v44b/c1+SrBt36M5l4RYw5rhyPr9vI3v1XR6n43iwbfhiqRFJS3iok0/HdRZDDDe/ekC45bFaZnQCLmJMoL87Ip7qq7U/Xf22+jjYYrFhJUe3Rk6U9NRxbgoJ7WWzIP5M7ZvXB3Lk2xSW4RC8G0II54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9nYBiQz; arc=none smtp.client-ip=74.125.230.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9nYBiQz"
Received: by mail-lr2-f11.google.com with SMTP id 38308e7fff4ca-3a49e9e7cd8so25932211fa.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789473977; x=1790078777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WuLMGh0XOazeaknZ4mouWBM1qCV14oE/XC3P1nwDqwk=;
        b=C9nYBiQzQZtHErsA8fNyzbcIXDEE7wqFu5H1CBf+6EAPtNYFvUEv4jZORiWChpO8DH
         WEhmuHOj8hd0m6OdpnK4YRFkB02wrxJvc5KaX8j8dNhRMvcLX70wi3N1esKWmsVulF/9
         ysfuea5FV8WcoUE1FQToLUC+6wSIknHHwex9mhI9o94wgRsDI2TW8Qy7I4LxktLHL3aQ
         IdaaIIv9YrQIoUYLzjSvJ22Y77eTM6beExg0CKzPmxyHWQ3b+ScYwxVON3IdwW8tcWND
         SqtYgn9WyogFju6xT4CdTh+v2AMd8wBL+6wczURhc0E1qX5oHk/eEbAFe3mP5HiWNrPK
         gEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473977; x=1790078777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WuLMGh0XOazeaknZ4mouWBM1qCV14oE/XC3P1nwDqwk=;
        b=cpvuBYaKe07dqbm73tifFA9kOf9uAweGTA9fxYJD3eWAWiN529H/62ASAHQQ+vzNZ6
         Gk0+4ctznad0LyFnN7O2wC3jOJwFxaqEBj3mcAgd0d2fTBniXS7rAPDmS6Z7hbLdvEB6
         D0Tvi1SK7fEBFVmyn5KPOrzPajNS8JnZTB2RgZke9iyV7J+Qt/HU4pe6ZlxKWaUi9W+H
         QpmFRGS1CFi8PWBRCpJ2ILJC6tgj9FzNy8qbjd9SBx04JLQljckRkVxZ6elvokiiZeW7
         D8sGjGu3/qpHzjkUDCJc4mYoKa9nWhv8e/H3nufWLaw5A1f4JNS01Xs9GrY2GZiPI/Lh
         LFvA==
X-Gm-Message-State: AFuF++kvp7iR0hhmTqXSsPCZR0ok3XqtCJYXh9XjWgFUrXICSvwpG1ph
	4meaIZ3htPsEHraBapq7JJykLwRCHcDNZ5b98w1tGLamVL+vi6SCctYe5E9jMuqeO14=
X-Gm-Gg: AYBFou0ui0CeQSG7vbWIcz4OPyy1979+UYDVfcUeiA9ulrcWAJIVLuKOeHF6pwhO9j3
	nO8+et+Db0rou3PGXGle5BwRQP6DTnQdeag7Y+bA7htfQEtbCawm4iaBEHQnkurvjHmaan7d4v/
	yLhnA3hj74Pga4boRdycxgUIAVtpiZYvL/M3xSyBgWe8IdTiyKcLvxYgT8R/pzekWGO3CFl4qAA
	y0JPyfH4BklclvyxngmoLpn1/HVrBas6oethexqIxE0cgEvXOxdFKGqP7QLtFCkcg1mXmoVdJ0G
	ENny/JqBY8KpeA9doLMn5Nu4QV58sRsFPHlMDlfMSFUn5HFDibGymcAtYzuyspQPt78lyzfy1ZH
	RvdFXbgpFPbgoRcAztUIV5y0M60BzrjqJax/8mQ18R54EZA+rTBBvT21BlJ0E4EbyHad9Fpgb0K
	8ryUTwVFpkYsWE6CemZX0t7DNCDYYAAP7UZVKDubWAPqR2Z9BlKKRAlIDdD1X41prKIXh3hAySi
	/Qk72+t5r9TMNxMAPzkDV6980A=
X-Received: by 2002:a05:6512:1052:b0:5b6:1a7c:fd98 with SMTP id 2adb3069b0e04-5b8b4fd5a9bmr186841e87.62.1789473976400;
        Tue, 15 Sep 2026 05:06:16 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a047fd4fsm3186416e87.82.2026.09.15.05.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:06:15 -0700 (PDT)
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
Subject: [PATCH 5.10] dmaengine: dw-edma-pcie: Reject devices without driver data
Date: Tue, 15 Sep 2026 15:05:56 +0300
Message-ID: <20260915120559.106666-1-roman.demidov.nn@gmail.com>
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
index 987ede1087dd..95d60feca391 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -104,6 +104,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma *dw;
 	int i, mask;
 
+	if (!pdata)
+		return -ENODEV;
+
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
-- 
2.53.0

