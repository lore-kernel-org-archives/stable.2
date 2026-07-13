Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BED361DDA;
	Mon, 13 Jul 2026 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922156; cv=none; b=TNyVjRMRqbtWACckJD1vNnNhpzV4G7HEFhhDNIPK0xnnkZjjqkMcX3wSBlE7JshBkGKWJq3AYW2EAbEcWndE+9ya6FKx4NbEe+MaY+I8eVQRHJxaXXFvJg40h5ZRjrSzno2EMXBPxXH0Evl+g7sOyHwTYC3LphYKT7BuF81ExbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922156; c=relaxed/simple;
	bh=W+uO+BeXlGEbXx++cjoVrg+u5K5U1ePX4rMgEgua4Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWyJO2LO9kjtHUf2DiHx7bQPknIwfvHOzjCJtNZ+placcrYpd+AtcRadtqTpx1LzxQmOVScEMoP1Cq/GQtYGr+w3zOk8onuxPcs7RKymBotcf7VI8/9kcuV4p3W2L6COXJBocwPEGTS5nI67ZXPl3sIgy8r4gYZ6jnKqLvQzR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RSqe5ROu; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RSqe5ROu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783922131;
	bh=1I8RIag1StWJA8yxAS+rI9yR/F9Rj/KnLWzNPNLLQYA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RSqe5ROuNHw5jFyblUdqiAtUBUJBG7nzzwBVT3g1z5dykHoJ6BhAQvLDBOePZ9mv+
	 B8G9lUMNcw5TVF57naDnBo6ZYGh1PgMzPoxcJEI70LFLP0B/8wu4mzUj06k0nJJGb/
	 IbKKNLYh6pafUgiqml5cMdmQGhK07e1BtCoJAzwE=
X-QQ-mid: zesmtpsz2t1783922126t4e8b0388
X-QQ-Originating-IP: kzoVtfEwWoCIEDsQ9cZjeUlLE2EQ/vg/V1LPtyvLWys=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 13:55:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13683492954811134723
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: graf@amazon.com
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	aws-nitro-enclaves-devel@amazon.com,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] misc: nsm: pin the module while the device is open
Date: Mon, 13 Jul 2026 13:55:23 +0800
Message-ID: <BE6951D13B5E5513+20260713055523.3193089-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OfjuGSsnNogoZIWzjbKCu2ekkPZi1AVKWg7qJmrqTJAGbVQrpcmoN3S0
	8VQBtQsIXjCC5xc46WjMdEvnLinHxhd46KISgOlW2uhtBKZw5348GgirqgTpQWx3CSIr/3g
	UYu6XfBJdHY5ZFyy7I34TpbYUWFsSoF9icde8FbYhXkbWohUfLGU2ILBPDSEPGc2NYDcw/7
	JM2VIuKduTUuvp1PPw0kDtXiCwrqOYiIF94qupIhLOB0BnEunPavaJAxxQQ0EQ7TMlKfqF/
	y8zIEImOaLRzlfuhLMwN1kfJTlUMiU2NuHiHdbY5wiAexfs/Iias6PaOTJ3bEAFbW1XLuyN
	YEEgjkc4wfugH37XmNJS7pWkv22b4xCtddho7J+3IBrlqDi4s8mbfo6IAkqPs5wGwIhBCGO
	EQfo96gfy9Ummuwugho7ynh6XyVAO73K0crc+DLOOL0Ygk/Z1fr4BR0sg/6JkbgYMnp/5Yx
	ngST4QKfwyE6a7/kYw0D4u4/LLSEKsCPMf01jaB5SfrjMIYoYEX6um/YX8XmkgpWhEtTeU6
	Y+KFTkG8fFBlX34HT5HcIDKIOgHORGwWfPNN2XTDUJ2wjT6o7j6IgkRbFiYAwMRhkTNp/Fz
	4NMUZLvnTBm3hJwE/dZfMqdxzZ/vD2Zn7lFlfvGvvAkfOyARQHxTPcpes2/jiJVdpgoluzv
	uR3K0EMkFDGiMyolJCnH4frll+JAiOJrYDiIR85N4CB1Ax5Rg5p4zyjndXnoBxdmJCnTX2q
	L/VJQg2+iW8p98x/K/yAsWaug4p8j1wUHrKelqGt+8NomwDA/hrfPs6oLNsxluYxZkslhQa
	kbVhCOKea0htM3i1WyMOd6C7OXO+w0myvEZn+ApOqhvXrscl/MUJKS+i7iT6hLF9l3bB797
	xQlzsK4L43e01/VQK6XOD4MtPSKNxzV7NyIZPuQ85nHrhSt9zZTT+FtVOyj1gukqz0C0M3g
	s3ZOpQyunfY9+0UgycbkGR70qqtU9UVtU21BiYcq0VUUscEAeRRbAB7nujOg4Vydd6Iz6/W
	tpwff1Rba+x+ymrBsiW955tkmQsuUx/dN17drpTf7e9WLRWqy4DbFuL4SgfgYuUEdI14YE9
	g==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

misc_open() installs a misc driver's file operations with fops_get(),
which pins file_operations::owner before replacing the file's f_op.  The
NSM misc device leaves nsm_dev_fops.owner unset, so opening /dev/nsm does
not take a module reference on the nsm driver.

If the driver is built as a module, an open file descriptor can therefore
survive rmmod of the module that provides its ioctl callbacks.  A later
ioctl through that descriptor can call into unloaded module text.

Set nsm_dev_fops.owner to THIS_MODULE so the misc core holds the module
while any /dev/nsm file descriptor is open, matching the lifetime
expectation for the installed file operations.

Fixes: b9873755a6c8 ("misc: Add Nitro Secure Module driver")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/misc/nsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index ef7b32742340..e7b63a358df5 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -413,6 +413,7 @@ static int nsm_device_init_vq(struct virtio_device *vdev)
 }

 static const struct file_operations nsm_dev_fops = {
+	.owner = THIS_MODULE,
 	.unlocked_ioctl = nsm_dev_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 };
--
2.50.1

