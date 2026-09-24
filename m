Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A248095A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261045; cv=none; b=otyOprQhGfIFQjKPD6dsBx6A8ihtD199Oz2ZfSkVj1WT49NC+xZiUAfK8QiReu4lsstIk8bMMmt7tOrSL0bLwc8z05CdRzSSQCtszk0xYCFVfqOPB8R2mP5PNuj6L5/deKk4nJyJt8mgMCO6wORbmUV6+6JtFexeBIF2aJqL7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261045; c=relaxed/simple;
	bh=sLJrYImmpj7cDJOuqV/tBWAPnB7FJaQ0Atb+mCiWXi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvoL0Mh8FBpH8rkUXg4KTI1pkDkPo0cCpUYOsW20BKcbCD1cOhs/Jlue41zGefJtjP10uC5Wv2jbtTIA/omViP12WQxFXQJWnrIw72VtKJx2NO6fPfL2yeSnZQiq/whtucU2Yn2xNtT0I0S3Yp53uax/rB5k060iYXN7cQc9Aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRTmxSRw; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRTmxSRw"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so950492a12.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790261043; x=1790865843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BDZWmJgca/oRmUPYb8QTvKV4Z0J2CBYz2565yw2xf3w=;
        b=WRTmxSRwis/UanTHeTpTr3J+xKDuEswXPLqM85GQUpLA/nrg53JCYR29/+Rq85XDsh
         GfeQlM4/pYrOn8QYFuDdi3iu0UTvYYr89E+ZAOo0fX1HEs82+VZrRcEyBNU1wnnz15K+
         0NC/hz5ICDbY1phbxfEyx/1K2pSUiI3prBXr/+y56ywh82o3hYrtMznrSol+vFdjpyLs
         Cmc4GUgBeTxJ24sT1H5cqdiLfQ0/VA1UHy+rXbSLJfFuQ/+rQXjnOETlrIF7Z+pmkSIs
         q3B2bfKa0BajiMbDL10nb4jaHYXFJMM3uZu1qBDBD30JEy4Z+i1d7vHwUP1t4B+vyNw4
         ZQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261043; x=1790865843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BDZWmJgca/oRmUPYb8QTvKV4Z0J2CBYz2565yw2xf3w=;
        b=oJO3HUG0Lm1RlC0g/ZzF/N9smwYI/vGE8noAjkSa6m/eZ0djgiuiI9qJDQY6XgtIVa
         SBawN45WDICJ1mg9sBsQrAH3LlMvhnVryKyjwhOCnBeRE12B3u1hLwNaFD0f7s4RB1qm
         wrZsVdVXLXT+9JvohgevgDNPxOxRff6rJzI/CbOj4fABCX8FAwiun+/cwh8peO77dnGB
         enKixTlTmQ8NEOHHZKmuOAx5ia9h1SV37x1YtkOB9xUezIbB1mwH2Z9vsPK2SaHnQsdE
         3oLo6BSgFvkNu1Y1s8MeGJxk5ezq9a8mi1t/qUuX0KLw8tYfQLHxaEADCXXpRuSX8xOM
         6SBQ==
X-Forwarded-Encrypted: i=1; AKwUvByiw+E6qiSSMxFhHrjgUxbGI2ID41pmo7ShDxeIFPqEa50nlD0rqDZ1kVVAkyLNPgqfO0srf34=@vger.kernel.org
X-Gm-Message-State: AFuF++nqcrsTSGDLAsnt1aFgwlGjkQhc0wKAOnYb3R1/rW9/fwY0U0qn
	iD5DtQH6clNm91WY6VoNd+PxzHxchgq2r4xVE1BYyPmfalFB9CwPBE3FH8Vn586e9hsF1A==
X-Gm-Gg: AYBFou2dYN6sALlf/sCvDo4CqwtiC4RsMe0WN/1DOhZV6ONTGtxtqP15A95SePrZSvN
	xYK8beLNKglvEJprTqzqKEf34WZACM3ku68y7rsqfUxez+h8wZxKKGIUQ8ijGyoNgdMYqzz0trw
	6m2vRof/XiOAH7llE+Z9uOHUpEpNTQ6ukZTXO4EkbAiC2X97quwHemK+DzXJCJqmbUweOUXJo+w
	OX/QUMlCUmWmV3+Kis36J3ho2vBQd1d1vfrzdi4+qSoApOb5QU1qPLIalDeOfMGXEoh51c5MLAF
	Eit4M92265csw6e7maneWi/nvNWbhs964bTK9Hq9RPvuJda7YHb2bsKC0wETK6HyetWYOP+gzXe
	WEDlfbyAZq4HkdDJVc9i5fLI7B9RQns2Va58QnyRnOI66NdedAs4f8O/gCLIIov4vve9Q0yn/J+
	Z4VQjhe9mGT6/5f3BzyCL9lewH4BDpxGDqqmhDAvMZCpV04c9yMN6nXUd31YLQzw==
