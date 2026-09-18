Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719B51AFEC
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755218; cv=none; b=q+0Gq3heOzet5txHFbdGKHZAMEJ6ZK0uCKRHXrdPthwsLceugb0WVOuEt4hxIGVPUHZs8Z8Uw9kj9tVOFSsNp/bjzCD3cGC7RTzIJQyaOCxfWZZTE6I7dmac54nkhhsCf0jo3iVs1Q7OeDewj4WALdl5UO2IDr8adK3I9Hlh55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755218; c=relaxed/simple;
	bh=jxB51OTaF8ZQDmHlLnMOrVw7Z/Ws4WNrUhbIMMa/FPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwwZ0CUlT1rSknCibYfoSzGUMyuPtOMALiUOXIvz5WSl918h3N+aDenFA1iCE5RCduAVZUUXLtuY2BT5nMAjg2DdLKlDn7tB75F+oYrEyuk2JGiNGovw3wSM84ZpDxz4MkKLszfF7VJopcwYpPSfAuKd6Q7BcL042ZU/UWBy2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M44kfKPW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M44kfKPW"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffdso8442185ad.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755216; x=1790360016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=shS485b8tZfkhk79R4MyxZiHCFajwa7fKOgCDdDkLAw=;
        b=M44kfKPWKda/HQ54Lt3AI06EuzRL5MzqGj+Ht2X1/cHXTPkh30UTbI6D7FpYB1tsiO
         244NTerQ1oOA2MYCE8fqDDQ0LPQOCjIxo6a+qEmAsD9HqJSvuY/K1AGPxhOJnFkb9PJk
         mCmWAe6tARA8Js0hFMIelim+afhECSapODYiiZitQF7XqbebCqvF0uBtpCscJ4rLm/EB
         J14zTg6cAJqkmhixjA78k7BHWMiguDofXXh7Xzsmhw5I6jLhjmu3CLf8F78b5J6aOXfl
         feb6JEsF3ZWS7skzm4tpoZTpXqbjr0h/Q5HkeqM2DoqbInHjdPzOI2PjCIsbvTm/sUAT
         94dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755216; x=1790360016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shS485b8tZfkhk79R4MyxZiHCFajwa7fKOgCDdDkLAw=;
        b=AwIYKJffTeRlR61CKhFMB66VMpwRXB3lK8A5v+Fsr7M81xD0izAGK7WuhiQ+EzIW+G
         jsNU8xjR8361TeH0aNhdXpfUtnzsGidq30gb6ppxvrrpeesS6MEctCai5O+F84ZG6GfB
         jQ/Km6lVChgUZ8AUf5svboBWn7WnxA9Vh11RRxAw023vURgHECVSW+W7jLi6Y8ZNCLt0
         16iYmY0/YzDzi2ww6HiRbzhNO5BXkR9zXeK7cXO6JNj2mfzCaaRFbxde+WogA6uY+vKO
         xPA6AgVOs0A26PGpg/3H84jMUo/axtzLNtlvsasEvC9BnuaJKLT+X3/ACKgN8i0+Vl0p
         UWXA==
X-Gm-Message-State: AFuF++kur6Uziy58gkXjypun8gyLh4WBU+oLf0v9WDxPc9p8J7eNUSOV
	O8778Ff/uf+n+/jBkmP0dmedtt5Uv15yvWuBHsTXiut9FXk0rJ/VNvPV
X-Gm-Gg: AYBFou0f2P1XZ2PKkAQAY9oqhJZn3WHCQ/1x3ntNWRKVWt5inNuozeZXkSuChYjS9xY
	Lv1cs5kb6rFfTJFdNoNZvPesJml7vAKu1vX7c4UxpKizwZwTQ6QIKxHVGQmvGEPW9GlWheLCFsA
	8dwaIggEj5oFF57fkiAm3VTN8P4e8RJ7QPQZ/7pUqAIcC/uJXuaOZ4EifXzSGvQvXX8g2pdBMWF
	N5XL3X3fHnDRLRMVeNvynVy49OgQmfzMGDWFJ7N3+znNUgOBnm+zdawTjjm0PeI60tVFXtIA6DU
	li2j9+UHq1qOsMeu0v09CpNUuLzEKdg4+cHRomWoWgu+cby43q1/hVLYBRA2g2OzLGsKVge4VhL
	MbLZchAv3dNy5Zu0X+Mq+vej08PybGPtH8zI+vN8/P5fJCCHv1eGhZfAFV+NYIMLejBIN+awDjd
	9KezceoJyN/bn8qfOM9CYSZZp/pMW9T64kBTAEVriwaQ2qn7A0KIt4ldbLX5iRCgPI
X-Received: by 2002:a17:902:e751:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2ddb1ae69b7mr68800035ad.12.1789755215937;
        Fri, 18 Sep 2026 11:13:35 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1788bcasm662465ad.21.2026.09.18.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:13:35 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] scsi: efct: clear MWI on remove
Date: Sat, 19 Sep 2026 02:13:26 +0800
Message-ID: <20260918181326.3633765-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

efct_pci_probe() enables PCI Memory-Write-Invalidate with pci_set_mwi().
The probe failure path clears this state with pci_clear_mwi(), but the
normal remove path does not perform the corresponding cleanup.

pci_disable_device() only disables PCI bus mastering and does not clear
the PCI_COMMAND_INVALIDATE bit. As a result, the MWI configuration can
remain enabled after the driver is removed.

Call pci_clear_mwi() in efct_pci_remove(), matching the probe error
path.

This issue was found by manual code inspection.

Fixes: 4df84e8466242 ("scsi: elx: efct: Driver initialization routines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/elx/efct/efct_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 07c2f453459e..720bad7b3517 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -613,6 +613,7 @@ efct_pci_remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 
+	pci_clear_mwi(pdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0

