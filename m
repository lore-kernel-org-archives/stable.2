Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9A43BDC1
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533540; cv=none; b=bFeA+zXIfuQws0Qc05xJqOIHHb40qFm10/iwHbnG3hOXuQjotoHoeQvV27SXAlQw1I2y30TZUllrgyWkmllwQtvVx7i7xzlkn1s98dc+1G5w1flISHoQdgygzmXYWlPl8CWwJLF6bsMvTfwvlX6WOOS5M/xviTY9cLjOS1HGF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533540; c=relaxed/simple;
	bh=ZqVUWs3x1BgozxV3FrsSk7Lzh34dxSnwsmeX8ZrIYuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFaMqHpKbISiCVvbAp8o4u1XMupOnGengTeJowPkunTFwgOkLVowJ2o4CQMV7N86VgcNLG65e2Z7a2Pjtik6g+HCJa+m/c2Q926e3AIQhEB4P1e5/3bcQnTCrS2yqxh4Wv/UEqj7nqwP0e9U1QRyZnWTOfcgIAKJW42/qQ+eI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX2VFpLg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX2VFpLg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de008b020so496589f8f.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533537; x=1787138337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGNNvpeBB2xFe8o+eAG+ITw+sBusoz0y2d8gJ/h4GCc=;
        b=PX2VFpLgt9rPC4lsIJ82yrS9XEqQVu+xI6CLJaQcPVxf/xvPlghy7hZ2Uk1LN2RlOT
         1UmyaM0Xb4bH+QEX1LL9yReaqG6UwD9THwbSFqYhB9VV3ecyUM2j7TH24FBM+ZGhtQc+
         F/Vc1UBZWvM3eAnMKR4/SZAsL9fST5KGYUyJQyaplCODubYJ/q4XiaDiP++KD1BfXqw+
         mIvneW+OkI5wFnkPSV6KpD4v6aICpyV3fLONVU6apzquqQR1n8UVboqjxfn58oJgLtvH
         JtVcVNbiKl5hI6RwcZgn4qTBYLj1s8tbFtxgzr43kZQuT+g6c7i0HKBTh3tI+UvkE9am
         0rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533537; x=1787138337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGNNvpeBB2xFe8o+eAG+ITw+sBusoz0y2d8gJ/h4GCc=;
        b=ieznkmKws7mSSsY8cYvuHI38gflk+HO7KBL3HCIeoaZ1isLbINju5wGgNu+nKOL/MD
         aGBoZxlM8VoaWoaX330uEwtvPPeDjXj941/R3S+58RwTWQwjWOxVArnjmiV8URE7fvn6
         OU4CbXR8ftMcqMEaWEgnVt9wdAzwJ3Yb0zQDUepi4KjWBE/cEpgkTVKCElHJkAd5S9Gd
         QZXVD3qDzh/qe0N2UVTsLTXH9/2myBRM5yX3Rl0NopafNQ9JT3tJqOz54I8i3iJ56Z5X
         fDeS6AKKvhc8v2lt1TFbXBpg/8qYzpJ6jCmED70kgl0p58neE41o1W2q107AyKg4Bosz
         ViAw==
X-Forwarded-Encrypted: i=1; AHgh+RqlufpjSXMhChMAZSc5nLvPDi5wK784JOlEB5vQrwwvkvweWCiVR/YYXF1kvNHNbIINyX92psA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTVatmX12HovUA6NYUjuakX1NrKaks7VL51N+NRbVQ1j5nMtz
	4Wk6mNGUI8yfysEO80jpLZSgxuERJF/KvWBYabeDEu+PovWw+RGSbvjg
X-Gm-Gg: AR+sD12CqnFm1Pgx+kc+tIXX60rhoFWTtmWROyX83erpIODiIG3BwIklVUq7PHBKbLH
	tMeiqeG4VYHj7YTtrgOr/cS03TwP0daMRY+cAJ+odK7tBp5L9DY5zjQjAf2IruKoON7Al1/86yU
	SBaQec7gsfWSlSSiJr/p//j/dTyGcTQBMKIv/NUA9lztorDCQqZ+LwJLKcNUziQ2WGKV3KTYsO5
	7dfhF6vpHkrtS6OAkW8s9kcv9VfEutj4P9Awj0ACsKqVibcTO0fSA8PKy2P9Wzujpi4AEbbTILG
	17ANQUpq3WKKEA0jjdMUr1zcFEl929C5JorgNpPM5oBiW6GbGnAkrruDbYMTjnpcNl3d8Df9RCy
	pYod0Uu0Mnm2QI4EUhpSNnNwcAMgPukPL1qbsryknkFZqV9R7nSOV6YjFQXEQxFetYg09EUTs5Q
	BZq48EQQl5KMzTOGK+JJYHgQ8z01DorrKBZWkIx0JmFdXJEvRVPgMnFfvzHgdR9wNIl3ge7AHT3
	mYPUyN0Vb0ajET1BDppAA6Llhw8cucgPnloZkbTnw==
X-Received: by 2002:a05:6000:461c:b0:47f:71a0:c060 with SMTP id ffacd0b85a97d-4814febaf04mr11662868f8f.2.1786533536719;
        Wed, 12 Aug 2026 04:18:56 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:56 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 8/9] platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
Date: Wed, 12 Aug 2026 16:18:28 +0500
Message-ID: <20260812111829.172273-9-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI_TYPE_STRING case explicitly skips the string conversion for
elem == ORD_LIST_ELEMENTS:

	if (elem != PREREQUISITES && elem != ORD_LIST_ELEMENTS) {
		ret = hp_convert_hexstr_to_str(..., &str_value, &value_len);
		if (ret)
			continue;
	}

so by the time the ORD_LIST_ELEMENTS case in the eloc switch runs,
str_value is NULL (it was freed and reset to NULL at the end of the
previous iteration). That case then does:

	ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);

hp_convert_hexstr_to_str() rejects a NULL input with -EINVAL, which
sends this function to exit_list, and exit_list unconditionally
returns 0. The net effect is that any ordered-list attribute with
elements present silently ends up with an empty elements list, with no
error surfaced anywhere.

Fix by converting the current element directly, order_obj[elem], the
same way the PREREQUISITES case already handles its own array
elements, instead of reusing the unrelated str_value/value_len left
over from earlier processing.

Fixes: 4b2672ec71a3 ("platform/x86: hp-bioscfg: order-list-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index f09489a085c8..704c69c18146 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -261,7 +261,9 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			 * Ordered list data is stored in hex and comma separated format
 			 * Convert the data and split it to show each element
 			 */
-			ret = hp_convert_hexstr_to_str(str_value, value_len, &tmpstr, &tmp_len);
+			ret = hp_convert_hexstr_to_str(order_obj[elem].string.pointer,
+						       order_obj[elem].string.length,
+						       &tmpstr, &tmp_len);
 			if (ret)
 				goto exit_list;
 
-- 
2.55.0

