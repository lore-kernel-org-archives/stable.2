Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724992222AA
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784336403; cv=none; b=S80Yw0e6dGEYm/mw8wXMLHLbDVNpXUL1nINHDfb8dg0JCVFNj0S42LXwCLdRHS0eBVPQCeGtYPR9eAEWhMJ0MVkx7BoN0BgvuGf0fp86RyeZTFBiUfLJ0Bz65Er1W4L1Nx+iIPzezTGSxmImgkuOG7Lbu3QAl45RFWAsVAqJLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784336403; c=relaxed/simple;
	bh=t5dfLnmYrFlvfi9cFjKLCh9Lsw9U8pkmQFfRb4GC2sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmCeSmW2+Nk1vxPJHDLvaXuKj4t/x/Z+ej3d2RUt9ndW1HIwIrUozPFcwz6foVerSVdZp14KX66IiyAtSdBj286gIurUXbClde1gaRPpHpBVUL9zwnb9ZihAWuNEbjLGElGezMb3cWUlhQ6Xz5Irh2AdCQQj230TBD9/0v098js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkSXrLYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkSXrLYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBD31F00A3D;
	Sat, 18 Jul 2026 01:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784336402;
	bh=zEy0vrcIAQdZHqGH6iHTtKXXYXKbKBH7te6MIzhw6p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KkSXrLYkSTPgBOoLTHb1bo4rMWOSJPIU1r2GdF4u6eZDWvxBe1BgOFg8CnyRcZYWg
	 Qnz24eKXd6Y5jIIMX3PYg3sLNTLkmTt+nmcFrGXfnCwTRv5R33SZ3aCE1Q+4B9lPu4
	 j6CWZjVtr2VMnJ3mur75qm1wp+F6LHwDEBscKP64uNQYvm+pr+TEjdshQICftSSwl0
	 PA5j4N/myBvylJdHpJzLo/d0Yck2XZq6E9qOytxaH9LvRycvqOLQ/BucVa59lUyMLR
	 B9AQbpI8QKHJl9bb5Kons2EsNOhwLH41lw/GUngT2tCjeFjBRfesuqNlSAqpckXLqR
	 5Qqtb/KO7vxNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	micas-opensource <zjianan156@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: 8250_mid: Disable DMA for selected platforms
Date: Fri, 17 Jul 2026 20:59:58 -0400
Message-ID: <20260718005958.2505769-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718005958.2505769-1-sashal@kernel.org>
References: <2026071458-footpad-hunting-e8d7@gregkh>
 <20260718005958.2505769-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit b1b4efea05a56c0995e4702a86d6624b4fdff32f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 220857a45ac2d3..9a4c6466ab026d 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/rational.h>
+#include <linux/util_macros.h>
 
 #include <linux/dma/hsu.h>
 
@@ -371,8 +372,16 @@ static const struct mid8250_board dnv_board = {
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
 
 #define MID_DEVICE(id, board) { PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&board }
-- 
2.53.0

