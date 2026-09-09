Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA53624A8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980487; cv=none; b=Z3AsdM1OcEPTOiCZZXnOFa1hO4uw/n9xjLjQEuHE47eSBK9lbYkTP9mNSnp8pDbJVb9s9J+YhDOo/FqiamNoKXKVasZQAFBEPGMtIOCQ4yi9Fh75SbSmIjFjY5q7MrD3yk0Baavo1QIGb5A/3A4GdtEl//guJXfUat6px0EG8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980487; c=relaxed/simple;
	bh=GxgaoHTEeWKtl4HhY3E7gUCh50JHl3GhPmpQC6tVBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzZyiGsTq02GZ8MNaimMNotlFotQrcd3hl9+3GGAWJbAWWHDCUxxs+NTo1noGsfKhL7J0ny4T5bN2Scel23XWZwDZdkXleWqxTSo203Dy9NhQQSBuWCR0HfM2JmTuHlDhIR10Qg4k+suK6eobd0nay9XtwOSQPu57+wGOy6mQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1t3hwwo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1t3hwwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DD21F0089A;
	Wed,  9 Sep 2026 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980485;
	bh=RjrvZDuZgejp9ene+v7H+B3N9Gg+MYyes4vnc3ACOIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1t3hwwoc/8MqWqEiLwrIkn9/7WfhjhLOw+1AorHrhp+Nmvpul/XzHtI5MmEELiF7
	 6yBBBbzXNv1WQ0LaSkOKOXPpFCsh/1uW3Lhfx6+wdtKh5G2Ups8HfymyvpXR9RQwEy
	 PVhWahg2/jEUGZ2EOau3nnggAxv0YMrwNLNdOR6NHouzkMPcdWGgzKOVM1tvRKRlsP
	 SRSbg+5C6aOUTBc47QTvSgXljqze0LGp+pW+beM5K5DQ31/hhJqc6OzG8gaGZS9E+g
	 MqLV/II4WHPdyWERXyaaqTKS/5U1BmMCcVYHIEsviYSk3rvL0IVa69fYQsCZdO08op
	 mmHhoeenxtwOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] mfd: sm501: Fix potential memory leaks during remove
Date: Wed,  9 Sep 2026 15:01:21 -0400
Message-ID: <20260909190121.3510965-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190121.3510965-1-sashal@kernel.org>
References: <2026090351-runway-afraid-7fc2@gregkh>
 <20260909190121.3510965-1-sashal@kernel.org>
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

