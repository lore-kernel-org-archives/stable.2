Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030582FE56A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170743; cv=none; b=AQez7O2mVvNWHEGQ+b/ABC8hyIkkfyYx2BckC3ZLWyDBRunlWWpKfXeyuf0q4Shx2tFtxyv5hVXhqH3zZSsAebDVXVMLQZmKg4dlptyXuzlO1Q9nqMSHgE7XkDfQdumsBYs6XVu4+jWn99yRQ/V+OFZosFNKEkeIFig+OnZBkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170743; c=relaxed/simple;
	bh=utJwx9x/emAa/FX5+FqoqFvE8ykdtMHfQcVG1Wtfo0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkPzGuJzdv8iCdshwb+Yym5PvjlJwa+veZIkkxubLeTZuRdG7n7kSow7+ub2O53i1/zw/bhYKqugVCdYkb0fTSmHRpJK6iYdLZ3JvnQXGDgfqamKpt9V++xy79tlJUXNlCe/ROIFZZIN4YsTTja+2CPgPu4o1Bvjd0pFRz4zQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxCVNOkX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxCVNOkX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ced3386430so3662285ad.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170741; x=1786775541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=opM1ArZY9ycrOafIY5Aeu7mw/sEReWno9u0hjjJ5rx4=;
        b=hxCVNOkXSMuFBSbNMW30jXBLeQ0IcQ8xe4k9PCdTAgq0uUcKhJYW1KdRduDTdEFKtD
         +Ddrq3GxkSrwG+5soBTlso4AkdFFRbC/IMWlXadiJemrVc/Rj7GHyUDgV/0qY5CZXSOY
         3oyepKS+0mWt49431J2mHodKW8QEvbljae4A4gSqG8L5fJ+uZZTrUxKu6NtZ3//MfRJ8
         NjtqiD3AduAcwQ7TJbKGAIz551jJsvar8cDwubb9V9PsWAMV+/AXLn16GLFmIWlNbgFT
         7+HOEWEvmJTfJDEWQQo1W7b9VqPuI+lkDXofUJfm84PWbdgB01dEhWVCgtWTvZf2T70q
         plNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170741; x=1786775541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opM1ArZY9ycrOafIY5Aeu7mw/sEReWno9u0hjjJ5rx4=;
        b=nktZ7qSVHVfg5xpo00+Y0zKsAHc7DxKsPhmFJIP9cBIPfIHsN7p3/8BAOK/e4YBnXr
         tkUX9XL1sVnMT3jz5/22Svt7F+RxzdwtKDrFBaRbVWfGJpw9ac7hqzoo4Bk99qHqJBzh
         RLKBUA/cJnql9jwEmI21KOuYy0P3CJka65jfhJZOf/ewTWOtxaQEyK7xRyQ67i1mgmNZ
         OR9kH76quap5G4aRWTUAmVF2DFRihUbiY3kxkIcUTuoakskhnYNIIenMuhDXZsrVwN4u
         SL8lUMXn0VwqzmUEnzMygTuzaymbUlAckJJcPEIpYhcVyh97VY2jI4sMP2sb+FWMoGip
         VnLw==
X-Forwarded-Encrypted: i=1; AHgh+RoXw76OA18hiKft6AAva1NMdbxftWp9HKdQ6VyaOR21MLMbjTkXypQ/fIG0VJBKi4eTW6R0nH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVe7lPH991uwYdBo77pE43OvxwJ2UUjZife1nrjZkDwmmp6w5
	jgUojqqJcZIW1ms2GPN+qrzfWK7C0emzbl2wtKmOGlJUASsSVgMRQZM9
X-Gm-Gg: AR+sD11j24E5boujeTVPtxTFdU3yNNsGzLnjJEBJJH4WC98SLLRh88jFMPW1y2K4mdt
	RCIW0r2BGAVJoAKI5wOcPGvvPXDMFXqNlKmQs6qIxWppNSHr/JZadtLFt1aA5p+wB4hEFZEhGOV
	ezi99teUQcifGQoGp4OzahOfd9PTkv/gvnZiRC5OEGKbsBfPIrtMcZIsOq6uEdo6FWcxYbK81Ox
	tizP0MmPbAgVRx4wZtPtwtPQxEL31V8K2JQNXIqb0w1IvDLQ7/XV+BofDEDDCc+O/4RB2TlWBMR
	ZCQXpUBXv49PGV0XF89ePt2pORMfuiyPuQW3ILymGKbx8a0kT2H66gAOZ7nKTaVVCSMhC60ir88
	+hJIBjokf4PXDatBIACfUZdu0YqhGnYgUxGdt24VOixdT4wZq3G1aoGxKotL+wVfx+1hasRWt5D
	xANUkk/ML8HRWhb6NITrJTOUuMXUKFT0DIu9XcIs9OSXs=
X-Received: by 2002:a05:6a21:6f17:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cbc0175426mr12832407637.9.1786170741232;
        Fri, 07 Aug 2026 23:32:21 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1af2d8sm1484585a12.10.2026.08.07.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:32:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
	Daniele Palmas <dnlplm@gmail.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Slark Xiao <slark_xiao@163.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: mhi: host: pci_generic: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 14:29:16 +0800
Message-ID: <20260808062916.2604668-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mhi_pci_probe() calls pm_runtime_use_autosuspend() when runtime PM is
supported, but mhi_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during device removal.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before
forbidding runtime PM.

This issue was found by manual code inspection.

Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bus/mhi/host/pci_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0d0d9c7ffa4b..8efff3e0a31c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1479,6 +1479,7 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
 	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_forbid(&pdev->dev);
 	pci_disable_sriov(pdev);
 
-- 
2.43.0

