Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D043FFFA8
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392653; cv=none; b=djD19hQQwTlted6LlK6Qx7diTg5dlonTuCblnDivoiu42U1WsdILjeDSpihhlrYFVfKXRTu6OOtKIgarJE+A+NYG9KtCaksBjZy0pBfn+UEQzn8p9MnVI2G8SsxOfbERGxaTC2vsqom5O+H8NYfdSB0fwH2WKFWZuRQ/avvluIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392653; c=relaxed/simple;
	bh=IE9uzs2DfEHR/K6U5+EleAkKoKjLhWPifcX2XlK3Wh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY2K2nP5ZVFZtlpd4GSdjRVlDqthqB8dRMqe71q7YEBXz1rgxwpzpMJRThkII7Od6PjMQUb3JgYWFW33m2dTI0o5oJH6vCrER2TPwRPijsgLuP2m86ZQ0au6WiFPNWyfUB+kSLYnPjzxHnUWlL9OR8z0NTqbp3V19QxbeZ5QMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFWuLy/q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFWuLy/q"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79f7so13080985ad.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392651; x=1789997451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BJaElS3MZVd4zd/Sev0Vi87r/VeJDnrTVpf4OPQWFKo=;
        b=IFWuLy/qEDvgw/Hkb53foLb2aki69NHhPf/sYVe8ybe5uNx1ifXSvSxX8Egr1d+3H0
         m9QLhO8fz2BT9uTjboHbia4N0XJgHrjCU0E5NoedA8naEw+zPvEH7NacltPJb2eHgtYY
         rnzfg1d75y1/PLP1mddD6xKqkayQCr5ixlkoTXOJMa94e9+rfukwoTwEm+21x28rBKWB
         pyyi2197cikfqnXRRz+zN3MDDdK6ujxVxJXZGd/F8ZS1wfH8PfwQBPPYv6gXGNyNY0ga
         KbYsd+AQBz6xNHIs9oT2gBK4zWrnWpouF8OOwfDpW8C6xqsN1b34Dto995LY+POB+pEI
         Od9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392651; x=1789997451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJaElS3MZVd4zd/Sev0Vi87r/VeJDnrTVpf4OPQWFKo=;
        b=sUore/qQZS6XnG8Av2mqGnVJTc9Jjr7BLtNo6xLLUUxePoxbByVLOsKAmMzH1rSNo8
         Rto+6g9zOb7kBhPaGrfgobmL+EZ0a12HgvYB43bhvwp8bfrZE7N1hFjvuC9UwNKHe4Ts
         xI4pHmCO9yy3U217Pgw1OEGk0PxymYEgzTo0efUA52PUqlynsJ6NPUvIUAmjym6zALwa
         YHxJ8PQcGp0c46ah7sGhKWOuGZDb9xq8BGBVjl2i4vlfIRDNXbCtHsof7irifhEiRRZ8
         ZddcGgB/ZcvzQZhpHXS6qpi4QOZDLlVio1ZAdZdEAwz3RpX8HX1y7LrsHQV3rKIdFhJs
         8lDQ==
X-Forwarded-Encrypted: i=1; AKwUvByNheOxiO374FbbZ6/wkZE42rzctsViDlJgk86Ruqh5V6iF5BDGpn7gziF9Qoz092eh1ARoJz0=@vger.kernel.org
X-Gm-Message-State: AFuF++ntja5XaXjlmGflmnrJrzA6QneTeOq3LQk6qniy440uQWf2UKBe
	OdxSOhz9TEAtPPJdrPB29hVNY5ndCtxuZxMjn3SNtxFEwP+DBF0QYIrQ
X-Gm-Gg: AYBFou1Q59J9eKrQPGqgSaZTuEBDw6W3eg4W/Uo0NhWRbNwsMqRL8+vIq/1kk+D/UeS
	7G8yEIYSW/KCAKxFvDVghOOVwl3cUIPheEI0maiNXozk8qzuPKB8Rs0xpHItOEYa6Oy0JN0uQxP
	vTr/OYxFtyCAnnvSqZTH1chJhIojz9MS5PhZVQ6tz6AHT+47YtUcGZFn/gBOGs5TdG54rWbLrgE
	+fwWcp8eK3Z7AfCf/ftnverFk8BeVCix7jhtx5uZiFQEhSoB87+0VrM7z3JpaoPQZfrbXwDKnTR
	rgKwDuhMVxo8xqXAjM+rrGmMaP2BB5GXVuEoBcAd1Jf5SwnpvxpbaHH/ilftOwvwoWwszUrW+kc
	xltJHuT6jhfU6n7d+hFyZ4wcNXRGG+ByC1GUzPdK38U3DQyfBxwaRYIyri+MRuIfd60KuwKu1oh
	w79p1BXjQuiSQxhCw0Y8xUDZLnXS4H9YogTOr6C8pnfHhLpp02WJUSig==
X-Received: by 2002:a17:902:f70e:b0:2dd:752e:6d69 with SMTP id d9443c01a7336-2dd752e6effmr6027245ad.4.1789392650893;
        Mon, 14 Sep 2026 06:30:50 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd428ede1dsm39850535ad.13.2026.09.14.06.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:30:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/sprd: disable clock on remove
Date: Mon, 14 Sep 2026 21:30:39 +0800
Message-ID: <20260914133039.1732900-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sprd_iommu_probe() enables the optional IOMMU gate clock through
sprd_iommu_clk_enable(), which obtains the clock with
devm_clk_get_optional() and explicitly calls clk_prepare_enable().

The probe error path correctly balances this operation with
sprd_iommu_clk_disable(), but the normal remove path does not disable
the clock. devm_clk_get_optional() only manages the clock reference and
does not balance the explicit clk_prepare_enable() performed by the
driver.

As a result, successfully probing and subsequently removing the driver
leaves the clock prepare and enable counts unbalanced.

Disable the clock after unregistering the IOMMU device, once teardown
that may require access to the IOMMU registers has completed.

This issue was found by manual code inspection.

Fixes: b23e4fc4e3fa ("iommu: add Unisoc IOMMU basic driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iommu/sprd-iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c1a34445d244..65a970ad4c9f 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -524,6 +524,7 @@ static void sprd_iommu_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
+	sprd_iommu_clk_disable(sdev);
 }
 
 static struct platform_driver sprd_iommu_driver = {
-- 
2.43.0

