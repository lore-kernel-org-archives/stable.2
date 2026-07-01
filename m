Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC2C40681D
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906016; cv=none; b=qUWJ/+UsdWN5mw0m4PX7QZCHeHQeP9lQ3XRziRFhqSn6DH69vc9bNgYI0EABpBwEuqUAQZ8zJpJ1nLquspVK0YOKZiDjXvsSOKPcxaStT1DQ3OyvEFA/vKKppbnfRof1ksTBVwcuwPNJwrUdHO6e85Wg+1dUqGT0BHJB5H6eGYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906016; c=relaxed/simple;
	bh=Re5sa46Y0/VZaCjTaqs6KcFdiUfTXL1/i5WhJPbAY0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=erxWSaS1ufGOVWXRMjKW+INgBQ1DUkoI0ZPzOMEGt0QomHdjsITbD3JHQvs6zcuG/iFvgUQ2xX2gxKMdUDNi9oIb/0nW2VVDtamQ7rHOQMAo7OjX18Xf8MCSxcUadnJrvx+qhjBui55WYXP8hYcr3BF0YIoEXsMQtBhAJdZYbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zeq1BMag; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zeq1BMag"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38060005f1cso877228a91.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782906013; x=1783510813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tyFzszev+usYq40ARSSCzs6vScHOVyEQ8o7LSEdBPeA=;
        b=Zeq1BMagXyXrIpheTCUhmTFpi681odKjO7oUFvzPo8uDISU4mYvQ0ei2lxOST8SAse
         qspQvXVHRkddFdERTTzR2gcTYcGK5xAQKhT0cPeCTdgigj8vQ1CUaOepPdLs0krACZcU
         JyX19Xyy4G1QqWYzOsGPBADq7bf2VBOcETrg+Bsxt1iMFXA3Gq3mO/f20V7aHRL5bjP8
         i0N+Jct54lPBnn/lwBFLLjaJYs8NIconncmcJr2gsF92isAdArlEHhcU1eKLGo6p71b9
         MZ22SblD4HrCJ1U4AJrbTHn33DDPtRTIUIYhi1ipSpvvRdwwJpKueBemz3wqOWRnGG2g
         gaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906013; x=1783510813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyFzszev+usYq40ARSSCzs6vScHOVyEQ8o7LSEdBPeA=;
        b=rWZfMqGzs8cC2XL3R8iz3RyNOMnXAPcKlAThQjbev2Gc5kcf/bfFj7fsdhKtGFh7Mx
         rTcWRzoaRfheAHatAk1SkmxNX/h6/Ru57v3NVev3d2U65KGzrhFy93n9bBSjd9TFLdTr
         70JBEU8C/ij0usJ0HIgkzVYRdrQ+fmg5QV8qPFmWW8eaLbhxQDi8cJA1Gvl7YJq1qXze
         TuqLOW5OCxq4uLiIdGiQHpJMpqDq/uuZlZbDRdqCQ6oWtRT4XJH731nGVW1AYJGTeOLc
         ug0QRbG9qwCck+pDfY78rZOVKDjg/n0mq6t2dwupk/PQo2UsNPB9NzQ7ZoYq3dKJwfhV
         9w8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpT8DSw2hT+oHPA7LPo20ebGKZq49Xwb707xe79qO8fA74NgtZlTrA5JIWhjJzUfq55EUYUm64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfzx37r2C6lJiExDo9x8p9UOlBbqIBskDzcJ+msw1Yzl9jSO7L
	wfbJ0JfNi35/OyJDnJvi5k1SHfRqUjKreOiHwLw7oV60e6qCQO8qO3c=
X-Gm-Gg: AfdE7cnwLZlD2c0Iizd4CtgwiUX3k2IHhJK0x18mxmvVpD57EtYopXIATKXVFo1rz2s
	o0O/8e0iFprYgz0ZncfN6ikUqMKA1kX3571aE3z/Q/7zTY/xIMHy9xeyv7b4zZQwdTCFrQ4TSdq
	64gU0g2lyD+uRFFAMnvxKxPxPEU/E/UXerqBefgRjC049wEcywXYyieqQzDMWPbIEwziDuFq51b
	gwmDu6zrXfmKSNHyRsYHgxNh75uqkgp5odFUw/01zPnKft3NQJTKMYvKGX1uZf8SyMH6nqXxS1N
	zAYvtkHfNfUPV6u9BNm2C31M5SbjhJC3vNW6fSyJtjSA8ZuT+b1dQfGDqF188y/RiBZ6Ng5MDEV
	e5uM/1HCtPnmwsvmLYjds+IBYads7jug0b/BqCh5ww7a2oORRBrRq/Ef8N+Ej2IUQ2LU5PxebAu
	AZ1sf/mORU/b/mcT9ZqUPqA3NE/7bUnEYmFpSDr/3LhbLzm0h45lloGvgZ0htc3Ndrx7iQJrEhA
	nppGITDEclfvNeuvcA6LbT49kyqm22PEKkhOrfdvfmBkz23taLPiDU5cKbb
X-Received: by 2002:a17:90b:3945:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-380695868demr4370404a91.10.1782906013540;
        Wed, 01 Jul 2026 04:40:13 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095e83b6csm1776277a91.8.2026.07.01.04.40.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 04:40:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: typec: anx7411: use devm_pm_runtime_enable()
Date: Wed,  1 Jul 2026 20:40:06 +0900
Message-Id: <20260701114006.75738-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

anx7411_i2c_probe() enables runtime PM before returning successfully, but
anx7411_i2c_remove() tears down the Type-C partner state, workqueue, dummy
I2C device, mux, switch and port without disabling runtime PM.

Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
driver detach. Since devres action registration can fail, route that
failure through the existing probe unwind path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: fe6d8a9c8e64 ("usb: typec: anx7411: Add Analogix PD ANX7411 support")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/typec/anx7411.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 604868ebf422..41df115912b9 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1537,7 +1537,9 @@ static int anx7411_i2c_probe(struct i2c_client *client)
 	if (anx7411_typec_check_connection(plat))
 		dev_err(dev, "check status\n");
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		goto free_wq;
 
 	return 0;
 
-- 
2.47.1

