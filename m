Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1537F730;
	Tue,  9 Jun 2026 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995011; cv=none; b=cjaQkIRje39n2u7ds4H08uQp5WmyCnBtGOj3r7ROsZOW+Lw1cUMcNNlzqWkAPCD3jXtQvdHTfcnljT7jVFJQowfArjfUgp8FqYQhqonzon4xJ80bpA93igw1tPOjBy62JcZR75+/V+lNB0b7TzKZF5ULwYCwafeU4AIEGXRjDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995011; c=relaxed/simple;
	bh=ch6wgGiX+rD6eN6sGcu//35HJaHz2kUy5eNIIWaf1aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ommI3oq3EppPJchZyWiC4z8VqFhQpqBm6MY6f8li4Pk80+pRhcfWgVO90SxIyweevzcFprN4QzEyS3o8uGDXPhk8J9B493Os4UTK6mIGQHVgQKkc/jJiLmtXAL5BG71D+QawgbucEh28rmW1jMeFktMWpYAWkIDwM75JrfBLU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p6HYJalz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p6HYJalz"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LZ8PA3263305;
	Tue, 9 Jun 2026 08:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D7wYBVlzvA7bduDTdxaKO+5K9D780blvGci+nmL2Y
	FY=; b=p6HYJalzSwFKKUd9yOtu2Ckvu664hDa9V7m22OGMh/VbUOiKzPInzwXwc
	0v2ugpji+JND6JEVRa3x0mKUODazNfXRrM2fi3NamXT69aOy/tU1sdV70nHQl+NO
	xDEWjW3Wlqb6WCUWC1dq6iAuYIjFKQQTerFONQw/27+mwBhaKkkf5bDxXygpieaJ
	rpM47Oc60sFCoYVtFCTWwXLndljVi7neYb0hDBTSn+ylhbnTv3XtOm/4BXw+jGDw
	Oq148nyIJJMwaLW4HtKBEZ8Ic3ah9sV38Zkkotz77FXAtk9BU0tnsOea+LACth7n
	NA2PJa7sJXlE3Z44jeIT41CtLvEjw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhuar2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:49:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598ngcb011741;
	Tue, 9 Jun 2026 08:49:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1bxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:49:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6598nhKk35914194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 08:49:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6993620043;
	Tue,  9 Jun 2026 08:49:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE3D620040;
	Tue,  9 Jun 2026 08:49:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 08:49:40 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH v3] PCI: pnv_php: Add null checks for OpenCAPI PHBs
Date: Tue,  9 Jun 2026 14:19:03 +0530
Message-ID: <20260609084903.1352581-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OSBTYWx0ZWRfX8yXq33AH5/9x
 CCyBcLBcKpBfxCFP40BviSdutCZsOLQJ+aIo/D949ydu94I6ZeDUycPzob0u1SwAE6S1OkXZ83c
 L5foYyLqL5pQer4saNW/FUF/XS4mbx3ujGsvrZk83mHFIcxdwcYr7EUPuX+0YMWH/SLNzSBBrBF
 3tYHzN7ziJEjvKa3w4oWOIDY/Obb1bUvhcxhqWfEXZ3CkioBUQ8yQCjY7wrwE44K5R1EGoLsA4a
 XXVvcJ/6vk+GlkcVoSDdofL0wu0GC5ruqb5YlAblGo1aCAhcN5Uzvbhox0eZa9XgxAj7uBCoPYt
 Fe/hAjE9jwicvkHEDcgMt95shtLSGj3/jZkHULtqHVYikswf0dSecFPGk1+jadRGjeLXV0K8gcs
 /tTOaZYE+4vMKV7q2Jq0Y4g9iZN+WrfTbc9ichpNjZW7B4LgyeR8tDv5zz2Yld4jIf9hAPFEHjh
 seSTr0q1N6h6kUwQ7Uw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27d3ac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=2CTBcJULQSvMIThFTPkA:9
X-Proofpoint-ORIG-GUID: 8P9qn4Odz_P1EpWE5lpFtesQ6i3QH-it
X-Proofpoint-GUID: Tb46MgE-W5F1gSsm5wRxl_p9wYpho6Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090079

For OpenCAPI phb direct slots, the .pdev for php_slots will be NULL

Various sections of the code in pnv_php can do a null dereference and
crash the kernel.

