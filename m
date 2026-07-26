Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0821F419A
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785076583; cv=none; b=i1r2DGCG1gFgsuwWWwXWspr0AafrDjDBZgX96RT8UPs2cOGZK+sAhXTYIHnohdwQoro3wGjLwMaRRghiMFGxQe5FNPL8DfUaB1tEc1aO2WHcCSGCTBXahrhJ319ptekt6uM9Mp0wx2s7xmZWe7yZVod+B5miNaJTx3Sk1W34nGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785076583; c=relaxed/simple;
	bh=9DwOpU8JXSr2mJOXnVgzYO7zGv1+1NQMZj1fNf6G0gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeoNvi/x1+Z7Cq0Xg+mN6AvJJUHebrtXYZoyOUDSqsAN7b613+BxCs5o4+PmLAl7Jn+rl0QAi56hBcc3km1X7vPWWQTamrH1fTnOLzkCLQwY5PQ2G+Ow6iul/nWHurfh242MJaOCO9u3b0OhAKkG7jyuXZaJOZzT2jv5GijXWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpGtbDap; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpGtbDap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF861F000E9;
	Sun, 26 Jul 2026 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785076582;
	bh=OLdKgpx+ZgXyOJp5iE11NVGp7d4otw0sMl2AOb9249A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JpGtbDapv3cW3wCagLm43QNPfKWiyFklE/EeQ3harkYhY/WEi+R9r6ihrDfIj4vPC
	 oWPiNxV8OSLKOf2yfindf9ZV729COT/YFwKv89SD7KFx3fRXPlWsnE90TydvO6kZC7
	 jTAe/3EnOUoPGA4VSM27A5OwGqlpieGE26ORt5hGXR42j1Df6sWhUrKIMxbvYsV4G+
	 u0FqPp/ZN1UJSz91NuiCPsiqfCDx6Sjn9jUkjlhf8hs1KERi/9L3ixN79zO57L5XgP
	 aWIJpEygDMJ6lrjrwfVfSMbdS20REkFFUzIWcAB4SR46QpN61NGWERcLx1W29VxUyo
	 PpqWCwRDr2xdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
Date: Sun, 26 Jul 2026 10:36:18 -0400
Message-ID: <20260726143618.1025423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072015-okay-retake-2a7b@gregkh>
References: <2026072015-okay-retake-2a7b@gregkh>
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

