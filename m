Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045772;
	b=v7Q7ypRz1BfXRkDkMr6dQu4YBk2fAlzp42unWX6g/LUo+sTRWiaKkhW8EfJ2G4a5K+RH
	 aif205zUnNxXdennhNrCHNtDMcq+ESGm8urdbeBnpP/L5svA71Il/61ZXgK6L+uwRjhLP
	 tekaUjyD8m+BTQ9haJiZwwQRSdjAJhs88AKSziVImZlMvciYJinLaCCVEUJlKKnAvOXjv
	 /OGRGSOqEte3nJNP9l6OlAdlxQfoUSUTCrEPM8GLoCUpw8g9V88MsFV3YhTMmCTitv4aP
	 7WZfQlO0oHMmgj3IViLZcOMy9zPu8kmM3f8I7ndQYeWCyXmhJ9wm/HSrcZf30UW5eJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N2J859H+uWsojSkha9zezH8TJJ6OSnMwegHD1qKOF64=;
	b=bQw8WKyk/ssbaLDsyE+137otiVcMI99ODP80z9/RizDicVeQX1ov+EyCQ67bm/etnqq5
	 cTtNjjMsS53VTib9WXQZ0Tiulyttv5yaoXK7MGyOVn6exGjZpoaZdchrSwaYvHZxZY+iX
	 v93I26J1Z9bVbOesbgKu5pGeORYwoMNJjH5FSUKCUip1Utpq+w1g8++lGcGS50LGvkv07
	 FMCK399mW1NIKSI+JHS/pk0klCrhwojo5qQlEvKFleHoodB4r5l/pTUwIObI06hWDev76
	 kVpGkdq05hTv2BCJvVuB9e+HidNBOp2gyZPegviraDwEq1TucVVINN0beOq/fhprV6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwDzbLFR;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D74D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BwDzbLFR
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so917138a91.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794045770; x=1794650570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2J859H+uWsojSkha9zezH8TJJ6OSnMwegHD1qKOF64=;
        b=BwDzbLFRwEm//pUHT/71T3R10Z48hOxXLkQanXNmEMP3e7yH8k/yoBAwpcFgjW4WbD
         R2Ik4Dbi3HIh1w1ElO7YBKep/CfBTeIcKxofrcBMfwXsyDmSZe+ACOOd+rd7sppKs6vm
         o2NE54yUzVwiWuTlrKJDaKoyD9uqSDZLqaxwmMRdZmW3+jBPTh47wl5vtzCZ+dCIYRpM
         8fOV79WMXPFsRQL8vcs09QSBTyaNJZT10cPOSD0HtDVehu0Kxw3qYK+fe+30uwCD53ng
         m97+DK+DwFI+NeOniuMHWRGaprl+tqsM9I7ova4WtaL/z2/UOs1JMGyIYow6CjZb6E4f
         eXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045770; x=1794650570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2J859H+uWsojSkha9zezH8TJJ6OSnMwegHD1qKOF64=;
        b=cKBzrF/OqguWG8ZzBzDzdcw287Q+Oxsa2wLkrq5lJAJ1uZpwvB/Ld8au3yqdExaD9U
         wcoB8LWKbblRALDSmTL1jxLFRDILDwRZisMMLxDntm1SRaskYMWziHVYKaIIzWVtf7q3
         wJ0ZgY+AUJ/VmomvBp69x0mwduNYI8gOnOrArjWUA37S6nohbY317kofRCWASw9iwn1f
         Q/o9k/jEY7wkeNacpUZq2aK+YXG7upI1Rx+aa4CBQwbNHTaOxRlSWXpjwhBECOVmNefs
         2wFb4zptgAITRpg63IC4EESIVf5SqpDpXojOdFWfl0tV4K6lrj012sekHIlw389RZr+g
         rV7g==
X-Forwarded-Encrypted: i=1; AL+hErFUpj1sPJ7lwGeYaU9Q5BUfDTXeMHaAadubcafzRkImGgEk6ImVg/YWKNw1XO5YTUjEiJOASWM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+hlG3KA1pJXUppBuqrjhtTyzHyoZhTQQawhx0B++hE02AV4tgm
	7yDEbweQDWgwC2inXTvS+kUp8FsagmlK35dZ+/XN40zNdE7f/R+4Fed3
