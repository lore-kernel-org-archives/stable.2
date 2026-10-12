Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB33EC80C;
	Mon, 12 Oct 2026 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802045; cv=none; b=ecFkS00Ho/+A9Zo/L0JGx9hXSKNaRX347KQLdw8LWFtSsov8jZ0OEfiRnNwlbZUhSibflvK6dnzqj8kWuQq6uGy1nSu4TNdaUF+wKKftj72PdnlTy1zNkqOMSN8PuQn3BK2MtX1bLX0RDGEqFHMFfelQQccxqFTW7LOd2aWfFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802045; c=relaxed/simple;
	bh=4jCsF+HnpTj1GBQ9R/KGveCDKHZuavbIuMsCx0ZYjeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4mPywMnVlvGW0vtgFjwe8Of6CmvpFR1MhyYxfapw4PcUQihSSTyisK5eGXx5drMFlyGi0pesarP+Zqnq6HjIiFqR+BbtlcMc76zUAtP5IMgBfEsUvlAIC6H9JakyATCMi+pEJeccUufZggQbdAHXNdxzTUQp2ernCipTHDhLKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IzQnCiix; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IzQnCiix"
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CAJ3MQ2652167;
	Mon, 12 Oct 2026 10:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=yFssUbg+7PbhDDHelDeXFwEBZQ7Staen6NBxl
	dvWVBg=; b=IzQnCiixMDFcLTNDXIcC6CnCBKB1VAHLpMFcgQ3j4Aiq7wm8Jfl3o
	5SG6RDCTKLuoPCSHu3S4ai6qMvgGMlJgt3ayrfpUc9YbPEuvV0/B9GAKNqkzbEvh
	+k1MGrA0Nq70v6sURTwwBJP6Fw6U43Ub3g+c0bSkrk+atqRbjqun7ewMkMrTmgC4
	MSz7oQbi7xpwqvQ/iU/bgTcp9oimWLbj4Wpmhchz1eTTOy2nKxxIDL78XKrZl6Xx
	3/Y3OyNpfWySLrWgCaKJarCa5i7zmPWXlAltI3D0KPjbPB8+pPItt//hqt82a0rZ
	5sAVALEx+MDAPekUup6pD3wWQcH4yWc9Q==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4h8wpn8bk9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:47:02 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 728FB804788;
	Mon, 12 Oct 2026 10:47:01 +0000 (UTC)
