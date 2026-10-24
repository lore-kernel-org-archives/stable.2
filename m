Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792875587;
	b=Fayv307WqNokK6U0+37yTpjIqORgn930BZaM0BFpJIGOT2tg5nsXK+u9wrlNm32hEO7i
	 2oDdD/GYCVJUtkXKh5Z7zms3OimrW2DJs6e7GNM2XfuNyw/rzRoU600Yt4FxO6gQ3z4Co
	 ChqqTJAN+yS3XxB6iL07g2J1atymNPH9KlfaJjm4yLYFMbekR9b+FaffHo6VaUJ6kim4S
	 6zMs3WfIuYg3hWzrwCYER37CF+BY3JQnWuvyijhHdTEKyPTWrZ2eRQ+7OdYLPZ7JRuPYF
	 6PMhMThtcxeifp/aACQoXOJj1+o1l55YYocJXluuoq4WnkBp/3OP3/ih+HZ6JTBLzvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792875587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
	b=potyDVh6RXjuzsOz6sWVlhetaLYBT+Ryy4Pz4MG8mK4UFlSTEiJxIojhIYFP9EM77yFD
	 7mVyhrTKkKeZKidAZlGMwrfZk4U0ZkU0zHWwblCNgY10BjGNIsD+pKHu/TWaXfxmhMoWR
	 pXqbd8Dw7D1lPWuBN07FnuRc5tepC9Cm+IupWotv/Iyn9l1w/wzVY2sVhWdBKFJq6xihJ
	 Q8DaGgzWti/gJ/2DoA0L5ZLI9SxnqBxIh94D/6lvvNgVBC/M/GWmkjsT6SLAHDykfaqXC
	 ihlTYS0zgTlsA9m8Xg8SopVWL/ILn5V6TQVGWjZiLrBjTu5/PF7/IdvtNoPdlZx4dGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="roZ4/y44";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5035606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5035606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=roZ4/y44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so3620555e9.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792875585; x=1793480385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
        b=roZ4/y44G1EO27OnJPJ3sDl8ZFtcBwtcgPA6kkACIwOzj2BlHLGmNU2t97n8+6Uk3m
         Y1a02QfANryXw/VAZ59g0euXvFSdeNXCq1WvqYAdUTSSDVuCDGboBVCnV0sd0ujDKWW/
         p1Y2cyz3AD77dd2YoGCVfqEbOXHfz2ByWLA5eWcleHp7H9Z2tSVXprpy3tG7VzDhMoS1
         QK3c0F5TOeLSm+n2gHWxXUgkydr1HVheK4GVOIPiDtZTqSuSGMc+OnUYN9lQIpON9jzI
         gK4ei3pdbOlXG6I3CIRBhLuvqJUBukapPDgDAwJgSZbHkne9rpkgOXKg6PBogmn5+H5I
         Hh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792875585; x=1793480385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzDkiyczJyz4mNLu3rtCyGgbHEPN6yDhFIklvUTjWo8=;
        b=Jz9eXEQYwLyFRFDnTI9m506ZCda/z2o9m6PCEBIe4+hamtBy/lITsl1hJBzNRpbJBe
         hP2tgIUgohIRojJRhZ9tm4b+/fFhRr0naXamG6TOj7HNgtT6Drk6bVgG9+3uu3tK/wmb
         MnEKiqOhUrNe9yl3H5C3XooYi6JlCEXIhoseEl0z6N81XQOLbjo6o0kVHOajQ/sVU7LO
         tOs73m74NVWe/SXqXxhVgNCPCZaNj83xlYV7sXadJA8IynOf8RJad2z0+8kpZc3Jher+
         FKsyQ2542fFGxbrLmxjK1Q6TfI9Wlywkjl2PPxRByVKmlPmTHmMZ5Cfm+huF4U+c4J6Y
         Vjqg==
X-Forwarded-Encrypted: i=1; AKwUvBzbCdoKrT2c3tTNCdpCm9STniN7c9acDpMXCYcGHP9p0H8e3twxzwYZAHYI0WI3pEfQ9IeVnFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSM2UJdWeJ8NDrznhF4aVX3gHNq4SOzN6r4b1TzcQACsu6GgEb
	IYfr13nfRSb2OJeDamkVHX07RD8Dr+d/1EqtayfiFAazFB8Cr0APT6pZS9Xw
X-Gm-Gg: AYBFou3j4kWxsFCsSC8ZBKIy0Ze0of59o4D3FT0uvDte8RItzt/JfUUAzaXRpjZzWdN
	ZCJ/ZHUnHGil5D4WV7Co1GdLfOiDe2MJhf/zcVH2BI26Hv50CLV+xbHttRH2aYncbZLPaHimDv9
	/fIJ1p2idZE//USjMpMMxwVwRuj7NDciVwd0zr9UpjaUksyitaI8inoBWuRGZAwEefU7ie8tmIP
	Se/lXabvXimX/EbbZ082KwJboc7BKviTIspmroRWWAcEc2YuWK8dK9VL8+pZ6M4UZli0oEkvWOX
	BC8Zm4Lv9c6pVJ1rEQ4tcuqmIaxwv/71aXy5xHZMdJ+DvFgv/t01DjnW7ojI28wu6xFknVapDeG
	Pg+V3BTcsLug1l/DYNTNExoTjZ30f5Y2s9kWWCtlI/+Wz/VLf0tmEv3+brjUqHk92+ETpjmHTEt
	MgLdUP2zAYXapHIsiaE8Ixd1L0FYL+gHKJ49WpCLrfSkCYs4nuhYe26ikAIuajzK4gz/PZnpc+i
	B7OWpINnFjCD15N4v/oFAUe
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4a35ac99b77mr40539715e9.9.1792875585215;
        Sat, 24 Oct 2026 13:59:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fc1207sm60326925e9.1.2026.10.24.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 13:59:43 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Seema Sreemantha <seema.sreemantha@intel.com>,
	Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH bluetooth] Bluetooth: btintel: validate PPAG table element types
Date: Sat, 24 Oct 2026 20:59:42 +0000
Message-ID: <20261024205942.4056250-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

btintel_set_ppag() validates that the top-level ACPI PPAG object is a
package, but does not check that the inner PPAG table at element[1] is
itself a package with integer elements. If firmware returns a
non-package type in that position, the code interprets an unrelated
union member as package.elements, dereferencing a meaningless pointer.

Add type validation for the inner package and its integer elements
before reading the domain and mode values.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/btintel.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index c69a5d226e882..aeaf80e03f8ad 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2637,6 +2637,19 @@ static void btintel_set_ppag(struct hci_dev *hdev, struct intel_version_tlv *ver
 	/* PPAG table is located at element[1] */
 	p = &elements[1];
 
+	if (p->type != ACPI_TYPE_PACKAGE || p->package.count < 2) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid PPAG table format");
+		kfree(buffer.pointer);
+		return;
+	}
+
+	if (p->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    p->package.elements[1].type != ACPI_TYPE_INTEGER) {
+		bt_dev_warn(hdev, "PPAG-BT: Invalid element types in PPAG table");
+		kfree(buffer.pointer);
+		return;
+	}
+
 	domain = (u32)p->package.elements[0].integer.value;
 	mode = (u32)p->package.elements[1].integer.value;
 	kfree(buffer.pointer);
-- 
2.47.3

