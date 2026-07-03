Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8041735C
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092436; cv=none; b=Wn3sP67iNBS98xrHHJiFrQF4D5FibZwvqZhACKpSRqvnEVHdNd+q7phzMkrQrIdE0ZR9Ss6wGjeMXH/PCvhSSAd81FAG0UPpbg9hqG2tZtiIYxaYU+/6DfUD7FsTs5UI2BvwaQdBRq4JQidDRD9Dx2HoJsxPydtd2zSFqdL1Dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092436; c=relaxed/simple;
	bh=TukiYcyaL6HvstWzY9oV1D0LPs+P1LWTmZhuuNPqXrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=taVEe5fl1BepVDy+73f7tkf/UrvJOieRGFr+X1V2iI7mOLw6/hUMHCylQihAKiSN5sU36++stSO0tRwzqdvIE5lrjYQb03ougO99N1SjI+xlulWXihEJtoaSHI7Bvmef+Po0rpNZcEeLhXB/HhtoEobBmPvv71uII2za2v3NCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kxwh/pP1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kxwh/pP1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so184635e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783092434; x=1783697234; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7jpWuBmgCfnac9kWe4AodWLj+AdSLC8VyDipYsDjci0=;
        b=Kxwh/pP1e3GlSdUkvwxexCLYyk2B6pOPZfxTrOplLomg/qHxRy4ReW5Vn2GdNG+55O
         vrMeVpt1Vt6OFKofBjJU6wS194EG1PjS5cd7F75gV8cLOUCuy3g25/E/jMLfFtrjdl4n
         VIdTO41eWQ+T7FvuBWUY3LqaJMpsJSrHgawSlc+o6hHm02/xr9r3L5fhfMforWPGK+sQ
         ioJZvq0kQK2JNOVCTbTsrGDP6GDkQTz/eW6Uev/5qWkX/47Y1YsmpJpXFnLRFgzCMNiG
         Kj8ManE6UThUlEaW/BKnpuXiP0CA8BuliYFA4IzsaOwfuYXK66Nkgo3eLX1jaB1JqkD8
         yMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783092434; x=1783697234;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7jpWuBmgCfnac9kWe4AodWLj+AdSLC8VyDipYsDjci0=;
        b=D7s0v6c4CWKleKNNkKq2yauh30IBQU6VV1t6pvjYzz7gAeLV8ZqqykjgMNhYhsl7cO
         zLGmfNa7drE5IiDOBprHSvpc36mMkg7g7ULpiITKfWKBgGNIXdDBW/ywI6S8Q7cm9GrY
         lp+2cl7E0OvoFmdLD37uLzfXrZdSgf9gbRkUXjvScIN/+14PYJqPdXcnTsvZ4jR84tPU
         OeTXFaBXCF1Dql/v0gQdPNse246lz2wXjVqrQ4cSXjQ7dxonpkiLgj78y5edEhNFFXVn
         w1pB5rx4DNQcEt9CuLyNekraJAcmY3cjxMFKJgy21jhiaOZyBvYnxcB3hjpeIGrbZe24
         ibEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bkcJvRPzwQ9Y8zyc638ZbDjNJbgw2t66gXZKms03zv4SHn4hfB+P/hCYY7hJuHEB+ROFCoNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjeALoMQakJleFnQ1a1JHx29yutYpoQPnqqNPZjBNMUebl0cD
	8GvsBQ+e+VBfadr+Ckmip/nYbBdJ+ID0iKrVb/y25eQp/qOatqQ0HVj9LNU4rdjgCvc7HxPIgYm
	bvtr9llu8
X-Gm-Gg: AfdE7ckMuH0P2c93TN+/MEukhLxPKXqMRxQSDt/ryyDAtuDjZLM6WPGgG7F0xyq2pPO
	zA0fEEIw9CfY/sNgHXeCB/t3Y5+tzYI4eyE3SjYz5YLAZFaB6MNgsEZ+dxMZAXUlQ/eWdlneYC0
	ujNA/ga7Yn/2fRYSryUm5mcd8Q2itUUXKoPkp3gEwRTiVH9K8th6nVjBRcoVmvwp+AIQdpw+YcX
	paQQ1SPLjrf4Bko2jKfZBbnBBDujdOXBNkF/hTQ1+NcEScGNlJ3oJzqLqAZp5Yzzn8wJBAArI4X
	UP/itvFw/O9iVTROI9HabXR/fOh7840L9bKKMrUMX3l7T9rTVdG/Ec+B+6RU91mC8w4EM3PvFip
	1wssZ+hloe04STcQAuMu75sek35bfRdP7359ictU4mAKJVKOEjLIECLsVwqYGikLjsAn7iXOV4Z
	Hiw4k4Vj/d8IgyG2cYtNjAQoHGJwCdEnrFqhal8TWROuwzr3PMXKBuzLeRTgInTbmKwrX8uQ8=
X-Received: by 2002:a05:600c:b4e:b0:493:c1a0:7fdc with SMTP id 5b1f17b1804b1-493d0fe58a3mr39155e9.0.1783092433298;
        Fri, 03 Jul 2026 08:27:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm128009f8f.10.2026.07.03.08.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:27:12 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:27:06 +0200
Subject: [PATCH] HID: asus: fix UAF of ->kbd_backlight on !CONFIG_ASUS_WMI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-asus-uaf-v1-1-1a2af2534eb0@google.com>
X-B4-Tracking: v=1; b=H4sIAMnUR2oC/yXMTQqEMAxA4atI1hOIFX/wKjKLWlONC5VmKoJ4d
 +u4/BbvnaAchBXa7ITAu6isS0L+ycBNdhkZZUgGQ6aimgqcZECrUTFaj9Q3nBem9I4IUrIF9nL
 8d933tcZ+Zvd7HnBdN+42d09wAAAA
X-Change-ID: 20260703-hid-asus-uaf-0b8e1325fc00
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Carlo Caione <carlo@endlessm.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783092432; l=1129;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TukiYcyaL6HvstWzY9oV1D0LPs+P1LWTmZhuuNPqXrI=;
 b=XC0Y/aLHtVUdK7FUQMa2p9np9WV2IGgb8xx+nXYLcWs2l9I+0i+dkh4YaSSE+qi0S3EGr9E0+
 eEOGREV+LiQAxNk8xsse4T12xmiEnjNbM7o2w3o/NhX7dJYqDHzWTEU
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On kernels without !CONFIG_ASUS_WMI, asus_hid_register_listener() will
fail. asus_kbd_register_leds() reacts to this by freeing
drvdata->kbd_backlight, but doesn't NULL out the pointer, causing UAF when
asus_remove() follows this pointer.

I have tested that this bug causes an ASAN splat, and that this change
fixes the issue.

Cc: stable@vger.kernel.org
Fixes: af22a610bc38 ("HID: asus: support backlight on USB keyboards")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..c2a5edebbd7a 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -777,6 +777,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 	if (ret < 0) {
 		/* No need to have this still around */
 		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
+		drvdata->kbd_backlight = NULL;
 	}
 
 	return ret;

---
base-commit: 51512e22efe813d8223de27f6fd02a8a48ea2323
change-id: 20260703-hid-asus-uaf-0b8e1325fc00

Best regards,
--  
Jann Horn <jannh@google.com>

