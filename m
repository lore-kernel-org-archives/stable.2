Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2723BBFAE
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785077066; cv=none; b=cn7ylZehzPNkey3/fre4iQmjje6cpgqB2PL/pb9n1weqO+/O1I+SX6rcRCZyy+ur4BO9kVeiaHrWQ5MmmsTC2zwBLhaEoLt8NN4eC+hdTPH4XD7hQtvqQmcmzRQLLKZAigt0AE1iNyjUBaX8RME+VOPtqjgZl2pJ62tgfK/0sQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785077066; c=relaxed/simple;
	bh=9DwOpU8JXSr2mJOXnVgzYO7zGv1+1NQMZj1fNf6G0gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQgrQPtuldJNLfsOgRH1waEkXuaC7KsEHoXhiZtlPybSZSW97ZzlGNsEQaHkGLT2p9opSj6H9LG0GtFS9qHH/pQyHKlTcTkIk6npB76Xu5/CJJrNAoSUhi+pTjVWgbtEe3b9iT6ZCdInod3/Wu9vfVU+us9yJR1R7Z9sWSZ9ZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6wtS7tB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6wtS7tB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449691F000E9;
	Sun, 26 Jul 2026 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785077063;
	bh=OLdKgpx+ZgXyOJp5iE11NVGp7d4otw0sMl2AOb9249A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L6wtS7tBvd1e4FC0IhJaC5RYLIsbq3+elnxyLKwWgquSAxdxZLbG8SHt0OgCFHK+Y
	 zvPKor4HUx13UumAjrClkO0yCNnr8sA9gvccngxQJUoBdond+bsQKZx0SEyp1Bbosa
	 I5ZoGkI1W2ulor0L4ea7iDI2HQs8C0uwK2kAXRSG7B8YRdA47n3c87ucUr0zcmW+3F
	 jRzmSIa16vVPHV0Ssx2HBnjcTsVCxZmrDe1fxI8IwZ8B3l8e3XXZKb7oWQWsI6Ikqg
	 8S2OlovMfSQxmaqP0cHSz6Xn+WB6UfXoXM6KkXlIBK1S7o2BXlp8fYE0fad/gmsQNp
	 as7YJAD8m0DLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
Date: Sun, 26 Jul 2026 10:44:21 -0400
Message-ID: <20260726144421.1163854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072015-obscurity-happening-14f9@gregkh>
References: <2026072015-obscurity-happening-14f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jarkko Sakkinen <jarkko@kernel.org>

[ Upstream commit c0c9cfb3b75def8bf200a2d4db09015806acfeaf ]

wait_event_interruptible_timeout() evaluates its condition after setting
the current task state to TASK_INTERRUPTIBLE.

With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
path is used:

    tpm_tis_status()
      tpm_tis_spi_read_bytes()
        tpm_tis_spi_transfer_full()
          spi_bus_lock()
            mutex_lock()

Address this with the following measures:

1. Call wait_tpm_stat_cond() only while tasking is running.
2. Use wait_woken() to wait for changes.

Cc: stable@vger.kernel.org # v4.19+
Cc: Linus Walleij <linusw@kernel.org>
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net/
Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 38 +++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 16e486337ecbcd..88f73e1b749d52 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -49,10 +49,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
+	int ret;
 
 	/* check current status */
 	status = chip->ops->status(chip);
@@ -62,23 +63,32 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + timeout;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+		ret = -ETIME;
+		add_wait_queue(queue, &wait);
 again:
+		if (wait_for_tpm_stat_cond(chip, mask, check_cancel,
+					   &canceled)) {
+			ret = canceled ? -ECANCELED : 0;
+			goto out;
+		}
+
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			return 0;
-		}
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
+			goto out;
+
+		if (signal_pending(current)) {
+			if (freezing(current)) {
+				clear_thread_flag(TIF_SIGPENDING);
+				goto again;
+			}
+			goto out;
 		}
+
+		wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
+		goto again;
+out:
+		remove_wait_queue(queue, &wait);
+		return ret;
 	} else {
 		do {
 			usleep_range(priv->timeout_min,
-- 
2.53.0

