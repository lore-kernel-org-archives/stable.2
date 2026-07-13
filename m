Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4719F121
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946952; cv=none; b=oJRo1E2kcpPjeJBKHdFLyg2G4gTpuqJsMrhlZOAgMjMyk+F+W99nPaFMG23OtaPlvMzN/N06A7lbaVK2mfqeFcdaAL/bDkRmNWlwN+JmOktnlsvPgnWZemn0Rll9cW0XB2Aw0Aptpio3WhdAJ36XGomzV1pvFHr1H5G5FW/ptr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946952; c=relaxed/simple;
	bh=FAGdPy+lsZRuRfEPFQJAZ8cjKo8xI0mRZoZZp54rw98=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FR6m45fTuVhSGdQJTAPkiuk2li6eczCwIqkwQrh/mE1fOYuwoCBg2iLyhV+UstPTk15UVHEKKdEuCX8FNhprvsHB+0DpeHl65DH7thUMeHJSXmWyhtPNkhWWVXoflwLhEzbvDJp86LJangI7ThWPLaa5E7D6xs2TqSwvGLeTSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7aLObn0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7aLObn0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED381F000E9;
	Mon, 13 Jul 2026 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783946951;
	bh=0Ak1ajwie8eglaW2AxOcuwQNdQgUjCCEa0HpSReX+oI=;
	h=Subject:To:Cc:From:Date;
	b=F7aLObn0xsoUmgnz0OUhecMCcFxygGKbVCLyKqGarEwMX6eBn/7n37J+XAq9DQZLe
	 Tkt8rUHF+4Vffne4d1G2vwplH2mnC+M5hqarMQGsawL5Jk7UJ0bQcGlKgzYLUpiYBH
	 4UpFIHQvZ3TrzT+VO14HJ2KYKDtzFHrWzJbME76E=
Subject: FAILED: patch "[PATCH] iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 14:48:53 +0200
Message-ID: <2026071353-jackpot-overcrowd-9420@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6e1b9bff1202da55c464e36bd34a2b6863d7fe30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071353-jackpot-overcrowd-9420@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

