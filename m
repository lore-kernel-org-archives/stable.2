Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637234;
	b=vrIrKCghtsb4NhmCc0bToHeW2dWXl23ByXxoM6H3UcO9AaFrG78Hl7SuRby9XSEG7CXd
	 +NErfipgXVTMUThnognBTHa5/HVQwhLfAMwTy2MEbGVcjDIIcRxlL7bbJkoTd+T8NtNDd
	 lY87w8Us8AnCe9fuYnCm+RuTUdNygoVyqomo/NpmHombGljkx+0J4UP7d+I9a5U6efaXc
	 qqaOW74LvvJlo4xalZqlVZG9S/FG6k6HjfGtXYUnBu2oDuzkRPCVh4VlwtcO7hjp04WRY
	 Fn18Q3pp0CmV4qWVmu9/9Cnv0m4v7CnfSl5UfjWVYg3KQavOmyL9ob8Gy6fnjsNcthw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
	b=viVKlHX257YI3f0bHVtQKLK6Gz85s1IGj84kahY9z985DSvpC1XmTWQpF9mSjhkHtBEt
	 sfiqLhptx/zu7SMx71v8ciz+UDlMkqu9WtJEz7DZTqr68yS4oHm9L+Rbg2SyPf21SlgQs
	 VPZq4iSLdkf7v2x+pBE1Ez/GGvWlPqtZlERopPfOFOgdtut7/0yVJdrW/baCE2qmoFZbC
	 nNKmItMn7pfQOp4qurnYGStKJZ8RPQoN+6MoaUkSOtujeqRGdWuOkws890yE7+2duXhb4
	 rCyHXCTM/EQFeXFsIiiRzCoQyKTvxEmM22+HgF3EutyMfLVYFF+kuT3sb5ngOAdQCpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrvaC8PV;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353260A0CA5
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7353260A0CA5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JrvaC8PV
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so2160634b3a.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637234; x=1794242034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
        b=JrvaC8PV3yKZNIM7YzvffeBEM1S7IiL6Ll1G+tV8UOL9CjYBI7FQYGbPXUV7+bRdZ4
         TTXSFKBmuXgHw0r9HQJ7eCjdUqPXgiWXBoL4VTBMiykDJfLYdGCZlBGbe6LYUxg8BI/j
         zryPaqQMOKW/beJVrVtLflaYtEqOuO8RR8yeUpOOb6m17kz04bGo6YBp+spKAsjPbzqi
         0vmm2tz8MNWHB408s72/R/3YXQ7qFXHZfIiln7TBW0kTGS3WXMe+zIbn/1Xwc6wi6GRZ
         gqzApzEFuF1ljcjodFItDZNUYXydMJePxUJFWS10F7SYnOf4mNNqkNdRpXLFhWUr2+zc
         kLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637234; x=1794242034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7A5LOz0c2QL4S1/kVnCWpIWEscMv5GfBU745tHtcqZY=;
        b=U/nffU3KL7oVijXfCdoVCvCZCnTtxtuKGgn2o3S0ubqJ7onMcnCXP27ev3W1KqnkyQ
         sL1YIaqfJvTm/OhYcLL7xu9B7+ZAe8LOg+w3NHhEnFzwljN+AhwldAGhsPAPxLHtFUAN
         alHXKbPQ9soPR93+i9wHmBb2djiux6boWxrPVZOCs9KS+57GUQvwJAnx8xlUm1qBBPnB
         +Thsz4kxq44OFj42+kuy78cJ65thocVnBUeVQTDU+ZA8cu+352yJmbUzVrISkf5UcZZY
         nH7yXvT5OSWUEBLQxwzrEcLqdMgS4LrVBLmexMMxnMWCHcq9HLboZzPCC6gMeh6iusJn
         izuA==
X-Forwarded-Encrypted: i=1; AKwUvBzuVFUav2TtWkAHYk9Hzo3ahZ5MwA/cc9a2KvJrgRDKq1LGaKDKGEIxg1nvwT6SMkJXLNZWMOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhlwpJEcY/4Dds0Gb0vPfGbZkTCnBOL2nBAA3fwg5HRISggBCv
	f0z8jo4QM9A4BE4S7m+uXC6iO1EwO6Qr9+1QKzzh+1J4OZPFnecHU++C
