Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714835B636;
	Thu, 15 Oct 2026 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030114; cv=none; b=cDoCnRFlQ1HY3nJRREWqzeYWbX5oDYnl4ePGiR/nPgxmW7WZUZykGCYiW4xgdtmTs03s5nX1ziMn0qLP2rjdCEGtHRYO2FQtDDCZz7hAxdwcQmZve3Tfh0fxwaTCZnodmjWbIdJEghF9Dg0uVmg6lQkK4RncP8Pc8fjPCAdH9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030114; c=relaxed/simple;
	bh=3amoQ/nTDDT0GppKteMx3dDiNVlSCCJkByPmLJlllAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaYHvuYT7yKyCbu1LL5iw9fQ5k0g7lV23rEnk4pZOl4yaulE4u754d0czW0XfAXrldjtphSuuMeApaVMjx3v48jQUkivSiuWtSXzwHGtoqb3/Ra8XcxWFy4vyf12k69qO3dweauLzhp588pQtuhO6oD9Yu6Jns9okcPgzC3+qfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Ec3l3J4P; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Ec3l3J4P"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EMlx4K291910;
	Thu, 15 Oct 2026 02:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=pQKKzdPUbCuLMTwWuQwUh6R8DjxNyBGSOBCVk
	XtcPss=; b=Ec3l3J4PoXouptd9G9unF6wN9y5dQ0NV/c9hIw1qEs5A687D/lMbd
	TtnaojY/Sy8d3vNSHAZsjLVD4Z1lrP9Xmmc+inVg+Gx3n9k38CMj/Gv4XGp+1S1r
	+bxLRNAcxsA+eASba2NTAi/6f2m46jILYE2okFdT/sUejKgKX4KNGd6lGoMp3/p+
	TVL1seNs5eX3HWf/6bM+6KkLy0qaep8KaeJQ3kigok81kvaxw1LTAQjTa6noaXoY
	NNyaRHyLUu9FqfNSvwmrPbWqEaRRZQK8124hjobHOeqnX6lUjBeey0d/P9iEA+wc
	hqyO9xAd468r7W4A6yX6w/wD3gYl8YnlA==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4hagcw3yrq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 02:08:20 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5F0DF147A6;
	Thu, 15 Oct 2026 02:08:14 +0000 (UTC)
Received: from localhost (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 66E25802827;
	Thu, 15 Oct 2026 02:08:13 +0000 (UTC)
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
        s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
        zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com,
        acelan.kao@canonical.com, michael.reed@canonical.com,
        desnesn@redhat.com, dlee@hpe.com
Subject: [PATCH v3] PCI/PM: Restore BARs after powering up during enumeration
Date: Thu, 15 Oct 2026 10:08:11 +0800
Message-ID: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwOCBTYWx0ZWRfXygKE1RG9EqoC
 NN/+UCLL7rNFN6CR+ONMlk2lqz4pz2r8spSzQdeP01CMuwyL5be9sDfqjJdgnwWdKvj4pQS0QoM
 n3uDhHprTulJPoRme7HMkC3IWKHJ04/EMD0wXjdDtri4RRJ5Y5F5LMpvbifRdOHw35DKCiGG/CA
 PkoYhJWPSiUnGdhwI55HedKjMc0+V+VehyVz2EfygQplGhzrb1EbOEYoYHGIQSwoJf1HurFHr2Q
 LnfuX2Tl/jWKmRavTBwrraaj4Y+ifOiW6fmAkbBA2+eygN+pOXjDjBLeMBepG4ItADoci+Me4TI
 zqDy1kikGsMc2GF5yjTWJsn9NV0XPOR0JxEGH54V3cJ8DsVcBUPXQpHoFQjkG8oP1JGaRT0xIKR
 X8cUZw9W5KmATIsVhLvLvDcEBlu7hnHIxDOBQ81sCza5nyBDX+6Gnp3c8MPRqPZ6pffMe67bHv5
 Lt6Hly4iZJIHlFRzjRg==
X-Proofpoint-ORIG-GUID: LFzXPdcYKUW2NKXheocSpQM8GolQ5Qpy
X-Authority-Analysis: v=2.4 cv=Wuq+otfv c=1 sm=1 tr=0 ts=6ad03594 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=MvuuwTCpAAAA:8
 a=zd2uoN0lAAAA:8 a=QxgImIibHiPzE-hgDXAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwOCBTYWx0ZWRfX0vojc6ZCq/XX
 2WZ3B1PzWTm0pPeeYwP9Mh4unXF9lyDe3RFgULkRZAfrZiKvYKutkBC7ZOl7a2YLnVAIHY1TIhm
 Z4HTi1Hso0AT/lgyHMgopd1YSTK1324=
X-Proofpoint-GUID: LFzXPdcYKUW2NKXheocSpQM8GolQ5Qpy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150008

Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
The helper ignores pci_power_up()'s return value indicating that BARs
need restoring. Its resume callers restore saved configuration
afterwards; pci_pm_init() does not.

D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
After enumeration powers it up, pci_enable_device() reads D0 and skips
the full power-up path. Previously, a device still in D3hot at enable
time took that path, including BAR restoration.

On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
D3hot with No_Soft_Reset clear before kdump. Diagnostic reads on
v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:

                                   PMCSR      BAR0
  before the platform power call   0003       f4100004
  after the platform power call    0003       f4100004
  after native D0 power-up         0000       00000004

The upper BAR DWORD stays zero. pci_power_up() returns 1, but the BAR
address remains zero while dev->resource[0] still contains 0xf4100000.
Without BAR restoration, the crash kernel hangs during boot. The
last console output includes:

  pci 0000:01:00.4: enabling device (0000 -> 0002)

Restoring both controllers' BARs gives matching readbacks and allows
kdump to save a vmcore and reboot. An AMD Turin xHCI [1022:1557] shows
the same BAR loss; restoring its BAR also allows kdump to complete.

Read the initial power state first. Otherwise, pci_power_up() may
request a BAR restore based on a cached PCI_UNKNOWN state, even
when the device is already in D0.

For devices already in D0, only synchronize the platform state so
that ACPI calls such as _REG still run. For other states, use
pci_set_full_power_state() to power up the device and restore BARs
when needed.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=WWOQjDAPmSepSAQPg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
---

Changes in v3:
- Use Rafael's sequence: sync only the platform state for devices
  already in D0, and use pci_set_full_power_state() otherwise.
- The D0 path no longer runs the full helper's ASPM update.

Tested with diagnostic prints on AMD Venice SP7 and Turin. Normal
boots made no BAR writes from this path. The crash kernels restored
only the cleared xHCI BARs (two on Venice, one on Turin), with matching
readbacks. Both systems saved a vmcore and rebooted.

v2: https://lore.kernel.org/r/20261012104645.975190-1-keng-yu.lin@hpe.com/

 drivers/pci/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8cc6a89130b5..895969fe4520 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3255,7 +3255,15 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 poweron:
-	pci_pm_power_up_and_verify_state(dev);
+	pci_update_current_state(dev, PCI_UNKNOWN);
+	if (dev->current_state == PCI_D0) {
+		/* No need to do a full power-up, just sync-up the platform state. */
+		platform_pci_set_power_state(dev, PCI_D0);
+	} else {
+		/* Power up the device and restore BARs if necessary. */
+		pci_set_full_power_state(dev, false);
+	}
+	pci_update_current_state(dev, PCI_D0);
 	pm_runtime_forbid(&dev->dev);
 
 	/*

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
-- 
2.43.0