Originally, the issue was hit during boot:

  PowerPC PowerNV PCI Hotplug Driver version: 0.1
  BUG: Kernel NULL pointer dereference at 0x00000074
  Faulting instruction address: 0xc000000000b75fd0
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
  ...
  NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
  LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
  Call Trace:
  [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
  [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
  [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0

This occurs for hotplug slots on root buses where bus->self == NULL,
such as OpenCAPI PHB direct slots. An added debug print (not part of
this patch) confirmed it was OpenCAPI:

  pnv_php: slot 'OPENCAPI-0009' has NULL pdev (bus 0009:00, parent=NO (root bus))
  pnv_php: slot 'OPENCAPI-0009' dn->full_name='pciex@603a000000000', compatible='ibm,power10-pau-opencapi-pciex'

This only required null check in 'pnv_php_get_adapter_state', which
caused the kernel to boot.

Even with 'pnv_php_get_adapter_state' null check, there are more
possible null dereferences pointed by sashiko, including cases where
userspace crashes the kernel, such as:

  $ cat /sys/bus/pci/slots/*/attention
  ...
  Kernel attempted to read user page (6e) - exploit attempt? (uid: 0)
  BUG: Kernel NULL pointer dereference on read at 0x0000006e
  Faulting instruction address: 0xc000000000a83334
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
  ...
  [c000000046707a20] [c000000046707b90] 0xc000000046707b90 (unreliable)
  [c000000046707a70] [0000000000000001] 0x1
  [c000000046707ab0] [c000000000acb00c] attention_read_file+0x54/0xa8
  [c000000046707b30] [c000000000abfbfc] pci_slot_attr_show+0x3c/0x58
  [c000000046707b50] [c0000000008181ec] sysfs_kf_seq_show+0xd4/0x204
  [c000000046707be0] [c000000000815004] kernfs_seq_show+0x44/0x58

Add null checks to prevent the null dereferences.

Cc: stable@vger.kernel.org
Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presence detection")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Changelog:
v3:
+ split the patch from v2 series, as it's independent
+ incorporate reviews from bjorn to improve the description

v2:
+ sashiko pointed out various pre-existing null pointer derefs, which
  can give access to userspace to crash the kernel, fix them
---
---
 drivers/pci/hotplug/pnv_php.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b8..d0f5e8ad1f71 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -47,6 +47,9 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 	struct pci_dev *pdev = php_slot->pdev;
 	u16 ctrl;
 
+	if (!pdev)
+		return;
+
 	if (php_slot->irq > 0) {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
 		ctrl &= ~(PCI_EXP_SLTCTL_HPIE |
@@ -414,7 +417,8 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 	if (ret >= 0) {
-		if (pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+		if (php_slot->pdev &&
+			pci_pcie_type(php_slot->pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
 			presence == OPAL_PCI_SLOT_EMPTY) {
 			/*
 			 * Similar to pciehp_hpc, check whether the Link Active
@@ -442,6 +446,11 @@ static int pnv_php_get_raw_indicator_status(struct hotplug_slot *slot, u8 *state
 	struct pci_dev *bridge = php_slot->pdev;
 	u16 status;
 
+	if (!bridge) {
+		*state = 0;
+		return 0;
+	}
+
 	pcie_capability_read_word(bridge, PCI_EXP_SLTCTL, &status);
 	*state = (status & (PCI_EXP_SLTCTL_AIC | PCI_EXP_SLTCTL_PIC)) >> 6;
 	return 0;
@@ -514,11 +523,13 @@ static int pnv_php_activate_slot(struct pnv_php_slot *php_slot,
 			 * fence / freeze.
 			 */
 			SLOT_WARN(php_slot, "Try %d...\n", i + 1);
-			pci_set_pcie_reset_state(php_slot->pdev,
-						 pcie_warm_reset);
-			msleep(250);
-			pci_set_pcie_reset_state(php_slot->pdev,
-						 pcie_deassert_reset);
+			if (php_slot->pdev) {
+				pci_set_pcie_reset_state(php_slot->pdev,
+							 pcie_warm_reset);
+				msleep(250);
+				pci_set_pcie_reset_state(php_slot->pdev,
+							 pcie_deassert_reset);
+			}
 
 			ret = pnv_php_set_slot_power_state(
 				slot, OPAL_PCI_SLOT_POWER_ON);
@@ -911,6 +922,9 @@ pnv_php_detect_clear_suprise_removal_freeze(struct pnv_php_slot *php_slot)
 	struct eeh_pe *pe;
 	int i, rc;
 
+	if (!pdev)
+		return;
+
 	/*
 	 * When a device is surprise removed from a downstream bridge slot,
 	 * the upstream bridge port can still end up frozen due to related EEH
@@ -1093,6 +1107,9 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 	struct pci_dev *pdev = php_slot->pdev;
 	int irq, ret;
 
+	if (!pdev)
+		return;
+
 	/*
 	 * The MSI/MSIx interrupt might have been occupied by other
 	 * drivers. Don't populate the surprise hotplug capability
-- 
2.54.0

