Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E7D49B1EF
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818345; cv=none; b=gZoZWcY/YIvFy+5DTTskMdaVAxG3moGevwFrzH5molnfEsve14A59BB4a9qUpjlGTtsCdQzRz8JQMYy1e+hxT0LDb3EcN+wKnHviw4amUoHn6kc47fYl5Jeb2xd4YV9AACEVpE3katmYMTXxHCuCSFcWiUXq8N60I5rHGTNWfy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818345; c=relaxed/simple;
	bh=zCThCBQHEg7zoILpu1wZQQI8Pc820V1e/n5FVw5TliA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VK/OlvZhBeixaouYw82cvExp3qmDGncHnsWWNSNJ1oi2FsVk8JtkFTTHjT+EZw6JrWNsrEmWX86jkG74ioOQ4JKs1XzmKrTWKOSrXYgBZj6YDg6lXfZHwtrCzVSpI2JGSFKAD/FuvQzArYHeFPhkJSJKOZtVWk56vnws26vBpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Z2jh8w; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Z2jh8w"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-885cd98d226so867323b3a.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818343; x=1792423143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Smdsi1BCXFX0leS6t8zLips+J1KQ1pukbcy1pEKTRmY=;
        b=a4Z2jh8w8IqAYly6Tjkzo55Wf3S/+kjfqshh5BFpINuDnQb6tsjnhZwIwDII8w1qZ7
         z1bcwgJcFi8Er8D5jji+1PKO0VCeD3GTgKulnkrgOsafJhcM89wY4l4l3EOVdikrh7/E
         MOHrqUFkpH2w72t2A3j6ucSNoKLIhlN8ip5Yrnu55J4fqPIVFeRaqPobXVqWvu1Wb5+R
         iXiQSXK0GYIf5mC+Ed9D+C7LO/4C7LUxWJzATDdB79XcbKUEM7BaxcU/J8UsPASb7bhF
         AmXlI9Hr5gi9ymVzAbWDjv3n1xvV8bAzMyJjnGTVh+mZJv3tvdHOst1jk5A5r3WA/0w0
         Ih+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818343; x=1792423143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Smdsi1BCXFX0leS6t8zLips+J1KQ1pukbcy1pEKTRmY=;
        b=kuDbJ+N/lioXomFrmvWBV+Ra/zqBfphhhSMP3YYvsFUcqbi3Ge0BrndrdrTYYDc+Vq
         8GmdynDJ8AQqzMcoL1VfE86mAddQGA/NI8UUiQ4DwQxa/Y3ddpRzYc857pHW3IZvH6XT
         UH8I7IB6OcJyuCu86bG7bo/INsXR4l1Gp544FDXFYIv1Ji2ICfhmAgMt/zcd5iwoFqE/
         BLl0XlQBr+sTZd2R3jIwWvSqAul7Y16rcKjlTYo6KmsWHTFccOtb/O7/HFqBm4RjRzYk
         ylUICfoMBqtGJezu8JcRjW7aclnaYp7Fi2BbzPM8/vF3OSqplRjTUlpcVdB8Gk9N06Ob
         Eqcw==
X-Forwarded-Encrypted: i=1; AKwUvBx+hAsWfrhs50ee7NwSvDLy3111a3Qy9vDoMLqfU1MtdHdTR5K3h7wq/qnpfey5BXMK5sws8mU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKR2q2ikrjcuSWo6Fhw3lqHc+Lcl6onJAc3E7DnOpeKdD5wfxmu
	oXyWoN5odCTpjdEqQcAiIYqimLqNBI3IQwfqBhmNZa87X3oO7NA+xGtVOGKOduLjNOFhB+mM
X-Gm-Gg: AYBFou2U1BKAMLriDqQZMK4xSVh2RyWlnVsQelyQRfWeLvRMFXNlt16Cyn+zjU9in3c
	mxXlfgBkYnaM1dS8mlC9fZAUTNoZdFqBbGo2B6qT+Hz+SCdVymbPNmZo4mQow4udmN+mwNNUzW+
	bXNdon+p7C8haa4g5uHE+0LqkS+qBS/+NYWRnBF20IBxqizGwMonZLXbGIXidAcPNNWzPFsqNsc
	JiQfwEuKiFkNUhci3dVciFPY0mHU0fSqQJPiAzZoeJic3/B8yhe3bcJlbrMEpMJDwE1vwPWwFgu
	IGLLIkwPWomILurVSiYFQhm1Qg6s5Y9ts/dmT9REk+4jgR68bkqUYAhq9FfXxp4AoSNMRvHFijE
	nPQmWwq40R9gnhuOzicRR/8U2gaK4DThoWtYKhjlVGQY9BhbgSamHhsDw8dw3gclI6kPpX3c4hH
	PrAFZgzUtXe4TkrZp8liznnOOlXXgQBB2Gna721rmo2FAAoh2Pn+ASXLwDgSN7GvtpI9kODEAGq
	82IK8Vc5jeXMOMyzDYcEhcw211ZuL8NLHtwMmZfUXLlXsbvPQ20fl5hcas=
X-Received: by 2002:a05:6a00:c08e:b0:898:776e:eed6 with SMTP id d2e1a72fcca58-898776ef151mr3214615b3a.34.1791818343199;
        Mon, 12 Oct 2026 08:19:03 -0700 (PDT)
Received: from localhost (ec2-13-231-150-91.ap-northeast-1.compute.amazonaws.com. [13.231.150.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896b68ef2easm4191976b3a.7.2026.10.12.08.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:19:02 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev (open list:DEVICE DIRECT ACCESS (DAX)),
	linux-cxl@vger.kernel.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix dax_core_init error return code
Date: Mon, 12 Oct 2026 23:18:57 +0800
Message-Id: <20261012151857.22534-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_core_init() mistakenly returns 0 on error paths. Change the
error return to use rc so the actual error code is propagated
to the caller.

Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---

Changes in v2:
- Drop unnecessary goto label, keep direct return for dax_fs_init() error
- Add Fixes tag and Cc stable

Link: https://lore.kernel.org/lkml/20261011132017.31131-1-jianyungao89@gmail.com/ # v1

 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45f84b0eb909..210f4af479f0 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -738,7 +738,7 @@ static int __init dax_core_init(void)
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 err_chrdev:
 	dax_fs_exit();
-	return 0;
+	return rc;
 }
 
 static void __exit dax_core_exit(void)
-- 
2.34.1

