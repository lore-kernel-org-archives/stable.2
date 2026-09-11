Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D435F170;
	Fri, 11 Sep 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128398; cv=none; b=Dx5ZuwkoDtXc3kJuQ9zL4lmWT3Y9zrOsFYPJazo8u/Fl+8L3pffbyq8JAsc8yIKDcpADrQy6lxkonIfYTrZnGb6+yLyhKQZ07cTZBg9fnBOKNbYNI21KvqedHOTTMpPDzRewEDIRoOSKUFnW9V4YliYkznAfPmCbjAv/JY9uPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128398; c=relaxed/simple;
	bh=S5i2kFHa2lCIsrFoOaKdSys03HuTz4Df1rLQT9Zb3cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTKwtxJd8gUKn7xwzE4x+Gq3n2o+3wthdSkRmqDaJLRcjs9+xlC82x3iXPQ8Xn/F0qdja1H/ynPYPfo2a2E6+qVdaAGW3QekH/BXb3eIu2ENzjCwXFwAXhNcTuG1rw5zNOAw8mOTc6gXOK/UmG4liL4wz8SndDeB8IhtA7aFlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBWQnN+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBWQnN+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E831F00898;
	Fri, 11 Sep 2026 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128396;
	bh=PvNORlvLHsmxunMJ1CQzAPAm3uXM3Ldh9UdzKdd90zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBWQnN+yW6EbD7cGh8duOeUB6FO82QrU85ietJUUd8kpJnDAdH0dPiY4TMTnfaadT
	 gmDfhsbdeUmYULdPj74uU5jxdA8ujTXycO9Dvk+PRzhQB3o2t/3plZnew1SUoKUke5
	 JN5+EfmVT8quUWL3OlKx39B+Uk317eXgCZHRxUIpdKzqd0uJtOcF1xTsMTH5/lWUdt
	 OG0AGadLp8+l2HZ5EUArXALIzb51X0iLFYQUouONOfgbCv+imfrI7QCgPopkHlASRT
	 iJ2hFl7S3FbulM5pgPqFT3usb2nPmrKoAjQKCOM2i15CBSHdjJWaI0Dn1qT1SwQhSQ
	 ibk3YysuMCQjw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	linux-edac@vger.kernel.org,
	rounakdas2025@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv5 3/4] EDAC/altera: Fix code leak on dci allocation failure
Date: Fri, 11 Sep 2026 07:06:26 -0500
Message-ID: <20260911120627.2634225-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260911120627.2634225-1-dinguyen@kernel.org>
References: <20260911120627.2634225-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: If devres_open_group() fails, the function returns -ENOMEM
without freeing the dci structure allocated earlier with edac_device_alloc_ctl_info().

Free the dci structure if devres_open_group() fails.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v5: add missing } to fix build
v4: rebased to edac-urgent
v3: No changes
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d8a3438fb5f44..ccdfb35178b69 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1516,8 +1516,10 @@ static int altr_portb_setup(struct altr_edac_device_dev *device)
 	altdev = dci->pvt_info;
 	*altdev = *device;
 
-	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
+	if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL)) {
+		edac_device_free_ctl_info(dci);
 		return -ENOMEM;
+	}
 
 	/* Update PortB specific values */
 	altdev->edac_dev_name = ecc_name;
-- 
2.42.0.411.g813d9a9188

