Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443958;
	b=zdCFs1c+hUJ8QxxxccoyRGOV1oyCRvGLhvWluO8wOyFlj/7kSAeROK3yT+42KDzLUmkM
	 972/Jl9IeWDvacWbvN8m5PkFCxxjvQeejknX+VZjlEHELovkH6oZYlrKpiwpeBnFxW4qy
	 UdO+nyczVwItaVgkdKmjbm1ynsq+CXOUvZQGZ2V8ihMTDZxEhXO0m75F00zbOsdO3mRpP
	 jCcnhut083j9MEVJkRfIdg7i/6MfWyD+dlaIWhT/5gUSxjoASan+xtFM0h3UvXOUtftpD
	 V7+QtToQ80L5jqXewgMERcMb4844omI2ZVC5N1p9FjcKapc+W7/LdRvNO6AhCfsvmPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=uxmsdlRkwXKs6xHOy9xMbMTKjN7AQ/1XvZ4ccJmXMbM=;
	b=3KXimGja/WuGsUn82VnjtNa0kGzDvvuAGOukIJD3pCzNQlEygVaebOFdojAUciZ47CwS
	 80qXVfS0oJxXL8MtVDoQDwkNAKXgIJ8m4cptFwYL+6sZplJCUQ8LelaqB79bMSSXbhtvx
	 UaMbNpxI02iRPemCE5IqORhi4yirZMDoLTrOHFBBwBXi3teDXFmBTkWDCL/yGQgJCOBXo
	 tQFrbyqfXO2YABhj8kHDW989fO3NssSIKYXA3Bv2xyIz4YKCuLvEMveoOKgNGQC31tJuP
	 Y9h7VqCnLMZTkpI3L/T86jFvJmQWw6ViM3NTEIUfUlmDZjsTKWrMQffHHr7bq8i6pbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G4eRre8A;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85D606A335
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 14:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D85D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G4eRre8A
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so560784566b.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795443957; x=1796048757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uxmsdlRkwXKs6xHOy9xMbMTKjN7AQ/1XvZ4ccJmXMbM=;
        b=G4eRre8ADIv+VNaafg0Tg4mBLaRSO/A9INY4V/g8+zv/j1tfQtGP3cQA+9C4kfWe5e
         vFAFIu+otLRFJdOpTVuBp1A8cfZ9oesyT8zmq2UG517+hKtKDvqKUjgWFtZbEhYX8bq2
         UAJCvV56wYh0OoQ7E/gMhExrodXV0lP3qhMGYWLblZSlsijEqowvO7fKNMzzSSsAp/zX
         5DkhQmrpV4Q1Wgqw4e8dkRutN1FdmfV/ibwKFDMQTLBqPAlyBdvJOE9LqVivH0xWtiFV
         NRwKwQr/aLT4ByHtdYb0cljjaRlfiqJwG++XaEhMnQ/2ZE1riXQ0rkEjC+4Egd1tLjZG
         a8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443957; x=1796048757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uxmsdlRkwXKs6xHOy9xMbMTKjN7AQ/1XvZ4ccJmXMbM=;
        b=Zpu0KWG58iHDx5ldKiOvGvuYLiuHtB7acOWDAkOTSKmIln2Jp2nG9eJQFcN+6Xnb/p
         sbJ5KKIm7cFPgR7tfq5qN7yORbw0rX7GPIDlcnTxICWWmVPd9vgiW8x28RAIvWPkteMI
         /oExxnZuF+ikRB3zIR/IyR4HU0ly/Nwmg37iTVQ6dy1RPbVVIrCIC25eIVnliyqIKvOA
         F0REr1wtv4JsYEWJuA82YKmvqTlZtk90m/LnStt4A304n2OnEOnN/HjIqrbmUlOCPwyM
         QHMJC3LuzhGdGjOZlY2+2nNei0prR0o2Ci47dNJQczb4EPT18S5unAxXVdU2ax/DyuTP
         qIgA==
