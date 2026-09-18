Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CD51812C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753396; cv=none; b=Gk78tzjtjQRfoS/6FZjKOwtL/13/ORAgCZPavj9dVn5XyuCGYwkBGcdD6rgdIy0p1aWVIQbf/+fWNP0SWj9rUgAcoVams2yTYMvGdEdCsbElhVAiRSLU4tPeueFFRXuLoMTHYvfzaq8CjDqkcU1y/8HCVIpnQWZq9JF694kSHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753396; c=relaxed/simple;
	bh=Uq8QRraJyLtZrRNTXaeWCRTnd/mRf52zyf3y/Vh9vqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J3upUrIV8iUozdglfa2lcWf3rbujNB5o2JHsctzkogekmNbWQAge/7XS+cD54mGnmk0vBBaJuqYXev0cbckmsc/j9vmIkkYTnaeEm7VtY1Di1c3r5XEIlauQKEpptGnmSmXHKMSaobr9P3V0LVOMIET7Tzn3Mxj32T3/PtB/UVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU+h8xfH; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU+h8xfH"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f20513so1049376b3a.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753392; x=1790358192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FIRlGwxrCdrjvee4osJgbOjkfM6UpiYBM8dMdM5ttdg=;
        b=UU+h8xfHVniiUKDQWJ5AVEV7NEpFnJm1eZuxjtwdZv7Pv0juY1U33W1eqVQyn6mO1s
         dGRouxQltAochZ3tSJa4v2BYefiwJcHIl1cgWEFAMG0hvWF9Kfr+CtxL6gpkQ2Fo1395
         fQxhU2ZCjOUTd2RP7Ee+Qq06TPkKNfYDRBDrlGLoSvfmzNqZA8duXa5swNYL7hlWKKKG
         sAzekTWNFWxs6w+OaVRweuWQFWLjMCjpmpRBN9bph9xAPsT8CzfQNqOQjidS29ZdOvtJ
         ppe/1UG8RUlTCT2g5in+XEoLZGnQoDXwNP3teIeEmPd3ZPB9/mopYq7wuPWj4dP49Ii6
         9URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753392; x=1790358192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FIRlGwxrCdrjvee4osJgbOjkfM6UpiYBM8dMdM5ttdg=;
        b=Vz2whZYiuG3Rl7oXl7Umtt20AGywe0xEg6IHnFLU9eLkrngjQaTpCrgqPac0Mr7c8N
         fiYbv/FlSgAYFxr6EZbfIe+92YFvDvDruapqV23Uhbec/jAvRIyaPUVNjv1HYp3/ceta
         PtA9+jZZ69ox2N+6tq8F42xGTm2UoibbOOyMmwKsoDOhv8vAHcvfmqPDt3e/gcskRvgO
         Tv5j65JXhYMmGpm+hlm2GOPzPrrioS/jSLkDZet5NpQT/ZXPU6rraLeJWdKgCWnkU5A5
         ffi+MdjLBpR/BQK1FktwxX8MmHu2o9PiFBJWJ0KjrGbmex8efVumzkNUQiZjaqq0cRV8
         US5w==
X-Forwarded-Encrypted: i=1; AKwUvBymFI9+gb9w/7EUX0wDp+HS5urxoW29i7QW7h22eebBdc4IGaXQeAbi5J3Bzp0ORHtXmzi9sa0=@vger.kernel.org
X-Gm-Message-State: AFuF++kEu7IyYIe5bhNChVcxbFvk+lFfLuw+Aa6E/p6PkQrTm53dv2ac
	8W5bwa3qVPFp+2NwpZfL7B8z154KsEHVtndlcO6WvSmWKsb7sLR9TEbd
X-Gm-Gg: AYBFou2BVRY9xvfYV3JKRztnjSQwsJSmT2kZyfp0Xphfb4EhyCr8eJcPHFwttAMUQZd
	h//hjYF//fwkZVOxTt9jDBBzFnLvMPE7Qlik7xSCE0PiW3WMMt6+5zLJ8Nk4vUDNpYPAX/qk++z
	RcaN2RMVd2BQsygzMW2CSdmVL1HBKNu9tSRLP8wiaCCTd26OCez7irr77aha8M8GS1zZBG2ItOW
	s1hn9Db0Xrt7CMizrgw5oPyFwHooza2IP/bOp3tByiqFubAiCI1jkRXBDhP/QrO+B5XBVKB+PXp
	akVYY5N3rNfeclxhYqtNlU3tPV5mCVrUVSXH+I3NmhlaUilmJB1V2G2MRyReSy8AtibqiqObn70
	wAruep9mx+cAMAK83AXh8NIKEu/XgLnoKArvsmVa4PXDLYm92iCShePxep5iHumh9eIBqoZowqO
	ThJBtX8Jjj3zDKfPXvIjgqMGKmLFWLVk6ZE3ZySl/ljA13YN76xLLe7Q==
X-Received: by 2002:a05:6a00:ab89:b0:84a:29a7:f3b1 with SMTP id d2e1a72fcca58-874decf5c32mr5978246b3a.16.1789753392137;
        Fri, 18 Sep 2026 10:43:12 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f4fefsm130384b3a.25.2026.09.18.10.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:43:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: sim710: put SCSI host on remove
Date: Sat, 19 Sep 2026 01:43:04 +0800
Message-ID: <20260918174304.3611005-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sim710_probe_common() obtains a SCSI host through NCR_700_detect().
The probe failure path drops the host reference with scsi_host_put(),
but the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
device is removed.

Call scsi_host_put() after all users of the SCSI host have been torn
down to release the reference acquired during probe.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/sim710.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sim710.c b/drivers/scsi/sim710.c
index 408f37003748..c3454e04c1e7 100644
--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -153,6 +153,7 @@ static int sim710_device_remove(struct device *dev)
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	release_region(host->base, 64);
+	scsi_host_put(host);
 	return 0;
 }
 
-- 
2.43.0

