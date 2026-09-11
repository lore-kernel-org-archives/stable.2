Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192945561F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128525; cv=none; b=nSCfI+R1c10bA/hkUjEvUz/wLjA3lbYTHXxW4ibsTfsfzT2P+Sg/SK9eIWFXq1pxBrF6Abb1aIHwuymxcHSQp+bbGcxG7POI7mj+dKLnUsDjY/Dthxgj0YwnEeKCbMfjv/f6GXe5EaCjBah2kPbe/Kg+wLZ19n7zzzlDMYlZGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128525; c=relaxed/simple;
	bh=fSfLONgCcz+ekspXfYqXQHhLS7NVgCdd9qMidKLG9EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f11AAS2bN3NAatorQHNHSZl0rujRKrp1xKjeezVOaOKE+b1dHwrnnehmF0J8vs/sEpFoGZbIRva0f7qKbgWq0BjyzyGb+7QLVufUuGoclvfOV7a2VNxRUQjaaH4lNr0AJTCMZ49k6QKwoiMV0IpS+z+DLIZoAlOPU9vdgVyJyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8QDRqqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8QDRqqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C21F000FF;
	Fri, 11 Sep 2026 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128523;
	bh=QBREfrg5RTQ+fAm8myNaJ3S0mu2DaKw7UGB03hUKY0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8QDRqqtt62WKPaG08AQ6B/rKjUId25fwwX0SAfTO+l+HolGrdMT66qt8nKn17rjW
	 hBY3ynZxk9W1Hps0J8XPRU1kuP/1FO/gKXcW8QYFLjbZb1HNSJwGARXO1boDmKggRT
	 hdevsje+YxpMJOz1C0rHm6OfdVdQV9JAgjSqdDcm1CGkYa1zsAyuaicJ+NCpzLb+VI
	 i6RtSK/EDPxu/oZ1zE6+1LwCK7kBmFLEx7mJJB6LuiZbI8NpDlLQbU+i5IYp7s56Ne
	 OlvPcWGRcWKwMSNUn3/OAMKNW9hhEcJGtYXVB2O5vCvaVl5thu7hlaD+WalIPVZD2k
	 C4clgl5ydxBEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: saa7164: fix cleanup on resource allocation failure
Date: Fri, 11 Sep 2026 08:08:41 -0400
Message-ID: <20260911120841.494587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090952-april-junkie-ed48@gregkh>
References: <2026090952-april-junkie-ed48@gregkh>
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
index c10997e2271d2..6691042cc4211 100644
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

