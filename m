Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E37346ACE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044214; cv=none; b=aovgdxUYhLEp3kDgWSbaty9Z3tYblWaC3mvPA8i92/qb8JxknmkQrJUPf8ACaOPC7MNM/MDOvi6n4dVsxTfrLf7i7HdxT2az3wY4S4c7pYdEuguh2L+0XbeaNJYOWCZkYzYwLHTIjjF4EcDSWXb9NoI3KEv4KDWCBUSMeikklZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044214; c=relaxed/simple;
	bh=cq7rdx61eXdbjcyO87qDHTPh3msIixHXID4aorjNQj4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sxpzQ2OnQBs+wIFpmMSQ6U8BlenPAq/PsFjXIgwFC4Qm4hrGoMUIEiP3ySv9gKpk1ukJYEmbLrSEV9Gb9ftjKxqFgMUUT0Rk9Oje10G46X8OqUIpJ4tA/ZwGGJ+BLtB6Z47GRmXqZi8Yoe0LkNmph+jpEa56w6gxA+9eCKB2sK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ortstp7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ortstp7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2568F1F000E9;
	Tue, 14 Jul 2026 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044212;
	bh=0HmbZMHW+HtHIrJzVljELFcrk0+vu5H2pmmA4/wVv/E=;
	h=Subject:To:Cc:From:Date;
	b=ortstp7izr4JdB4kmBo+dxVtga+gO0F1gm52tYXnJA2ExGnxUZKoUbEWj8wmb2DOB
	 eOvQUUHRI50krI+e8IRcRYL5cCq9rCJgiTltmUKvpSIGQqc5Jj2B5XS32RIHw0uAQH
	 AuHRpj3LuCjeZJluQWsS8EertmkA3RNLnRREXGFc=
Subject: FAILED: patch "[PATCH] serial: 8250_mid: Disable DMA for selected platforms" failed to apply to 6.1-stable tree
To: andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org,zjianan156@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:49:58 +0200
Message-ID: <2026071458-transpire-rigid-ad0b@gregkh>
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
git cherry-pick -x b1b4efea05a56c0995e4702a86d6624b4fdff32f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071458-transpire-rigid-ad0b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

