Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE4378D96
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408767; cv=none; b=mz5w7GHwhP3blOhzPj89Oi8gKKPXl8yLliIv1TpgvKADng4T8+0hbArOmJjfNM5qLxjRV82rXHyzfe8YiK5W+lHc/UYOczvtqgQEqEKEvv/LMpOpUz0SXfbH8mk3eQV5BkRHrjEBM0w+srRNlA8Okfp4xvhy5yy0s2Zc5HqFjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408767; c=relaxed/simple;
	bh=jHLJzttbBKgSP3b8emxFkW7pBsHdjYr4SjpKSIbN3cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PxHW3FRCHUtk09jEyrsgONeo6Fv/WI/ijXFsB2NZi+MWmm/AKS6+RwejtPeQ/apVi8nYhse/VGjjGJG1fJfR+S8f3xpPMVaQvk2+xN7mxYf228o2p5xOAWqTcr2w9NpYc2+5xVyy5RNRyD8QReq5mrg2oTMV+UCgPzyZ0vMXDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDidOvTd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDidOvTd"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so2071685e9.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780408764; x=1781013564; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ntGmS1r7qZz7Yt3+q7IMJ/TmsGLT+m13augHi6PYpE=;
        b=rDidOvTdOHI8MiX9QhHaGMfVGrEHKJIkaibOZYR4nFoLn+TAYNSnSdhexkCQMXD8pq
         BDJbo2kIxqJriZzoKFPm1ipdImbes22GRh6dlwrIrPGOs6UB6s6qvOi0LkQ0Qn1w2BSe
         NW5h7klAsM6YCl6n8/uZGWmWddS3eHC1OSIBWjLMXsqyG97pcptY+EgoDywG9EPD90CR
         0ZcM/ICCWQbdlCDGuKabbevvFkQ1pVoVz86YGSe7FLZ6CVxDoYQza3sMuYd8KK3cH+CM
         t4Q9YAL+bF/IdPT4UJcEeeQ4wkqnusKA9dRSQcwbCtxJFhm9icFDhqJ36xPedqyaG86F
         6XoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408764; x=1781013564;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ntGmS1r7qZz7Yt3+q7IMJ/TmsGLT+m13augHi6PYpE=;
        b=TrVjjKITWFmRIBMSPHapOFFo5PvliNEFW3b0cEtQWgwu1ZXqp0viA47HRP1bPmXm+3
         c1KSIueIZEwonAAe3utAB9cfv08YEDYKsAxetQemd/ue9VWzBtVp4FbJaGQF7e3VhJ7J
         BnI5++dHztQkU9FmB2ZosOpQI/N57rvvedJ6fsR//ibgnvzScdaUCq764lv1JWpXaWCE
         eyLslirep+iX1fQxhhW/omroRLQx2ES5FqrxjE87rc62BtGrHCTC2PecdcCvMcmtmF+1
         kWSEhqn9pujyEe+K9W1+biLrlSbDHC7FbzDU/B2yhMTXHlxTVvYtjnc/hMX/1U9pi4Ml
         FcEw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q+wyvvVkvJ/L6AFrjuD9zYzb89IjOgETI7RoGLkQd8cLQVmXCi/nkxJe/R3FoAqP4WC+X7xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnJ5PBX9QLuWJv9oVksUBBnA8bnYyheYc2CzaRJNuBzQhdMq0
	qV+jPR9DKFOfLhJlykCV9buaLX1VUmm0DHjyL8Q0/7WYBZXOwuvKzA3c8LmnAkzwtBUlE41JK3w
	pQrwrZJI=
X-Gm-Gg: Acq92OEWg7HjLUllLyHr8QM+scPehERHfkQAcu3u7plwo9YJ0CGrKry8/X8zVb7KmgH
	+3sXN/4wwP9O1BiyOafg/keE17CGHhf1ZaPRJNd3Yvwa443l3EmMtrW1DZ9iqbMwVtC1qtTitWs
	Lns61sIGXRZriYwCDy3124/9mBogHZsIDA9XIw+HeuxOnt/G+nzUB6XNR0fHBq0AlmEHgf3ntOm
	9ACzwu5c8/kXARmlcfK0iTQyKdlMfMjdHEFXjYYjZgU7iCknIU2xErP1z6b3U66r875f9b2+4Ds
	dzS9gYNhbsmtSUTkGODO2ZYhShIciUiwgHlN6HrGGpbEuke3wzDxc9MPr6LSGzsONNRnm5styCj
	mtV/GiFE+FNTD2f3a6vcG8F/Ge9qjyY8ROZ9sDkNiiJJYS0tPVDlZgEhly/kjQus/dbCl5S1z7r
	7/7wQt9uC4jT4CIrmT7eiuJ3GxvUCFbIqtiVBL+F6wrtel
X-Received: by 2002:a05:600c:3552:b0:488:78f2:6b0 with SMTP id 5b1f17b1804b1-490b0702b0bmr78788275e9.29.1780408763979;
        Tue, 02 Jun 2026 06:59:23 -0700 (PDT)
