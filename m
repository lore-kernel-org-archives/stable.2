Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25ED324B24
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938213; cv=none; b=Onn8miCiCmsp8pRbhNJrv+5Zl/i7MmaPIakPaNh7zhQMYwebljb/BmWGy6s/4PABnxgXwa0seqpP1WaxHbdoi7T54RYtyLRczfmS9Dy5paFzBxoe7zL1He7fyQLqUATHFyr/bsjXIb0UO1vXMJwEhG2AamZn4nAxrW7Ds6j6sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938213; c=relaxed/simple;
	bh=SZNKc2jWaX+7ZPchNb8Z8qXS+B9Dw28m1FGfwGF3Xus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVQjRmPz251SvE0icyxeZsQ/9EC+bj2kIz0tkUBw16fTVcsOabOUckuuXbiDmgp3pN/Vw2Da8D2m0zE/pNT94d6RK83tnHSNJvYxAt3WEwmVVFCOiBKlBQdotHWExK5WgSGvj5CpucISSPiOQfsKJchZcOzA0iIEc34QEXAIadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebNAj5Wk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebNAj5Wk"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso690362a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785938211; x=1786543011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eg7s7wWDZNmPm0HzlM/ekfoGFm4nbJx3bfGiH7qMY1E=;
        b=ebNAj5WkTyI1XslIXYPbSMa8aI8pUpWwWutETE+sJd0vP+wYbabIIq3SavGcRHfdGV
         Xx0DKYAfqxCRpdMfS14F++fb34c9VJw07GnLMpZS8N1M26NslYAniaPVJQ23g4QAEv6T
         nhfkvFgsYJfuCyYHkyQylB483SITjbMs41P0UFDvUt/LSF+9TbbEPIyxlra+EJt68L/6
         iWgbdJc9L6DFKQ38EwxIGr88ynXa54dtZ7cFAfjJH2/JJkbS1ZvKjbLMClq4+QS4INAH
         s5M2//2Gz+V1FuKL2393ePv6ucPddp6drwWhFX2NpWtKAQBzl0dnFTHy85ALUUEFny3I
         IEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938211; x=1786543011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eg7s7wWDZNmPm0HzlM/ekfoGFm4nbJx3bfGiH7qMY1E=;
        b=kglQEgdHUgyvpJJsSUgx2CqwIg4zm7goZhCQoyrf8V2w7Gxz9wetjd1xxomwjn4ng/
         2QmoUN8px8qNaPppTbEQ8JNZ6XRPrcAlvPCmuo5daxV06m1u/ngPF3/v251PW3ORqzGe
         XHNFWiJEeGwYzKNQxlcaYh2gMnz4P76+Iafpm60hLzxlw2LIQu9cmYK9TjRWszxJPnVE
         iqKEUnvVFak8HbI7cbI4afZA7kNCVVeRaRx3EVwecClBVcksrZSBNzv0NVR2YgcEmtQm
         Bxx6mlsPA3ldo69xwQqoNyCxUEKNBTBGNzuE6j6KWzLGNpaxZCyXUQA2WrCFL7OMOV19
         HSWA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0QDxIteNJagzAby5VBUVAS5utsFmvEo/bxbnqfb4WSrm1uINutNBBI4L5mNztXvhsLI76Pp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwiue+1AfczI5ObBKsSeplR+B6pN8xRr2Lvpx0VLbxbo1j8OKa
	xV/PuIxnjnb7Wv62CEepR4eUNKtfXmYYUyHsyc1nbgE05XBlSpBajl4f
X-Gm-Gg: AR+sD13WLiwiaklfmNbXUpgQ7tp3e83yt4h1LnwzPNa7NrnK0ajaDmooRrPijFyvmYZ
	ziS/vtmBbwTn6v3M0TiDy1YK4CBKYwQP1Te5CxComIj3CxqK9DrZdjSFHtISS5Xzsu5W7SfvRjo
	Ca8EawThPcBItS7RpFEVa/en/RbK0fQCWqT4YDfbe4/OMBV0NsVDVwF7qzBrTkxjA3H9bVEHPLN
	DtloVaR0HhRGWDrhWtsIYKNoC7QQU5EA5sTDIrQgZfaR2osVWI+02F4BVububDgcdlHXFjqffY+
	84B8w4LGUq5KhbT88HwZEqSQcmrKDg8WuAmF9zN9IBLIn/UxUSC2m99zuvTzekb+M/tWcpTsLc8
	8eC+rxJq4FWzEX/1sold8FSiOMXS1VvUxv5KP8/qAAPdJog96Ds6fUJimIjF4ftRlm3fS2amXBw
	6CNJ9cFiHUdU++94ky1cdGRz13sO0e8AzqK5ZcSQ3vGOYezs9AiED4X63ygJxYQvpgKw==
X-Received: by 2002:a05:6a20:6f02:b0:3c4:511e:26ab with SMTP id adf61e73a8af0-3cb85ded984mr9538978637.3.1785938210963;
        Wed, 05 Aug 2026 06:56:50 -0700 (PDT)
Received: from ahmi-PC.. ([2401:4900:88f5:5e4b:e580:68e3:78da:9f5d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be4dsm22066935eec.16.2026.08.05.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:56:50 -0700 (PDT)
From: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org
Cc: michael.riesch@collabora.com,
	jacopo.mondi@ideasonboard.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Narasimharao Vadlamudi <ahmisaranrao@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] media: i2c: imx415: Release runtime PM reference on VBLANK error
Date: Wed,  5 Aug 2026 19:26:35 +0530
Message-ID: <20260805135635.56556-2-ahmisaranrao@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805135635.56556-1-ahmisaranrao@gmail.com>
References: <20260805135635.56556-1-ahmisaranrao@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VBLANK path returned immediately when programming VMAX failed after
pm_runtime_get_if_in_use() had taken a runtime PM reference. Break out of
the switch instead so the common pm_runtime_put() path is used.

Fixes: 3bcae55ab96a ("media: i2c: imx415: Add read/write control of VBLANK")
Cc: stable@vger.kernel.org
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
Signed-off-by: Narasimharao Vadlamudi <ahmisaranrao@gmail.com>
---
 drivers/media/i2c/imx415.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index f5cd79da512c..c3b22b238ea0 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -720,7 +720,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
 		ret = cci_write(sensor->regmap, IMX415_VMAX,
 				format->height + ctrl->val, NULL);
 		if (ret)
-			return ret;
+			break;
 		/*
 		 * Exposure is set based on VMAX which has just changed, so
 		 * program exposure register as well
-- 
2.43.0

