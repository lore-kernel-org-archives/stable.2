Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F449250A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044219; cv=none; b=dLoGhZw+rIHHAajA3NpMAl96q+YNusGOjwkxyrO94CI/LY9VpYyRsJY/cP2dvDW6WiejXqYAHlEHIMKkp32gWXTIlB7aqkQogNk8YiOvxJ2DzjiJgmMGJaofPJ+mrFUfbG1FDWrkQ8BEbyC7sSlNi3F+6Pxt2JdWENoTDG77XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044219; c=relaxed/simple;
	bh=Y43Vv6+M9bjvoxlcp8cEYqaD9CnWUPxdOVnK/UYsDB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nZ09zekZvpwDG1kZFYNzK+Jd9QQEyoIEYw84p2RyJTtE1FYo2ZGhIBKX7ZX7ReLNcqp8dQ6Ons+cVfnl40dseeCMu5HZ9DqRXVvsPWW2d9S4eQNjl0F8PQZNcC26KlF2YotWTZVd+bK3kX4dV2I/3y0Xj1jmZ195Z8VskV3X8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K6NZSmsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K6NZSmsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674EE1F000E9;
	Tue, 14 Jul 2026 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044217;
	bh=/KJTQ1YTR3STKViaHlAMZn1Mb5zlJ4UJ6Avqz3jqefg=;
	h=Subject:To:Cc:From:Date;
	b=K6NZSmsI8h4zRNQV/ADrJMNmTyOwwqSKabk2DiIAvLF0Hd3my3zo+4D1LfXyCsPQA
	 VIQJ9qKAisw1hK8o7N8nybE6qXpclHDbYFZt4YVXpz24McyfAmAo4m0HQZJkOKnRkn
	 qPSAaBbQuAjFxh4t0wQvxglIjrQMJ9UWEZOj7nyg=
Subject: FAILED: patch "[PATCH] serial: 8250_mid: Disable DMA for selected platforms" failed to apply to 5.10-stable tree
To: andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org,zjianan156@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:49:59 +0200
Message-ID: <2026071459-sulfite-malt-aeff@gregkh>
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
git cherry-pick -x b1b4efea05a56c0995e4702a86d6624b4fdff32f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071459-sulfite-malt-aeff@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

