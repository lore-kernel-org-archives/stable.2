Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74D41A938;
	Mon, 27 Jul 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158680; cv=none; b=YWJHv1XiNgxYgCuK56oBmzEcKfU+oYzb2VWD+p8BOLQ9aezfa8xTlfCNY4ohX1boXLa7pRPsElBftupC7mQGiATyRNO7X/o7aXNTuBRLvisOy9wbZ7BNOn8D5/c9TQ+WTFamDVePBTO3wc2+sC+B8ZjGzaW3xV5WxVfO3QrWIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158680; c=relaxed/simple;
	bh=LWLhBZ3YhqHtemmyrVHEDfVV8bZ1ldLrcC31frkNKFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqHxBmZ3TY+cNJSEcpBteJFBiHSs/OsWQMtlxCXHwlYCAvL8tLfxUBzwmQCyYpwA23S03ZWEVyVSvIgeTNDNeHXkloDBJl7ulqz79nwKbJJ2IBxOurIqIwCxFYC0E90X7fHSLjsQQ+SDQw4mud23gTg0Qs5xZv+6NtPzRx1LtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQPiILAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQPiILAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8CC1F00A3A;
	Mon, 27 Jul 2026 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158679;
	bh=pxg/kdbMDOI7VbEj1X1BoLxGjHFWNUoLvc3rO1OTTLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gQPiILAWpn+/cgJ92+dIOcGwMT6KLTH6+YxvF36cWmAxTtelAxE3XdZ2wmUxjotov
	 cllWOlIXUkvbOLUHm/Z17UBtfYLxiAR0gWE+g+GVdIpOeih47viTiAcA3O0dw1dEcp
	 27e02XAffm+sgNaTD/azLfGSZ63ahXNe9hZTk9tg/AdWyrXkaWWmaxBlaoqPBTvVMO
	 nILzX0clP9EksVjZr51iJf929Shw6C9RAmjtUsT0Hi1aTkQJVGg48obg8MyczTjxkG
	 gBR9cAN2b7oADlEh409ISDUfBMaAPgiR5orCrc6gyJXqMeU3+KkmHFZQ1gw+Pv2TVH
	 jTTvC+PIzontA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 09/10] EDAC/altera: Detach sb_irq handler when db_irq setup fails
Date: Mon, 27 Jul 2026 08:24:15 -0500
Message-ID: <20260727132416.807230-10-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260727132416.807230-1-dinguyen@kernel.org>
References: <20260727132416.807230-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

altr_edac_a10_probe() installs the sb_irq chained handler before fetching
db_irq. If platform_get_irq() for db_irq fails, the probe returned
without detaching the sb_irq handler, leaving it pointing at the
devm-freed edac struct. Unlink the sb_irq chained handler before
removing the IRQ domain and returning.

Assisted-by: Cursor:claude-4.8-opus
Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5087aa5ae5612..80ca9f511ac98 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2209,6 +2209,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	} else {
 		edac->db_irq = platform_get_irq(pdev, 1);
 		if (edac->db_irq < 0) {
+			irq_set_chained_handler_and_data(edac->sb_irq,
+							 NULL, NULL);
 			irq_domain_remove(edac->domain);
 			return edac->db_irq;
 		}
-- 
2.42.0.411.g813d9a9188

