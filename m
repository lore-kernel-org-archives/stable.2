Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF33AA9CA
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575909; cv=none; b=tDR1XiMtagXbO9l3SFkAaPalGlBUvEaF3ZcnqSX19f8ApV6BX1eOGYV2epplLURs9I2IRBLYOc8hClUaxc0zP+ad8wTFi8rkCiVoy3jNnYvc1s5M565l9nLR7ezqMEnBI3jVwY4odPQQiGpXOofEFahw6Gmp+aIdpiCu5oG74Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575909; c=relaxed/simple;
	bh=7YWYUetXgW/NXR/YgBA5uVZfly4AXacfnLWUPCgSzFw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Jua+NyP5tidXCpVzPHsWr6+8mXA+/PcmPcfWVdGRbnbXCh+JauL4eNLCeMAR2NyJ48CS/29lmkwChIHtFg9GRHCoURxY8CxVl7fEZIjL+2pNVm9VpUj25QBIwO+ImdbkZn9mtdxqZq9diGg+Ar822ovMZ612C4MoXyo9TbdS240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=stXA3LyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="stXA3LyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F231F000E9;
	Thu,  9 Jul 2026 05:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575907;
	bh=55ZZFEqy3fNRzqThxxp3OsXe7dV130QAcFCP1neztSM=;
	h=Subject:To:From:Date;
	b=stXA3LyN+KhkRT6b9Yp+BNRsKq5I4YrwPOt5/+LKhRsSby7pwKEfKp6c+03KXWigU
	 gVWBL+tzFIYbP5Pkb3PeAkFStx81r+fYLlq3y8khZtjImOQMtOlmMOwhQzdjzENqs8
	 dcoKKIchV2aL80KdaSyDhuWhqa52GWxsXhSU1sSU=
Subject: patch "iio: adc: spear: Initialize completion before requesting IRQ" added to char-misc-linus
To: m32285159@gmail.com,Stable@vger.kernel.org,bookyungwook@gmail.com,jic23@kernel.org,jjy600901@snu.ac.kr,sangyun.kim@snu.ac.kr,vz@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:48 +0200
Message-ID: <2026070948-deviation-walk-a31d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: spear: Initialize completion before requesting IRQ

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3ee2128b6f0eb0be7b6cb8f6e0f1f113a65201a0 Mon Sep 17 00:00:00 2001
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 12 Jun 2026 19:58:11 -0500
Subject: iio: adc: spear: Initialize completion before requesting IRQ

In the report from Jaeyoung Chung:

"spear_adc_probe() in drivers/iio/adc/spear_adc.c registers its
interrupt handler with devm_request_irq() before it initializes
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in spear_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, spear_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_isr() calls complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access."

Fix the chance of a spurious IRQ causing an uninitialized pointer
dereference by moving init_completion() above devm_request_irq().

Fixes: b586e5d9eee0 ("staging:iio:adc:spear rename device specific state structure to _state")
Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/spear_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index 4be722406bb5..ab02a14682ed 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -283,6 +283,7 @@ static int spear_adc_probe(struct platform_device *pdev)
 	st = iio_priv(indio_dev);
 	st->dev = dev;
 
+	init_completion(&st->completion);
 	mutex_init(&st->lock);
 
 	/*
@@ -329,8 +330,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	spear_adc_configure(st);
 
-	init_completion(&st->completion);
-
 	indio_dev->name = SPEAR_ADC_MOD_NAME;
 	indio_dev->info = &spear_adc_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.55.0


