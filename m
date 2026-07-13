Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958C2DA75C
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946949; cv=none; b=Jzze4F1YDvymyLm4JpwHeQ3BnIZbdm3dfEcLIa7DpfXd1CjPkaRVjYYlzKpEk8B6GsleZouUZ7CwwyDuHHv8LBvEu5DrTB69RiflIkIcB8L7lQVgZqH1yeR6KjluyLvtMwKaXVA5XMB6wjaPhc1OgPaJrXUhiAq5KdLLet6UmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946949; c=relaxed/simple;
	bh=ErYPBc4zu8KSj4IxMOz7lH7eKY7738mUt61m0EPmdYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q/Y7A+IUKhPQ2q4kO2CuviUCqPhAV4JPwiv4WQLTVEv5T6Qy1RtDwAhr3A0F4kuou6649vqWwNrCcRawS3LYINQHWoaTywGtpbXwbFGrwkGYk6w+k1UopEf2ltzOYcRWyuMcj78nMlFCCUwh/3USbxg0o9q2rX0IyqoZbcrN9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZopoextR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZopoextR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5A41F000E9;
	Mon, 13 Jul 2026 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783946948;
	bh=eXUiKgKqEouIScu7rONqe2/zOPrnq21++RqFPKKBc/E=;
	h=Subject:To:Cc:From:Date;
	b=ZopoextRXkOK7R3rFHKJ+KyR3DRx2NLhFFNiMTiHpEIHVkMzvUvTuDREqGSk2zLPx
	 tKuYp11Z0Xkav0jwpKON4Ydxp0AKbyJGDJWwz0xIsHu2rBGL1qY/Udu6awXV2jcjxL
	 I2/rqbdge5rPMxul7/rFxv2WQ5Dfol8HsipWBHZo=
Subject: FAILED: patch "[PATCH] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ" failed to apply to 6.1-stable tree
To: runyu.xiao@seu.edu.cn,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:48:52 +0200
Message-ID: <2026071352-yanking-dealer-b803@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6e1b9bff1202da55c464e36bd34a2b6863d7fe30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071352-yanking-dealer-b803@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e1b9bff1202da55c464e36bd34a2b6863d7fe30 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Thu, 4 Jun 2026 09:42:46 +0800
Subject: [PATCH] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ

devm_adis_probe_trigger() registers iio_trigger_generic_data_rdy_poll()
through devm_request_irq() on the non-FIFO path, but it does not add
IRQF_NO_THREAD to the IRQ flags.

When the kernel is booted with forced IRQ threading, the parent IRQ can
otherwise be threaded by the IRQ core and the subsequent IIO trigger
child IRQ is then dispatched from irq/... thread context instead of
hardirq context. Because iio_trigger_generic_data_rdy_poll()
immediately drives iio_trigger_poll(), this violates the hardirq-only
IIO trigger helper contract and can push downstream trigger consumers
through the wrong execution context.

Add IRQF_NO_THREAD on top of the existing adis->irq_flag value for the
non-FIFO request_irq() path, while preserving the current trigger
polarity and IRQF_NO_AUTOEN behavior.

Fixes: fec86c6b8369 ("iio: imu: adis: Add Managed device functions")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index d76e13cbac68..3e6a7af6ab01 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -94,7 +94,7 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 	else
 		ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
 				       &iio_trigger_generic_data_rdy_poll,
-				       adis->irq_flag,
+				       adis->irq_flag | IRQF_NO_THREAD,
 				       indio_dev->name,
 				       adis->trig);
 	if (ret)

