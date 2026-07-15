Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADD52C9D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074680; cv=none; b=LJuoy+0uIuCGcpDfcmRcB/2AmriuuPQnyrzCy6tttOF8M77D3FiZgZEleSRnX1PNRq/xyK1lFoZc/Vrmx4cZK/8JjRje9Y8L1Xkyl7lX0ASDFylOySeO32ZBk9ptpfJG1lggUOZArC7qhhaHiL6r8U/ddXbCArV3LbKvCBRmrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074680; c=relaxed/simple;
	bh=AiZegMVl7guKGUFKCUl4mMy9p5KKaZ84g1GZyAtYy2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDCUxWUPP5U3/lwLkOoPXYT5Cw8qMSaOcrvoPHcxOlodJasDcphkavEerBcKdREY3Rb73xvSIb+w3englHnsNiwpeBYGO5vD0ZupJBiSP1kZc9RGcipFZgJTKeIoM4Blq04r0wQInbezUHeZxtNwaDPKrxKMMwEgVp4iuB4qFDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo4U7CxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo4U7CxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F291F00A3D;
	Wed, 15 Jul 2026 00:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074679;
	bh=idQnS+1DRKYFpGvhSlp1hYnddqz3z5qyMgKFDt0aS14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lo4U7CxRqqCrSVh5EtKEYlDXKDTZN2vyM4afLXYeOo2zPk3RqFZcKfkfgJdLbiFs4
	 JDxNxEVnw25QKmkxhnpK7k678Pu5eXfmIXcekwdYK7ox+FqBmrKPnibz3Tj0+eNdxi
	 GjJQYtq7wVrgy8e2rL1LVQOC0Tg3nccKnf6SZkgIdOwJPzxKRqaP34yrbPcFnmbE/z
	 UbdhZUpRNSz96j7aFGEwKOehf2Yv1qY7PQaOzWILrRwNzNWuSQBBMX9oMJEpSTTq9I
	 DzMZDB+CgyZCQa8t80ZGCKcMUBob++1cmFj0+VrBeXWADljqcqiR4oEHkqbSrwIOt6
	 N662gmEFGcPxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] PCI: Free saved list without holding pci_bus_sem
Date: Tue, 14 Jul 2026 20:17:52 -0400
Message-ID: <20260715001756.3783927-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715001756.3783927-1-sashal@kernel.org>
References: <2026071305-gulp-reenter-fa22@gregkh>
 <20260715001756.3783927-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 1d8a0506f69895b7cfd9d5c4546761c508231a8a ]

Freeing the saved list does not require holding pci_bus_sem, so the
critical section can be made shorter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-6-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 569f1e27a07807..fb570796ae5ac0 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2324,8 +2324,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_claim_resource(bridge, i);
 		pci_setup_bridge(bridge->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.53.0

