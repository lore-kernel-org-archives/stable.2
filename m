Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F47379C4E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130322; cv=none; b=c7Pg1+lheXYTea6+J9PAKK37LnyEfKZIsBi3kvxilztPddzRNad/Ke/o7Dt/JhqkonHIKfl8F63K8IfrZj6qAtwq+Mz1auFSqRjtBfC6oZ9ZP3FmgRj2k4fmm4HZ662DB3iaU/l/CC0JR+Dzt8AnEp3y1XbEKaK9uhkbBxyM76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130322; c=relaxed/simple;
	bh=g5XxiDFghNFRNW5IZuQbEjg3YtPgkCJzRoomlBMAd5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+o6I/w7/a3yAC1I5ZCr9E2lomWCsSlDrMtqMzd04GqssV2ovXTnZOYJsCiqKp9Ehw/rB3G/BzG73Q4GE4YTWWIPST00yYy6uDHOzRPSVfSDQwb2OwalAmIUl4HVZwvhF4zaSfZ2WBNwmtmXq/dEk1Zb6+JybbJcuXrsmfXc3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRXZCerT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRXZCerT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-141a5d476abso11939c88.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130320; x=1790735120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OW8pONdYaJOrcraRgR272mPtvH+JxyXPDb9LA5IdPHg=;
        b=YRXZCerTNuNPOuZkZCXN/McoJmBVe19ihdI3AeGt3634LRZa8Mf3VDeLVL+Q30JW61
         LI1sOMmXsrbXouFz10DcrIDU90FJoi/6QaLMe6odwETrvjK7gMP3Xq5S/C99l6jQlJn5
         zBR4Dg+R9ItyFh/lfn4OHYxrFAWrBAw4gGO1Wx5bwrSUON0FlOXfiUdPKZ53c5cumbR2
         dEiVCjapPq3kT9mtAUWrW6Bx2Xide+9yVuDNQj6ktRhVSKWBhr7fJbxSg4K8hfRtgG3t
         aznR7cWgZD18oWg7aMRAWYp+YNg+2son95hXryjDQDT+sq32/UJozmUT0RT55w2SL99k
         axJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130320; x=1790735120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OW8pONdYaJOrcraRgR272mPtvH+JxyXPDb9LA5IdPHg=;
        b=eSBMlj3iQtchUDWgGHMl6o22Ad2UZPwLjdMeQWPrthgnLzfD7hUQaHJMt+Ki0vwQ9w
         1l7EanE56YnsrumvoP0zd4b98OqMNtist1I5XQ0amkbHQJpnvhGFpYNIr2o9+Wbjje5U
         B97EdeQgebB2zwlGVNcSGB2OZ6dGgDbwADiVPeYBs6wUuTbQ8FO94hZy1umcdSdQn5ls
         8NtApYWjUDFmur+evzyD3H1r3ZTwbqpprFeO5wKF4+i95KX8qOPiVkZ0Np7jY6L+Z7ff
         zssVRNwXE7fRah2wLK6JQe0+OkjmlJbvkupqjsZdw/LEGfTM5JYvgmh/jNwnG2YhPREe
         6HGg==
X-Forwarded-Encrypted: i=1; AKwUvByuxkUy0UC11Dt4FVkpZIsLmVHKbvT2E2+UlEfsuSwMF2LxNXbIiSY42PGUDlUeQlxvSB33WCw=@vger.kernel.org
X-Gm-Message-State: AFuF++lMeRezbMacJV2h2PoaSqN42BGCLNZ5E9TKHIOeMwCB0X2lyEXF
	52qB+9y2/P0efvtKVVskuhjycEs/6h2R7rF2WV8ZR8qQnG4Ag6gkxecvfPdYkbFd
