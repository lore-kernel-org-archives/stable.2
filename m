Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795752269;
	b=BVXfQfuP3qEmAU8ZsoNf0Nf4B25fB8jDDQkJ+TmtwAYL2X7FhREU3Q7F9RonC5Ub/6Dz
	 m4biFyNajogEt4cxkvderGDI3egVIGnB+ni/qqCVxP1dnpkUjCxBru9oImBZOQfEqrTLE
	 J+O1U+uNlU81OGm+zNBCgVvcD8BHmbbCnRv3HEPBQSRvTE0twT/VF2mGYc8/SO4ZE/q2H
	 vE3YF8ToxjntRgB5bs0pKE70hISXLCvw2N4FE53UXMCFW1ZgaZ+SHvtr4fRybWD9jfrSQ
	 pMf/O4NmadzgMB4lJHWXNEfyY27xLP0mdqdIJiB9xf/lnT1g26IlxxAZWDpsQ9SSLfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=49RGOLgGTv3V6igoKyBSy0u5pkCbgUtW5o3Nh4WpNpM=;
	b=N+eJM5y0SAyzws9Lhxcbtbtg1DVxFbK6sAFTr83RUCVThqq32hBIvwYH9j13WfZqAb7G
	 Q0mi7kBeuXfD9evckwCCs3K9irl/o17LXnNhbdi4uDgUK2jo1+ryar9GZGtxTOA+bUhbf
	 toJ389dRpffdQ9WlJu3iZO6ADFWqAJlpnR5dekRy226m0RQZ+glHaB7fawGpe5XDYiUtK
	 H3UtiNZe2L3QTMsX3ML3RrSmqF7yg57cBdLcfh2LliI82abZDqlLehph6+hUuRFClvj27
	 sJtBDnEhn7NELU1YTnKQefnvlq+zkmu2okU9MV+NLuLNKVDELSE54an+qerflHrlx+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQay7eKn;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DC606A326
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C9DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AQay7eKn
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b532dfb874so229065a91.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795752268; x=1796357068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49RGOLgGTv3V6igoKyBSy0u5pkCbgUtW5o3Nh4WpNpM=;
        b=AQay7eKnKcw8AeUT8yBh78HidoyYQXWdsBAkdmjx2NnL868TRROlcsT0bjTSF6lnNO
         9a/v0kyEEeISZG6iRPPt283rfzG/x4OypFsbkUqp5tp2T3x+DKsgdmUg/HhHbot6i3N2
         bzL+fA9Xfd21B3K9w8y1/OsERl5FbB2IZ54ZISvW4uGvbB/cg2EpcyXWVSgA4+6dXFFG
         NsnAFzx8MxqBjQcGvnecB3OSRVHWLT8Y/iHyJmGik3/jAW/bfPvgzAm4S0YBEY3kYu9F
         avhrEcN71w19ZjIrrrwMW731dXnjM5V67VDV+9X20egfj1uGOkOQ+ZayjnIGDBYMvC8F
         dRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795752268; x=1796357068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=49RGOLgGTv3V6igoKyBSy0u5pkCbgUtW5o3Nh4WpNpM=;
        b=Pw5VUSc9lZW9cTafeeZIW8XYU/BH4AIumG35giuxM4SJjAX9VXWxtyO+aVyhZv3AgP
         WxKqM3Njaf2F6DJsxggj4GiWpFAe3h8of4xJY73QVieHyvPFAK1547Y0kaYO0etGLz0r
         8IfVATDXP/qLHiE/6E9AWBKL20USL0ZWxK+ddYb4ORCVK8rbEA5httElNZU/fhPyHy7x
         FqcmG75mRxAyKH0117oOqE800QY+qZhhI6xllJEuVNs+bYtHg6OjTujCCmnEaWqeWKtC
         bINUqTNQCal4rr6ypppeh3WsgOByFo/E/jS4AQgIc6XM+QFWve2WoXx8fsJshBmTtFY3
         SGNw==
X-Forwarded-Encrypted: i=1; AL+hErEiMQGBAcqsiJ/210oiyNURjqaN0fYK/yUSTw75FQ45FNsD42xDy7W3BZ0r2WCe9Auk2gSTpP8=@vger.kernel.org
X-Gm-Message-State: APuU4Z96ERWQIXf1C5wdLWM2UXjo3rK36op2gAaplESjtrmCrlveLlSG
	o3ht8BxWU4nOqOdsN3tjWyrePyhPhQZr0W9VIKWXfAcKtC0tuQVvOzvOCRyaww==
