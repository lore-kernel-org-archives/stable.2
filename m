Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204679;
	b=INjsTpGszqF7XmwsbCzZFlUyGUG2nyHPtte/7IvgryWUpuqAky/z358BVJtaMsiKJcbP
	 oqAGNdj4OzSkg8ZMnRWwRA5jqZNVJKGr+jQVcIsJcL+OIV2l981n77OxwBM654u4kp+Ja
	 YH87XZjRZ/F/wdMYrXTL3lDjPld1NlAKS6z73dTqgXCUvWU/ipapIrmSLgwUOmgKa9cIq
	 qQ2VbHtF94CO13u1/6cIgXmrpyi1OMHfZnQ3eTBPEot5wBQWKoB8rUdJpeI6VyGJQfvlW
	 uqhu4/XJ4wdmUvyFQhaATmEzlFD4koxXEKD0CpCxn0WBEFUlsMBBIS05A3l7j4Cj0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
	b=kqbpBkbjpHbT880ex1+hJWs9PmeijIODZIWvbc1d2jSSbWURIq2rUW37/nqNdOqTANVs
	 P1kCvGr1bFT2LwvHddK88HZBXowNFoUrwo1d8M9bGe+f3ubm1aMuFOQ045N0MbMnxB+RM
	 F/UP78kMWULt2ZhqhnyBcYlGIXv/tD2kWSJ0xk0S2qlnnPOHBvQbuEgbHFAbrCI6q073K
	 hykUnOjIADaWuzG3IUpHMr5Wvwuvk17VTKhgkJswJ7PpbhZUztudFbWX6f4wx2G05IDXr
	 yRy+wb7P7qdjwevbcYYvn5gzNSpIwX4r34mXuyXfJMQdFuPYKud2CCVTP44lpgWJHOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfplylRo;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1E606D81A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E1E606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OfplylRo
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36f6295304dso560341eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204679; x=1794809479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
        b=OfplylRoXH6zxkHdL811mTnHG1rZdYJjL1UcZLThcV+XmWvQYL4ogoK/zr1hb9sGIo
         ceYnn4cXghVQFjG77gaIyVwaJUz8isqOcypuV6iWqxcvSpbqtMBCyJTsTl/3YCLr10pk
         DrST9Xfqhp7P1pdZUuplHwm7emcMy0r7CkTs3kJRFqmIb6Aj16anRW6AMlBIAqTaOyiN
         0hVnTtctIONIf0zDd/5DbeR4wDq12Y7NbW06FKYXagBs12se2OE4Mv6v2RgAu7lco0h1
         s8MPJmlfz9t1mMP+gQmRMegX1yq1ANlxvieenGqG9l+JcEyISzYlrzk7/8gxoQqjyN/C
         So8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204679; x=1794809479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JkolMb8tFJSidUGyY2kChnqwpp2TCm0729AY/AotZ6o=;
        b=wDsoeoA2Uw0xq7vGvOS09Fbs9dRPfsaFSyZmdk58c9vtTJvAYEwAVAX/3LWV7gvvlS
         870daClS/gTbee7mH80NXr2YTQd6mG5svIRlso/L4eXZsRRWh3iN8D5R7oRG6a1JHhlC
         Mh8k2hTkOyrULgE+bsE9JLmM33V5h8MFFich3RWPD9sOXySyVJMJvEygUiZEOd1q5MwV
         fi8BbwuwrLRdpAJL/ASv44rU9aupcRAwYEYBb3OG6CVgaCYJC3oGvAfpRrxAVHZrjJwf
         gQjuNk0dAIhXkCt2T4bNpvbwMZT7kmRoOoPZ/qZVPZEDmioJ9vx8e/g4k7IYnS0Xsrm3
         QetQ==