X-Received: by 2002:a05:6a20:9149:b0:3d3:ae40:51e7 with SMTP id adf61e73a8af0-3de0e762e07mr2709521637.27.1790261043213;
        Thu, 24 Sep 2026 07:44:03 -0700 (PDT)
Received: from lgs.. ([47.82.103.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3f2d0esm2982721a12.22.2026.09.24.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:44:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Ludovic Barre <ludovic.barre@stericsson.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Julien Delacou <julien.delacou@stericsson.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mfd: ab8500: fix child device leaks on probe failure
Date: Thu, 24 Sep 2026 22:43:55 +0800
Message-ID: <20260924144355.1604369-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ab8500_probe() registers MFD child devices before completing the
remaining device initialization. If a later MFD registration or sysfs
group creation fails, previously registered child devices are not
removed.

Use devm_mfd_add_devices() so registered MFD child devices are removed
when probe fails.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: cca69b67b3ba ("mfd: Export ab8500 chip id to sysfs")
Fixes: 9c717cf3fa16 ("mfd: ab8500-core: Add device for new RTC version for AB8540 cut2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Use devm_mfd_add_devices() for all MFD child registrations, as
    suggested by Lee Jones.

 drivers/mfd/ab8500-core.c | 44 ++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index f0bc0b5a6f4a..55dd9ad285ae 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1194,39 +1194,41 @@ static int ab8500_probe(struct platform_device *pdev)
 		return ret;
 
 	if (is_ab9540(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-				ARRAY_SIZE(ab9540_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+					   ARRAY_SIZE(ab9540_devs), NULL,
+					   0, ab8500->domain);
 	else if (is_ab8540(ab8500)) {
-		ret = mfd_add_devices(ab8500->dev, 0, ab8540_devs,
-			      ARRAY_SIZE(ab8540_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8540_devs,
+					   ARRAY_SIZE(ab8540_devs), NULL,
+					   0, ab8500->domain);
 		if (ret)
 			return ret;
 
 		if (is_ab8540_1p2_or_earlier(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut1_devs,
-			      ARRAY_SIZE(ab8540_cut1_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut1_devs,
+						   ARRAY_SIZE(ab8540_cut1_devs),
+						   NULL, 0, ab8500->domain);
 		else /* ab8540 >= cut2 */
-			ret = mfd_add_devices(ab8500->dev, 0, ab8540_cut2_devs,
-			      ARRAY_SIZE(ab8540_cut2_devs), NULL,
-			      0, ab8500->domain);
+			ret = devm_mfd_add_devices(ab8500->dev, 0,
+						   ab8540_cut2_devs,
+						   ARRAY_SIZE(ab8540_cut2_devs),
+						   NULL, 0, ab8500->domain);
 	} else if (is_ab8505(ab8500))
-		ret = mfd_add_devices(ab8500->dev, 0, ab8505_devs,
-			      ARRAY_SIZE(ab8505_devs), NULL,
-			      0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8505_devs,
+					   ARRAY_SIZE(ab8505_devs), NULL,
+					   0, ab8500->domain);
 	else
-		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-				ARRAY_SIZE(ab8500_devs), NULL,
-				0, ab8500->domain);
+		ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+					   ARRAY_SIZE(ab8500_devs), NULL,
+					   0, ab8500->domain);
 	if (ret)
 		return ret;
 
 	/* Add battery management devices */
-	ret = mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
-			      ARRAY_SIZE(ab8500_bm_devs), NULL,
-			      0, ab8500->domain);
+	ret = devm_mfd_add_devices(ab8500->dev, 0, ab8500_bm_devs,
+				   ARRAY_SIZE(ab8500_bm_devs), NULL,
+				   0, ab8500->domain);
 	if (ret)
 		dev_err(ab8500->dev, "error adding bm devices\n");
 
-- 
2.43.0