X-Gm-Gg: AZFdTZdnkIuzUJyVX/UX5IaygYpn2gYMYFoQut1M5DNQeFNq2t71aXPJOWB8DnZXcV5
	kSrI6vC+REvuGg2GYrghKNiz0TQIBVv3wXxu00ojeLY27tVeELS3Katu/kY2hWqp3X3MWpwfV+j
	yCxqvMUVERF4c9NVRitMe+OgpQ/PrGVPkS5KYFcJ1jHw12j/RHQ/3MaotkZUq/XJUE9kBbDQvR5
	t+cdhkvlat51JiKO/2v8iHyMyusYmA4HHa7ZLdkrazrGbIWJYJsAx1b2gk8nUt/jvF/lqGnDOVY
	5NI5NarFSUVFhXFqiGTi63EgAf1zANmeIx0cmhWPvb5osYTcb6M6oMPx4DCiTKPfGNXOl5Du4EZ
	dMscL7z6hc08uNl6ZQaq3UQhYjzNVGhWSmbX9/n1zsDkaErGi9YoxGwOmlSjpaaE90Yq+o7z4Xw
	i89o3y3jp37JtndCdpkDSUW/Hgu6yhFucJ3uVYCkiPwrzeMQslvgSQTUCnCPSsjsed66bGVvrYL
	VLtmJJwZqnZOXbFJ5xbPYCZqc4Fv1L8BycG6gng3b4kwCJbCDFSmKV6lfRBQYh9DCuZltiC2M/6
	We6y8UUbaw95EKiKUDzqkmX0l2WS7ZV4w0RfSakpOmCZhguwYUalTXmmtExojxxyzdYUbiJO3ag
	GUEf55tYs0PByh5NlTTUmNcCccWkzYfJb/hr8Gha2MIWE9u4u0OH3zLhBngOlj5FMOf5ItpTjXj
	j1Bw==
X-Received: by 2002:a17:90b:2f8c:b0:3b4:10c3:c1b6 with SMTP id 98e67ed59e1d1-3b41c9286acmr23144333a91.25.1795752268454;
        Thu, 26 Nov 2026 20:04:28 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b457a58d04sm15090652a91.0.2026.11.26.20.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 20:04:27 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Hsiao <jhsiao@amcc.com>,
	Rosen Penev <rosenp@gmail.com>,
	Christian Lamparter <chunkeey@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] crypto: amcc - fix scatter ring full check
Date: Thu, 26 Nov 2026 20:04:16 -0800
Message-ID: <20261127040423.1023233-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127040423.1023233-1-rosenp@gmail.com>
References: <20261127040423.1023233-1-rosenp@gmail.com>
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

crypto4xx_get_n_sd() compares the scatter ring head with the gather
ring tail (gdr_tail) instead of the scatter ring tail. When
sdr_head > sdr_tail but sdr_head <= gdr_tail, neither branch of the
full check runs, and the allocation is granted even if it wraps over
scatter descriptors that are still in use.

On an APM82181 (Meraki MX60), a stress test that keeps many
out-of-place requests in flight stalls the engine with this: the
engine stops at a packet descriptor that has HOST_READY set, no further
interrupts arrive, and every later request hangs. With the check fixed,
the same test runs to completion.

Compare with sdr_tail.

Fixes: 049359d65527 ("crypto: amcc - Add crypt4xx driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/crypto/amcc/crypto4xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index acf18b71e54d..7a1ababd9198 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -402,7 +402,7 @@ static u32 crypto4xx_get_n_sd(struct crypto4xx_device *dev, int n)
 
 	retval = dev->sdr_head;
 	tmp = (dev->sdr_head + n) % PPC4XX_NUM_SD;
-	if (dev->sdr_head > dev->gdr_tail) {
+	if (dev->sdr_head > dev->sdr_tail) {
 		if (tmp < dev->sdr_head && tmp >= dev->sdr_tail)
 			return ERING_WAS_FULL;
 	} else if (dev->sdr_head < dev->sdr_tail) {
-- 
2.56.1

