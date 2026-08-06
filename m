Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72D2EEE7E
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038513; cv=none; b=VNYNPjPDay7DpCAqJ/hZkF9JVhgeebNbsJjrfOKl7G1y1oGvqdfyjSqVQP8PxLPLTCQOwIEmF4wR9YwIvclM68DRKxyeZU8W77fGSArCgbQZp2AQ0qDgLk7VsAq7yCKOnhf43ot6m4FSWNiLBK74SK/JUV9WZdHb9paDxH/yZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038513; c=relaxed/simple;
	bh=c2dydsNvnWQ8gDIWNzzh9hN6WpImX0iNEBUmAqH8iMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub70D1UrwyRH7MO3o3fvJDm1PhCOo7ODD9/H01FIoXsXyEtObOZeDP8WPvhGPBp2ttWdC7vraX1i/Ogw32/Gx9B1VNeuKe2cn9WjqfanxsNAT7SnLDR3BtBUf1lh38iB/Gt8jtYLkMJ2zOO1o62jYjw9o0faXSsJ91/A51U6JwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbC3EHWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbC3EHWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B341F000E9;
	Thu,  6 Aug 2026 17:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038511;
	bh=EEsXzKlQkQeIgoi/7p3WuLsnz7Rln3Ddle9ft/471g4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbC3EHWOeNQl60n23I9VMWDFCHoLBdg/WDLecf6wrtGrlpzOlyvKoM9/WhfV4HQ6T
	 25/eOpNgPoDpAiSgDf0yUxouJxORhaEoA5kMJGfbX8GavAL3BdfgypRMDHjlU+KwJw
	 hwm6g11eBtu8qLHSgJe+rGSCfAXK+aEuUgXWxW0d6ki+pqS8SBKV5HLIE7TOWLlGc3
	 NMTw7xB5vRLCO0YAeXR0b4DJIpT5tsFqFAtMHKcZ8Mpi68dJXYSWEiuPP0oyRjLfkH
	 2dmOLivqtMwzQ7/Eh5BGWaUXe/wKZZXZj7D+w5nf1Fp7RQ1ItEZGdo4YC5GvVVGOB3
	 kzsU4AUYR7vhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] serial: 8250_mid: Remove unneeded test for ->setup() presence
Date: Thu,  6 Aug 2026 13:48:28 -0400
Message-ID: <20260806174829.1352022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072925-designer-willow-bfb6@gregkh>
References: <2026072925-designer-willow-bfb6@gregkh>
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

