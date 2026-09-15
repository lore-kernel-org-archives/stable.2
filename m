Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A33936A
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481127; cv=none; b=ACx+HRKEoYa5OyflcGrXavzaHQGUX4d1Bco+6+RihE2R3rS1u5NEHrVRpUlUrijJtmUuK9y7cM9cZB/VsZx4Fx2QxmhJEIsVun7gygpfbYtgji4QS69TEVJAuXEEFk4O6VpiTu5buqzF+pUa82+TGy/qc/bcKtdcMjVZZPhjgtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481127; c=relaxed/simple;
	bh=l1MSFdroio9w5UUZCK7+2//D7579OK4nRstZyOaDeE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjUk1KG78bE9QKIyUUdM98PdPUkQMZjUnMEz5ALM7zycngS+SjDT/YtVTo8Op2CteQZeO5TgmlNGZ4M0AjfWEflAbUne7IepvJb9j4FoCUm4ywpjIMEhGaF95jaLSUY3eFvBroGQ1f14jriOb08UlYJIkOQr7z3kJeQCI6u6nKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efANzoMp; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efANzoMp"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47bc923fe6aso269013fac.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481124; x=1790085924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/dvc0f8jIgO60uW57rTwjvHY9CDCgJCM89WrVhajN4=;
        b=efANzoMpspjN+nI7BjiTg8E5Ixhw/qAu3h8y6dh64dS3y4VzNCEv/5meX8p5YZF3DX
         AuxJWZbOSeavGPqGH6kuJnXVpmxes79+PM+9Ufz9t0cAn9/PIeG4pJmiPHb6iiJPDz8Y
         JlkdQH1er8EGAtoUKNyNyse3679/0R8FR2JX+6IMK8rn4JHZ4LPLhSwUvB2MztDa/uW5
         NmPvkDZVXazApkjhMPC9aIW7uI5xWwfrj7ydtlGJ5ZKFfVlm2+UOALBrXKIamTH7pKSU
         9i5vB0njf4YXM6NydtEZneyO7a8vYo26WLQMoF4a81cl2BBhW+1B96RQwSAkBpYxQr4g
         QEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481124; x=1790085924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/dvc0f8jIgO60uW57rTwjvHY9CDCgJCM89WrVhajN4=;
        b=O9+9crlow1sKgAMwAaVFgfg1tSCyuZzbl0mmvV/Z5iscoA5w9WaGzdP4JhmDVDNsQF
         ANTKU2HpC+2iFwlvcBlJZwBcX/FVGWy/RGEkHic6gJJ8bKGffxzUxtFRNbeo7wbfjGi0
         GksjsCVgciAqFUv89d0msqnPRJWw3YmJM36cmUKlp8lFKGb4C6BxKlJTaNUWoornuRMh
         CPOESBaq+MO4SMvv9qX3lC7PgDQoioChIR8JzuFILkvx4ex/gMyecnTxhSNsdSKyMO8v
         o+VyMAa8HIwd1XYFLFE8vnN3yfls19Jbgy+AFqZSErW+tPiDGLhrYcte4K1Hjzb1EFQh
         lWUQ==
X-Forwarded-Encrypted: i=1; AKwUvBznWfGo4tWnWDhV1gsq290Np90P1l9tLz2lqg/dBq/94RDX8R7RKPLCHWAHMa+LWpRKX1xZCLI=@vger.kernel.org
X-Gm-Message-State: AFuF++nfZmcS6yMB5cP6SRDSnyNw0zkyKUqUD1DrmWxT79mL+JnYGAv4
	tUqSoViL08jUN+8/fEQaVmMYCS5Gjuf2Eme2D46woeagn941EVwpJHVk
X-Gm-Gg: AYBFou3hliiCKdZy+xA/jKQphoVtgh2HzCzGM84zwJnsY/+V8rxn+BkPvPqTKKL99iT
	2ULltf+nH5gVTqAiIDBuOl5aBll8/UBWAQVUO2UGNgUTcLmKKSa7q+B+yow21wJA0pM4o5Ix7ZL
	z5n2K45B2bU9ipCpyTSMQIk0mWQKciGT5mQSummKTEpLn9e6EiEDFBOOBwT46w55/1MPUko68y+
	xHWfiRjZsO4fII1iFkFQlfBbttNEmM5TeiKVn5D5vxVjhm3nrdcf8X4mdodlyACCUmBPd0YPg9U
	SQ08n7R+khy03NxAN5pCc0gg8iQMEtg3JxMBgsKph+oGiI9UONx5VcSr7MAz1LMlaOx1GjJfOm9
	68gBdTW4VFLbOmDokLn+3D49A3dr08TdjO72hXb7KfI97ckaKS3wdkBSZR0KkEEECj4OeuX9Sa7
	iDvEWw47m2AW9jcI2Esfdt3eNzdoEtZOghQjJEJQvMGcO0SCST8iw8+w==
X-Received: by 2002:a05:6820:8c7:b0:6b8:1306:8567 with SMTP id 006d021491bc7-6c739c76dc5mr719865eaf.57.1789481124343;
        Tue, 15 Sep 2026 07:05:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6036fd7sm7020010a12.0.2026.09.15.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:05:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: rkvdec: do not destroy borrowed SRAM pool
Date: Tue, 15 Sep 2026 22:05:11 +0800
Message-ID: <20260915140511.2429792-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rkvdec_probe() obtains a provider-owned SRAM pool with
of_gen_pool_get(), but its error path incorrectly destroys the borrowed
pool with gen_pool_destroy().

of_gen_pool_get() returns a pool managed by the SRAM provider. The pool
is not created or owned by the rkvdec driver and is destroyed by the
provider when its own managed resources are released.

Destroying it when rkvdec_v4l2_init() fails can invalidate the pool
while the provider and other consumers still reference it, and can also
result in the provider attempting to destroy it again later.

Remove the incorrect gen_pool_destroy() call from the probe failure
path.

This issue was found by manual code inspection.

Fixes: e5640dbb991c ("media: rkvdec: Add RCB and SRAM support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/rockchip/rkvdec/rkvdec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
index 061281f903f3..4541ef9ee3b9 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
@@ -1857,9 +1857,6 @@ static int rkvdec_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (rkvdec->sram_pool)
-		gen_pool_destroy(rkvdec->sram_pool);
-
 	return ret;
 }
 
-- 
2.43.0

