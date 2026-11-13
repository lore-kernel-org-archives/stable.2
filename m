Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535441;
	b=hLmQkYo8NkY1s1zp7RvNcz6w/UwBgrtCrPBIWLvGGAPCa/O8uj4ufzLdq/3YKjn79zsH
	 XucnJEgyRoRfyRDh0QVBJTlnXz3L0Uha+Wqt6XbxbCTkKvs1Nn0mUIE+/WbZF4bIQIgip
	 IneIsL56NVeYHQm/lZiWuzb3g77vISDRsp14lUlxvSUFGWaYuorjCew423xVEv6Te15Bx
	 oEGFtcqC+gMkJOkxsCjZQpXzbENSANpFoV1spGmwGa4UVK+5HxZgIe6uv8dcNGYWwRUjm
	 q0jveS+Hyl9RnWjH6L/zsDUC7qTYhjLS/dacsgcos2pUOxdPyzJzKO1OWIpdcraFI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
	b=UWgJC4akW/9TRFTr70XPAg9aqTMuPOeFKVJgC8uNGeVp0L12JshXc6UxS1ST8yroum8t
	 I53B5cvkBLsCHHe4IG9VQng9aCZue+7+PZdtsqR6h6Q/bVA4vvlAxBOlJrFvuw0jET6U4
	 ERU0G3A6d3WAvpYKXP7cyHxKN1vaF/Qr2FLRdSWlrYnOyXTfV/bzUg6EnmKGLZ2IxTUSq
	 he7YNd5RxmzW5U1WcittM6yDM10hwZ1NjHlcSZmmsfcsfGfopa1GCaJA4VBPzAGxwhnjw
	 YSO/THVmHun85NLE/M1pFyZuKoNK+0nClHBqe6jsyx8rMbKN5s89JM1R2waonx+b5uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qq4tUlWx;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0B606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD0B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qq4tUlWx
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so639975a91.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794535440; x=1795140240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
        b=qq4tUlWxgxvu9FuI3nMao3Sd6WxnuMAv3ieybIed6+2qd+w5MRDY4LP8+Lz4JJUrBI
         sHe59g1WaSp8lRytNqzFMV8/dozA1HSVj8+PGlvMtJ9vr9ywpjEE6tQgWl5+FPiGD0WL
         VOaro1bUbEmaZZVcEy/kysDVL5KzjLIeMtoANpZArCYQl9dkhRygkUKmy5ar0ROtorUD
         UvZENy1uk4ELD2f4klmkH9IDP5NdrZdL2fS6eh5BZC13LmSgcw4yIzj6LXutNaCM8AF7
         NtcAxuzqWFavjOnUsdN8R3X24iP7UjS5H0YaHtu+B7xuR6lVLtMrwqPJzm8tdiZ6XSlN
         gAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794535440; x=1795140240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PLEPDne2vJUS2nr+kA6W1uSGTKTQlxTcQxZui7YSGzw=;
        b=o5AkAqrjvkRWmcEqAPqtzj4xtgq2yaBrJq6qvX/oJJNNyneRWRFdgJwEu4XGKTAE6Y
         h1CJALytclwJH2Ub+ex4/v+Re04CaJQKOSWuJpGx5gfK76jmKFeW4UX/1oyYoDVSsRCi
         thuzKCYOEWRk80gAGzv4wtHdnlep5XTON+KDtVAh/5fRWkUeaalU+5TgTHG+bA7V10tn
         nm+t198yAN7AZ3urqBMP8lCk8BIpcYz4IyFoFLp3BJ/trGOvtR3Yz80oYpHGWf6/eMOT
         hPfmR69nSMsHEIhqeD47HLkngO9e1RW5nrMxejlfhZ8e945EB0HBaQ0JFzvlEnnjjR+u
         GEXg==
X-Forwarded-Encrypted: i=1; AL+hErH9+vlGbsVLZpI3E6urXMP3fVCs0S54VZCTj2Xw6PmWne69FdX8/TLK5lf3zSjAup8w8SeTgos=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HJdK6EQJM35g1gqTUqkmI/eypYUQI9ArUHZlgEAmf5tzSxLSg
	Z8PlPPumm87n1SLptYZIgyM7INiu6qSYvIaSaEGPauCaAZGOtJ0YUgTT1DPhipql
