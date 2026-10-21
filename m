Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553095;
	b=ZyY8+NH8sEu7XvfqFvQVCd6EkYkV5VoNPKWPADbuVHuV7DTPCNCAyfJMLeKCizlqKxGR
	 l+mOtGqZMOXH6mf0Lp5Fbnjbcgms8jFR3ia+IT58lZO5H2C/9B31iOd7uAp9PhAWitBlK
	 Ob1UaYulMKf0ToYLxWPzQawhZWy4pnroak3dFtRiAqIDAdJOV/Zlz+qsjWr2sTcBLuLcM
	 +GNAeCYEfw7zI15FH7vqTA0XbEWPiH7gdLmFICJ8xoyinoZ7Nf98O0LgirsS7gZgN5UmH
	 Qio70wojw9Ha7MycaZxutvZ1JHhRSR6cqM3Tm6RSU2jnhG625Zoma3wZoPVqrHtRxSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A5FwLktz5PtvprNXjwoy8hFZGED8+fDvEmX7G7td2Lc=;
	b=XMvOatoVMFA2AfOzm6I7vfk1coB9BMAQM6U3wUh6CxoRCBZkt+71LfCb46G0rxbvPKvV
	 +jE+TACSQkM2H28GrGBZSQescC9QKZonIRbQKjdgYUjCLdshHyA2RT4U53FJCitd2tBoq
	 L23VU2OLnoPpMm9lHmrW2s6sEsRrszMnF95xWG9JKCzQO48uMQV0yg1UzuGjI5GjaJFGq
	 nKSuD0FkolMdzkM2S2ugubfbEZ/iIfO96AK99MGoCbrK6MntS3fzjRzb2qVpUUJarwTCT
	 sPPa+72b7cJQhhYRUjVZue1jEacL8lyalNhpwJxWggcaUvz7mEAYRxUs1GhxcNARAXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=AmLlPCAf;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F79606E842
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61F79606E842
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=AmLlPCAf
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e96502e447so2107585ad.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553095; x=1793157895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A5FwLktz5PtvprNXjwoy8hFZGED8+fDvEmX7G7td2Lc=;
        b=AmLlPCAfkpz346fbWJeoZOv11aOUYG6FpMTZyCQbBmzS2JMzucLINH3fXQ1LLSVvgr
         +9dFuYvWLuAWTI2GyvyBl/ihQC8idtXBxJKvEySo60BYFfH74aLKsAcFZjL3nl/0O7XK
         ZOtO7BiYlMLzM8cEkNIVZsEo0tN+JwbNEniZFj+Bb+vkc6rCIDvTnELxF0ZfpolG5oPo
         ymwFMiNsEm1AE+/SoMfJYXiPYzI8BvCKTanxfGx2Q6BqdpeSUT9IrWZKC6byxXViGwaB
         zDKhOPuPhHuCX05gT0hLxpFj4dakQpzX+uEah6OQhXV6tT2lZ0NtgAf/SrCgL53r825C
         7nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553095; x=1793157895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A5FwLktz5PtvprNXjwoy8hFZGED8+fDvEmX7G7td2Lc=;
        b=uScJW7P/lH2bz8kxyPm1x/3NHLKqdtminvGAorC/w8jpQYXy849svmVWWfobvVVnbh
         hzmpfusc9BbPBMD35foEsTYuS/NlxpB/SiOZcnmJCN17uYVluvJjY3PBOoyjx+bvGLGP
         VOSYQP5V1cx4jzdCWlytk8T6+XmfIjIAle437euGTrLrRbeDQCIkL8kFwFDW+DbUcZ1O
         kZjmilrQPvbj4Db2ZZs3pQR/Vc5fytNzUrbHEyyb0YPrug87O1Z5wWlhlg5AHPmgycum
         Z07K988W2zum7lKvwuHTMV0dmPKK7Tc6gzpn5oVajExSdXHcv+npBsKowRcvYLQp8ENT
         UMTw==
