Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4FA2DA756
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789836167; cv=none; b=gKkh22ppp+HRYVdYlKdkv8/ru58b2dZD+lGXRMuAFxmXiyx2MZQRInIA42dkHgPngoigpN+65znDR5OAJA6HapUgQJxdMVzdVuTt+GC9/ROOgi3CMVUsVaIwTGqA4BrJ3r6ycbvxPs9+WWSk6iMAuylZ16fpd/00xIu6xDfNSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789836167; c=relaxed/simple;
	bh=/2MEVIOCFXaaVqWP6h/GwVQ637HlexwqaeMpwWnS/yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILWxl+wMICvTNSiSF6UlGZBNaufql0y/7jSzVv2b+mTshXzU9vUejbZuzvLlIssYiZnnkLvAVzrdaPyABzX+jHxIsbDub4IoD9aOGg08XqgU2zIZICGDTfgr/DP8dP7T6HYs1cmz+pWxuXLphAWkTxh8N7tjxEtO2GQJZC6tzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQfb2fF3; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQfb2fF3"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so1516026b3a.0
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789836165; x=1790440965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PeBCyTcPJ8dsj0ORopbbJ0DJqPrxnxBiJwDVmVe2isY=;
        b=CQfb2fF3rUURjqUp4CXuhuDOiA7KPLI8eIVgOZfXHyUJicsWWzwNBLVbjwNOp4Viq/
         RaA1pSFDURdM+8C+cA7zOaFJODXTItQUl7IMJw4YXBcx378lWrssxATAkKnN0VXi/b54
         /br+r1i1296ZmSRIq4ERDlZcL8Uq5yPLXtPsCTqCIlz5xbJBLwurNl07czZFC8Zo7gDN
         RmGbrTcyvarle4kV9nGc9BTTEJ9d82pDM+L/a5t6F/lhIQbZr2H4UuFVD87l2sXXgUxQ
         FFIfc05RNr7XGGNJ013CXA/tzaYK2dOkDKIj7tI0RiPBW1fTokGQwATndPbuyiX2nZrn
         RKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789836165; x=1790440965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeBCyTcPJ8dsj0ORopbbJ0DJqPrxnxBiJwDVmVe2isY=;
        b=DgaMQq8oEbZuJPpkKrQY4b4ktSiigzShzDgOIvbxcYIsAo+nrl7Euwy7lkdPHFGPWh
         cfuM6hjMOm3FbswNqQsM2AchBNkJQO8qw21GpJBQK6YC9WtGaKtNexrtngaCOZr4Foq5
         5TfYg4igjpCZ4JCFTSEZrUkViDBLpHuNQjz3RWdIjl1rfi/IEJIDV8OgiFnpMrBnJtGP
         0DykVoX8vHy8eSUcy25fqxEeleFZ0ZECHbj1G6hHzscEUwY0Cg6UhhcYKwPdei4vm8Wf
         51aOXoGg2yx2pS0bwkzNoas1K2ywp/SIuvcnT7Mdu1e2OzafaoyBF7il+Xo42JWGg53h
         Y6vA==
X-Forwarded-Encrypted: i=1; AKwUvBwDChdQD2IqH2MEHfcb5WtD23cwUXQfRKPMjEH0n+fwTqAF6Ol+STH6/vnCjwI6FQjUAO3Ntws=@vger.kernel.org
X-Gm-Message-State: AFuF++m4gjEA1jksWsepy0aD7XY/29bsLUe0gMsSkfETghslZOWaLpSU
	XC+NICGRljmCo68fZETeoCi4lHdBLJnBNTbLx1GgRrQ7ghPYSZPEXF2GTSJqSYKdkAs=
X-Gm-Gg: AYBFou1v0iehNnwLz5ZWYPRM2MVpYjBdQqbhndWj1Z5pWV580SokI0WkWWhtPjXtD5Q
	cSsFRiUfzjefGkBeZIjE8+LwULK2nYY+zQygrz+Uz7Mvk+Lsi2M33542WvY6GG3aHGDdv2cRKkD
	LdTDl+YAvziPNh0ZfPnRtXKbflfySgeKYU6dYF30Ofw1k1KY4kmMTODx67QkSE9JkWzkJzSQjI7
	sGYHqK/IFSXsTm8qLTfpoRVYEYqI5fPfuCGBCNDniKhc7EMdcHIaFt5TvDWZ5bBZ0INa36GEmtr
	U/7I6JzbmtihjmnTk02/3RzBtFxVd2eEoU3y/QVbzfJDn/59Ogl5I8zRuWILhlJhBWoKEQqMY/I
	mK6JMZZXCzhUJY2VQvZrrZGJtRllusSV1g4fkkQB9+VvVIDfddmz85ryhc/k1xroaHr/tPQLn1S
	9XDvpbW6Nn6u1TGUe5oDi8yZTKT7K0/pVIERZz/ljhYSX2Wh912be/hg==
X-Received: by 2002:a05:6a00:8089:b0:878:3830:a487 with SMTP id d2e1a72fcca58-8783830a797mr1993678b3a.55.1789836165396;
        Sat, 19 Sep 2026 09:42:45 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee368asm1096482a12.26.2026.09.19.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 09:42:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: i2cr: fix memory leak on registration failure
Date: Sun, 20 Sep 2026 00:42:35 +0800
Message-ID: <20260919164235.3672733-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2cr_probe() allocates i2cr with kzalloc_obj(), but returns directly
when fsi_master_register() fails, leaving the allocation unreleased.

fsi_master_register() can fail before or after device_register() has
initialized master.dev. If master index allocation fails, master.idx is
negative and the device has not entered the device model. In this case,
release the device tree node reference and device name, then free i2cr
directly.

If device_register() fails, master.dev has already been initialized and
holds its initial reference. Drop that reference with put_device() so
i2cr_release() runs and frees i2cr. This also releases the device tree
node reference through the existing release callback.

This issue was found by manual code inspection.

Fixes: 53e89e3e4490 ("fsi: Add IBM I2C Responder virtual FSI master")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-master-i2cr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-i2cr.c b/drivers/fsi/fsi-master-i2cr.c
index f76af608c421..c5e504d67a46 100644
--- a/drivers/fsi/fsi-master-i2cr.c
+++ b/drivers/fsi/fsi-master-i2cr.c
@@ -279,9 +279,17 @@ static int i2cr_probe(struct i2c_client *client)
 	i2cr->client = client;
 
 	ret = fsi_master_register(&i2cr->master);
-	if (ret)
-		return ret;
+	if (ret) {
+		if (i2cr->master.idx < 0) {
+			of_node_put(i2cr->master.dev.of_node);
+			kfree_const(i2cr->master.dev.kobj.name);
+			kfree(i2cr);
+		} else {
+			put_device(&i2cr->master.dev);
+		}
 
+		return ret;
+	}
 	i2c_set_clientdata(client, i2cr);
 	return 0;
 }
-- 
2.43.0

