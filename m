Received: from mail-pj2-f35.google.com (mail-pj2-f35.google.com [74.125.227.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D3379989
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525971; cv=none; b=JznbQHDCmKIs70XRxfpaVq3UInyxhNLLknx6xM9Yaox9O4SMW/qu3OzP6NV5+KsQut4bP6aEfAfpIouSSR4ui0qoNwbDroOzh+W7sni+EgssgRQz+v2F6Nxx+c8ATKE57TEojHUYfO6icS/n8gnwAJRzVpizZDF/5vFFRQR6Mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525971; c=relaxed/simple;
	bh=SuQIgv0SEoKEEDd+zO2LbMvRV51Ofr7lqHjGiCkVtvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WqPXv6TWcjzwAJe570aeIevrRFlY6gF/hdq05FvVS2lL2UBu5HG1Wta+a5CCH6bztOTtI5gS0U6wsISoRkX9L/8nQh13wtoPWlQgk6575jw/5P6XeA1lOl4xi11iE2vTUluQcNbh/lD5MZf8e9GgsVJ+IoVQFfxxP6ck0AwTCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU+wJL22; arc=none smtp.client-ip=74.125.227.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU+wJL22"
Received: by mail-pj2-f35.google.com with SMTP id d9443c01a7336-2dd77300825so4413105ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789525966; x=1790130766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKzmIBjxPsY9wwxZ+pV+iWoGbpiC0lGusYTUQ4D7CLo=;
        b=XU+wJL22/Nooco/rx5ryPoSHFCHZt/u4d7Y1Tewc4L2QMehWmMJqWcDgYxT6B/yuu9
         jcv3QLCFV0tWEwUTai0EZZYjmdKD7N2pBdQXGV1oO7+Lkie6ZHMzeIVRaH8LPhHOKGfd
         tYd+SnrqMUtFxyJ4E9WNuMc5LSNlo4c8oOINJTkVys35TvsoNbSdHAHnhMkrKcfuYibr
         l+6YEDOx8Oxoi2l4z/fBTeZoBF9d+UD+euft+9Q6iSfSqvMC46FZirsXy8GKrqa4ahJd
         5YlZ2XmNlr1MhRfHN24V515fRrawxC0A6BLx5nRMdfbbtLDyEn0o3Ey/G1lsX1xj6H8j
         708Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525966; x=1790130766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKzmIBjxPsY9wwxZ+pV+iWoGbpiC0lGusYTUQ4D7CLo=;
        b=ULRqAPiwS5t7fXSIwu1r9ukSBr59aG70aqCuH+8VvBGdaqUfQYVSFT0LK7g5XMerk/
         G5FNvkTZSMG8Cicg5xY12qo9R8ZdPID3kwjMtpSR2vtl33mKAPTB1coiwerwMgLFKLe3
         XoWPkfb2qp0hBYDgkvqrblgTHhRFz994xuA9JtUeGMDzEEi7GoEZv5wjnTT8mzcBzjFU
         wd+DoQc5p1fhHSlqkTpwtHP5S9vxcKtPnexucSK5qaYgV3pehJGHie1rL69v1BI0MRnE
         BOIbKUZ+vmxzCJ/wFzhFodnW9TSzO6wzCkusYSpUEppJu32LK8oSNZvcDWgZOm2DDV6v
         koYQ==
X-Gm-Message-State: AFuF++lsbXYCSkeNUtUNYU0/IY0gvlTEbjzdOEkXeVH9f7N9c8Zpgvrh
	BzXsi0R1RhtTd2UT9nGsRsuxrCT/2SW473NOH3xBn6MxvUn+Zl5M/2Daf8UkdZXq
X-Gm-Gg: AYBFou15ZsvVteUVwuKMHA3KFBSqk9XnZcOeL4fh0KjN9cBEchdGOxGf8FOZIuVz0Fz
	dZcs3e/RNf5TdLy+ji95yx5IbXy5aMCtSYSr5S1uuQ8X7ILUsbOeZbuMIebekUGXBlPPhBGEss3
	AEFvQvim105YJ1wIUJpQR25tXgVHUBs6A9LuosMZKO9wi7IR19M1wIKhKPi30pYy+hLg9X0aVRB
	euikb+1v5MF4fzKrjygD1TrYKzvKLEVTDxZ5QaodaJ805WfEAEa9sqImkjOizvAky7n/8PCbx/N
	KJNNHPKIb4NYk0G80oUYcKUS7LTQNCX+KOCw0o5ammmrrxVRoKLNtgh3psvHcx6BGHjoc5VjbG+
	+RUWKCcPKKn3a0E7IK7t5017WryfnAwNGUxBjv/WX5ZHqH69puk31+Wipln3Kmvd2PAPlD8R6Z4
	Njr/Cr9ApLrpWwho1Pd71/3ucAXnqz5BlhXpuyxcVanh4Gcap+O9ZViQ==
X-Received: by 2002:a17:903:19c5:b0:2db:8019:847a with SMTP id d9443c01a7336-2dd8e012174mr17506605ad.9.1789525966646;
        Tue, 15 Sep 2026 19:32:46 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eff35asm3456075ad.58.2026.09.15.19.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:32:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Netanel Belgazal <netanel@annapurnalabs.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: ena: fix MMIO read buffer leak on probe failure
Date: Wed, 16 Sep 2026 10:32:36 +0800
Message-ID: <20260916023236.2701485-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ena_device_init() initializes the MMIO read mechanism with
ena_com_mmio_reg_read_request_init(), which allocates a coherent DMA
buffer for MMIO read responses.

The normal removal path releases this buffer through
ena_com_mmio_reg_read_request_destroy(). However, if ena_probe() fails
after ena_device_init() succeeds, the error path destroys the admin
resources and eventually frees ena_dev without destroying the MMIO read
request, leaving the coherent DMA buffer allocated.

Call ena_com_mmio_reg_read_request_destroy() in the probe error path
before releasing the remaining device resources.

This issue was found by manual code inspection.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index ea89619039d8..86ffda1c8632 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 ena_devlink_destroy:
 	ena_devlink_free(devlink);
 err_metrics_destroy:
-- 
2.43.0

