Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B34A49A0;
	Thu,  8 Oct 2026 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791468564; cv=none; b=EXo1s8hKazPNmTsYXYnLbt/HmlQP7ZqHriUlzsNuzoBfrzm08Tou4kYtav8oneNoLTCN0xnRhcu+wBo7J6uJ1MG5ND6SvD+JEb/XuUS4tMwy7nVXt8H21J7k5pfD5XK0RH5kjSRTjVbySn7oLqI/uFzMLfr8ot0+4gQ92G3idTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791468564; c=relaxed/simple;
	bh=tJKIYvZkt9I7Pd3RilsLEM0QUAe4MX4C2zadXoQbjmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rie+WwvILm6de8OAVUlgrrgAlexG+JkKgmxqeXRmlnkQ8kFEH5d2t3frLAUqZz7K2YN/MS2tTTUPzoBkiiRK/vPqvcbgOFPoEeD0Ck5gEIJLW9D89eTEVADYwgZXxfmRstkLzL8rukCeLTkfmHctotl37iWD9uN5SD1HlndnzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MNdyV1Xv; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MNdyV1Xv"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698BLfCO3007741;
	Thu, 8 Oct 2026 13:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=9UWIQfwB1lSDMWilAtw2HlQHofHeEMlNpb6FK
	sHgq9E=; b=MNdyV1XvcAcTot7w0vUXC5dyhHVnkKDicnu+0DYJGa6B21qhOmh/E
	C5tTVEODPiznME470D9hGY/QBEbv+SNAEsbNKz2RS8kEroK4jRmmrYw54TASALg+
	WNLtxfiTXc+U9Jg+34sTc8I3snoteB7jsmHnKdFGqp6zOohUfTlVwh1uLU0IwswL
	Zf5G5jCBm81UrkG7V7wngqdtVKWjtSNu4BNYJevfwLBIbXswJi6A94qhDaUcFiEk
	JC9oKTJ2OeAv7foMD13okexb31B0rKt4jzU0EizsW+GtGX0GS19lPBrARHoPfYIl
	plTgclNV9zyZsuhqDXgbgUxefNmdkx6xA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4h67v33x7g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 13:37:25 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E65AB804782;
	Thu,  8 Oct 2026 13:37:24 +0000 (UTC)
Received: from localhost (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 3A55B805E5B;
	Thu,  8 Oct 2026 13:37:24 +0000 (UTC)
From: Keng-Yu Lin <keng-yu.lin@hpe.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthew Ruffell <matthew.ruffell@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.liang@hpe.com, david.chang@hpe.com, s.collins@hpe.com,
        jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
        zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com,
        Keng-Yu Lin <keng-yu.lin@hpe.com>, stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Restore BARs after powering up during enumeration
Date: Thu,  8 Oct 2026 21:37:08 +0800
Message-ID: <20261008133708.947908-1-keng-yu.lin@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1MyBTYWx0ZWRfX8laSg/M1HYKc
 KzAqDSedTteprjNlPKPObkU8NGZGSYVycwyc7LgJUvIGQyTYaS571VJlPyrk6hvYmiYQKJLUfWb
 9OnrxNzHB1hfjddwAz8fD3lJxp3ooTpaEh1QBQVedUrKNXaI905fLZH3pebSR4AoQZse9vuoZ4/
 qTCiA2fbGCHBx1V7ZHj5gpeEvVaRpgS8Z5vRW7Iv7M3FDiHjwIAMlQBHD90dTzl0UZ+MReIzvfs
 gIVBwHp1DFKaSAw7nRqO9z7E9B7AXRPCn8sR5eLo/92BuiCctH+rVDkXNxTW4fZgzYYGEN0gh8J
 t1HAKPJkaC0H83hBZbwSLwtusR/RJPZS23TvdcVvWKHc4PNOvKjokI66Ja8+RRA+EDWue2eaKO8
 VTgjZJakrb/uHWvKcbC4j0DLyfhFcRnf8zRGshaZD+hyAtB769nfNom/pN/oUFwZDKUSDNHaDIv
 4YBiREL6NDVkiFp0uGQ==
X-Proofpoint-ORIG-GUID: Dtbi9H07u2ej6c1p0k85xEXhj8pif0Hx
X-Proofpoint-GUID: Dtbi9H07u2ej6c1p0k85xEXhj8pif0Hx
X-Authority-Analysis: v=2.4 cv=IPmXmQvG c=1 sm=1 tr=0 ts=6ac79c95 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=J0OTuHAx6l5K1fCpvPfz:22 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=dSG_NjvMcWhgSEuj-ZkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1MyBTYWx0ZWRfX9V8vu7O2txu7
 BaLmm5pQfgimIbCKVaGq7Amy6nhRSAk0ZVPLq7uSJPxGqr2GnYYZrqfHHEnDbONkBUrp6Rq4Qoy
 GuUsYmDM6jdaI8Qa7oK/q3BKPktfd7I=
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080053

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
Without this patch, the last console messages are around:

  pci 0000:01:00.4: enabling device (0000 -> 0002)

With this patch, BAR0 is written back to 0xf4100004 and reads back
correctly.  The second controller's BAR is restored in the same way.
Both controllers initialize, kdump saves a vmcore and the machine
reboots.

The same happens on an AMD Turin server with a different xHCI
[1022:1557]: the crash kernel reads the controller back in D3hot, the
D0 transition clears BAR0 and the restore rewrites it with a matching
readback.  kdump succeeds there as well.  On both systems, a normal
boot performs no BAR writes from this path; the only crash-kernel
writes are the cleared xHCI BARs.

Pass the restore-needed result to pci_pm_init() and restore the BARs
after confirming D0.  Read the power state back before powering up, as
pci_enable_device_flags() does at enable time: the state is still
PCI_UNKNOWN here, which pci_power_up() treats as a possible D3hot entry,
so devices the firmware left in D0 would be rewritten too.  With the
readback, only devices actually found in D3hot or D3cold are restored.
Leave the existing power-up and platform calls in place.

Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Cc: stable@vger.kernel.org
Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
---
 drivers/pci/pci.c | 14 +++++++++++---
 drivers/pci/pci.h |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8cc6a89130b5..f34e4d259151 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3181,10 +3181,13 @@ void pci_d3cold_disable(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_d3cold_disable);
 
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
+/* Return 1 if the BARs have to be restored, 0 or a negative errno otherwise */
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
 {
-	pci_power_up(pci_dev);
+	int ret = pci_power_up(pci_dev);
+
 	pci_update_current_state(pci_dev, PCI_D0);
+	return ret;
 }
 
 /**
@@ -3255,7 +3258,12 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 poweron:
-	pci_pm_power_up_and_verify_state(dev);
+	/* The restore decision in pci_power_up() needs the actual state. */
+	pci_update_current_state(dev, dev->current_state);
+	/* Enumeration has no saved config space to restore afterwards. */
+	if (pci_pm_power_up_and_verify_state(dev) > 0 &&
+	    dev->current_state == PCI_D0)
+		pci_restore_bars(dev);
 	pm_runtime_forbid(&dev->dev);
 
 	/*
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc2..96af0f1d081c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -277,7 +277,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
 void pci_dev_complete_resume(struct pci_dev *pci_dev);
 void pci_config_pm_runtime_get(struct pci_dev *dev);
 void pci_config_pm_runtime_put(struct pci_dev *dev);
-void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
+int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
 void pci_pm_init(struct pci_dev *dev);
 void pci_ea_init(struct pci_dev *dev);
 bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub);

base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
-- 
2.43.0

