Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9998217704
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202303; cv=none; b=ENlJvRFpsOlPoeCwxm5N8Q1tPAw4YbaYJ+1VZRWCCySKsZZ4SXOYy8NHXIf1/ZnuDUcrdhUe7zy3nEvxaD9pGA4CSX8q2FHjiko2evWoQA9fwK4quwFSwq0FJdsItoVSLw1dXNiJ4leJCB1sQDE0V6oITDN0uxGBYhnuCFqg9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202303; c=relaxed/simple;
	bh=xN3XdDgIGoruQW2AwPCdjZ3rcxzT9LsA5JnV72gCxjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHVnJ2ARhiriVz6APN2fodcqNbFna3uEdYGWH07KrKMXFaEDf1GoeGq4ktxC8BZny7EifYeTLcYZncLLI02fGkwC3ArouERund6a8oQpySpfPlDMUc27PyIhWH+Qr7Yapo22wWPJZO90Z31inyOsBI53Z2nxQtnrdZGFRBmv9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=VsalMrGt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="VsalMrGt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccf2360620so31167705ad.3
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1785202300; x=1785807100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NV9OX3HfsztmSf4OIPL5ZR2O39v4TxztWNESgaKRtxg=;
        b=VsalMrGtZM96C3PiFobwI3SVpMlEHO6538kUUbPGmCus3AdlG/rwYyMIl2oaEAXgGd
         ESB3+nbelD31swgMz7wHwiZxpUTTCTpSdPenyIs6rap0Sx9J9N4wPgO+cgLoKHV80IuX
         H3dIsu1KGoxBBIQcn+wwbSgYjMuTMVE6jsAko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202300; x=1785807100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NV9OX3HfsztmSf4OIPL5ZR2O39v4TxztWNESgaKRtxg=;
        b=I4p6Gu3WbuuTJ2NHwmlW/dI5GlqThN7KrtVQgrGfyoivUyP1XeGSQBFLCENW0WbCeD
         bjXo6Mr2jjcRS5rNm0iv1NXgDCrJzv/wXwttML5S7j7sSCay1NUNCAK4n+NARdbz6BS1
         hHPuciRf35FPEehtXRNfNaDe8uhNXNBtsOW/gZvjufrvsdFvMWnPmPUtxwPEuY9C6R2I
         1ZxIWUwqk64uzXx3y/lvekwMqTwVzSjJoroiXjDmJyccXs+l5clixJv76ivbVFL3Tbzs
         TRHoSxUWjmAUYkxWm1SkrmwjwLf9PUwO3tPHaN5nf7VYxXA0JwfgvXZgVaUGakA3IFNZ
         BnWg==
X-Forwarded-Encrypted: i=1; AHgh+RrylvcXCPzdqZI8nPfBDRTGK5wRL9WXTER+4hHi6X8cN6n1KXX8IXqhHJ4JDjClyRr2Us8Nbyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV00h+3tgGeHcZfTPZKkkCLO+fe9B5W6rpFbuJPloJmrDSFdow
	KLyljdcrpnYKy+hIHsW1WMSir+xBBGuDe3D00+gq6nLvcUqUWFMXrKKFMxupdvDcBuk=
X-Gm-Gg: AR+sD11FACoOwkOH4TbnY4GkVVp7eT3Jh7IsBiPRDOPplb8HkBlXeDSfv8hvh5gZoig
	TQASRKNOFtvmiMchIhwrvPX5f+mrxbdDEra4LU4uglNr6/V1L4OfEiuxY0sTk98UylWLe+sczUo
	M7aOmvblcuOotQy4pOR+YmHvsggMkUVEp4ptcc5ataM1Y1nMzWgn4IajTAn2AqfjCYjMVQuufkP
	tBl2XLJEhIRinFR1GTTKBBLIAEMzLjCpYS571vfe0RdrCr90G8VgCVXty2jpEqZraIj/iFAFYWm
	/Ej5FrnRvV+iYvCCoI112kXRxYJxUwMD2k5NPPvJzH51b6K8k6VYxIfx6rDMkh+Xc8JIl6oGzyT
	xgxbeWzDx4ahYQ5Ix+Lfc0cU0FmiZi5RbRC0A9u+lMHkS2T7vTHa7RttyrsgT+WvMsjFV3S9Roj
	6ZOIF9wl5caEQulQoCE2YbJEjNM0lfs7DgGYn4r2e0Md7gZ7JkM2cD/rJ5AM729OsheGKy60VVp
	wkbjHkRujwFVUjpMuLBjlbm4ZfrWmCpT6mxec06FnrYnOf84OER/fBZd5ah/jDwrr9Ekk4UtCW7
	XjX9RWQO7cMaEBPYLsyWLouE79NPey+oWWcSYxQApjosKBx3hO/56iCxizvqGwvMaPVnmRwYzHP
	Mk4mggIZRAnU4HPOt0Xy2t5N8kg==
X-Received: by 2002:a17:903:b8f:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2d015d43f76mr3129095ad.44.1785202300262;
        Mon, 27 Jul 2026 18:31:40 -0700 (PDT)
Received: from aegis ([2001:fd8:4d03:6b00:7871:9297:7799:ea22])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81cd27sm43655545ad.79.2026.07.27.18.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 18:31:39 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH] soc: qcom: pmic_glink_altmode: use a freezable workqueue
Date: Tue, 28 Jul 2026 09:25:49 +0800
Message-ID: <20260728012549.14502-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On suspend wake, the DisplayPort altmode setup often executes
before devices have compeleted resuming; this triggers a legitimate
warning:
  i2c i2c-2: Transfer while suspended
  WARNING: drivers/i2c/i2c-core.h:57 at __i2c_transfer+0xc0/0x9a8
  Workqueue: events pmic_glink_altmode_worker
  Call trace:
   __i2c_transfer
   i2c_transfer
   regmap_i2c_read
   ...
   ps883x_sw_set
   typec_switch_set
   pmic_glink_altmode_worker

The setup doesn't succeed, leaving the DP-alt monitor non-working.

Fix this by queuing the work on the freezable workqueue instead,
deferring the setup until devices have resumed.

Observed and validated on a Lenovo Yoga Slim 7x X1E80100 when waking
from suspend with a USB-C DisplayPort monitor.

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 619bad2c27ee..939a444ebe6e 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -450,7 +450,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 #define SC8280XP_DPAM_MASK	0x3f
@@ -501,7 +501,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 		alt_port->tbt_data = *tbt;
 	}
 
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
-- 
2.53.0

