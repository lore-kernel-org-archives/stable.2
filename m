Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715D28033B
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790424700; cv=none; b=WBmjXbJ796F+/X0wJWS1qa44b4GGJf6cI2MV3kclSHPnECx8lEkpRWH90nf0rRUzGJ7yWjaelvNdApRyWHkEOCCT3wy/jufnUK2K+J2z0iDxTuzMPr9O1ARzoLZGnci/T+dOuE7t+oYotLHF2of/qwCX25rMHQKzPvrJSOAJTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790424700; c=relaxed/simple;
	bh=LPLjbx8I8Er+Ls1rTGy3VE3lTFlXqKXn4zGM+1+2f5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gk5cFC2KWOK1pOEkHXJnslVygRRitDJVrakgJWRZxsq19ZorCc3lbWFT0v0AznXsmPxNunHQMYkvMEQCbhbmfO35za/VhWLNS8LO6H6NBFw32Kb9YOzzU5rsWkZ2KTVKhDhTBun+u20tgssOJ/qczqWrXC0JvHpMcVNlcV2mr2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+4mpl5r; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+4mpl5r"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so7805655ad.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790424698; x=1791029498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UCqXVsEit/5UgovE1bO5G5/xS9YReJJK497aNTHOdc=;
        b=i+4mpl5rv2a6ykWEoNCD2VM5dipnqgRCGFSH2x6FYqPEhwazS+sezAQVnrwVGvoBVl
         b1QcReKIkUnqvftoR5xrZUhVvyGrNa6+wsSiUEY0vy2oAEmWqo74TaZ6eZvEebcWgpJ/
         JcnxbyPyCrxA1SeVrdPL+LD887wod2annT8NfBsoXiyPzfi/u9j8cFUhBMHghBCPl4Bh
         Qir7w1blCyJ9NFkHgSP7iOCgvSQ6EaALlSXtfvGkAQzbcnfA8DPyCKvNsoJ7P3lHeugI
         z2tzqwT35TqrZXw536FCVA1ONPDbw6iHpZu/o7WwACDO4QntLBWXE3aSRAj5ohItdFQD
         gU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790424698; x=1791029498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UCqXVsEit/5UgovE1bO5G5/xS9YReJJK497aNTHOdc=;
        b=oG1DXF4P+qlcuw9/hacm2WQ7cvBzNEOEjZhAPxkCyFAMdNK0d3/w0DLSMmQ+LHhdGH
         Ju3x989/+W2lY/xhw0mhixltzsj7Uzwk/kkLHYrVAgGtR3EnEqSn0iKI9q97+GrUrgNP
         urYA0ryVRWBWBhZNu0uQp+VnYNfkHBPCl4azOt4BYnZUObl67uxshWXcHU/27nhPERYj
         HYcnEa06EW0CjIuu5W6w4z2VlZkzrGOvdselbl6ktYeU1IGC/g6XVWnpyp4D98iSFc77
         l6zXp4jdSXeQ6yWznPAg1j6/ML9DYVBN8goSTJjS/+Vd3pI/2xaIYBercUn/wqjV7EEI
         Uu4g==
X-Forwarded-Encrypted: i=1; AKwUvBxNIPkPe/E9n8+fuby42IZSYntFermPwEYh0vl/F06PkKLpQm2WUCuSNMtTp7NkOh/BPj9hbEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJiFGyCqvftCuGXjfPvnAUuwczt5V3i9mOaOfF7NMExIz7yF23
	qKNfAaWiUTXjCQF/UBb0+zEwJMq0B/srMoXpWCJTPA7NnSE28IiWMaf8
