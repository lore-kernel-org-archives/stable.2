Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551686;
	b=hsS+7r7G9ilLQm9gS2Nj6O3nQvSlvhjUxuBey0i/f5y/EIRBrEmPgHJmku91usKh3/KD
	 sNbUuddmfwww9BDMvpPNqO0aiw2bycvNsL3zrFgLLZcNRqAXa2CyRP+NcvInI25oLsVYy
	 WTmyrl8GBeuAwoEUgsB5/HGcvBuRZ1dMRVNVg2aFOSULNQN+k1BYnVODEjNKnnSHB/xbR
	 uVFLNzYL/I1QwGIVMh+gtCd+U2+LD3ONZjrm5vEu1N0Y5vrSnvJoJWY3QuI4lUz2WwiR/
	 rNtsKz1b8WfFMTTx7fwInVrRHsp4MSg2jWVH73+Z17BsGvM8FmQk43p8X0OxXup0ouQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n6vkIDMoqXBl2eKdspHtWw5uEM5j7saGuWr0jlVkPSY=;
	b=B2HIe8LHMWNYCwX8QS9/7MIrjD0Qx+OPnz0JEKLIBf0qcLZdGgjj04o/WIpDBwjS7efe
	 etqaru3OpjgDHo0XupiyGtFpC2t1aNfotKU9khsL9apX+FDLPMvOkPDV5Wb4TYeEyF33x
	 U8AlznJbLLgnEX08SW09dBZQP2l/PGFF6n3ihH7orz0W8DuftpJYY+aXo6DvWTxLyBoVO
	 wILQzbh3eGJkqUkT5q7Rj+2A0VMXDZOHD7C/hRx8WvitPXZK8gm/o8ioWHpArLywNUBAX
	 1CqANMx3AVIb55OawNIKmRQZW5wD3uX6KC13A94SWjVwsZB9zqqogl38M9qlGZ+mzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eqzg3eMS;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D71606A883
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01D71606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eqzg3eMS
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36e90071735so100692eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794551685; x=1795156485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6vkIDMoqXBl2eKdspHtWw5uEM5j7saGuWr0jlVkPSY=;
        b=Eqzg3eMSsfJXGVAIw4llXmb/7RLiL1jicPyXBM92BNvpUxYtNR7kNaLh3hPHWelN9u
         QFywE8bfOGCHpzAlOwj10TQAhpSme1U6ra5nSEblgyO0dcUx7bVPe+aQqH1a5sk2kvTy
         DZhDMnfxUldUHZ8pcxFmKwB/2H8lVc0DtYlJ3OZqEE/9SiWClMDgtuDV4ZByazQ+eQCJ
         IefsRrjSCDZkUKN4yWlQdGMlCcvpZikWEY81kSYEfN+2QNDgEQ2AXyS7Un+u/WJqIeuc
         FWN7AeVd8s9Az9/aaoPn+S93+2kxwfs9HIGoGHXBtK4Pg8WxyaS6yCtB9O91rrzKiJz2
         ixRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551685; x=1795156485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6vkIDMoqXBl2eKdspHtWw5uEM5j7saGuWr0jlVkPSY=;
        b=xy5RpHu/THYkPMeia7mGr4UFRxmtVXadryaXP9mcrZ01e+wftJh8IFGInOndzBrxqv
         qyC73+LYssp3rOP53oFE12xYpRlfx0p+m2mTB9ibLigkvRUOTXG7jiljC7uCdP+LmHj1
         bTtR2JCxiVkBT6p6cv2ORBd2A9DjFrbzx/orctnMMuYEJrHUll5gIBaEEJquRq6kKxsG
         EPqvs30xjRdsshCElU4j1QF/taYMMIqXIL/6+hoDYvGTg8M/VbhJmwqOhDEgCv3maneD
         qU5x/eMEbLuLCC/V6if5h+c9I3V75fPWOEhbpTGVB50G+DdsAjfujBew9qq21AfqT1hh
         kiGA==
X-Forwarded-Encrypted: i=1; AL+hErH+hcSzTsd5rgJuIcqhKW0ZH/X2GM14cUJobZuPHbU+CzQpVzSjugHI5t0VzCjAELTTGI7grD0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8r18J3km4jLGj+4p1sRIbzBDs3MGAE5mdc5ARCu3QIvkSwWpr+
	oMsNrF3pfmmwD3ArKpj2RM7hjn7jJ41eLZW+F/ckx0eisgVr7fV1BiQU
