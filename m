Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE141D63C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059372; cv=none; b=gIVjEMP1S1y7K+ZDg9HuIM/dhKgiIF84gwYC/KDC6yK4COTIt4xHQyZSkBIUy0r8WUqXc+x+xX02xcEUnAsPa52jJsz01LIQgQiQb5ftr1uuLA4KO6JUeZWzVfBptLTJKRcy7HRlNKwSoiELk7a4gIkk2B2PUeiNYCnt9e3MMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059372; c=relaxed/simple;
	bh=akN/88WdJGEfZePDz9mXxIEFNSEBQ6ADSZwvlToGdQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLgNP7QV+5iNBCu8QPRhE5zAEMZpD8iFB11hCQ8UOT1wSBCW9z85lRz7yesFME1JazEUInXwXh038hWs27730sIGeVIWl1k6b4JpjkGGRy9Z7vXtI3w2Dorh/s1gqKpTczc8a5BaXZ3lT/ZY2Soo/KqrgaDROaNatd8eOpJk1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNzdHHio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNzdHHio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59611F00A3F;
	Tue, 14 Jul 2026 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059361;
	bh=zuiOq3wPT0D/PnLDozRyhRHWmMlLP36M+6CjPPFmw6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CNzdHHio5hqV3RxiPA3RDK0uaRvdP5P+ZubQePrxwtIyU03AJ9EY98DTBTJYPLZC6
	 fOqnhcLVZSEZIGG9drrwy2uYo55+uvV7AqH24iAHQslmufRqs6w03bKSc8VAv9XKG6
	 8FuSddcAi60knxPqgwTPaQInWGoodhc4sBfzqXxWe2cO5xoUp/tPUrTnkFETbGS7rt
	 N2po/+55PKDTNE8gqfUv3dChkLxZPnMGL6xzmMo5zPmY0UCbtiZLgv5BTLTrE/Z8+i
	 AuJvBQaknnouTNGGqlnrDOfz7Xomg+5fHwXmMRUNe3c/7s08EE6xaIlXkcTiWKWpE6
	 QZdSegzU661dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/8] PCI: Free saved list without holding pci_bus_sem
Date: Tue, 14 Jul 2026 16:02:32 -0400
Message-ID: <20260714200236.3153778-4-sashal@kernel.org>
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
index 55f3ac3f3eb1cc..5985ee441c7e2a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2465,8 +2465,8 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		pci_claim_resource(dev, i);
 		pci_setup_bridge(dev->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.53.0

