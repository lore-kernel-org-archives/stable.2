Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67243CF211
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437339; cv=none; b=plh7qdbviCrOx1GtKzCS4F2emY9cbPAnrgzLJFq0UNUWIZdMd1bEfJtp1LOhEdaJ3cvSMn+DxlZXLUWXMoxGgQgf3noYkHK80AnOdmU0VZ+o8f725jO23mYy5Bghd81jKrTC93cYn6/oGpDs2Y1NbyDxH9rPOrbeYiXf7NNJ9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437339; c=relaxed/simple;
	bh=YSvTJwjDAjCvoWE2T05StqLkRwhDOCuesdzub+bU8P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3bgw49PcwxzVvEC+5ZUzakWnbdgq+2gPhxG5vC5rswwk4nZpBLzctop/2r7QiVRsk3P5fj5w2MVZTDYI4GOZXiCjtKO0Ak7XFS8VccS6LnbjgjcOreMgAWa8vUHi1bpwaYXfYXMJZh5ne6WfqFH2IBJZN5y+b3ZRtbY1rgecQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+GZCKmf; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+GZCKmf"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb7692a57so30520921cf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437337; x=1790042137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQzxIfg2AQzCkVpbVYXrLDBgU99fKCXJvWhA7g6zSYM=;
        b=A+GZCKmfuOTbccApiqULuH46tzXOjRXMUGLUEbjteF8ZhP8mPCWRUQPre5tNan3k+S
         eS9mxuoij3LXCk7BG1EaILuTIJ/sPZ/8A1NkNX+3JvtnHGZ0+gZuBbNxQDPTCABeL9dA
         RmVcl2E2cQ6ruP0wmmvB4HacfnSYB5bD8fwtTkpcI6XhGfpgj/tVIoqywwrsFgT+z70j
         IgsAdp2N8Uiba5O67b0JAfWq3KQcEy0srgiyHr+nCoKLEl0rnKme/iZd/Zc8EEaPOVUu
         /I4v3Gcrko/eSTEjlp2qIb2DxlyJl7WOW4a2yl2lIS5nVQNC13aw2Ig9ESk/mONy5dmD
         Q/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437337; x=1790042137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQzxIfg2AQzCkVpbVYXrLDBgU99fKCXJvWhA7g6zSYM=;
        b=VCFOY/5Xhqqiv22ycGfn/x3iTQgPJ+dT3TT4EnBfkdZxXLylb1OGvFObkY4AttXHC1
         JnRDk9a785Umx2sADC3chYVRm5gozgEVGnkSAJ13v7I29xmkVwLN5Aadw+kSfQEbMN7C
         D3EGihmQngzG6BYau1V/VHkVmdDMDmb/2Qi6JtjNkCTjWIDhi2wS7n+meuMCXHNAJvxM
         4pj3N7FuuM7FcXBqxdKYem+qt5RmsgOdJKq/leQ6DJQlJ3lwqCBJqkE0QFmOC3svyR95
         R9Ku7pVPtFFYucNz9rUaGo/PQlTD4JzZmZSey20E1v2ohL8oTOtW+wzLNx6xxs73UNum
         mZ1w==
X-Forwarded-Encrypted: i=1; AKwUvBzXWLHM3IzarRGXWaCMi3BvZ3/siGC0pn9kYCZIYMq8OW36s59l+K3b0wcw83HM1cQamtLqfL0=@vger.kernel.org
X-Gm-Message-State: AFuF++m3INF9wn97cOn8x92gtnlPS9g34HbRnEFUBakMFLxybeLuR3qX
	jZqm6cYDQN4PDTuu1cgyELGzqEveRS6hMtdUHlaLCzS0LAzlFJNRUhI=
X-Gm-Gg: AYBFou3iagHIaWAZUAfSIota9Cv2sXLR/m6WuMdeQaoTjFu0VFIFnXCU5OMbTfFDlYX
	8ndRUmTFtmctg7PNujgkjZvswr2uZOVjHsV2xBkBuIrPN3CqU+l4LR48mc725ECtJlSSsPuF5Ys
	6NgA7Y3I6q85/FzTRVHaBKvmc70coSk5LlVydW1dPeY1jLA2gK9Sncr0B2EGAAwQrk+jVqtUPS8
	CcHS9dqmKfFJpWrLBf9oWnCrJcH7qFRPq1F3buZF4pyeSr26w7Buj6iU9ESXqsBrWHy1SaKC+t7
	goBPHjXRV4saHqgGxi9o1u/kpaEyPQ3mIIjxciGVqoR4JAOdXmzGOFn3ClaJ2E1ioKhbmo/SeNi
	a4abhjpHBVb/3XKig9MKal2LvsUzj32TI5NNpZSMAWc1I27SHCXGxhyFcKmiHBCOcEnXgCzv3EH
	aZA2N8WQ1o+ooPqvHsDkFkAxkuGBN+G/bYgJMuP0wdkiqLRVn/4TNx0hk3xzLfgEPcCEsG/SdpR
	YwI0M4lhb9WFkM/3iHCDe3vuP4xD4pNMWyMk4FXkZ0lC80QsUTZ+6FmBQbCKZxFSkRXlPbhDpld
	D1W8rapdBH59nb+I7LPSzs8qTTM36tvrsUfeWrYKzJGJu5MkZ+w2Xud3T/TuItsHDgD4uw==
X-Received: by 2002:a05:622a:387:b0:530:ba79:edd3 with SMTP id d75a77b69052e-5310d09f26emr80280201cf.62.1789437336690;
        Mon, 14 Sep 2026 18:55:36 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5ebc79sm109264546d6.48.2026.09.14.18.55.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:55:35 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] EDAC/x38: Balance PCI device enablement
Date: Mon, 14 Sep 2026 21:55:19 -0400
Message-ID: <20260915015519.83833-4-mhun512@gmail.com>
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

x38_init_one() leaves the PCI enable reference held when probing fails
and when the controller is removed. Disable the device on probe failure
and after removing the EDAC controller. Keep explicit cleanup because
module initialization can call x38_init_one() outside PCI driver binding.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: df8bc08c192f ("edac x38: new MC driver module")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/edac/x38_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -423,6 +423,8 @@ static int x38_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return -EIO;
 
 	rc = x38_probe1(pdev, ent->driver_data);
+	if (rc)
+		pci_disable_device(pdev);
 	if (!mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
@@ -439,9 +441,11 @@ static void x38_remove_one(struct pci_dev *pdev)
 	if (!mci)
 		return;
 
 	iounmap(mci->pvt_info);
 
 	edac_mc_free(mci);
+
+	pci_disable_device(pdev);
 }
 
 static const struct pci_device_id x38_pci_tbl[] = {
