Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09A175A6C
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430412; cv=none; b=DEY1qYg897i9xCHoFKkSk3g4Klbpmv//kQkvbAzC4uNMQQugmw0VKzYjmucl7xPflQ1l/U5hBIGgbAOETj/9wVlGKcjnUpuDj3c3mAMR+71K0gt5nW0jagLn01aMxaUBKN7psROY3ySaumsdegDZHYAwyg5sM2W2GX4DtYymnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430412; c=relaxed/simple;
	bh=+s33b2r3lHpGsYdd7mU8JRWxBLo9UKuVJeuzWshsSy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNdtt0WSqpaiGpvd93mgqNbAa8w4Eqh+3c4HktIqXKLgOe1RXhmZ0Qn84/K+DWHTlYSKv62Hkkw68jiRVWBtP1yIZ8b6jAjW8YpNiUX3lJCuJ+Bpja+4GjKlulz/fMViM+bPDuek+ASXD4Cufozs724ZprBU3zEZv0HcHLvlqDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRk2WDA5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRk2WDA5"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15c7d22070so1191911066b.2
        for <stable@vger.kernel.org>; Sat, 18 Jul 2026 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784430408; x=1785035208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fs8E0jLUar5HdcayoGlzBPDcKNFGyvNAfQjWNK0wZRw=;
        b=PRk2WDA5wKoRlFJ5lFjbDvq0hMdeKCQ4vo1oEsBYgazuIsPlD7JyiiO9/BLGSdNuwV
         kn2JHwEoTZHkOk/ptMV/RH92a5pdIA7jrTAwYQimFmO4We4Go83cwTB2M7q6BfsjbniY
         nJCzQs/vtDPUw5c4AP61wCvpfgElzHh2KjOQ0iA5yWRf0I1fZzcOXCTdOAajupC1p7BY
         Cbpjpjp7oSgjilRt/8Dt1D1nPPzsq3fFPIfejYI9tqDEouPBF3ycY2LRTbMS6QMNue1B
         BDuFauhcCq0agoMLd0B+YytNTOoz2z/k2Pb2BjuPnU3mmDxm/LzqVxjWq22WHbks9AhK
         tDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784430408; x=1785035208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fs8E0jLUar5HdcayoGlzBPDcKNFGyvNAfQjWNK0wZRw=;
        b=qWaevB7NU157g8lqcY1zomgGRlBj5aqPByZJcmW2lsBEKOZpTUVnX+8Rk0EZ6wqjRW
         IUn5ktrbL3bdSceAFPVqrhMh6ShxMXP9JMqslR7EqyNbpzm+SJEVrZYrW7XS49w+hlCo
         ra3Jq02JtZsnW9diQLlTseJwPwmAAeBd0QoX3lDXat88nxSqWo4TMXPK1fjgRQAG4kix
         onMffp4EYZExr9TnQAsTZaXK67lYi2pQ0zRXiV6p/le04NRZUjDLwC/QSf8FG270Cb7a
         sofE+W1vZKNpT384UwAujUz9Zf/uYWI41SkU7J7YKxsD5ZP8Td3jYCx8jAn66nTpY05q
         TCxg==
X-Forwarded-Encrypted: i=1; AHgh+RqmEPBjut/O245gkwudaP1Uz5UfZETmhASObTxt3OD9/QwIIpUQe21c8XbOLZ9aYcVevqH+eeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yTrBZdy+W6jSt3KjaPXeMEC48glwoJeMqBtn23aVbwBtbgOb
	/IFsK4ZBhID9XAVbrSbReRmAWRvQwMcbWm739wEbmejTS8Z9tZiTaN2C
X-Gm-Gg: AfdE7cmRWT2RPvYAroYX0px02Y2aKEWqpaQFE5vYy5BLVkxgaTrUDhaqwF4HTDU1WDh
	ku2yRH+HKi5eqLo6rSeZcZuNa+hfkppoHAeKiNGLqxZGlqB6DtxHumKasDg+CS5V/Ti+ufgtrg7
	xQ83Lt4bertHzHX+iiDC2+kfnNuFyoYuMBgWz1PWUC+SzkNEJH4lLgFwSA8kuJTM1YUyBJgr5qP
	Td2Bjodh8Z0nXzz9Jq+sBXwP9RM8cFpo7IwO+HwA6S5Uf3n96AAn6t8Ps6wluGw1dgXgaveL9JU
	Wmbl8PJrdXEiuhCCG0aiJMCR9K9h7+2IfPYmWiYbUtn+niNmKzMskfSTny6u31Sr0SKTYdZ3sCV
	JXwXvrnAsuYHKXbt5Gahwk44ZlgG9fUBMn0sPpetOnfAb0twYIAAX3BTXwfOb58tywikkkYXX83
	FeJpXkT4idIQ3lCgFyYVDEZUP8NZsxLevBmFep3unirU/eycU4QzEVwqxEjCvfDX0CZw==
X-Received: by 2002:a17:907:3e97:b0:c16:55de:60e4 with SMTP id a640c23a62f3a-c16b476f1f7mr402142366b.50.1784430408224;
        Sat, 18 Jul 2026 20:06:48 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffd0eeesm2856192a12.20.2026.07.18.20.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 20:06:47 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hansg@kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] staging: rtl8723bs: fix OOB read in rtw_get_wpa_ie()
Date: Sun, 19 Jul 2026 08:06:31 +0500
Message-ID: <20260719030631.88254-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw_get_wpa_ie() reads bytes at fixed offsets into a vendor-specific
information element without checking that the element is long enough,
causing an out-of-bounds read for a short trailing IE.

The function locates a vendor-specific IE (EID 221) with rtw_get_ie()
and then compares a 4-byte OUI+type at pbuf + 2 and reads a 2-byte
version word at pbuf + 6. Those accesses require the IE body to be at
least 6 bytes, but rtw_get_ie() only guarantees that the element fits
within the buffer; it does not enforce a minimum body length. A
vendor-specific IE whose length byte is 0 to 5, placed at the end of
the buffer, therefore makes these reads run past the end of the IE and
past the end of the buffer itself.

The buffer holds information elements taken from received management
frames and from the IE blob passed to rtw_cfg80211_set_wpa_ie(), which
is kmemdup'd to its exact length, so the read can run off the end of
the allocation.

The sibling helpers rtw_get_sec_ie(), rtw_get_wapi_ie() and
rtw_get_wps_ie() in this file already reject too-short vendor-specific
IEs before their OUI memcmp(); rtw_get_wpa_ie() was never brought in
line with them, and needs a minimum of 6 rather than 4 bytes because
of the version word. Add the missing length check.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e02b54131633..781dfe63c239 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -371,6 +371,9 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit)
 		pbuf = rtw_get_ie(pbuf, WLAN_EID_VENDOR_SPECIFIC, &len, limit_new);
 
 		if (pbuf) {
+			if (len < 6)
+				goto check_next_ie;
+
 			/* check if oui matches... */
 			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
-- 
2.55.0

