Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046550;
	b=bOGgH+0X6u0cF4uuoDDfQ7IkXlIu9qkg5+XOcq152GoLiFvsjsl/4SYP/Jinkra1s5JA
	 QUhsg9c91aFFJynBmGdIQQZYsj0jil4neWAmoM57qiqB4YuMmpy5ZFj/614BOB23nt1ir
	 G+FBiPtoMp9FqbyRlLsJs7s3A6Zu0QnWbqux1VWHEp/tkbNW22mOsmRJJQp5obHgZ3kz8
	 npLZVI7GJ+Rc5DZ9trGnl5k9xoTSqWMG8vSy1VLLqtWrHc0BWJOME8MIhKK2zDg+P4Lp0
	 SdtOpXkL46EQ4utZQ2vX0QWKMUXrZKh83mG1RWgh3Ox86VvfxjcBRk+YAMRRjj99Cvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046550;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Icsh7ibZCZCrR/S6gArHp4jXfe5TongIsfzJIGWpcuw=;
	b=WFYACQqdaRYFuhRXkqun1xPvu7IeqbkakCNCAlPOzxBgj1VmagHCaetUjYbJX6BNJ3hd
	 coH2RiYIPZyGRH9NiI95BcKnDYy0kRuhnvkTPc1qYKOct/NRrEXg8e2shSeAIRxQHAy4v
	 7zOET/byzCjg2mOThUgXc/gJrkLPo9O8INvh2l9vzQUR+qV9OXHKc20DyB0jMGCAWOl5k
	 UrWEnW1BMAR5mpHJJzsL2/f2IuioJ/Jo4aKkmOfOT5knPZK6nRGmaQ+8LM+7FUpdVL+eB
	 QBYaYRbn69jgvQP5jyOpbE+kGZjzfKhhoR8GkelDoQmkJr5HiA1Sgp9thpPTXCsxYvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqiE+X69;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E19606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqiE+X69
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0431F0089F;
	Sat,  7 Nov 2026 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046550;
	bh=Icsh7ibZCZCrR/S6gArHp4jXfe5TongIsfzJIGWpcuw=;
	h=From:To:Cc:Subject:Date;
	b=PqiE+X69J/l88vGeZ/RXQdRl4R+XD2823bs/97H7x4FSnldqBPPD7X0DfhOEmlIj/
	 tMu5D9kMjC6k8smpuu+q/uo7Crwy0Gp+sHt1Pv9lF8QbMYOAoXblmiKyzIhY74ViIy
	 BZMKva0Wy2Mzl/Woj/esolsqWQ/SuqeAvGbde861HwNT3/Ddi3zWyPziCwKLh8CxJe
	 nCGSQRwo2rFhC2iACVDccB3noNiUsYFyXmRlY9en8K4FRF5F6islv5WmP4oiRuhdyL
	 1Ca0NrbNdfUXfrL5YeE9c8u0o1jiYjGNgzTnFNXE9NdVcEkDf9OKroSenc5Y7mOWmp
	 dI4kTiTxX7cpg==
From: Sasha Levin <sashal@kernel.org>
To: noam.d.eliyahu@gmail.com,
	pavan.chebbi@broadcom.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tg3: Invert restart quirk logic to restrict SNP power-down bypass" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:48 -0500
Message-ID: <20261107051548-failed-6.18-d7314b51341c@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d7314b51341c037973ce022f12c6009fd07b021e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051548-failed-6.18-d7314b51341c@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