X-Forwarded-Encrypted: i=1; AKwUvByQsUmG8p2Xxsk8ulrL83Xno1HFDYD8X8dCj0IN5BDG0P5El4ChRsM1a9tGyafOb4m+UF9rDjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKRQcYfpEj/Hfz26hXWKt6AijWHQL4SksbDdE2KFWxj1/6CJlEf
	7NoUnqr/nyYFLv2ODWzsJ62NZKmytLkFGIavtoL6sbVAIHeEQBqGSqToi5ZnQRG5vRo=
X-Gm-Gg: AYBFou2ApWgEaRiU2ZgUBd69Ab4G8SqmwDkYTcKtoPr80IqXaKMUMzH/RLVdQBtTycH
	RYWDih3HlsvUvgpyf2K1dL19bZkC8uayjBOovq25timuWNc9KgEyWARxwJxeE51yCEWMFtWNbQO
	pLavp7DhJTqK57u5O4z+tZpSpHAa20FYpJpnQ/Lc0GZThNSSffvoJxbEgOvTCyPmb4Tn1UmA9Vw
	f5PC1lFUN/40n8b90fUgdqjkpWzzIfV9V8pxrz2mi0hbAk0WrygzMHRp+E+mrvbiIsu8ofnDl94
	GuOSSPUxVwnzZasJ6pkyHYN7L8J98EAa4pWfFNDvIUcskKqkaTIudaCyDFp0Wt0v6DehEtgNc9l
	/Nl24C2/n43J54fpU1pic9mbNxa553YrZ7u5k98uvMqmJqgwid7xtLhW0DYt/vuKZ97lMXgoukt
	hVHI8P6duH4cphVX15i8YPpDXm0G1OdB8E/eQzch7vbEWkuOsFgY9UFVj4+UPTavlbi8IN0yHQi
	c4M0/88JisLA4HV1/c1TzN+eMXQ8TrEf9gSzd0MSzVQKCE+NysFnAsmBbEaoX7T2F6wiufKwpBr
	OLqLEW9GO4+E7AvMUqLDi9gRPSqNxKgn0COWa3wDtpqvKJKAaH1YxRcaeTeJ8ZiQsi1noM4to2X
	K
X-Received: by 2002:a17:90b:5645:b0:3ac:b7b9:6471 with SMTP id 98e67ed59e1d1-3ad8707b58bmr634341a91.65.1792553094582;
        Tue, 20 Oct 2026 20:24:54 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:54 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security,
	stable@vger.kernel.org
Subject: [PATCH net v6 2/6] nfc: nci: uart: serialize driver selection
Date: Wed, 21 Oct 2026 08:54:39 +0530
Message-ID: <20261021032443.44412-3-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021032443.44412-1-shubham@octane.security>
References: <20261021032443.44412-1-shubham@octane.security>
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

NCIUARTSETDRIVER assumes that tty->disc_data remains NULL until a
transport has been selected.  Two concurrent callers can therefore both
allocate and register an NCI device for the same line discipline.

The transport registry can also be changed while a caller is copying a
template from it, before the transport module has been pinned.

Allocate one UART context when the line discipline is opened and claim it
atomically during driver selection.  Protect the transport registry with a
mutex, take the module reference while holding that mutex, and copy only
the immutable template fields.  Keep TTY callbacks disabled until the
transport has finished opening, and unwind the context so a failed
selection can be retried.  Use acquire/release bit operations for the
selection claim so a retry observes the completed unwind.  Treat the driver
number as unsigned before using it to index the registry.

Found during a source audit assisted by OpenAI Codex, gpt-5.6-sol, and
reproduced with two concurrent NCIUARTSETDRIVER ioctls on a pty-backed NCI
UART.

Fixes: 9961127d4bce ("NFC: nci: add generic uart support")
Cc: stable@vger.kernel.org
Assisted-by: LLM KASAN
Signed-off-by: Shubham Antil <shubham@octane.security>
---
 include/net/nfc/nci_core.h |   1 +
 net/nfc/nci/uart.c         | 133 +++++++++++++++++++++++++------------
 2 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/include/net/nfc/nci_core.h b/include/net/nfc/nci_core.h
