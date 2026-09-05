Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9093218BA;
	Sat,  5 Sep 2026 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601754; cv=none; b=jcYK6mcF31hDU5QJ2+Hm/ZY/5X+wSyHRDxfKfkJg6fLa1tHuHZJ1YkH+JCEbvywNaIVVH+FRK9GZqBZlpA0bu6U8mn0Ezv6P/pJd5Yyi4aBr02qrJoIECGEvO9yrZjRDoyXFX+yVqKY2s3Q81AuiiHcAhH1ZAltg2LcIb0QT83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601754; c=relaxed/simple;
	bh=HEZSXxR7D5f2VMOnzy/aUBdLkPDDgHNsYGYaKtJ33b0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=VwpzjMPhbLqKQ14F7wIOKmI2HcyAlXxfcM3XI8rCE2vVRFyk3uDPgUOgU6ExsM7+aOTeAxU9z+0NiYT4xmlHkSrNHv0gWukLpBaLK813zjgounpwA8Y9zMTM1yV/hoy6Fw5WvU2Q5rOgJQH28JRIZpVWIHrQzO5ayAYKzaHX19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=qhu+AATp; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="qhu+AATp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1788601747;
	bh=iQTrKofK8B0o6sYUWXl1lgzawmN/VIW2Yu5ona/5X2s=;
	h=From:To:Cc:Subject:Date;
	b=qhu+AATpkMESfbRH4uRbkIK0glGg6sHk8i/ncqpknqK+EVMgo0c2JUAG85isybgP4
	 mQ6ecMZ5zQazfTh1s9A900ZykznnLvp8i8ue33fmcOO9MtsSwZ2XW3bobuHa9fjQal
	 Yai0UU68vMuxjNxBDP/eFeXbuavqhMixHX6VyG5o=
Received: from KernelDevBox.byted.org ([115.190.40.10])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id C4494EDB; Sat, 05 Sep 2026 17:49:04 +0800
X-QQ-mid: xmsmtpt1788601744tlnx0u73b
Message-ID: <tencent_9F54D64A6DFD82697B7C2884A1E6496CDC0A@qq.com>
X-QQ-XMAILINFO: OEUhVsHQax4M8tqdbgzIgJj5Pbh41zsBM/ilm9pQ3IRVBR91l5GqtQ5SwTEc1b
	 Y5JumCvY0ddR3zIWtKrKSot+Jmtx5tJqJViWZReTCPr4DavbkShDuo0ErFtAAdp6WzXsTrFWCmnl
	 eAp2CsKfUwYqepNGtsun0l8NkvBbV5YZDOLsS12MywAxZkSuZoQ2N9eTaloWK+x8NOyWaenDy20N
	 4HJPF8zMvwc7Af2Wvkdd/eoRaDbUpEc8hg1ocip1Hc0V0aKCm+8somSI1q2KJnFCoMh9vz3T5OQw
	 zb9eMi0ywYAY0Q2OwguIMcBmHFLLBNGPxZaWEJfUfeRKJmR+j1kQxdDyXU9N/nkovPo1yfr1PW95
	 W8Wb5YVX/I3KrgJFoC909xu25lmIRcbg08b39rWUO9x3N6zr2QJ1wu2rWwZ8KflvPZ85UNuioIs+
	 uU2t6nKcUuqDbQOzxnlEVCbrS+AluBcsFRKLDGDDtRJ1MOh8zqcCtiLbGXcBxRWKk8I0Tiqy4Iua
	 rOKRmwbI2ZVZVqZZYZK8z1vlfQeNVBeXxAuAmZhd9gAIwY6EFnx4A5j2FGFtAViyfXSBFvJ48qXw
	 31gu2aD1veMhzAbQlxF//+UciQDws0VZoGR9zBwWaAy1sOJpegi+wP8Nurkc8qQCgwbHTVWdTIz6
	 Bk48oLpAEqjq/xxeqGAebeqS93v0Fjy9UFs1X9jXTXuBsYaBTi5HyXD5jLsRBmm1Pp6WIjFi19Vc
	 CXRHPl79EbTgWAaGgSvNkFgI3XVOW/erUNxRavqeWQ0bJxJ98s4dNUXswohkl3IO2E9djlGgNhK2
	 iy+MfX8Nk9L3RXCvV5MYM7b6bmHVaApH6cdfBblPfkwHFsI+70v4oyiL/9PffGYdsvSzHOChN+IH
	 x4z2X3p7lUvQjOjRwWN2RcWxsW7MdTHqx6ICX/ihlMQmg152pw/LpIAT4eDp7NGWjASkvXIaDeFj
	 QAhzz/qJNTpklRsqHQfOP8RzkYdTq72TiNzukL24KSIcS4e6o4NEeO6NBG9LCvgQuGbMxVFSwy+2
	 4JqOAdQWfIM+w3G0oUJG/lOsFLFA2j78eghXnXf/Z3tkxeCTfHFeWXpCzL2eq8ghclEg49Fw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	stable@vger.kernel.org,
	syzbot+4ac6df95b7f516179c07d6b8fcd77d81ec45e7f3@syzkaller.appspotmail.com
