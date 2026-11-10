Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343558;
	b=0uMRUaFxz8wgcm9GhPcdY2o+wwNUYJAddTlw62CXx7V1uN3uV8VNIwZGAebWXK+9rhJn
	 YPDn7h8/GtTShRJVpyrUuYhJGjyznxT97Ul8dvINKD9AKFWWFOXVQSdDxtjfvHP2dU7Om
	 lKSKS1TkbkMfFE+tAttJ6GHIV3ZSYsS4mLNsPAc1+iIPl20DmaS5OXpNIXMx7fCfNM7mv
	 fv57Cs94s5TEqZWXDmiKK6QAHZm1UBHUczkzTCwFWX1CN71xHB+12V/2lfq+xQvPwlRpF
	 KB+8+kf3iTPP2P1RNlIDv4LANbAhpQ1AL5H4M5d+M5KE7kGf7y7rdeTjkd5/nU8C06w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343558;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=gIZ2SgTqsBXMiJy3jUNyd9Ce5+8WyUSAiaj9nc7FkrQ=;
	b=AKXIeHC2KAcOjC6sv5NS1yugVPpp6dxnVn1Mqb3YOKWe8kM3i1vzywFwLW8UPNy274vl
	 JDAnQfeCR8Kps3wpjyWgEcxyOi4CmFSlH+je8DFVg+EbFggYvlSV6E0vJmt7UrUwpJf23
	 qO2AEB6zFrJLOZ1IdpSg2oLkZII/8BafnN4ecDhnzGnWUCFMyqKzH+wHJhu82tqXlx/nO
	 M9y+xsrFO5zGWFTx4d6xB6dRcEtN3JVI9Ne0la2ZpGMt48c2CqhCTKZJdx4TOImi6la7h
	 o76NqPuzo3eXxD28y1JOdBU4IrsrR88FwHrRJtsJpNFbEdjHcvnMl5IS9oh1SY6eWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an6lsa8r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E428606A335;
	Tue, 10 Nov 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=an6lsa8r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7AF1F008A3;
	Tue, 10 Nov 2026 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343558;
	bh=gIZ2SgTqsBXMiJy3jUNyd9Ce5+8WyUSAiaj9nc7FkrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=an6lsa8rK8ZhGIzE48MYNNvlj6wTCqorkLE/+EK+q6PzNSpJbUEuBqLfoJQMECF24
	 dj2EC3SfohuGZrKCobkfKcWoo6Jd0O8+ucFpTrV8M5WWbrJiCo/4WPB+aEdtTNCWAO
	 6x47XVAAFVFr2HrebKGyie32NvOeqrgIYLZ8qkJNgUKkhV54C6BZcYoFU+Cu7r93zZ
	 PFGxt0v+mqETPBTBAxZ1tq4TS8DtqcaEoBIM1WXzQQL5bgq3mnPh9hOhdbrqyuIf5b
	 97v5LFPwFEnqUdzxJJMszkUXeYBtG0cvKTGGK4IYVA1j/1H+Acx/VR+ZDygW6S5DPf
	 Rtpf9CzFaMTCw==
From: Mario Limonciello <superm1@kernel.org>
Date: Tue, 10 Nov 2026 14:45:45 -0600
Subject: [PATCH v2 1/2] PCI/PM: Disable bridge D3 on Lenovo ThinkCentre
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
Message-Id: <20261110-superm1-kbz-222179-v2-1-5605e6ce6454@kernel.org>
References: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
In-Reply-To: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
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

