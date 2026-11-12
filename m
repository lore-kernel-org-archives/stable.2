Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499514;
	b=sQuwB8DfGvSaXI/8Sv4y20ybx9IYlxRzIvqMwBtkq+e9mWV3Wh8EM/kL8wchzgFljDpY
	 HuwnJROOpXsjCR4Eb/5CZU7HHfR5uLrbvGD7uloxDqdxecD4tD/GsiAf0cFz6N+F49gxE
	 YUNz6rj0WqJg6vHBYu61xGM6JKGtNyFpsGeKq6z+PdfOFf0Sa4BGTBoJ5ULkOxoc3xyNf
	 2T8erhPBZehjhqQRTcptlwtkxk61xHkHkkcqXWOpIGKH/hcXq2WOJezfFy7BFGP8N48cr
	 +mL81M3dbBvdERwf6jrPAHeweraKNgN5sUnBYJzbdZoNcxvqnC//4XshDi8/uZCiSrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VMc78JgEAs7pEZMCa+sdp1KqpJLxePsHY7uD0WQ1SfI=;
	b=D/RqCVYI/hbNTaftz2Hk7YnJmfxgZdAGOcPyRg5yIg4Zz0usXWNAzy/a9daWtwdVl4YC
	 Bd7MUUdH7O81UJ+pr7VYgY94Op+7D30sftpwhdido5y5h3y7Mjqsa7RyAMkzixVkt78Sp
	 eEbtzxx8gDNbk8fHDVfWovH2gJNlRnhI5oIama/aoor3Tlo/bGj7NqVa/25En9PuKIFnj
	 +OP/5fZENWn6Lpo8AG6xeuDWad/fWmhGvWtM+OTZJT2z/K51wCq1E6U9HBgPSRr/7F7Nl
	 skOYilKMhPrPbxxE9zvkqpduWnWVoAOXiJrU1pJNJ07U6geEM6akkjMc4Vi06YYIUEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1q7RrDR;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901F606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B901F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j1q7RrDR
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33c10faf6easo5256eec.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499513; x=1795104313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VMc78JgEAs7pEZMCa+sdp1KqpJLxePsHY7uD0WQ1SfI=;
        b=j1q7RrDR8fZBAlj+F2pwk9+Ag3SURyZ9+eispT9RdIXwg4+OZyNr2vtoHdyOeYU78U
         Yf5Ffp5ueJyvP6Y4TPA6CLVbL/3o8Vf7CYf1simUG0vN+pBuG8fYU+EL7SCNA2RPuhou
         ausY6rusQodrFfUvpOzEGty4s223ht7uIdP//0wOhYHntW5LhoZcx21a5EW677CYB7YH
         KHFgZHpDfYa8re7wGaVBAdmR28tmgy4hO007PsHoe78Vju7sFMunH0nZvVNI8uc1vGCB
         IeqCrhQ+bdO49pHs8myjvAH/ECWnxwL04WZXPue0X+07EzX/7KDwguN+P+c5viGHIDVy
         BVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499513; x=1795104313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VMc78JgEAs7pEZMCa+sdp1KqpJLxePsHY7uD0WQ1SfI=;
        b=cKzoTXVmBh+gXJwnmBeMIid4YCDKzgZl0WDJYIMwin6chVkXAgJDQgf2oWnWKuoM58
         r/3kOSKVAJ5dolNEq3n+x9a1o9XFfcbaZAfPkLkwDToyR7sEn5uXQ+TyTHusvwhpH6qn
         urZ1QpQtFJ2RioZDKoOJJFuEfTe7dqn9bjyEdecDxvQmQCWVmqZ6cCZD+sQlVuY3lse+
         OqTBqhWLIeD9EID6K89pJDPwy0BSm9zGwW6f4Ky3gTKQKu0wRS7T7wqvbcWI8Tbnee8l
         ffRpfoHmEyNFmGxrOM0jLOsvGmcNLUYMQ3pqqsEYZISMXwB4e4MyFg1fnKBSt3Kh603t
         AN7A==