index 664d5058e66e..2f542f5c9496 100644
--- a/include/net/nfc/nci_core.h
+++ b/include/net/nfc/nci_core.h
@@ -454,6 +454,7 @@ struct nci_uart {
 	spinlock_t		rx_lock;
 	struct work_struct	write_work;
 	struct tty_struct	*tty;
+	unsigned long		flags;
 	unsigned long		tx_state;
 	struct sk_buff_head	tx_q;
 	struct sk_buff		*tx_skb;
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index aa20e8603f32..fb9ed281f62c 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/interrupt.h>
@@ -34,7 +35,12 @@
 #define NCI_UART_SENDING	1
 #define NCI_UART_TX_WAKEUP	2
 
+/* UART flags */
+#define NCI_UART_DRIVER_SET	0
+#define NCI_UART_READY		1
+
 static struct nci_uart *nci_uart_drivers[NCI_UART_DRIVER_MAX];
+static DEFINE_MUTEX(nci_uart_drivers_lock);
 
 static inline struct sk_buff *nci_uart_dequeue(struct nci_uart *nu)
 {
@@ -102,39 +108,57 @@ restart:
 	clear_bit(NCI_UART_SENDING, &nu->tx_state);
 }
 
-static int nci_uart_set_driver(struct tty_struct *tty, unsigned int driver)
+static int nci_uart_set_driver(struct nci_uart *nu, unsigned int driver)
 {
-	struct nci_uart *nu = NULL;
+	struct nci_uart *template;
 	int ret;
 
 	if (driver >= NCI_UART_DRIVER_MAX)
 		return -EINVAL;
 
-	if (!nci_uart_drivers[driver])
-		return -ENOENT;
+	if (test_and_set_bit_lock(NCI_UART_DRIVER_SET, &nu->flags))
+		return -EBUSY;
 
-	nu = kzalloc_obj(*nu);
-	if (!nu)
-		return -ENOMEM;
+	mutex_lock(&nci_uart_drivers_lock);
+	template = nci_uart_drivers[driver];
+	if (!template || !try_module_get(template->owner)) {
+		ret = -ENOENT;
+		goto err_unlock;
+	}
 
-	memcpy(nu, nci_uart_drivers[driver], sizeof(struct nci_uart));
-	nu->tty = tty;
-	skb_queue_head_init(&nu->tx_q);
-	INIT_WORK(&nu->write_work, nci_uart_write_work);
-	spin_lock_init(&nu->rx_lock);
+	nu->owner = template->owner;
+	nu->ops = template->ops;
+	nu->name = template->name;
+	nu->driver = template->driver;
+	mutex_unlock(&nci_uart_drivers_lock);
 
 	ret = nu->ops.open(nu);
-	if (ret) {
-		kfree(nu);
-		return ret;
-	} else if (!try_module_get(nu->owner)) {
-		nu->ops.close(nu);
-		kfree(nu);
-		return -ENOENT;
-	}
-	tty->disc_data = nu;
+	if (ret)
+		goto err_module;
+
+	/* Publish transport fields before callbacks observe READY. */
+	smp_mb__before_atomic();
+	set_bit(NCI_UART_READY, &nu->flags);
 
 	return 0;
+
+err_module:
+	cancel_work_sync(&nu->write_work);
+	kfree_skb(nu->tx_skb);
+	nu->tx_skb = NULL;
+	kfree_skb(nu->rx_skb);
+	nu->rx_skb = NULL;
+	skb_queue_purge(&nu->tx_q);
+	clear_bit(NCI_UART_SENDING, &nu->tx_state);
+	clear_bit(NCI_UART_TX_WAKEUP, &nu->tx_state);
+	module_put(nu->owner);
+	nu->owner = NULL;
+	goto err_clear;
+err_unlock:
+	mutex_unlock(&nci_uart_drivers_lock);
+err_clear:
+	clear_bit_unlock(NCI_UART_DRIVER_SET, &nu->flags);
+	return ret;
 }
 
 /* ------ LDISC part ------ */
@@ -156,7 +180,17 @@ static int nci_uart_tty_open(struct tty_struct *tty)
 	if (!tty->ops->write)
 		return -EOPNOTSUPP;
 
-	tty->disc_data = NULL;
+	struct nci_uart *nu = kzalloc_obj(*nu);
+
+	if (!nu)
+		return -ENOMEM;
+
+	nu->tty = tty;
+	skb_queue_head_init(&nu->tx_q);
+	INIT_WORK(&nu->write_work, nci_uart_write_work);
+	spin_lock_init(&nu->rx_lock);
+
+	tty->disc_data = nu;
 	tty->receive_room = 65536;
 
 	/* Flush any pending characters in the driver */
@@ -180,14 +214,17 @@ static void nci_uart_tty_close(struct tty_struct *tty)
 	if (!nu)
 		return;
 
-	kfree_skb(nu->tx_skb);
-	kfree_skb(nu->rx_skb);
+	if (test_bit(NCI_UART_DRIVER_SET, &nu->flags)) {
+		kfree_skb(nu->tx_skb);
+		kfree_skb(nu->rx_skb);
 
-	skb_queue_purge(&nu->tx_q);
+		skb_queue_purge(&nu->tx_q);
+
+		nu->ops.close(nu);
+		module_put(nu->owner);
+	}
 
-	nu->ops.close(nu);
 	nu->tty = NULL;
-	module_put(nu->owner);
 
 	cancel_work_sync(&nu->write_work);
 
@@ -211,7 +248,8 @@ static void nci_uart_tty_wakeup(struct tty_struct *tty)
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
-	if (tty != nu->tty)
+	if (tty != nu->tty ||
+	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
 		return;
 
 	nci_uart_tx_wakeup(nu);
@@ -300,7 +338,8 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 {
 	struct nci_uart *nu = tty->disc_data;
 
-	if (!nu || tty != nu->tty)
+	if (!nu || tty != nu->tty ||
+	    !test_bit_acquire(NCI_UART_READY, &nu->flags))
 		return;
 
 	spin_lock(&nu->rx_lock);
@@ -328,13 +367,12 @@ static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	struct nci_uart *nu = tty->disc_data;
 	int err = 0;
 
+	if (!nu)
+		return -EBADF;
+
 	switch (cmd) {
 	case NCIUARTSETDRIVER:
-		if (!nu)
-			return nci_uart_set_driver(tty, (unsigned int)arg);
-		else
-			return -EBUSY;
-		break;
+		return nci_uart_set_driver(nu, (unsigned int)arg);
 	default:
 		err = n_tty_ioctl_helper(tty, cmd, arg);
 		break;
@@ -370,33 +408,46 @@ static int nci_uart_send(struct nci_uart *nu, struct sk_buff *skb)
 
 int nci_uart_register(struct nci_uart *nu)
 {
+	int ret = 0;
+
 	if (!nu || !nu->ops.open ||
-	    !nu->ops.recv || !nu->ops.close)
+	    !nu->ops.recv || !nu->ops.close ||
+	    (unsigned int)nu->driver >= NCI_UART_DRIVER_MAX)
 		return -EINVAL;
 
-	/* Set the send callback */
-	nu->ops.send = nci_uart_send;
-
 	/* Add this driver in the driver list */
+	mutex_lock(&nci_uart_drivers_lock);
 	if (nci_uart_drivers[nu->driver]) {
 		pr_err("driver %d is already registered\n", nu->driver);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto unlock;
 	}
+
+	/* Set the send callback */
+	nu->ops.send = nci_uart_send;
 	nci_uart_drivers[nu->driver] = nu;
 
 	pr_info("NCI uart driver '%s [%d]' registered\n", nu->name, nu->driver);
 
-	return 0;
+unlock:
+	mutex_unlock(&nci_uart_drivers_lock);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nci_uart_register);
 
 void nci_uart_unregister(struct nci_uart *nu)
 {
+	mutex_lock(&nci_uart_drivers_lock);
+
 	pr_info("NCI uart driver '%s [%d]' unregistered\n", nu->name,
 		nu->driver);
 
 	/* Remove this driver from the driver list */
-	nci_uart_drivers[nu->driver] = NULL;
+	if ((unsigned int)nu->driver < NCI_UART_DRIVER_MAX &&
+	    nci_uart_drivers[nu->driver] == nu)
+		nci_uart_drivers[nu->driver] = NULL;
+
+	mutex_unlock(&nci_uart_drivers_lock);
 }
 EXPORT_SYMBOL_GPL(nci_uart_unregister);
 
-- 
2.43.0

