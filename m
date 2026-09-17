Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB04B7A4D;
	Thu, 17 Sep 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660532; cv=none; b=LGdYWYPfmnlWt3CpGOxeUZYhBtXBjLToro9MHx3D1DEyqr/g9KYPj3Ci3YPR4VXNIQrQoC8pUQ0rCw1WRRq+3DQ6Y1GuB1oNGLKwOyIDj8nVrE1z+niroYIRHKwT+gTFlkHHrPk+AF+j/yLNEPTRrRQh85R9hA5b2Ac9wgikCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660532; c=relaxed/simple;
	bh=CKiDNDlAPivZUnh2+t+SQ0i9i1s0550awWQilbIllXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFf6PuOLUooFXkSiYJfOgbZOzp07GVRMbyZUJesQsgdAXF1J+FDJ95wSOQyV/fkAvXbBw3jhAx4Z9ZuhTTM64U1KXsBVkdz0jY66/qYmbF4T0Zl7UOLHfO+8HiqXKqD8eNTo8UBvu/RFinS8puDZv2+mwGcevM7iGNxsTHS1744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC36EJrDaxqhvGDCA--.6286S2;
	Thu, 17 Sep 2026 23:55:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alan@redhat.com
Cc: danielt@kernel.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	jason.wessel@windriver.com,
	jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kgdboc: Fix tty driver reference leak in configure_kgdboc()
Date: Thu, 17 Sep 2026 15:55:23 +0000
Message-Id: <20260917155523.2161202-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC36EJrDaxqhvGDCA--.6286S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWUCry3ZFykury5Jw48Crg_yoW8Jw4DpF
	47JFy5AFn8JF48XanrXr18CFy5ua93Ka1agryUAas8Za45ZFyjkw1aqry7tr48Ar48ta47
	K395Cr4UCFyqyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7M4II
	rI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMx
	AIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1oUDJUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgENA2qr8889TAAAsF

tty_find_polling_driver() returns the tty driver with an extra
reference taken by tty_driver_kref_get(). configure_kgdboc() stores it
in kgdb_tty_driver but the reference is never dropped: it is leaked when
kgdb_register_io_module() fails, when the configuration is cleared, and
on every reconfigure.

Release the reference both when unconfiguring and on the error path.

Fixes: 7d7b93c1452f ("tty: kref the tty driver object")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/tty/serial/kgdboc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 5a955c80a853..e2c8e5ec688c 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -188,6 +188,11 @@ static void cleanup_kgdboc(void)
 
 	kgdboc_unregister_kbd();
 	kgdb_unregister_io_module(&kgdboc_io_ops);
+
+	if (kgdb_tty_driver) {
+		tty_driver_kref_put(kgdb_tty_driver);
+		kgdb_tty_driver = NULL;
+	}
 }
 
 static int configure_kgdboc(void)
@@ -254,6 +259,10 @@ static int configure_kgdboc(void)
 
 noconfig:
 	kgdboc_unregister_kbd();
+	if (kgdb_tty_driver) {
+		tty_driver_kref_put(kgdb_tty_driver);
+		kgdb_tty_driver = NULL;
+	}
 	configured = 0;
 
 	return err;
-- 
2.34.1