X-Forwarded-Encrypted: i=1; AL+hErEbFFR4sK5+RvsQf0Gi3OLiML5JT+SC0bXLH+mYHaHCjYAReTTRWtIhfHkeEhKUffKy8orw3U4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SJieJwHu0dMtQjS5JlqneghGmJRuCpT0Bw0OlMX3rfi5nFOto
	/2IarqGDCVmhKSqKhvWcN1XFy2bL3kSxKZHgaukRYfSzn2aiuAbkh4LFO0agrT0d9DQ=
X-Gm-Gg: AZFdTZeIL/KwRp5na4lmeL5iGPNLHytraj/c5Vm0ALZ2Q0SCbqpblAwfIkOpL+mcBMS
	P05/b9lkHwsfDl9ao/fzVEQT3hGrguUlKWohsjrq11zsn5DO9XjHCEACweJG+SkuyW1pOohOyHZ
	V7NsfT7ck/9f2q9kOTkvlpsuOzeoPjvs3OhYRKjPO+5js/QvyoFjAVBQBFNz0UV+SXxpploWUu4
	AY55+eGGABDymk7HCQD6wtHrga7WiYF+HcWPYEf+daUKQ0iVuHI2xd+Q7n2OFuMEdEeiy9RSOWk
	u733JV2YVlqKN0/+r7cmWpaALjVCKI3qxchwExwZ4FBa/SQlhoaFrBX3sxXzxz9/ofgwO4ZmGT0
	mszPxD8VRmHltj1qVMb2sbm47ZY6xKJZBnlM1ppr8iW3vlP4py3VxZtxTxgy2IilboeRXaKPtzc
	a3ifxRJeltH/eWHipGsaJnN0zyJTIALDZTb98rTtdZinAZKOXtFyH1fCjdr2n44qp7+KHnVwWWI
	B303oCrfxbzFlYXnUqP8Jef/l+/YOXZ2BMM/c3kl5EuNERm0aFpWUwFG0PfiJDNxfukMEWfsmB2
	LG7siGP1p4E7H8eakUgdHFq39+p8BxzKTpVgjihkvPXbsJXmqd7plfKTptlTpNJB2SXKzXXDkRS
	UVrKQKwJtWLTQLgvDDg==
X-Received: by 2002:a17:907:a890:b0:c41:266:68a7 with SMTP id a640c23a62f3a-c513aacd82cmr967497166b.10.1795443956585;
        Mon, 23 Nov 2026 06:25:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae67cbfsm428224366b.14.2026.11.23.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:25:56 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 23 Nov 2026 14:25:55 +0000
Subject: [PATCH v2 2/2] phy: exynos5-usbdrd: apply gs101 postlock tuning
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261123-gs101-usb-phy-orientation-v2-2-3361fa5f7543@linaro.org>
References: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org>
In-Reply-To: <20261123-gs101-usb-phy-orientation-v2-0-3361fa5f7543@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 RD Babiera <rdbabiera@google.com>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, phone-devel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Phy tunings to be applied after lock are never applied on gs101.

On gs101, gs101_tunes_pipe3_postlock[] disables the high-speed squelch
detector when in P3 / U3 to save some power. In U3 (USB3 suspend) there
is no SuperSpeed data traffic to detect, and link wakeup uses LFPS
through a separate low-frequency detector. Disabling the high-speed RX
squelch detector in U3 avoids keeping it powered while the link is
suspended.

Apply PTS_PIPE3_POSTLOCK once the PLL and the CDR have locked.

Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index ccaf0f27c4c8..f647688c3bfb 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1745,6 +1745,8 @@ static int exynos5_usbdrd_gs101_pipe3_init(struct exynos5_usbdrd_phy *phy_drd)
 	if (ret)
 		return ret;
 
+	exynos5_usbdrd_apply_phy_tunes(phy_drd, PTS_PIPE3_POSTLOCK);
+
 	/*
 	 * Set this while still holding phy_mutex, so that the orientation
 	 * switch callback can't miss an orientation change.

-- 
2.56.1.750.gf70dc682cf-goog

