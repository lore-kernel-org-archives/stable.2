Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606283BCD2C
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360312; cv=none; b=sXnwFWHIRzkKRuhPiqCbiFmPpWxTK0QVUfjllZ+9hwHMvKFq8yg/2MhqA17ItC9DGD4DxaH28kBvLa5a/Fw3MbsZE5wtajttOEb9FVAq3NnPPQcpyBHYoJ08onbwKsTUV78Rxv/K5s15FHP7qMhrsjPKtzYG8KfNVJs/npaCAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360312; c=relaxed/simple;
	bh=YQQ0swAPlNYOtdSZVBJo7dYA9mdh1pilQAEGfbWdZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmvQER8jdEHJBCwK3zFJ4q5Z785istKrGGRMNQeArJmCGcaTfLTpzgMx5itQlNCSzwoJs7HHObQzcGEBP9SGYEP2MEo15A5YY93AHVmtKiKLUsuT1rzLxo+KepUsATh619m5AOnVw+6NkmAAre8mXgyQC5npv9oyrqjrVRjBgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANT1YiiB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANT1YiiB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so17916245e9.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 10:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360309; x=1783965109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HmxkW83CI8zC2ie0tepZoqWs3zkGn93Bzp7pmV6Q/wI=;
        b=ANT1YiiB7h5Lev2+khVHRrYkZnBrcNOFPSYPOPl5cjasSdfYe9QdMD0ZqDqiYZeIk7
         0Fu5FyBVkLhfLlM/JvfgHkbrd+yQr02ek2I5Fkftaaxkdbweiu14ttOOymHbUyiymX1M
         6Ee4lyvaGNFRcU0uUL1bk4Kdl+hgCpwQoJZBRWtMUVm49zU5x5OkPJUZ4XnmQzHJ7F/J
         11+7cOh/QoT9Te9RvUHlv5+ilYEUXzVl8kkPJZ5BfUW25h1YKuAt4Mkj6mSEKAt6deAQ
         eiyXIidGjEpQxw4ex8upbWm2DVb5wQHFcYZMKGLJ38G6DD0yx6S9wMp+DmbEt+CFf7cO
         R2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360309; x=1783965109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmxkW83CI8zC2ie0tepZoqWs3zkGn93Bzp7pmV6Q/wI=;
        b=oqs033ajo65p0JDmGmAYYg2eQpB0gq+O62lss79k80uNwfE+mzPCcyDj+bEkMVzVc9
         H/rqk3P4UWZOuDAdbh9TDLfirPRluPQZGCEi3Uxg9a9VBPM+kJmDD2QLzwrG9BFjNehC
         dJH8cUcbx2pBARRhSUFferlD9Jpby163XHf+VppQLJVBe0prrtNGznFB/K5e52M+MiRD
         xqnVmv7OJ5J1RrAFbEOyPb28chfb8trSuVZ5rolwbUQDewZF44v91DySGPU1cD/XZDGI
         LL5Ec+O997UjL8+92f2wvFxD6Kmvb/Rgh2vJzSQJznWw/zxHUfTTLuJC7Nygg90vepCB
         3GMw==
X-Forwarded-Encrypted: i=1; AHgh+RqvGmNwRPrreCBiH80DsHi0RhHZZuEG9sYS2OBjmldM7/8d+3EmVx3iSwlCxBO62OURPS+qzzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJZNmAFHxh/ynGyGu0b6Xe2EnaYaClLl144wUsnt9jS0h0yWT
	zHQV0wMKbtdLitqdwDUxruh4ufeE661VzZkFlnNVw0veKxCE0UWgTUv4
X-Gm-Gg: AfdE7cmzqgPJhh3gCWOe1mIkjjTR8nuBWMQEmXAzviftnbqQjieaAD6uNGeEGy1T6R2
	IDZ8f55/6vNPHfDMRSxxVLjxTv1pBHdy4ta8Na9Ymc7fuVyT1OuZZesw8/1DvJSQpCDelcJaGKO
	94B2cBY4ULAVInrJV9ElvJpGDiPCAAs+W1/OdsYtyffzI1/AmFZ5RdfmpcdWA3rD2wqwM/ZXQFA
	jNoXoD2HODOH8/gjmzfRkBQTOANYiG4IyI9JAtfKe8LTDwmYYkhGuyGsUmfVgcV9+5B/Ka9E1Q2
	AScLQ/3mnYNnWCDAak8MiosknBYRcnDuZ4KHHu2Qxh/WZ5hN0eWASqIMMmcEAMN69lHc+LZgUa5
	XufoXaCWErG3OU6e2IdkQPvTB8nkUQZhBIkcx3r/VSHOXN1YKHkoJk82W1O1QA1jpgLcibQdeAh
	rAfNBawWY6B/gmGkzKR3dPJGy3I6Hc5NtoyPcSeKtfcc2BSExOBDPFxBIdXC7vCVT/HV6KsjMwx
	4moex0INMK8IiZ32EcL6chEdM6Z0u8P/qOYjw==
X-Received: by 2002:a05:600c:a011:b0:493:a8eb:5145 with SMTP id 5b1f17b1804b1-493df063da1mr19180125e9.4.1783360308698;
        Mon, 06 Jul 2026 10:51:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8e02:886d:c345:c5e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0078d49sm1263145e9.0.2026.07.06.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:51:48 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 02/12] rtc: rzn1: Handle EPROBE_DEFER for optional pps interrupt
Date: Mon,  6 Jul 2026 18:51:28 +0100
Message-ID: <20260706175138.12587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
the deferred probe request properly.

Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
indicates that the interrupt subsystem is not yet ready. Intercept this
specific error condition, assign it to the return value, and jump to the
dis_runtime_pm label to avoid ignoring a valid probe deferral.

Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarms")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No changes

v1->v2:
- No changes
---
 drivers/rtc/rtc-rzn1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 305f10a8a85b..aa27ad7f5941 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -464,6 +464,10 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname_optional(pdev, "pps");
+	if (irq == -EPROBE_DEFER) {
+		ret = irq;
+		goto dis_runtime_pm;
+	}
 	if (irq >= 0)
 		ret = devm_request_irq(&pdev->dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
 
-- 
2.54.0

