Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DA3E8343;
	Thu,  9 Jul 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585702; cv=none; b=AFwYxOdBeqgZPC8E8Sebpx1FsT1IewIWSw7Oujw5ebm++EQU/IT2jWJ8arjAtiIwx8YnRHdtRx/TBcQxZaCKpGj+LWw7ex5R3WreSzHNzLgIaxZovIuI64ik4DSwCuTOkzTDDzQcCJombZkax3eELx4Q8sc9OkOjrdySNO1J5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585702; c=relaxed/simple;
	bh=W8aJmWsDCYzrglo4hW4OCZU5ACiR5TWfwBS1+eul67Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlsRFIMKN/mLrMGdUwDUS0Lg+dQFDctAetWZtLEODlhSJUFrvQ3gxZFEts9bbJ6hHtIBSUoMRdL/vRbj/3pbtYfZ3yfl6/DGylBav8JXE3C8NwCi3VHN/4W/Eyi3YLuTZ2iTi0E3yX0N0/IRgCAo3CJKkLXBwosnPxqlIc9JH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbR8fW/U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbR8fW/U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639181F000E9;
	Thu,  9 Jul 2026 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585701;
	bh=Cmoq6VMbPVy85en+8zJIIsm8Vs79+cKUgRAaAO2MN30=;
	h=From:To:Cc:Subject:Date;
	b=NbR8fW/UUNrdd+NqJi7VrAoPQap66t0KZK3vCV0OP8i/q06gq1TEOYXqXpUjUw7ja
	 t8IKu9tnGZyrfS/gg5YMHntuh9poH1gG1xtg4igjyqVKe73FPQ/Pz3PRhVUQ43fyog
	 V0vsmMt/10CKSf4aX5ojVmlZ4k6QCpra0zsSexK9YUqDAvCX+hDvY9h99Rxluj8Gvx
	 Vmn3Om7ga7t2nrE5KHD9PDv2H2BOVS56kxh8qDe9dkGONfX+aJfVSz3NVHe9Qhh+bM
	 6E8D+zauIZ8U4NomtuQYd+cVyWm+kSAE4ZuwuHRpB3MPSNcFUAgoJcDe+UO17u2L0/
	 QAnoFxY+Rtlmg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1whk7G-00000003TnL-3esa;
	Thu, 09 Jul 2026 10:28:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] net: mvneta: bm: fix device reference leak on failed lookup
Date: Thu,  9 Jul 2026 10:27:13 +0200
Message-ID: <20260709082713.829446-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken to the buffer manager device when
attempting to look up its driver data before the driver has been bound.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 965cbbec7f20 ("net: mvneta: remove data pointer usage from device_node structure")
Cc: stable@vger.kernel.org	# 4.19
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta_bm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..128fe1f512b4 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -395,9 +395,20 @@ static void mvneta_bm_put_sram(struct mvneta_bm *priv)
 
 struct mvneta_bm *mvneta_bm_get(struct device_node *node)
 {
-	struct platform_device *pdev = of_find_device_by_node(node);
+	struct platform_device *pdev;
+	struct mvneta_bm *priv;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return NULL;
+
+	priv = platform_get_drvdata(pdev);
+	if (!priv) {
+		platform_device_put(pdev);
+		return NULL;
+	}
 
-	return pdev ? platform_get_drvdata(pdev) : NULL;
+	return priv;
 }
 EXPORT_SYMBOL_GPL(mvneta_bm_get);
 
-- 
2.54.0

