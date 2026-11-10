Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.187.6.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329714;
	b=fRVv4MJo3dn261UFuCLd7os7WYe6Mi6g4bapj5WqyaUOZyqHcdeY5wFRvslmibhMYoaI
	 xvGdr6W6TZQ62kjabARqNClhkTthSy6BKAGjE5uk9NRZsqWMA4xx3TEheLSLuZK62chTQ
	 g6zHLA4Ye4S64bOwzBdgcKwNk/Xjv62fAv2XbI5l7RJoUQGPvrlo2+rmQIi77v1s5z8wD
	 YotMw3wGraZq6jYLoWBosRIkkscEuYE3+u7jkXgcdSbFa/KTEZHnpGX9EvaYyL/GUWTeE
	 qjKLsN2cfm7L3D/R1VAtor/CYh7Shd3EOIfegLcdozmlxne6VbKbQUj/jjL6xFqWHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329714;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=OMUVvNok96eLG6z3uWZdjjBaPhh9NjlLMIaPd6V/DRc=;
	b=nOdS106b60AbE36UAMZzYRrGiaS0648pxHv3A6EPJpb59U6EqWEQhSXXbJkBRKRaoudF
	 uvemvEo+ns1LnydpCy8upiIMyqpz1mS1t39/Ph0XI641DHjVquEtQmr6oRyUU4nLgARHs
	 WLhPn2hFGzaAnq9dvXMwgng0vjC+hKOlqPkzPxwbLsweR8J700fdda1x4mkuII1Lh6kxF
	 HBfAfQcVXAhN230wWheLjZpjL6lLXV+LRKJJxxKgORviRtzEhQx47n4KkBsP5BHlXU/s/
	 7vHSkUYmcB7Af388q/tZNaoAi1xmxlm0JgdIl5YavXp9RDcCG2vQkD08mhcrKmKXJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=52.187.6.220
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB560A5BE9;
	Tue, 10 Nov 2026 16:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3CB560A5BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with UTF8SMTP id IAEQrMCGTWlnTPNqWq8vAA--.34538S2;
	Wed, 11 Nov 2026 00:55:03 +0800 (CST)
Received: from 51f0e866aafc.ntu.edu.sg (unknown [155.69.197.24])
	by gateway (Coremail) with SMTP id _____wBHQDdZTPNqhKI0AA--.54723S4;
	Wed, 11 Nov 2026 00:55:02 +0800 (CST)
From: Suyuan Wang <stevewong@hust.edu.cn>
To: iwona.winiarska@intel.com
Cc: openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	joel@jms.id.au,
	gregkh@linuxfoundation.org,
	Suyuan Wang <stevewong@hust.edu.cn>,
	stable@vger.kernel.org,
	Kaixuan Li <kaixuan.li@ntu.edu.sg>
Subject: [PATCH 2/2] peci: Fix use-after-free in remove_store()
Date: Tue, 10 Nov 2026 16:54:49 +0000
Message-Id: <20261110165449.1996921-3-stevewong@hust.edu.cn>
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
X-CM-TRANSID:IAEQrMCGTWlnTPNqWq8vAA--.34538S2
Authentication-Results: app1; spf=neutral smtp.mail=stevewong@hust.edu
	.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxJry3CFy5GF17Gw1xZFW3trb_yoW8trWrpr
	ZxXa45Kr1DWr17GrsxZF4UWFy5ua1fA34rurW7Wr1Ig3W3Ar909a40vFWa9a4rArZ5KF4U
	Jry5JryrWayUCF7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQYb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14
	v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l
	5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVW8Jr0_Cr1UMcIj6x8Erc
	xFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82
	IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0Ha0PUUUUU==
X-CM-SenderInfo: jxsqimirwzmmo6kx23oohg3hdfq/

remove_store() doesn't hold a reference to the device across

    if (res && device_remove_file_self(dev, attr))
            peci_device_destroy(device);

Once device_remove_file_self() has dropped the sysfs active protection,
nothing keeps the device alive. peci_device_destroy() then does

    device_unregister(&device->dev);
    device->deleted = true;

and if device_unregister() dropped the last reference, the second line
writes to freed memory. So writing 1 to the "remove" attribute usually
ends in a use-after-free. A controller removal running at the same time
can also destroy and free the device first, and then
peci_device_destroy() reads device->deleted from freed memory.

Take a reference before device_remove_file_self() and drop it at the
end, the same way sdev_store_delete() does in SCSI. The deleted flag
still makes sure that only one of the two paths unregisters the device.

Found with a static analysis tool and checked by hand.

Fixes: 42bed52b2e9c ("peci: Add sysfs interface for PECI bus")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only. The race with controller removal comes from
reading the code, I haven't reproduced it.

 drivers/peci/sysfs.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
index c04244075794..4b1c8b91a3cc 100644
--- a/drivers/peci/sysfs.c
+++ b/drivers/peci/sysfs.c
@@ -60,8 +60,19 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	if (res && device_remove_file_self(dev, attr))
+	if (!res)
+		return count;
+
+	/*
+	 * device_remove_file_self() drops the sysfs active protection, after
+	 * which the device can be unregistered and freed, either by
+	 * peci_device_destroy() below or by a concurrent controller removal.
+	 * Hold a reference until we are done with it.
+	 */
+	get_device(dev);
+	if (device_remove_file_self(dev, attr))
 		peci_device_destroy(device);
+	put_device(dev);
 
 	return count;
 }
-- 
2.34.1