Subject: [PATCH] media: az6007: fix WARNING in az6007_i2c_xfer from mutex reinitialization
Date: Sat,  5 Sep 2026 17:48:55 +0800
X-OQ-MSGID: <20260905094856.632367-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

az6007_power_ctrl() calls mutex_init(&state->mutex) every time it takes
the !state->warm branch. When a control transfer fails before the device
is marked warm, the probe cleanup path invokes az6007_power_ctrl(d, 0),
which re-enters that branch and initializes the same mutex a second time.

That second mutex_init() can race with an I2C transfer. Once
dvb_usbv2_i2c_init() has registered the i2c adapter, userspace may open
/dev/i2c-N and hold state->mutex inside az6007_i2c_xfer() while blocked
in usb_control_msg(). Initializing a locked mutex clears its owner, so
the mutex_unlock() in az6007_i2c_xfer() then trips:

  DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
  WARNING: kernel/locking/mutex.c at __mutex_unlock_slowpath

Move the mutex_init() into the driver's probe callback. The callback runs
once per probe, immediately after private data allocation and before
identify_state() and i2c adapter registration, at which point no user of
state->mutex can exist. This mirrors mxl111sf_probe(), which initializes
its state lock in the same callback.

Fixes: a2c35d346d9e ("[media] az6007: Protect read/write calls with a mutex")
Cc: stable@vger.kernel.org
Reported-by: syzbot+4ac6df95b7f516179c07d6b8fcd77d81ec45e7f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=4ac6df95b7f516179c07d6b8fcd77d81ec45e7f3
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 65ef045b74ca..60af125ae6dd 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -694,8 +694,6 @@ static int az6007_power_ctrl(struct dvb_usb_device *d, int onoff)
 	pr_debug("%s()\n", __func__);
 
 	if (!state->warm) {
-		mutex_init(&state->mutex);
-
 		ret = az6007_write(d, AZ6007_POWER, 0, 2, NULL, 0);
 		if (ret < 0)
 			return ret;
@@ -889,12 +887,22 @@ static int az6007_download_firmware(struct dvb_usb_device *d,
 	return cypress_load_firmware(d->udev, fw, CYPRESS_FX2);
 }
 
+static int az6007_probe(struct dvb_usb_device *d)
+{
+	struct az6007_device_state *state = d_to_priv(d);
+
+	mutex_init(&state->mutex);
+
+	return 0;
+}
+
 /* DVB USB Driver stuff */
 static struct dvb_usb_device_properties az6007_props = {
 	.driver_name         = KBUILD_MODNAME,
 	.owner               = THIS_MODULE,
 	.firmware            = AZ6007_FIRMWARE,
 
+	.probe               = az6007_probe,
 	.adapter_nr          = adapter_nr,
 	.size_of_priv        = sizeof(struct az6007_device_state),
 	.i2c_algo            = &az6007_i2c_algo,
@@ -917,6 +925,7 @@ static struct dvb_usb_device_properties az6007_cablestar_hdci_props = {
 	.owner               = THIS_MODULE,
 	.firmware            = AZ6007_FIRMWARE,
 
+	.probe               = az6007_probe,
 	.adapter_nr          = adapter_nr,
 	.size_of_priv        = sizeof(struct az6007_device_state),
 	.i2c_algo            = &az6007_i2c_algo,
-- 
2.39.5

