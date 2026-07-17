Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CFB3FA5E8
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294261; cv=none; b=lx/JhHBARVI3NlpIXZ1HjQb9gqCdGnS5W3C2laa1JKYOMGECKMkRGc52IXntgZaaT6EUALxhBn6YR5vuJpJiW6V+6GRsE9WVJadt4HwaJMdEbfn6Gp3qxuwEc/7EvcdIPY4M/Y8i98r9woqOCeYr5myP/zKmkHNEO7o5al1D8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294261; c=relaxed/simple;
	bh=Hvtps/wDYbIsM4c5E2UreoLfCBOyh8LrLfxlk+d0lzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ59a9WjlO52JxVaQwXsdNmvsa8SZ3nwJaz4BacoOUAwW6xPwQaMjLQ4voV5L3zGzZWPQ4yd2Ww/1yyicLoru3EINe/wc77RTxPrldpCxP1DigMwDFF/bFRYNbQKRmDwNG2uhustWxTCu9cOZVo+9Zq0E6elGH/4MaDNK+gB8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg4z/a3+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg4z/a3+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so5050821a91.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784294260; x=1784899060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2OpEvimBr9inqr1oxq/Rw5zQcfND5k4NuFnqM1lzPk=;
        b=Kg4z/a3+m6HxpQDiEayPLmF1tR9rTuAaBqdwnbdYiah+MOxHtadJjO09hth7J/1bG4
         Lx26sM/m1caDCeWfZrVSngYiZ86ql81EYef0P0whGGmjsebHB0B6f1sz+pwT7yJdrM/w
         5CqheQJQhHP20QNyYM4TLYLXoUkl+tUuLiMne/R0lz3azWJjn4Q5JHvIGX5MV+kxsex+
         s/uGcd1C6NuR0oxeornop60XsSYw3c93hYsFfee2Y5/Yml65XjFr/DzDADiZsZaKMHFv
         jSm9QnXzV82nJzNMuN9KlvKb6oHY87kKrnYqhzXmnzv+ZYnMY8PZO5Qk/lZkDrheOBAx
         faBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784294260; x=1784899060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2OpEvimBr9inqr1oxq/Rw5zQcfND5k4NuFnqM1lzPk=;
        b=ND3mJGArq2eYr7KAUksg1Gm3GL15a0eZK/LT6OjGYisJoSQldXlXRO1Jje8NhMEHl/
         mGFK7ng1jygQ/M/RCRN/F9MPcJwF2KGFM08C9tga1DbENjvP2fCeCPbCwQtecEyLFxG+
         C/DLTMN5Pzijpg/Lj+NaZLlVtPej1j2PLm7XmM/fn+ampHilhhynOiH4kmTRISjExEXr
         qdIJKsqUVzEBMdVO9r2UCXfS18kpCxtAOWGZZT9O5PeryWB6nflJ+Ty0YohdhmwHOfYM
         RZ3mzeWQxhITuczEyUMAO7pSduuewXhqDKVgFX4S/KoDn0xpJhOkzKcrLz6k1+NiBuna
         zUlg==
X-Forwarded-Encrypted: i=1; AHgh+RpXM/Rd++bpkgTbe/yJUgLJxUIyHgv8oQXBLQtYFlK6HFr1yOAJYMJ2LcwTyORISlZnXBMs/CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoMw9yB7xETILhpuxm7LVvH1XRcpiztq4daTSolJwKTsO7KVu
	BNNrPFb514/crAmfii/gSmRDLY8dkmNBQOYKJRWzpm4NBKLDTxWR/mqj
X-Gm-Gg: AfdE7clkW1tk6Xp8UcEUuAd/FfNFpOrA2trxi7cOK3NIF0IlTfTRBw+1fj0FsXPhSw6
	4JqAKgpJa4VUwgmv0FXx71rSupDu73AwKoALnNRommmk4ntNG+tnigM/ywaCqTZ7ZnEV7f1DfdI
	StdjvPVEtLV88m7/xrypXR+/nSsu4Ys8V7QsQ4gdyk1UVOD7YNhfVB1Yzgc643j74QaFriJEgEH
	7n3w/GtGsrZWKFIJNucqsZqr8MmH186YBF4vwP/hL1CYCQBZLMOFBXrhMrwpSiQZWygZlmGZAqk
	m0jaWxFXQydgkZlwA+Ihap/0Zrrt3jgxuvuksNzC1t2jXdpE5E8n1FilEfMwRcVASeW88MGeZqB
	Dl0jZxB/UkSPw3NqhYaPGWrhes4cu9w67Y5lC4WcpFFs+157CBp7pOS30n3Vlc6g7wYkeS9Lk9M
	8Yam5+LndbPiz+BAIg8hu1L6X376O0vN+Jph0=
X-Received: by 2002:a17:90b:1dc3:b0:384:5b5b:3465 with SMTP id 98e67ed59e1d1-38e4b5792e4mr2760146a91.29.1784294259629;
        Fri, 17 Jul 2026 06:17:39 -0700 (PDT)
Received: from localhost.localdomain ([152.59.184.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429ff04absm6907802eec.8.2026.07.17.06.17.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 06:17:39 -0700 (PDT)
From: Rounak Das <rounakdas2025@gmail.com>
To: dinguyen@kernel.org
Cc: bp@alien8.de,
	tony.luck@intel.com,
	stable@vger.kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] EDAC/altera: Fix device node reference leaks in the SDMMC ECC setup
Date: Fri, 17 Jul 2026 18:47:20 +0530
Message-ID: <20260717131720.19038-1-rounakdas2025@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <182c3d64-17b7-4e18-9bbe-2fd97eb231a2@kernel.org>
References: <182c3d64-17b7-4e18-9bbe-2fd97eb231a2@kernel.org>
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
Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/20260708091135.94114-1-rounakdas2025%40gmail.com
Signed-off-by: Rounak Das <rounakdas2025@gmail.com>
---
v2:
 - Add Fixes:, Cc: stable, and Closes: tags (Dinh).

v1: https://lore.kernel.org/all/20260717102549.13309-1-rounakdas2025@gmail.com/
---
 drivers/edac/altera_edac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 68846f583eee..777ba6efcc54 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1524,6 +1524,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name, 1,
 					 ecc_name, 1, 0, edac_idx);
 	if (!dci) {
+		of_node_put(np);
 		edac_printk(KERN_ERR, EDAC_DEVICE,
 			    "%s: Unable to allocate PortB EDAC device\n",
 			    ecc_name);
@@ -1534,8 +1535,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
@@ -1600,6 +1603,8 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 		rc = -ENOMEM;
 		goto err_release_group_1;
 	}
+	of_node_put(np);
+
 	altr_create_edacdev_dbgfs(dci, prv);
 
 	list_add(&altdev->next, &altdev->edac->a10_ecc_devices);
@@ -1609,6 +1614,7 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	return 0;
 
 err_release_group_1:
+	of_node_put(np);
 	edac_device_free_ctl_info(dci);
 	devres_release_group(device->edac->dev, altr_portb_setup);
 	edac_printk(KERN_ERR, EDAC_DEVICE,
@@ -1638,7 +1644,7 @@ static int __init socfpga_init_sdmmc_ecc(struct altr_edac_device_dev *device)
 		goto exit;
 
 	/* Setup portB */
-	return altr_portb_setup(device);
+	rc = altr_portb_setup(device);
 
 exit:
 	of_node_put(child);
-- 
2.50.1 (Apple Git-155)

