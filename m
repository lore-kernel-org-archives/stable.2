Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A9361968
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984072; cv=none; b=biZiVhoZqOLIa7CpHZFq2V92AnHjxH4jtQVYro1CRePKtinsu5zHLD6QHY88sPQhilkg9UIX+HZUdVaC9J8CiEe5rnZHVIsTsT3Jr+7LvW6cqvf0c4mS0S5C0yf2afH5bREzLm5QSt9XavFAX6+AbeW2CokpPOY33lCDlnLVeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984072; c=relaxed/simple;
	bh=5SKaE4jkBIxkiDaVd9tl8UlPKJRH3rwtTl1DGrzcJK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFUYXGYscwRcexCir8U3yL1K01RhFszRXZa3FtfqckJyLryDF7lTz+Mz9bRICoywmQHd5QT3h7St7jfLtN1u1T7YK4ZwjCA9PyqPio/1EWjScyjSryAddlfECxdrfLHfSy378Hkq8L1X1dOo49jpqLq7tGBQcQZ8YjVwHEpffRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVaf9O7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVaf9O7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B51F00898;
	Wed,  9 Sep 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984069;
	bh=4irWYAKEpO+3DSlnKzKQVr6fJU6Fj4u8Dw/AaolPdf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RVaf9O7nSOTPiLlwgtZtJweLjxWQC2U6nIXqgM8v9muE5Qpygbxg1vFD/1rcbws+x
	 g88LMdPXh6FQ98ROyKxJ+YLMQ4gmC8zndiGPqQOAOFUYsYw0R/JLNorZ+uc8U4BrFx
	 odioq1qVPHGljskwLmorfTYFM9lwB35wbjpSi0pJvyEQARh2Uf6zaxb8ZuPeWj2BsM
	 tA9/SkqOQRkjIoMj+HjDj77eyLXBBnONDYghHphXhZxcAX14zeuTsWaS3bEdav2dQ/
	 gOUTLhzQVxDqXgeKbC6o0ZExXCKyeu9SQOIKqLd05LDl7Ftoeg+/wEKImH9HqtTD9U
	 1usnilmjv7h4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] mfd: sm501: Fix potential memory leaks during remove
Date: Wed,  9 Sep 2026 16:01:05 -0400
Message-ID: <20260909200105.3592162-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909200105.3592162-1-sashal@kernel.org>
References: <2026090352-pavestone-customary-a077@gregkh>
 <20260909200105.3592162-1-sashal@kernel.org>
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
index 5aae0c16bf47d..2c87cdb516e15 100644
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

