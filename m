Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204678;
	b=nRYI9j2cLRi7xEjJgYCU3xPDIGo+ZwdIIdXtWxNWvp6DKZ500U9ZqdxJU6Lj3UDPVIXV
	 fCjF2fQLaM95r1ZQmgqx7ORevXjhymPEu2J44ibQgfG49CBEkPxHe3kD2U9paT6OD6xEq
	 rmHLSFupna3TmI/9cw8aIDEZZR/K8wELuoLgOBqb1hQCvH6YjtahJQnW7Yxzu2z59q2r0
	 Exi7e7Km2d/ByIGmeEpciUsqlhXU7Dp/KEcz+KKvEPAoUhlSWkrrzt8/hnvW8D8TRSTXK
	 9lhP3yrkzJcnBw5U7TnV60H6I+AZSVA+jtOOgqQC/MCOQ5+wdhQ5OnTLxzq3iKTa7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
	b=BJ+fXW4VxsnUZD4ryXRRU+LHqIvlkJo1tyJYnKPT8h6YyJsqkkvjhSrx6vRADLxLY6by
	 MRBjoIuQDX4heez0+gMStLqLOx1s4isaFPuic+lQZNQKlor4e/H9YVprCJo0NhslRg+R6
	 Nkn0XGZxvm7JgwXP658KIO4IgWEOsRoyUlfyLNt6cGtznHf/K2bKlV52t/cvDVWoeUSH4
	 PWgfwx+RNZGJjP1oqms+MogAMyPAmlVwbG1XN5GM3idIsAh4KBjDcUvY3bXSpwJg0q+9x
	 7/nuiPurFkIEWIbiRu2CGNcQDBmKOx4GnzwtL6pRIUDw7zRgvZG5+x8JilRm8SZvpLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbG3f67H;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA1F606D822
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA1F606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CbG3f67H
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36ff9c9da34so901248eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204677; x=1794809477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
        b=CbG3f67H9GUeuN8CRNc5kJQBRsAnWzfsF5ytysEWLD0oDckJ7to9w+mGZ51P+JI0gK
         mZsG8X1UFhB7aWz6wSl+gvElBeCgseMK9GMdZej8g5yglvAZILYXfTOmlOHuI52QYiFM
         Cky21RlWHqUQxh/fhTZngLTW958l70dcKIDHIacfIaoapajRzBFJlc1Vy4rjIBd1aPZY
         P7CSFN1jzfHti1TC32gmJI1j7VhoThfghd/qO1+UmY6TGurTJloY2MEPo2TV8UBlUJ4o
         GiiWbrhjw686kzrn3W3oo3Yej4w44vnL4be2s7XaRRo2nwamXgWXfFshp8SFPQx2foee
         MzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204677; x=1794809477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d0+9T6WMMBqwCfVLifFK6dacPPozrHvyz8Xfn7g/UCw=;
        b=kUOfmtYStR/sG0cILYH/s+imj1hcUGZiV+91NVDb841zybbThqhhU0EKSuYbCKmX1u
         QswaZ0t36QCihXShpvXdrbvKhAXoe/hrny+Dam0k4i7su4NRdSCaSFhdkMw/7UYYB33M
         oRf92DP/njyG4yLBh9prq5CykdFL8x7RzmYbGGBUQvnFqAVFu6OIZ9A0PD4E3M96h7tY
         AJIjjfxaVV8RQnVEQFtT3bhCH5THwPNNdbiBwVOJnnJEVKyGGOv9T5v4gzHd2nPI74rU
         RmrenOSs/te/ceuI8tHI/aHbHkPxv3jCiA5QNRzlvJd9xEvwaMbNJlvb9GTu1a5YDmHu
         qKWQ==
