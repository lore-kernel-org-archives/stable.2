Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A13FE658
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526871; cv=none; b=XyydtpfKBiTd8MjotvZGjtBHijbqsOAO9CSHuBTJaIjDePL9oh2b1OJqSLrILM6zgT3jiEtiZfbtJeBl3utSVa8jdN2wuMNJITEep+dtUwQaCTFTCo4fBxQoSQr438d7hifn57cEInEHDU5bXuPD8h2APRJXNhI0zqm7ixraDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526871; c=relaxed/simple;
	bh=+Q0nVSzTRmqvmkg+g0HdWQYxEGok9QT2sLIAdcqKVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIH3dJMHmblD0hJRLaSZVC3EAd6ALjEb3sQMzERJiNzP1ZnKa1EB3h9oejMqj+oPohxiVl9Xn+hH3kbsxqGgyIEuRlipAqqoC7kILX9UsI1Z3YSnWmjE7EzM6LRu2Em1knBI5e8m4ORZIyvxZL2g55Skl27cnYeV4CkVZpbPCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTMYeyGX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTMYeyGX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso915143b3a.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526869; x=1787131669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1TfD87JSttf0FoHcv7x41fHEYgAqJLQiQ0nL4xBOEkE=;
        b=NTMYeyGX4J1C8MUCjODyC0XjSDhw81szdFDQP6yssDZDG16XM4W+lMGObP7/jUDz0u
         sojHABqWaBWrNF5mXvq/b/pFr8ruLQzIB9cF2cYlLwL3d6x2vgkjeHD5EsWPKXFuTHwo
         9goxt0PKyCRrTwn7UUTPwIzfZoza4CFfUqO+2xtDobJH6uen/joG1I9RtH1B1YUOfxlT
         gSBR0DwUq+8ah3f8Q1jZ2qJ6V+u55OBYLpx8iL4s6o3qUvYO67i3Df/wL5WaUpdYcr+0
         Ds/flKSh7K17mNTlvChrKbXoF7LDhNI3my+lPPjLbmKqYQvsuIKmgxFTYDMhu9TY/Chm
         MXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526869; x=1787131669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1TfD87JSttf0FoHcv7x41fHEYgAqJLQiQ0nL4xBOEkE=;
        b=gdY8Q/wZvJ32VZmkus/wiy/pd95bQz0uu88DThjM87Xz/Xc526etAuq+7c6P049PXw
         AM3GcjzpuWfREFk9IE/IBP1/GxwTYa6WOQOH4Teuxlii4mz6AZUIpcrg3olwUdmeM1lK
         jcrmMqn3uKViOYIWdiREkoy/jtisDNKLiOiJqV3UtmImSmOZ8dZg+IZT+E9cAlFpgH5M
         idEitQchRovp2/GMRxrysvRlVrH34/sc7eh96WUXmfIDv9M5v4C1+wTdsrFSRRttBPAp
         RDvtEgtu6fcg9MCO8b+QLwKjYGynB9NHRg2AFUsI0AsIVjGYGTcasmkhwDVIJ5Qvhppm
         YQ1A==
X-Forwarded-Encrypted: i=1; AHgh+RrtCTtLwIpYtYDWNcbVl4ndeY+4uQznyDA2dD495qKhSvZjr+h9hrKRK9nOCGCjcdE5Bv+Tg2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7ELFTf0FWkPOZzvMI63SorXNXAIAzt3kucJvO2qaOcDhQfgy
	Iqt7F6Gn2iij163VPiU/oF/6K6vxeKcNcSLuWVZKkUpWoxU25Prj3rF9
X-Gm-Gg: AR+sD12t2qKvinMvZmvSDgKkAJZU/CnsTC9ql5W2y7ells36boPACULhAqLbNEBp2IT
	RnybAMox2tMnKKslSVrPyNkzYg7/7nKsthijI5JAQD1X8fY6pP5778E5783X7TZd9OlUtDVH69b
	NG572TtjCzT6h9BdH2BX+WqTTGWWOYuwXP7NucX61sfQbY4hUhc2l/RB4cpsp6tIK/WZp2RlaVZ
	imvNcpXlrCxBRTEKaIjU/dV26sUJyOWaoSOoVWy9AJMt5e7Q6AUMhUXEcDjPrkJeANUPEmrsctp
	EAcYkXdE9szrQE7WD9BCdEF4xNlc7sMMgvfU5qC20OGvCA98XFo4FVYslTMXsSSdiEokyCLVQF1
	uaKDmgZwOGX+0B/TbM4YHae37FJyyKBPmWkd8vH6Uq5BblfhF2Dsg19hlpLA5a39y65Tey6Vz9D
	HCoSdwqHFsawmeCbNVvBzHOgqB+snGo7FfrCZez+ACO8s=
X-Received: by 2002:a05:6a00:8d1:b0:842:5da3:9b89 with SMTP id d2e1a72fcca58-84fb55aaf96mr3658976b3a.38.1786526869174;
        Wed, 12 Aug 2026 02:27:49 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1ee6646sm727306b3a.38.2026.08.12.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:27:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ajay Gupta <ajayg@nvidia.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: nvidia-gpu: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 17:23:22 +0800
Message-ID: <20260812092322.3423217-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpu_i2c_probe() calls pm_runtime_use_autosuspend(), but the remove
path does not call the matching pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Call pm_runtime_dont_use_autosuspend() during driver removal to
properly undo the autosuspend setting.

This issue was found by manual code inspection.

Fixes: d4a4f927e4dd ("i2c: nvidia-gpu: add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-nvidia-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-nvidia-gpu.c b/drivers/i2c/busses/i2c-nvidia-gpu.c
index 14c059b03945..9dbe1fe22412 100644
--- a/drivers/i2c/busses/i2c-nvidia-gpu.c
+++ b/drivers/i2c/busses/i2c-nvidia-gpu.c
@@ -334,6 +334,7 @@ static void gpu_i2c_remove(struct pci_dev *pdev)
 	struct gpu_i2c_dev *i2cd = pci_get_drvdata(pdev);
 
 	pm_runtime_get_noresume(i2cd->dev);
+	pm_runtime_dont_use_autosuspend(i2cd->dev);
 	i2c_del_adapter(&i2cd->adapter);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.43.0

