Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F13CE0A7
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437335; cv=none; b=CCs8rIXDuGJHojtx6RkP/GrEFbGCPaUmJP7Q/f1GcgPa4xjFDUMjdAilGLPut60biD66+CNz/pi881xSefRwPM/QWuP1coJYQp3cop/IVIxc9Rz2pb0VpE7gaxBmBqn+yGq6yS+GrABbjs/givdulaHKV+2engP40tFqphJigTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437335; c=relaxed/simple;
	bh=H4sOniYLWo6+KB8DHXp68YHJ7qte+sqivFhogKC0E20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQFJdcfLI5xJpS+x8gWEthX1U7PLybWG/qBhsUB3V2p8N3D3S2ahQPtm6fTdvz1H75tTibANGTyJiFo6WZi7sU5ZRBlshymaserbZQqrOl/TZy34DkAeo+t0kQKMbAqQzOQEHdVbi6jvtk8VBzWwmSPbyy2qpDOn/C0JuXVIA2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUY6W7KI; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUY6W7KI"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5306d609317so38404081cf.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437333; x=1790042133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AiIvJCNExljMSljYlzye2b1G5pTXXWKqhzAs8LgW/vk=;
        b=JUY6W7KIpVOulb7t/xW9eD9JTVGNgk7pntYkjaevhtf8+GXqvGNAmyxwls8kr1BE0s
         n2jReTbFh7bphN5veGmmBK7LyvF7tq1mh40oJWnvCb7ZPBfInp6CjN46t7Xkj5kawIPY
         PiqsHYjCb/HbxkpZB+bnKhi81kyyF5UfeHB+6Yg01pIYft0ur9oZAIvjDZ30Ws0w+yUE
         6o89HcdzZY9HtnEW9jG+XT6ivcTL7J+q0cIQaBAlgKRRkrESsEtbScy4cvsUuDKX5rXG
         7NZu5uySQ9YIigwDyafrh3H9a+vQEmvxU1fRzr6xdU/FeAd3fRaCdpXqTIiZ6u0cDtEU
         vUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437333; x=1790042133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AiIvJCNExljMSljYlzye2b1G5pTXXWKqhzAs8LgW/vk=;
        b=WqsFjy/1IFMhh1ehyFhCLQjLVGsfjvkNLqQTQ2fWP2iMqjROIg9q4ALIceNRl70lj1
         N7Kh6UmJic12W/GHYwr9XqYDE1gg+tfL21x3UHq60R6CAkk/O+m/yrfM0IYzbncMyQt6
         JOXj6G320z4VOdebGNsm07KEYyrNT7cIft4tMSt+n0AyzrtA+FU/3+6kDKNzW/SH1M0p
         csnHbrb4rCJuYhP8c217Bl8dEbbAjgXh2FFL8z+n9y31dDzqJzIjOjSdh/6JXf9Wtbk3
         9kjywUdJt31Yrbtt/5l75evOpHHUxD099J+36zTvzwwFcHgvL9BriTxFobMKE2aU/KcB
         CSOA==
X-Forwarded-Encrypted: i=1; AKwUvBy2bL8CwbMuD+UkaavOet84QVuN18vAHnhnkoZFoPS7AOofonyS9+J9P2Jna0qBj967+EhC294=@vger.kernel.org
X-Gm-Message-State: AFuF++lVopeeqosNQwLlauN7XdsquNYHLnSce+8lw0+UZXedX26jHTug
	3o42I9sXdvf2pUa23Gbz2fTZQknE7FtTVCtebsvzM8AQ1G2hWuwXcexbGHVHE8klog==
X-Gm-Gg: AYBFou1Zr9buXbOplv7Ktx6PzdNDne27/j+bfBKKVqgBNrg4FbJFs2wOSNi3WdUznDz
	3fedqBSIqSlH5ao9l1TKkkeKlmqudv+XKh9v/WKCckVRA7I4gBgyExXsDTipmCwOXPu9HbPMnyf
	IzSlu5297PeSgXSAP6ZlwwtvE70KDTVyRKg62iJux9zr0/S0BZb8kAnGBcJhXQHCCLwupvlKAdN
	i6sS29a1jttPtwBFmX3smfIIjOwuhObQmXccdBcAXAF91BVZr0bpSY44G90M4l+TYQNOe/+vtdQ
	+/4/oTPY43svISokZzfrqcCfw6U/+Rl904xdpbWBkNL8/bAeNUG2puExbb1d+p/Sq0v7+8tggKi
	l682J07GIOtF8+gNCBz1WVMi0aXols1G7GMkf2dkVWZOmYZNDslc271mL/7Ejq/hLosCFwKD4CA
	q3D0TwvV5HC2y4xz5YnBfjn9xp7GFRLcD0nkAe/grOhVN/CRLwubMmYzcZJDl+Qcv0r6Un033rK
	Zj4v0hlFkPzWFBiO46qteaUZVFTrFXcqA5O6FMfsKimaKgWkHOX+Ry7gTAgnZ4aioqV/IWvJAtT
	WafAiovwVkCcACNbdH5BiZxiwTO1IVr0JJYH5mgDDRAfz6MwQuwVjRGWKXUk2WTcngrFCQ==
X-Received: by 2002:a05:622a:2285:b0:530:d491:d168 with SMTP id d75a77b69052e-5310d03093cmr74722151cf.34.1789437333195;
        Mon, 14 Sep 2026 18:55:33 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5ebc79sm109264546d6.48.2026.09.14.18.55.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:55:27 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] EDAC/e752x: Use managed PCI device enablement
Date: Mon, 14 Sep 2026 21:55:17 -0400
Message-ID: <20260915015519.83833-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260915015519.83833-1-mhun512@gmail.com>
References: <20260915015519.83833-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

e752x_init_one() enables the PCI device without balancing the enable
reference on probe failure or removal. Use pcim_enable_device() so the
PCI device is disabled after failed probing and after driver removal.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 806c35f5057a ("[PATCH] EDAC: drivers for AMD 76x and Intel E750x, E752x")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/edac/e752x_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -1387,7 +1387,7 @@ static int e752x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	edac_dbg(0, "\n");
 
 	/* wake up and enable device */
-	if (pci_enable_device(pdev) < 0)
+	if (pcim_enable_device(pdev) < 0)
 		return -EIO;
 
 	return e752x_probe1(pdev, ent->driver_data);
