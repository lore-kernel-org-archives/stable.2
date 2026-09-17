Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C344E4C35;
	Thu, 17 Sep 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661190; cv=none; b=NuPjqwxhLB/oKa9L5Id7yKPxQQa5ACk4hK0xijHIx1t2reivkt51b5AummBgjUAEmsgOmz3hwORcIm7P3GevZfacmCNIIES9wEk5lAHxfWMZVoQqV9eLmmPqZ4kJpHTeSP189XiCKsL1ySDTOrrKSgE3a1KZG4U2k+bF6NUvZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661190; c=relaxed/simple;
	bh=tKtwm9lUPm27HhAZoomq3ZQp3cqA0zL9ascqgq/zXqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CfZI1HP9dYNETbi8IuklgTs0zZOU2hhpggfaTU+sGbMqXyIfQMW2ITOEynPyMhhhWBAviX4zN+hgPG2qS2BC8w9vT8GF9+QY1xbP/OBrtu5GexCvyY62krquqA/JHUdT7c5z9s8fhrtSCV+ws4bghclvRLo925drlJpsKgiwoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zn+D6xqJyKECA--.6359S2;
	Fri, 18 Sep 2026 00:06:22 +0800 (CST)
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
Subject: [PATCH] usb: cdns3: Fix PCI function reference leak in cdns3_pci_remove()
Date: Thu, 17 Sep 2026 16:06:22 +0000
Message-Id: <20260917160622.2161638-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zn+D6xqJyKECA--.6359S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryDGry7ZrWUZr13tr18Krg_yoWfKFc_uw
	4rur4IqF1xWFyjkw1UKryFkr9rGwnFvF1vgF4xtF1fGFya9F1kZryfZrn5G347u3yrXryD
	GFn2y3yrurs29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUOuc_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qr9LZA3wABsI

cdns3_get_second_fun() returns a device obtained with pci_get_device(),
which takes a reference to it. cdns3_pci_remove() uses the device only
to check whether the second function is enabled and then returns without
dropping the reference.

Release it before returning.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 1ad722e7704d..6639751ab22f 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -188,6 +188,8 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
 
 	if (!pci_is_enabled(func))
 		kfree(wrap);
+
+	pci_dev_put(func);
 }
 
 static const struct pci_device_id cdns3_pci_ids[] = {
-- 
2.34.1

