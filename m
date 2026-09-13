Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3D386C18
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789334095; cv=none; b=seE3sqi5eHMH8RM08hp/4YPWSKHYBX9KRQoBaUmSZkwVpZQ4i80nCrMr6tU7yPUuiU/KM1VnNw1w2YbpsSHz2vYYIzjqKQLiN4a19HMPSx1k8RRCdl3N1PvknC1P3HUtjCeum/94yaYiLjiluHA0WMY3RLMlcpfS428XO2bpZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789334095; c=relaxed/simple;
	bh=6QTSFu+QYOXAVxnu/+LpbdSsP3vJnCO72sARPcer6a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG0lgsm8rJzVzqsB5KVlTReYoBHxoMGIzfJZcBBoIJNL4G2oJIa4Qu7P+bTLeg67wL0Kf4Zu8sksE8capHPhDOp0C5gWajBLrJrfQ9UMP2MuYiN3f2aVNdPTzSu3z24DCkbrBart+2N/C9X86cisf2/wNVOHszS9WU3EmvvzYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlFyf5pM; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlFyf5pM"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d6ff3936easo1757855ad.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789334093; x=1789938893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FAwWGoInaiibNI+PkowbPr1zLMnMrJfky1hPSvm8w8c=;
        b=FlFyf5pM3GAYs+p80ct4FtxkI7VJKlxyKL40ziyCnozRwlo7z7NDVd/8l7j99srd50
         R2reYFKpF/w5fROIsmB5++KmacplBm5+Pv/RMIDZ2EhWGB2OpJLSIOdiNfsRYh8XPVy1
         +KWhz+SikqZnPFlHW3Muchys0TjeK9BbFHhZ2FBuVZkBnSts9dTWLEN7cTzacP/1VSE7
         9g9LnMo9J9f42Ms4UjjFtYMuB7zwgKbrQfuI6EU0JmT5QMEXP2fLJ5xjdek3EQ0Rp2F1
         cid3JtjAQCdi9CG7Zq5sIIedUZmG4gDHq7b/PRfWD358gPpSoXMkm1QtzsdDNQWQ1wrO
         v5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789334093; x=1789938893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FAwWGoInaiibNI+PkowbPr1zLMnMrJfky1hPSvm8w8c=;
        b=STftyFDgDHETlwKyG1crZWgQVShIp+X5dr2wz4c3s0DJmGybj5nyFZKWXlrZq6n1nw
         FavxZeBd1+uRIZTegcbjiVV6Gkk0cCyDqd5zBRxKVdv1Nid28rCVqLXutBk7tHjirlTJ
         XH+3/ypVgVJx73H+Dl+Iei62YJLTYG2N1Tahg42T2ol4+3G+tl3GOUU5DiKoj0n5jHVq
         jM/7kmFQ2Z2hFhclg89wpFikivftMH+QV1okEW21caNx2KgA8UtZCi+dUFNl/zD4kcmQ
         YC6K1Q6MxTx4kucmiPqTHSArd7Rg5YOu8x619MQeR4gZCdUCT66pZzLIQGTkSfO+dE6I
         RF5w==
X-Forwarded-Encrypted: i=1; AKwUvBxp4N1wdNoNPQxNEGbcloPLVrGgBmjc/G/gqYes7AIUG2UmCfZKlxHe8WaMYMJyBkf1byndOCY=@vger.kernel.org
X-Gm-Message-State: AFuF++mb+tmj89ISGrmAXazJGZNm4F6neZYwxUxXcjOsuu9kFd86e1rO
	gvNDvQ/YsD6rYqkw96vjZ/RZdvxlvTcQpT9kBOtvGJTXf/0/DrzIUpLm
X-Gm-Gg: AYBFou3yr1qAJ3Qv4p0qznpc4RgLW6DebSdih4iL63rvzgOQ45DLYEa2ArW/ggrmiN+
	RYOEb+vnO2mofbQxVG5Ij2q4SS0RiQ8HLASvDv83/ymvuQbZwv3INd9k4ZzPTLYWOJ56ufv1IDP
	KBGsdQURE0DjWji7OykCboOR9wds9qiniL9wDPlnMpil6c4SJWvvJl/r2rlcdqZyki0IRL3/TAL
	97kT54cFcQJGnRB/zkkJdVLfgWpfod+VGfJI3hwMNDqN4huOVyV0OnKlq+iqWxuC+VggBxq4wCh
	QCmb0OxHomWNwcX3ImCdpTEw4voQ/CJ/i1uB/r22uoJhNA5nzj+3Z4pSu1wosJO+ftqy4pgOsXP
	9cHDhHrW+06CT2BPpGrzGjqmbn0ieoFQLnA5RpDqh16MkmQxRd4aXlKgVPG7YRa5hlm1w/x1JKC
	XEPOOIjC7jdNlYY15xmiZ7PBCKNb7TGyJ5LVHjrWB6IZqnAOqWEQJBRcKETZWaNYuY/mreQg6la
	9zeQuheebfvHSEWPbF8uMXZFhsWm3zL7A3HWrNYVFmq1z/Mo3DxKrzN9vYUvg0cP4pLIBcLfWhT
	/sxmIqApbJ8wG6srTvKR
X-Received: by 2002:a17:90b:3808:b0:38e:76f8:fcbb with SMTP id 98e67ed59e1d1-39d9c2249c2mr15929475a91.4.1789334092888;
        Sun, 13 Sep 2026 14:14:52 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b348cbsm21382925c88.3.2026.09.13.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 14:14:52 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: miriam.rachel.korenblit@intel.com,
	linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	emmanuel.grumbach@intel.com,
	nika@nikableh.moe,
	mpearson-lenovo@squebb.ca,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Navon John Lukose <navonjohnlukose@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v3 3/4] wifi: iwlwifi: pcie: deselect the product reset mode at probe
Date: Mon, 14 Sep 2026 02:44:27 +0530
Message-ID: <c370900547aa57b4397e5ea9b7b456b82256ddea.1789333511.git.navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789333511.git.navonjohnlukose@gmail.com>
References: <cover.1789333511.git.navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The product reset mode lives in the platform's ACPI namespace, so it
outlives the trans that set it. _RST branches on it and does not clear it,
and the deselect in iwl_trans_pcie_removal_wk() is a DSM that fails once
the device is off the bus, so a later request for a function level reset
can get a full product reset instead, with Bluetooth still bound. Deselect
it at probe.

Cc: stable@vger.kernel.org
Fixes: 9673c35486d4 ("wifi: iwlwifi: implement product reset for TOP errors")
Signed-off-by: Navon John Lukose <navonjohnlukose@gmail.com>
---
Patch 4 depends on this, not the other way round. By the time a recovery
reset runs, the disarm in .resume has already failed, so the probe deselect
after the rescan is what clears the mode. This one therefore stands alone
as a fix and is tagged for stable while patch 4 is not.

 drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index e5edcc2..d93d8f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -4256,6 +4256,8 @@ int iwl_pci_gen1_2_probe(struct pci_dev *pdev,
 
 	iwl_trans_pcie_check_product_reset_status(pdev);
 	iwl_trans_pcie_check_product_reset_mode(pdev);
+	/* a previous trans may have left the mode selected */
+	iwl_trans_pcie_set_product_reset(pdev, false, mac_cfg->integrated);
 
 	/* set the things we know so far for the grab NIC access */
 	iwl_trans_set_info(iwl_trans, &info);
