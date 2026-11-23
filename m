Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417293;
	b=QyCMw+EBQV2pYrbAmt5dmzAizH+vSj91dTwY+JBiEVLgwKwcJ8HvGtGnCfV/T24zFGqQ
	 pjvAQ8gVYx1xG01HEomZRGLKqyxmUzdrHHoj/ozIZnLv0LxJLzbYxpqPGd/xkQlrtFr1M
	 RPn7uMHIofhXiIdCo2B9Vo2oKYzGZjjkC4N4IGBVQeQdM95gBR+P0izWnI5IVxCn/bsf1
	 xCYIC8By977B4TQnjXR0EKWsdXmBRSi9BHOyLlX9yjRagXzzfLBL3EIadGVOIUXz/TIXF
	 Zdr5MFGpEe2hK/PFhvZUakvMacQomYH9VCQ6D62pJHQu/MtlGneGGjvUHPth8741BSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
	b=M/pBUj4WlTlVt+qzAxrUwGFCwW76XfiALHLcpL8fNrut5qRKH47GF3nmzkZK5RKGNgBu
	 YTKZ9Q56L2QQLe7znh9kqIdcATBU3ZqwYGQdVJSTgHbicMnQYZSQ577JxKtaeIkz25Vb6
	 IYP7lVE6Ihm1hH91JZWNbwRZAtDEGU61NTYYhxhfvEy27frX6bLJ9eeNFuGVbpCJPxlFi
	 jahzk984CP7OWNgjRk1j7M+DqntnbsKyf4T9H2alyv6bsoqjxt+Mc2zkgAxORdnjgklqd
	 dLALVRRaPaPooBR+0J86RbNPj5NpKngNb7vmQFcOvbC0GvneZb5YxqIyBmLX1pkG0ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="C/U0hB04";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338E606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 07:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A338E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C/U0hB04
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c511c0e2826so336213166b.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 23:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417291; x=1796022091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
        b=C/U0hB04+pMFvd99SWH6Deft8IcvFt6LOZJuj4d/cxGdul8Lcbk65BFTXq0oe67VVa
         FVWjoEz+TlD1PhYTyNXPNV4absQQ9Q52q5KU/yyOkkbhURBVfWB0wM0ugOMLgRgOZVE5
         28rEfFhwVAhfcSwgWoEMaQobJtN4LSQ6dDSVm9V/mvSYKcoctFmGzmoGVeHhj8lDrAMp
         abaG2jP2+QWljp4iwVSgafSzcvwBnVeCAdQKoIvJUHasG/JTqnp5PDeS0dPztLorlMYD
         jQ07mkfyr159abwTtV8qQeu97/YPz40N68lGOO4hsTgSruVavGRd5SWDNLeOHFSvjgy7
         4qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417291; x=1796022091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IEvJeXJOsH9S2fJ+fRG2KCQNfhieUtoOB+kM1PZCkvU=;
        b=uYb92Y3iKF7CTJjh+NA69QY+rGNqcxzNWPlHpmGyBdAnJoTeA65R95oYDbJ0AY69C/
         uaE0W7FH4iOjfo7G/OJyjsok6Qpp0XLLJQwx8CVHdOjpWJ9bxQpu4yevduE1IDR4CF2T
         cvJOE3D6qg6Ns95stDYHLimCUxmG/4d38NyOcjpQWBxoH7M6aGNGQr8TKUsvezfUrPNH
         TE4la5ZpZmVYLU8S/Nu0bzlQFhJvZQh3xO6BOXqSFGqnCqRV0G59IBtmNyhwZUV9pV/a
         PkwrnVgcPEpd7RVseEOW2o2MdWPDAXlsrXaIBneOYJYgDbC8V1THlXDVASfdE4N5KJIv
         GcWg==
X-Forwarded-Encrypted: i=1; AL+hErH4bLDLFkHHRo7es0hW/0Hh3/KTMnlI+YhrJ7xX5m7q6+5Q/zLAuAgJzPF2tZjJpm1JLnVGrZc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FbGx2rf2mFvjOeogdrnFzirMzt/jcq4eW4h+f2KGxuT9We9gN
	wNPPtA6NWjFQ1zkg7o90fI7bHdw6nxRxYBvk8zgie9udPh+l58QFYEO4
X-Gm-Gg: AZFdTZfK9WHv+l+CUXodh4pEBv6JFJam0yamoH0zye/FFcKb4XP0rvnPbG8Pzhrrtxv
	7PO82OOpSTci8aBECPvEFpyKmPLl0PIazkqbfxfsekf6NX1BMY/zYs/HHI3FJueMcgPJGdtIhaH
	SJ+F3QfTivdfgqMB7/pPHjbD0qMRVZ0z8U6M/sRqcZg8IThDjTRS8Ivgvlkq5VH5aJBfHRwGewR
	qtsd266zcILtT06s+olHwheYRwIsKuRH8mXjwn+P9OKeQZHyUJL+455nKPjuY6UXi0qU51AR3dM
	oMoYfZOt8YZMUNuwOvDe3GWKyWW7sqb4NocnJabPUL47sF+5M0Vmu4yd1aKxq5XddGVBOfw0BZ5
	eI9Btn54ZLnrf3HBYGUedS2e+Z69yYxuOGqqlPGTFyHqXj7mWxTekVD4LLSg29wtS87ubWmlkMI
	5pmOlWpkPc2aL2bxwu2K90MUIYUovxCxUkTtv3iOKCaAGToxPbtKRzjaYkBYSuPEQWbLox1S5W+
	pCKAQre1l6sw2R2OUA05XOp6DMnPRCgAH+mVyIjY3NLfC1JnT+WU2WZlSO+pbFh9AuveTIbcX1o
	spDFQM3H9Svol5q0JOLgp/7CgDUy602xmpB7
X-Received: by 2002:a17:907:e00b:20b0:c4d:22e2:1a2b with SMTP id a640c23a62f3a-c513a47e2ffmr543211566b.1.1795417290844;
        Sun, 22 Nov 2026 23:01:30 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:30 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/8] iio: adc: at91_adc: skip unpopulated triggers on teardown
Date: Mon, 23 Nov 2026 09:00:54 +0200
Message-ID: <20261123070101.53868-2-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
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

The driver keeps an array of triggers and leaves the slots for external
triggers unpopulated (NULL) when the "atmel,adc-use-external-triggers"
property is not set.  Both the error rollback path in
at91_adc_trigger_init() and at91_adc_trigger_remove() walk the whole
array and call iio_trigger_unregister() and iio_trigger_free() on every
entry, including the empty ones, which dereferences NULL.

Skip unpopulated trigger slots in both loops.

Make a minimal fix to simplify backporting. Moving over to device managed
cleanup will shortly remove this code.

Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..9ecf8ca362f5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -660,6 +660,9 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 
 error_trigger:
 	for (i--; i >= 0; i--) {
+		if (!st->trig[i])
+			continue;
+
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
@@ -673,6 +676,9 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	int i;
 
 	for (i = 0; i < st->caps->trigger_number; i++) {
+		if (!st->trig[i])
+			continue;
+
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
-- 
2.56.0

