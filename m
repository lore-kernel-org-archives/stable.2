Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E44E5335;
	Thu, 17 Sep 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661390; cv=none; b=Gx20iKynJ95I+zoTwZrJVOTQ6JI3ovvrhaBkx54fJgQIz3ep3Ohse7r3g/zqgeJF1tGsS9P6XiX1TfGnMcSLPUf6kzmoYjhU2cTzsO9EnpCVolQyXW2cY6SnDb+e6o43rZ3l/UMV1JRDoXZGHq/rEc7HFFIz+ICJz+bJpKD+qzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661390; c=relaxed/simple;
	bh=kOhxTu0JtznoHG97ZCyaU49bLhLPqMOmAJHA+Lh+Ntg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nib7GAqC1NHmrr5SUFOvHLSj+iQ0lO2wqM61nznpIjb4eB/okmN35+OMD7CuwzGqPm/hv9pAYVA9OpnyzRfoZfTRt1ojEHjwBpnrETW6g339AW2vIJjyXAj/BuTmHFwG1HG8ejSWeqbkNLwyagmeHauuLpg62tcQV0AtVpPr1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHdkDHEKxqTi+ECA--.153S2;
	Fri, 18 Sep 2026 00:09:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@nxp.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: cdns3: cdnsp-pci: Fix PCI function reference leak in cdnsp_pci_probe()
Date: Thu, 17 Sep 2026 16:09:43 +0000
Message-Id: <20260917160943.2161796-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHdkDHEKxqTi+ECA--.153S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr1rXr1fGr45uFyDCryfWFg_yoWfKFg_uw
	4ru3ZaqFy7uF9rKw1xGryavrWIk3ZIvF1kWa12qryfCFZIkr1kXry3Zr95G3W7uw48GF1D
	Kw1vgw45WrsrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUY9a9DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcNA2qr9tg91QAAsJ

cdnsp_get_second_fun() returns a device obtained with pci_get_device(),
which takes a reference to it. The error paths release it through the
put_pci label, but the successful return does not, so the reference is
leaked for every successfully probed device.

Release it on the success path too.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/cdns3/cdnsp-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 566d94e49102..061a2c43e986 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -162,6 +162,8 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
+	pci_dev_put(func);
+
 	return 0;
 
 free_cdnsp:
-- 
2.34.1

