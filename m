Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7033987F;
	Sat, 30 May 2026 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173877; cv=none; b=l1wLl9WROjGu7JuxuuwLMSNRkblRB85FWD7flX29xue65YovKcTMsJYwDXEsMy27KX/lKAT49kbBhG411r98KpQ0hk0ySukdX1gr/JppYdctfeZMoSgPCJzKilYm/oQt9oHrcg8uqAapvXQmw91o0sA31eJyz+dL1SjgQ5ZENbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173877; c=relaxed/simple;
	bh=dyYL01LZ5qHWMqyJwyvnUp+ChOrlhbU69c8t9ir9t6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBC8kvXwpsZsYSZiBsYH+W/lMoo2wa1fqGUxXGukcfgBCPgumyx32806Ey8Mu230E1RzHBdO6FcW/SuMVodKgDzW+JDbdGPZomnm/LgfV0KBmmgJyI9Hl+CTQ4wS3zXdy1uAgmiO5jBrdrj14EVYYDgf7bBbSckfBrSpD0JIiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4k/20/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4k/20/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001671F00898;
	Sat, 30 May 2026 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173876;
	bh=DghMdL8csfcQu1r/J9oPTH3CmWDSHrp8UzOqw+7OhZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4k/20/OIc4TIQKEc1zXMN5/GdgGJ6DkhfalpAXDmVo6LDiVdWRZMpKggK4w1ErIQ
	 g/KJEYi8yy3ABETMrQvSkr40KJfT/P/vdZC2RUgbmdxh1lDulzqnLsEyysSnQIStbv
	 Ra4n0F+xkB+o2CwfIRWUtbla3mPBseLHO3nR/k8u9aUrjzbe7JszYC51wTLYwFDNA4
	 RacByrt4QA6B5gF4+cK+Wj3T5IkbR9UPWld3VzSEae4W15/2TFxpa0SpgktooU5bbw
	 kB9EtLBKZjv9T2CJ0+fRUpzje8wGGzV+j7nZMBv13r9phPYMVsGvfb5PgJHCzSyNwI
	 tkaY10PQgZDfA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/8] slimbus: qcom-ngd-ctrl: fix OF node refcount
Date: Sat, 30 May 2026 21:44:14 +0100
Message-ID: <20260530204421.116824-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204421.116824-1-srini@kernel.org>
References: <20260530204421.116824-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2..428266949fdd 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);
-- 
2.53.0

