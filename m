Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510687;
	b=ZQFLkYI2dyWYhfs38akVl4MDrwZ9Lykqs6dYyBAWTvOoV8xgxz1ruln5CAFkbxzSWIkl
	 tRkts1MELOGt7LF6KF0e2AvfRwhgUpXcpo/vY7sYBxAClJerC9Ek5d/eMTra9GgTs9c0S
	 2NIgM6mCTQpkSHa5LPUGbAhSEj+dg3HdSdVQ2lzlXCub4fFCqndn2nxThYuAUMjD911KQ
	 sB+EUP7ZX07K2HP2WpPpb8Pc1FDJSd+BYK268CdieHaguEiPFC1Xrs+b/0FNSlDruO/FW
	 Cefi71BdzIgPFYruIV457lMbgw9zdNPw80sMC4mdRS50co4m/2dy611je0BWe/jWyUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510687;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gIZ2SgTqsBXMiJy3jUNyd9Ce5+8WyUSAiaj9nc7FkrQ=;
	b=RwmkWQc83yjdBfcoxI/m7UymZOoMOltc6aCdJn42vgGbhilnHa4PGSxMAPDK9cRN2Uu+
	 sx14sTh4RhOvj+5AmZ7zHgBni26ah0vLGAcb6uKdwq/XEXh+0dW1cOcb8JuqX8MEU4sei
	 cHXcAHnIum001pvJLxFvzq5KxIhZ+c5yvscduvm6vIlFdGNtitwp/2rsaKW4/u9j32Xvl
	 ltY//LCOkQdmZQNR2QevPrI7dno5ggzGQ4BylRNAIVs46BwShucdckIOrjOoaS1dkZN0n
	 doYdyugBywPiIJNaSuYTIcKKzKgvuDZXzDEiKyt0sqFhYqUei2T/G3m5yIfKeOwCJgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaRog4d5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8543606A8B3;
	Thu, 12 Nov 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QaRog4d5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11311F000C7;
	Thu, 12 Nov 2026 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510687;
	bh=gIZ2SgTqsBXMiJy3jUNyd9Ce5+8WyUSAiaj9nc7FkrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QaRog4d5e/T3/ukLJ05f8sXvGN8BviEfr0P1BArjRyZMjrs9UvJapUWHSbGS/cpgA
	 Dj0mbGiEP1wb2EvEk9MACGE9tSzajGEZ+mcQO6nSsJFL4qjHNz8ss32veO+jdBN7cH
	 /eCmilzkn1g3y88vSzF9zjZcTLAO6OfWdDiOTJ/PAA2VjQFtuXa8dF52PdYcGaZ7y6
	 Mh1ddv7KfWUonhRKFEZvip9wFfGUWKy2z8BTK8KEmPvMqHrZWVGLD2HJXtkCC4eJJL
	 ZDhwkHYIANxpegBc1B88CRPpyIENABF9MOz+715zidQjD8boYCDzm+kq1d4fJp605h
	 LSu3+vhRYYDQA==
From: Mario Limonciello <superm1@kernel.org>
Date: Thu, 12 Nov 2026 13:11:16 -0600
Subject: [PATCH v3 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre
 M90n-1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-superm1-kbz-222179-v3-1-f20b5ac06b6d@kernel.org>
References: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
In-Reply-To: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Joshua Perry <josh@6bit.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

On the Lenovo ThinkCentre M90n-1 (board 314D), suspending the empty
Root Port 9 turns off a clock needed by the onboard RTL8168 behind
Root Port 12.  The NIC becomes inaccessible and r8169 fails to probe
with "Unable to change power state from D3cold to D0".

The RP09.PXP_._OFF method gates PCH SRC clock 1, which also supplies
the NIC behind Root Port 12.  Keeping Root Port 9 in D0 preserves
that clock and allows the NIC to probe.  Commit 4d4c10f763d7 ("PCI:
Explicitly put devices into D0 when initializing") exposed the firmware
bug on every boot by ensuring that the first runtime suspend executes
the power resource's _OFF method.

Add the board to bridge_d3_blacklist to prevent bridge D3 transitions.
Check the blacklist before platform_pci_bridge_d3(), since ACPI allows
D3 on the affected hotplug port and would otherwise bypass the quirk.

Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Reported-by: Joshua Perry <josh@6bit.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222179
Cc: stable@vger.kernel.org
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/pci/pci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba81443..17ec7f065682d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3028,6 +3028,17 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
 		},
 	},
+	{
+		/*
+		 * Suspending Root Port 9 gates a clock used by the onboard
+		 * RTL8168 behind Root Port 12, making the NIC inaccessible.
+		 */
+		.ident = "Lenovo ThinkCentre M90n-1",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "314D"),
+		},
+	},
 #endif
 	{ }
 };
@@ -3073,6 +3084,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (bridge->is_thunderbolt)
 			return true;
 
+		/* Firmware D3 support does not override known platform bugs. */
+		if (dmi_check_system(bridge_d3_blacklist))
+			return false;
+
 		/* Platform might know better if the bridge supports D3 */
 		if (platform_pci_bridge_d3(bridge))
 			return true;
@@ -3085,9 +3100,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
 			return false;
 
-		if (dmi_check_system(bridge_d3_blacklist))
-			return false;
-
 		/*
 		 * Out of caution, we only allow PCIe ports from 2015 or newer
 		 * into D3 on x86.

-- 
2.53.0

