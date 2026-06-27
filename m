Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFF158DCF;
	Sat, 27 Jun 2026 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782531259; cv=none; b=F3jBUGsaFng7QyaPTqCgF+qxrC24B9Y6pfDLh9W/Bke1qMmxOTIZELlnCjfkqyXH1VhyG0buVMQv1M3+R/HxtXZ6wcvTM2L11R9Y7VkRSychTk6ALGR2brTgx4KJSCrq0ThLrdjw3kIi131Mpo9fzghWDRuhdDvm+y9X8nwbWjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782531259; c=relaxed/simple;
	bh=cWxeTg/S4C9B63XCq6h5vziPOmiEId00rALtb3Kl1Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSCuAD6hZ8HWJxB8b4m+6HppaRImVinvSa/jWrJf/MSY1P8ISe9mnW3rF0KdADc2lGYgWQ1WJU3wOKKeTRt5zs1RZufaXbNf9OCTiCxM7AEpoIPM3+nSl4aIhsiQPjBiqv8DqsSK9Igrd/czKc4GsWURK0NW+KVhGPGwGJmvjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAAHpc20RD9qyhuBAw--.60231S2;
	Sat, 27 Jun 2026 11:34:14 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: drivers/usb/serial: usb_console_setup: unmatched usb_serial_put on error paths
Date: Sat, 27 Jun 2026 11:34:10 +0800
Message-Id: <20260627033410.58709-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHpc20RD9qyhuBAw--.60231S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryUurykXry5Zr1kGF45Jrb_yoWkurX_G3
	4DurW8ZryUuFW5Kry7JrW3Jr4SkrnrZFn2v3W8Kry3Ca4q9FZ3tF1qqr929F4xXw4UXryD
	AwnxuryI9r1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMLA2o-DxBvewAAsM

In usb_console_setup(), serial is obtained via a simple pointer
assignment (port->serial) which does not increment the reference count.
However, all error paths that reach error_get_interface call
usb_serial_put(serial), decrementing a reference that was never acquired
within the function. This causes a refcount underflow on the serial
device.

Remove the unmatched usb_serial_put(serial) call from the error path.

Cc: stable@vger.kernel.org
Fixes: 61dfa797c731 ("USB: serial: console: move mutex_unlock() before usb_serial_put()")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/usb/serial/console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/console.c b/drivers/usb/serial/console.c
index 29f09190846e..e97520cdc43d 100644
--- a/drivers/usb/serial/console.c
+++ b/drivers/usb/serial/console.c
@@ -190,7 +190,6 @@ static int usb_console_setup(struct console *co, char *options)
 	usb_autopm_put_interface(serial->interface);
  error_get_interface:
 	mutex_unlock(&serial->disc_mutex);
-	usb_serial_put(serial);
 	return retval;
 }
 
-- 
2.39.5 (Apple Git-154)

