Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600495;
	b=d9kC+Z650LAsERwNA5PK8tOHPkFO+yxuqFuhS1s74WGlEmjy5xCHkpVxsA3xKZ7Q2Mci
	 eL4yYrnSGRYuOfkr9lbEq19CJvUZGOVfbzi1mOfzF0GmUbODUqih/0J6D7aRgRWQOtyDx
	 9Oqe9YvtIjR+HV3CitCnKiLg/ORAm8P50ll/Vw5pCy/qzWY+jdbnbMy9q+9o7uDe2w9su
	 6PNbtVi6AVRh4AUgvv82D6iZwx9am/THI9CFDTVHZP5zoqxjsj8mAgiD2zzi1Mq33fGuU
	 Vb/us/hIdbnnsWzz4JomhUmXzAN3asQSIjR1WJlvPAFYyU4Yt5KN3vjCCdGdMWWQ06g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=FbYEVMXpJzA5zcW4OIgW+/PaPqghZIbk3Ujy/NSfLqI=;
	b=POeZ6pmDreYd1R3cKTbL+smTtnFtelKmbHcBHhLrJeZ1j4/iM3CDTgjT062Cn3PVMTdO
	 qNZa1MXg0HBRi0333ujMFsg6aTZa2np00Ynd7AaJLh+C+DsPC1tKcoYGBVZUy/++Q3Tla
	 E7DFwtKJ3TWAlnA2INAbGWAI+UJqCAWqL2atOe9abYzY1EdSuMuf7I2Ry8bqGawo9Cl3d
	 Ww7zaOpuNIKo6x+iZCIX6nZfgMqKn6IwCbsa1IRGuK7uvdcwq07qNtSnEO8WFnS6+ffOE
	 TmzuNvW9l0JIycY9AOzSrzFPa0IJYQ2ayvYY47sAGN/hFCt/foPc5aM4fALhvMl8WYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC65606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FC65606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=FbYEVMXpJzA5zcW4OIgW+/PaPqghZIbk3U
	jy/NSfLqI=; b=vnCmXv9z//0kK8NvaFD7arFlf3v50Kldn2l8QFvJj1H7T0Z7re
	p9Vdt1e6gMvFIsXSez+gi3tIc7uHck5euYKJXtVpn7Ffd2PN1E1uJaUZps7h8KMK
	ZHHwFtut3Vk/L57diURQ2/vAtMlfn+IPxLudx+CDYNSBEPGB2b98fHN8U=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDGzwJZsAZrlMUzAg--.37139S2;
	Wed, 25 Nov 2026 17:54:35 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] Bluetooth: btusb: fix use-after-free in force_poll_sync
Date: Wed, 25 Nov 2026 17:54:33 +0800
Message-Id: <20261125095433.19044-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112543-cradling-twins-5253@gregkh>
References: <2026112543-cradling-twins-5253@gregkh>
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
X-CM-TRANSID:BbQMCkDGzwJZsAZrlMUzAg--.37139S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Ary3uF18ur47Xr47Arb_yoW5GF18pF
	Z8Ca4YkrWDJr4DCrn8Aa1xZFyFvwsrX34UC342934ru3sxWrW8AFyxtrWYgF9rCrWjy3W2
	yFn8Jrya9Fn8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc9a9DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm-MwAGsW

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
index 9f91b7521a0e..223b4477e7cd 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -854,6 +854,8 @@ struct btusb_data {
 	int (*setup_on_usb)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+
+	struct dentry *force_poll_sync_dentry;
 	unsigned cmd_timeout_cnt;
 };
 
@@ -4260,8 +4262,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
-	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
-			    &force_poll_sync_fops);
+	data->force_poll_sync_dentry =
+		debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,
+				    data, &force_poll_sync_fops);
 
 	return 0;
 
@@ -4297,6 +4300,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	debugfs_remove(data->force_poll_sync_dentry);
+	data->force_poll_sync_dentry = NULL;
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-- 
2.34.1

