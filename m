Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661053264C7
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202552; cv=none; b=E3D1S5QILgBWXeiXAZEBmu0BsPfKN0m95PRGBacZeqnw8e3G0zf/uN7KHUmbsTUFnQn81Yc7bO2ugDmWL0w86ADndKpNZ3WgWOl0ien4nLitx4e7UeupWUkTdaRG7dMJ4t4MLGAbjJunFzRvqV8yRQzWBqjDj+OgSS7tS4LQpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202552; c=relaxed/simple;
	bh=pUVoEvqTkBts2j5M0WNdQpyr1pnzEIN9t25AtarzmiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5XI0iFG/0ktR3WoAq96C4nJt0XZ4AWqeeMlCC+qZ8bWKMY+6wlHhWGWtJl6fnykHt+EH3xDTpRQ9Rrdf1NoYXd9wcskjVE/JAOqxd7zmA/vIE3DNRR4faao6/Arupn+tINj8EAUU1iOIPiMOgQfxLxSeDvlRVKDEdebK+Tcw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcDCOcWC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcDCOcWC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf52d15d88so3835745ad.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786202551; x=1786807351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bn5LTk57U4QWCUdbGncuYOxjBXWL7RxJ7HrZaPl5EUU=;
        b=GcDCOcWCJt1t3arAoAbWBmnwSy7oPG4AGkSJveTC8F3QP4ZRku5WgEJOEHqeJABkrj
         6501iqlJcYPOJIfXHZC//6yJCD2VJYzpY7rVp3mzzL3hD/aoDmPUkmLUXUinS5fYtPzU
         L2KoEdufBCN8vMdQJGtPExrDMYQzDzevQQjL5V+3m4oRroMQ50qWnyeabOo3JAbeUOlM
         bEm9pYZx+FN8e4xGMHYfLiZh717NZQE+dEukBmGqtkj6bk3PdhZ0KADbfYn5cpBCT+jY
         +Qnyd9m/b4rkteA2W7ni9swcvqNKBJ/PXT7SpYa6Wejg7S/L7KMOAD/TW4KS+WviDyBw
         1fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786202551; x=1786807351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bn5LTk57U4QWCUdbGncuYOxjBXWL7RxJ7HrZaPl5EUU=;
        b=XuO5fFI3UxsDGy3qLvNkU3fh1arG7LtaVJ5KUHyBRD8T73AZ5peqspgCtY6qtVpYG2
         5j54JhSHsWl2jk0NsTQnYcS/CcZi7v0Ais4yvaFVsJQ2G9qRvpsmHaUAShr049UkZL/j
         CriYoNi5EcG+Yj2QXbp5bB1Flc5EI4pCg22Pdm5EhzCndlxBSdEEIbegsquOLohU2Lod
         +cFwl5lBnRQArSGkmm+9zb9lR7gIUzUToZkF09Sjjb2e9I/BCOVA+jF5pY+La/WOgq82
         4aWL0uO/u9UxbHkDIDYtCnq8hC5mOU/AMRhqVYhO6IenAFu2brQ5l7Na2HY7jlbfOzwS
         As1g==
X-Forwarded-Encrypted: i=1; AHgh+Rqz4JHLS1uvLzXsMESODUXgiXB3EzCqA/u0O6l6p/mmkdV0IIgaFDdb0oNLG9vlQ7EEVblJ0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJIpIdXjSgZcRNu026ldKXEczOfbVJtu+5PwG0q1MUZUb/6Pr8
	7jBjJ/hS97v+EK7g95AXEn0z0X86te0zCLzcjpOf6dOSEC0jtuc4X2vL
X-Gm-Gg: AR+sD13/Uyu8zv4aNU0mMzyHZmKj/i3mH/WJ4ujYvIHONykW44syLBVxTMIIK9WnRUG
	09sC5rV4r2fXDzS63NJe/OsUYbCVnvUmcDnoVU8ZZEEUWFEeSLmzh7ptID5/vwRFbqrMMBjb/Vt
	k4leAnFgINdYbJ4QP5oj6RTLFIl7p43oJwkwaOw4Mzzdd1ACY6goVZ7pYUovTFOS2nYq3ihAXxk
	/upJVA8DxWy4IMnHHAaJvpJjEDb9YHyN3801CbrOVhcZM8pK1+xKeRGCMET0UwAbHCJX2bCJpvQ
	gPPi4H4xEAys/1Noq7fS/5DrVKW/zGQjxEDmEiz9WbSMVDAiEzt+JpS9cFIgXA9TKkCmxjOP8Yw
	uC5UVyzK/GiLAcl5HrkjPOUTuk7NL3L+uMf6SQ2PSHF33F6pu8bbKPvN1L6IbX9rHtVdqWPhKq/
	tNpOzgPUUq31PZNXSKecKqSIk2C/xsjXAJ6e4o492ifmf1xJD89Q==
X-Received: by 2002:a17:902:ef02:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2d2a898f9abmr104950805ad.9.1786202550819;
        Sat, 08 Aug 2026 08:22:30 -0700 (PDT)
Received: from lgs.. ([101.36.111.22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16b446bd3sm19442305ad.61.2026.08.08.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:22:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: amd-mp2: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 23:22:20 +0800
Message-ID: <20260808152220.2938557-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_mp2_pci_probe() calls pm_runtime_use_autosuspend(), but
amd_mp2_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-amd-mp2-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-pci.c b/drivers/i2c/busses/i2c-amd-mp2-pci.c
index 5b41d18b62d3..2b7f7b3cddc5 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-pci.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-pci.c
@@ -371,6 +371,7 @@ static void amd_mp2_pci_remove(struct pci_dev *pci_dev)
 {
 	struct amd_mp2_dev *privdata = pci_get_drvdata(pci_dev);
 
+	pm_runtime_dont_use_autosuspend(&pci_dev->dev);
 	pm_runtime_forbid(&pci_dev->dev);
 	pm_runtime_get_noresume(&pci_dev->dev);
 
-- 
2.43.0

