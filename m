Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABFE3FFFA2
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782732658; cv=none; b=kVbD9td3GJ+DjqXAcgH0tfFufumCCBuFxlTLYkACOmEspVNJN5L9fxPxT1ydRArGkCwIvM1iA/z0QPrbn+tbqqLlyGa/LjyYUSQ7qqy5/FFHo+xn9vwvjkUJaC/Spsg3Dfd3QLygRBvjG0xV5e41d9Aljq6phqq9Z3ZjthC97cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782732658; c=relaxed/simple;
	bh=I2H5tinn3brqMNAoiayDqdeQNYpC874+PMUqa9KGe8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e/LKtIM9izZFrb2JNlpcEKLzHUTtMuC+HlyXNYpag3RU8OhJNjS2GoSIrOml86brFkpt9XSNE5Ptpc7apPiGUtNoaQylD7YiAmGG+Xhko1SO3b5/IKGXneQlsgfxMF1+hRLvLR6N2/VWMwQfxhLooqYp8m+i+MTvBJ+5pKBC/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CGHx4THy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CGHx4THy"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5ad4f1cf3cdso3027970e87.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1782732655; x=1783337455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ET2VyfZbT6w4nMLaDtcHsXYFQy+5hvSsWtzBLWHwhrI=;
        b=CGHx4THyomG9KgMvrrWJ41aw/qBh9KEy6drGrwNkm5GNy8tDHs2Lui+1I79SVbgJua
         Za7BUWJjoFLCciyEYvWy0Vk16Ik6fNE7eLzN+RWRkOojNCKS/r/N752hkIbFmIn/JBgm
         QhA0OzcZSPwSe5x+cdUqrx2tcwIRLH99EoTnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782732655; x=1783337455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ET2VyfZbT6w4nMLaDtcHsXYFQy+5hvSsWtzBLWHwhrI=;
        b=hzxCxPAfAJWMH4t1RKvQyfbn8sG7W4HkCwUd9mxo9w0TOc6AoXtUbo5lbT0t3dhPkV
         BdOGjevXuAH3j7OP7zRtCmwesjafoLMoa63sdW6Zg0zVWTXWit0ptWpwzWmSBAEZPOZ0
         g8qIriVbVNAr4rkHrI9gXkOxHCvUSwUq+/IQRBVAeYdE6x0+n2g1RgoLUBoHrPbWKE9U
         WP0mn2rj1xSgNtsUP1E0UXgJqPajl0dblE9GeXaMzT6FnxvqAd8VRGG2b8Dph/IaQ1Sk
         uDqIugC8nZcOaiLhsyUa97dnA/UkKpg0dt7x5zzmfGvcLzEbP7wSVEJBh4JPovndSuie
         UaaA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7ibXIk0vehlbNfGTCHrK3BucL/DcMUC+BS0ld+ZzjPZynrilU1sBnTiTwjV1ZespBYmydwi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjv1sgsIoLQ+K7BibfY660/DTjLvFqQKh9O26z9RpnB07qmmn+
	xvgQfsQR1yxWf8o+/PLr5+Hz08ZHlk/UWSn40W5/QNVlkBJVKkdxXd9f9DKzrycVGw==
X-Gm-Gg: AfdE7ck/KP8IYOUoyUH6dkGYMWBw+G8JbSKIaKR6+Kc+Du6SuWmsI00rFGFYo5NAC5C
	88XFbHZLJD7yHZ60CP/uwSpJju+MVzZ+697hlO3gwLpRVaMJHxKqdZUjhd3SBASHvIcUW7GP9wU
	KNo+u7qLo1L/m2J6/pQJz9C2cGlmax18jAViiDjpVF5H46wMSF9W3uv/c9kW8VBIGKoXKjVeyCN
	uQL7Mlk6G8v5Ed8/ynWWWZ0w4or2FlzOpitxtdA+y4UEGdCmyXm0DacgYO9hCJXTUEzcPTErk6l
	s8cJ17gVX7DH5yRSMhHnfHAaHXDt8aCwXVdeqV91q+mtphMYCiu0NgwcsK1u0jZBkyiEB4u/MmJ
	d1Yv/hO5TQ06Xg4qnr0pSjlnkAwc51x2IDkNYsMavYKZwag9d3GYxj6B8AAlsTjantCh7WtHa4E
	l1OUXm2gPt4xinpD6qaa9tuVrO//Y+r3lvQJJUairtcJMBPZOnSgoiwDAeSavpgEAjFD/w
