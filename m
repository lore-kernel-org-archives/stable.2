Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627859;
	b=nb53Gk9FE8ALGJateLJ/CBTY5g63yRLeML72gNyEZEGWMczZWscyYJwGAuAVHFK+g1PJ
	 3LKulRjMScRXHOlIul4Kujg81MZdr/pJriMIclVNkPe2W4GKwJidPfEvK8gITSr5PU8Z7
	 cYvqFGLK0Hvq80m1MrS/FIeMZtT6oNi3aaWjMbmMF6R0e41YN0fBWwOPp+UkyUKx0se1t
	 S+ucCPuWuj1ppBL1N7FNH+b4gpYY8+9i5HBOCcLLpQJj8W7f7yF5lg5+vo32FdrAmOXDZ
	 2N85sKtEixIjOdd4Yq32xMgCLsVxmFSAHXldYM9B/MvSZsVP9D+OM5WpJjZ8YjLfB/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627859;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ciKcvrHroXrvoGDXsp5MEAGeUPFNnPeJ9WSkWfsPgEU=;
	b=xtiRrsatPUjlGYgQxhKmJgbTY4fNpK5FrQ+ZaHtIREDCaru1A5Bw7drmIN1bbkxzY4nB
	 T3b1QhJ0tudLWH19AHmGuKFAMAJv20+R2sQNQMGmWrFPE+uLzBKgyaOisQbR2dX6svKPv
	 uh3eGYPYblo+ppGSbnI7t7aSAAJO9+L12bmSpYqnMlSYKEj4BGrBgacn2DxthU9L0lkTA
	 KgmmD2g3Y8WTMhlUujnhdhiRE/DQWeaOZKWxo9qRfC2Kqk2fj8mfqnq4M+E3msRKt0ezC
	 MOKTHD3KlLGJTpC4z/WxvkpXj6suBPU4KeKudp2ATzOKATQ/oo5oKohEtYWrMlor5Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jY/Z/luW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B74606A33A;
	Mon,  2 Nov 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY/Z/luW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16361F00A18;
	Mon,  2 Nov 2026 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627858;
	bh=ciKcvrHroXrvoGDXsp5MEAGeUPFNnPeJ9WSkWfsPgEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jY/Z/luW3qHXt7mZjZVU+9BdpRI5cmsyxA0TDKoYo5fWzLkVuI2gJt5BmRub+lfu7
	 9LO0ZoqhK0yjyOQIqbUcyzLIPO44QaDZYBZByASLt9cZDe8zpTTpaklHZNomi+Apy2
	 FAQQC1u/U+Fz3zZegvvXeE7nhdLlrqsUgTB0YiptT1+wFd7tO6EH2eKKyQYbGfhDcR
	 RMZXLB1LakQazXQvG6Ee3j/f1Kvv8d7Bgu+jwpOAly+cHzFNG5/EGuUwLokD69GN03
	 xZ/wZjpo2Qn9p1yuB/6VhNGikssA0S873qQt+vtkxHCD/I9XkVUCSNqMWACrAmHqH/
	 gfDwEOfYjl3tA==
From: Mario Limonciello <superm1@kernel.org>
Date: Mon, 02 Nov 2026 07:57:26 -0600
Subject: [PATCH 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre M90n-1
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
Message-Id: <20261102-superm1-kbz-222179-v1-1-c91a664ba251@kernel.org>
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
In-Reply-To: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
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

