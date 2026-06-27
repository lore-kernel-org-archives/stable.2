Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DB137923;
	Sat, 27 Jun 2026 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782531875; cv=none; b=p79A01xhQhBcguTmcBj4U/tz9zC5i0RW/Y7KQRPrImzZMMxTE+k+WyvX/sOsEaCX1rX6fMh6yU5uiiJTFTDah2jNs9rjVh5awIhKWQccBn7UeZdRWvvMe2cIn63e06BMTK+9ENFSig+347rP4UStM2OZ0AiVUaQQYvLI7H2HSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782531875; c=relaxed/simple;
	bh=H22b1DXAepBmGTA3ko0ruPqwWcSCVZqUBYYG8Mf80U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDjixoSX+iuXnEbBQGwtddNRQ3EDdDjkkWytaQXe0TzpXKXqE+pR5LbNczHAhJd8Ne8c7F4gtCGxmPo5k7HEhGmgDHPxwqgHon2UQtQw4d9VmHQmsjcC7+mUTHdLy5EXPbWGSEIJmbjcxRanjx8iojFOMVHI+ajKgVwpzgUOlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAD3kMkeRz9qYW2BAw--.26715S2;
	Sat, 27 Jun 2026 11:44:30 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/video: __screen_info_pci_dev: leaked pci_dev references in pci_get_base_class loop
Date: Sat, 27 Jun 2026 11:44:28 +0800
Message-Id: <20260627034428.59479-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3kMkeRz9qYW2BAw--.26715S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFyUAFyktryUKw4rJr4Dtwb_yoW8Jr1kpF
	Z3GFWayF45XFWxGw1DuryDuFyfua15C3yfKFZ2kw15uayfZa4avr1xuryDur1fArW8Jr1S
	qw4Ut3W8uFy5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgLA2o-ErFs-AAAsh

In __screen_info_pci_dev(), the loop uses pci_get_base_class() with a
non-NULL starting device pdev. Each iteration returns a new device
reference but does not release the previous one. When a non-matching
device is found, pdev is overwritten and the previous reference leaks.
When no match is found, all acquired references are leaked.

Add pci_dev_put(pdev) for non-matching devices before continuing the loop.

Cc: stable@vger.kernel.org
Fixes: 036105e3a776 ("video: Provide screen_info_get_pci_dev() to find screen_info's PCI device")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/video/screen_info_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
index 8f34d8a74f09..c821101e9304 100644
--- a/drivers/video/screen_info_pci.c
+++ b/drivers/video/screen_info_pci.c
@@ -123,6 +123,10 @@ static struct pci_dev *__screen_info_pci_dev(struct resource *res)
 
 	while (!r && (pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
 		r = pci_find_resource(pdev, res);
+		if (!r) {
+			pci_dev_put(pdev);
+			pdev = NULL;
+		}
 	}
 
 	return pdev;
-- 
2.39.5 (Apple Git-154)

