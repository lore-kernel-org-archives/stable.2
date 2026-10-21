Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579664;
	b=1MuV9LkXzbtakyBTUIQWrhC8hyaRbCJcyBO/bpSSHI96EcayTByT8zSfWW6meznT5fKe
	 ZyvqHcFEzlTFma1IOwyt57KAFQV/g455QGu4SAYnHzv+IqZ2z4Kx54S83Xit02ATDeON/
	 VBZsd/GdYic8EWd4VEvHA1bJyHmWCFbe6ifRnQM00Nald1zTKavdd3PnSnpCmQYyZrTHX
	 LCdJi8igkfFCyg0HMPi6x/FbjEXoqSp6sDe18O7sRAYeaqg72vtaqh3PRTSDltnHR23ly
	 FdDr7eeGh5Q/3jh4jVkYhBlDjdbn9XrSgkIqzIOecPJyG1NOLIjRSqHPfumKuhOCECw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579664;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=F5csqRK13zPSxfbq79pxKullCTeZhYmrR2iPCGxcWe8=;
	b=1WFz7AwS3XWSllZlBVP2YHjcEcWEKmuhISH3NpZhGG1hyDUtflRk6gncZJroboWadiHj
	 KUEPWWLqg1bfSsU3FI3b6N2e3gwCVnylXFgBjLQ30/BvDjS3/2vzRpd6jAL5u2BkcnbSu
	 ASR8oNtQKr3B2UREZQJtSIYyYLe81Z8ccyphSXe4Q66D9X06VIpsNp6/QMAe20EPFOHdO
	 y2dkgeFto7gUyQ81kY7gY7W2iMHk5lVj0xwW63D6lg4PtP5BrYuMsctWpGouL+Z2WidK9
	 KnFbg/1L++wONo84676kejuBfygdagKg71Akq8ISi3V9sA5jOrmVkV2bNAuwQSaFSSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DZZ7Cy9B;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF2606A324;
	Wed, 21 Oct 2026 10:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DADF2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DZZ7Cy9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=F5
	csqRK13zPSxfbq79pxKullCTeZhYmrR2iPCGxcWe8=; b=DZZ7Cy9BjqEvHVvK38
	CSG2QtQlglH667JsRNVQBmlPCyCk/l1jI//VMWvaHPkIJ8V/pg+Beaylvv42VeZD
	8AEFmiK+ivylIeAyp2IdQKi16RxJL0JKqJ1Hg0AQLbZZSThL4lgEMvelFQG6r8QZ
	KHrAjrFiXboMxdmXEpM05syAI=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX3xM5mNhq3MNSBw--.27855S4;
	Wed, 21 Oct 2026 18:47:24 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/4] usb: gadget: renesas_usb3: initialize debugfs command buffer
Date: Wed, 21 Oct 2026 18:47:17 +0800
Message-Id: <20261021104720.4106961-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021104720.4106961-1-yaojiale02@163.com>
References: <20261021104720.4106961-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX3xM5mNhq3MNSBw--.27855S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4DtFyUCr4kXr4DXryfXrb_yoWDurg_Za
	409ryUXr48Arn8Kr18X3yavrW2k3WkXFn7ZF1q9w4fJrWIgw1rJFn8Cr97ta1UuF47Jws0
	kw1ftr4jvF4xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0LZ23UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhwGQGrYmDyHjwAA3K

renesas_usb3_b_device_write() copies user input into an uninitialized
stack buffer before comparing it as a command. A zero-length write makes
strncmp() inspect an uninitialized byte.

Zero-initialize the buffer so the copied input is always terminated.

Fixes: 43ba968b00ea ("usb: gadget: udc: renesas_usb3: add debugfs to set the b-device mode")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 2c9c3e935a5e..baa654f616f7 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2613,7 +2613,7 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 {
 	struct seq_file *s = file->private_data;
 	struct renesas_usb3 *usb3 = s->private;
-	char buf[32];
+	char buf[32] = { };
 
 	if (!usb3->driver)
 		return -ENODEV;
-- 
2.34.1

