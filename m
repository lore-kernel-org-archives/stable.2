Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380194;
	b=JZ+yJBbZ7QDm6fJXTZtvMtktkZKLm4GWnckFKK6mL8o0+UkfKDhPrtnjVqJN+z6mnqC1
	 EMvEkCrHCkjfzZgAaP+tffHeSGdaK1rWVU5Vt04AUzYBm+GufYfku94M1LyiFWcMdHs0N
	 lfIz/fHjW/zHhXYJgAMM9fTpdEa8oVpjUEX5PW71EhkjQ/uYpjKJ9rlAYgT74TEyThau5
	 j1nwpZ+kiULEsp8JfKZwKsB1cslHOLlr17QqVWGWkLoJdXYm7frFNPxRMrY+Ie3m3R0Ww
	 LkYxZ/8P+GdsI4Ti1lp2pvnZPt6dfckJ2jj4vWO2GWJcLmo0o8wZ6wqDTWeJ3hl6DqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
	b=pMR+N1oc6NtBbyuBhyTLL9zRH2GRs+2+7C8rxgK1iR3DuqfMnECa6kWo7661DjGMPwBb
	 r4TkrzRWpG3aAkg1zKJMwxR4amJSTA0osXpdfynbPr1fEh+rwwHl70Kpsl/hFAmz3Ns0M
	 eWz//v+16eaVIOGuT38J9VMnykn5A8Irw6o1wWumfPheb+KQC3EXuM5U1ii+tym8r6Buc
	 JfVoBwesQp+UUhtgX5oi69fDzZ2KCqHwbp7esWxV9Qa9OMoP54i3LkXlmbigIQjh5VQvx
	 HKyMLCkCYwED3yU9zkw9yzS/8vTn65zsdzbMvPiY3L0EJtZfuc1NKiaFuxVhwCJlECQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SsBkwh+R;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F70F60A3810
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F70F60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SsBkwh+R
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-14394530ec6so3679342c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380192; x=1794984992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
        b=SsBkwh+RkvYyTpBTtc/4YgnN7aLAWLHZYO7IaApfZg/2+mTAURxhK77U4LOuamHTSu
         jkFkqCfyuaMmtT0wzFNdgVG7m+iuWt4idS3/lGzNjhfCRRgDTLRyBOJas3oH3WKoL2uP
         zkj3mIEaV/jebvGfL4BvKZ6nIZUfw8qc7jNHIvr5JGMHJYYdhVTgtVfmD9Za1zaIM6Rp
         DDI3WFIcsBe3/fSsOo/440Mz6TSKbTXDzC5bE+50fn/VvNa8V+vb/LCtusu8KTWhFqzQ
         tkG1oSN8dvPWpgWUA/UITBPpy5UJK4X0H83gp3Yter7D72wb1o9nAIdY7J6eQVz5NOE0
         3eXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380192; x=1794984992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9jhOOC622dmlAeDDXE08OsOwQ9rbd0t9D1tGFsBggw0=;
        b=QkCVLXcYJFbi2um3yoAh/z3ImLVXBD8ZjGcPXuxRInnsqCdFUYioK3K06p4l5kDWrb
         SLe2ref1j/Tgm09h6AQZuXNMCaM720fg0e6ZWtIE6MpeCUw/vdytyUEGkNB0QWXWGfiN
         TfnblWDiCZKknPCE5RMFkI10Ie/pUS2kLJ1Ui72wKFGO/zOhQrul1YGpFrICVsLTDQw0
         4eicrMh18pURg7eQ8uREtkpiyiu1Ida+xcfoMTY0sRUE+OozqzqiuR5hjqIrAzVmBHmZ
         7IkVlLY+yh+DXrdVa7hsKTv1udiQm4X8GyGp2sZyOtGcetBj2THUBoNVklQSIqJLjaOj
         qmhA==
X-Forwarded-Encrypted: i=1; AL+hErG3yVK9j+mpHK8a/Jad2tIvBOHZEQ/ynaSVr10ytr5z/DSjng6jvr495THinvDZpK63JBld8KQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z870qBeKdeWbcCwkMAfXVzbAhT9l7862DDUXkB2e6Q0+DK86/8G
	cNCNDETqQ0BUqsDcnwcdq7dvsY2dDKvgPuBF2iSk1a6Eu39T8KZMgFR4
X-Gm-Gg: AYBFou2P3OQkHGI+rYpOJrBZ4W0cqL+hgH+nMH45PpJ0E3hubEMmkJc1AkzieXvc/Rh
	ijbLZef51crYpCQVVhlekWuRRIU4o1TaBjLncPv42BmXLR2nHb1LocXJy0ORlGEcbW/nDRt8qm3
	kWFzldO1r5/bt44oSGHkquHj6UC93oTUg6l7TwpmmTDK2zNnRkiKDjteumE77azkviCgZxe1o3F
	YC1IncECpeSGkHJXFNE9BRs3xG7Gfgga0yYD748mGLiDQdtx5dHbKc7fHdfyiubyXWRCel4pRkH
	SHdUIQPh6/ivBOUlL7zWATOCQu3NLXmcyrubKMdznGAy9F6I1xSeRnXeT1J44P79Ap75k1P1Mju
	37lEE0Txwx/X/zIDvNWGNls3aVrNyjUoobpK3KbwExQhZfuVDBnMQKttoOPonjKknisFhoYzZ9I
	Fu8E5BWYnCU2RHvjHAObjt3ZrL4liAxgitZLKIAKekXkZ/b8voabZP4zL7OUu2EczoegcVSpdAh
	pYZxxvlORMxTK3/aOtVvEuOeY4YEe/V0Fas7ETOziBOeNKKJfcK8WSOraMkMKqIExIePoKn1mv4
	YpB44F4Q7RS6H13HYpO3c/WIBQF2vIRAPypaSgCq7rreKsOCb0qoxk3052RlcG+NNT/WmOVC4Rf
	FS2vfHyIaPW1DJRKmsQ==
X-Received: by 2002:a05:701b:4513:20b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1b3c023deaemr1635953c88.4.1794380190728;
        Tue, 10 Nov 2026 22:56:30 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:30 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:04 -0800
Subject: [PATCH v2 06/33] HID: logitech-hidpp: avoid NULL subtraction in
 consumer key report fixup
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-6-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Report fixup runs for all 27 MHz devices because the keyboard quirk
is only determined later after parsing the report descriptor. For mice
and other devices without the consumer collection, searching for the
descriptor fragment returns NULL, yet the remaining length calculation
subtracts the base descriptor pointer from NULL before checking the
search result, triggering pointer-subtraction undefined behavior.

Ensure the search result is non-NULL before computing the remaining
descriptor length.

Fixes: 42bc4f3129e6 ("HID: logitech-hidpp: add support for HID++ 1.0 consumer keys reports")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6ac41b7d76ee..53c171dfcf96 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3872,11 +3872,9 @@ static u8 *hidpp10_consumer_keys_report_fixup(struct hidpp_device *hidpp,
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
2.56.0.542.g3ef89b7020-goog

