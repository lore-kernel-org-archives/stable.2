Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D2347DD;
	Thu, 25 Jun 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403577; cv=none; b=RrwJPyQbSfuT8+iVNhNUbFya+K+TyjiMM+/dlmTiBlqg4+G+4ZyvRQx7qgnsSRbVWbOZCTyuDwIIOyIFjEWhWlSXLydCi/NqHQ3Kdkpt6/i8O+liXpguowcemnLdC21gnWWkWFxHRL6+zEw6D7ahitw+tIBebR8IFgUC6nX+IKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403577; c=relaxed/simple;
	bh=l+DHLD0yCxEuPehPS7ksD3dSugjvskURTfhbZEviHx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pN2vSveU3waJdMCuz1tTXIG7CUjvF5a1nXc262cAbQjP2QoepBQMkKS5oCU4A4gpeVjnnCdBs9fx9Ogv+K6T/D60HkWVq2dCf5DQq3wqWa5GGBi0TGuILrf/skHoFhPvnC+P3s1Qjpoj+ZEzMQ3lK3SKWSFGl4HnOHiAXdA9akc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-05 (Coremail) with SMTP id zQCowAAnoPPxUT1qk2o9FQ--.23845S2;
	Fri, 26 Jun 2026 00:06:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] btmrvl: Fix hdev dangling pointer and error code in register_hdev
Date: Fri, 26 Jun 2026 00:06:07 +0800
Message-Id: <20260625160607.81615-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnoPPxUT1qk2o9FQ--.23845S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1ftrWxGw4kAFWUXFW7CFg_yoW8AFy3pa
	1kWa4Yyr1FgrWIvrs8AF4Iqa90ganxX3y8CasxAwn3Zr4ay3yvyrs8ZFyjqr15KrZ5Zw13
	KasrWw1Uu3WUAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8JA2o9Q74fFgAAsv

In btmrvl_register_hdev(), when hci_register_dev() fails, the
function frees the hci_dev via hci_free_dev() but leaves
priv->btmrvl_dev.hcidev as a dangling pointer. While the subsequent
cleanup code does not currently access it, setting it to NULL is a
defensive fix that prevents potential use-after-free.

Additionally, the function always returns -ENOMEM on the
hci_register_dev() failure path, discarding the actual error code.
Fix this by preserving and returning the original error code.

Cc: stable@vger.kernel.org
Fixes: 132ff4e5fa8d ("Bluetooth: Add btmrvl driver for Marvell Bluetooth devices")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/bluetooth/btmrvl_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index d6f0ad0b4b6e..3a4c8abae05b 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -683,7 +683,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
 		BT_ERR("Can not register HCI device");
-		goto err_hci_register_dev;
+		goto err_hci_register_dev_free;
 	}
 
 #ifdef CONFIG_DEBUG_FS
@@ -692,8 +692,9 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 
 	return 0;
 
-err_hci_register_dev:
+err_hci_register_dev_free:
 	hci_free_dev(hdev);
+	priv->btmrvl_dev.hcidev = NULL;
 
 err_hdev:
 	/* Stop the thread servicing the interrupts */
@@ -702,7 +703,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	btmrvl_free_adapter(priv);
 	kfree(priv);
 
-	return -ENOMEM;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(btmrvl_register_hdev);
 
-- 
2.39.5 (Apple Git-154)

