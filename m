Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858218;
	b=DfxwPRwXMS4eaEe6XwtbOOT0WVSlxktrESdjsctG7d7WDyuRJuvVzlNltw85Td6iwC7Y
	 qs5RIWVpc039waejEL5Y0rPsO2U6AwGwC4n0Y51Dw9bGWyJZD4rOAg+z2jp6VaItpY/OB
	 xOMIwMQb3KSMKXG5zwhwzhEk0SwK/8PG1cnEfyhXi0HBu8veHTWUK7C5vkr4rTZ+yxqnx
	 nVr9Op/Vyiuuud4kjJFM5CWGTfoQAuYgKswTPAqfbdjH79ORqnPmw/x6qUKTvHmk0Wsc2
	 arxUH//fDiMfxeJPusCHVFrc+wmIP8jAWMQ+h7Seqw25Nn+mUHA1jZzPwNE9iK9UvZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858218;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=38uH5IVt+9iUG9mjJN8VcSewQa2Hbj4tG6YJ46RI16s=;
	b=D7wxzVSNKCqkxqVBjTZUUA8KxsjYSTxw+Be3ypv36YzEnvmffTOq5UaL/ocExqXCsglm
	 Fz2f6WRRkoR8cuZ1TXSHWf8f/w9NfQ+bJu6ZPY0LwDEC0W8HC+/Or0zgqhYNw4GYJOYlZ
	 nlyEqQep733WjH99PrjYkjJ3dF5Cn8WE8Uh3non27RjUtLYJ8pNXfqAo+Vg16cGX67Mvx
	 Dedgwzq+Sj7K/7I77BJTIAbmIOIf6PRkPQIXvauU2ibhVTSP1juBPD1RywS+eewKZFdCf
	 KYxOyH9Q9FKC8IqbgiKZZCYeUyAbkRnogyZudaC8jlRlCPujtxi0gaScOjje8wf7ejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30A9606A326;
	Thu,  5 Nov 2026 05:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B30A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=38uH5IVt+9
	iUG9mjJN8VcSewQa2Hbj4tG6YJ46RI16s=; b=7UyArZQZ8sWayrSX/6EiXpwH1m
	yXDE7Bj8+HKj6hkPHf8FN4CVWX75BirVU3WM61/flzgufSN2CluWthKxYlT+Xy9C
	BfFxB5Aq9dfceaO8y9IY9AvfnE7l8wtuo/JkioTP9IpAzv01VzdyqTc/k1f86GPA
	hqW77NX/fZ2FDtiec=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.104])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkB2nwWdGuxqAS4pAQ--.25527S2;
	Thu, 05 Nov 2026 13:56:46 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Subject: [PATCH] Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
Date: Thu,  5 Nov 2026 13:56:45 +0800
Message-Id: <20261105055645.12917-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkB2nwWdGuxqAS4pAQ--.25527S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1kCF18Xr1kuF4rKFW8Xrb_yoW8urWUpa
	9ru3W5CFW8Jr18Cwn3Cw48Aa4fA3y8W3y7KrZ0934avwsY9r4YqFy8JayjqrZ8urZ8Cr42
	qFs5Jrn8Wr1UJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5POzDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rrSlWWGwABsR

qca_debugfs_init() creates an "ibs" directory under hdev->debugfs and
stores pointers to fields of struct qca_data in the debugfs files.
qca_close() frees qca_data without removing that directory, while
hdev->debugfs is only removed when the HCI device is released. The HCI
device can outlive the driver data, for example when an HCI socket still
references it, so reading or writing one of the ibs files then
dereferences freed memory.

Store the directory dentry in struct qca_data and remove the directory
with debugfs_remove_recursive() before qca_data is freed.
debugfs_remove() waits for callers that are already inside the file
operations, and any later access fails with -EIO instead of reaching the
debugfs helpers. This covers the two writable files as well.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102113654.8724-1-25031212351%40stu.xidian.edu.cn
Fixes: 0ff252c1976d ("Bluetooth: hciuart: Add support QCA chipset for UART")
Cc: stable@vger.kernel.org
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/bluetooth/hci_qca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b639b2..d96ae0fc2b2e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -161,6 +161,7 @@ struct qca_data {
 	struct delayed_work ctrl_memdump_timeout;
 	struct qca_memdump_info *qca_memdump;
 	unsigned long flags;
+	struct dentry *debugfs_ibs_dir;
 	struct completion drop_ev_comp;
 	wait_queue_head_t suspend_wait_q;
 	enum qca_memdump_states memdump_state;
@@ -665,6 +666,7 @@ static void qca_debugfs_init(struct hci_dev *hdev)
 		return;
 
 	ibs_dir = debugfs_create_dir("ibs", hdev->debugfs);
+	qca->debugfs_ibs_dir = ibs_dir;
 
 	/* read only */
 	mode = 0444;
@@ -744,6 +746,9 @@ static int qca_close(struct hci_uart *hu)
 
 	hu->priv = NULL;
 
+	debugfs_remove_recursive(qca->debugfs_ibs_dir);
+	qca->debugfs_ibs_dir = NULL;
+
 	kfree(qca);
 
 	return 0;
-- 
2.34.1

