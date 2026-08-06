Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0029485CC3
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037351; cv=none; b=c7pQAJZhnJDYJJS9TRdQ/6+D+X5xVbxbOy3GprrO7VUHKwycKp1HjFxOWb8Ct5cCqZeSCPmRb3kzPBAVxRi1ytR44bGWkdCqr3S9T6QzyRrHFkdsjSmLjC6ZfSyoATMQnbtfehixjNZKIhW53vjDL9dyCY0grSCFusY8Xza3UB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037351; c=relaxed/simple;
	bh=D8GQXnGrlYPUCvAkUKDjuAmii8meebk7fawXYihZ0XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBIgUGClgBan0InVagYHi3gotBauOvlD6d9l2InXxtwl6cH9ylwPXqlFOM0IV2jkBzJqeSqbpUUn4YESYcCWXLWpuGWKuCBs6AIvbdyVR3f4x2q7YxWnDRC4dVyyxUdD3Yu2/Il/Q4gvVoqvgvntJ5KONul0qBfJRHQVjq1AEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiPBmjTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiPBmjTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA50A1F00A3D;
	Thu,  6 Aug 2026 17:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037350;
	bh=G0GY0QGzuJ/HY75250/8HOhY0+ZNluy/qQV9slrBxbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SiPBmjTFHl4ZoUr8Kqo6jHTpJLo/TzhsCOgUS9RxviIhsoqkac/gIaf1ed+qpzEzN
	 RMV6QuInrb6UbLBw1TaLwgpN30vA/rv8BXnDjtFVh9OgEpyIEGHBEPqEn+lb8VxtaG
	 w9xYDTC/8CUmx7ITyP0GQQixOzoMQvYWbZD64tCGMJzjWS2SRSdCJ/qOWu0AWe2HhN
	 KPtyn914uRQ1+XpGkwi+6lR1hDJaOcW6Lyy34Kunho7VJ3xyUPxBNiEYA8j76I4UJN
	 zarFlubiFA8RslN/PlXEmEVposCHOjyzGucNkN1LOX6Ge6qA3/asbFgBHHs1PmYtfD
	 s25DGKIAAlZLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable <stable@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms
Date: Thu,  6 Aug 2026 13:29:07 -0400
Message-ID: <20260806172907.1212704-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806172907.1212704-1-sashal@kernel.org>
References: <2026072925-blitz-earflap-f9ba@gregkh>
 <20260806172907.1212704-1-sashal@kernel.org>
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

