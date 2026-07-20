Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22C3D952E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559685; cv=none; b=hbWJ9CzWkTAdhe+u9XExBcSlytq5r4GNjpkuLkQEp/L+YO1hKq/qCCFkEtSju4dAGzhsi2R//HsaATLtfY+vztVVHK08Z4bKDxPPbCtW46YbrV0emGgx8kF4JNuuAvqedhoqa9Y9k3jp6YfbIIAIZfmGyVXejjv0+yPtKhSdqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559685; c=relaxed/simple;
	bh=ERHB8e7Fo9JsEOVXMLuwndcjQfPEldpE47ZqRzeP2Sc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sXlz7iCLUh6zMzRccu9l2l0MFSfoS/+kd7ygMM+u4Eq8uvtL2QFffF9S441dfqrduCkl9FTOJ2g3CY32gAkaaKV5esZaPXW+Zsv09RQlV00VX/PxajEvcLLV/vB4rh2q+WNZYbLf77+vlbPSPALMBvgHzaPTB9P4nsfGYCNDFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QctK4WnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QctK4WnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42571F000E9;
	Mon, 20 Jul 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559684;
	bh=lN7NdBfuykFY44aSntJcdvs+f8aBuoElI2dLYZ4MNn8=;
	h=Subject:To:Cc:From:Date;
	b=QctK4WnTQIQGF9iATbwptfvXlZaCjC5xthaXSQI9w/VpkWhPqYvOTXIOGgBclJB+O
	 mXLiqas6b6NsPshQNVPCxsyvMsCzX1L99GHVx0mldAfxMHq3UAIyF1CE+f2Ros3OU6
	 BlYN17td/5cFUM24Hcc6bCZ+n+NmP3OOEz1K3R5s=
Subject: FAILED: patch "[PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()" failed to apply to 5.15-stable tree
To: jarkko@kernel.org,linusw@kernel.org,wahrenst@gmx.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:01:15 +0200
Message-ID: <2026072015-okay-retake-2a7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c0c9cfb3b75def8bf200a2d4db09015806acfeaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-okay-retake-2a7b@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0c9cfb3b75def8bf200a2d4db09015806acfeaf Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Sat, 9 May 2026 21:51:07 +0300
Subject: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()

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

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 21d79ad3b164..153a57c79240 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -66,8 +66,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
 	u8 sts_mask;
@@ -87,23 +87,30 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	/* process status changes with irq support */
 	if (sts_mask) {
 		ret = -ETIME;
+		add_wait_queue(queue, &wait);
 again:
+		if (wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
+					   &canceled)) {
+			ret = canceled ? -ECANCELED : 0;
+			goto out;
+		}
+
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			ret = 0;
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
 	}
 
 	if (ret)

