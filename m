Received: from mail-pj2-f33.google.com (mail-pj2-f33.google.com [74.125.227.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768A3876C1
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 05:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789708431; cv=none; b=dmVBUm6iXWm2FZhcNBzg3QCE65vtoaJpSF4PpY8JSxl9xdJLk67f7uhK/9WPhqcCNhJi1xydf+fhiYA8QaLvBPyng42Ynb2yNguDcTDZcwyUhe23fem578tYErqhcNdZ5LaTe9Z5qZF4fdILcsnaGGoEWvHU59Y6yBhB+iS/2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789708431; c=relaxed/simple;
	bh=ulA5Ml9aBNWFkPyTYzxj3umiIvCtlQZWCthJVuYoA7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Elq8/6kifPjZyYRPoFjbG81MW19yG9WyENdK9jKwP6oS8QcSeXpp2FXCjGkwWpi7ab4LAaTr7s5h7Np9yUDmL9JnV3qm4cAtuzL8jkfrAu4ffrYaGEZQjdowYGCVsKhffDfDwihdWjVhRsiNd7edHwlCif0w5AUm4i71A5vYvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKZmIX1m; arc=none smtp.client-ip=74.125.227.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKZmIX1m"
Received: by mail-pj2-f33.google.com with SMTP id d9443c01a7336-2d747ed1368so4162315ad.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789708429; x=1790313229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fD5FYGWqbEawclsuAKqnAhQHLJbtl85EqSDEc6sInv0=;
        b=iKZmIX1mwH3JLXYBvSi8YG5x7BBNqBVvoZKDDAIiYkpWKpEx79Dpd3/JBv/FHfm3IA
         OF8j3bJxEP0tp4pWHq1p8eMEkTcoacBQRehcxJY+f+2thtyiwHWUwO1yRf6C47wJLceO
         i3AkWyaxCD9TnmNvPt4gSRlPPk0HA12WbXSPm79w1ZCzgmN2ZmPnbnRadP/GUUzh7hcE
         PeC60udJ0jkLxdE7cKzEjLFk3QYRyNEx9iPNoFjhXe9l3l3q0C77d1SU3I8sFvUd5Hxt
         CE3wuHYYLkKurPLvp8bKhQWB4CPkdHrYrszHgkqETv+iT4efGpzN3/y+ZLzTKHPgfYDd
         aSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789708429; x=1790313229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fD5FYGWqbEawclsuAKqnAhQHLJbtl85EqSDEc6sInv0=;
        b=ubx6IHsqYG+xphJDXA5jkSEyScJDDtG6tOb89E9kSSMn+g+80apzKUgTWDtfOBQ6k7
         vzEGNfuolBM21hE+iBrrS+BqOD7IDaMAV7mW31rqnv10WQ6WtgZsRErhH6tPMOXseHjC
         SIT+I3sgR7qoL7jKdIYoVMWU19JusbTkthgPtcHVlmOVzIVd2Pu0wY390Sg6CGM2av5H
         AbhRp2fa6LVVRycPblJiS9TLfWBTNZCkHvjk1vzBE7WfGgoQpGKBY8yOgsH9NyH8H7dd
         rip99gqAZS9GFIYoUndLgL5RyDWAUhULMh5ztAef/cerzSh9HjtQCPJXuHdSfIpu8HAs
         N+yg==
X-Forwarded-Encrypted: i=1; AKwUvByA1+01yVU8iX3UBZAGKbw8L0zp/FLoA+JpnpaeOCbtDWIxXaFBeUFQ4YBHz2prp6fFlHeN+us=@vger.kernel.org
X-Gm-Message-State: AFuF++kE+tzfkDWsVLAmfnBWhfT6PHlAr7iLEx7O4tDse34JsTDst7Hk
	AlcPonF+PJxjwiZ06pwjWXOnPrsHtNaHZj1wM2ZrQXcTlkxLKGOqLmdT
X-Gm-Gg: AYBFou3qINWJ2Q4EXtLoEDGXpZFuYn4Cwu5DccECaLC2XIPOgs44qO+8Cx/yC3dNRjB
	J6AY8ACmdLWGfiHCIUI3OBKjfC+Kg9OiZnRpntlp6E8JKSuYbQA8Ku3iTqWx3y11jDI2sMV2jM+
	Co5hjMMskp9KOMYHxyKZPjh5GT+P3VBwM0hm9yD3KPkbQ7Ozl2DjambzXDfjG8Tf1VmkmVIPIxb
	dXNJRZeQ21z3r7GExc5goq0ezNlJjcti84jlkDrFHeBrZ0HuFrXhg+d6wGpGP4QEMx8sR9DEp7l
	ZHRupdIU+DNSHOROFWn5ATpJMEi7jzN22pvR/xv9AK0QsoYcvIUZDIjkD1F12T5QHLKDuAEjciy
	IF2t7/5ZHgfwxjZsxvzQAgQ4xf+PzuXD4dCZaSeARmcUXyamsy7bU0/aNx9vfL5EA1h8RnhbB/t
	SGhtVlmFsX8k6Qj9Mn8TERNUIrLo921k3NB87Gi2BLJSF6TiVLLCAdfQ7dwwJTeKDc
X-Received: by 2002:a17:903:9ce:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2ddb1b1133cmr31729675ad.13.1789708429446;
        Thu, 17 Sep 2026 22:13:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb73dae10sm2177985ad.1.2026.09.17.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 22:13:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: a100u2w: disable PCI device on remove
Date: Fri, 18 Sep 2026 13:13:40 +0800
Message-ID: <20260918051340.3549545-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inia100_probe_one() enables the PCI device with pci_enable_device().
The probe failure paths disable the device before returning, but the
normal remove path does not perform the corresponding cleanup.

As a result, the PCI device enable state remains unbalanced after the
driver is removed.

Call pci_disable_device() from inia100_remove_one() to match the probe
error path.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/a100u2w.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 4365b896f5c4..827d8715138c 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -1204,6 +1204,7 @@ static void inia100_remove_one(struct pci_dev *pdev)
         release_region(shost->io_port, 256);
 
 	scsi_host_put(shost);
+	pci_disable_device(pdev);
 } 
 
 static const struct pci_device_id inia100_pci_tbl[] = {
-- 
2.43.0

