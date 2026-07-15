Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2B3C9ED5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114183; cv=none; b=IemMJP5zcoOnFbXK3sLDyb9FPNXODJe7QO0VREpoZSYYKxhVoJPZ4NSxFMlohrAmBVhv6t5U55RK4aUwIhCJjRsFapIiJe3BJ4ZdLthytAwTd1XZU1H1N5iAj2/C9/2SgrnAYnk7mABZ4P9XzVb2/QGDqX2F2Fhv3ragqkHaLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114183; c=relaxed/simple;
	bh=cA7KJuejJcGfVAe1w5mbwBnFHS489fvONJusiC3FlmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc5DKc5ZsFkkubpeB5FGDdQWoewqiWk6f7w/JalOeuVB9A3pzwJnDPiP42mnlGOeLG/Vb/hk6zUXU3ZVWPoemrL8cJpxeyGvL6oEL5uIrJtJIb9c1ZGxUkq0d4VbuSKVnnD8oNSqPG5G+kExAe4iGWKmLkXYJIfM2aS6G7lCA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jqi34uNV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jqi34uNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8601F00A3D;
	Wed, 15 Jul 2026 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114181;
	bh=7/94RzFanRSTI9ta7ZjLdZR53wXHEJGdYyoaY200/1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jqi34uNV+IOcS5LmaG6mrC9lOe+8RIQsXKRMyfEJcGlgsKkNGvbSZqhBBBLB2tOC4
	 cb/wUygSP1AFVs3UrKCJ7XBr1CcOa9K3nIpjm8dBYLslgHVH+5t78aZQ7a0e6MvSYN
	 Kh92tveRrVciVieoCbv7IoYeXdnNzuTjJucntvOp64OxD/PcNA+ZuFYiP4SoemOSvh
	 /HPfO7hkttF/jMXbUTZZI4we1m/QAWyQ7bHVsSiwG4B3BwbsX3sM1ID3s3PtI32hb9
	 DEz1bGg2yPNoMkN80g6McVEqKqpUMNPKGK26QT9FQmNbjeFOIRkSps3KSJtGc6eDlg
	 03zQCwVq+hJkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] PCI: Free saved list without holding pci_bus_sem
Date: Wed, 15 Jul 2026 07:16:14 -0400
Message-ID: <20260715111618.647249-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111618.647249-1-sashal@kernel.org>
References: <2026071314-tableware-flashback-79cc@gregkh>
 <20260715111618.647249-1-sashal@kernel.org>
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
index 92a9a0f38fa76e..5d85de5e777ddd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2269,8 +2269,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
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

