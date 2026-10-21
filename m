Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579666;
	b=EXyUX6tLG1/azRt0qfn9FRxJcyq4THvpLb3KOBkFURRj/NeJXQspkHqaMnSZ8XeB4UKH
	 xYt4yOmVvjSW4WWHOPy0MryLXGBsVxK/uNOr8kliDaUQCi6C4eTV1dLDGb8QqZTegDVXO
	 T8jBR59qRLpu/avdefVOHnxVyEfCRl3hbxNCVt3Q7aUjBGw1z1mA9mXCO5MN3ckAcrgak
	 BT47jGvqXmzem/pR2eNzV7jDWkxPwRZjP99iR1fbNu+LvcXqupC+MpZJeVnq/cEbxbaou
	 sw6DH4ZC3JB3X88RHVAaKBwI2UJYuT/fX568ANs2YEMGe/ZwDy296uNOTEYrz5eB8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579666;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=8rjo9E5I5jUw2GRnY9ilROcz1Nwl5H/IPAT/yzyrHdM=;
	b=ZguISssDQBNL9gy50Yt8ByfAVh9Z6pDEp6pDkH9Sehc0K2cypvag/9tbs9OolhCcqHYX
	 aM+WG36Dg385yLzuHWQWuaOXd3wFvWkmLoGY1BaTxN4LSr/aLhEVDRxf6IjdR22hM9/j+
	 yixacX5tHkq84TNZHivfvgOuW0PvpJ/FELG1BOxTADkY6YGqvLlrsvo0Y6ifyM5QJEWQx
	 rSt6GT++5r6zLnUAOLtb5Dx+8hx+gK1kF0NgAtkEGCDXA+wB48tl8mjcEoZoczlEso0aZ
	 1CMrcF7+zUpGTpI7SjOlRP0ZeC5gGtPKfiWQVd4xTjwU8mQeEeGNokj1ybBwXiCA52w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=keeLRbDN;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BDF606A320;
	Wed, 21 Oct 2026 10:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03BDF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=keeLRbDN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8r
	jo9E5I5jUw2GRnY9ilROcz1Nwl5H/IPAT/yzyrHdM=; b=keeLRbDNGVOdaUCCEY
	UDev274CypOiPvrdx9VKF8HolPrD66p7MmIxZkmjzIdrVM2HQfBpmPBwZeMG6Y3J
	RXsYnPB4ej5Lzo1Utiq6AYaHkJjL51lcsrQzrI1n8VOk6lr/WYJuyUVF6MkRCnkr
	AOECxd/UgaxK79n5yHj3Fc0i0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDX3xM5mNhq3MNSBw--.27855S6;
	Wed, 21 Oct 2026 18:47:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 4/4] usb: mtu3: initialize debugfs command buffer
Date: Wed, 21 Oct 2026 18:47:19 +0800
Message-Id: <20261021104720.4106961-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDX3xM5mNhq3MNSBw--.27855S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWUXw4kXrykKFy5ZrWkWFg_yoWkGFcEqw
	1IkrWxJr1vyayjkr1xCrWqvayfK3W5Xrn5ZFnavasxAanFqrnYvws2grn7Zr4UXFW5Ja4D
	Cr9rXrykWa10gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0YhF7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzh0GQGrYmD2HowAA3m

ssusb_mode_write() copies user input into an uninitialized stack buffer
and compares fixed command lengths. A short write matching a command
prefix can make strncmp() inspect bytes that were not initialized.

Zero-initialize the buffer so the copied input is always terminated.

Fixes: 4aab6ad24a10 ("usb: mtu3: move vbus and mode debugfs interfaces into mtu3_debugfs.c")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/usb/mtu3/mtu3_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index c003049bafbf..8976dbfaa585 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -423,7 +423,7 @@ static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
 {
 	struct seq_file *sf = file->private_data;
 	struct ssusb_mtk *ssusb = sf->private;
-	char buf[16];
+	char buf[16] = { };
 
 	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
 		return -EFAULT;
-- 
2.34.1

