Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600496;
	b=VGkneV4xPq4q/sIUMswq/RZVOSjcsUoaD/QcqB/nj2MboOK6p8wEdnA0uqxaUlsSgXek
	 NkHqyldFKbpHgDjIAD5X3zTAKMWK2TdjqC4YMtlbpnEUvhmljsrI1au1qfQUjNYMoOGLp
	 xNvO4u0JIlZy/S9DLEOz1KcbIHIHT3s9CAiSjEaqStgKUupebkNxtOtiNdYzMKY3jE7jM
	 RPcDWSANI7J304Qb+tmA9+kntlw1jeST7YA8lSISCkQp1vS2YhJBAo2B7iDIP7ZYwJZ6s
	 Nvm/gPBzWdsYFDBDpnmPT4oGx8yyMjxdhvcUZuYLahYIc1yf5gkmJY7e75yMmtrGDpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600496;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TpAxRoA2bH9icZAqaK2opYt8K9SnvMjaecH+wNXH8Io=;
	b=Lw6GpRpPEyGLUYD9qL7aTvTwOzZbT+n3+AL/+m+4Bv9Fm2nIXlJjfucW2GvXPefujKiT
	 OHJBCrWjxgko8+PWBQRZA1/NlzTyYGP95Dh00zBSXSDukF9aCeHlGLd/VYG0Upp657+6L
	 Y6C4nTEULwJ/XLUx0CHU6VQXBrClEnr1PjcL5FCGxKpZoKZljITT5Jn5Ikb4a7PHsRA7J
	 XYyk7uTPWh34oskAiYRvrQZak58wuo57MWHg7xSglUG+V3/ELIJGmWfdjGfN71aUFKbqW
	 RntiXYx15gG15DZmEqlFjZ6sGmz/9J5zpPUjtZp16/ryodDSy71dJxWG9nc8CILb22w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DF606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2DF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=TpAxRoA2bH9icZAqaK2opYt8K9SnvMjaec
	H+wNXH8Io=; b=tlihQwTYgdlkhqgnNtw9fKPm4wNSZlQU5cIRlHp8vVzzKhigFa
	rPEgLjpRYVo7rziWQwQ0OXpZtoBhSsPauxvHaoRPr11csaBcqhqmR1nkDpn4T+/W
	gnLEF4rs/HPw56Rw81kKJ78Dskb8MHNMUrBYJXZ0it+XD5+OV4VvdhazY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDmDgVnsAZrrWM0Ag--.15873S2;
	Wed, 25 Nov 2026 17:54:47 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] Bluetooth: btusb: fix use-after-free in force_poll_sync
Date: Wed, 25 Nov 2026 17:54:47 +0800
Message-Id: <20261125095447.19078-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112543-thinning-expenses-4a20@gregkh>
References: <2026112543-thinning-expenses-4a20@gregkh>
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
X-CM-TRANSID:BrQMCkDmDgVnsAZrrWM0Ag--.15873S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Ary3uF18ur47Xr47Arb_yoW5GFyxpF
	WDCa4YkrWDJr4DCrn8Aa1xZFyFvws7X347C3429w15u3sxWrW8AFyxJrWYgF9xCrWjyw12
	vFn8Jrya93Z8CrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
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
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jxsqXUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm-MwAJsZ

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
index 6142546c387e..48ae89803c4f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -995,6 +995,8 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+
+	struct dentry *force_poll_sync_dentry;
 	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
@@ -4231,8 +4233,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
-	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
-			    &force_poll_sync_fops);
+	data->force_poll_sync_dentry =
+		debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,
+				    data, &force_poll_sync_fops);
 
 	return 0;
 
@@ -4268,6 +4271,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	debugfs_remove(data->force_poll_sync_dentry);
+	data->force_poll_sync_dentry = NULL;
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-- 
2.34.1

