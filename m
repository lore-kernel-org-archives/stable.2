Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C46383339
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272644; cv=none; b=GXtJFsEyrnPwzCLXsXKJwaaA6Jh+f1MXxkYMqkCFsu6Skzh3yPOxRJu0XuERrohm39aw+PGqLpL1Wf4CoCDgqhmlayyWpUbDYCY4fKMBZ0mN9H73BkAXHy8pNIuBnJmOdgxxp2vQrTI9nqPG7zMmbMZs3Zvedh71hpalRnWb7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272644; c=relaxed/simple;
	bh=q70lBCJF9U8Wv9pSNev+Rilr/PYDCEDGEVWmQL9R7qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKHU+tJzRfoDyv/wHO+zEY1w2xh0Rw3Bl83n1cnJ+NrYSmQkeC/qapfN1ox/7dyhDrbM2sTviZakNC7bLir3C0darH419f4AG6aaWGfj7QF8NKCV8uHt4ZeFIetTYOt0f9n1yQCYUnSdKVTJ3vCFz/JieH0hXfUE5cu73ci/2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA/YgI/L; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA/YgI/L"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91058dd77a2so18538866d6.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 21:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789272642; x=1789877442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LdnUVZ9fGnxxypDVfl/aC1u8LA5L3SFgGUxVp+gDyPI=;
        b=BA/YgI/LX8qY2e/HXaOWFxUY8/TQCfPDJXudwkboXgVFDCbP6vkykCYAJyz2VUKd+e
         nQwruyyxF7x6OK2uNNvFSaXXNYXKM1tykIJlhlyguyoSvcHpCo1oPewNEmtyA4E9aFCb
         Hh0f+7U6MKLq8Xn8bQAH6JtIBE2Zd1iSDOFjDD20lzC7ydYCXUdNcPilScTKocTt3Cy0
         I2M7rfj008J2ZsbtrFSJblzVlWNzEGQlFgBxIPCvmMOxaarDMBRrQgRBMatDC/XuH15y
         303IZKs+Fo6rS3gClNgspR6EacP3GXrWtD8VVgyKSYVUo2BsyYwl/+MKxhqr+Oa+H3TL
         LB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789272642; x=1789877442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LdnUVZ9fGnxxypDVfl/aC1u8LA5L3SFgGUxVp+gDyPI=;
        b=UlPsh+ySebM0vc0Iw7xuawVrp2jkF0YErK7NZC63lmixa+zW+Fmq1vreGB6UcTfyk6
         mU75FSuuG+bA/eDdixPNi/uB/6RsHkO/SNMo1JxKbkvslPCerSX7HJheFtBGdWZOTuuF
         3dVELYekrPuczBcre1W9iopD8l66FsuwePeOqOikkY3wHPtmvLA0nmReIRdSpCvH2iiN
         QP6sMxGw2cg4tliJtLo/5hQjOACK10wNC++G0KGp9B55JPN3FGnCoV3rBqyg/uMewNXK
         LdfeexD2MXf9CEPvh5n+wE8C3uC71cJ3SmKL1V09myezA68ceXB+kqP3RMym864QTPbJ
         IZeg==
X-Forwarded-Encrypted: i=1; AKwUvByTsBvb9Cyi916JhBq6HUQTfsYubEHZhaiQW+LcPRDj+fPPFwwhFcwTRRUtT55uMBIlP2qMUFE=@vger.kernel.org
X-Gm-Message-State: AFuF++mqimL4nu/4rd9KPeb1qDuZDmPKDSy5tqto1tUIQiJjXIPC47EK
	ZtvA7YANyQ79mH7NNkuWn9DnOJN/Yd89qhAHcLsFbx5zAdXZ/LCNgZI=
X-Gm-Gg: AYBFou0VOAFG78T5p5Xsw6rz/sEejcPTe+/Q4LyaVS/PZCJklEOjRzwu4C1jZ08sc3S
	KgD7qaAvmYd9g22zOC04lkZd+q1T5LU9K2AgRJ0ic9tFLErVU37Pug7YSH6bE6uhnmqXwbyehgw
	8sRE90Up+vkGknsGMxbgpazIFBc2IFELuQXYQlrc8CJ7OjVsYBuSGGRmtQLm3tKmbqW1TS1mKgb
	UVzUPDmUak8QPN0TQghAo9RmMTjzK9ju1EREDoMsDuunSHt2R16k1+Rc6Tba+3HmY+smgtYDUQo
	liVU4/QT2X1dufFYrFvZNIopxQrePkCWD+oWFiGvPKyOs2M5hUo26uIXHX7JxTLQ3pxl1gEkNLq
	tMZq5XUtlsdUKeSMGZ1QDJSu33UPmUuPm/55QLYhHe98ZIgpXmnnwnVjTSyl8y/vKJ8tn+x/jgU
	4suSuWa1VIMnvvR0QkqfvBmrYZnrSHH0ajlYEbY+5GzXm7bA4DHCTzE3vk68fz7XwmC+7yQMIUr
	tMNVz0xdqhFeijKMFx+e+R6JEJc/xN1klZuj+Gnr1fVx3Z1pWmPer8M1kq2Vt+TYeBPCIPYnytw
	wb5nG4e9hdliZkLKiEknDvvpRMnAXxx35w==
X-Received: by 2002:a05:6214:2a47:b0:910:706b:6a73 with SMTP id 6a1803df08f44-9121206f50cmr172281656d6.5.1789272642083;
        Sat, 12 Sep 2026 21:10:42 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45a780sm61544396d6.10.2026.09.12.21.10.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 21:10:40 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Dmitry Osipenko <digetx@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] usb: chipidea: tegra: disable runtime PM on resume failure
Date: Sun, 13 Sep 2026 00:10:33 -0400
Message-ID: <20260913041033.25144-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra_usb_probe() enables runtime PM before resuming the device. If
pm_runtime_resume_and_get() fails, probe returns without disabling runtime
PM. The later error paths reach pm_runtime_force_suspend(), but this early
return bypasses that cleanup.

Disable runtime PM before returning the resume error. Do not use the
fail_power_off path: the failed resume did not retain a usage reference,
so its pm_runtime_put_sync_suspend() would be unbalanced.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 8b85e11c1a7a ("usb: chipidea: tegra: Add runtime PM and OPP support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/chipidea/ci_hdrc_tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_tegra.c b/drivers/usb/chipidea/ci_hdrc_tegra.c
index 372788f0f..26225b034 100644
--- a/drivers/usb/chipidea/ci_hdrc_tegra.c
+++ b/drivers/usb/chipidea/ci_hdrc_tegra.c
@@ -306,8 +306,10 @@ static int tegra_usb_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 	err = pm_runtime_resume_and_get(&pdev->dev);
-	if (err)
+	if (err) {
+		pm_runtime_disable(&pdev->dev);
 		return err;
+	}
 
 	if (device_property_present(&pdev->dev, "nvidia,needs-double-reset"))
 		usb->needs_double_reset = true;
