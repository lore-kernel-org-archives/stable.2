Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184488;
	b=UV98P0CQ7QLA6nRfC/G2VD+SmbCevEnvVNNT9+gohFOXgsQlxi2eq611m1aujbADnmTU
	 9aOVVuJFGpTuLDr4hwIM4U46GVg8D4IInXRjsuYmz9H7cbrExrBQZBsKzWezQgHrs0uNf
	 NYJAOyTIcc92DA67JRIPPnHxQnmj9xW3j5vBAuJW8v0gm6wJ2HU7AIla7UdjMswabX9qm
	 lz5jkr2rt+YeWyOa8Ym+lDJvkU8YALN7nEj9EIQobRujYdNi1ZnmFkcvJ3n+8T93UJ3bq
	 02dH9YzabfxRTtTzMgHRZwE0kajJm86PLC02GGFjB4nAjC0hJiBCyqjssCjxp8a8r2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Developer-Key:X-Developer-Signature:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type;
	bh=ITiUSrkcHo3/vrwpGUwRiKCqGxMl4l0M0GrgljGxK/4=;
	b=HI8r6+vIFxnQzhYyLGxvhDadWW11VaSE0WErflQITtpViZx7G66D5lxHlgxi6LyW3zAJ
	 ZWbly27+Lz0Fd7RLbw88+7JicOm3aDGIO+E/70yUqCxMm7B0z6EFPxviQ9HVGE03ja0zQ
	 M1Ij0S61vXX2+EpyRsR/GLn4FfkD0vH4duPITxFLFPefZvCfMzym/fHr2iHlG7FpFsZ/z
	 vYl7/LFupbn3o4ryhYDkVnJCDybeRF948A/h+s5pbRe0MGVwLNv35+xv89FuveL5oTK3b
	 E/Mi27Z9KROKAapTjfbVE/nv1nRjSfIfz8+fDs9KJ+aLqMtgkCc1Mf51MOO/CrH05TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBS3fzbo;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E785606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E785606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBS3fzbo
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4a799d93bc3so471066f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795184486; x=1795789286; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITiUSrkcHo3/vrwpGUwRiKCqGxMl4l0M0GrgljGxK/4=;
        b=NBS3fzboEkL64Ak9+4oXjgDYEondLbWnqd3arCyHVetN7wmvWalFjvylGj93+6EX0F
         Ry7mMHTT7zfpKThI46+b3+U4f4DO5hQld2ErJ1OsZ4yMnjuyyLRwA15Y3ulwy+0Ee0/f
         CLfdwYS8At9/QE1BSfYZBCzTnX8UCpcDBm5ab4FnbCa+SCQNSKoajqRGE8VinrEsb3Wk
         f/mfcq+dINTXkk+1oVpm/l5XOXEA+ULK8MZXOg0orGv5/odMaieYQpPjM26K+VrIteEl
         on8wlfQEJUaTlvjecRM7X5PPCCAOKKJ59q41lG5NPLIR3zbF6iNDvafXMQLCKDrr2b+9
         Kc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184486; x=1795789286;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITiUSrkcHo3/vrwpGUwRiKCqGxMl4l0M0GrgljGxK/4=;
        b=vzDqnJ93SgVUDS96Qa87xyHbaKG8F0BINjj+Yc2SFGK4/2rnPDvwF48P6R6KKl/so7
         1+uzSTNeyy3skvk23/hdJkInsbcOtQjUcNXV4T12XovF3WXbZVoNaL6g2JxNT3bNshSB
         9kzN2Jv5DdgYdS5i4ICTVTnQuDIgALMe2UQQvwL6AODh9qxP5+mbAMQyoog3y8U9WbX0
         WS6bOzZ1LLOeEOcAjuovJeNZou0GOTpH8cfoT2xn+9i5sWge6sWmQIRsOcFDK3pc6uc9
         DdIitRAzdIvKVri7mzPf1XIY2pdSWL+chUc0DQTOSd8o8pvnbYxRH38OYSZgpi6Noajf
         nc6g==
X-Forwarded-Encrypted: i=1; AL+hErGTp0m66XI1GvCu929zIpyUVz078XaBT6UlsyGRkboDojD7GGVI3tqFMUhWOQtFGYs2ZgiY13A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OgN/+muecEHsKO3IVZTLtmWTBXyYzNStA9Cr5rncldeOOIMDw
	uJveaf7PqkRjPXSx0mbiqx5LSmz5FYSxdlcxGO+ePWZ0iCotGq6NoJdRrDhQaqt9lA3mRVOvIQ=
	=
X-Received: from wmol4.prod.google.com ([2002:a05:600c:47c4:b0:4a2:655:296e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6708:b0:4ba:7e6:53d6
 with SMTP id 5b1f17b1804b1-4bb88940848mr62322595e9.33.1795184486289; Fri, 20
 Nov 2026 06:21:26 -0800 (PST)
Date: Fri, 20 Nov 2026 15:21:24 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=ardb@kernel.org;
 h=from:subject; bh=X3o9Rmm7jx01kMITf0sPisYNfYMNsUTwItzuQQ7OsyU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZshPPlBlfXFQ9kW09YuOKl2dvuLpIz2Bfx5jAVLbl86F
 Bxy70NGRykLgxgXg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIJBsjw85VT855FniemFxQ
 f6STSe3HinPZPe92Z9xc5fR35kqVCVcZfrMmftN6W3k+9LHuJ4UDv1PusBnHS16u4fTd1BAb7/P zEBMA
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120142123.1125683-2-ardb+git@google.com>
Subject: [PATCH] efi: Don't destroy runtime workqueue on efisubsys_init() failure
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Commit 98086df8b70c ("efi: add missed destroy_workqueue when
efisubsys_init fails") added a destroy_workqueue(efi_rts_wq) call to the
error cleanup path of efisubsys_init() without clearing
EFI_RUNTIME_SERVICES in efi.flags, leaving __efi_queue_work() passing a
freed workqueue pointer to queue_work() on any subsequent runtime
service call (for instance via the rtc-efi device registered right
before efi_kobj is created).

Furthermore, since commit 13c6da02e767 ("efi: Allocate runtime workqueue
before ACPI init"), efi_rts_wq is no longer allocated by
efisubsys_init() at all, as efipostcore_init() allocates it earlier for
consumers such as ACPI PRM that do not depend on /sys/firmware/efi.

Drop the bogus destroy_workqueue() cleanup from efisubsys_init().

Fixes: 98086df8b70c ("efi: add missed destroy_workqueue when efisubsys_init fails")
Fixes: 13c6da02e767 ("efi: Allocate runtime workqueue before ACPI init")
Cc: stable@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 9bc22de0d67e..40b423f85e06 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -466,8 +466,7 @@ static int __init efisubsys_init(void)
 	efi_kobj = kobject_create_and_add("efi", firmware_kobj);
 	if (!efi_kobj) {
 		pr_err("efi: Firmware registration failed.\n");
-		error = -ENOMEM;
-		goto err_destroy_wq;
+		return -ENOMEM;
 	}
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && efi.runtime_supported_mask) {
@@ -525,9 +524,6 @@ static int __init efisubsys_init(void)
 err_put:
 	kobject_put(efi_kobj);
 	efi_kobj = NULL;
-err_destroy_wq:
-	if (efi_rts_wq)
-		destroy_workqueue(efi_rts_wq);
 
 	return error;
 }
-- 
2.56.1.750.gf70dc682cf-goog

