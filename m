Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8C47CA62;
	Fri,  2 Oct 2026 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939403; cv=none; b=RjxjJFIMtklyoa1sSES6YX3GaX7cuyqc2zl07X/BwKUFJ9q80EHR/cRk6RGoKw3npg+EgzrEYd6Jq4sYs0RNN6jiynoDGsYh2YpUdV7Sv2HZ8pNmpUIak5zgDFncS/as0mFKKnt06FQ3sy95d1vk88nhQ0M9nVhEgl4hiptvJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939403; c=relaxed/simple;
	bh=9Tyey+PpQYVnJxUIQSpRm/0z1TJD6oq9LNHH/PxCcgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVwkKJZoNKnUH5hDor9SU34Vh2Jv9A6gfyEO+8T0H1rakhnKA4PbLsPztuo9GhuLs1K8NBZrqNVbf3B14EE8Dz52KMuo3V5JwLzeHItJgZF/pJjDWDuw+poqllq1jXIBB1DnyIZh1mC/DL+w2oplOtlpkoz1/aAAEWPXOzDd9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anhHdi3m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anhHdi3m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797EE1F0089A;
	Fri,  2 Oct 2026 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939397;
	bh=9w3Za6yjLfr8k9yYgSHrwJIyHlV0VlFscPtwBwUxy1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anhHdi3mbewyWSQRFdVwC4BSFMVJZ26IXVDcwyTXxrVVrz/Oyb6sf1IK2ZD6EzQ/U
	 BwyvMkb/fWw9GSFe8MhvZwpmBUdZRcTy34lyity1HJO8B0aOzL9FsQjIgygxBuRFbf
	 7mML1U/53H6h3Vr77BeSLpylqd28lxASwni4GANHLTH6uIUIrPkfPqha1+i5ZG+nej
	 o/Mw2tY4RaAjLnTpxE/vQsjDcyn9qS4rXQBYYbBkLWpwyFKSzI+oWNQNPYyrPEUaV+
	 3hzMdgT/ytMWgDkDzWdTKU2DS0/6ApW0ekTIU0PbVWkiKfcdU9YLLo4gwRp9K6uHbi
	 BXZYa1EwqvBFQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 3/9] PCI: rzg3s-host: Select PCI_HOST_COMMON
Date: Fri,  2 Oct 2026 14:09:29 +0300
Message-ID: <20261002110935.2004349-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

pci_host_common_link_train_delay() depends on PCI_HOST_COMMON. Select it
to avoid any build failures.

Fixes: 2b0d1a605ef2 ("PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none, this patch is new

 drivers/pci/controller/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d246bbe37948..3e2889a7f1a0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select MFD_SYSCON
 	select IRQ_MSI_LIB
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
 	  SoC.
-- 
2.43.0

