Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AB3A7193
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383451; cv=none; b=sHnJxVYqiCuKO1VbbKfGd1nnRFZQygR40E8FZqqi3xvzFbrUZsva5j8S0zGvb9sflty1s7e4dgfjt7xJa59zW3Npy8ogxyX7IelfjdO4NYdYbnF4CyBQmch3zk2wkYYJ91Ro3CrJAq+xkDft+O348F3ClwHWBPCAsVW0zTinh9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383451; c=relaxed/simple;
	bh=o5+CeElZHIIOXnJc4NY+IIRsKr70lhE35Yu4969gRfg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=hT+tVZGnjrWYepUjOeuUAEz3CQsOGhSIaY9yBK/KdxORwCTbfu4vB/swsCAPTMOpm7Yu+9f2ng+Lm8PvxiaoBhNNijRp0GVuKqHpO/IQRlMoTrmGzzoHlVOdFiJeSJrpnQQEJQhUVP4IZWz0TKxeEzxhUBEUKvibgDOtKPbb1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=X7Bg+JZ1; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="X7Bg+JZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780383438;
	bh=XR1CBcVCRqj2n1AfL+uL1VdxCXyHM89+MTPtiIBLqpw=;
	h=From:To:Cc:Subject:Date;
	b=X7Bg+JZ1GJgnAb28d0HmWB7iwbt55NeLcqZBzPj656TWsiFTDOe1z85hm2oNGy/8D
	 ptI1JjTBYG/zq7PDTc7Yl914PL+KJOXecOXc+MuvG38GJ4qAth30QK7JU295bA7Zkv
	 KqN71T1updhS06JWPIFkvvFjeOQXKtYVBaVuwgNI=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id E501C283; Tue, 02 Jun 2026 14:57:16 +0800
X-QQ-mid: xmsmtpt1780383436t62imag9y
Message-ID: <tencent_E54E7EE6CA5DFF23BCB8F9A87C2037BD0C09@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoejEoP+0r6WqC/jwESN5g4cnoGB7tPdCbfrQFJ87BU5dagEMlL+I
	 qcHabZRO3HyyPjUuPiRqKRrFIqIp2JCzYcd2lk7JthHLX7h4U8KeGq9EOQwW5zoqxo4uahpNunhQ
	 eeljVeEQk9NqP1Kn+0zh/bjvCLvS5LlCmLw9l+zzxD089czUosHiIBWzb/cOdBHZNh6EY1eB0l/t
	 +RtEyXUhQ3VLW9m6GtxHQokL25N9Dik/4HlwuD1eenqyUbXhaFlEWFg+r77t5fnZ0XQXP3GqMuo9
	 ZQ+MpiD4Lzlw4LR6NDldh3eXQecZZZ4FmZsQvB/L501VYMZumFZeIkgJpwD7oTGqjxoiJqoXBLR6
	 w6HrLtvkBrkQOMPLW8ls7uoaRyYhiWXb4ET1PU161fcm1C7Zvom9VAyoVgyU3IHeioLVWeCzYn4d
	 uJFoAkkVQfUaFVC3ln12j0+gfhIoL/vGyEy3QG/grtKV3XNYB0OOab71uHdi7toO4OEIulpX0wzh
	 fFK+ap5HLH3qK4x6B2fCoVUajlWTLKRfCLquWCRZ91ykPiH6yN7XPvNWCt4etvsH0YZMmdkr+wI6
	 ZznlKtCnBgmymMGqU7939yry/+ddxAvtpvE0E2i5wCys003sCom/wkG7wMLFwx9eL7LsfaB9PI4m
	 4PTpL70KDrWcdEhsFpWNHbHCMcz+0a9fV+oaOrYeOmNPisNtavGnu6qDfxaF7f9QYyRvkOfdx59m
	 A9KhswP5esDv2WDN2Ub27Kso8FEeBb2xCwAAmlyva4EKLWC+K+fHfuROySZZzIPR+lRKMwRqIpZ5
	 nNlpJhPjQ+tffsabeYRzgKFvdgldn/JnWURDmsfTSx5aJq36dW3N9dYfgUSSr1LEivXhJVUEJhQH
	 2nM67CJEUuTEmBKmzaCa9VfY7snUyS/tJzKQzfIVvcFgn8aEGL5Oo4/TF/o3jQxL5Wd1YKVmYGtj
	 kjd4kjA9dquKBHov0X8V8lNteQZvmYI4YChsuLV9xDTpD4uZokJxTp67uYnYxG2OoqmOrDVGFH+Y
	 CPPNPbaXfJ3Uls7YDI9dR7eTjSs/rrnP70DTL0+e5Sp3jqyNdU48k69zVI0zk=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: xiaopeitux@foxmail.com