X-Forwarded-Encrypted: i=1; AL+hErEINcLuA2cPo4u1cvub9QKJh11jtuHV6wUmH0NAfJHpcyGWqbKXs5uaNyaBnPkZtfUSdf3kQGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AMTqpRWFqEPV1D+NziIV9XrvPRf6AJQjGMPaEWoYfhBsqSzgM
	WZ02+lwavHW+WG3eeHrYPC5dgVU9f0XhjafgV/09qdQE8DcDzJq3FDJ1
X-Gm-Gg: AYBFou00YMLtiv5FGzr0RiMVbPRfsYmLjBeQYKskOFEWo1ruaalLryvVuj1BlgK+rMz
	bcUQkF41Doc+AgizlWNEKF+q1jMOFhY8BG/DSR7QK9eHNxHcvdyBpbEtglD9V0smAXUUS84S8NJ
	62dGr4g1lxoIGaJD1CddgNh9BOliMgrJlPvACImMiNndvvjRUp6MgUYm/BasDcFOn5YwHARw28/
	4GbsrGdj3UkotekC/EXzCfcVvNy/GCpdIlFfUQVZ8pyS8xMsEi0dlix5IEX170CiWxIABD77wqw
	MwCrUxLLZQ2XKfcz3ZCx6gMw7r3SskZyquYm0sr4c066dtb/zQOJ+kucJNvU6qkohAxynSwUDmO
	+MlpuOZ0qujOWFDnA+7dAQ19mVi6/Nb5Q5iRHXba1zRctqzPkVRF3kbUVTGZ0RpJoebAVYlGMVJ
	W6eMJtsuNtlXb3GgielRswLw6oAmGGR5jJrjiExQPPUCRTjNZ3K5SIXQW2akVAZoSI1kCii+Ec9
	D//m/kEhmRIQ/23/SYPSuDSqka9dxvyRnxYQjKT+IVqnY9EBBUJxf+jRxf2/kAxiksAFuT2k4ZR
	04yAB9Va6B6yJXZiUM7CCvGyUTl9DLY338pnhveRXw==
X-Received: by 2002:a05:7300:fa13:b0:372:c0ee:875b with SMTP id 5a478bee46e88-3767ff8b6abmr8776758eec.0.1794499512744;
        Thu, 12 Nov 2026 08:05:12 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37922d49049sm613673eec.1.2026.11.12.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:05:10 -0800 (PST)
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
Subject: [PATCH 2/4] usb: musb: dsps: free the VBUS interrupt before the child teardown
Date: Fri, 13 Nov 2026 00:04:46 +0800
Message-Id: <20261112160448.41566-3-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261112160448.41566-1-lui2012qwq@gmail.com>
References: <20261112160448.41566-1-lui2012qwq@gmail.com>
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

dsps_remove() unregisters the musb child, which deletes
musb->dev_timer and frees the structure, while the glue's VBUS
interrupt is devm-managed and only freed after dsps_remove() returns.
dsps_vbus_threaded_irq() re-arms the timer via dsps_mod_timer(), so
a VBUS event in between re-arms dev_timer past its deletion and
otg_timer() runs on freed memory.

Free the VBUS interrupt first, which also waits for any in-flight
handler, so nothing can re-arm the timer once the child teardown
runs.

Found by static analysis.

Fixes: 369469a92393 ("usb: musb: Add support for optional VBUS irq to dsps glue layer")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
Build-tested on x86_64: musb_dsps.o compiles clean
(USB_MUSB_DSPS).  No runtime reproducer: requires AM33xx/DSPS
hardware.  Fix written with AI assistance.

 drivers/usb/musb/musb_dsps.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 91d8712efa41..69c8b4b3ffa7 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -942,6 +942,17 @@ static void dsps_remove(struct platform_device *pdev)
 {
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
 
+	/*
+	 * The VBUS interrupt handler re-arms musb->dev_timer via
+	 * dsps_mod_timer(); the IRQ is devm-managed and would only be
+	 * freed after this function returns, while the child teardown
+	 * below deletes the timer and frees the musb structure.  Free
+	 * the interrupt first so no VBUS event can re-arm the timer
+	 * past that point.
+	 */
+	if (glue->vbus_irq)
+		devm_free_irq(glue->dev, glue->vbus_irq, glue);
+
 	platform_device_unregister(glue->musb);
 
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