X-Gm-Gg: AYBFou0qAQZkHT+MqEAPBIg8zCejQDpr4JwUgRhHwwoJ3NobzANDlEvFyUbZo2rtKLG
	ixHGVwTnuVf88qgEXKtYE4yXEBsOVEIf1W1yp7u/6fVjOIOyQcwA0SFzpVoPwENw6pFqqGoUofF
	Yh+NAnUKkQw340Dss94u9LkXpvfk/sA1bBeJwyysunoSE3L3QWbMdrW/g0IKRf1zAHsYxbJbePk
	PQuD1evVbYEQfaO0TMCJMBKnVZfQUsEw/1Xfhmav77ltJ5yZksTUNC4gaf7AxZAxP0K70a/zF9I
	312lidTtf/QJY6fNtfQ73oY75vD+D2GYhj1n/HjLnhIGSLAwTBFxewsrJPRxOtILsQ9VTR5KFJR
	Ur0ZaL8MbRT568nWd10UWtciqtIngleaz+2JE64+hlF5KdnF73diGYVp8ndekcsvSf7VFon9cY4
	HKA7FA6jZGIRD+ao6tAywV/r3PWcp/P9h7Z4AMFLTemSHhoQM5JioEiXDnxzH9vEMOG5o1z0+aQ
	sLkPd42UubKoEJK0dLeOmltHNDoHR7KThvjhNunq3RsXGIvlY81NUHnNHJGuVjRUCtWlLd2B6Lg
	kLyq6XkBbvpU65cpPoga86wwqhbWU7IE9q5BmMB5vTFT0BWPD0nJK1T2zEkwOzB1S98SkGpN3DX
	Nhe6Jn5cHEKE/A6JVsGQTpMjycNXWuZLR7liFfi3XC+VUbXRXMpm7nZVKt+BwJnBbQ9GQ7T4Xgs
	F+tCqsyn5MVq9GEHRk1CpLh0Jkkhbi3xJ6RzDEy/mjhjQJ1pj1WiMIv7M1dfRfyj32FxYJifTXU
	v1fTVXON7YyykzQQg==
X-Received: by 2002:a17:90b:3890:b0:3a4:b061:2765 with SMTP id 98e67ed59e1d1-3b1b09e69f1mr825607a91.15.1794535440527;
        Thu, 12 Nov 2026 18:04:00 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (145.247.125.34.bc.googleusercontent.com. [34.125.247.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d04336sm7167618a91.7.2026.11.12.18.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 18:04:00 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] spi: unoptimize message when queuing it fails
Date: Fri, 13 Nov 2026 02:03:51 +0000
Message-ID: <20261113020352.1741295-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261113020352.1741295-1-jctchan@gmail.com>
References: <20261113020352.1741295-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

spi_async() and spi_sync() optimize a message before they queue it.
When queuing then fails, the message is never finalized, but finalizing
is the only place where the core undoes its own optimization
(spi_finalize_current_message() calls spi_maybe_unoptimize_message()).
So the error paths leak the split transfers and the controller's
optimize state, and leave msg->optimized set. A caller that resends the
message then optimizes an already optimized message.

This happens when spi_async() returns -EBUSY because another device
holds spi_bus_lock() on the controller (for example mmc_spi), when the
controller's message queue is stopped (-ESHUTDOWN), when the controller
has no ->transfer() callback (-ENOTSUPP), and when __spi_sync() gets an
error from a controller's legacy ->transfer() callback.

Call spi_maybe_unoptimize_message() on these two error paths. It only
acts on messages the core optimized itself, so messages optimized by
the peripheral driver and controllers that defer optimization (such as
spi-mux) are not affected. A queued message is never unoptimized here.

Tested with KUnit (spi_core_optimize: spi_core_queue_error_test,
added later in this series) on ARCH=um; builds with W=1 on x86_64.
Not tested on hardware.

Developed with help from the Claude and Gemini AI assistants.

Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
v3: No changes.
v2: Added Reviewed-by from David Lechner.

 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a1276d194465..a6a98f052809 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4915,6 +4915,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
+	/* The message was not queued, so it will not be finalized. */
+	if (ret)
+		spi_maybe_unoptimize_message(message);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
@@ -5018,6 +5022,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status == 0) {
 		wait_for_completion(&done);
 		status = message->status;
+	} else {
+		/* The message was not queued, so it will not be finalized. */
+		spi_maybe_unoptimize_message(message);
 	}
 	message->complete = NULL;
 	message->context = NULL;
-- 
2.56.0.506.g506a7eabc5-goog