X-Forwarded-Encrypted: i=1; AL+hErHgfIRDqXY0bJb7Ep1+CL0Nq8dPLQIdqAk+EANJOkj6Jb6MnLo9A5ZNWb+6QmOkUD9vIBdo0rE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rEKtoPhBk/PUzCYg0XCvkdxQhMhagtM5K5tdwpPY3K3nl4S3c
	h5fAGrpezdbjgnoaa0zjLzmhsTGLXxB67eTIaTPxtrJ/OKbZ/pfMjW6K
X-Gm-Gg: AYBFou0VD5nB0ExnxKqJsRO5EDOauW4nHsyWo2DucRk547YKvMlgl8EV+KGec4S2ehx
	whi09MNEXpWaq88gbc5Y+o+aba1wdN0gvgmyRFyb7blfxX16BCFHy/OYtuAop7NvQWKUbCOpocQ
	bLP9Gfz9or7gKlGR/DEHMdTImJ8mZvdtSf20j/VPoyjQqG6LtZaguy4Ec+caKoznsVXljqgDY0Z
	2pxnvGRrmhVReyT/nlXPWUQMzE5vrE6I1TKc3emcu0nUN0OivvAXlyr+iTt509Wk3SofVGL6QuO
	fxWgXV2S1LngR/KutUH7mgCdbaqm4FXZwR3B3udN5Rqhuju3df9VuvBaEPl5q66SZddTpj0bgYu
	4WUhZvs+55YNTb2fZMWeaGi7JsY0JvZhaPFd3tZkw1YxiNDYQ7BHHkwUty8rdDQe1jHmVIZ4UVA
	8POOGyRkaY+4ktxzi0z7kxaDim22eiLzNTPFQL3LyL2nCD72v48c2AUWIMYn8HZsWn2ZXUO2fBW
	wJ+F0JVu012g5g3xj+0iPRadUYp+knlD+hHBjNhL6feEUSuX9KRySMbHRBSJEIJvsct8c0TaI7E
	zABtLeVlcoOojfXyOadiYTW8zZwQxlABcB2U5YWY9IngxVhgBORi2ibbM63PhFJv/2e2GDdVrvd
	eUteXIy/3nFI6cAR2
X-Received: by 2002:a05:693c:835b:b0:373:9551:b971 with SMTP id 5a478bee46e88-3739551c52dmr2920611eec.14.1794204677033;
        Sun, 08 Nov 2026 22:11:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:16 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/18] HID: logitech-hidpp: avoid NULL subtraction in consumer key report fixup
Date: Sun,  8 Nov 2026 22:10:50 -0800
Message-ID: <20261109061103.2887636-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Report fixup runs for all 27 MHz devices because the keyboard quirk
is only determined later after parsing the report descriptor. For mice
and other devices without the consumer collection, searching for the
descriptor fragment returns NULL, yet the remaining length calculation
subtracts the base descriptor pointer from NULL before checking the
search result, triggering pointer-subtraction undefined behavior.

Ensure the search result is non-NULL before computing the remaining
descriptor length.

Fixes: 42bc4f3129e6 ("HID: logitech-hidpp: add support for HID++ 1.0 consumer keys reports")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9f3ae8724dd2..a1a69705338f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3866,11 +3866,9 @@ static u8 *hidpp10_consumer_keys_report_fixup(struct hidpp_device *hidpp,
 		0x26, 0x00	/* LOGICAL_MAX (...                    */
 	};
 	char *consumer_rdesc, *rdesc = (char *)_rdesc;
-	unsigned int size;
 
 	consumer_rdesc = strnstr(rdesc, consumer_rdesc_start, *rsize);
-	size = *rsize - (consumer_rdesc - rdesc);
-	if (consumer_rdesc && size >= 25) {
+	if (consumer_rdesc && *rsize - (consumer_rdesc - rdesc) >= 25) {
 		consumer_rdesc[15] = 0x7f;
 		consumer_rdesc[16] = 0x10;
 		consumer_rdesc[20] = 0x7f;
-- 
2.56.0.506.g506a7eabc5-goog