X-Gm-Gg: AYBFou3aTrJIylPC52IZCceYGyEEoA2Ukk4v4VA6EvYVFltNE91v7IipTuPfsG1qb9q
	ZqStndkb+2yEi+xkCNNH9LkDJ23PIkhyrtnPP9ciirBIFutrGRPO71nltYO4TEwX9hy3KPc3zlU
	s8OU3pHXruIuAeAoUk3eHNk4tmoawOUQchIEY0BsHgcMkfQCreNg9t1bw5Rkv+FeciP3RbydPvD
	TP8pc+jYAXZ+erfQeesBZn5tqw4UWfnSGNv+cLKoITtFgGFOdglDPRFsvp4x+jAlE+RSIySO0ni
	rGYJwpvMTYLjJNFhi8pAb9uee0d5cnMTDidaTrgdlRBAGrU6/+/j9eEyPgJT05JsxkpBdQobD9x
	g+YIj6z3RpPw6/fxb/z0ei4aie+xml3Jh9zIee4ryvr4nKWUWjcq5bOX+2MO1WbdunqLQP6GfIT
	MtO+XzY95M2Nyp2JtcCPiZZiiTJFJmaPfe7pRljvumZ+aihkwAIJ+lThd17Mxg7ZStoe5W2uCJ3
	ZrgJbaPOYc3eljB9jjycmxOsI6iupDzQb/Lr6HQg5/pgE4lyh12nkx73R/veapfi9PKQacUvYgy
	/woF6EyJ/TEgWcDkMs3wTlx6U6fhz/TRLSrh+Ba7GFgZasOqRiVTTjm0OTVcQ5TL/hJc4IZsW7O
	vIzIYryqF/cgLulZvBqwPj6Xzxwm8m9SLC+kqqG7A1U9EceKm95twhftXCthC07R7bMdVtoo1L7
	E/8oKlrn0vdnq55flAGKHO6IIg2Y5L7Q==
X-Received: by 2002:a05:6a21:a96:b0:3e1:370e:f233 with SMTP id adf61e73a8af0-3e928abd43dmr9176791637.69.1793637233860;
        Mon, 02 Nov 2026 08:33:53 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:53 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/14] spi: spi-mux: finalize message when forwarding fails
Date: Mon,  2 Nov 2026 16:30:13 +0000
Message-ID: <20261102163023.2574632-5-jctchan@gmail.com>
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

spi_mux_transfer_one_message() forwards a child's message to the parent
controller. When spi_mux_select() or spi_async() on the parent fails,
it returns the error without finalizing the message. The SPI core then
logs "failed to transfer one message from queue" and does not finalize
it either, so the child's completion callback never runs and spi_sync()
on the child waits forever. After a spi_async() failure the mux also
stays locked, so the next message on any child of the mux blocks the
spi-mux message pump in mux_control_select(), and the message keeps the
spi-mux device and callback in place of the child's.

This is easy to hit: spi_async() on the parent returns -EBUSY whenever
another device on the parent bus holds spi_bus_lock(), which mmc_spi
does for every request. It also returns an error when the parent
rejects the message, for example a transfer with 16-bit words and an
odd length, which spi-mux does not validate because it defers message
optimization to the parent.

On select failure, set the message status and finalize it; there is
nothing to restore yet and, with patch 2 of this series ("spi: spi-mux:
release mux when parent setup fails"), spi_mux_select() has already
released the mux. On spi_async() failure, set the status and call
spi_mux_complete_cb(), which restores the child's pointers, finalizes
the message and releases the mux, in the same order as a successful
transfer. In both cases return 0: the message is already finalized
with m->status set, so the error reaches the caller through the
message, and the core does not wait for it. Returning the error would
only make the core log "failed to transfer one message from queue"
once per -EBUSY while another device holds the bus lock.

Behavior change: a device behind spi-mux now gets -EBUSY while another
device holds spi_bus_lock() on the parent, instead of hanging. A device
wired directly to the parent would instead wait in spi_sync(), because
spi_sync() takes the bus_lock_mutex that spi_bus_lock() holds
(drivers/spi/spi.c spi_sync() and spi_bus_lock()); spi-mux forwards
with spi_async(), which returns -EBUSY while the bus is locked. Making
spi-mux wait for the bus lock needs a core helper and is left for a
follow-up.

This depends on patch 1 of this series ("spi: unoptimize message when
queuing it fails"): spi_async() on the parent optimizes the message
for the parent, and without patch 1 a failed spi_async() leaves it in
that state when it is handed back to the child.

Tested with KUnit (spi_mux: spi_mux_error_test, added later in this
series) on ARCH=um; before this patch they time out with the message
never finalized. Builds with W=1 on x86_64. Not tested on hardware.

Assisted-by: Claude, Gemini
Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index a7ea6585b374..0e770137b5bb 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -117,8 +117,12 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	int ret;
 
 	ret = spi_mux_select(spi);
-	if (ret)
-		return ret;
+	if (ret) {
+		/* spi_mux_select() released the mux on failure */
+		m->status = ret;
+		spi_finalize_current_message(ctlr);
+		return 0;
+	}
 
 	/*
 	 * Replace the complete callback, context and spi_device with our own
@@ -133,7 +137,23 @@ static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
 	m->spi = priv->spi;
 
 	/* do the transfer */
-	return spi_async(priv->spi, m);
+	ret = spi_async(priv->spi, m);
+	if (ret) {
+		/*
+		 * The parent did not take the message, so it will not call
+		 * spi_mux_complete_cb(). Call it here to restore the child's
+		 * pointers, finalize the message and release the mux.
+		 */
+		m->status = ret;
+		spi_mux_complete_cb(priv);
+	}
+
+	/*
+	 * On error the message is already finalized with m->status set, so
+	 * the error reaches the caller; returning it would only make the core
+	 * log it once more.
+	 */
+	return 0;
 }
 
 static int spi_mux_probe(struct spi_device *spi)
-- 
2.56.0.317.g454f8302e1-goog

