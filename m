Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050007;
	b=dxr4+Y1ap86T1lwgSs105mhTCixTvitKknH5J1BxTa9iNqzSrYjbDAqRkgE7JASyyZHT
	 rdrATp/fbeYD34STWHc+QX1s3Tzn2DhrJ28Bxcvv1PDXWvVpku11iOs53iRynjU2quDbV
	 jWIfdIG1kwv31n90YD7Z6pcKFNy7DhZM7rfqnZpO64mFPNEKGYnXNxxOHZV77nlX8otCe
	 hV4VkU1uLFr0PJ8rJYNm/j1Z/fMCfbKAtYnNftWqGsd9DJ8ix4HqabeFKEeOsLBecQE+P
	 uMiKUB1sxEte1e8ub9D0IyIyN3JSscEuE3khBFBGGh7/8N5RSx5w9wYJl3xCA8ru7eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zvmxVhP05DVJmoMNBX+bTXmPeyj/51GHdv64b23jjxg=;
	b=vX2iYdof9OPB3YqpxCi2lPGxhnOm4gAUpLOPpVgjg8RDHZnQjnYC3X1mUgIe7kRuWn8U
	 4nvhFBB8s4CUkY2tFdZPt3xBRB2P/bY1LKbC/YgMwDrT2uWHGKhFOuoOoWTd3MwVnYVR4
	 GVz/LvgG/Q+os1EDQzWgZhO3bRpo5h5xTcxLPo30RSN5Yvb/uoBfz4u7wXtVlxHkfRltJ
	 AkuiyNynU+WtGMT4qhRk1lJ0xYtCyCWT020S0sxwL29QDgmcfP7cV80U3JHbDDBUj8k/D
	 1seQG4DEPwkDXf29sHRybPQfkl6qLKMoLSqv398kMWm2/ZsCQZN0NwmM/8H7doFypVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtD5aUcJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA04606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtD5aUcJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B5C1F0089F;
	Sat,  7 Nov 2026 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050007;
	bh=zvmxVhP05DVJmoMNBX+bTXmPeyj/51GHdv64b23jjxg=;
	h=From:To:Cc:Subject:Date;
	b=NtD5aUcJ9baDWSlisV1lxbLBiOzoxjt4yO9c9IWTNDMEI9rB5LVqW6bQtH41M0QGY
	 Q0CXwmqdL2dd62XQXd7IVspyaZk0SO536Ip6bfqD3N7eA/kBO7WCzoA09DNnbz04fm
	 NLdLfStWyOt60onFsNuP+gaJ9ftkVTiG6Pux8OYcK53q8qPwZR0eMdhq4D7PgdrxSp
	 cPg48cKnF6EwSQsx36KzuJrRaxavpzww4gFfWMUgs5GMCUwCjlR3VhG3WW4GOh+kRh
	 HbUYm9i7o0nSMmBo5TazVY5Px6B4J33nZBj+mgl52TN7U+p72Uvt4luO9xBXzcHa32
	 EIL40qtMcFHSw==
From: Sasha Levin <sashal@kernel.org>
To: noam.d.eliyahu@gmail.com,
	pavan.chebbi@broadcom.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tg3: Invert restart quirk logic to restrict SNP power-down bypass" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:25 -0500
Message-ID: <20261107061325-failed-5.15-d7314b51341c@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d7314b51341c037973ce022f12c6009fd07b021e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061325-failed-5.15-d7314b51341c@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d7314b51341c037973ce022f12c6009fd07b021e Mon Sep 17 00:00:00 2001
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Date: Tue, 27 Oct 2026 00:09:56 +0200
Subject: [PATCH] tg3: Invert restart quirk logic to restrict SNP power-down
 bypass

Commit 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
bypassed `tg3_power_down()` on system restarts to prevent reboot hangs and
NMIs on servers where NICs were initialized via SNP (such as Dell PowerEdge
R650 and R750).

However, skipping the power-down flow globally causes the ACPI _PTS method
to trigger fatal PCIe AER events and hangs on other models. Commit
e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot") attempted to
mitigate this by adding an AER-disable DMI quirk table. Maintaining a
growing list of models for a secondary symptom misses the root cause,
leaving systems like the PowerEdge T440 (sharing the BCM5720 NIC) exposed.

Fix this by inverting the quirk logic:
1. Restrict SNP power-down avoidance strictly to
   `tg3_restart_snp_quirk_table` for the specific systems requiring it
   (Dell PowerEdge R650 and R750).
2. Restore standard power-down behavior for all other systems, eliminating
   the separate AER-disable quirk table.

For systems affected by the original SNP restart issue, their shutdown flow
remains completely untouched.

Link: https://lore.kernel.org/netdev/20251221175050.14089-1-noam.d.eliyahu@gmail.com/T/#u
Fixes: 9fc3bc764334 ("tg3: power down device only on SYSTEM_POWER_OFF")
Fixes: e0efe83ed325 ("tg3: Disable tg3 PCIe AER on system reboot")
Cc: stable@vger.kernel.org
Signed-off-by: Noam D. Eliyahu <noam.d.eliyahu@gmail.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://patch.msgid.link/20261026220955.473247-1-noam.d.eliyahu@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 48 +++++++----------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ce108705bbaf8..95827df4cf6a1 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18256,53 +18256,23 @@ static int tg3_resume(struct device *device)
 
 static SIMPLE_DEV_PM_OPS(tg3_pm_ops, tg3_suspend, tg3_resume);
 
-/* Systems where ACPI _PTS (Prepare To Sleep) S5 will result in a fatal
- * PCIe AER event on the tg3 device if the tg3 device is not, or cannot
- * be, powered down.
+/* Systems where powering down a tg3 device on restarts triggers
+ * NMIs and fatal hangs during reboot if the network adapters were
+ * initialized under SNP.
  */
-static const struct dmi_system_id tg3_restart_aer_quirk_table[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R440"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R540"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R640"),
-		},
-	},
+static const struct dmi_system_id tg3_restart_snp_quirk_table[] = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R650"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R740"),
-		},
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "PowerEdge R750"),
 		},
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "datto"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SIRIS 5 1U Server"),
-		},
-	},
 	{}
 };
 
@@ -18320,14 +18290,18 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	if (system_state == SYSTEM_POWER_OFF)
+	if (!dmi_first_match(tg3_restart_snp_quirk_table) ||
+	    system_state == SYSTEM_POWER_OFF) {
 		tg3_power_down(tp);
-	else if (system_state == SYSTEM_RESTART &&
-		 dmi_first_match(tg3_restart_aer_quirk_table) &&
+	} else if (system_state == SYSTEM_RESTART &&
 		 pdev->current_state != PCI_D3cold &&
 		 pdev->current_state != PCI_UNKNOWN) {
 		/* Disable PCIe AER on the tg3 to avoid a fatal
 		 * error during this system restart.
+		 * Needed since on restarts for systems in
+		 * tg3_restart_snp_quirk_table skipping on powering down the
+		 * tg3 device causes a fatal AER error during ACPI _PTS
+		 * (Prepare To Sleep).
 		 */
 		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
 					   PCI_EXP_DEVCTL_CERE |
-- 
2.53.0




