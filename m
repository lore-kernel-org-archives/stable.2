Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787C3587A2;
	Wed,  9 Sep 2026 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931518; cv=none; b=YZADRxkkkqTdxEjydBk4Hl5FMfd+kEZNlzFYBGJJuFBEO7lvapVbjpXKSzhcPzqE67RaW3bjtGhm086w5Jr/LTokQ3Tk7LxHruszT1y4mZpHzk2HPivsYwNMzveQJRBaMvmfrdc9cKtn+ldd4DWu+VaXnR5/DWl/oN/2zL88c1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931518; c=relaxed/simple;
	bh=z1IMR72Jm/OXNjztBA3wGKpKghlaUl7Iv2sZZOJYPU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKxogttiVhOW+cO7F7sX2ddKUFAzpdbyb4PkjNr0Wpt3an8CaPxVYpY4/V7Tth6XTlv8582ZkK8DLGr18xYd6bRuSyYdVRjc6VqWQ6W5zQITead6gQXdCKE+SVOKp4yXOQxswVzYYXQDj0CA18c1qkjTbuRsFuOHEARdFF02pkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHIX6w7aBq6uoBAQ--.7104S3;
	Wed, 09 Sep 2026 13:25:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHnKaw7aBqbcFoBA--.45453S2;
	Wed, 09 Sep 2026 13:25:04 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lucas.demarchi@intel.com
Cc: thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/xe/i2c: cancel the client work on remove
Date: Wed,  9 Sep 2026 05:23:28 +0000
Message-Id: <20260909052328.654682-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHnKaw7aBqbcFoBA--.45453S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?YhfASgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBFzIrCNcQHfV2ckOR5KAS8rZcN3Zc9b3RzG5I2YoyNUuUXV
	JaRR6vAqtJ69vbf58Vip9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4Dtr47KFW8Kry7Kw1UXFc_yoW8CF17pr
	sxWrW5GrZF9F42gw47Za1xAFyUCr4fArWSkr17J343WwsxKry8Zr98tayUJFyjyayrZa4j
	yrn0q3y3urW5AFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==

xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
schedules i2c->work when the adapter is registered under the xe I2C
platform device, and xe_i2c_client_work() then instantiates the AMC
client device on that adapter.

xe_i2c_remove() unregisters the client devices, the bus notifier and
the adapter platform device, but it never drains i2c->work. A work
item that is still queued or running when the adapter is unregistered
dereferences i2c->adapter in i2c_new_client_device() after
platform_device_unregister() has released the adapter. The work item
is also embedded in the devm-allocated struct xe_i2c, so a work item
still queued after the drm device devm unwind frees that allocation
runs its callback on freed memory.

Cancel the work in xe_i2c_remove(), after bus_unregister_notifier()
so that no new instance can be scheduled, and before the adapter is
unregistered so that a running instance still finds a live adapter.

This issue was found by an in-house static analysis tool.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/xe/xe_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 706783863d07..5a176d78193b 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -311,6 +311,7 @@ static void xe_i2c_remove(void *data)
 		i2c_unregister_device(i2c->client[i]);
 
 	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
 	xe_i2c_unregister_adapter(i2c);
 	xe_i2c_remove_irq(i2c);
 }

