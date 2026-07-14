Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB53A4F36
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044205; cv=none; b=NPZXQZrP6SdLc/bN6bB+LBPuQlz6Unkm+ETLQ6OFghsDLDJMGkmFCNot9iRKHnyxMsnCVqdQ/2EV0iv+QonrcIhWUZ8iNFM8Euu71hbJhus5vH/QzQTBqTbne7waxCxS0n7j70KPevlNm+TpHiPrvSq0NRAsLGZRvJ9gWLIBAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044205; c=relaxed/simple;
	bh=ReYe2pgmZL5/h03+PSORFqf9fomfhed705+LNcqc/FM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sfF5GoIaMBWOCpL7uUEYu9suYt2rK08KBzMvPDgNdsbfLF+zXs+SKtLKFuBJyX6FnP/hICDUyvLKLeRqp8dBcMd0Aua+m+jbLtNZPKoFq2+k7QjGT0Rbig3w2EE/03295Ms7t94f1ApEvLCIMYcA2pofiW6uO/54QFQCCibY+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IdN82fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IdN82fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71651F000E9;
	Tue, 14 Jul 2026 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044204;
	bh=gYLtqRQWy14kS4PXkvvENf6FUw6WUxop/IUUTksNLrc=;
	h=Subject:To:Cc:From:Date;
	b=2IdN82fy4VNbaR+wHMmTVEaACn1u5DJAOEYWcYOjW0cgc6gqeaA60FRWDhibYpWpG
	 Z/w7g17H+TvwDqm/GijWNcqCnomM/n1lJu+vQHFA+j3Eme1r3HcglsN/0cDr7YQrZT
	 PICTBfpR69bSlxujPjUnpg2uJWpMKT7tISEdQycc=
Subject: FAILED: patch "[PATCH] serial: 8250_mid: Disable DMA for selected platforms" failed to apply to 6.6-stable tree
To: andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org,zjianan156@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:49:58 +0200
Message-ID: <2026071458-expletive-shrubbery-16e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x b1b4efea05a56c0995e4702a86d6624b4fdff32f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071458-expletive-shrubbery-16e0@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b1b4efea05a56c0995e4702a86d6624b4fdff32f Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 26 Jun 2026 11:49:37 +0200
Subject: [PATCH] serial: 8250_mid: Disable DMA for selected platforms

In accordance with Errata (specification updates)
HSUART May Stop Functioning when DMA is Active.

- Denverton document #572409, rev 3.4, DNV60
- Ice Lake Xeon D document #714070, ICXD65
- Snowridge document #731931, SNR44

For a quick fix just disable the respective callbacks during the device probe.
Depending on the future development we might remove them completely.

Reported-by: micas-opensource <zjianan156@gmail.com>
Closes: https://lore.kernel.org/linux-serial/20250625031409.2404219-1-opensource@ruijie.com.cn/
Fixes: 6ede6dcd87aa ("serial: 8250_mid: add support for DMA engine handling from UART MMIO")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260626094937.561776-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 8ec03863606e..f88809ff370b 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
+#include <linux/util_macros.h>
 
 #include <linux/dma/hsu.h>
 
@@ -368,8 +369,16 @@ static const struct mid8250_board dnv_board = {
 	.freq = 133333333,
 	.base_baud = 115200,
 	.bar = 1,
-	.setup = dnv_setup,
-	.exit = dnv_exit,
+	/*
+	 * Errata:
+	 * HSUART May Stop Functioning when DMA is Active.
+	 *
+	 * - Denverton document #572409, rev 3.4, DNV60
+	 * - Ice Lake Xeon D document #714070, ICXD65
+	 * - Snowridge document #731931, SNR44
+	 */
+	.setup = PTR_IF(false, dnv_setup),
+	.exit = PTR_IF(false, dnv_exit),
 };
 
 static const struct pci_device_id pci_ids[] = {

