Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4F568FA6
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980130; cv=none; b=Kc7dMGqqmcCphixgjPDfw9g189mzpfoPvp7flAMiTD9RhYuYtOgeBSNoKtv3lNEcYliI8ZjWHNGLRgUEky/qgduU8Un/DsnrP4ErTKDi+NQeWcPBCABxH2i30LgEbhEputpNXswNhEpI1gtA48Ko5Z06sTNEmyYURCNYxiK7NAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980130; c=relaxed/simple;
	bh=GxgaoHTEeWKtl4HhY3E7gUCh50JHl3GhPmpQC6tVBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNkVtNN/alu1O0Q7iKN1ewJinuxyG8+aTLulcGXB5vJ7NMnX7lQXO8ThtEn1UsIx11bPMJ/iIhBqeO3Wll8JVZBWr5JtqGbXE3NCLkKY2bVRpmMaldMC10sAyisVPzu5D6gBgr0fjXsRe8IhTXuwjGRDcebw752q+VEXX11MYUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Tq7Hk5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Tq7Hk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0326F1F00899;
	Wed,  9 Sep 2026 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980123;
	bh=RjrvZDuZgejp9ene+v7H+B3N9Gg+MYyes4vnc3ACOIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0Tq7Hk5sWKE1h5pv6Ay+BBcl7Wl86DWdZWVwXUpH00/HoUIWiINzU4CIhSFKC6Xf
	 4qIEn5la7DgDzmLdQ2JMR0cBRt/Lb6Kw6rhk7HJy/eSyjDRw9WD5X/mFSo1OGMsO2o
	 AoWtRF/pKtchtXqHmbh6OpJeaXbX5GNn4AQpnb81oKnoI/dpsfCD8A6i3D5YckxjjB
	 s0vw8QlMzzGWBjrTzM64+nRd/ToX0lSg0PIT9A7o8Es7sPjffpvkjXqN5I59zbXRjv
	 zihdDQerk8hFJCqSfAIiLjdm/SbNRDCe4qb3t0EYF5B+99UOhIIpc1Cfn1X94Qr4RD
	 ojLg8hRjgVFFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mfd: sm501: Fix potential memory leaks during remove
Date: Wed,  9 Sep 2026 14:55:20 -0400
Message-ID: <20260909185520.3489928-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909185520.3489928-1-sashal@kernel.org>
References: <2026090351-moistness-unmoral-5211@gregkh>
 <20260909185520.3489928-1-sashal@kernel.org>
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

