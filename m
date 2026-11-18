Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024446;
	b=spOoHMkX3h6M+8BIlineHiesqS+LOkOGemUOwfOdAsCfxL4FS2VVmwXScH82y+csOGC2
	 avv19KawCiyPyRP+XjsigwzsAtq7jj6ypQ6hjV0InTHmT+yLEGBh00im70c/juDivKi2c
	 QGvRELZ96AxfWi+o99RGNT6gj31KCYflY/Zyvvcp6CiT0gdqKnmh3wIBCbJdS0klVR4Y2
	 6o97YbhPBMOayk9medxde9FJjCudbhl4B8WpjnOUPLdikFpU6SGg9zCZVH3Sm7lt3eHqY
	 uzAvSlMyLyq5iT+VdtbGNBficBf/T+lWNQaevAj3Ou4JFuJaOS3x2eErzNYAm9huVCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QqweH0pYyIm/pZwPzk7IcmA/lXOB2dIrOde0Tai0CcU=;
	b=shOjR3CYUQeNTanZJAY3q87UbSkol9geahjpsRSKcRlDAxE+D4h135jH1WBYR3p7IsZC
	 BmeAQcwcqq/N1AmV1DPQxve4JWhUp/Tlf2FdLAp+xbiQ6A+6Cj+eqvZtZdeC33vOfTDP7
	 TdMb5iYRneC9Z5byGe+dKHKYmBZz9dcj6adSPkkDqP1+9snJxq/BjMvk32Wu3Jo/LVNh2
	 xp5KplXU4TrJTmhVlgds5XPhtwew0TrTRIsnEacECsJUuwnxEgpuKldiXi4mmO2eeXgTC
	 9w6zcX28WinMQwDAdMQpRCmhWxUPe5UzcU5fGiXEDn/Hda/OAhz21EuyDVJjuX1WnDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPmfWjhF;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11D606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 17:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E11D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nPmfWjhF
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-382666ea434so91628eec.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795024445; x=1795629245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QqweH0pYyIm/pZwPzk7IcmA/lXOB2dIrOde0Tai0CcU=;
        b=nPmfWjhFSXKVsOedyCpWGxiT0bmkvZTBxQAIoH3WOGQ+Tkpav5ZboHgU8H7zmbfgK2
         oI+BGSsLQDxb4KMhZDuvQGVWTISfprhkwTCgbs9EqjqELWCn+GYEkHK8B4jpo0seRq/7
         Lo52EaLrsc1kkTbyXs15jn9zbI+x6kVfNxsZuG3E18VGqPSN3kN7EzRUAU7UGVN8NmGW
         8z1Tq6YnQo6vsY+PRUdTswyX6WEonDwPD7kF6ibHYWMoHY9VHxTOuFcQ6jxfZ9+0Sien
         +D6AX0Ts7YOfA0zFuRP2DXyP3tDrCkyn0a9SRuUEYSG/W5pITNRbv7FBcNp43LyQiYRC
         6CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795024445; x=1795629245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqweH0pYyIm/pZwPzk7IcmA/lXOB2dIrOde0Tai0CcU=;
        b=hsBSv/gcqvvDZFNCZNuhACEl+JtUAQm29cfLwKUon0B+nHjTcZZPblSnS5zk8v7pFg
         IStTw55Pr6bY3HXvSsI7MgINc/4NuZn1nWDbf2eTreFtSrJlBT+de9jgkAxwlwkT4QGq
         bxLsAeVJuTsHMZSnmIIJZhCmBCI/Or+v/4ZEhTjihm+3bRRqa7J6K5zf+fldAvh9jLlp
         qhwzrZ8HEFeWFSBoJVj4YvjWagGsPdndjG+jV/soLXVHT32JkQJBjWSWiKKNYkg/AcSy
         iqC/uxSTN560F0869a7o+784g8wYNHmE48QocnK3YG3d8+Lz96En3vguDMduUL3xhA3h
         oHhw==
X-Forwarded-Encrypted: i=1; AL+hErFr8sfc8CL4O3Redc0OV5gxjPgvORqYCFfcyZNL2Yk5H0fT0X2mM4R4wxsoaZBbyk7qZv57FTA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TMhRr9pRDwKHyWoiW+G/uMQ+vQ6QL98AxpGSrizAT7K5yEaND
	mH4OCtqMZY+o7hhAkt0Q4k7/UGju+M3xmxs44I8mNtPoNadKfNq8urj6
