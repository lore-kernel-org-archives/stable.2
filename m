Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5AD4B4882;
	Thu, 17 Sep 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639773; cv=none; b=IPAdn6rTJThCKblFriOpAlYJSTHPSFxEEaPTv+7pnIQVQqtB9CmKd5zjaAnn6lxivYSMZf4Z14aXjZ0Ve4S0KxvVlX0WCjfK0ZXJL0xjiMxBF+7EtB/7ZYptApcEEX1zjwO22iAJrqvYI3s3+iq8ASjmR507Gy9DG2U7LFUcUnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639773; c=relaxed/simple;
	bh=7SA88uXt27Vh7dQvfKYPBRkBazuTc6H6MbT/2EtPVIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swR00HoKWgx++l5fE9tH/0envNyB2qEQCX9fD0LwBSQyrc6DpaViSKirINHW6iURv+trnigUNy+7Foci07hhW2rsiVeTkW83cR/PxMC2Tz6Cyt7s9q6VmFdsGjX4gIhQSe3VyptwKp6889A22UI4pnJc9lD+gD+bN4Osnj8S/ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnl0FUvKtqDlN+CA--.307S2;
	Thu, 17 Sep 2026 18:09:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: isely@pobox.com
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: pvrusb2: Fix USB parent device leak in class_dev_create()
Date: Thu, 17 Sep 2026 10:09:24 +0000
Message-Id: <20260917100924.2146125-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnl0FUvKtqDlN+CA--.307S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKrW3GrW5Jw4UWF17uF1fCrg_yoWkGrc_Gr
	1jvr92qw18Jw4rKr1avw1rZrW5GasFvrykXr47ta1fWrWag34rZw4Y9rn5Ary7Wr43ZF13
	Ja4qgrZ5G34fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07b51v-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQNA2qrrJo63gABsU

class_dev_create() stores a reference to the USB device obtained with
get_device() in class_dev->parent, which class_dev_destroy() releases.
When device_register() fails the function only drops class_dev, so the
reference to the USB parent device is never released.

Drop the parent reference on the failure path as well.

Fixes: 28c4a5e6d324 ("V4L/DVB: pvrusb2: Fix USB parent device reference count")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/usb/pvrusb2/pvrusb2-sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
index dba43d4c24f2..678e069b4c92 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
@@ -633,6 +633,7 @@ static void class_dev_create(struct pvr2_sysfs *sfp)
 	if (ret) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
 			   "device_register failed");
+		put_device(class_dev->parent);
 		put_device(class_dev);
 		return;
 	}
-- 
2.34.1

