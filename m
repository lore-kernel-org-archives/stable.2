Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADA840E8FC
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581672; cv=none; b=rRINBewIeqISt+k2hFUc+MCWaoIQMXg83/P7tTmR27vvTmFsgN2Whlhx+2VZzGBaJHEdj+3YJYvlFiwz5uIgpNYCQ2yfh+hVL47Zgos0xZHblG/FP17qq298CDthzZnKsxvEEK8f7KRyA+CyhcCPcCkE9NwKobR3MMK2LODTI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581672; c=relaxed/simple;
	bh=fiMLttTfalhCTAYlHNGOdhisfxhBpO88GtQc6y2H3dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOQF7N7jfpwy8YQnPpy9lpAxyB7KWrPPMb6eNWkkg8rNyk4or7N/NjhjjZ+Zk7WmOWCW5FbLvvacCqZJob41hzWexV6GfJxLoKLu7mvUTieHCYhENkQjs8Z+C4/MuuDxE34sZZpFJVdHzC+5HozCOmPp5d6uqSmOuGouYR6X/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyuUziL5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyuUziL5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso19195655e9.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790581667; x=1791186467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAmEOBD3v0bnVlYcFrfguXtEbxOwMvuvxDB7riQNPhw=;
        b=UyuUziL53Jh/NI9XmkFhvmTFCgjoO+za1rYZaWX2Cdvs3jGYeb0OuWUgjcWT67UurX
         //4solEEw9Dx0wC0r/NkVD+mbfS/LOXu2ATiwdvH0wy7bLgRpoQu0/9CYjkrJ5/xa1XD
         1JDCIRpPj5N/scpn884kLEnJWyA5Cbgxi3MQoi03K8k0Q5smPURG+NUjTGkSw2bwXn4q
         +xUFnO+PWdyi9PO5n2L23vchOfS862XF2H+WAjyJHJD+DPaWa39QmpGei0ARfsjP1Nb+
         yHaM6U2782UhxQWZ+vxkNjEvkr6iAzjjkCVhIBDSvUrzu36OO//VQr04USajcyMnLC8z
         Puxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790581667; x=1791186467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAmEOBD3v0bnVlYcFrfguXtEbxOwMvuvxDB7riQNPhw=;
        b=I9dkRTbT1w/2Phk6+HGiCHLqTWYeaXX/ZVN6nHKW7jhqRzmdokgftyLBJW39AVXJt1
         mZ1JxQxUEJuhQv7/nNeTBGY2UR2H4KAJrmQD4PqZA9JkG8WXOPKJ3VHebB6cf+p2nY52
         rQVSaoP9NMY1unrtlhpqICkvUTzc3v9qgihUfwQCV7gn2fTDqO9EhCm8UG6CHTQDm+NI
         Fx1UJqYuRgZHYJMAQ1es3Nd0lHVzXLtlBgK3/pJcRc6LWsSVcnCivTMINuVT2qOLW8UC
         50YTeXhmXhgK1MdGERfWOEK49hi0+E9bAF1XVWn/eqOfljApwOuPXCcPQKLch0wOaqbP
         +Fsg==
X-Forwarded-Encrypted: i=1; AKwUvBwkgEkonOOOxmW2Jq3wWZTQS2gXWhhJDRTv3y8fl3p69iYtKpg5reJh552NovvbpMcWUBrMHrw=@vger.kernel.org
X-Gm-Message-State: AFuF++k7J3SWwwsGkl0wCdgASwSyeoEyLPz172CMd+UeQE9jZz9wwS/z
	I1Xne2mTq1MR+k+RfB85pHjiQfFAdv9SCkHYTe3pe5h6d3Yow54lZPaU
