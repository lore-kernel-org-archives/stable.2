Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0D37A83F
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522985; cv=none; b=gQ3w1RzWmpAZxJ6r38Zj2BV/aW9GNs2Z5OmXh8NpJZBGFtKKmD7D6vCYp73OPPzscesNjv8mjD3fT5h62UjzZdrhraOHLyILAVlmJrKJNTw5e0pyWDdI2KLyxypkQm4jPAXgx1KHetNzzWfs7RVVbaZvYB+KofyZpYcvrjt/pSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522985; c=relaxed/simple;
	bh=2H8v1oyrle2HKsNAP/KxLy914h/4c7nGoy2o7SVu/VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBilEqQTxRnBn3HqIAJ/SI7DvYPz5Q2eWEhO5XiANVz74zOKZb8lIo1Adss7RFDR+nbWgY5eyrHNll+YuV8tIg+FlM1w/jUMCIfOJtXA/Rz5O6J/SI7Dx0i8ARYpNz576pedXzM1M9STWjVV3sy50f6/ybgN8gBw1k3M86fbYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibFYu8B2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibFYu8B2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso10814325ad.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522983; x=1787127783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9czSt6q7vylVa/nHulnD/ffQGxol7Pay/M7CQhmuBNg=;
        b=ibFYu8B2udqSkwZNJSDjY5m7r7VPuALu50jA88TMtMoFkELprG1mDESg80u7FiLwIe
         JW/g3WE1BjgX4Zla3+SFlsfCJmSTe2k6/DZOr0z/1IWGPb10CwRk89ENt0LdV7qI+bQE
         6NisE0SWSat3NA9N8vQfu2ugasyyoKNLeG45VTlpN/mJ9lPQircHeeoQqVMIncFWRXLj
         XbrvrwpkhvfwzLPfM/Ui7e8c+fymuRI0KvSzJdtozXfnzvQBMCbaUAj5x9r++UYK4KNk
         mieXivVUD6OSauD/wl2wONyiMqyr01DX4aYSf5ysZCxVMeQsXU0pDWjEF/cburhlIXs0
         LwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522983; x=1787127783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9czSt6q7vylVa/nHulnD/ffQGxol7Pay/M7CQhmuBNg=;
        b=L623yTOM/LXcJu4eCWxqdEmqyx5qEa5Khh/H9d4+wzCgxDIY17mp6GPxl/209WSPJm
         VJsQWCo+VaqdMoe/tbIeLBnUhSOlJorQAPN5OszTGtZBs6u1+EOUc/yJqdPMgTKYXhA9
         yYmKrAAFpVn4iAWn/ABsq2BR2tDzFG2RkkmuSegb0RVMSGY0pSi0kJglI/L1I820BRiv
         cYcYyrVvzimqBZoZTTezpda5LFP4QVtjr727h3njkSnFw+V2QSqoSN0GTnKXJFeWGTGK
         pBKQmwi8Bsac5M/QDjABjZEexCCzz2shKlRRlvipHntCr9wuKrSpG7vvgIrrlhAs7DsN
         VgQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFbTMotlA7jxdzMl9VWOCT84TmCnTjVDLiLjfld0c7mXqVr8QXD1paYMEwsEbI7FVsHjCS4XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztB/RW141dUOJtlQmUNWsU4sXzKIXSh0jEvETW6DgPO4lx1ieq
	RwNXmsH42IehiHlMnWCBoqXr8ubheDzkBngsjgc7H1lA+ZvT5p5Iav2e
X-Gm-Gg: AR+sD10qoL2IkIdZ1KmROXNnW2bQzh5dO9k/Rg9PJCkMz/D3Esrn6ttaAVCFxpW7MQh
	plBcHtdLT8DOIhMhdF8WVmaofGsiP0hvSIxUsxS9/klnt7QYaBsRtHUGfH/oxpnMQ9/CQAtfc9K
	cxEXYniOHreQ/Vn+o0VcD0pqLZ5L8oCGc6I/Uv6YW9MDB/cxKpK2OHi4N8PuJIOQs4dPEGaZQWB
	gndUCLlVM02h4LTIyo+e/DnGfFdO+ljM65Fv0cShKVbhnKMR1y6jT1rQbKz6gFDUeSJsAPPCrKV
	ClFx66zfYHYbaSRE1vZIJ/6XDHVIpzn/w3fG4ryg+N0pFyuFQjqr8KtO5SvXTs3rp8w297c1OT0
	eC0VPChn4oeE9tzy3LQhET/afGidi11/49+pPPniVvSdv8tnkE2hZhN8DkNQrgZsc8LBafykGW8
	rhbETRvkZxy5JtUobMMVQ+YmmgR5GhGduSQ5OaFmgKMsU=
X-Received: by 2002:a17:902:cecd:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2d34560d1e8mr36701705ad.18.1786522982570;
        Wed, 12 Aug 2026 01:23:02 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d35219f21bsm3015345ad.54.2026.08.12.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:23:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Wei Yan <sledge.yanwei@huawei.com>,
	Wolfram Sang <wsa@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: hix5hd2: fix autosuspend cleanup
Date: Wed, 12 Aug 2026 16:20:47 +0800
Message-ID: <20260812082047.3148742-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hix5hd2_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
failure and remove paths do not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without undoing the autosuspend setting during
teardown, this reference is not dropped and usage_count remains
unbalanced.

Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
state. Its managed cleanup disables autosuspend and runtime PM and
restores the suspended state on probe failure and driver removal.
Remove the now redundant manual runtime PM cleanup.

This issue was found by manual code inspection.

Fixes: 15ef27756b23 ("i2c: hix5hd2: add i2c controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/i2c/busses/i2c-hix5hd2.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 95ab910b80c0..f3b967316a2d 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -449,18 +449,13 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(priv->dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(priv->dev);
-	pm_runtime_set_active(priv->dev);
-	pm_runtime_enable(priv->dev);
+	ret = devm_pm_runtime_set_active_enabled(priv->dev);
+	if (ret)
+		return ret;
 
 	ret = i2c_add_adapter(&priv->adap);
 	if (ret < 0)
-		goto err_runtime;
-
-	return ret;
-
-err_runtime:
-	pm_runtime_disable(priv->dev);
-	pm_runtime_set_suspended(priv->dev);
+		return ret;
 
 	return ret;
 }
@@ -470,8 +465,6 @@ static void hix5hd2_i2c_remove(struct platform_device *pdev)
 	struct hix5hd2_i2c_priv *priv = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&priv->adap);
-	pm_runtime_disable(priv->dev);
-	pm_runtime_set_suspended(priv->dev);
 }
 
 static int hix5hd2_i2c_runtime_suspend(struct device *dev)
-- 
2.43.0

