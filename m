Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600495;
	b=agUFPFLWIsM/zzY1cIOw0dbcvs782Lwuequ7lRNNYG6LL5gWwiaa4Iqivy5RhPpTfiZQ
	 qCamEe/qOPKFfzaYmFuWta6VBbns7URzEXk4mhoNh5VNBRw24/KnDIPeggySuXHifTNz3
	 FS28CBKtkEdGWBtWxQOYLA/fIjXQSvIjCILd5oY6rR7fa/ppxrVHbK7Z8iRpTfd3vxxDJ
	 bwUmmHlhqDckVWgCESMJZgXZ+t0ORqitRuZVMhjT+bIseFcDW9av5/J8Azpb4t2WW4LOK
	 s75QMJdHjQiwqyQyRXWnixgajU7qWFZUE95nhCzPqYPg9MYj17NK67nLaSwxzqEBcSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=IupsUi3liovTKKlLGBYIhte7QRE8u+zVpXRHWhnx5pg=;
	b=bkluIWvVT/Q2WLMOJex4WpifA/ZHicX50Q+Hk9Zw3/EMJshc5U1LC4grpNDJulQIehFa
	 bv0ebc0QmBPI4A4seZd7fpGlcvFh/lhgS87wB3O4MvJZc9hXvHoOZ9KH8E5+1RwJ5KiR9
	 YpsKMcTfIjVW2uP71ZocLLS0/l5F1buCOGKV8kC5eEfHi/Lzwttb+X66C/CZex+bSS1bv
	 qteUb+e8JbHvjyhxMuvSvEasfEA2POXM8R6TQoACgZJxg4Kr6+E0Ieymq9c7Xw98kf1JE
	 n3WrF5oi5eTcMMjwXzOXDTontaTIQQ4DOgMJC/wPCUJaDWvJGzlTIYrtBliE5bGrf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DB606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=IupsUi3liovTKKlLGBYIhte7QRE8u+zVpX
	RHWhnx5pg=; b=pISQRdb7p8LqUMyYV0nOBLnQyd9M+AmZwp8N9hcKpLB6Aj6XdD
	vVrpFEslF2a6V7Ws8Mend90L+sTZd2r159vRvOOfYCAPxn6u0rb4zkn4HBYBcISS
	qkKQO8HSMlpprLN0YyUy2jBsuZi4KTuU2XoD4jO/5eJ+MSBH/MxqsVVvw=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2OP5lsAZrH1w0Ag--.14579S2;
	Wed, 25 Nov 2026 17:54:45 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] Bluetooth: btusb: fix use-after-free in force_poll_sync
Date: Wed, 25 Nov 2026 17:54:44 +0800
Message-Id: <20261125095444.19061-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026112543-dislodge-padded-0851@gregkh>
References: <2026112543-dislodge-padded-0851@gregkh>
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
X-CM-TRANSID:BLQMCkD2OP5lsAZrH1w0Ag--.14579S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Ary3uF18ur47Xr47Arb_yoW5GFyxpF
	WDCa4YkrWDJr4DCrn8Aa1xZFyFvws7X34UC342934Uu3sxXrW8AFyxtrWYgF97CrWUAw12
	yF1DJrya9as8CrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU8GQ6PUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm-MwAIsY

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
index 11b633e666a2..31b07b2208b0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -949,6 +949,8 @@ struct btusb_data {
 	int (*disconnect)(struct hci_dev *hdev);
 
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
+
+	struct dentry *force_poll_sync_dentry;
 	unsigned cmd_timeout_cnt;
 
 	struct qca_dump_info qca_dump;
@@ -4105,8 +4107,9 @@ static int btusb_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, data);
 
-	debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
-			    &force_poll_sync_fops);
+	data->force_poll_sync_dentry =
+		debugfs_create_file("force_poll_sync", 0644, hdev->debugfs,
+				    data, &force_poll_sync_fops);
 
 	return 0;
 
@@ -4142,6 +4145,9 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (!data)
 		return;
 
+	debugfs_remove(data->force_poll_sync_dentry);
+	data->force_poll_sync_dentry = NULL;
+
 	hdev = data->hdev;
 	usb_set_intfdata(data->intf, NULL);
 
-- 
2.34.1

