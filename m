Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8BD3793BC
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037351; cv=none; b=stxyC2tGIp+n/mDN9P05SxkWvIajA45cGv6yS12zfpLl++tPy0amZvTL/rsFjMgEeqPovayU/xR/YCFt11bwIKzS4mFOrwppcHZhrmKFrdp5pg8w87RlQ7O/nkIUWmmLizWsz+3RFxwCzTgIrxKSQnPWzpyNyubjnTpQPLRVchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037351; c=relaxed/simple;
	bh=c2dydsNvnWQ8gDIWNzzh9hN6WpImX0iNEBUmAqH8iMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv6LKXPThy6iuBTxPin2BfwXunPQ5U3k6/YR2cPtyKFfg6Mci+jMMNj2usOYQ8bTAfCWOIaS9t2fSuw9GSgO0+sd0fdmQ0EFPdGU1+INzrOM/j0g/WSt/6QnQfZTzmqR9poBNvw144iD6jnXiTM80CPdU7l+G52OCuDMp5nJ4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrWKlH/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrWKlH/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B931F000E9;
	Thu,  6 Aug 2026 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037349;
	bh=EEsXzKlQkQeIgoi/7p3WuLsnz7Rln3Ddle9ft/471g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrWKlH/Xo12A35R0noF497YIR+K2nzWc2wvIXOLaP8LinasCI87f/yKwCPAL8ULEa
	 ojOcFdKLsfB8Bw8fpHll6+cS1srvIStVMxy6/yFr515M1V6j+c4pz5ttJ93lZrj2P+
	 5mo76rtIIDMTmnXD0vorIc371zd0m5g+v8yJoFRKD0G7DwfTyesRsfuiyF/OZ5ZuW1
	 KOGz7nloSLMwycDtb5Uy+XxWEepHtqqER/xviTRMMT5GgImbWR3ToIt0PrTMzJDHcq
	 8+W9MNpssQwZmEE177qK6/JcFB74Ce8RTxaNxHaUADaA5tbWYjcDvyDIDu37h/9mQc
	 g5E+s6apzQYZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] serial: 8250_mid: Remove unneeded test for ->setup() presence
Date: Thu,  6 Aug 2026 13:29:06 -0400
Message-ID: <20260806172907.1212704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072925-blitz-earflap-f9ba@gregkh>
References: <2026072925-blitz-earflap-f9ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 324facd1ccb353a213ea2c2785604f2507f79297 ]

All supported platforms by this driver require ->setup() and ->exit().
Remove unneeded test for ->setup() presence.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20220215101111.47250-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 7fb13fd7e9a5 ("serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 9a4c6466ab026..c6c13ef061a0a 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -319,11 +319,9 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	if (mid->board->setup) {
-		ret = mid->board->setup(mid, &uart.port);
-		if (ret)
-			return ret;
-	}
+	ret = mid->board->setup(mid, &uart.port);
+	if (ret)
+		return ret;
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
-- 
2.53.0

