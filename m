Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C841D643
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059368; cv=none; b=W9ClllYFVaYQ2TsIie9WFHuoP2m86asgLsw0TEuv9tqqp/typ7CyMad+N5wZrrfoeAgNt+T13XFpuqybZ8jEpkYEigcVJHAVUd5yh2m3S8A7zg+UIZ11+u7OUqdJ106GlyqP6FW4rUzsV33Qas0zMY3Fk8+d1F87eqtBlqmfCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059368; c=relaxed/simple;
	bh=zkbq/Fi+/TGY0Uz8DWeP7AmPR6QTcCXf5z8eqpVYKAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcybHtKhY0ULhVBdUxCMEUGf8uuLCHxHvfBcXbGqADKXC5faoavGhvpdJtGmnybuL0YepqnHbw0NcUVPLMjWcSZYjOW16QCWKb7AJdSVP5IZIvUZkYuTwQWCr4Gc+7LAVcsZX/757VGLTChEQ+qeoognn1ENvZV7R0V2hNRBpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZPZ7e0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZPZ7e0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA8C1F00AC4;
	Tue, 14 Jul 2026 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059360;
	bh=f/8phhMD9CGQ/X+ekW646XtIa++rbiFpQGa4NFaqK9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZPZ7e0lmJg100cpiMrPf7yNJN41v2sEWC5gkJ5v5J/imPMPLqMYy2wC93NZApymZ
	 yZXo4hmMgqCqhTq2Y2eRVYyQaerPI/f5OD+E7qnF1iv2zSGoyuN2ImOw2bmU1azXLm
	 Lpug/CD8+k9a4dQibK0ksisj+wWz9QifQE/6G5AIsbwaTCtmKDV80I6blrQS7QFU+G
	 xx2PcGqDjFqrSeH4zrL3NuI4v40M1LPmiOc6rKn1uHr9TVZ8Z8aT8mIhgF2xyRHpcs
	 T5z+zUYwcs12WG4rZBpjDObOS7zqtpA9PCYIroIrRu6kg8wgQhT7vyVcp58gXRgc/I
	 IQKsydj5Kr36w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/8] PCI: Try BAR resize even when no window was released
Date: Tue, 14 Jul 2026 16:02:31 -0400
Message-ID: <20260714200236.3153778-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200236.3153778-1-sashal@kernel.org>
References: <2026071350-unfold-lather-d66a@gregkh>
 <20260714200236.3153778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 121d3e9e4b217f2f23715901fb15c6a3ca2bab46 ]

Usually, resizing BARs requires releasing bridge windows in order to
resize it to fit a larger BAR into the window. This is not always the
case, however, FW could have made the window large enough to accommodate
larger BAR as is, or the user might prefer to shrink a BAR to make more
space for another Resizable BAR.

Thus, replace the check that requires that at least one bridge window
was released with a check that simply ensures bridge is not NULL.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-5-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ae72a34b09c562..55f3ac3f3eb1cc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2376,7 +2376,7 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 {
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
@@ -2411,10 +2411,8 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		bus = bus->parent;
 	}
 
-	if (list_empty(&saved)) {
-		up_read(&pci_bus_sem);
+	if (!bridge)
 		return -ENOENT;
-	}
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
-- 
2.53.0