X-Gm-Gg: AYBFou3piKetTE9GGGDFc9WlB0BuoCPO6tWJiCSmnoNrZUrM7nGi2nWs7ntarNM327I
	Zx6ueynQyMsRGvlfavV5lgAfMz3QXWp+xStQI9dVidMQd7boy/0RsBV0Mw3CeE8ZnjqUkpCPHQr
	5vIYplubyPuw7dkgKisZwTgY6Mw7DOF+L5MZIeYoQv29+nTVFrQR3MafFK7bC+Crq1pyzJ/8HBr
	AIxziliElXWvc3kbB4tt90tZJyvYKFqSMPcIBappfVUxrOhMRqEH/PsKE0/fLuNto7G77gu5Ok5
	+Jr0LCaB9KJjV1TLsBhJUeoO60MYUKBz3h2LSAekrMW9UNwFvpgfnOxES56sIS4a3NNHWBma71a
	yDOmzhsGIW3Yoxd3XQlA/2huG0n0QUvABWw2g9vqMF6DVLumcr6MdnmDfbyvXbLVhJ6nt5yQYrs
	FHwfGCemIlaLT9Z38K3RdSEwEMn/bSRjZ3aQtzyPXzmOh2G+lZNyhfc+9PqoQ5GLvOcNJcqVC7/
	4tG6XQxZ9dBh6LydcAjGvCgIM20+ZQtJd1/hcspOj4xFTv1jBLcOoCFDQ==
X-Received: by 2002:a05:600c:8b71:b0:4a0:328:43df with SMTP id 5b1f17b1804b1-4a0032847fcmr36162805e9.21.1790581666994;
        Mon, 28 Sep 2026 00:47:46 -0700 (PDT)
Received: from localhost.localdomain (host-081.salzburg-online.at. [213.153.56.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ef3asm25817668f8f.30.2026.09.28.00.47.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 00:47:46 -0700 (PDT)
From: Ginger Li <ginger.jzllee@gmail.com>
To: s.nawrocki@samsung.com,
	alim.akhtar@samsung.com
Cc: linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus.Elfring@web.de,
	stable@vger.kernel.org
Subject: [PATCH v2] media: exynos4-is: Fix a race between s_stream(0) and the interrupt handler
Date: Mon, 28 Sep 2026 09:47:44 +0200
Message-ID: <20260928074744.23378-1-ginger.jzllee@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260923083729.64831-1-ginger.jzllee@gmail.com>
References: <20260923083729.64831-1-ginger.jzllee@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fimc_lite_subdev_s_stream(on = 0) sets ST_FLITE_OFF outside of the
fimc->slock protected region, and only then stops the capture in the
hardware.  flite_irq_handler() runs under fimc->slock and clears
ST_FLITE_OFF, so an interrupt can be handled in between: the handler finds
ST_FLITE_OFF already set, clears it and wakes up fimc->irq_queue before the
capture has actually been stopped.  The wait_event_timeout() right after it
then returns immediately and the driver continues as if the capture had
stopped.

Set ST_FLITE_OFF in the same critical section that stops the capture, as
fimc_lite_stop_capture() already does.

Fixes: 6319d6a002be ("[media] fimc-lite: Add ISP FIFO output support")
Cc: stable@vger.kernel.org
Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
---
v2:
 - Fixes: expanded to 12 hex digits, as the media CI asks (the commit it
   points at is unchanged)
 - Cc: stable@vger.kernel.org added; the bug goes back to a commit that is in
   stable releases
 - commit message rewrapped to 75 columns
---
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -1209,9 +1209,8 @@ static int fimc_lite_subdev_s_stream(struct v4l2_subde
 			spin_unlock_irqrestore(&fimc->slock, flags);
 		}
 	} else {
-		set_bit(ST_FLITE_OFF, &fimc->state);
-
 		spin_lock_irqsave(&fimc->slock, flags);
+		set_bit(ST_FLITE_OFF, &fimc->state);
 		flite_hw_capture_stop(fimc);
 		spin_unlock_irqrestore(&fimc->slock, flags);
 
-- 
2.43.0

