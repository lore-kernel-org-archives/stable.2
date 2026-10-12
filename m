Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A293A0B31;
	Mon, 12 Oct 2026 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788638; cv=none; b=ZXCf4YCVDdtnZ2TvxzVwtnUUkON7glZsMiGqppNog4x3kHV5tvIOYeMvcOBm0Rs8rO2tpvmfcO86dVOZYL7rS1hLSzpsUkKDk+IjjNBr46FCjA/AJOGxvItu+7+iDeEOiG8YPM2R2Dwqn6DvslOAgNCOg9B0Yrm8jOvp/2N7rnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788638; c=relaxed/simple;
	bh=LvUoFsYWZSv70pcqEgisP40yj3CvqoHxmlm+2rkjDfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbLHhcBagTm3Luzf0R6tXeo9vbqiAdkj8/oCFrwW6nkERRZvNtK+fqy4xFGKmKVRrOzeGTuKzgjzCueLBkGbdwJpi90q+1s0qz6f4GyrrHzrBNe/yBTdSpLo0lveUncQRv9SC5WIVzUrrrdB4BBGWY3nQ/7BMp94iPxR2zpMCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XWdQWwJ5; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XWdQWwJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TP
	ubeSRgODtGgypVZSi/iOeayOGONu9PZYaJbTIcfMw=; b=XWdQWwJ5u5gQep+Zux
	tOLaYe1LVwE/Z2Koa8ko/fs9rumLG9ymdHcWHmn/ERSU2A0AoNDtFiJ4ab++lzZL
	/feRNTQBeVETqAqRwN9ggq6ntoprI7SO6sCcMnr+tRghR0ym353Z/Xtvu5iu7w2/
	OVAJZUmA12PkRy2dTu6TOZAU4=
Received: from ubuntu.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnD5AvhsxqWq57EA--.861S4;
	Mon, 12 Oct 2026 15:03:18 +0800 (CST)
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
Subject: [PATCH v2] usb: cdns3: Fix PCI device reference leak in cdns3_pci_probe()
Date: Mon, 12 Oct 2026 15:03:10 +0800
Message-ID: <20261012070310.3704130-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnD5AvhsxqWq57EA--.861S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4DAF4kXFW7ZFWrGw4DJwb_yoW5Ary5pF
	Z5WF4rCrWkJry3tr4DXr4Uu3WFkr4Sya4xK3yIk34xua1Yyr48tFyYqr10gFsxCFWkX34j
	qw42qa1v9F4jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9hZ8h2rMhjZTKgAA30

cdns3_get_second_fun() looks up the second PCI function with
pci_get_device(), which returns the device with a reference held, and
hands it back to its callers.  Neither cdns3_pci_probe() nor
cdns3_pci_remove() ever drops that reference, so the second function's
pci_dev can never be released.

The cdnsp-pci.c driver handles the same situation correctly.
cdnsp_pci_probe() jumps to a 'put_pci:' label that calls
pci_dev_put(), and cdnsp_pci_remove() calls pci_dev_put() as well.

While at it, also add the missing NULL check in cdns3_pci_remove().
pci_is_enabled() dereferences its argument, so if
cdns3_get_second_fun() returns NULL, the current code may crash.
cdnsp_pci_remove() guards with "!func ||".

cdns3_pci_probe() gained one more return path since this was first
posted: commit e5052f2c5c73 ("usb: cdns3: Fix NULL pointer
dereference in cdns3_pci_probe") added a -EPROBE_DEFER return after
the reference has been taken, so that path needs to drop it as well.

Found by code review.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- rebase on current mainline. cdns3_pci_probe() gained a -EPROBE_DEFER
  path in e5052f2c5c73 that returns after the reference has been taken, 
  so it has to drop it too.
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index fd06a3d8e638..7799349bba77 100644
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
@@ -99,12 +99,15 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		if (!wrap) {
 			dev_err(&pdev->dev,
 				"second function not initialized, retrying\n");
-			return -EPROBE_DEFER;
+			err = -EPROBE_DEFER;
+			goto put_pci;
 		}
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
@@ -165,11 +168,13 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
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
 
@@ -184,8 +189,10 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
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