Received: from localhost (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 89A1380B0B7;
	Mon, 12 Oct 2026 10:46:46 +0000 (UTC)
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.liang@hpe.com, david.chang@hpe.com, s.collins@hpe.com,
        jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
        zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com,
        Keng-Yu Lin <keng-yu.lin@hpe.com>, stable@vger.kernel.org
Subject: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
Date: Mon, 12 Oct 2026 18:46:45 +0800
Message-ID: <20261012104645.975190-1-keng-yu.lin@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UdTE26SN c=1 sm=1 tr=0 ts=6accbaa6 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=ModqzXLkJJ0tFyq98apW:22 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=zd2uoN0lAAAA:8
 a=hKWmPlKVfKqGova5jE8A:9
X-Proofpoint-GUID: fD5YyRC0P02KIRcUstnaz6dlqCsYLiaZ
X-Proofpoint-ORIG-GUID: fD5YyRC0P02KIRcUstnaz6dlqCsYLiaZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfX15+tMj7HPMvT
 f7HaV5VIseum8b4H7O35zYZrsxnZeKwHbwFdj1cH/xVc8/1iZlPbiFO2RFzJ23v7zEDyfopHxJg
 q2pKTq7hxZ8M4Jfl+ZQlt2B0u0q9TTM8JqC7k/HEct4GsaVBNfa6NEtGukVS7+NOyGTY+lL966C
 gy5hzuM+5KyfnHs5zojwCWMtfuVvefuLF3M0sQLsyYKZske0XK8oVbEHLCVG9rZumGxZdRGWvjY
 0LaikthGzRb6/XY5w3QmdR/rnApKhtmZtyfSCezerQjp4CSIs2/HPNEWetPfef0HG0hafeRdFAw
 /bcDs6X5+PWpjaw8h+weGDkWwtweXUXjGmedezmiO86USjIoB2jm1HY9+g5WepUqAqz6Y6GTrqS
 0NMjYGB5qljZPBXyZ6mdPmtKdhT6iGMl6xZypQjZutS5cR0hBJ6LK6EUXmwptPqEO/3hUiAhxXd
 FD0e4bBVTsUJ7gOCOPA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MiBTYWx0ZWRfXyY0l77CTSRxA
 BVNxW/knN93Ad23VDdxbtAYDVeooqkvqYRdrufjnhZdQNnVtQp8H7GxPKDpg/YoM0tjppk5zJ9u
 tHP3zVj/7Xi9U5wBb/infcd7nerJe4c=
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120042

Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
The helper ignores pci_power_up()'s return value indicating that BARs
need restoring.  Its resume callers restore saved configuration
afterwards; pci_pm_init() does not.

D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
After enumeration powers it up, pci_enable_device() reads D0 and skips
the full power-up path.  Previously, a device still in D3hot at enable
time took that path, including BAR restoration.

On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:

                                   PMCSR      BAR0
  before the platform power call   0003       f4100004
  after the platform power call    0003       f4100004
  after native D0 power-up         0000       00000004

The upper BAR DWORD stays zero.  pci_power_up() returns 1, but the BAR
address remains zero while dev->resource[0] still contains 0xf4100000.
Without BAR restoration, the last console messages are around:

  pci 0000:01:00.4: enabling device (0000 -> 0002)

Restoring both controllers' BARs gives matching readbacks and allows
kdump to save a vmcore and reboot.  An AMD Turin xHCI [1022:1557] shows
the same BAR loss; restoring its BAR also allows kdump to complete.

Use pci_set_full_power_state() in pci_pm_init() to power up the device
and restore its BARs when needed.  It already checks the native power
state before restoring and updates ASPM when link state is present.
Leave pci_pm_power_up_and_verify_state() unchanged for the resume
callers, which restore saved configuration afterwards.

Read the initial power state first, as pci_enable_device_flags() does.
Otherwise, PCI_UNKNOWN can request a BAR restore even for devices
already in D0.  Keep the final pci_update_current_state() call so the
final cached state still accounts for platform power and failed config
reads.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Cc: stable@vger.kernel.org
Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
---

Changes in v2:
- Use pci_set_full_power_state() in pci_pm_init(), following Mario's
  suggestion to reuse the existing BAR restore code.
- Leave the shared resume helper and its interface unchanged.
- Keep the initial state readback and the final platform-aware refresh.

Unlike v1, BAR restoration uses the full helper's native PMCSR check.
It also updates ASPM when link state exists.

Tested v2 with kdump on both systems.  Normal boots made no BAR writes
from this path.  The crash kernels wrote only the cleared xHCI BARs:
two on Venice SP7 and one on Turin.  All readbacks matched.  kdump saved
2.53 GB and 1.10 GB vmcores respectively before rebooting.

v1: https://lore.kernel.org/r/20261008133708.947908-1-keng-yu.lin@hpe.com/
Review: https://lore.kernel.org/r/04f5463b-f123-4079-9286-06a241976d3a@amd.com/

 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8cc6a89130b5..d3a5871e1b36 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3255,7 +3255,9 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 poweron:
-	pci_pm_power_up_and_verify_state(dev);
+	pci_update_current_state(dev, dev->current_state);
+	pci_set_full_power_state(dev, false);
+	pci_update_current_state(dev, PCI_D0);
 	pm_runtime_forbid(&dev->dev);
 
 	/*

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
-- 
2.43.0