X-Gm-Gg: AZFdTZcS9330ZeI6ovHm7vVfgMVt5P+8CVyYdGD6fg9UiqrgACxNLjuMxEeuIBkDdvj
	K0tx/+jd7RuqyD12oCDEp/4eHFvQCk5o+zo08BHRNisldgi2ZI2JxIMMkqlrskFLUJg12FdX5N+
	Vl1PygiTQpT0H+Yzh6nyKhw71Lp3CgvK8vqYCyFxyjKjyyzVIKINscV8u0OrAED/eu5WQ39qFBD
	HLNN8rZPO9xN0SLcT/SQZiZ6rzKSGFgB20TXEI0hWoROHaMXKxPAsMwiHCeKmnXRgPsLfkb3GgW
	2SpwfP7oc6+05Gesezcq07HtEDg8EAP73YOVR9mQCwwfFkNYfNheWh670UUkWC/cf2syRwMwylj
	lSQkQxA9dkZhCHwegPF+9L22vtiTKJStrxfXJJgB7x5zQvRtG+g11b0vOLE0L8CiifkgiMWuzzZ
	ipixYBhr98rcr6lulOBD3eZWMXXPaHtTFFBcwm9T5JxYFgQvFlhaVpsjjeEPjCLdjLGwY+TiC+g
	oZ6h+vbeM+QhhLirh5cEag8CyNVKvXzRSqbKx2yqRx3wZPigmQIgyK2ApIp37x84PZExRLns1Vk
	d6+PczJ+9QD5lfypgDEwKOdzbHj4sCUeGlaqVjlJ/CaKi4/1QDAHig==
X-Received: by 2002:a05:7300:c595:b0:377:d6e5:e642 with SMTP id 5a478bee46e88-3827f98fedbmr5064472eec.1.1795024444661;
        Wed, 18 Nov 2026 09:54:04 -0800 (PST)
Received: from localhost.localdomain ([38.254.175.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a79c96b2sm10352900eec.24.2026.11.18.09.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:54:04 -0800 (PST)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: quic_akdwived@quicinc.com,
	dmitry.baryshkov@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] remoteproc: qcom_q6v5_mss: Fix off-by-one error in regulator error cleanup
Date: Wed, 18 Nov 2026 23:23:54 +0530
Message-Id: <20261118175354.42351-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In q6v5_regulator_enable(), when any operation fails for regulator at
index 'i', the error cleanup path unconditionally calls
regulator_disable() starting from index 'i'. However, regulator 'i'
was never successfully enabled at this point, resulting in an
unbalanced disable.

There are three distinct failure points:
- regulator_set_voltage() failure: voltage was never set, load was
never set, regulator was never enabled.
- regulator_set_load() failure: voltage was set, but regulator was
never enabled.
- regulator_enable() failure: voltage and load were set, but
regulator was never enabled.

Fix this by introducing three separate error labels to handle each
failure point correctly. For the failing regulator at index 'i',
only reset the resources that were actually configured, without
calling regulator_disable(). Then roll back all previously enabled
regulators using 'i--' in the for loop initializer to skip the
never-enabled regulator.

Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy and active regulators.")
Cc: stable@vger.kernel.org
Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---

Resend, rebased on next-20261117, no code changes. Reviewed by Dmitry
on Aug 18. Original posting:
https://lore.kernel.org/r/20260710194638.1502-1-saileshnandanavanam@gmail.com
 drivers/remoteproc/qcom_q6v5_mss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index dd052a62b858..692cbdece318 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -313,7 +313,7 @@ static int q6v5_regulator_enable(struct q6v5 *qproc,
 				dev_err(qproc->dev,
 					"Failed to request voltage for %d.\n",
 						i);
-				goto err;
+				goto err_set_voltage;
 			}
 		}
 
@@ -323,20 +323,26 @@ static int q6v5_regulator_enable(struct q6v5 *qproc,
 			if (ret < 0) {
 				dev_err(qproc->dev,
 					"Failed to set regulator mode\n");
-				goto err;
+				goto err_set_load;
 			}
 		}
 
 		ret = regulator_enable(regs[i].reg);
 		if (ret) {
 			dev_err(qproc->dev, "Regulator enable failed\n");
-			goto err;
+			goto err_enable;
 		}
 	}
 
 	return 0;
-err:
-	for (; i >= 0; i--) {
+err_enable:
+	if (regs[i].uA > 0)
+		regulator_set_load(regs[i].reg, 0);
+err_set_load:
+	if (regs[i].uV > 0)
+		regulator_set_voltage(regs[i].reg, 0, INT_MAX);
+err_set_voltage:
+	for (i--; i >= 0; i--) {
 		if (regs[i].uV > 0)
 			regulator_set_voltage(regs[i].reg, 0, INT_MAX);
 
-- 
2.34.1