X-Gm-Gg: AYBFou24UGi5Eyd3W/G3TLToMRfLRzdd+l5l9WM+1TbOgelFkvYrOmBpbBmI5XLljeT
	77cOlN2SuHmU0crjx9YwfgtVU9KdBkB4zEn+uafvvz9Ml4z1ScRd03/HezL0+OiKsj+n6w3ILLR
	4G8J/yqeyoI/Wz/5jim/z1YuiGnlyhRk9I9V0sKtqWS5iwgP4FkDkv4ezKfYjBn0okm/O6gxfXu
	I5AzuwF8jHQwJDfwyCd8XJxWEPmVkielI3SiQdbsv3HEPTeuyPOSuNOJ7eJZydx1FgEmf7u4KjD
	RFIydMOtzjX+gsu6j1wF+/+TF4OBjzH7xua/LTtOoZvprpZRaM6gNSdJ4S43AtjUFos99KIcMua
	2Z80ALrz6XlLRrB23TpqYZCXUKkQSUUjFaTjY5T6eIF0IsL3USFTvTuqadaOyVoiXLmp4zc+Rfr
	4I4sSQ70mOX03tyRjamnoVs0aJ5ESo/FNIG/OCHwbxKV3h0eD6QreZhPjReHyn6/ams9x30EwY8
	nLVjkn0iVX3VEfEC0xPtZUScpTQtr8k1GpHeV8QsZXUxg+wxt3maCNiIJsXLvW5NJ0jvhe2hoY8
	/DXk36iZMNY9m09HEqegUFsIT7V/vz86kG2YqTUOKmuFYyLKdQhvrrg5oCq0dNgH+eWrow==
X-Received: by 2002:a17:90b:530c:b0:3ab:2737:3393 with SMTP id 98e67ed59e1d1-3b0db6f4c26mr4969368a91.40.1794045770439;
        Sat, 07 Nov 2026 02:02:50 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1152fa888sm142705a91.9.2026.11.07.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:02:49 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwrng: cctrng - cancel deferred works on unbind to avoid use-after-free
Date: Sat,  7 Nov 2026 19:02:38 +0900
Message-ID: <20261107100238.3542588-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

cctrng schedules two deferred works that dereference the driver data via
container_of(): compwork (cc_trng_compwork_handler) is queued from the
interrupt handler cc_isr() on an RNG completion interrupt, and startwork
(cc_trng_startwork_handler) is queued from the hwrng read path.

The driver data is allocated with devm_kzalloc() and nothing ever cancels
these works. On unbind, cctrng_remove() only runs the PM teardown, and
devres then releases the hwrng registration, the IRQ and finally the
driver data. free_irq() stops further interrupts but does not cancel a
work the handler has already queued, so a completion interrupt arriving
shortly before removal can leave compwork pending and have
cc_trng_compwork_handler() run against the freed cctrng_drvdata
(use-after-free). The hwrng core does not drain this driver-private work.

Register the works with devm_work_autocancel() instead of INIT_WORK().
They are set up before devm_request_irq() and devm_hwrng_register(), so on
unwind devres unregisters the hwrng and frees the IRQ first - after which
neither work can be scheduled any more - and then cancels the works while
the driver data is still valid. The handlers do not re-queue themselves,
so a single cancel drains them.

Found by static analysis and code review; not runtime-reproduced (needs
Arm CryptoCell TRNG hardware and a completion interrupt racing unbind).

Fixes: a583ed310bb6 ("hwrng: cctrng - introduce Arm CryptoCell driver")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/char/hw_random/cctrng.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 03401ee..138cc70 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 #include <linux/circ_buf.h>
 #include <linux/completion.h>
 #include <linux/of.h>
@@ -497,8 +498,14 @@ static int cctrng_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(drvdata->clk),
 				     "Failed to get or enable the clock\n");
 
-	INIT_WORK(&drvdata->compwork, cc_trng_compwork_handler);
-	INIT_WORK(&drvdata->startwork, cc_trng_startwork_handler);
+	rc = devm_work_autocancel(dev, &drvdata->compwork,
+				  cc_trng_compwork_handler);
+	if (rc)
+		return rc;
+	rc = devm_work_autocancel(dev, &drvdata->startwork,
+				  cc_trng_startwork_handler);
+	if (rc)
+		return rc;
 	spin_lock_init(&drvdata->read_lock);
 
 	/* register the driver isr function */
-- 
2.43.0

