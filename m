Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18947B432
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039111; cv=none; b=adP1/5tVOfRkvkkTt08D7NzMPPkOSrN5SJ8B3ALBpdGLrCm4KgcgGGXfB/KZ0J87ZmiSVgsM0qnDqJdYbZhgZI2oc5tN8yRmzLZMzZEn14XtQsEcCZunHr0J132DEcv2qoh2JFomU2x25IPn7AWqrcNwlfJCB3lBDCW9S1lPz18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039111; c=relaxed/simple;
	bh=IK3LCy68nNia2gEMkKnq6We11pVBGa+uglDzb2BQn0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGzFaJzzk5gpIFePD8p20O9e6t5o9E5gJfNPwKZVZsXfNRknu29isjMIrTTyYgoEo37LnPYH29J8X1XdbT1eg9qFVYryVZ0csduVllyuKlYlSKl8EcfrlBVW0oIlESiHXbUvyQ8y3VLu1PVrWzQ6rPM4+Moi7JoAGBBi6SxWkkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TZIvveBF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="TZIvveBF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso33952175e9.0
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784039108; x=1784643908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcfrg6EgnjJunuXszKnS5dRMOUov45ln2QkWfO7ihtI=;
        b=TZIvveBFvGvE8FBiW5rVXisexkGUyXphLa1Wmmw1YpygomAI61AYJA0mrDvbOij1Vh
         sVp+iyJdxLyxXQvvRXrqCMLTeofV79eGv0wUuiBpGMVvWIzsWOVor9+i5P7DzbRHYw4v
         87PUatCIn1vGZhDKG/gPJ6ZCNb7n+rO8ugRjoGKhJe24SgoR4xrPBnXbPPQcjtLGiKYp
         UrfPP/vOIj/H8jpF8O+hS6+HFCl4rBOAMLZZoMWaKGG9NGcqewhBVQu1cqPhifyehLvk
         8RztKZ1kQC4oAjlmtmdbsiW3xjvVY+fGl89ft3RlDKdgj+B3bAgVYkA9cTdcqGoIiNdj
         kJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039108; x=1784643908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcfrg6EgnjJunuXszKnS5dRMOUov45ln2QkWfO7ihtI=;
        b=CSj7ipyk3s9HeZbOLS/onXd6RMN0/g67nmZQAuFJFZCUS8sMjTu+hq9I2Ev66AQNl/
         cI+ZrgnM58j86zaRcCF0xMJNH4NdQjaChx4EkhO9JxtZkttHlGiCaVgTKq377l9bq6d0
         SqRHsQOXB292zocjKaodBBl5XeFL41V3NRYSfyODBo9vuGHhuqsYFY7jXBNkEJi1DoqV
         XOkOqAwk62d0YRYI9BVSfg15wch/f8e/0usnmmprPlZ2iIqnRSBUxjIIxPYqUcso63Nc
         OcdIUIs9y3MGCANNFttASBN0nh2g7UpYKj0gFlnaP+idqYO9jpka2DKt3GDcrbxZMgR2
         Dpdw==
X-Forwarded-Encrypted: i=1; AHgh+Rpvcxk1PylBnphughYmc5qV2k8IEMYI0gCYSNL5m5Bq1BHYrL6ogtALb60Ju0Pkz76h41hpqf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqOEB0LQ+9UM8i2HQX7nwQ4HdRLwyf+/Jp+IpLw0L3wZ7arGS
	qDC7jL714saT7fkvT37H2n8bD8AU5s4TseALh0wc4GnIbwDdbGZ8DAr2t9Bym+zWTP0H
X-Gm-Gg: AfdE7clvzW5CGeb8R5xudMM2RnqwCzRqkkZWLOz81cThYBKsKO7i+rQbaGAfNRUokKM
	X0KFuXRKA8HEPJkankK+vZbL3bMlhgWBHXEE7GyDRoIv7JagD6TUqJIgXBFzB2IZpnebCNpvxym
	kHPopAn8HKJizgIPW4kE/dCOh//FrZ1MFTHNX11HnllB4O3h1GFb8bOuqDXtwkaUVQ8giYsBVPP
	YyfKQUcq5dNyjkzBEdLZCU5aEdHuENqaFToiG6ng+NbJbl/85UwGbftqIH2gw0F4FSHPc5xH40k
	CONRReqjW+ciUEnJNxyTnL1FXmb+ERxqaH+aGJmHQYIRMxBn33LYtY2VFSakqwOBH+17uE96eIx
	S0cHpkIbo9ct1f0HDYQ4Etsrwz7dTcl1e8WOOQ/4BdwW2PTuJUjlH0MREzVl7dy35Z7CiHTJlMB
	/W8Cq6H+kNKOAbp5bBP6hjPgqA5DqW6VYLNn1RUl3SX6dlEIAIUCQYz/G/dQutJvksidbsLP0Th
	L1kNQMvVwmEiRXNugvRoAvkrFpwA5hu04n5wN1wjw2jbg==
X-Received: by 2002:a05:600c:4fc6:b0:493:e52f:6ee1 with SMTP id 5b1f17b1804b1-493f8784bb5mr151350735e9.0.1784039107888;
        Tue, 14 Jul 2026 07:25:07 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2ed840sm74518925e9.10.2026.07.14.07.25.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 07:25:07 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: uclogic: Clear stale pen_input pointer on partial input registration
Date: Tue, 14 Jul 2026 16:25:05 +0200
Message-ID: <20260714142505.95630-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclogic_input_configured() caches the pen input_dev in
drvdata->pen_input before input_register_device() is called for it.
The in-range timeout handler uclogic_inrange_timeout() later
dereferences this pointer, guarded only by a NULL check.

If hidinput_connect() fails while bringing up the HID inputs (e.g. an
input_register_device() failure, or an input left unpopulated), it
unwinds via hidinput_disconnect() and frees the input_dev, but the
driver's cached drvdata->pen_input is not cleared and is left dangling.

Because this driver installs a ->raw_event callback and the hidraw
interface is claimed, hid_connect() still returns success even though
HID input was not claimed, so hid_hw_start() and probe() succeed. The
device stays live, and a subsequent in-range pen report re-arms
inrange_timer via uclogic_raw_event_pen(). When the timer fires,
uclogic_inrange_timeout() dereferences the freed input_dev: the NULL
check does not help because the pointer is dangling, not NULL. This is
a use-after-free distinct from the timer-teardown case.

Clear drvdata->pen_input after hid_hw_start() when HID input was not
claimed, so the cached pointer never outlives the input_dev and the
existing NULL check in the timeout handler becomes effective.

Found by 0sec (https://0sec.ai).

Fixes: 01309e29eb95 ("HID: uclogic: Support in-range reporting emulation")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-uclogic-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..396d46b0b88e 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -262,6 +262,19 @@ static int uclogic_probe(struct hid_device *hdev,
 		goto failure;
 	}
 
+	/*
+	 * hid_hw_start() -> hid_connect() returns success even when
+	 * hidinput_connect() failed, because this driver provides a
+	 * ->raw_event callback and the hidraw interface was claimed.  In that
+	 * case the input_dev that ->input_configured() cached in
+	 * drvdata->pen_input has already been freed by hidinput_connect()'s
+	 * error unwinding, leaving a dangling pointer that the in-range timer
+	 * would dereference.  Drop it so uclogic_inrange_timeout()'s NULL
+	 * check takes effect.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		drvdata->pen_input = NULL;
+
 	return 0;
 failure:
 	/* Assume "remove" might not be called if "probe" failed */
-- 
2.43.0