X-Forwarded-Encrypted: i=1; AL+hErGpoPBUgdv99ZYia1W48iCxfZWaThGsbfXOjaIGsovjFmz6hs/1GWekMboDgegA38sEeE2GzIw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+P2FAD04PGTzOZkOG8JI3ZKvEnledQYsojADOUuEa8sXNviVSb
	2ZsRO4RtFvyv+Drbmk0K8EBaPvB7/A+Lq1BHIP5wvNZ/GyUxkng47EJe
X-Gm-Gg: AYBFou3Reoeb49DhhABJClicYGJSNmo/mCGeF5R6eExdQfz7ovCLttD/VC1X18lEvcT
	v7lcTPzHeO4I4K6sDUodMhRqdfnFt8gcCopDWYOQSVQd7rB69PX+QbLMu+ljsQVKziorgE+qKQv
	h74LFxDgeFMwwVFovGMe+RpFW26tq/g/8zEDmGjrlyxBVbhZJPCJRMv4n2kb+TTAavm+NYdmcmu
	BcqfjoG7AfX535RxmGTxJpmSrYz7IdtSwboe9ALyxjkojkeKn/entOA4BZychO3VR1hyPDHTxdm
	4RCAUnGUk5pgjqId6k1N2X/T01us/k5LAc6o/9+DfXDJn1wu5hFPN2tilYrjSnkskrNuAtC/X+D
	83qYttjayJsiYcam45AhgRpvoLOI7LupRayNHtiB6yJqNQPEVLEmXU5ZW6J7VOaR5CVghoKp1be
	STtgF8lyouzNb/dHdpuwW+j6GRvAttO9uWQn3Zy7r2/Gi2SLBvfo/cemWJlLyID+FtnfM1fUmHD
	5bna3fIBrXAhl5wvRmbmbkzpQtQIV4ysxWfnEKuKlIeFtliV3XksK2Asjw86f828ymLTkEH9jqN
	EpnbEELcSQF5mX1JX3TvaBwRgHqZ9PNe6tpBx6noDCZ2gz9ZzDZYAUL0seD5z5Q5NPvwlAsA1wS
	V/aqgts2xKweCmrtk
X-Received: by 2002:a05:7300:268f:b0:36e:ff7e:e57f with SMTP id 5a478bee46e88-37256bed4c7mr5983858eec.19.1794204678753;
        Sun, 08 Nov 2026 22:11:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:18 -0800 (PST)
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
Subject: [PATCH 07/18] HID: logitech-hidpp: fix off-by-one in G920 force-feedback slot tracking
Date: Sun,  8 Nov 2026 22:10:51 -0800
Message-ID: <20261109061103.2887636-8-dmitry.torokhov@gmail.com>
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

Logitech G920 firmware reports 64 total 1-based hardware effect slots,
reserving one slot for the built-in autocenter spring while allocating
the remaining 63 user effects across 1-based slots 2 through 64. Because
the driver subtracts the reserved slot count upfront before sizing and
bounds-checking its slot mapping table, the 63rd concurrent user effect
is assigned hardware slot 64 and exceeds the stored limit, so its slot
mapping is never recorded or released and remains leaked in wheel memory
across device close and reopen.

Keep the full hardware slot count for table sizing, lookups, and slot
bounds checks, and withhold the reserved slot count only when creating
the input force-feedback device.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a1a69705338f..c4c878c9061b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2865,7 +2865,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		for (j = 0; hidpp_ff_effects_v2[j] >= 0; j++)
 			set_bit(hidpp_ff_effects_v2[j], dev->ffbit);
 
-	error = input_ff_create(dev, num_slots);
+	error = input_ff_create(dev, num_slots - HIDPP_FF_RESERVED_SLOTS);
 
 	if (error) {
 		hid_err(dev, "Failed to create FF device!\n");
@@ -3480,7 +3480,7 @@ static int g920_get_config(struct hidpp_device *hidpp,
 		return -EPROTO;
 	}
 
-	data->num_effects = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+	data->num_effects = response.fap.params[0];
 
 	/* reset all forces */
 	ret = hidpp_send_fap_command_sync(hidpp, data->feature_index,
-- 
2.56.0.506.g506a7eabc5-goog

