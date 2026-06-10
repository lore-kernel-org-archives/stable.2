Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD237F8D6
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096808; cv=none; b=WdkBXDzzw16Sz8rOaWpDyZRwYioyW9LfCbI7M7YGAfPxJZqaouq7DWt9PD288YUp0VsMLfMyL5jcA4AWd6VRxAuHx++QtV+pADHL7Dh9R5GbZ5O10RNNXucG3Ph+PZHtr84cyTE3mNeFE7nVSEz+InYZUwFEmE2ozPtK5L+5Smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096808; c=relaxed/simple;
	bh=WaosMbjfwHRBHBEEDV3W8lJK6/4vapnN1+pjcrONctQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9YCDsuYOxQ2v753R26+XF6nwmxN/dvyxr+cwoZy1y36LsSFzwzpEpFhsaDxJEa466GK7rC32WdouNvr9du0ikABvfHLsrT9mykyPIOtE9ODZ3Sh/Ns2iP5CfIWKUo4BO58Su723d4Y+qHL+9Yy2PRPrIdopscsGSUJUCd6iV/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ+/o6WC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ+/o6WC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so46827485ad.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 06:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096807; x=1781701607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=kJ+/o6WCK4jUFde5B5aMGjZIoCB61ZcSQy2gjffYO4fWL4VrIko4+iJGMsdGiocBbi
         BKAklRL6kaYPguGQDEkRsXd/DBuL/1Hb79E0HFHms7W+oGiYPJCahbS9At/9XHAP06uU
         eDuwh8akAqvZ1QPAOGoe+DnweESrw9IgymJ2OhJ62mRNvOmqA07nesJmSDqUammLnoEb
         Ic1YHkEn7kahnXdZN8lmBmNAxC7iL+pWFrHwXHEakwbqifUHrQn3ZiRdrJfhJcAiTu+W
         vwiDL13adJjUC5GuMNEo7luD+2w64IBFGoTCpKdNyRAXbviAo5NedPIczkpz98aEOTNt
         My3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096807; x=1781701607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPY6kv+qAU78zF0fcea5dJTa14wAhSte/v9aqMKiagg=;
        b=jZ3Y1YzHq0sufDGmxd5n8wKrq0eu3vaiVPPBlQIHXGa2O2VRoaltSfH0l6x9OTfQg+
         +cyDmIf2SCdMYsSOM5/A3d4Gobf46JZLbsXNLc7wdHS/OdEVvtXy2X8ZELV+bLgB9QKu
         7DB76RHK361DkhMisuqJiallHrsHMOspx0zWNaKWpcciV4cWOnXxhOQuufITWHP/I4Jj
         4DaH43IdIHd3uYNOvhocX5tSPg0Uq03xYVZa9yYGukgNaS0omMXt7tLwPDSQIJGnB/JC
         9lmok1vED4Vu1JeZREQvUvs7p97MSZJyShTeYq40IGb4L1dwrbQ2Y54t/YWjGMEtJLxm
         935A==
X-Forwarded-Encrypted: i=1; AFNElJ/PbTPwNBv/Hl3t5nG0CRbCQO8DGfekXjLruD9DLso1jAoCCRIbS0lCGMjWfK0mYWH9B26soi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWSDD0Vr1xkyUM+mdUtzgmQOVGcAmBm67PUKrV6fFO2hvKb6+
	PNnfni5A0/zbHD3lBOs25762ffkCG9DX7v889i5BJ8lmky9yT9HToLTX
X-Gm-Gg: Acq92OGa0tmlTjawM37dsUB0qXqTa8OcC8HTMM2u0m7fE6DKBYLFshOBDmwqIHDLXRa
	USjBF63oxp5dZ61XyoMhArwVYrMQuL3zYR8UgihSLCA9TGoSzK5ESKYPOeTL5v0WLwwzmQ37tpo
	vjlv+aSoUT4rkOqnZ20KtAEd/lKkaRugI+9oNgNrXWxd7ZWsyuspapez3JM+JwbhtIoihPOlfR5
	ACdY51WczNv4V6nCCMhFlMCVXN+tSEFX14h+TPUjg6wnaOq1J05hHIIr2qqiOJvOlRT8Oxajhg9
	arV4aKuBJOnvrLhqObiFkWT7au3n1Ao6UnP64Y8spLjqXK8rmUQW1NwTZ3D0fVf3fHBWTgr7+sG
	IPb6dWL5gz3n306ejQW/QYI9rIt5uONlnxRDKLB/tF5o/kewXg4FYVGq6K0cLbfSfFtuQp8e31+
	k9fjWNPdfzijPQWDo3Fdfk/4z6iLtyrD24S7Ws39b6dMyqrdcJ0bAkO5pHhyVtOibuWA==
X-Received: by 2002:a17:903:3805:b0:2b2:57f3:8d07 with SMTP id d9443c01a7336-2c1e78e4d1bmr312576555ad.7.1781096806541;
        Wed, 10 Jun 2026 06:06:46 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm238523865ad.21.2026.06.10.06.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:06:46 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: ruippan@tencent.com,
	leonzzhu@tencent.com
Cc: hugoolli@tencent.com,
	stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in _pci_assign_resource()
Date: Wed, 10 Jun 2026 21:06:26 +0800
Message-ID: <20260610130627.1601141-3-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260610130627.1601141-1-hugoolli@tencent.com>
References: <20260610130627.1601141-1-hugoolli@tencent.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_pci_assign_resource() walks up the parent buses looking for a
transparent bridge to retry resource allocation against.  The
termination check dereferences bus->self->transparent without first
testing bus->self.

For SR-IOV virtual buses created by virtfn_add_bus() via
pci_add_new_bus(parent, NULL, busnr) -- which happens when a VF lands
on a bus number different from its PF -- bus->self is NULL.  When
__pci_assign_resource() is invoked on such a VF (e.g. via
pci_assign_resource() from userspace-triggered LTP coverage) and the
allocation fails on the first iteration, the !bus->parent test passes
because the virtual bus does have a parent, and the next term then
NULL-derefs bus->self.

Add an explicit !bus->self check, mirroring the established pattern
elsewhere in drivers/pci/ (e.g. pci.c, probe.c, pciehp_hpc.c).

Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV PF whose
VFs span multiple bus numbers, by triggering pci_assign_resource() on
a VF that lives on a virtual bus:

    BUG: kernel NULL pointer dereference, address: 0000000000000860
    RIP: 0010:_pci_assign_resource+0x63/0x130
    Call Trace:
     pci_assign_resource+0xe9/0x370
     ... (LTP tpci test-case 12 driving pci_assign_resource via sysfs)
     do_syscall_64+0xab/0x500

This is the same SR-IOV-virtual-bus / self == NULL pattern fixed for
pci_read_bridge_bases() in commit ("PCI: Bail out of
pci_read_bridge_bases() for SR-IOV virtual buses").

Fixes: d09ee9687e02 ("PCI: improve resource allocation under transparent bridges")
Cc: stable@vger.kernel.org
Signed-off-by: Yuguo Li <hugoolli@tencent.com>
---
 drivers/pci/setup-res.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 991d3ed543f5..e8bd3d4ff923 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -353,7 +353,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
 
 	bus = dev->bus;
 	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
-		if (!bus->parent || !bus->self->transparent)
+		if (!bus->parent || !bus->self || !bus->self->transparent)
 			break;
 		bus = bus->parent;
 	}
-- 
2.43.7

