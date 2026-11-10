Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.76.78.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329708;
	b=NrnR/iNQdp8lZP7P/0XQJ2y5ACo/VqVjWbpdnLClypV6y9ERkW3C1+Ro4J7dmAg3TRG8
	 Pa8UYl7mHDZzI964Ce3DvlFuFr6te6DYuTLKdUPtbci6+AG0h59jtfkae3aMvQ/gTA4Zc
	 kDMeDVtbpEngQ3LmLJz4iGtxkuuxw+IYBnSl2gkfCIdB9MPaZVzYJtu/1x/mFeLmMTg4K
	 o/TczMlg6kUoacOZwZkagBJFogJip0OdJFke52Y1k5bXy2Pqlgrl/H95PEHIFzq6mLCkm
	 FHWvX/EXYIUNQ3cbTQGMNLT2m1/+18Nj+vI0NqfLCgihK2Dbhxn5stZJxL0Lkj5PFtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329708;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Uc4O8pK5nK8LeAYmaSGivWLqbt10i/bY+fluzSA22pM=;
	b=H8TlJ55UC13K4tzuKkOnHKzAHjO/2haF64UObj892F0+0TQkLEZiWZs5ZKcbcNPjHxQI
	 6IbMQZ/V24fcu+OJxs+WO6aSHwfEhF45rbiZ+HcIgKQQJ8IiqtZ81KLL375WCgRm50GU5
	 Qrz7QFwOMQO4KNdWMEwK3ZATj7qRPQI4awExk2Il/YYKxEw7QJWTPwLmMIkN25hM9JnNX
	 8TFFloRO3izCKz8WY0jLGaBwZEB8szcFe2LiJxJ5pCM0nYbeS8fh0bSwkflZFRGGnM0K+
	 e1/ruKcWO8BADNm3d6uOjshbHl5Kj5SBH87YyuxLvzsKRkuOuEsMlMWvCKOBp6w01Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=13.76.78.106
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522A606A333;
	Tue, 10 Nov 2026 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E522A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with UTF8SMTP id IQEQrMA2XcVlTPNqf_8NAA--.17770S2;
	Wed, 11 Nov 2026 00:55:01 +0800 (CST)
Received: from 51f0e866aafc.ntu.edu.sg (unknown [155.69.197.24])
	by gateway (Coremail) with SMTP id _____wBHQDdZTPNqhKI0AA--.54723S3;
	Wed, 11 Nov 2026 00:54:59 +0800 (CST)
From: Suyuan Wang <stevewong@hust.edu.cn>
To: iwona.winiarska@intel.com
Cc: openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	joel@jms.id.au,
	gregkh@linuxfoundation.org,
	Suyuan Wang <stevewong@hust.edu.cn>,
	stable@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>
Subject: [PATCH 1/2] peci: Fix use-after-free in unregister_controller()
Date: Tue, 10 Nov 2026 16:54:48 +0000
Message-Id: <20261110165449.1996921-2-stevewong@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110165449.1996921-1-stevewong@hust.edu.cn>
References: <20261110165449.1996921-1-stevewong@hust.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMA2XcVlTPNqf_8NAA--.17770S2
Authentication-Results: app2; spf=neutral smtp.mail=stevewong@hust.edu
	.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18JrykWr13XrWxXrWUurg_yoW8uw1Upa
	yrGa1aqF4FgF4agF4jkF4xuFy3WanrGFWDua9rJ34UCFnxW3s2g345AFySqFy5JrZ2gF1U
	Ar45tayxXFWDAFJanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14
	v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8Erc
	xFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0k9N3UUUUU==
X-CM-SenderInfo: jxsqimirwzmmo6kx23oohg3hdfq/

unregister_controller() keeps using the controller after
device_unregister():

    device_unregister(&controller->dev);

    fwnode_handle_put(controller->dev.fwnode);

    pm_runtime_disable(&controller->dev);

The child devices are already gone at this point, so device_unregister()
normally drops the last reference and peci_controller_dev_release()
frees the controller. The fwnode read and pm_runtime_disable() that
follow then touch freed memory. This runs every time a PECI controller
driver is unbound or its module is removed.

Fix it by saving the fwnode pointer first, disabling runtime PM before
unregistering, and putting the fwnode only after device_unregister().

Found with a static analysis tool and checked by hand.

Fixes: 6523d3b2ffa2 ("peci: Add core infrastructure")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only, I don't have PECI hardware.

 drivers/peci/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index e14995b1bf7f..247a287f87ca 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -88,6 +88,7 @@ static int unregister_child(struct device *dev, void *dummy)
 static void unregister_controller(void *_controller)
 {
 	struct peci_controller *controller = _controller;
+	struct fwnode_handle *fwnode = controller->dev.fwnode;
 
 	/*
 	 * Detach any active PECI devices. This can't fail, thus we do not
@@ -95,11 +96,12 @@ static void unregister_controller(void *_controller)
 	 */
 	device_for_each_child_reverse(&controller->dev, NULL, unregister_child);
 
-	device_unregister(&controller->dev);
+	pm_runtime_disable(&controller->dev);
 
-	fwnode_handle_put(controller->dev.fwnode);
+	/* May drop the last reference and free the controller. */
+	device_unregister(&controller->dev);
 
-	pm_runtime_disable(&controller->dev);
+	fwnode_handle_put(fwnode);
 }
 
 /**
-- 
2.34.1

