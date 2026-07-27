Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A93CF692
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138087; cv=none; b=aXd/si7KpUZgvG6QrQU0ScD8H2OFveLL8hpVmx+njXkNJlxLeOByyv6g7PrBHubM8RAgKxn28zpsg4uxuAlgqmFdZ/NM1aZvQ6RU01HGoYHqiqpr8MJGDTyeB4yhkKadQS38OqN+UCJkKtCdR0jRZXPhRFYN2tsbQerCcmNzqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138087; c=relaxed/simple;
	bh=i/FrWikECvCNNUz/Xm4748HjItEyZOmtw+SkQjP+LFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP0wtjAoabHMaGXxjUIFS3HUeNK4GsQ8VsH7OVsRmigzIDbKEGA5NFfiHKT4dm5zfwAgt2JgtuaDqAzscio7UcHTGotew446OGlapvuUt8m+v0iFsGn5jV3jKarSgjjFSzVgNYHEQzFH7GmbMMlx9llYNJwzdWjUGTJWQmM8Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApB8d0wp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApB8d0wp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ced3386430so24488195ad.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138086; x=1785742886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lr4IppW37FhX0Qct9muiBTMuyT8/uhGcBpZdV9syIrs=;
        b=ApB8d0wp/MD31sdVl8OlbRGpPPtgGNoh4VXz5VNO2vU+6U3+SX/HnatNRpyA6VCY9/
         QsmzL8S9sOvlNiXVlWLRLa1Fk8Iq5ODwVL+pdUP4dLtBBBAMIPQuyBZ6tLWjkyUyp7yf
         QfVwlk9fn4nggh6y39ld0LCLjbn/njXYZxXEf78+uNgk3Pby011uSbFbySkTVF48lUzW
         b1KAe2DZQ5fjE9vsL4c0QCu0N7L6T3c2nFzGJ+1RFg98fxRWjbWIzeHPStkHdw+bcRZC
         BUqHEAOsP9R7ViZvc4vyFMeT9lLQsRESxSdx85lQICF5ZK+kyZWb1m+r1ckKLmO7XGSM
         FpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138086; x=1785742886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lr4IppW37FhX0Qct9muiBTMuyT8/uhGcBpZdV9syIrs=;
        b=IXlNQyQNRZDvEHh9KDZfzDJBdcCe2zYmHN1XxIbwUDXF7Mu6CmaRTtDHUc5Sk20f0N
         OhbSn+9q80l+5ql15/3mNfbpQetwsFbJfWFErxrVE5QIvxGA0R+B7Zl1v0XN8UGOiAN4
         7rdo/93NdnPUV3BVZxTh4/jxMMN7VWUG81nQsLO7kgJxK7D/wCJvVCo4/hy7lH8IxXqD
         HoJl0iL2E9x/aI9du/Xn5SzWJ+eQDBaAKs2SE/Y/MeyYYWAv/aduLNH9zOmbvQ1ClWU6
         TQ1xIYv4F/WJL+ehEXCrI+yB2y4lvnV/FkWRYEH8bdc49KwY+MGTsv0e8f0wSRJLnbSE
         G53A==
X-Forwarded-Encrypted: i=1; AHgh+RrS9QNfW9GQE1/HdvEhlrbSm8Ggc4AMoeMdBZRAMmyM+zhIBS4TvJPvrrTXPLh77xzPK6Fl71U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6QFGD6Bv91ve/RaywhJpBG0Zr0NinqDssbEnS2uLaMhjF1KP
	xZjkg0x9XRegFa1Za30ZUvypcBPs1C9LlU57CvTgy8it2j+OqDFUeATiPx2Fmv1L
X-Gm-Gg: AR+sD137rGVd7H9HArCgna62vgodGWNCpJCa4CQLq9qakFIDs3djtUWL3AWqqd6eq8t
	kzESQhRw2eSTPFyPrgc+KgULRM0CEBgUoCloPL/x0IlNCNVzNStQZiHwaHURNwKKBHpzcyGv+lO
	p4Bu4Ns9OGHU0ks8803ANG1esrh7A9zo81OZxPqqcifIkJsT2MZyLRnlEhpLz7KoE4hPTzbSvCd
	RuC6RkCdqKbalRpk5pQ2iUFTJEd8FajgqJD4eGQCLkoakhitTvI8VQzMAIKhWarkqrr94HvWRHL
	FmkrMJVTyt9pav6dIY3SK2DgewTke6KT794lAT1itKPQSm4RdBEE3uUVVMa1Pv/ShIp+zwDWu1X
	3wEQP42WVAl4dVx/odXDd0Xt6p5f4lioZQYEJasgyenB4e/7+EOBZNFQgmq3bYyRAoCictvy3B9
	pXSz3EMykqKlTAbP0I4WGdF+8Q9azf7/IyitKmdPO+rplqz7K4hEjbS42mpwAO8ejyPVU=
X-Received: by 2002:a17:903:191:b0:2c9:fc14:588f with SMTP id d9443c01a7336-2cfde851b92mr73992095ad.29.1785138085897;
        Mon, 27 Jul 2026 00:41:25 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c8337sm31054755ad.20.2026.07.27.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:41:25 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: sre@kernel.org,
	andersson@kernel.org,
	neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] power: supply: qcom_battmgr: terminate the strings from firmware
Date: Mon, 27 Jul 2026 16:41:19 +0900
Message-ID: <20260727074119.2585463-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qcom_battmgr_sc8280xp_strcpy() takes a Pascal-style string when the
firmware sends one. Otherwise it copies all BATTMGR_STRING_LEN bytes and
leaves the destination without a terminator.

Those destinations are model_number, serial_number and oem_info, each
BATTMGR_STRING_LEN and declared next to each other. They go out to user
space as val->strval, which power_supply_format_property() prints with
"%s", so a firmware string that fills the whole field makes that read run
into the following members.

Use strscpy() so the copy always terminates, the way the SM8350 path
already does for the same field.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..c76389b2f7e8 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1231,7 +1231,7 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 		memcpy(dest, src + 1, len);
 		dest[len] = '\0';
 	} else {
-		memcpy(dest, src, BATTMGR_STRING_LEN);
+		strscpy(dest, src, BATTMGR_STRING_LEN);
 	}
 }
 
-- 
2.43.0

