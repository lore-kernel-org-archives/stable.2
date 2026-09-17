Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47844E3241;
	Thu, 17 Sep 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661060; cv=none; b=T0ayx3JsTHXcqvTAPl5OQ0UW37ahQOiGYHQNHB5KpWUMXZnpTsQ/CfHhhjejEfcPWEiV9F+EC8ueHhZNSuUdpLsmSeidC47PqrYDO1ZbaDw6wbr0DutO24OO8QsNQV13KAE5QWkrIWNA71jcdbwmS0ZGN/+Axe0M6inPK7Ky4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661060; c=relaxed/simple;
	bh=892VpFegINfRO/8g1K0jwYvQ/5eWzW/TybwfMV2/dpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+LghToOATN45RPgqZ9w1yL3I2sfo7JtHS9m2bHjzLji4+8ca1XwFUeCxGHog6Ds72cPbICpkbsNpNQQGHYfHFDFkQQ0gXaurkiFUKrqavdOiiAeBWuux1hY8IdcCm2Pfk6GNAUGB90A6HhK5Xok1CZ5h6vs7t8InN5jZq0JDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnEDt5D6xqDBmECA--.67S2;
	Fri, 18 Sep 2026 00:04:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: felipe.balbi@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org,
	rogerq@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: Fix PCI function reference leak in cdns3_pci_probe()
Date: Thu, 17 Sep 2026 16:04:09 +0000
Message-Id: <20260917160409.2161551-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnEDt5D6xqDBmECA--.67S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWfAw4UKr47ur43CFW5GFg_yoW8Xw1fpF
	y8WF45CrWxJry3JFn8Xr1Yva1Skr47ta4xK3yIkwn7ur45Aw47KryF9Fy0gFs5AFZ7W3y5
	tr15t3WjgF42y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUblAp5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUNA2qr9LZA3QAAsM

cdns3_get_second_fun() returns a device obtained with pci_get_device(),
which takes a reference to it. cdns3_pci_probe() never drops that
reference, so it leaks it on every exit path, including the successful
one.

Release it on all paths through a common put_func label.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index eb5760f75b9d..1ad722e7704d 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -89,7 +89,7 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
-		return err;
+		goto put_func;
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
+			goto put_func;
+		}
 	}
 
 	res = wrap->dev_res;
@@ -160,11 +162,16 @@ static int cdns3_pci_probe(struct pci_dev *pdev,
 		if (IS_ERR(wrap->plat_dev)) {
 			err = PTR_ERR(wrap->plat_dev);
 			kfree(wrap);
-			return err;
+			goto put_func;
 		}
 	}
 
 	pci_set_drvdata(pdev, wrap);
+	err = 0;
+
+put_func:
+	pci_dev_put(func);
+
 	return err;
 }
 
-- 
2.34.1

