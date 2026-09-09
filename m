Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE58357D19
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980841; cv=none; b=tQewAoMyue3HVdyV5pib/kZntj0eYtAdIaSdH413lHGBe35GLhy+ChuFnd6KrRNU9jbmEuFJacqYt1GVo+2NLvdBkEG+Y8gcmmHlBMkCABZplfKfkZX4c/KMbckT8JVfmp1/ni9s4TQJc0Et805qhvfpEiHUUT049eqBLQlO9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980841; c=relaxed/simple;
	bh=GxgaoHTEeWKtl4HhY3E7gUCh50JHl3GhPmpQC6tVBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0jZMF7XbeNW/kZRAN1fdJNd8WPHGL/Uzq7cp+c7tcNANoN8Z5swkmXSj9Dvqurd+ycFh/EZqFnpuXBd73SM2/TQmJsmw7JR8B/MNR+CrPFT5lIylAA1QYYuI4qazF2SOf/k/A4a6wiD85HxOn+RgKNneFyO0Yj/hq1r95UGDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvTgQiOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvTgQiOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2363E1F00893;
	Wed,  9 Sep 2026 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980839;
	bh=RjrvZDuZgejp9ene+v7H+B3N9Gg+MYyes4vnc3ACOIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvTgQiOB4kSAUQV36BPnCUWkzrbhbw7QmXI9wgNVws3wysQMp5zttdHQ+PyOqRdn+
	 aKCegzDQ+Ss1WGCON6lHn0FFzgmiVGoxWyc4BMj08Ii3CGrlt5oEQFat+xg1Zp8WuG
	 51vAi/Sqb4ccvAZ91eSiaoeX5cRBNJF8H0x+yjRlorCSx8Xn2WtBAUWKq0T0iDrBFP
	 zdBFtSaNQHNbq0ehin17YvCWOXedyez/SQzfd03YvvFNI+sPDx3nOSYTTCSmgvAYsP
	 nb2k6x6BsXgtUaF0HrbXBZH+xhT6ZichI2YivG2Sv1ki4HvRIqj8uzMGGuD90ZLtpq
	 FiO4DJSjKL5zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] mfd: sm501: Fix potential memory leaks during remove
Date: Wed,  9 Sep 2026 15:07:15 -0400
Message-ID: <20260909190715.3536119-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190715.3536119-1-sashal@kernel.org>
References: <2026090352-reptile-skyline-e58f@gregkh>
 <20260909190715.3536119-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 83feedd9d83c0c5199f98c72df0a6196b4aefb4d ]

The memory allocated for struct sm501_devdata in sm501_pci_probe() and
sm501_plat_probe() is not freed by the corresponding remove functions
sm501_pci_remove() and sm501_plat_remove(). Fix that by adding a call to
kfree().

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260720113836.73133-1-nihaal@cse.iitm.ac.in
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/sm501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 06e796883189e..5752099683eb4 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1667,6 +1667,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	release_mem_region(sm->io_res->start, 0x100);
 
 	pci_disable_device(dev);
+	kfree(sm);
 }
 
 static void sm501_plat_remove(struct platform_device *dev)
@@ -1677,6 +1678,7 @@ static void sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
+	kfree(sm);
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {
-- 
2.53.0