Received: from [192.168.0.35] ([109.77.42.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0af2d6sm118070015e9.14.2026.06.02.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 06:59:23 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 02 Jun 2026 14:59:21 +0100
Subject: [PATCH] media: iris: Enumerate cap->bus_info to differentiate
 between encoder and decoder
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-iris-simple-name-fix-ci-check-v1-1-5ec9d0d00983@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQpjSoVxEX7fjHjtpYMlqE0
 rs36vLjwVvIkBVGx2qhjFlNn6mg3lUkQ5euYL0Uk3c+uOA8a1Zj03F6gFM3gqN+WJRlgNy5bmI
 TDxLafYhUHlNG6b//6fy3vfsb5PWd0rpuI7OxD4EAAAA=
X-Change-ID: 20260602-iris-simple-name-fix-ci-check-13f3f9c6586f
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=jHLJzttbBKgSP3b8emxFkW7pBsHdjYr4SjpKSIbN3cQ=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBqHuG6tKOQdHYjCHrYMWiHw1dLU7cNZyKRopMuV
 v1Zj+3hiYSJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCah7hugAKCRAicTuzoY3I
 OqchD/0cDfYAvJ1vdBY7ZwJEuj76iq/4fAc6YVN0+4Kk/0Ea8BUxHy0oMadKaZqQ1Awqtq+71J4
 WNHqVlCdb6lucLEwRY1d2G9AV/xinLGxc12ZzKpr4ZKktNxSxdWC2EmthYoqUDQcL8XJzW5xlET
 tX3DsAEnl27dfJdiJqv/HWL/6fcrk+9VarBr1q0UyMqCapFS3L06CZ39PhcXXDnhZf5kttVdP5/
 NI4E3XPna4hyIEP95vilDQnkBFGTwpZHwVUXGzmxlbkLG1I2nXWv1f2iPamxF2HII7zKz2Vrleu
 pcJioVydB0R036//vvWdn13KCv9d7jPt1YequVxsjYO5CBRX1vZggZfPd/6mIKsahdf622OJMK8
 Bbtz/knvUiiRhrYRjwlCiZ2K/uEKl2QUiG14t/YzLzm73ZpI5isFuRh0n1QPCYxqLc7kXewZ4Gj
 p9tl4Ec2+R08SkliXYvHPKHy35uMD6RKIfDNL1HcZWBwGu4IAl9K4dFQddXDIN7T/0LG20+bTEW
 qnn3ftEMJ1R7T1t0mlWGHMaJKikj1FaQxyFr0NZYf9UgWcTl3HVxpAIBkZ8zvU+E+AmgK6O9vRv
 XiuPQ377icO2LZiebTEDr/1q7dCT6lxZGuEDikeFfIu/Trb/cWoKOwnLBy/zHFX1ADwXswvWADv
 AbTxs41WxKXap0A==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

commit 66c744e28b69 ("media: venus: assign unique bus_info strings for
encoder and decoder") introduced the naming convention
plat:node-addr:video-codec{enc|dec}. Right now Iris does not replicate this
naming convention.

When we do v4l2-ctrl --list -devices we see:
Iris Decoder (platform:aa00000.video-codec):
	/dev/video0
	/dev/video1

Enumerate the bus_info field of the capabilities structure for namespace
parity and appropriate differentiation:
Iris Decoder (plat:aa00000.video-codec:dec):
	/dev/video0

Iris Encoder (plat:aa00000.video-codec:enc):
	/dev/video1

Fixes: 5ad964ad5656 ("media: iris: Initialize and deinitialize encoder instance structure")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
A really simple fix to differentiate encoder and decoder in user-space for
the Iris driver as we have previously and recent done for Venus.
---
 drivers/media/platform/qcom/iris/iris_vidc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index 807c9a20b6ba1..3105583cbdd1d 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -451,14 +451,21 @@ static int iris_enum_frameintervals(struct file *filp, void *fh,
 
 static int iris_querycap(struct file *filp, void *fh, struct v4l2_capability *cap)
 {
+	struct iris_core *core = video_drvdata(filp);
 	struct iris_inst *inst = iris_get_inst(filp);
+	char *info;
 
 	strscpy(cap->driver, IRIS_DRV_NAME, sizeof(cap->driver));
 
-	if (inst->domain == DECODER)
+	if (inst->domain == DECODER) {
 		strscpy(cap->card, "Iris Decoder", sizeof(cap->card));
-	else
+		info = "dec";
+	} else {
 		strscpy(cap->card, "Iris Encoder", sizeof(cap->card));
+		info = "enc";
+	}
+	snprintf(cap->bus_info, sizeof(cap->bus_info),
+		 "plat:%s:%s", dev_name(core->dev), info);
 
 	return 0;
 }

---
base-commit: 6a75e3d4f6428b90f398354212e3a2e0172851d6
change-id: 20260602-iris-simple-name-fix-ci-check-13f3f9c6586f

Best regards,
--  
Bryan O'Donoghue <bryan.odonoghue@linaro.org>

