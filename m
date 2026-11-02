Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637231;
	b=ecxQAGysPK/GOUSbTfsvM+7XUB/4YTNlMFrd3BKFYgwYrpVkaA3WJ/sfvVGjwR8l0X/j
	 punTMWQ3tLXTpaJflREP0SoAlOz/jTLFwHAROWwycXKTfCDhg/OohNflj5d4HUnlb5SV3
	 6Btr86l7yhPT2e8nzwP8gJ4MkxKqx22sLLzEpmRgUZyqQ9dT+T2NfoOrb5qQ8AjdgcnZT
	 rkbbU7rz0XFmNCTnaKFkhQHACHe7d+dyaRgqqwLZDlURWbtZy1TKtEk7ElU2RUhF9tWZH
	 Ec13v8YQWr9wZ4inN7fJJwYRTUW6+6TyKlYyVWy6p+usS+bbr5xi/cd8m0id1SzIsAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
	b=EQZp+PuxGWSg6B6wAmkvMOiPETbFttweVEP9RHW2xdL3LFbmC7O7g0RoYCT4V31QaCat
	 qOz3/2BOKuBlIlu7iX7T2EV15DiOpFhWujcqsCRpRboXnk2AgHGjDS8WO8WSP1rU0+rMD
	 ztnnj+BWkJSqaJohgnDQ09WYKnUe6CqPBDUE7MKQ0vqSVbngWc3gRLzEVVHm1GP6+Yq4b
	 grUiHDiXUD0c8jDxgtbo8WlW2lA091MkTvdBzMIAKR6VcRLtzgS7BORE94d0zJHbvrYZc
	 2jWBVTf2HRESsNZbxRXJH5Rii9CD3PHf3zIIGyuMl0IYhyX4el8HeSx9FeXHZ0hb8xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcBRjtd0;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3060A0C88
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9D3060A0C88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcBRjtd0
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so2146019b3a.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637230; x=1794242030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
        b=CcBRjtd0AvsoPzgWq9Q80R3XYFb2aSLnURrqxrhdXzkqtX4K3EAQl1srbBuEdcWd6w
         FNWhq8L3ZOZpulDYKH6DJVhM6T51gTOZ4fQ3Calj+vwryyHkm5fpbLU886ovOE677rXW
         cWpcN9srRoUzRU88z95ugwRfLHZ1ZNzzmR4FKU3UcIkwq2F6XLBfkYJUjLEZQwQzL9GP
         +WoP+zPO+4VVn4Z0HN3uUH9YcWbdg7nrvAA8VQ0ljdc4H9DIHj+8j6yWTxvAz824UBvY
         dmLBn786yImTL6enGtI05RqIK2ITcJKK7ZaD0AFMifpVFYRIwvMoqQGKSRZvt+baFjSI
         5HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637230; x=1794242030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUTZhles4tY/W/6lQ/RhJc3o/eNDuVloJXqcBxEDBm0=;
        b=o6DSBDQ7yvQquED6djNkWPHHk7MuKf6h7nMDL9im1oM8sLmTVG/qJNi5DnSCgLszns
         45lQwb55H+JOrT0TuBV1wxtQlHHAd6/AijGmo1TWnjgeIaRzDhvEgrGMSn71vxvZnnD3
         S6j5Tq6hAK7CwN2hK1sfSTDJt5IGgT9YrVTI86zRdJLgtbdGC/CIzizEULESHt2nD2Mi
         IT1e9NK5Jbs6F1cJ2gdD1qqDG7SCx16hm7T2u9SPJPw2kCRJO9rYYm0ex+MHzg3XtOMa
         q7oOJ3oz68J/uHDKK6tdtPcHyZsz2nvrZ5VXYcYCHSF2zeFtHkJSPIMjMXLyD8BhketY
         aM+g==
X-Forwarded-Encrypted: i=1; AKwUvBxX0PC8r76RsKG4SxjA9KSKapalvi8htvPi5NeJF76aVbBFEh65JfrbtpwkXT5iAeknohmyMtE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+byvAOd7ZUKKVBZqXBSrAG8iV+7W1ICAn+rCCf3u3bYI3qlM6v
	X0Mkx2/EyfitZL8/X/hjV7rtGfyz+xUvfCGjxVzh06HFzKaXQdo66/oJ
X-Gm-Gg: AYBFou1Xr0ZgeU2FedZ9DWwFLa5FFlpyf2ER6duA5xflg9POsLWJxJx0Rzgtvo7icuR
	NOl+6eLwsL+rQNeUMuDmNbykHA4Pl9/h/ZR7jZAhhupG1OlQ++L1ErDQagK8SKiJZTMK49hMrw7
	mr9mSeaUrUAuVayYSgZ0mxj22hZdTbjFlh2TrmYcgvKVep89+iL5H64XeLIk8IWetJabuZcHMjD
	6ZUr6t4iTRT9K5m5iL7hfzuZrlQli/mcHZ43uLJ6/mo3GEL94ySgRdBAHWQy3Ci1s9dJX5G3/NO
	xCgY/LLCIk9B81YjycUFdTP62uTsEeMGgG7bMl9NoDFXYN6eBUVRfSgRjAiILnb9rD1CWQbcU77
	aFQbLCP7cnfgqnkdX7tOczdibvM6rSDFtt5Ma8FaWsaPlU52iNtObF8o8OYtD9rvBckzwtHkLZI
	gBzdimVoRKRTAsGjJUG9W1Cq/qShcOVPg2scfc1el43Zj11aYMS9jtkAwly/GNp25+dfz/XEW0S
	GfA2sFcewCLIwjpQSg4gJWNa6nFvsk+0Vb9ch9EXXxOz2Gk6e5/XkFZEiQABIEaMZJNc4GyacBd
	udZJSLehGcxwdyUBbmeBCQ1UhC7/pqsea18c7oQy2M1cxerQFPUGUXmIIZv4LWxbWc/P9utuisM
	P9wXEp5Y2PUMDajMhIkixuOO0YvJ+SfRV8uX6aA07Y01UY4hPpzaSOXaSameE+KySy+KQIuQoTQ
	iUIoa3obyin6KVxSb1UwQYKEFJMJii9hBV
X-Received: by 2002:a05:6a00:e11:b0:882:359f:ef17 with SMTP id d2e1a72fcca58-8a9bb7a0b64mr9114119b3a.12.1793637230136;
        Mon, 02 Nov 2026 08:33:50 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:49 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/14] spi: unoptimize message when queuing it fails
Date: Mon,  2 Nov 2026 16:30:10 +0000
Message-ID: <20261102163023.2574632-2-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

Assisted-by: Claude, Gemini
Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Fixes: c86a918b1bdb ("spi: don't unoptimize message in spi_async()")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 40cda0037ea5..0d36460e2c87 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4906,6 +4906,10 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
+	/* The message was not queued, so it will not be finalized. */
+	if (ret)
+		spi_maybe_unoptimize_message(message);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);
@@ -5009,6 +5013,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
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
2.56.0.317.g454f8302e1-goog

