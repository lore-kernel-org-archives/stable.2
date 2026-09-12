Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339F2400DF6;
	Sat, 12 Sep 2026 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203649; cv=none; b=hl/9zzRdZuZn8dwuGnE+GpkTixSia52mbwae7qH1+WXVwJZx4n56N5Re9mLKhaegIlIpFaV9S5vPoQV6t3jVznNmKxaaCNlHOHEvYDveFf5tLDKUS+pm+eDW59hjBKDeLEieh+D13y7LScegaRMb9xCriUJ3eWiZSkcwlqHWxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203649; c=relaxed/simple;
	bh=0LCXAIap8o9c29+csO1EvdHOD3SHfaU5iVmMfoz9iPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PybrwEPdArIOPxLQd6VVDIObFOq6p4237q52010Zbhvw343PvkdCGU94YnlXz7WuRGqXVYu+H3BcdprNG/U32WlvF4dKzWLk+BMtIKM/zARKyUfF9ar194R6p2sQhjbHiAPJbNol0xYwvQI9FP+pZ9UKwBkPtRnSmv0R638+rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDXbjSwFKVqlscMAQ--.12412S3;
	Sat, 12 Sep 2026 17:00:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgBHl5+uFKVqaA14BA--.23246S2;
	Sat, 12 Sep 2026 17:00:31 +0800 (CST)
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
Subject: [PATCH v2] drm/xe/i2c: cancel the client work on remove
Date: Sat, 12 Sep 2026 08:59:32 +0000
Message-Id: <20260912085932.101598-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBHl5+uFKVqaA14BA--.23246S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?09aIEAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBEONEqAH8eom9prQji2O8CPow7cAPpYBDTA+NFT4iyluaT3
	RaBwfZsCyQJS0+zV8/vN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4Dtr47KFW5Jw4kXF47trc_yoW8tr1xpr
	sxGFW5GFZF9F42gw47Za1xXFyUCr4fJrWSyw17Ja43WrsIkF18Z398tay5tFyjyayrZa4j
	yrn0q343ZryUAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

xe_i2c_remove() tears down the AMC, unregisters the client devices,
the bus notifier and the adapter platform device, but it never drains
i2c->work. A work item that is still queued or running when the
adapter is unregistered dereferences i2c->adapter in
i2c_new_client_device() after platform_device_unregister() has
released the adapter. The work item is also embedded in the
devm-allocated struct xe_i2c, so a work item still queued after the
drm device devm unwind frees that allocation runs its callback on
freed memory.

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

Changes in v2:
- Rebase onto drm-xe-next as requested. xe_i2c_remove() now calls
  xe_amc_exit() first and no longer tears down an irqdomain. The bus
  notifier still needs to be unregistered before draining i2c->work,
  so keep cancel_work_sync() at that point. (Rodrigo Vivi)

Link: https://lore.kernel.org/r/20260909052328.654682-1-fanwu01@zju.edu.cn
 drivers/gpu/drm/xe/xe_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index d8fa68206f41..143ca7145e4f 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -334,6 +334,7 @@ static void xe_i2c_remove(void *data)
 	}
 
 	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
 	xe_i2c_unregister_adapter(i2c);
 }
 

