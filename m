Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DD3F8245
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644916; cv=none; b=ZyCzgGiQSuPlCBfCPC2YPnnpQv6M42DfcfMZEB1rH2ObU8TMBeotKapWF6RcInUiQ9P7Dwp/bBVoQae3LF1OvzTEdXiNELP9CWEimJaqd5UU12ZwCFZhyIj9yEyBJF68b5r17DH7EkAJCwn+eRdYhZx6NUOXSIzzPKAJ8mM9SHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644916; c=relaxed/simple;
	bh=4/VXWgsIRIKfrVHunlg8WMDRE+QLI3xVo05RjJxnkwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ucca0n3MlIUf/oerEWnLf46zPy92ll5jePLr+zSpa/0acrb86naxhY7wnfd81EMxh0D2b9/APOaZzG6zIj58BRNoQnph6z5RJl+Apj7DLlTMUjAfC0YOqui+13OQCW+SY+QLPi1y+ZiJp80M4SW7M3MWs3tWjnvHALvRVN7b68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5D+ev3T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5D+ev3T"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-845c92bc464so7087738b3a.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784644915; x=1785249715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAwfc5iFE/E+WtAWO7/fCyQvb8Oo2HFdE/v5P8GpI9A=;
        b=V5D+ev3TFS8adlNMISbPmTPOjrVQBd7yQhzN4yxinPOadXIxMCv5AeOUElfaXhbKmO
         D5m7JyDpEitvl2WRi+7LlkgFnlwfod8o59F54Z1osD04+55+El5dGw31h3LoKZzT83Xq
         /B9iXPj99a6G215x8ZTDoTBDlA+gW778IypZ0wK0rkZD8CX6cOls5VkntaEAk4ynzmvq
         V4Yas/Xm3uv7fIZoO5Q4MWzJ6o6ESBS/RFgNlrC56tzmo4IWHSvq9DHsa3CCstdWiDwC
         PTK/3ZZqeYUPKBBRx4gtb3HtOZ1FnTr5ZJzShL1qpSleTiwmEAI3jRTyaVkQw8gXsGdC
         4law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784644915; x=1785249715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YAwfc5iFE/E+WtAWO7/fCyQvb8Oo2HFdE/v5P8GpI9A=;
        b=Jkrtsqqad2kTskg4xQMHih0l9NvMwu9TZ8rwijgFTDEaTtoVAIYvVcX/Ows7sRrmIq
         dR9j+LV750RCga6vTd6P2d/10Wd0Wqw1FCjzqyg0x/GlYyPWo1T+FAEo5k8rp8Jleai0
         S2juBftrqsInfyaLGkU2d6eRd5W72M1nqAfZ5TDWYzfPIAcyN24aB9PuqMJbI3re6eUl
         kVKNwa3i3ww2c2nY8n13UR/6Jsn/kcqkQDsWS3rJtHcpM7rYYZt6NtQQri/KXliMmbJV
         qofURwN9vPBJo9ra7bgnyNN8dIUdlGSj0c9VIb2EnRZtQyFnINUiukwD/jvMBICxwN33
         gu0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrZacYbc7EuCIT5qNLiiKBs0s3oQGZY0DPvFhJUCHEeonuHvtw26byqt49p8H4gfXxDLhup5oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbUQ8axglHCbxZHYq4bIgPtGjtB12AbFg7HBbwriZK3pJfNoM
	cKeI2rtJMqtJLSycxFSR49/TyByP4bMigbg7KmjCsIs4FmUvtuSXJpo=
X-Gm-Gg: AR+sD10iAt6O0uLyH4uq8B/5iuQsVXHZOsi454QFx+3eZ79nKQJjUe96kRJzHeixV1i
	reusWsDG2pYukxtffnF1y8aYalabtPat7HDXmPTeSSk3H3vsb6s05th7DL0jo+rho4I/2x9lzUA
	fyjhedwG88aXdOKsoxshoaK95m6DOLHHZTaTbNcT1k9OHhKpnxHlCsSeUCp4mRJ7cRtLzAwnef4
	RVa+T3eNVh/v8lYHeaC+8oOV0paO4UNlaf7JEhX/esPzs+FGnWjK8feF5tPILOrVYSEvP9ZBUVj
	zDFidoFearX6ek+o+cmz5WWPpGOnfCuU00A9Q625fx5UoglWIFtnG/yjSvjLBEq0mSlZTZtXW19
	+3vZX76wcljMHelp69Z4MVvnP7i9lmS5xru7sX37JDE8/2ljFsb6jgNRoS8hINapVfi062v+kY3
	VbYEJ9ePAevq6dbwVKDBJuxVXtPMOnFLjB5v8LrWT+44o3Oo3PuGHbfVQQhOyEMjkrjbQCnBWG+
	mPY7eO7WGCj/wS0FMnLynl9iBLNUn2Z8qKyhhh2
X-Received: by 2002:a05:6a00:1c82:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84c292a3dc9mr19309918b3a.22.1784644914563;
        Tue, 21 Jul 2026 07:41:54 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adcc78asm7649075b3a.23.2026.07.21.07.41.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 07:41:53 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Elie Morisse <syniurge@gmail.com>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] i2c: amd-mp2: Unregister callback on adapter add failure
Date: Tue, 21 Jul 2026 23:41:47 +0900
Message-Id: <20260721144147.31150-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_mp2_register_cb() stores the platform I2C context in the MP2 PCI
driver's callback table before the adapter is registered. If
i2c_add_adapter() fails, probe returns and devres frees the context,
but the PCI driver can still dereference the stale pointer from its IRQ
and system-sleep callbacks.

Unregister the callback before returning the adapter registration error.

Fixes: 529766e0a011 ("i2c: Add drivers for the AMD PCIe MP2 I2C controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/i2c/busses/i2c-amd-mp2-plat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
index 188e24cc4d..9fdd6a5fb8 100644
--- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
+++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
@@ -316,8 +316,10 @@ static int i2c_amd_probe(struct platform_device *pdev)
 
 	amd_mp2_pm_runtime_put(mp2_dev);
 
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&pdev->dev, "i2c add adapter failed = %d\n", ret);
+		amd_mp2_unregister_cb(&i2c_dev->common);
+	}
 
 	return ret;
 }
-- 
2.47.1

