Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038D38B7BA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038514; cv=none; b=UJp2HfOMs6x3NegDQ9hu45xtvyrf5NIH7v7iownLkH14/xYMqQBpkOjESa9g+Q5mxAyABb1aKaZkN3sd0AkAOZGi2nkPbz5XWj1HNfcpBbRr+FeWMD04st78xL1JXNkkFTr2Ni42Bbg1hSWpEYeAEREavLYMgiHDIGHY/i2wSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038514; c=relaxed/simple;
	bh=D8GQXnGrlYPUCvAkUKDjuAmii8meebk7fawXYihZ0XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUJi/SRN6fHTkvWVWWds0aAclXNgPsUUN3sj7B9VJtE/ka9R31/eJ+CEY96WJFkVZoJNeh09JqRMbtzYYigcZS1aapwc3pmrm137WU6nHz20sy3E40sKpIwMO0AyZbfP0z7PQ59o6SyDG6HV284a8OfqLHd3lkALt8q7XpzB1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MloqyOvS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MloqyOvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E221F00A3D;
	Thu,  6 Aug 2026 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038512;
	bh=G0GY0QGzuJ/HY75250/8HOhY0+ZNluy/qQV9slrBxbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MloqyOvSqUoip6HMSQ5XhtV+88qNPwKLGAJs37OCcx6yIeTvAHXtqL0tM9BE3F8MO
	 ogviGZVtXRYoxChfJ5HRbfpj6HWZmh0VvByF40lJfrs6uXDuKJ3GXgniYiu4dhiJJ8
	 1UBNaagC/Odymuc1EXyG4r1NpH4plnaw7BC0VjpqC2Ql0uoXHjVkf/BslLzM5ILMYd
	 DrlEGlm8xHBfm6LxsjbYb5IgaU+bw+XfH11eV05UaPOMuQsb+zufvqD8EDaTQdBUha
	 Q9kW4LDA8iYiA7FytbDX8DjSdhReoRCKXncOJHGOWZsadWHJuum4EDZuDXeBCyZ5/7
	 LVAX4BDYdHOUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable <stable@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms
Date: Thu,  6 Aug 2026 13:48:29 -0400
Message-ID: <20260806174829.1352022-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806174829.1352022-1-sashal@kernel.org>
References: <2026072925-designer-willow-bfb6@gregkh>
 <20260806174829.1352022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 7fb13fd7e9a59a37cd911efff83abe19e3ee029d ]

Commit b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected
platforms") replaced the dnv_board setup and exit callbacks with
PTR_IF(false, ...), which evaluates to NULL. However, the three call
sites in mid8250_probe() and mid8250_remove() unconditionally
dereference these function pointers without NULL checks, causing a NULL
pointer dereference (kernel oops) on any Denverton (DNV), Ice Lake Xeon
D (ICX-D/CDF), or Snowridge (SNR) platform.

Fix this by adding the missing NULL checks before calling the setup and
exit callbacks.

Fixes: b1b4efea05a5 ("serial: 8250_mid: Disable DMA for selected platforms")
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Link: https://patch.msgid.link/20260715073546.1875083-1-yijiangshan@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_mid.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index c6c13ef061a0a..5f67bf4ce0fad 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -319,9 +319,11 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	ret = mid->board->setup(mid, &uart.port);
-	if (ret)
-		return ret;
+	if (mid->board->setup) {
+		ret = mid->board->setup(mid, &uart.port);
+		if (ret)
+			return ret;
+	}
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
@@ -337,7 +339,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -347,7 +350,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {
-- 
2.53.0

