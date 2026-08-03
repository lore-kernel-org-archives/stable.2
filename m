Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002BF4192F7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767475; cv=none; b=UXT/KaI/LELLoeL1K0gn7BcA5WX9FSyd7lya3QWjAXVrCUDMKS4rXQVjUTWlXaa44cjyJ5weLJS9eu0MZH02WZmYv0CZnCQeXKgipHTxLcFztuDzxG9z6EMkUqlQX+L5ElXSYe6OtpG32+ACnge/q7Ovl9kSxM0dW404rxFINpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767475; c=relaxed/simple;
	bh=ZqVUWs3x1BgozxV3FrsSk7Lzh34dxSnwsmeX8ZrIYuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm38VNxmLSLYdfvfT7ONxo5oIWJ25RA1zpKkDdTyyWxZDEldhDr3T5is+LOazzXD9xcBmgWgVwj/Lzc6Toz7jf1140B0F/xRUFF7vbewX97B5vrXOu0im/Z9TyrETFygVf61jWMJSaks3vG3vSuKSmeQlD2MRPUUF6X8qZNtCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crzuaqhD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crzuaqhD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4980dc26022so13785515e9.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767472; x=1786372272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aGNNvpeBB2xFe8o+eAG+ITw+sBusoz0y2d8gJ/h4GCc=;
        b=crzuaqhD32tZylx5ndKwb6IvjJedmiZyrqlIP1NEQd0Q2lhDGUq34CcdY0i+LD7TdO
         HHlZ9I98cXfpHCGcVy0YqK13gDli1Hl1ObqaMxcztzMAVS2LRBQM5uskuNKJHRLp8j3W
         xCpovROFnXhsW172TcDfbR2shveaZc+U91lRkAtOO4I1JTTvJVC9oEA8ZHKdXFxo+JkI
         4cezzWvEfb/fq69sa09DQaQ6vSvL9rkYZgk9GUNvUHL1GkTiGzruofIqlHKhgnaaH+qW
         sd7sZCzVk/KbWWf4YQu/cFcTz6Bl1rO2bo1YuyoMUawUUC08AH3IZaAJ8W0YCdxTngAn
         LJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767472; x=1786372272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aGNNvpeBB2xFe8o+eAG+ITw+sBusoz0y2d8gJ/h4GCc=;
        b=LCMLKaEaRJDWH/G7K9hH7+D7WMpxa48DOy/JF7sPwp9WmpAqSKF2LgNROhFZVeduP4
         NxWPU7LByApYCrh2iTunz53tknDj4HLX58PTB/VIBvDb3hv34T3VgNKOsPbs57lN6auW
         JusbbzJPIRX8YnQy8GA8CvvLexOIDenjLFPrvsVClOL5v7N599hZcEQHAI0d2Uo0KVto
         RmdSXlQ0y0GraiQP3olqMCDwmJK4otX76qu/Cv/6z+s3D6HrRb69413YF9wg03dlgaLh
         nLmU/afm1vu1D5lBSE5Ja7P98MMWiCLe9Oynlta/07vgU8GtHpq9cjvPEGKr2NEEe5UC
         xr/w==
X-Forwarded-Encrypted: i=1; AHgh+RrUdXYz5AGlyxHwHJTlNnB4wkKh/1Wn+878vVM3ccewrUTCLzSQgPvmOgKar+1xhQEIlZ4FIjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2aSfPKp7je7UvXAMCX667pxlJAir9DFgi97eI7FZs33mgjgVx
	P1X72LfpCCp6AgNrLwY7c0hndefdJoFUyWpX9bhpWtGpWH/RcNxlcTry
X-Gm-Gg: AR+sD12/j4/FFtne91sqwUvp+0IoPzCwSbzVrB+PVdNba3HdZK3z8CzYwdYdMlS1vw5
	SlS7ErNpYDgPe7bMq9FJeS1bG25DLEkMaB19b4hliI5I7yVuUCAMryBmd/yNI47sprdLNnG4jvS
	8e2owNhTiQ61I/DqDgObGjP8gwwU9UOUrl3JXXm9B6GCu7cOYHAkaC/CEQGzQyKORfWB3AB1aBb
	GnZyNZUBjpXdHUe45xN7Uy2vd4v8kcey15JaGTU6y6QhAAzOWqnJkAY98WLY0c8ehMWmzrD80gm
	xj0ed7l/qz5mWKD5kKt5JCqhDURiGowIHlQjqgoAVvV7NUaVxBQfgrkp6I8f9a466UsmpMdT3zV
	N61IIRzQaOaOBV39HrLCUhYMXuYiN7FbHdzB5XGKdwsz1DybzED9vwuGsRmtHN0IUrAVyyIotgk
	S38yHmEFPxbaL6DW86LXEYcYs2VnbH4s0nJuW/HKvhlGOH8by2tIC738iFK8QCe5i0KdQqLw8cd
	OXSzFkrR/ke5zcO9IBDkQfZepeka3G60HUFAUvoog==
X-Received: by 2002:a05:600c:a47:b0:498:1371:6612 with SMTP id 5b1f17b1804b1-49813716987mr143983415e9.6.1785767472196;
        Mon, 03 Aug 2026 07:31:12 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:11 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 08/13] platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
Date: Mon,  3 Aug 2026 19:30:31 +0500
Message-ID: <20260803143037.93105-9-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
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