X-Gm-Gg: AYBFou2Apc2swIenlxOIeuy6rGyu9jyo4Px9fwUxOfdI6eEEa55c4r2uRLoH1h5MhIN
	8Rsod5gbs4OrJ1sHncX1kqW6C9XJpB6FnOVBU35DR3poiwnWRGZRtBIL2XF1Mi1LuKLlAOnCjFG
	aM8IOdB9ylgJ+PqVJOq+UwSDKrRYFy0TPL+GSER0DW3YinRcmIIJE5HF1hTdR3zUXp5L+UxiQqr
	JYAZNybyRhjQacFl5orGLCX88/aKTvWOmyb4UhABXwiZVFxKXtn8lMpdnvHsBG8rveNc6XnVzAk
	10R8LGU9UIyi9u/1TvHCF8MFuMOEJztlku1ERLwTsDtDg+YedqgEy2uTgCKHXhmFCBV4OQC0AW+
	AXLEf9sgGcK+t24WBTpGg0fYAWJhXkZOr73JAIFtlxVY8N4iFbEw4BevT4TF/u3vQkOacV8/JLW
	G46Yei2nD+lXprBgHrG0zy6GZpyY9/+aDrFjMQQC7miGWo9eAXyLNPPzagxlJrSbGkh7dbkvR7+
	qqdojzOdpLQ8NF9Eb0AwK4C0zo5UpBgYGuIll2x5ez+kjarEx/xSQefC8qt90/fYnjmeJplpaOL
	wnt+wXYiwgYBOzbvzy9BKFEgj3XaVLncydx5XzR8eA==
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr2445477eec.1.1794551684869;
        Thu, 12 Nov 2026 22:34:44 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm6745027eec.25.2026.11.12.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:34:44 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-usb@vger.kernel.org
Cc: b-liu@ti.com,
	gregkh@linuxfoundation.org,
	nkapron@google.com,
	tony@atomide.com,
	bigeasy@linutronix.de,
	balbi@ti.com,
	shimoda.yoshihiro@renesas.com,
	robert.jarzmik@free.fr,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] usb: phy: gpio-vbus: free the interrupt before cancelling the work
Date: Fri, 13 Nov 2026 14:34:09 +0800
Message-Id: <20261113063409.47485-5-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113063409.47485-1-lui2012qwq@gmail.com>
References: <20261113063409.47485-1-lui2012qwq@gmail.com>
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

gpio_vbus_remove() cancels gpio_vbus->work while the VBUS sensing GPIO
interrupt is still live: it is devm-managed and freed only at detach,
and gpio_vbus_irq() schedules the work with a 100 ms debounce delay.
A plug event landing after the cancel re-arms the work, and its timer
then fires on the freed gpio_vbus_data.

Free the interrupt first, which also waits for any running handler,
so nothing can re-arm the work past the cancel.

Found by static analysis and confirmed with a KASAN reproducer:
slab-use-after-free write in __run_timer_base() within one debounce
interval of unregistering the device while its VBUS GPIO is toggled
(object allocated by gpio_vbus_probe() via devm_kmalloc(), freed by
devres_release_all() at unbind).

Fixes: c2344f13b59e ("USB: gpio_vbus: add delayed vbus_session calls")
Cc: stable@vger.kernel.org
Reviewed-by: Neill Kapron <nkapron@google.com>
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v1 -> v2: no code change; collected Neill Kapron's Reviewed-by.

The reproducer instantiates the unmodified driver on a gpio-sim
chip in QEMU and toggles the line while the device is unregistered;
it widens the remove()-to-detach window with a 500 ms sleep, logic
otherwise unmodified.  Repeated runs: 5/5 KASAN splats without the
fix, 0/5 with it.  The KASAN report and the reproducer kit follow
in this thread.  Also build-tested on x86_64 (USB_GPIO_VBUS).
Fix written with AI assistance.

 drivers/usb/phy/phy-gpio-vbus-usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/phy/phy-gpio-vbus-usb.c b/drivers/usb/phy/phy-gpio-vbus-usb.c
index 60b7c1219dd2..82d2301c3804 100644
--- a/drivers/usb/phy/phy-gpio-vbus-usb.c
+++ b/drivers/usb/phy/phy-gpio-vbus-usb.c
@@ -325,6 +325,14 @@ static void gpio_vbus_remove(struct platform_device *pdev)
 	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
 
 	device_init_wakeup(&pdev->dev, 0);
+
+	/*
+	 * The VBUS sensing GPIO interrupt is devm-managed and freed only
+	 * at detach, and its handler schedules the work with a 100ms
+	 * delay; free the interrupt before cancelling the work so a
+	 * late plug event cannot re-arm it past the cancel.
+	 */
+	devm_free_irq(&pdev->dev, gpio_vbus->irq, pdev);
 	cancel_delayed_work_sync(&gpio_vbus->work);
 
 	usb_remove_phy(&gpio_vbus->phy);
-- 
2.25.1

