Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54802420888;
	Mon, 14 Sep 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385059; cv=none; b=fZ6kFGHK0pg3IZzDmGQ/OdrASvh+pPtHI/rWLFoaxzCWqhM9EUwU6eS4r780oOlKU2L4ygjflp6Q7R7dIAPioDxK1aytRLK5D7NtPteLjwnMiBrK+3KElP8RGEQZuu+oJcl68iy+wM3eJxA8aoSoAyv4+t8XcF4X/7SqnMZxLe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385059; c=relaxed/simple;
	bh=DP9/BrDpupTrBVIifpuxXNvScYxUQ6sFrLK6tasH/is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fyRYB3/zFDUxBoGsR3D/7s1x6R4dvue4D+8B4hwJjtFjkZolZWoMxHcF1Vh84myec/U3lyZjjo1sihCOCiB7417HLJiZ38UM5ZvVLPVDQhdd8F3e9KE9KJn+iMirZjDoIjeReXR0UKnOESBoyOzfx+vRrGQISekhgk3TQXU+jAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RGNZHyrL; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RGNZHyrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EG
	IxVHESNotLjxa6twY50arJ5UcB1e9LUU5MbbH3Nuw=; b=RGNZHyrLty5C8icCso
	e15wcLG4hHhUx7fHAvQHWkIoK8ZSiQZAnO6QFXpSoHjmQjSWSI/FdPE1GkYM6+fe
	XX6MeE6manONYSXjZ+kb+Tt01WXohWA9fOcpcZ9BHu7qxQt3y8wuxrXS+WDCoZlG
	0/5Aemi3akvtyhe90OzXdgmTQ=
Received: from ubuntu.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXQhsq2adqu5gpRg--.61345S4;
	Mon, 14 Sep 2026 19:23:28 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: peter.chen@kernel.org,
	pawell@cadence.com,
	rogerq@kernel.org,
	gregkh@linuxfoundation.org,
	felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: Fix PCI device reference leak in cdns3_pci_probe()
Date: Mon, 14 Sep 2026 19:23:20 +0800
Message-ID: <20260914112320.4176773-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXQhsq2adqu5gpRg--.61345S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryDAw1kAr47Jw4fGFWxJFb_yoW8KryxpF
	WrWF4rCrWxGry3trsrXr4UuF45Cr4Sy34xKw4Ikw1xua15AF4UKFy5ZFyUKFZ8AFWkXa4U
	tw1jqw4q9F4jy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJ3ktUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9hAHEmqn2TBsxAAA3-

cdns3_get_second_fun() looks up the second PCI function with
pci_get_device(), which returns the device with a reference held, and
hands it back to its callers. Neither cdns3_pci_probe() nor
cdns3_pci_remove() ever drops that reference, so the second function's
pci_dev can never be released.

The cdnsp-pci.c driver handles the same situation correctly:
cdnsp_pci_probe() jumps to a 'put_pci:' label that calls
pci_dev_put(), and cdnsp_pci_remove() calls pci_dev_put() as well.

While at it, also add the missing NULL check in cdns3_pci_remove().
pci_is_enabled() dereferences its argument, so if
cdns3_get_second_fun() returns NULL, the current code may crashes.
cdnsp_pci_remove() guards with "!func ||".

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index eb5760f75b9d..d18c15fb9365 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -89,7 +89,7 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
-		return err;
+		goto put_pci;
 	}
 
 	pci_set_master(pdev);
@@ -98,8 +98,10 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		wrap = pci_get_drvdata(func);
 	} else {
 		wrap = kzalloc_obj(*wrap);
-		if (!wrap)
-			return -ENOMEM;
+		if (!wrap) {
+			err = -ENOMEM;
+			goto put_pci;
+		}
 	}
 
 	res = wrap->dev_res;
@@ -160,11 +162,13 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		if (IS_ERR(wrap->plat_dev)) {
 			err = PTR_ERR(wrap->plat_dev);
 			kfree(wrap);
-			return err;
+			goto put_pci;
 		}
 	}
 
 	pci_set_drvdata(pdev, wrap);
+put_pci:
+	pci_dev_put(func);
 	return err;
 }
 
@@ -179,8 +183,10 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
 	if (wrap->devfn == pdev->devfn)
 		platform_device_unregister(wrap->plat_dev);
 
-	if (!pci_is_enabled(func))
+	if (!func || !pci_is_enabled(func))
 		kfree(wrap);
+
+	pci_dev_put(func);
 }
 
 static const struct pci_device_id cdns3_pci_ids[] = {
-- 
2.43.0

