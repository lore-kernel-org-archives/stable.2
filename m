Received: from mail-pz2-f28.google.com (mail-pz2-f28.google.com [74.125.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A75463B9F
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460564; cv=none; b=apEIn9rL/L84vIU1A2QHSA3Vq61yxQE1ztdbkpP2xN4RFo5934vxhhqWjVmPKKTdbAwBUfEk53TLhtir2k3n1JX1TXUxGuTMHZmT1dru+Ji58FdcSTS07m98PPiuTXm/0VFHwbmIbKGiysojWeouSULTh4+tSO57YjJ9CEh32UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460564; c=relaxed/simple;
	bh=C9KYtPlI7ZMCyFQ9z0YFTlmCZFRzUMM33buNbWt5z4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPn1KCNqNjBCTwrkcQ+X4xPKwSPeACdR5qiTs5oi1YYhx5HaDfH7pt+5MhhShq4I0r9d0UQX+9ys36nA27otIkI7jxzXRKJDCyGwgDnIeIwU4ihXX04Cx7t9RCcweZIOlb6JY6+tDAcL9pbcGkwGx6F3N/PdrAWA72Bggl5wkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELK0ebjI; arc=none smtp.client-ip=74.125.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELK0ebjI"
Received: by mail-pz2-f28.google.com with SMTP id 41be03b00d2f7-cc4ab4fe290so713381a12.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789460561; x=1790065361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnJp0gFL0rnbjTXBsTtZtrnRTdihrTDqa0f0ZnMfF0M=;
        b=ELK0ebjIerWSvbTWmvxCOMc++ii+a61Ul0rJ1Z8Arju0vBNDUk3FS1CD2LKG8PvkRq
         f3qFcDs8GnIk+DSQJW38UXFMyE3euIlVR0E8/BWBjTAzmHV1DJCDyV6YoxWquL69hL2c
         218vBGhDlb8jEgAG12xuGkUWuVwtrtOdTN8xBNMJgou9ke2V3dvBzjM+VIzEbgyOpj0o
         lfmh1QGBkgSsca0VyrDiGAvpqI62mKsyICApKjxTp+UJSg0bqx9xXqxAfZQUbZ3T0uiB
         juBwC+NUuKqEODdkVxBM8HLHAiVn4T8XJTjyp4vvbuqG7CcEdULzDoYJdtvpU25Ji1To
         FpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460561; x=1790065361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnJp0gFL0rnbjTXBsTtZtrnRTdihrTDqa0f0ZnMfF0M=;
        b=C4VqMmbH4wDBUHRGYUxpWdDi1HOubpS+sBEk4bH7GsgF+FxjAOOQhclRPdRlz3Ha+5
         79zymYOmlxZD6rb2LH7D3XEBO6cRUIFigQO1PUVJi3auuOqRA1yavTiq/MjvxTlhZoiV
         mEFmXVVPiTFAwRb2/e8lD4Vhx6zwxv4VumCic/yGM+6y0Lfg3TbWU+Si+HXGbbYo9c9N
         AcYK9VLblvg8BiC8r7l2MTxXVM9qB9/LuOE24vihnM986TwzfgX+wiOiD2vZxQDW2Jhl
         G84LxPbbcMzFcNMlhh+7rgrvbRMFmc3kI2C0cOoCLoRNHvmCUeIs3PKCNPaT9OaDxedy
         JTvg==
X-Forwarded-Encrypted: i=1; AKwUvBxkEuZnLvsorIUh9yoMkKN8JUTCCLXj0CCec0QxPmNvRlPLClJijDcdMnfUOK3xgr8vHRd8fjM=@vger.kernel.org
X-Gm-Message-State: AFuF++nh6WeEu7CuzsFEridLP0G894naz27Yy6yOMVi5FiMb7maMHCrm
	1NiTjiPgejU/LKKUK7wbe8eXVjxnyEAeSvKAum2RQFSlU0rY0E3fgnQWlNgq3RRk
X-Gm-Gg: AYBFou0MfHG3PPNHbbLt2iX4SIHYgt3JhmnfEn/xEDESpKZUqDos1rE5oMKhCFj6Xxa
	hgDl+YaYU5vlfpBztKD605xChMhwLrd/yGABZB4m5rGDxxAVsCPofAKBkJB5KbcP5Mdn8qRAGzt
	b+7qZY+7YKxIOAYwna29sqwDw+zOw+FwOVHnnI7kTCt7HlPThcsIOaIkc7iyD+80wYBB208J8Vp
	dFI0uu4XLwUB+0aTT0Y276rRHHMS5wFf9raytIWg1Po6y58Cnwa4c5F4o6JSKIeJyI2EEPp3hJ7
	y3oUaWEK75VuKndF65mZTptjt5AG3MsKSimYj9o/5Jt8ArDJjj+t7JfYtoXeWGlgDzGwQ/5XatT
	qMJPMeY5OBOm4rMVlEp9Fs6sgtzv4yfxv1qFKtX6vFgyKdj22mKmM7eJijAP0wBv9rzakKzvxsN
	RY2vFBOXOYrV/lyGfj4UlFTxAnyhhqukPzAfleiwhCCtnhUbDpJGlwlA==
X-Received: by 2002:a17:902:ebd1:b0:2db:2c05:5d92 with SMTP id d9443c01a7336-2dd764ea0abmr38594445ad.8.1789460561120;
        Tue, 15 Sep 2026 01:22:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca26cdsm63466485ad.7.2026.09.15.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:22:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: imx290: fix runtime PM reference handling on probe errors
Date: Tue, 15 Sep 2026 16:22:29 +0800
Message-ID: <20260915082229.2235439-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx290_probe() takes an initial runtime PM reference with
pm_runtime_get_noresume(). Historically, the probe error path balanced
that reference with pm_runtime_put_noidle().

The change that moved the successful-path pm_runtime_put_autosuspend()
into imx290_subdev_init() made the initial runtime PM reference get
dropped once imx290_subdev_init() is called.

The longest probe error path, however, still falls through to err_pm
and calls pm_runtime_put_noidle(). Failures from imx290_subdev_init()
or v4l2_async_register_subdev() therefore decrement the runtime PM
usage count a second time.

Move pm_runtime_put_noidle() to the imx290_stop_streaming() failure
path, which is the only error path taken before imx290_subdev_init()
drops the initial runtime PM reference.

This issue was found by manual code inspection.

Fixes: a92651b8e288 ("media: i2c: imx290: Avoid communication during probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/imx290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index 21cbc81cb2ed..c2cdb1557dea 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -1634,6 +1634,7 @@ static int imx290_probe(struct i2c_client *client)
 	ret = imx290_stop_streaming(imx290);
 	if (ret) {
 		ret = dev_err_probe(dev, ret, "Could not initialize device\n");
+		pm_runtime_put_noidle(dev);
 		goto err_pm;
 	}
 
@@ -1662,7 +1663,6 @@ static int imx290_probe(struct i2c_client *client)
 	imx290_subdev_cleanup(imx290);
 err_pm:
 	pm_runtime_disable(dev);
-	pm_runtime_put_noidle(dev);
 	imx290_power_off(imx290);
 	return ret;
 }
-- 
2.43.0

