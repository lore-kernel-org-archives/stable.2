Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164068;
	b=liH33Fx/VVHm2k/96VtuhnKgKpn9pXsibVwqc6WUpd6W49+Xi55hg/t4Otbh+np8Ipxf
	 wq8LVMXlNgH4/+DywWHvu3tUOC3yiRlwKtHdoeZiSaK60738YAfWCl2ZjVcuOfrFPyPVm
	 MFp/3XYTEj4SmZ9xLitbva1xTw7NVbgePUJ/xkKJ6wg7WKvn3XYQqxlgLJ+k6QQTHABWZ
	 BfMBBiWkBIPTmj2bidAGstcGljMGT3JojsbtCvCPLjl/BnAZo1Q+H9QyTEcxZvHn2pmk/
	 jkagw51kbmT+ObQj7n4jpsGcax76kuwn1z4sVWH7IoaeIxbymQlXqCzsZYZdyaVo72Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
	b=a6jhU5jJcIBLEP6WdzcV941QgoJX1bnkskwBT5sM93zEHeAZoV6FeeF37F+OAWHdgOZM
	 e9UdURjocdqpy+i165OrkIEP1wR/WzOE9bmgXVTEKDdDrY40Y1botFwUG3Ss7nRiXqKMS
	 s0xXnQRniQJSgxTwmIpOHl27oeB4U5u4Sp2Lcw4VXzSDw0LUIa7M8565XEH1A1HLkuhhV
	 EzA1+biuu8cJB1T/flXm4v+a6CK8uFIlnt1DBycTOY56QeeP7dHjeC0gPgEVYWglKAIfE
	 kdGVHOp6ooGwn0Eu9yRNNUqeDGvEmnXJhfV3pqXwh7gwJ9qvokDEU0u6BbpYRbess0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6vS6VWp;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2DC60A382E
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B2DC60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L6vS6VWp
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3712b6d9843so553645eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164067; x=1795768867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
        b=L6vS6VWplOM9URretomgFujZAhoTdSfoJ2zAX66pifJCF/cI5mcSbF06OrbisceRGl
         bh90xvXb2S6z+Cr/HNvB12Zhbcv+56FLs6hwcEvM9zd6MLli71IkpLf4dmfkhsUmmmtB
         vz6j2DHQKVG5FuHUOf3ORvr/lKqkewIK4CW5MtgfLx1+hsU96O86QTvue0oi645hd22Q
         cKa82CzO0OdVZT6oA8UAnCqnYTLMnSWBaeKEnG9T1j0QDBOALWw/Dszb6MDgeJzQfhju
         HBwv6STamCDm3swZ2S8+XuwApLKq//O2ylCa9JFlEyjzU6QlsOgVmG3KqjW0YSt0tw53
         aYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164067; x=1795768867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtiWbm8KIScPzP7+gVQrDHqSwiwXMiL4Ojhbg6OvNUo=;
        b=LXm24D9mWrXYrID21zo9F2EJ5PgmomnyDinIjYLOEnOLOsHkdZZuDXtXsBSaX/7W9C
         Uuj2r84SgYsDWcwfcuZxESzyP1Csg+el6sBNphyXggcPAbMDxdPtB3PNFp+NDtVWSbTZ
         L3xiTo6lvk2ergar1RZcgTjloBcJMOr6y5uOk9aytbmD5G6FO7HvVZxex0nGDihMwwxm
         V4j2B+T+nBOO3oPKoowTJX9+snuACMu1jyexaWgro7yi8C2I1unwTI5GFYje5fbHj6xQ
         +4wTyom26wmeOhsFmJ/0k+iQG9/BSNzO1VHHZjW3oGO5yxzW7UGQVzrn/EQs7EeCutzY
         +q0w==
X-Forwarded-Encrypted: i=1; AL+hErEr2pKCL+9yYLUMAwlo2ckrShoqYJaVLTarkSxXktjK33YWZMLBh8S1PWth1GM3yoNVXiSBrbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z89RS+VgJvzQB6pBYPH+p1XFRZ3pAkakVXb3clo/GxWyvoESkn2
	2KXkb9REGqmLj2DcbEqOhXi00Jb80/DH8pjDvNO0PGpcMaJr3LxmnlOr
X-Gm-Gg: AZFdTZfIzBugH4qSvdrkR7RoVZeATPe7tkCgcPwQtCE51lSFcbwx8PKKym53YuLserF
	LxpMp17xVNjjvjtuN6DoyDUGBWILCCOakUg4vSlS+/0PewmxzPIQLyjNO1c34CxVNn7CDAjnleU
	o7DSwH1pGH8IsGSJF5UZJSImKm3NqL2G/iKeQEOtiTi6PDax6gg2gTB9DDviXR1taEp8YOZIJ67
	tqYjg44JPF9wnz10fQjHemfVnKSHhFEd25HH8Iyj88/iquLAzf4IZ/tED2lSpsNoP+33B8wvjCd
	zyQdEb/4Qx/mmTsEpJavpgA950ur1lNtbj8klv8RCc+frEv0uXBi3pSo6jI+ScJQoNHIgD4R/HX
	24S/7Lm0yrqBpYheJKbFBx2pkgitywOHLYcMe3fG/wI1lUZ7bepRrZgKNMBJR3savEEWwnxawzl
	q0RT4UPganq3OVe6Dtpwu2JcYAGRI/ZulEqxqVOyknRO4CL/hxh7dsJOYfWjhg5pxpccSGq4ir4
	Mo3H5sCnsOKHNVeygFsaPdr58ZaOY2BN8pGouC2lFT6Y870XLRC2R24sb3CHAT3iNZVi/zzRjDW
	qFUyQ8IDaOVQadJ5myVNxUzXEJdxtml2D388cFIv65y3qXASsBSQ1pQAOooYLNTTapNpWFA0P9e
	8RV2LnlQsX6xGi3sq9y7hK3hSwIWWC5yb9ZwamzA=
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id 5a478bee46e88-3856f65f251mr1756514eec.10.1795164066585;
        Fri, 20 Nov 2026 00:41:06 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:06 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:54 -0800
Subject: [PATCH v3 06/14] HID: logitech-hidpp: avoid NULL subtraction in
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
Message-Id: <20261120-hid-logitech-hidpp-v3-6-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

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
2.56.1.750.gf70dc682cf-goog

