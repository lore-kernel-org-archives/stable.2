Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1EB3ACF1C;
	Wed, 14 Oct 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970567; cv=none; b=sHD1FCFjVyLYU6yq6HZCvoCusIiVmsFFtwZD3+C8vvgUZ0jeEAdziD16b8vV7wFNacG5rrp7p/REjiSBV+Dn+NkWEjic6MORAA4jEaJg1v2Y9LkvhfwVwqvn1KD3IvJeOhizt3etiYn3jbMo3SkOHPberNlyv1U3ecv/UfNPwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970567; c=relaxed/simple;
	bh=7giAKsjkqcXcQMqTVaB+qY7SM2CFaZrhkq5pTweff6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfmI6dA6mP2Lhxegd8y3owkY+XagMQnVKwuPi6X61P7RCuhKiEd8YI5yuJBcNyfBmD86gd2Kv060yBzg1JESLTLJSCwTMBL1Ud4FwxTyofE2MaDrygRToKlp1mWgqC40R4dOpDmC/HlVsayORwqZrnKCU+UTaY1gNDtVnyJdTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=DzrGzK2V reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="DzrGzK2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=xZzsjjrfGk
	WbbVv/YWH6P3DFGtqXahU/y5v14sh9hBM=; b=DzrGzK2VRKegLxlPlUdgcFFttL
	YG+MWKqZiUD9+W4PdaC9y/FhVwM5coYUZEd38aiaNLM6EMs9Z6tQWFEimPURzt2G
	wwIhT3836/+fedG+6oNlzIKp6Y+o5nFKBwx2Zh0DfC3jEJaIO7Q99bvArES3wRpO
	ZpsHizPMnSJ+MDcS8=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.94])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGyP3uTM9qphCXAA--.48766S2;
	Wed, 14 Oct 2026 17:35:43 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	=?UTF-8?q?David=20H=E4rdeman?= <david@hardeman.nu>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: rc: fix use-after-free of rc_map.name on register error path
Date: Wed, 14 Oct 2026 17:35:41 +0800
Message-Id: <20261014093541.16491-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkCGyP3uTM9qphCXAA--.48766S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UXrWfGFW7Kw4kCF4fGrg_yoW8tF47pa
	9I9FyYyFWjgF4DZrs8Xw42qa4rua1fJa98CryfJwn09w1rCFyayFWUtFWUuas8Ary8ZFy7
	tFn8J3y8GrW5CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeF4EDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2rOS7xmRwABs9

If rc_register_device() fails after device_add() - for example when
ir_raw_event_register() cannot create its kthread - the unwind path
frees the keymap via rc_free_rx_device() while the device is still
visible in sysfs, and never clears dev->registered.

A userspace reader of the uevent attribute then enters
rc_dev_uevent(), passes the registered check under dev->lock and
dereferences the already freed dev->rc_map.name:

  BUG: KASAN: slab-use-after-free in string+0x483/0x4c0
  lib/vsprintf.c:737
  Read of size 1 at addr ffff888007ca9d80
   rc_dev_uevent+0xd7/0x1d0 drivers/media/rc/rc-main.c:1628
   dev_uevent+0x28d/0x570 drivers/base/core.c:2709
   uevent_show+0x1af/0x380 drivers/base/core.c:2756

Fix it the same way rc_unregister_device() does: take dev->lock,
close the input device if it is still open and clear
dev->registered before releasing any resources. rc_dev_uevent()
then observes the cleared flag and returns -ENODEV instead of
reading rc_map.name.

Fixes: f56928abaa6d ("[media] rc-core: cleanup rc_register_device")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/rc/rc-main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index dda3479ea3ad..903ae3d3441d 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -1970,6 +1970,18 @@ int rc_register_device(struct rc_dev *dev)
 	return 0;
 
 out_rx:
+	/*
+	 * device_add() has succeeded, so userspace may read the uevent
+	 * file and access rc_map.name. Take dev->lock and clear
+	 * registered, as rc_unregister_device() does, before any
+	 * resources are released below.
+	 */
+	mutex_lock(&dev->lock);
+	if (dev->users && dev->close)
+		dev->close(dev);
+	dev->registered = false;
+	mutex_unlock(&dev->lock);
+
 	rc_free_rx_device(dev);
 out_lirc:
 	if (dev->allowed_protocols != RC_PROTO_BIT_CEC)
-- 
2.34.1

