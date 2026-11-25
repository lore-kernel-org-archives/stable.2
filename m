Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600498;
	b=ANPv7lIZgMFYnqFAAoKExWhYCwxgu+QhP42efS9wMo+ZSfx4reZyYzn9ViSMtl+FME3g
	 eZ9DfTxzvqclLhaxvg2+/i+19bmBBbfW+3bf/s903wPh199VKQ3WhOL6q4Xwco343ZtIp
	 jVqzGlBkaQFXIOZ+f6Ak5z6411Ka2Jhzi+o7KSr29aEahxquWKbLqnP7NY5ktecdg38dD
	 h1Oz7J0bv1U7HpXIvShy0cYPjgJkD8N8oeqon+RH8g6O35qgkVM9OUr6bBpenO/ATI4uC
	 cvPmyzzG/r52qLJAnqVlGEVRB331FKhVWe1wTjnV6cFPdCIOzBbZZ0PwNjCplcuna+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600498;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+z6OFVJvldmxKYL0WM3BZnt2oFvNjZR/hp2UpWCa11c=;
	b=GKxp+4/c+mqCa9tT6hCFXq4WHIkCRjqY5H87RRcQfZUOn3gEJd32PS8Vv6B8YhFCDg+u
	 npDjl8Sm65Tq4RiXZ38ZPq2E7+BHMrRORFZgAiyGV85trpugcTdiyfN46bpz5n8Ycx099
	 xiUis0Ksu9LvMvEawqgFck8UtQF8uzON3a+1kUYPw1OrF5fRt3BobHOMLSXlZSpWXOyXq
	 bcGoesvz46elWIzvJI0THYInCeBjEoSXO5dafG6cBLYjwm5vmXDCtnnIG6QtrbzpwJ/2H
	 Ni3fYLRik3o3iq0xqpq5kTvWQOXGoUXPFfHrNuhYDIXfZbtHEdgPDhFCNw87kJAlPfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D2606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 109D2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+z6OFVJvldmxKYL0WM3BZnt2oFvNjZR/hp
	2UpWCa11c=; b=pLltAvAn0rZJ/nb13KTzm4PBL0o10UzzO4j8SyZ5Xn9LduWAc/
	335Ibolp55hjzEtw/eeMlP7+LQ/7nzy9Dn8MydofjqXstVGDK+FSMnIZBHyWLLut
	6He3TnUQChLa8VngEVmcjK2pNkxMBTyUpotQt6aTS8F2JSaEJHsQQLtnk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAWNftqsAZr2GM0Ag--.16677S2;
	Wed, 25 Nov 2026 17:54:50 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] Bluetooth: btusb: fix use-after-free in force_poll_sync
Date: Wed, 25 Nov 2026 17:54:50 +0800
Message-Id: <20261125095450.19095-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112542-sheet-unloaded-b161@gregkh>
References: <2026112542-sheet-unloaded-b161@gregkh>
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
X-CM-TRANSID:BrQMCkAWNftqsAZr2GM0Ag--.16677S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Ary3uF18ur47Xr47Arb_yoW5Gr1DpF
	WDCFyYkrWDJrs8Crn8Aa1xZFyFvw4kXa47C3429w15ur9xW3y8AFyxtrWYgF9rCry0yw12
	yFn8Jrya93Z8CrJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4vEwIxC
	4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jr0_JrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07j4WlkUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm-MwAKsa

The force_poll_sync debugfs file uses the driver's struct btusb_data as
its private data. The file is created under hdev->debugfs and is removed
only when the HCI device is released, while btusb_disconnect() frees
btusb_data unconditionally. The HCI device can outlive the driver data,
for example when an HCI socket still references it, so reading or
writing the already opened file then dereferences freed memory:

  BUG: KASAN: slab-use-after-free in force_poll_sync_read+0x129/0x140
  Read of size 1 at addr ffff88800cfb7038
  ...
  Freed by task ...:
   kfree
   btusb_disconnect

Remove the debugfs file before the private data is freed.
debugfs_remove() waits for callers that are already inside the file
operations, and any later access fails with -EIO instead of reaching the
driver, so the force_poll_sync file can no longer dereference btusb_data
after it is gone.

Fixes: 800fe5ec302e ("Bluetooth: btusb: Add support for queuing during polling interval")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

(cherry picked from commit 868c886f45f7c10dc888b94c6993352702a84d04)
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/bluetooth/btusb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6143414711c5..99bee6e6d286 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1018,6 +1018,8 @@ struct btusb_data {
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
+	struct dentry *force_poll_sync_dentry;
+
 	struct qca_dump_info qca_dump;
 };
 
@@ -4418,8 +4420,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
-	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
-			    &force_poll_sync_fops);
+	data->force_poll_sync_dentry =
+		debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,
+				    data, &force_poll_sync_fops);
 
 	return 0;
 
@@ -4455,6 +4458,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	debugfs_remove(data->force_poll_sync_dentry);
+	data->force_poll_sync_dentry = NULL;
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-- 
2.34.1

