Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1763B8407
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120584; cv=none; b=dTX7bcqBDAaxtpzmYgymO0vQzACrwJfB2nJXT6gjUUzGJiIWewFsygY7fa+87sLBPWOrnAU7K3O0LXmkyFVQRzADNXCeTzXdzGCH5a4/5Cqd9YzjKFIBGmKvN2GeVLY3tMwLCjE3rtOqdWCspZJaoqNCnL5mS6BhEuaIWidygyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120584; c=relaxed/simple;
	bh=t8xthvLB34WKlOuJ+NuiDLgely9bY0UwOgmPUZUzplM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=lGwlB1EFLXBkbc07S3AGWzF4BBsg239iM6e4qaHQ9Kkzt2AI8DiK0P55jRVWCL/jLOTs8RUWzZayibudfyUFeFXoZbmhg44GIWR5tDwiEaGI6Hh2RlMbUrTnRLcO9BTPrwD8q/aoNVM4c7L8XPJQcJQJ43d5dh2rvNw/vnHWqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUwnhVXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUwnhVXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06AB1F000FF;
	Fri, 11 Sep 2026 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120581;
	bh=6Nq5Y6+mQkvadoK2KYaYQ7bLIf0jkYu/1E50ElHGQ5A=;
	h=Subject:To:From:Date;
	b=BUwnhVXnhaH8XokX2hCIOXMspvGcaazb1MIYiL+2tSV+WsDRiZoTUB4C10RrA8ptF
	 LlOUj2B9+ZEiCpc2FlCI5dgMwwQYlyyIZsdBQdR1/4FqGOd3D+y7kHFuCOMgWDOsgV
	 B1uLf/+xNbSqUCs81/slbHZ5h0V+jJaB/yRxbbws=
Subject: patch "iio: adc: rohm-bd79124: Fix GPIO mask check" added to char-misc-linus
To: mazziesaccount@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:33 +0200
Message-ID: <2026091133-garbage-magazine-0f29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rohm-bd79124: Fix GPIO mask check

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From d081c116a16489f7808d35fcf1ee9d4b9869d204 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Aug 2026 10:50:49 +0300
Subject: iio: adc: rohm-bd79124: Fix GPIO mask check

The ROHM BD79124 has pins which can be configured as GPOs or as ADC
inputs. The bd79124gpo_set_multiple() is intended to ensure that a pin
which is requested to be toggled, is indeed configured as a GPO.

The check uses XOR, causing it to fail if mask is not exactly same as
GPO configuration. Eg, if not all GPOs are asked to be toggled at once.

Fix this by checking that mask does not contain pins that are not
configured as GPO, allowing some of the pins which are configured as
GPO to be untouched.

Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/rohm-bd79124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 2c031a5e9eb0..f5b3096f553f 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -200,7 +200,7 @@ static int bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	if (ret)
 		return ret;
 
-	if (all_gpos ^ *mask) {
+	if (*mask & ~all_gpos) {
 		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
 
 		return -EINVAL;
-- 
2.55.0


