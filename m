Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBAA44A40A;
	Tue, 13 Oct 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857353; cv=none; b=Z05obiKuXKAgGMDPVLG+TT0/0PLqiomVAWgiRQN/GIs1ej+6qz9oPPR/MMKFV/X2/qFh4hrotgt5NMScGNVOcwefn2R/Mqi9n0jNBbGVbFh/wOyHX93BKshEV0wsZWwX987v/Z4L+Me2LlvxbqjtsAyr5Pt2c1kCTdOlZUMN054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857353; c=relaxed/simple;
	bh=i0MS4qgu9PObpyuQPeggxh/NmzNRKVcLRLyQV5MC8FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhD7KxnmJCc5vtcUCaTuHL2qcq5CLTf7bIba5NS7V3FCehtAWtGQFxMcRAqhvp0DCDS+sDYDNW/fvw8VwsXxUOXiMoc9o364jP2pf239aAWEfTM+txIfHzPs57oRqjPo1oXwd4tH0HTAq+xm3l6kbTzuCQrtq+gzpCrw5rgDl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=onqYbyY5; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="onqYbyY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=G2
	IJGoUUfLa2xG5P9/wT00uiOud9f9XwAM3xSFZ6TMU=; b=onqYbyY5uf6rW+Zjy8
	pZGfoTc0nJ/4V6uPxuodj/Z0xY14aFSZshyNGssifQVU0XdJkeklWFMsulzK5J0m
	3kttwJs/EkD5/AjbhB4Cr9MSjMsrsIc2lTSTXQdMwsj1SrVZ5ZMishRxfN4HTRI+
	tJRBVGe4F+9QEb0HjqGoXGItE=
Received: from ubuntu.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDHKsWcks1qZMCpDw--.41545S4;
	Tue, 13 Oct 2026 10:08:35 +0800 (CST)
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
Subject: [PATCH v3] usb: cdns3: Fix PCI device reference leak in cdns3_pci_probe()
Date: Tue, 13 Oct 2026 10:08:27 +0800
Message-ID: <20261013020827.4099844-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDHKsWcks1qZMCpDw--.41545S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWryDZF1kCw15urWDJF1xAFb_yoW5Kr4xpF
	Z3WF4rCrWkJFy3trs8Xr48uaySkr4Sk34xKw1Ik347Zw45Ar1xtFWFvFyjgF4DCrWkXa40
	qw1jqw4q9F4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piJGYdUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9gPa5WrNkqOTEQAA3e

cdns3_get_second_fun() looks up the second PCI function with
pci_get_device(), which returns the device with a reference held, and
hands it back to its callers. Neither cdns3_pci_probe() nor
cdns3_pci_remove() ever drops that reference, so the second function's
pci_dev can never be released.

Route the error paths of cdns3_pci_probe() through a put_pci label and
drop the reference there.

cdns3_pci_remove() needs the reference dropped too, and it is missing
a NULL check while at it. cdns3_get_second_fun() can return NULL, and
pci_is_enabled() reads pci_dev->enable_cnt without checking its
argument.

The same error path also frees the wrong object. When the second
function has already been probed, wrap is its drvdata, obtained with
pci_get_drvdata(), and it is shared. The second function keeps
pointing at it, and cdns3_pci_remove() dereferences it when that
function goes away.  Freeing it here leaves that function with a
dangling drvdata.

Both branches that assign wrap are guarded by the same
pci_is_enabled() test as the registration block that can fail, so the
wrap freed there is always the one taken from the sibling function.
Track whether wrap was allocated here and only free it in that case.

Found by code review.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- Do not free a wrap that was taken from the second function's drvdata.
  The free in that error path can only ever run on the shared object, so
  it left the sibling function with a dangling drvdata. Reported by
  Sashiko. cdnsp-pci.c has the same construct.
- Keep the rest of v2.
Changes in v2:
- rebase on current mainline. cdns3_pci_probe() gained a -EPROBE_DEFER
  path in e5052f2c5c73 that returns after the reference has been taken, 
  so it has to drop it too.
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index fd06a3d8e638..31089eb9ca29 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -72,6 +72,7 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 	struct cdns3_wrap *wrap;
 	struct resource *res;
 	struct pci_dev *func;
+	bool own_wrap;
 	int err;
 
 	/*
@@ -99,12 +100,17 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		if (!wrap) {
 			dev_err(&pdev->dev,
 				"second function not initialized, retrying\n");
-			return -EPROBE_DEFER;
+			err = -EPROBE_DEFER;
+			goto put_pci;
 		}
+		own_wrap = false;
 	} else {
 		wrap = kzalloc_obj(*wrap);
-		if (!wrap)
-			return -ENOMEM;
+		if (!wrap) {
+			err = -ENOMEM;
+			goto put_pci;
+		}
+		own_wrap = true;
 	}
 
 	res = wrap->dev_res;
@@ -164,12 +170,15 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		wrap->plat_dev = platform_device_register_full(&plat_info);
 		if (IS_ERR(wrap->plat_dev)) {
 			err = PTR_ERR(wrap->plat_dev);
-			kfree(wrap);
-			return err;
+			if (own_wrap)
+				kfree(wrap);
+			goto put_pci;
 		}
 	}
 
 	pci_set_drvdata(pdev, wrap);
+put_pci:
+	pci_dev_put(func);
 	return err;
 }
 
@@ -184,8 +193,10 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
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