X-Gm-Gg: AYBFou0Pt1juB9KdriLfUaPvyEf3hsLmDLaDSmtUg+Zt1s0IV8zx3V3Q+VDTR1bN59U
	5DHMOczz1pdGv9dhw8JbA9i2YPNDNsUbAwMs4euBH1fKjA4U8LpomWFxbA0KTjUQHr3S6ivZU/k
	CCnlGJB/E/W+pCK2wVx4Lu5WrmjDKX/zKDLb1JfgOI9CwFcwk33X0YppNrGeJUHTNZZigHBBc3X
	l2xUc6GRhj7nqMA4CEYEo+dliyJ/j7EZ9PfIuZKcMrbEtykgZEnb3+lNpuCKlxVHVwbCnY+ISx4
	pobKuE6dgK+DV40dLwih0a+bGepQf/KnLM55GtK9cPNOjbjUtecwLTsoybbuIyv4bcDrJQFIgft
	1vinH1XW80IZ8M4AKZsSFzafiy7Ohd5tnzid04pnpvCpg6pDPgFgkO3rOEce30+PNZxaZUmrN1Q
	upvXYX6GMThipzRiqke8izZ6ggPaiv719VGURl/mZAyr132UcCuvqmY60JrWt0TSm4B6CDypdp0
	xXmI6DOGkv1LPCnyN4yANHylfcid9scopZt6vVlKCtXi54/UsR/VN3RXMnAMI7DYMJqSV3FALtn
	9U3O+z0SfQcpWjcJrw==
X-Received: by 2002:a05:701b:4508:20b0:13e:5a51:148c with SMTP id a92af1059eb24-144f9002ab3mr1914745c88.0.1790130319575;
        Tue, 22 Sep 2026 19:25:19 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f983c5a1sm2972435c88.7.2026.09.22.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:25:19 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI/PM: Skip the suspend_noirq config save if runtime-suspended
Date: Wed, 23 Sep 2026 07:55:11 +0530
Message-ID: <20260923022511.24932-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_pm_suspend_noirq() saves config space unconditionally when the driver
of the device has no PM callbacks, which includes unbound devices.  If
such a device is runtime-suspended, the bridge above it may be in a
low-power state with the link down.  Depending on the platform, the
config reads then either hang the CPU or return all ones, which overwrite
the snapshot taken at runtime suspend and are written back to the device
on resume.

Skip the save if the device is runtime-suspended, as pci_pm_freeze()
does, since pci_pm_runtime_suspend() has already saved the config space.
Use pm_runtime_status_suspended(), because runtime PM is disabled by the
noirq phase and pm_runtime_suspended() would always be false.

Fixes: 931ff68a5a53 ("PCI PM: Restore config spaces of all devices during early resume")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Found on a Lenovo Yoga 83KF (Arrow Lake-H).  A driverless O2 Micro SD
reader at 57:00.0 with power/control=auto lets its root port 00:1c.0
runtime-suspend to D3hot.  The port then swallows the ECAM reads in
pci_save_state(), and the forward-progress watchdog raises a fatal machine
check at the ECAM load in pci_mmcfg_read().

The same port returns all ones for CF8/CFC reads.  A local quirk hid the
reader's extended config space so the save did only those reads, and it
was tried once on each kernel.  The unpatched kernel still died, and the
patched one resumed with no "restore config" writes for the reader.

!pci_dev->state_saved would only work for one cycle per boot, because
pci_restore_state() clears it and pci_pm_runtime_suspend() does not run
again for a device left in RPM_SUSPENDED.

Stable starts at v6.19 because the fix relies on a2f1e22390ac2 ("PCI/ERR:
Ensure error recoverability at all times").  Older trees still return
early from pci_restore_state() when state_saved is false, so a backport
there also needs "pci_dev->state_saved = true;" on the skip path.

Tested on 7.2.5 with the root port in D3hot, three suspend/resume cycles
in one boot.  The unpatched kernel dies on the first.  W=1 and sparse
clean.

 drivers/pci/pci-driver.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e16aa59dd..bdc8bad57 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -915,7 +915,15 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		return pci_legacy_suspend_late(dev);
 
 	if (!pm) {
-		pci_save_state(pci_dev);
+		/*
+		 * The bridge above a runtime-suspended device may be in a
+		 * low-power state with the link down, which makes the device's
+		 * config space inaccessible.  pci_pm_runtime_suspend() has
+		 * saved it already.
+		 */
+		if (!pm_runtime_status_suspended(dev))
+			pci_save_state(pci_dev);
+
 		goto set_unknown;
 	}
 
-- 
2.55.0

