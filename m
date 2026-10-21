Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579666;
	b=ZbtKzLN+4r30HGKBFzAy+e0SVW4ZwTZr5SQskjgh2IKQD625k+/UgZ+VOiMw5zKCC9a/
	 Lvlw4re4f8hzwj9L6Vpz/8RE3+QLrOWWCfd7PJwdWNKBnIXobP2ZU3S39zndWZnvVqjwQ
	 xwV+k0fLEbOALoEiVS8CrayhKRZiLL6cva0PrbVaADIieqIB1gqACgBbe9kdh9CGsB/0d
	 RvDpmSQGFYyOyy/XdtoSN1fugC7256mkHS+ql49VR1m8VugAaY1sYSiHUxWCZMzfsR8gR
	 OmseteJVeHkoc9W2TZUABJVaoklS5sEs3hZNnQZaWnSu5yazb7gUtc5HYP8IPWHdgOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579666;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=iFM3u1yFQoUGk7xH09RrFv71Siu+/Us78ex+Nl+B1l8=;
	b=Hi193/6QWOD7Ahd60aOhS6N48ydPvbF+p8HHZo/yoQmS906WFvplGoomiKY7cUyFyUQS
	 LwrSOgRyoNDfA5GTORum7S2KDKccvXn7jFe1XaZb6yAy5rJ1cZJKVj0oqZFjlrcuIZUFJ
	 5ZM0vWvApkeDE5h277i0AqjpleLQp0UO8DAI3TlVkcky62g26x6RuZDSBP3MnnffTnN6U
	 YnC3lVKP9xl0ONyeUUCQ1g/o68Tuu/oixmULY4kfSKWxyllpu9MLJdeCzj+3QwcpFzGCA
	 w2CwxE5NSYDYqYowG/UnEiuO3G3ldXXJOLp6vJZ9+HbF3eJ5zEkPC+07WxNgcWEo2VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OOjhdw8G;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F9606A31F;
	Wed, 21 Oct 2026 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008F9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=OOjhdw8G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=iF
	M3u1yFQoUGk7xH09RrFv71Siu+/Us78ex+Nl+B1l8=; b=OOjhdw8GiMsrdBj72U
	infnrsfOCg5/6h1raNGLgo53sIUnvjMgZvx5ZKDg9eSYpe0cKt1pO2IrB/+r++hl
	PXlF6B7Mn+J8dilqewnXp+KYbMvVNn+EJyFW4GtFAkjul1ItaMrQBaQ264yXktzx
	rizO9Bwu8BdTIcgZ+3N9zM6WE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX3xM5mNhq3MNSBw--.27855S3;
	Wed, 21 Oct 2026 18:47:23 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	John Youn <johnyoun@synopsys.com>,
	Felipe Balbi <balbi@ti.com>,
	Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/4] usb: dwc2: initialize debugfs command buffer
Date: Wed, 21 Oct 2026 18:47:16 +0800
Message-Id: <20261021104720.4106961-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX3xM5mNhq3MNSBw--.27855S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWUXw4kXrykKFy5ZrWkWFg_yoWDZFbEqa
	sYqrWkWryDKFyDtw4xA3yaqFWYga45Xr1v9F9av3W3Gr42gr1rZr4vgws2vFs8ua43AF9r
	CrZrJrn7CwsrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0VBTUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRsFP2rYmDsp-wAA3r

testmode_write() copies user input into an uninitialized stack buffer
and compares fixed command lengths. A short write matching a command
prefix can make strncmp() inspect bytes that were not initialized.

Zero-initialize the buffer so the copied input is always terminated.

Fixes: f91eea447ac3 ("usb: dwc2: move debugfs code to a separate file")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/usb/dwc2/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 3116ac72747f..9fedeb2e3562 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -31,7 +31,7 @@ static ssize_t testmode_write(struct file *file, const char __user *ubuf, size_t
 	struct dwc2_hsotg	*hsotg = s->private;
 	unsigned long		flags;
 	u32			testmode = 0;
-	char			buf[32];
+	char			buf[32] = { };
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
-- 
2.34.1

