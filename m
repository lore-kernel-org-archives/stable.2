Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA35013B9;
	Tue, 13 Oct 2026 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902861; cv=none; b=JXyhOJuK5D40dhRygzAp96I5ZBA4TRdiF6GsjnTawF/+LMhqK/zHw893TIFCog1O2RFNJ4Qf2bKHT7KnA/6Z/r8IGxZFimk9KgkXK4YDoBqdbukeVmGD0vRd8zNfR8157WS9iH2W8YztlOViWPB9m6MSNM4xJxmqAvtiC1om2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902861; c=relaxed/simple;
	bh=Tl8dWZ2c1JiqeuXayNIW3lODPyejvDXdZ9J6nROe4h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SifCc3Tfg46ulr6NFHsTGc6gvO8q0RkyWdy5697zC3T3OegNHtVzysD7SXAp+nxuAeuPEVUtlfRmmT74FJgvhDP2q1+W6+0Z1lhFb149pCf00dhmUp0oPyzSOxKD6smackISUOsS5Xq5uBvjkVzObQB5tml2h3l93WhCe3LNHDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=jPbC3KAZ reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="jPbC3KAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=aCbPFN9EmS
	JHSCbJaRZ03CYLMK4KvH2MF1s9BptRg3E=; b=jPbC3KAZ3jrK7/Omhhl9MsMhuX
	oWLRuOjRovL+ImdoHE+bZ04/x9Rjuyc5RusHQyFJIpUCdkMK9EQ1FrrE8h9oHK+/
	xSWcUlaHBEVma79Spl+2N7BbG0d8rruiVar2wNRqbScfX8nZZpA27Po/WQTUnYWZ
	3w11ophna+xslhuKY=
Received: from localhost.localdomain (unknown [113.200.174.18])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDGzwKBRM5q9CWOAA--.34153S2;
	Tue, 13 Oct 2026 22:47:31 +0800 (CST)
From: Yuanzhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: az6007: stop CA thread on probe failure
Date: Tue, 13 Oct 2026 22:47:17 +0800
Message-ID: <20261013144717.1621-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkDGzwKBRM5q9CWOAA--.34153S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1xWryfWw1rAFW5KF1fXrb_yoW5Xw18pa
	97KFWSkrWkXrsag3WUJw17Gry8Wa1kAr98Kry7Gw1ruF4Sk3WYkryFk3y8KF1UGrZ5AryS
	qas3Xr17GF45CF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb5fQtUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rOQtcCHAAAsh

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

During device initialization, az6007_frontend_attach() calls
az6007_ci_init() to start the EN50221 conditional access kernel
polling thread via dvb_ca_en50221_init().

However, if dvb_usbv2_probe() subsequently encounters a failure
(for instance, in tuner_attach or dvb_create_media_graph), it
enters the err_free_all error path in dvb_usb_core.c:

    err_free_all:
        dvb_usbv2_exit(d);
        if (d->props->disconnect)
            d->props->disconnect(d);
    err_kfree_priv:
        kfree(d->priv);

Because az6007_props does not set .disconnect, the active CA polling
thread is never stopped. When d->priv (struct az6007_device_state)
is freed, the still-running thread calls ca->pub->poll_slot_status()
which accesses the freed state, resulting in a slab-use-after-free
read or crash when dereferencing ca->data.

Assign az6007_ci_uninit to the .disconnect callback of both az6007_props
and az6007_cablestar_hdci_props. az6007_ci_uninit() invokes
dvb_ca_en50221_release() to terminate the polling thread and tear down
the CA interface before d->priv is freed. az6007_ci_uninit() is
idempotent because it checks state->ca.data before releasing and zeroes
the structure, so calling it from both the probe error path and normal
disconnect is safe.

Fixes: 962f8f67e486 ("[media] Add CI support to az6007 driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..c4fdf437695c 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -906,6 +906,7 @@ static struct dvb_usb_device_properties az6007_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.disconnect          = az6007_ci_uninit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
@@ -929,6 +930,7 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.download_firmware   = az6007_download_firmware,
 	.identify_state	     = az6007_identify_state,
 	.power_ctrl          = az6007_power_ctrl,
+	.disconnect          = az6007_ci_uninit,
 	.num_adapters        = 1,
 	.adapter             = {
 		{ .stream = DVB_USB_STREAM_BULK(0x02, 10, 4096), }
-- 
2.34.1

