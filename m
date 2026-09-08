Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD523546E9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883302; cv=none; b=bTey94K9EGrAMvssWUFMlKj0eIzyk7jFz+KnMjJJKyMKSLG7SzVtg8vkNLipMAHXtdQ2q7UzBxuxX8wWKoZDO8eNOBgwOz9PxyhS/hVKOuGfEkGJ7AlCivdTG87HBybSGJ3uI69D0YCpsFSwJJMsBb8VlJW78fE5rnxP9MwGZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883302; c=relaxed/simple;
	bh=fSnUC/Uevm5Vbrih7n+FM4vcyD9bqX8J6oiWP1kp/DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWLkBi0vz1vYU2jr4DxUcOwar2G7jz3aXA5EneYSa5XpCg4h7X9HKHbWnFkXIM9LmsGquKBtbr3FZSbyx7xLI+htYNTKZqeyRM0OzvfOlUMNVgkJExQgerp91MhotQIaU13fIwLZ/zNmLM8rGEDKzBh0m4RiRa26uqj2rB/46q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNV+3LFb; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNV+3LFb"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f4f53975e6so4547143a34.3
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788883298; x=1789488098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HavqBuvOK9+7hkcuCpVB9Cv/dvjoerCr3RPaWhvFOI=;
        b=eNV+3LFb0X8EySGhpt/G4eUKLZBtSxeBr0h2RzFyu8qL1fHSnhBwr6u/Gdrky1Ed15
         OCrGbQ8L37t4w4Qs5LoAEJyB3Gcti0jnLzTxxIHWzyFBwVQ8Eea/mLEpKgCeCAORuB1s
         8ytcmAp0iXmH2Q7HjJ7wnMlWplnKWslbMGq4Xhqu3Qy96TNEYiAXThejrhsZrTRBzYSp
         5N4dSm7ORo3AGLkh2lmem5UF3m3fMCQ+EPaIHKxb3XfVcuK3fAgPiFQDh47YxYpJzmNm
         YdmUYZl/6Cu9+SngJizmQTXBT/1UlCsBU6qBSn4wfLRxeH/aaim72RIEI9Pd/bI0agAG
         rnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883298; x=1789488098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HavqBuvOK9+7hkcuCpVB9Cv/dvjoerCr3RPaWhvFOI=;
        b=mbceSdg9cSX3hVeftCXqlh/WBgON5ThllpIEf6/sbscodqaWOXY5DoFxssT4+9PPcz
         aBXGU/ubV2HaLjgTwSSL3cpwNusUAz7scI8tlKFyW4P9FWljghrLb3ia5GGybPbXfSsH
         rwWairH5NWd6pLdAi9xotVZ6nFQGsGadMgm/UcdRHHI4s98CqRZ3JXX9n7DiHPSGN1H6
         S8KPDHwLXQLRRSEtp0gRh1Qk8MACbnTIm0RNAx/v3UMKNT5ByksumDlaxFIpYZOVfKbW
         4Y6tJsnfoUxpoo6vLsQwp4lI7DmT5I3MQcF6QbJFZh8mNl+C0nug9nx/Jw0o9Fyq+N8M
         dfYw==
X-Forwarded-Encrypted: i=1; AKwUvBzAo2BN5SbHoBeKtWuO/Y4PcEoeL4Xq+1Zmmld7cl77Vrb4rSBsDSnReJUo9YbUt74YHLTRnyA=@vger.kernel.org
X-Gm-Message-State: AFuF++kDSYpcx/UrHzaNYP+ZmuYPev5gKwL7WwOk/oeMOUHWOy5PD3SA
	l6ucgjmjdG4+iuk7KfytBsLDz3dO4ALsBoIbn1kRubvs3jaePeCO3zT+
X-Gm-Gg: AYBFou1G4m0Fj5udEFJJpqmJR3hmfB327H5BN5VR5pcW/JebvEoe+AOiTTJ+kmkc8+8
	1G77cOgQu0ea+Rne0JPCu81O2Z7OfkQLw+7G2LMpfiNbaThP8gk8iPbWsxdy4Fsbj9lsE97ahSe
	3aZVPPFNcxgTaHuOB2g7EUQNnPQorCVtJuEAC13kl9isOzWccxEVE6TzX/O6OTUlaF4S7gV+m5v
	JwlxyPu/y9ZN17hoQyHhLD1q4WDX9xBSwuKbIjZFxETZVZSb2imMQPp6xGs8Q+24fdyvanEpEdF
	h6Ployh5bp1s69gnwMwmDH/dYm+590sEDQZ6plqf+UZ4ogyuTXKB7ulUNynnnP6acTZBKnWXLrx
	7cmfroIkCScDMWYXAg+nEuGjy8OwVXnI9ixAoaRADYp0zPEGUyPzzqasFBCQvBZzu3s499gt9oL
	jDX2Nj9JH8/+Nj9tK2uS8IU4c8f7i5IOv3Z3X4uCbdApri5zRw0Vjk4qy/nnc5QtN6EXQEaY8AR
	DUITLUO
X-Received: by 2002:a05:6820:6ac3:b0:6b0:4170:59ad with SMTP id 006d021491bc7-6b6fc7d1f64mr19096852eaf.24.1788883295449;
        Tue, 08 Sep 2026 09:01:35 -0700 (PDT)
Received: from kernel ([45.251.35.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm43084171eec.7.2026.09.08.09.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:01:34 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: herbert@gondor.apana.org.au,
	clabbe@baylibre.com,
	davem@davemloft.net
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] crypto: amlogic: Fix IRQ handler return value and fallthrough logic
Date: Tue,  8 Sep 2026 21:31:20 +0530
Message-ID: <20260908160120.4805-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In irqreturn_t_meson_irq_handler(), when an interrupt matches a flow
but the status register is empty, the driver prints an error but
doesn't return. It falls through the loop and incorrectly prints an
`unknown irq` message.

Fix this by returning IRQ_HANDLED immediately after the error print.

Additionally, the handler returns IRQ_HANDLED for genuinely unknown
interrupts. This masks false interrupts and prevents the kernel from
detecting interrupts. Return IRQ_NONE instead for unhandled
interrupts.

Cc: stable@vger.kernel.org
Fixes: 48fe583fe5417 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 6cb33949915f..302b398405e2 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -38,11 +38,12 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 				return IRQ_HANDLED;
 			}
 			dev_err(mc->dev, "%s %d Got irq for flow %d but ctrl is empty\n", __func__, irq, flow);
+			return IRQ_HANDLED; 
 		}
 	}
 
 	dev_err(mc->dev, "%s %d from unknown irq\n", __func__, irq);
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static struct meson_alg_template mc_algs[] = {
-- 
2.53.0