X-Received: by 2002:a05:6512:4285:b0:5ae:b7c1:f7a with SMTP id 2adb3069b0e04-5aeb7c110e0mr863055e87.30.1782732655026;
        Mon, 29 Jun 2026 04:30:55 -0700 (PDT)
Received: from ribalda.c.googlers.com (216.148.88.34.bc.googleusercontent.com. [34.88.148.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aea2cffc04sm3597745e87.17.2026.06.29.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 04:30:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Jun 2026 11:30:46 +0000
Subject: [PATCH 5/9] media: platform: amd: use refcount_t instead of
 atomic_t
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-cocci-7-2-v1-5-5884c80ee3b6@chromium.org>
References: <20260629-cocci-7-2-v1-0-5884c80ee3b6@chromium.org>
In-Reply-To: <20260629-cocci-7-2-v1-0-5884c80ee3b6@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, Bin Du <bin.du@amd.com>, 
 Nirujogi Pratap <pratap.nirujogi@amd.com>, 
 Sultan Alsawaf <sultan@kerneltoast.com>, 
 Svetoslav Stoilov <Svetoslav.Stoilov@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Abylay Ospan <aospan@amazon.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Bin Du <Bin.Du@amd.com>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

We are using the refcnt variable for refcounting. Use the refcount_t
type instead, as it has support for saturation and underflow.

This also makes cocci happier, as it will fix the following warning:
./platform/amd/isp4/isp4_subdev.c:394:6-25: WARNING: atomic_dec_and_test variation before object free at line 395.

Fixes: 4c5feef6a62c ("media: platform: amd: Add isp4 fw and hw interface")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/amd/isp4/isp4_interface.c | 4 ++--
 drivers/media/platform/amd/isp4/isp4_interface.h | 2 +-
 drivers/media/platform/amd/isp4/isp4_subdev.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/amd/isp4/isp4_interface.c b/drivers/media/platform/amd/isp4/isp4_interface.c
index 8d73f66bb42c..00a817909292 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.c
+++ b/drivers/media/platform/amd/isp4/isp4_interface.c
@@ -375,7 +375,7 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id,
 			return -ENOMEM;
 
 		/* Get two references: one for the resp thread, one for us */
-		atomic_set(&ele->refcnt, 2);
+		refcount_set(&ele->refcnt, 2);
 		init_completion(&ele->cmd_done);
 	}
 
@@ -455,7 +455,7 @@ static int isp4if_send_fw_cmd(struct isp4_interface *ispif, u32 cmd_id,
 
 put_ele_ref:
 	/* Don't free the command if we didn't put the last reference */
-	if (ele && atomic_dec_return(&ele->refcnt))
+	if (ele && !refcount_dec_and_test(&ele->refcnt))
 		ele = NULL;
 
 free_ele:
diff --git a/drivers/media/platform/amd/isp4/isp4_interface.h b/drivers/media/platform/amd/isp4/isp4_interface.h
index ce3ac9b9e5cd..04db71cd54e6 100644
--- a/drivers/media/platform/amd/isp4/isp4_interface.h
+++ b/drivers/media/platform/amd/isp4/isp4_interface.h
@@ -68,7 +68,7 @@ struct isp4if_cmd_element {
 	u32 seq_num;
 	u32 cmd_id;
 	struct completion cmd_done;
-	atomic_t refcnt;
+	refcount_t refcnt;
 };
 
 struct isp4_interface {
diff --git a/drivers/media/platform/amd/isp4/isp4_subdev.c b/drivers/media/platform/amd/isp4/isp4_subdev.c
index 48deea79ce6c..2a8bc1207843 100644
--- a/drivers/media/platform/amd/isp4/isp4_subdev.c
+++ b/drivers/media/platform/amd/isp4/isp4_subdev.c
@@ -391,7 +391,7 @@ static void isp4sd_fw_resp_cmd_done(struct isp4_subdev *isp_subdev,
 
 	if (ele) {
 		complete(&ele->cmd_done);
-		if (atomic_dec_and_test(&ele->refcnt))
+		if (refcount_dec_and_test(&ele->refcnt))
 			kfree(ele);
 	}
 }

-- 
2.55.0.rc0.799.gd6f94ed593-goog

