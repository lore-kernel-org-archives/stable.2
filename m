Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058927281E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567442; cv=none; b=Gd1sRxWv6yGFvgXeoH7Z8vKMnoZgvyaayP7bYjwpz7IXBvO/AWA0a/jQUyL66kwbBWAsDaI1u8lzhRMVnZPDN6mwR3CVpE/mnBNIrRHt8Ak/YBqbuosLtASgxopga9dpzPrEOa5T57p5E+DqzmcU5db6tJyZBMYz2PayP87GUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567442; c=relaxed/simple;
	bh=D9HlupeYiIkem/BjV+GIjRX+TIEz/LFRCsvDjntnfN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+wC5i/3fJDv9mYh3bnYMpzynJebo8Qy5gLrL5+JNoKz2Uzs1pXpUQObsDPQFgwENS9w/YWpLm0zkA54QsUT0mbxM/sYSGMhXhY12FX434NSKu6ohME1rdnO7n8/suePEOY60q1LLzfCMdgs7TtGfInaap4iHyAmGvYOHfF/IqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuJfveFS; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuJfveFS"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso3826305ad.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790567441; x=1791172241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYN1JXBk694UpkFOsaYTriZoiND1sF2gZOTB+NqjJJQ=;
        b=iuJfveFSfAIJ1d/1LqvAmHffz+hFpaCSLwGvnDMgZnuP4pvAV/wwxtR5E5C1thJ8v1
         fCiUSAwne4rfSt8ryRWxSz4ytqSAFw3NYbIFPJBGjv3tn2u3PIKFTK2T8JLTNa7wNz0B
         whtZAnOj5mwkD5Cj3cAF3RfdEr0O9LMNuU6Jbk6G8NUedPg3p4RvuObSyN/arQZykNUV
         FW/ZU/rT7JaU3RoZnVetg4joEfARXops5sycwNwV7cBGgGs2x0MdBbj65b0/p8BycibJ
         iPum0n/B0neT6DQ76fnkEKgvS4d+RM+qTmlp97oGDjHPMgKh5VKE0YV0JR+F6Nidmwnk
         G2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790567441; x=1791172241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYN1JXBk694UpkFOsaYTriZoiND1sF2gZOTB+NqjJJQ=;
        b=Myh7TL0pMDAh8fs9IM80xeaRW3xUBPk2w/reyV5C3QBe8Znohj0ZpLUhziu3yUXh67
         NgkfnYjq/acwYV0ZD/SGe+mrLjl9Kv4zxFq+A6W4jAsBnkvWfaBXFpJol4/gGh/+bPHr
         UITSoOAz2HO5qYP7bXXwYOvAWyrICALL0o6JX/UR/G/oX/rzyQyiuN2s2HJYZh9YNkRq
         BWG2TOjD8Da2Rx3/mGcShC42NsJCLfaZ8P2Dj/hpUf7+sp38ZVxVyV9dM6P9RxNIxOaS
         Rs9qFXnLjXWVUKskYsWN1erG+l6Hizm9oSeOaLVe7IuG0547ZTzDwIowoqVTCRNUEF1n
         BYAQ==
X-Forwarded-Encrypted: i=1; AKwUvByoLoax3toMXVCGdxPvFsy377uTSMLtBngapuhpxwgsUpsFKnRUo2/3yfX9Kb9OTwUoJsXA9/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFoYMT0oNjrV7XF2R4RG5IvN+kWHhNmb7bRjXrKblqz+RYs4xB
	GpoQJexfevCcFSKysSBnmgWjIlLBBZz5tGsN6b1557qcNWOpo6ElVSY=
X-Gm-Gg: AYBFou3GgqnRRH7PwQcfwnnB9DbwmLI8XD7NOePdq88K0b2534Ax8SaGbSju7O2UT7z
	e0gHttKUv6eRySiO0YWtk8BmteBiv8gMJ9UR/1YkOCyzII4c9us9qFpWxNPkZIbbbDbvXvDI4YY
	2pGrVkPtlP82biSvbLkUc9v5tQ2P+oebLfnuVAeRvkbo8R0D0ft2uJ7hhUQHZoAAJ6oAPHO7Fgw
	SwQ8xA7KbSjgmeY6O9oR9XzFSeJrXL8ILbrW3dQhAyRJPnPgdSthuBbxPvxWZLovoc4fXLx49OU
	z3o9ZDsZqeGbxvehHCRx6E6vuhkdbCThfjdLz3Z4rEl/pQTxCkff7yvjxBi6JOLl/VF2MxJMljp
	69GudYxH9RH5qBquKJtM6pZyEDoPFkNRogCT6Q6FShHbKpoTLcm4kbiJ+TrakUh4aieQFRgLdp7
	SgqDHit+81gyRLxnsZhvQ7CdX2naf4vg2fzjdiMqcuLEknJhScpbqCL5EmK17XnKs+2iaPQGYZ2
	Vn5vSEmMpr0a3E5QdFeOR3fCrk=
X-Received: by 2002:a17:903:2f90:b0:2df:b3ea:10 with SMTP id d9443c01a7336-2dfb3ea02c1mr29548625ad.30.1790567440561;
        Sun, 27 Sep 2026 20:50:40 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:712c:b4ae:f935:9398:3170:36f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbc951sm34448765ad.8.2026.09.27.20.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 20:50:40 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bhelgaas@google.com
Cc: alistair@alistair23.me,
	jic23@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] PCI/DOE: Fix double free of a duplicate feature's sysfs name
Date: Mon, 28 Sep 2026 12:50:35 +0900
Message-ID: <20260928035035.252394-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DOE feature is reported twice, sysfs_add_file_to_group() fails
with -EEXIST for the second copy and pci_doe_sysfs_feature_populate()
frees that attribute's name, but leaves the pointer in place.
pci_doe_sysfs_feature_remove() frees every name again when the device
is removed, or when a later feature fails to register, so the name is
freed twice:

  BUG: KASAN: double-free in pci_doe_sysfs_feature_remove+0x117/0x1b0
  Call Trace:
   kfree+0x11a/0x420
   pci_doe_sysfs_feature_remove+0x117/0x1b0
   pci_doe_sysfs_teardown+0x90/0xf0
   pci_remove_bus_device+0x128/0x2e0
   pci_stop_and_remove_bus_device_locked+0x1d/0x30
   remove_store+0xd2/0xf0

Leave the name to pci_doe_sysfs_feature_remove(), which already frees
it for every entry.

Fixes: 2311ab1820fe ("PCI/DOE: Expose DOE features via sysfs")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Tested under QEMU (q35, cxl-type3, KASAN) on 72d3fcf802c4. The device
reports its CDAT feature once, so a test-only change either registers
its DOE capability as a second mailbox or inserts the feature N extra
times into one:

  case                                   before           after
  no duplicate, remove                   no report        no report
  no duplicate, a name fails at probe    no report        no report
  two mailboxes, remove                  double free      no report
  two mailboxes, 3 remove/rescan cycles  3 double frees   no report
  3 duplicates in one mailbox, remove    3 double frees   no report
  2 duplicates, a later name fails,      2 double frees   no report
    probed twice

The doe_features listing is the same before and after in every case.

 drivers/pci/doe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index ac95b1d2d9997..56605386c4c16 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -208,8 +208,7 @@ static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
 				pci_warn(pdev, "Failed adding %s to sysfs group\n",
 					 attrs[i].attr.name);
 				goto fail;
-			} else
-				kfree(attrs[i].attr.name);
+			}
 		}
 	}
 
-- 
2.53.0

