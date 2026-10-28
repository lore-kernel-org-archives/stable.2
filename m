Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162929;
	b=a3EmI6Hb+8XEe4VVTO0IA8UXezRfuCygXTn8LXo+ei+xH+XNbfv2JZ6Q6WttP3A9oKlO
	 nymalvKRzq0jnZFA6yUGESTVrAo2zNcvKEW+qj3Qtaeh4+OrOLYzVNhfGRiKAxv5I7V8W
	 yPvlazR+pSIfUAhVP8hsTdTtvQbF/miD7rQCaomqkKh4PyaDq4Xr/jOKGWEOAcAgZf4mc
	 jj2h6Yp2/VFQX3V0vhH+n/ZmTlUd+5DaRIi7t+R4TLRPNt2kAQpjZQrPfY6XL1UdCxoLo
	 WgH+rUbYTf56mEWS462McYTx/ed7aRe9yIbKVue+sctz5xZJXfnZS7dyg/BcmKoiEpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162929;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=BIyqk4EIFBEh6YzqQd/sxPsjm17XNt9nVVGA3XBXOBo=;
	b=3/+aTozybZ0sEIX1zCjXResIumhxKA0NXzYS5ME2AXTxXD+24lbYPxtB1bpMU+/mtNe6
	 1IVBZidE4k8D5ngO1b9MI7y0QQ6JSgqA+nsDnw/gXTgGl55DmEYVewkNVnF40djbn4QcS
	 SsybXXUFrPqzRXoFZNY8MyUenD4qjfds5dlelZOeNOXR0WYOKCfGdTGbUqBURpl6coyhd
	 2HKIu+mJPFhuBEv+f6bkc2p+KpS9SSkN40Lo7vkQ3z8o12yReoRWy2d1hFPGvxYAv9bn/
	 GxnT7jGO04MMjWd3aeRNTvhlnG+0fddRvdC5o5ro1hkLCLHcanlGezcnzxUJnXhauEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SjI9VgGN;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35160606A31A;
	Wed, 28 Oct 2026 04:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35160606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SjI9VgGN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BI
	yqk4EIFBEh6YzqQd/sxPsjm17XNt9nVVGA3XBXOBo=; b=SjI9VgGNA+EpcYadfe
	xIg0LOp0537EKAHcaGFXKmtL3oMSUrYzgG2Rqln5aJE2ZxUIdBD99gUpp6KmYOdm
	QA4fGffDg+56+hBnATWndm8yMVZARV6z/xHvRYpQP7SpFbLYycSpC8+ktYYJHCyo
	J8htokG0k1o7dKYGUl6/cmX4M=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S3;
	Wed, 28 Oct 2026 12:48:32 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/6] aoe: initialize error message synchronization before registration
Date: Wed, 28 Oct 2026 12:48:21 +0800
Message-Id: <20261028044828.96177-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxZF4UJr17JFWxXFW7XFb_yoW8JFyfpr
	4fWa4rKr409r45Gw4qqwn2yFy8Was2k3yUua40kw1xZw1rZa4q9r4Utry7ZF4UJrsrCFW2
	gF1UJ3yrC34jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzrWrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wDaFWrhfqCIewAA3G

register_chrdev() makes the AoE character device available before the
error message completion and lock are initialized. A userspace access
racing module initialization can therefore use either object before it
is ready.

Initialize both synchronization objects before registering the character
device.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/block/aoe/aoechr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoechr.c b/drivers/block/aoe/aoechr.c
index a42c4bcc85ba..efc09c97ff23 100644
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -288,13 +288,14 @@ aoechr_init(void)
 {
 	int n, i;
 
+	init_completion(&emsgs_comp);
+	spin_lock_init(&emsgs_lock);
+
 	n = register_chrdev(AOE_MAJOR, "aoechr", &aoe_fops);
 	if (n < 0) {
 		printk(KERN_ERR "aoe: can't register char device\n");
 		return n;
 	}
-	init_completion(&emsgs_comp);
-	spin_lock_init(&emsgs_lock);
 	n = class_register(&aoe_class);
 	if (n) {
 		unregister_chrdev(AOE_MAJOR, "aoechr");
@@ -319,4 +320,3 @@ aoechr_exit(void)
 	class_unregister(&aoe_class);
 	unregister_chrdev(AOE_MAJOR, "aoechr");
 }
-
-- 
2.34.1

