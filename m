Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBD34DB72
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712829; cv=none; b=QT55CAy4PzXpBcRrYDLSd8FSB/aVBYndDMeUqjvHT7aeBvtmVilIdxVycbQH7i23ycPmGTyVXagydgaX7oWvf5Z3KuKqAupAkp55O1ePgh+zrB41AKhvzfrl3Fm7T1z0jpHvOKjChCsUmA5vZDJ8FPVb0GGxm+YMFWR8dHlGENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712829; c=relaxed/simple;
	bh=Mm8vmAyeqbEmk4lfT/fA/O5FmMAxOPU4AKwyS6lFPR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TrHjkHFCy0z6cEv0LIPRP+7G1+XTTV4HkccG3FgTuGCQUnZj4bJZqoCMpabou1Xnvu3EAXsRoltDfPcj/0LLwfsf8w6LXMQWM0ZgIrrz8/icKK5bBLHrwAtx4zlQDNOMZpu07eEuTurxBBndIidTvhamBVPC1THSiZcuccuRrvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0GLydS5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0GLydS5"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso117404a91.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712827; x=1784317627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ix8W+jjo7ckHJm6uTAC69TwW0JFsA0cAa6gGpTMsiag=;
        b=L0GLydS5q2IHCh38Y6jFbrtMBTl4H3Cb8puJeJEKsgQtaiQdJXtGm1+J8Ta2rfVt6r
         YzzIIm6GNeKzTdme3lgvbI6TMiTgP0FQSUkoIHaFGHKO2ot/zWDblpZNmwmjCp8DbhAp
         Pj5UY/tIjXowC/aFm1l+G8IL7nj3vIw100IzEfxdBW9pNG6pe27pn4gB8lrhX7KXDI7o
         ndDQJJQ9zFvg5dxc8cKmYY2gx4rHsg9nRyUcjpE+Fci3DylLsZh41rt8fn5VzXuvu6uO
         dAJxIvb/U9e01VbOMefKj680NrMT8HMhLzXn2lmkgzGwCb9GOI/why/dVY67HU6+E3ys
         kQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712827; x=1784317627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ix8W+jjo7ckHJm6uTAC69TwW0JFsA0cAa6gGpTMsiag=;
        b=GgsZe4hlfZgmnkvuafmygKOKt8RZgvhLjrEujlonPfeXOO6Vt3XkCJKcPwg9TBYm4b
         FheuHLcZ3/NOOu9Upw6mrf31zJN2qplFMoI32S8XL3B4V5EGk1/3kyrHDdWaYRZf/eta
         3DBBXwda+sPQVtUPcgjD9UMLouXULXjlHl8PpPCOfIfQoD6bZF8kAkJKk/QxhtXAqkeS
         f3Kqmf+mAK4l+Lj/fy74JaIyltIon7DZC+z2nI7X8NcVOWJM8ncvKXIJEI4MuMaEDtL8
         j1Tei473k9Vm42y0UIFIS3NrvO5Unr9yRsbBcZctkG0YmON6VQS6uNh1spqOl2sW5GLS
         IRXg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3LKh5QmgglXpU9kjzBpKW2HhTn5N2z7RgcmfxnDqz9ABBRbKPkCq5V9yQ2mTXULmCo1+yIbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsvsNpZcIbmOt6/aOZ/5nxPrztgbFDAWo9HdXNQm3WpPpf6ZL
	QtJHGyNVWJv+iYym9OcgnHH9BVqSBazvVXqfqxZSvEc4dzG+sLlophek
X-Gm-Gg: AfdE7cnleTrsvlQ1aa9FbUL8J57ws4XgZC0Zj1DlNP9AoP+3C7gNszAtu4aEwEwAI1/
	Px0thvzKsYjsmQ0IkzjNV95ZSaDGRgPeObJkJNel52n5Gftf4vlLvYbWgRaJQa394g3x+kRBtZd
	yOi1Er79opJ+3sVQPK145PTuDhAZO18ooizUd7eunvi35gDYi9mH3Iu7ZrPdLDn+l3xsqSCBnG/
	DOS4fQEp5YxKyh0e97aPPnKMCY5i8iwMZXfyR8xlozxxXMIbbe9yDWJHQTqm/v642QS/qJxtpQw
	nOus9Vf0bPiR+w+y4yRd9IaptVZcuT2bdatjdjqUi0cV7mm/OWcZkNmzR2/Ghc0gwiLogmIEN0K
	WjEr9miV1Hx3IbMotUKwYngyv4QwJ90vUIa7I6UGqiDjvTWWA4aMr9Q+64U7LRNT+M38nU+5qVg
	mNQFZHg342YXuGLQ+xwXQAuXqu+X277+HoC2gkji8=
X-Received: by 2002:a17:90b:3bd0:b0:36b:9323:c726 with SMTP id 98e67ed59e1d1-38dc77ec3f6mr243899a91.4.1783712827167;
        Fri, 10 Jul 2026 12:47:07 -0700 (PDT)
Received: from localhost.localdomain ([202.164.135.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm13699031eec.5.2026.07.10.12.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:47:06 -0700 (PDT)
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
To: andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: quic_akdwived@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sailesh Nandanavanam <saileshnandanavanam@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in regulator error cleanup
Date: Sat, 11 Jul 2026 01:16:38 +0530
Message-Id: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
---
 drivers/remoteproc/qcom_q6v5_mss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index ae78f5c7c1b6..9a17aa065f50 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -311,7 +311,7 @@ static int q6v5_regulator_enable(struct q6v5 *qproc,
 				dev_err(qproc->dev,
 					"Failed to request voltage for %d.\n",
 						i);
-				goto err;
+				goto err_set_voltage;
 			}
 		}
 
@@ -321,20 +321,26 @@ static int q6v5_regulator_enable(struct q6v5 *qproc,
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

