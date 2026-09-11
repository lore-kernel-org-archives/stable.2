Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF56470EA0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129189; cv=none; b=K0UDbCUW1qnP1rISVuQJa3UZc+Ttz/bDRdyRaad1+a0xCFutcIGb5yxvmNOiShByZCKKr0wXJueHdkNZ1wppsZJ8vMatU5F8C5YLsUggrjgyBQBur/VrpQdvIH8man8Ql/1jBtxotjwlsEeiDDhdN10eHOG2w1VoVhzsL6igPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129189; c=relaxed/simple;
	bh=sPPb6IKqbl9zScPC5lNnekqNiy+JUuJq317JvMdMlKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN8ivUPXy7AzqqD8C9aCYdMVfYOS0HhoCDspdG4wTdL6iu0XgsBbBWxjSle4pSY4uxFBAvKz+wNfFR/yob73RPk072fTDo0zbDYjAvA8YKs37VmWIaJUyxsv+bX/cx8X5i7KfhNZ+r+XWZQRQ5nrIJdQ3H86irFFVIFdzS82Znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhEc6bPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhEc6bPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA51F000FF;
	Fri, 11 Sep 2026 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129176;
	bh=PwxSMtqSwHw1pleam0oUOuL6WZdPsbKP917GwZJfy3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YhEc6bPLe5uiQiaVioTtYCIW3y/uyVXxkrz7Xcf6EdqkR6fFYu0EEdT3rnXpkUEHi
	 a/6KBff3RUTcJv4LpEBBXdlWjmymIX13bh3SaTqJalfJEKop3miORpLwhEBy+SWKDX
	 JIlgHX8EjWjPw6NWX2W7mB4OwUYsuE/LuLOpolsjGd146+fEQdHRIki4Qx+lmPu+u5
	 DmmA3tfgWTIfbaYnFWk8LQSDHT2n6dY71aiDB7MZDatknL2DuM8CPXImPOUSMuPCgL
	 SjUFvHK2eTRi5BZGAKaNxlQrU1eNPXhSxn8YgSDAiTlUxuL6YRVruP+meYLYH581WU
	 wll6Vu4eerxSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: saa7164: fix cleanup on resource allocation failure
Date: Fri, 11 Sep 2026 08:19:34 -0400
Message-ID: <20260911121934.514642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090952-skeletal-related-3a42@gregkh>
References: <2026090952-skeletal-related-3a42@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 28e84c6e2e6753ed238ea097b2842a32a6a6879b ]

saa7164_dev_setup() adds the device to the global saa7164_devlist before
requesting the PCI BAR memory regions.

If get_resources() fails, saa7164_dev_setup() decrements the device count
and returns an error, but leaves the device on saa7164_devlist. The probe
error path then frees the device, leaving a dangling entry on the global
list.

Reuse the existing MMIO mapping error path to remove the device from
saa7164_devlist and decrement the device count before returning.

Also release BAR0 if it was successfully requested but the BAR2 request
fails.

Fixes: 443c1228d505 ("V4L/DVB (12923): SAA7164: Add support for the NXP SAA7164 silicon")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ Inlined err_devlist cleanup with explicit mutex locking because the shared MMIO cleanup path is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/saa7164/saa7164-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 3cadfbe60fe6e..791bf4259b1d6 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -880,6 +880,9 @@ static int get_resources(struct saa7164_dev *dev)
 		if (request_mem_region(pci_resource_start(dev->pci, 2),
 			pci_resource_len(dev->pci, 2), dev->name))
 			return 0;
+
+		release_mem_region(pci_resource_start(dev->pci, 0),
+				   pci_resource_len(dev->pci, 0));
 	}
 
 	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx or 0x%llx\n",
@@ -993,6 +996,9 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 		       dev->name, dev->pci->subsystem_vendor,
 		       dev->pci->subsystem_device);
 
+		mutex_lock(&devlist);
+		list_del(&dev->devlist);
+		mutex_unlock(&devlist);
 		saa7164_devcount--;
 		return -ENODEV;
 	}
-- 
2.53.0

