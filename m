Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812663;
	b=TrnNqqSBpbes6kjxskDYYWzcc7voHhpB4NH2cv9ceRxEQKeQ8p39RTO3G9GPsN6MSurq
	 1ciLjPg6rd3KKL3P4MFV/ctkgYxNAIqxhzo7m+Y0xxwuKwB4eZ19mmiPRD2pjXMR3IWfK
	 4BN/cqir5UicG3VB/HQm5eBcYvjobWnels2JT3nOQyswvypFYM81SG9x7BiWa+zLv0hrl
	 Pi5w34hMyjRlVu3qUlBe+hIqe/emyADYADpJGeg4CZkt8mcNG6vl/IBkstElJ0r7Evn1j
	 oZ7sQoOmrThqE3oSsCo1wAyuvz0muuxREIF2bWnVOyVm5Z+UTz0tag5I4JJiqknMaYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
	b=FGRGy7avplm7lJZ7me9q47pEhF4OiaHy7fc7WNABfV9wifahY9vGMkot+Yh0567yK2Yn
	 q7Wia0YbZKGLrDowUILPAky16R9B+RmE0k3djG3bKsDixPQ4k0CD7CES4Eiz38qBf4x5O
	 epIL9yQQIQeR48k9e+3/Iuzqn4Ci5WF0OCve2LX9ftzDaXE0XCYQf0KIt3LOx5qK4127H
	 Q2+XVjiEoQYHN70vj2N5bSNaeEjO+//uLxKcacNshFQFDgq36qXa3NLz2ufjal2BEBAXL
	 CMrCfT0MWm94wblVKEXuD0XUdCAHIYJYNjIHXOuHvNYrTHahr0RZM557gFeQT3BB/sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9zeuA8P;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BF606A31D
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 428BF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O9zeuA8P
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-368581df789so1658110eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812662; x=1793417462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
        b=O9zeuA8PpjKR/mNeICZ72Ke+3eAhqwzD/YRJmTXJV8Zg4sN0tU6IOIBLWiIHESCH5M
         9kFIIWVp3YFzP0PlfpdiXW0MRcER10Tz5Xx7mFdWbHeZdx2BekiAcEVAK46VQXtyiBxh
         F0JB3FGAQnTAQ2pkrEZwul06jv1vheD+Dz2zn9RQSPIzR4shLjcD5B1irWqyuog2GkXa
         PF9S+RAwu4G+uQdbUjBmDhVjtQ2opsaEKTyjFDtytP1nRRDrxM+FPMqV1EgyLvl/F9Ne
         QcVRS49rnc3w+GCGj3zQo9VMTKnn4oShM7/B3KBIfE0h+ILFQirgTs42CvsbJlOwrJ55
         TlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812662; x=1793417462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n3H//P2Xt+SFt1vuWW61mGplc2uJXCj0F7tBueU0V+E=;
        b=DgmC+6wrD6bA1AViSeVJhBq9AdhFcjiH09G2/CzoWet2i++KjC5oFBp6zoeGzaZc3N
         5OTYjqvECqtx9NtpMhCROxSEs8EJzeT3qUWZelxs85jDgU9VWoog2KTWVQLyANqA2WUr
         w3AzKv2zPySirjwHIHKGk6IzzSgDH8yJGRHbLwNiwSQadBminLlOwQPYaurGatDOk5CX
         ERNMXE5HHNL1tjxhOxreW0qIANLIdASzq7/VZroMBFIrQceL9X8bKO3n3hX1mVb+G4Sm
         JK+D4AglMgyremBKifM4iQY7e+Ca2O5O1fwiDz9tFIEmPucTplx7JS6ozqWHBY2U/gJM
         /QjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgngxqP4zy2GC0e6MVNqxIlrE8GosgMHws1J/qSopv00bgUFcSmqUaj8n87qpU/Qe7zbd7zy8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgJrOh2D0L/igbtyKkbUA8I391NrrFHIP3djnepcgoiwVJBuAG
	E3MwgLBGfezH1Fb32fzAFo+Uu2RKEung5gipNr2SBsAuaUkgZIYJ2qIj
X-Gm-Gg: AYBFou0uuWvOrFvtXKPmm1LcszaYO4Rv4QWZ80fnYsQGjKxme5/LNd137F+T1KLUthg
	82g9V8EshrQeKBRnGGDH1VfSmwWqgkssR+PUi2QSlCFj+Fo2F6mHICMyxMEv1yQk3nXkgnykq3z
	OI2QlxZB11qbTnRhOaIq5r2BEkbg642tkyhGlJSyIHtgiK4oiy4bfuf0lb0hzopTnFlhaFtET05
	dVg0lsS35/ibTXr2uC91wwV0AUBm++yjB40wnzgUu1xJsNoCP2BXWJoZMdSwJzeQu+aV2c6S7lf
	rY1+95fwtbDVtMMsE0Ti31teO5dygeQrcGS3kxVk6htfiXZ2MBXOqQ369CqUcxZjj8qoHnBYCjY
	isrvg53yk1vMKBaRJfHd19nZhtFt+nSRKJitXASvk7G+boLmHnqjRZoZaiqCiV6NSyhG/fbkSRM
	387LlOLHxLbxWw8mfhjmy944y4Tz44hzA76rEy3r3GSjS+Ilm7DuI3NjS189z0r8nQew2nbpx/8
	PIC2v8wIodkNDCYxmvJy3F0jt4FoOrEw/kqn25CIwEoybKvYegLB4hJncVdVLVY5N5ixYP9CSQ+
	m/ReMUsukjG71losvUK2Mu8bxrxJ
X-Received: by 2002:a05:7301:1a05:b0:361:2a55:b94e with SMTP id 5a478bee46e88-369e84d35e0mr1251819eec.15.1792812662302;
        Fri, 23 Oct 2026 20:31:02 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:31:01 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v4 6/6] HID: wacom: add NULL touch_input guards to remaining touch handlers
Date: Sat, 24 Oct 2026 12:30:40 +0900
Message-ID: <20261024033040.316652-7-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024033040.316652-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
 <20261024033040.316652-1-jinmo44.yang@gmail.com>
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

wacom_24hdt_irq() (also handles WACOM_27QHDT), wacom_intuos_pro2_bt_touch(),
and wacom_bamboo_pad_touch_event() dereference wacom->touch_input without
checking it.

As with the other handlers in this series, touch_input can be NULL when
wacom_setup_touch_input_capabilities() returns -ENODEV during an
otherwise successful probe.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4d6295f57c9..38003e0b8083 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1489,6 +1489,12 @@ static void wacom_intuos_pro2_bt_touch(struct wacom_wac *wacom)
 	int num_contacts_left = 5;
 	int i, j;
 
+	if (!touch_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return;
+	}
+
 	for (i = 0; i < finger_frames; i++) {
 		unsigned char *frame = &data[i*finger_frame_len + 109];
 		int current_num_contacts = frame[0] & 0x7F;
@@ -1660,6 +1666,12 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
 	int y_offset = 2;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (touch_is_muted(wacom) && !wacom->shared->touch_down)
 		return 0;
 
@@ -3430,6 +3442,12 @@ static int wacom_bamboo_pad_touch_event(struct wacom_wac *wacom,
 	int x, y;
 	bool valid;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: touch_input is NULL\n", __func__);
+		return 0;
+	}
+
 	prefix = data[0];
 
 	for (id = 0; id < wacom->features.touch_max; id++) {
-- 
2.53.0