X-Gm-Gg: AYBFou3lwEdRlplXVKgTrWPyKJ+oIVLRA3qmmAavu/4zL3zWm+s4nAO5BjGc7FuGOj7
	Wf3iqn4TKHzKJ/hsXQcdeP7czsTD6BbcPjZrnf2Mt1Ab0XUs7WZbqZ6moCFjrWKoAmTeOsHeSKf
	4iGM/K/UO+UOqlueuKsEY3Nj0aZZoToJcx0LVvKblJtXtBSILXlXdEaKhIPdqjBfKO14yHD8MS4
	CaXevOw/H8TyPMa8UlYuMQca/zEL9HL1YRkrVnkcehbgAtYE+C2gdJhRfkdzpSNLxQ0VWyrOkk8
	oQiIQmUv+/cWbVPB+HIiMGT98OCqhMEh+6BPy5rpKET6pMzvXpM9MUKVGI2Nm794Xnuf/muRobC
	5yuBCYgNWmk5d4fyDBjDJUPf5NuZ0TqnysdQPKC2/Og1MQDSFi2l8H846Is+pLpvzaKE3gap9No
	9iCIvhA93CKyf7mEOLB44HII2r5hkfDdz2uKpqJXysxVnViOrxjgi0kGA7LE6CWEmpARaEGTxWW
	O0kv/NHgc8kEvQ0Ng00CR0zGtWqS2KE9AAYpX/PlRvx
X-Received: by 2002:a17:903:22c4:b0:2df:8ef0:4597 with SMTP id d9443c01a7336-2df8ef04654mr43600025ad.42.1790424693330;
        Sat, 26 Sep 2026 05:11:33 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:208b:3411:14ea:51a9:50f2:5786])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913dfe98sm21709715ad.22.2026.09.26.05.11.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 05:11:31 -0700 (PDT)
From: Rounak Das <rounakdas2025@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rounak Das <rounakdas2025@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] EDAC/altera: Fix device node reference leaks in the SDMMC ECC setup
Date: Sat, 26 Sep 2026 17:38:46 +0530
Message-ID: <20260926120846.35716-1-rounakdas2025@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under altr_portb_setup() and socfpga_init_sdmmc_ecc(),
of_find_compatible_node() was being used to look up the sdmmc-ecc
node. This node wasn't being dropped using of_node_put().

altr_portb_setup() did not drop its reference under its success path
or on any error path.

socfpga_init_sdmmc_ecc() did an early return thereby skipping the
common exit label and thus leaking the reference.

Add the missing of_node_put() calls in altr_portb_setup(), and route
socfpga_init_sdmmc_ecc()'s success path through the common exit label.

Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
Fixes: 788586efd116 ("EDAC/altera: Initialize peripheral FIFOs in probe()")
Cc: stable@vger.kernel.org # 6.18+
Closes: https://sashiko.dev/#/patchset/20260708091135.94114-1-rounakdas2025%40gmail.com
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Rounak Das <rounakdas2025@gmail.com>
---
v3:
 - Rebase on top of Dinh's "Address sashiko reviews part 1" series (Dinh).
 - Limit stable backport to 6.18+.
v2: https://lore.kernel.org/all/20260717131720.19038-1-rounakdas2025@gmail.com/
v1: https://lore.kernel.org/all/20260717102549.13309-1-rounakdas2025@gmail.com/
---
 drivers/edac/altera_edac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 4c20fb926160..bb95dab847b3 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1506,6 +1506,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name, 1,
 					 ecc_name, 1, 0, edac_idx);
 	if (!dci) {
+		of_node_put(np);
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate PortB EDAC device\n",
 			    ecc_name);
@@ -1518,6 +1519,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 
 	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
 		edac_device_free_ctl_info(dci);
+		of_node_put(np);
 		return -ENOMEM;
 	}
 
@@ -1584,6 +1586,8 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENOMEM;
 		goto err_release_group_1;
 	}
+	of_node_put(np);
+
 	altr_create_edacdev_dbgfs(dci, prv);
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
@@ -1600,6 +1604,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	 */
 	devres_release_group(device->edac->dev, altr_portb_setup);
 	edac_device_free_ctl_info(dci);
+	of_node_put(np);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
 		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
 	return rc;
@@ -1627,7 +1632,7 @@ static int socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
 		goto exit;
 
 	/* Setup portB */
-	return altr_portb_setup(device);
+	rc = altr_portb_setup(device);
 
 exit:
 	of_node_put(child);

base-commit: eef3b67f9c6782127163b631c9043011a68016e2
-- 
2.54.0 (Apple Git-157)

