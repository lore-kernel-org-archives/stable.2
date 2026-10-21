Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586079;
	b=T+9OUkz5WK+YH0su81YA2koFYEykHA/6NyAQThg2v15NpveVdFzdEpNCiahc6BbdDLKk
	 Gv/6frXUWKAHkVxPLRSrD4Gz2b6GOG3SzGXGJbx3EMsH2uL5AtlqO/Svkr8QEDCHO0wxw
	 khYqprIlCE+FzBsu8Pn8ByNPGsgb7cfc/M9yuiL+6YifcRFO5aeV/WTh/WNJCNXStz5mY
	 934OvdAZyPgBbEui48l7109ZO0qzAb6C+WzIkKbUn32cKdK5zcVviaokZqAudDht1bZbH
	 wMagDtm3OxW6UYyXv0ToLBimHIkA+mhud89IXDDwHpRcu+aI+pSNjDXsRzgB9kt74ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AOokD75NStN9kCpnuKmAghytal5d5dXGuM0291HkWnU=;
	b=N7mzKuS3o8Nsy3FRl2JWWCoYksMobc6jyvBt9Z65NYWlibSOH4gzYyARDFivYRUeaS0y
	 yZLsmUZ4xAKx3Uc1SD/sfj2hQdbN418UPHgvS4mEJ+qmupfLEzIqWqph/ze+OjvWJPSuO
	 0PfAQeWQP8RVJMUZaAmQmYHC1GxNBKio2To4rX/bPUBVLTKuH+L0oK29TI65ZRwqcjubp
	 5vuXqz2jF96k9JWiiESV1IJ2DF0YgJsY4u19Oc9TndrHViRclHpntQf2FVSGLKyBDi1ca
	 Hxx+aKB/DQgPzYKohSEezOtpa6zg/bOZgw6+AYZk64uecLlRrZXAwK8tR7iHu1UE3OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bu2UGaRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB6606A339;
	Wed, 21 Oct 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bu2UGaRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD641F000C4;
	Wed, 21 Oct 2026 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586079;
	bh=AOokD75NStN9kCpnuKmAghytal5d5dXGuM0291HkWnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bu2UGaRn1ANoiXctkb2RkByTc6YBQxufy4jBtlDEW0c/W6z98duMyBQHS6dRQc7hZ
	 TL2uNwnZSKBPuVfZX+TJwx8GfWsrU8FgzByZ7bncwp2HrQ/D//OAVrm9WY13pVEgW0
	 hS7ahF+dpq7dDtY3fZs2HHmij5kG2/W/PUU1+hDwpTTi/kteVdZc8cka1Sp2qIK41S
	 SIPPBvsRr3fQJhR+G+vVyoFckQCVbfby+027d/5pefmWAPoLVmY4bELFgMuvPsuqMP
	 9RfwEnYgNnggOAY4L8FRSJp9xj0K0JOZZgsz4cb0iaHm3IFNqR+1X7dWhab7yiwWwc
	 LBklmbWDUrlMw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Nikita Travkin <nikitos.tr@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/21] leds: aw2013: Guard LED array index in aw2013_probe_dt()
Date: Wed, 21 Oct 2026 12:32:13 +0000
Message-ID: <20261021123406.3163547-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

aw2013_probe_dt() validates the initial child node count against
AW2013_MAX_LEDS via of_get_available_child_count() before iterating over
available child nodes with for_each_available_child_of_node_scoped().

Add an explicit bounds check on the loop index before indexing into
chip->leds[] to ensure the statically sized array cannot be overrun if
additional child nodes become available during iteration.

Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
Closes: https://sashiko.dev/#/bug/linux-577a1fa0-4e80-42cc-8c7f-34c43c131d95
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-aw2013.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
index 216755d6010f..dfeac8b2993f 100644
--- a/drivers/leds/leds-aw2013.c
+++ b/drivers/leds/leds-aw2013.c
@@ -286,6 +286,9 @@ static int aw2013_probe_dt(struct aw2013 *chip)
 			continue;
 		}
 
+		if (i >= AW2013_MAX_LEDS)
+			return -EINVAL;
+
 		led = &chip->leds[i];
 		led->num = source;
 		led->chip = chip;
-- 
2.56.0.218.g1ec904b173-goog

