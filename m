Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F287395AE6;
	Wed,  3 Jun 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780479056; cv=none; b=Ztlenn/YISmi/0FlbXTC0pl/qWtF0hqrACN0BfXalYknhKKHo8MvynasbEFxaxLgClwo5pkbEdsKk/0E+Pc7Lio5ugZSbzzWvvkoFSYdL8Dd1lY0UFe2mxLNBf44t8G7QH3G15QnVOFND5L3AizoMquxcLEGIoeh+V4Jfqoafpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780479056; c=relaxed/simple;
	bh=r01sVRSPrT2eQE/kG930ZksXlsXMrKs57pPYu1eu3ZU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k5f2Dhux59flFKBpDeSlf62okO3Ya0q+n2K538lzpzE8mIiWIHqX92ZXF4fnfn7C2OwlQ7gj8oKAHXpfZXGFPbAIpHO6PcpWypbtPfJcZ1haCo4y0HCKYZU7FsfFIkMynkX6lC3qf512pJ+Z1Gzhsb9Th3t1IL0TNQY6fcwoJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JJsy4Hwg; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JJsy4Hwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1780479047;
	bh=F2OYMm1tsAeSVuVq/sm/Y6/xtYfenTUkYZgfJVPNRsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJsy4HwgeR3cYvV4zshqyPeZy6su9sWVWeCaSFlZEAI4+Rxadx2w6skCD9F1WyDrF
	 POR9DcyGIyefcI6DU3UwagIIED/ToEzLaywbR1Wvm7zKtccOgsYEKucmx2HwhfTpkM
	 IZ61YJ5lWFXtmoXe8hFm6lZZ853YJAHoVjD9OkbQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 7AD2A816; Wed, 03 Jun 2026 17:30:45 +0800
X-QQ-mid: xmsmtpt1780479045tiwps4ejd
Message-ID: <tencent_B3E59D0CCEA1BBC24538702F522540CA780A@qq.com>
X-QQ-XMAILINFO: MyOGqh57N7Xm9tUKxWp2c8HI48fn4ClLtuVjVXThx5/6UFxsLAxW7EqOzwNyAf
	 GUVvsJrsFdzhlnrDd6qXLQoCIOApoRXc7eNx5urdOnOHT41DF0Pt6dDJ5j0AzzV/uxxCDMX+LQdk
	 t6T2hFX1viALgCiCM7mtDYHF5Ea9ErK4xFvhwZ+WorRraHLZ8HTLzskjvsi2WZmzfh6KcOfppMTo
	 XQ0sqILI16H9YKVOuvhsnXqfLrBznshJeSbzTSMMGq0yP9gDgOCy6j7yrEPDg/VR4/zd/7f3nDEg
	 6OfVX8LrLvy4zUdSzhyjzb5qcWNAqhcg1sBrJoH/YANg1osVGGQF/7jPZZLysR+qIr4U+Ag8GPjd
	 TcUm5KUhGv9omG5erQP6RXhVWek715LDq5hwVoWkp07czdfSQeSigKz6dAradRWABhjbKLz8akh2
	 Two0Ffs3StDqqEq7e5SsCJpnJUQPUSl2jjuB4AbVQrPQ7GbnnVqMd6UFv7B3ftXt98ZxkAq3qsIM
	 jsLdjjgXug/jhcQHPdoHQwSmoJ/UwVmnIkamoAQV6Jp746scoVVCcksG74XhPbgdLeoawJ2+Tx9B
	 y+fKN5vf/SNW+MaI5yBEKk6aRdSXvizhVB71sGthX3tyC4V27+0rkAiVMm+YCB4OgV8aYvIpPYMf
	 nqUAz6A+OtBMFb3Aw2Yl42KGpy5T5PH2MMX7f8FMEr+/YDPdiX4gC8eigZyXRDfjkbgGc7TcB8A8
	 RUGtpNfnic+6rmHabmLnq6IftUYTqotT3PRM9KKPUlhYDe0EDvBtGF8Xj0JGhpv+2Sd92geNzZj+
	 6UAyF3f/Hk0NIXnlqYLHvQZ+Ramy6m9HFRDSGTpMRWkTvOKDGDsDyq9CVLCA5MiXDeWJ4vSyDtcm
	 Y4DFBgo0gheVYvIxVgxNadQzZANt/oxRLh6pydLpRCZX5jihw259l3bZagZdjJlHqLHBn8klu3lc
	 wisIyHR/OXZxS55PfDoIdALv8vPllCZGqklal/DEcI5/+ZiA605VNsPQVZS1oWiFzJc2rgN4J2c3
	 Q0lMiBSwlA8+2jsaEhlVQ7OSDCM1wWLqScBuXvzQ2UDBv2E/CL
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: xiaopeitux@foxmail.com
To: shuangpeng.kernel@gmail.com,
	mchehab@kernel.org,
	mchehab+huawei@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	aha310510@gmail.com,
	hverkuil+cisco@kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] media: as102: fix memory leak in probe error path after device registration
Date: Wed,  3 Jun 2026 17:30:23 +0800
X-OQ-MSGID: <f439482f78c398f7a342357c0848550189712d07.1780478859.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DAD7161C-A1DA-422E-BBC5-2893ABDC2DD0@gmail.com>
References: <DAD7161C-A1DA-422E-BBC5-2893ABDC2DD0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

Commit 8bd29dbe03fc ("media: as102: fix to not free memory after the
device is registered in as102_usb_probe()") solved a use-after-free /
double-free race condition by never freeing as102_dev directly once
usb_register_dev() had succeeded.  Instead, the memory is freed in
as102_usb_release() when the last open file descriptor is closed.

However, this introduced a memory leak when the probe fails after
usb_register_dev() succeeds but no userspace process has opened the
device node.  In that scenario, usb_deregister_dev() removes the device
node, but as102_dev is never freed because as102_usb_release() is never
called (there is no open fd).  The only reference to the object (the
interface's private data) is cleared, leaving the allocated memory
completely unreachable.

Fix the leak by calling kref_put() on as102_dev->kref in the
failed_stream error path.  The kref was initialised to 1 during probe,
and as102_usb_release() is the release function that performs kfree().
If no open fd exists, the kref_put() will drop the initial reference to
zero and trigger as102_usb_release() immediately, freeing the memory.
If there are open fds, the extra references keep the object alive until
the last close, which is the correct behaviour.

Fixes: 8bd29dbe03fc ("media: as102: fix to not free memory after the device is registered in as102_usb_probe()")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/lkml/DAD7161C-A1DA-422E-BBC5-2893ABDC2DD0@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/media/usb/as102/as102_usb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index a11024451ceb..ad6c5837f1d7 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -405,6 +405,7 @@ static int as102_usb_probe(struct usb_interface *intf,
 failed_stream:
 	usb_set_intfdata(intf, NULL);
 	usb_deregister_dev(intf, &as102_usb_class_driver);
+	kref_put(&as102_dev->kref, as102_usb_release);
 	return ret;
 failed:
 	usb_put_dev(as102_dev->bus_adap.usb_dev);
-- 
2.25.1

