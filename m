Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C239FCD7;
	Wed, 14 Oct 2026 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946962; cv=none; b=XCe1cr64KHOixhqxLwnRtihKWkGZE1xaBhCmo/ZH/xk2IKxlifQlKf7VyzsXfMuAGE1UQtbHZqbg0ossTyzBtvc3oWC77zMJf1sQ0pgS1PLbQoK5xLehQnx3WSLzkv7PM2H1hYh4lvTpuTkXFOhPQeMB8rw4mvr/JFDte9eGTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946962; c=relaxed/simple;
	bh=DC+SCsCa5BuoskMecVFJdSKkQuqvWhxdFd5nTXFv5Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UvVn7C3cZWJd0E3aVd+dOLfHjb2rz18DapS0+B2gM4E3xwmU84N57FlE/0PqLRaTbCguEW1+XFtJLV52am3zmesA9GJa84WzbVXB9TwtGvLnvojWApW4z7hYYWfuUtDZduClVNfhu2IreCWZEeLJIjIaxPz+BVWzXJGUw8t76dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=3YDBkTJe reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="3YDBkTJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=7FyG7Zks92
	8P51SwWoo17P2fONhXNiKiM0ENlaJTlvs=; b=3YDBkTJeR1mMJ8cO2M4QTiOOdD
	CR2QrCHPfxE8D4pk0UWH6AJ7dMXXPaqveXF0zl5YTueE5ug+YCN6cqyoAgVgp9Ps
	p1o/O+76PN5aJg7slvquY8xdbf5PPUUjrcelTsSkRR6jgKH400WDv/MNP3lEw4hu
	ld8mzn3PTybKln0NQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.94])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDW_gS+8M5qM+OTAA--.40987S2;
	Wed, 14 Oct 2026 11:02:23 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jose Alberto Reguero <jareguero@telefonica.net>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH] media: dvb-usb-v2: az6007: Release CA interface on frontend detach
Date: Wed, 14 Oct 2026 11:02:22 +0800
Message-Id: <20261014030222.9265-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkDW_gS+8M5qM+OTAA--.40987S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw43Zw1UWw4rWr1kZrykAFb_yoW5tr1kpF
	WvgFWfKFW0qws7Wa1UJwn7Jrn5Xw4xJF93G34xCw4F9Fn0gFyrCryFka40yF1rCr4rAw43
	t3W8XFy7Ka1jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU4q2NUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUGD2rOS7xmRQAAs+

During device initialization in dvb_usbv2_probe(), the driver calls
az6007_frontend_attach() which invokes az6007_ci_init() to initialize
the EN50221 Conditional Access (CA) interface via dvb_ca_en50221_init().
This starts a background monitoring kernel thread named "kdvb-ca-%d:%d".

If a subsequent initialization step fails in dvb_usbv2_init(), the probe
routine branches to err_free_all, calling dvb_usbv2_exit() and then freeing
d->priv via kfree(d->priv).

However, az6007_props and az6007_cablestar_hdci_props do not define a
.frontend_detach callback. Consequently, dvb_usbv2_adapter_frontend_exit()
skips tearing down the CA interface. The background CA monitoring thread
continues running and attempts to dereference ca->pub in
dvb_ca_en50221_check_camstatus(), accessing the already freed d->priv
memory, which triggers a slab-use-after-free or a crash due to an invalid
instruction fetch:

  BUG: unable to handle page fault for address: 000001a400000001
  #PF: supervisor instruction fetch in kernel mode
  RIP: 0010:0x1a400000001
  Call Trace:
   dvb_ca_en50221_check_camstatus+0x107/0x310
   dvb_ca_en50221_thread_state_machine+0x31/0xb40
   dvb_ca_en50221_thread+0x12a/0x180
   kthread+0x106/0x220

Fix this by implementing az6007_frontend_detach() to call
az6007_ci_uninit(), which stops the kernel thread and releases the
CA interface before d->priv is freed.

Fixes: 962f8f67e486 ("[media] Add CI support to az6007 driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..cff27708da3a 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -609,6 +609,14 @@ static int az6007_ci_init(struct dvb_usb_adapter *adap)
 	return 0;
 }
 
+static int az6007_frontend_detach(struct dvb_usb_adapter *adap)
+{
+	struct dvb_usb_device *d = adap_to_d(adap);
+
+	az6007_ci_uninit(d);
+	return 0;
+}
+
 static int az6007_read_mac_addr(struct dvb_usb_adapter *adap, u8 mac[6])
 {
 	struct dvb_usb_device *d = adap_to_d(adap);
@@ -900,6 +908,7 @@ static struct dvb_usb_device_properties az6007_props = {
 	.i2c_algo            = &az6007_i2c_algo,
 	.tuner_attach        = az6007_tuner_attach,
 	.frontend_attach     = az6007_frontend_attach,
+	.frontend_detach     = az6007_frontend_detach,
 	.streaming_ctrl      = az6007_streaming_ctrl,
 	.get_rc_config       = az6007_get_rc_config,
 	.read_mac_address    = az6007_read_mac_addr,
@@ -922,6 +931,7 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.i2c_algo            = &az6007_i2c_algo,
 	.tuner_attach        = az6007_tuner_attach,
 	.frontend_attach     = az6007_cablestar_hdci_frontend_attach,
+	.frontend_detach     = az6007_frontend_detach,
 	.streaming_ctrl      = az6007_streaming_ctrl,
 /* ditch get_rc_config as it can't work (TS35 remote, I believe it's rc5) */
 	.get_rc_config       = NULL,
-- 
2.34.1

