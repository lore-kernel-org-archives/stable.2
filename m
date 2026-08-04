Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C9D45C6E2
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842506; cv=none; b=VXPeGMBPtsScB8HJ7SUNgWxtw2zgptTxIx/zATDzo2CngKTZH1SkxQD3/snP0mSjAQiwms6RDMsMAbhlJ2LGlqP1BIxVzdH3AFJOknqrDlouZVNbiHaYWoFjltDuPrEXqde/wQls3VFLasXM0iNCw3Iy0MB6EehKJaaOrf04HPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842506; c=relaxed/simple;
	bh=YivSjq1wOwq0kkKSjd6/2xnjq1SVmDwDg4fV7fniTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXtP9uU/ZnFBsPTWiIbTr8fqOm9LiCdyrBL6ICV1YgkplvXZAvZ55ttiodFCQXjeDI5R5IfT8Xx7J6L2oQ6vuvRkV0ypKfsi2AYsJ+UVCT0xILvqiluzZBL2sqBXSJ+TDnSffe0SLf80t8wWrSSBCsHMPwWeTKY4AKyDWlxvP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdYD6sj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdYD6sj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069061F00A3A;
	Tue,  4 Aug 2026 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842502;
	bh=LGUVltlgJgUcr2aGGLszZLcUV2AEFZtxpBvu9AVI3dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TdYD6sj+lQ1TP+nBEFQOQ7aLGZPmPUyh+0HWsWlh5M6eIiw4ef+924tcqeWbBChWU
	 J0/5g1C0c1Ia1ASttkfRxUT/H7SD54n6fDEL5GXKDxz3GqRxDukHNF4ksUlLOHi2/t
	 qIgcW+fBChY0rrEqEK05sFzzkDU8ds50yVh2CjkOn8fAEh0boPTdJguLWmjynUj75D
	 Auh83ey330bKz2z/ihIU2PQc582ucUTb6C1WE0tX36WIr7wSDm7FMsNpLLsGn8MAFx
	 v56P5wIgDFJRWx46ES474j0olEq+TLp1kQLiB9O1IbHfhKOXy4BnUv67E7CEm4juAm
	 hsIrQLVUBxzjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: marvell-cam: fix missing pci_disable_device() on remove
Date: Tue,  4 Aug 2026 07:21:40 -0400
Message-ID: <20260804112140.2939615-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072931-shopping-hanky-ad2b@gregkh>
References: <2026072931-shopping-hanky-ad2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 033ff0420e4c9c240ae5523fff39770298efa964 ]

During manual code audit, we found that cafe_pci_probe() enables the
PCI device with pci_enable_device(), and its probe error path properly
calls pci_disable_device() on failure.

However, cafe_pci_remove() tears down the controller and frees the
driver data without disabling the PCI device, leaving the remove path
inconsistent with probe cleanup.

Add the missing pci_disable_device() call to cafe_pci_remove().

Fixes: abfa3df36c01 ("[media] marvell-cam: Separate out the Marvell camera core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/marvell-ccic/cafe-driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 00f623d62c962..062155ccfe910 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -600,6 +600,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
-- 
2.53.0