To: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	mingo@kernel.org,
	brad@nextdimension.cc,
	tglx@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@s-opensource.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] media: au0828: fix slab-use-after-free in au0828_dvb_register
Date: Tue,  2 Jun 2026 14:57:03 +0800
X-OQ-MSGID: <c0cb04583f255e53d39214257bc6a3be8ec8dfb9.1780383298.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

A use-after-free (UAF) issue was reported by KASAN when the au0828 driver
attempts to register a DVB frontend and the operation fails (returning
-ENOMEM). The error path leads to a double free of the frontend object,
causing a slab-use-after-free.

The root cause is that when dvb_register_frontend() fails before the kref
of the frontend is initialized (-ENOMEM in kzalloc of fe->frontend_priv),
the error handler still calls dvb_frontend_detach() which eventually
invokes dvb_frontend_put(). Since the kref is not yet initialized,
immediately frees the frontend via __dvb_frontend_free(). Later, the outer
error path in au0828_dvb_register() calls dvb->frontend->ops.release()
again, resulting in a double free and UAF.

Specifically, the call chain is:

  au0828_dvb_register()
    -> dvb_register()
      -> dvb_register_frontend()
          (fails before kref_init, returns -ENOMEM)
      -> goto fail_frontend
        -> dvb_frontend_detach()
          -> dvb_frontend_put()
                -> __dvb_frontend_free()
                  -> dvb_frontend_invoke_release(fe, fe->ops.release)
                    -> au8522_release()
                      -> kfree(state)  [frontend memory freed]
    (back to au0828_dvb_register)
    if (ret < 0) {
        if (dvb->frontend->ops.release)
            dvb->frontend->ops.release(dvb->frontend);  // USE-AFTER-FREE
        dvb->frontend = NULL;
    }

Thus, the second release is redundant and unsafe because the frontend
has already been freed by the first release via dvb_frontend_put.

Fix this by removing the redundant manual release call in the outer
error path. The frontend is already destroyed by dvb_frontend_put() in
the inner error path, so we only need to set dvb->frontend to NULL.

Logs:
usb 3-1: new high-speed USB device number 2 using dummy_hcd
usb 3-1: New USB device found, idVendor=0fe9, idProduct=d620, bcdDevice=
1.00
usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
au0828: i2c bus registered
au8522 1-0047: creating new instance
DVB: Unable to find symbol xc5000_attach()
dvbdev: DVB: registering new adapter (au0828)
au0828: dvb_register_frontend failed (errno = -12)
au8522 1-0047: destroying instance
==================================================================
BUG: KASAN: slab-use-after-free in au0828_dvb_register+0x1280/0x15f0
Read of size 8 at addr ffff8881685f4118 by task kworker/1:1/42

Workqueue: usb_hub_wq hub_event
Call Trace:
dump_stack_lvl+0x26/0x80
print_report+0x16a/0x5d0
kasan_report+0xc3/0x100
au0828_dvb_register+0x1280/0x15f0
au0828_usb_probe+0x353/0x4b0
usb_probe_interface+0x4aa/0xa40
...

Freed by task 42 on cpu 1 at 65.659497s:
kasan_save_track+0x2e/0x90
kasan_save_free_info+0x3c/0x50
__kasan_slab_free+0x36/0x60
kfree+0x154/0x450
au8522_release_state+0x1b6/0x210
dvb_frontend_put+0x12a/0x170
au0828_dvb_register+0xfd9/0x15f0
au0828_usb_probe+0x353/0x4b0
usb_probe_interface+0x4aa/0xa40
...

Fixes: ead666000a5f ("media: dvb_frontend: only use kref after initialized")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/lkml/AAC17221-93BF-436F-92AC-906A18F882F0@gmail.com/
Tested-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/media/usb/au0828/au0828-dvb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-dvb.c b/drivers/media/usb/au0828/au0828-dvb.c
index 31123e6f9fc3..3c74b85c3a40 100644
--- a/drivers/media/usb/au0828/au0828-dvb.c
+++ b/drivers/media/usb/au0828/au0828-dvb.c
@@ -633,8 +633,9 @@ int au0828_dvb_register(struct au0828_dev *dev)
 	/* register everything */
 	ret = dvb_register(dev);
 	if (ret < 0) {
-		if (dvb->frontend->ops.release)
-			dvb->frontend->ops.release(dvb->frontend);
+		/* dvb->frontend freed in dvb_frontend_put, now we can set
+		 * frontend to NULL
+		 */
 		dvb->frontend = NULL;
 		return ret;
 	}
-- 
2.25.1

