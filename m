Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812658;
	b=wf+28MNWr/qaytkWuVk3jAJzwEFHHZbl240ZPEG0vBQ4I6w29c3T+igDji/dT10EaJfu
	 2zLoJq8lwgyVkvuwMSuHiiepGXURdZvRXMNNPpDKHTGGE5638QkR6wN87j6M9mLAFnLml
	 rss75Z3pfTITE3zx4BU45DOwhzQRMWxa/IIeQwiRx6dxEa/XTGmn+op1kn6voOufqSjyE
	 pjr1Km4LUJSxmzZ0MtndMW9Um5G0m9ln5PgAjS3SIjCmuWp+ic5vSo1WgvTMWdFrJmyha
	 fshUrD61Xq5iZtwZDJb5lg+1N3nGs/uw8XVJhcs9ViwcCKBU23kPdehW3WZBS814Frw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
	b=xSIwqNghhR9AbgpG39XIODjDzANvHAVOs3iY04q19MHbd3hugikfKpc/8QDYjgQ0JcEu
	 Jj4hsnAmvqsqgheAgHaMO8fdXwldkleaHk1Sv0LhNxWgYZrMDWvRLwM9EFtp/t/2GKLAZ
	 +Ipzsum33lUNTZLhQReqEsIWmkZSwrr/7hyv+Z0vUdySdTwpx8ya1SgT/5ZfQPIcrkZGS
	 Y3s3w9d1cpXrWFBOZKjNfKYEj0Yh8MjqYDwHt0lKezuT1NqC/Jqqx9qY125m7oHTVtPXY
	 KKviwayckbKq/lFM26qmZJS6vizK2bM+ub48mTdURAaecMGJKbvmR4H5SA/yFZDt7gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xnbot7Li;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3F606A326
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB3F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xnbot7Li
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso2249285eec.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812657; x=1793417457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
        b=Xnbot7LilCE9GzQVggpQUtlm3O5iPC748Darj3t7UdYZ/Y12arwKbFv+cDmSrGM0cR
         mMAQ2QZ9CdPlz/yF9ebjqCNfn+15S0e18qDxAvWQ9UNNlmgvcnuT6A/sicnFXSDYFT4q
         1W6qW9e7xh4WQPakwDTQjmG2ekjgvOFQwvVzBEmsmwieOBTKQ6oIj1A/5UkT5giu0ukO
         L/t9k1mPmHYp8/13GtyIZNo/UXDvvZJm/nBcsZSKHFAEHlf+wJMJ51pArPB3wCzz3XpB
         OkxihjPACxym/IRBK+4LsPAl7dFFU57RlxApVF1AMALUHZFAP3IaEOb1+SPO7yRBunKW
         Ckig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812657; x=1793417457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMS+XYATUvY7YNvEDxX5IVPCQZNzXnmL5Yux3ihoSpY=;
        b=pZNwpP+bCnfDj49+V62ajK5pZzHdwqZ3ynDoeKFfkN2iK2x6+hismcDq55M4jC2S1p
         51B9twy3sgq8kVqmVew5d9HolALJINfcuC8cjtcnNBZnDVBOn7AGYlmeXwPfHbgig1GF
         DbQ8zvumr0BYHrhwcXK+aDufxPyjbGndpc4VnQAZkYhdLa5LbSjiA2HUStqxDFhPo52U
         H0tIzpfQbEg3mUT/Qwbi+t2EkuJo/9VHzg9pLtYYHvXSvaUlnI9wNI1y4tXtfhwKWWn9
         TBG9inV3VQfuq8A1d73HaqWf63A+FIWKGJMV6Ky/jCp7KdmF1W0cCfDjy3jxTcobrZTt
         cpBA==
X-Forwarded-Encrypted: i=1; AKwUvBysBOLaywiagZZJcmDlrzfNFuGMf37ieKZzQVPfRt0OO04W1WEYvmxZTZ7Rj3CbUP0pa68/Vdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMMc8IMTh40VOa6/g8K4sL4oU0hGdP1s5xhvfdKqcwCtM09n5n
	X71HCv0e0HC6QE8hHmwcGk5vmAdm+8lve7unaRushyj6Tp3Hn20pBXil
X-Gm-Gg: AYBFou1bydTkH/vgmmTTysI/ax/VJn8epZTJj0hELetAdZnHdHfMlkzwBL2b8+85CgG
	Sxe4UgYswntizPaJVCOHdhQy3ubbaYvafQOps3gvribE0wXj+EMF/95hI/ORPiRzU020H8Tju8W
	4i1P/k9OPV4dM/Q5WBrOwWP+kn3rLJZk8fmG/vhjDosXUPWKBnq61SPt7HAX3OG8l2TEYsp74/n
	vC/LjOnWy6QWKLe9dPq9F9mql20IYvqnEGMW7/Ms+Xnz25dHddyROmgi+sBr9+jmERmNNvcZ2jC
	X6G4gnZGCfZif+cT+48X6ngKZSJvMahOldzjGWIYijAMLUd0idx7d0qEKrFUdfcPWdpWMVfhr88
	Wx72V4dvq3Qt3dgz8lfQ3Pn5Ss4cuKZZdfWZvHW1Vc+7snPodhmn77pYCO6JYvX8dIjSgr1zraG
	FLRH2GsvN9fNLjmU2GtJmQFRQfa7/y4J+JplbUAQ32JOCZS0B8eHAfQXFpkxb7Ep1Tnqfz9po0C
	X+814x3/+cJzRr/cvOXhDb7p5WWaeAeThsGMUf31XA9Qsy2ZAU5Ayvl2+Ohv0pc3Y5cmxbegA2C
	Kd8Wl8ZY52DC1D0PQTllP/cSaVO0
X-Received: by 2002:a05:7301:4543:b0:369:a113:7560 with SMTP id 5a478bee46e88-369e86249f2mr1546686eec.41.1792812656823;
        Fri, 23 Oct 2026 20:30:56 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:56 -0700 (PDT)
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
Subject: [PATCH v4 4/6] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Sat, 24 Oct 2026 12:30:38 +0900
Message-ID: <20261024033040.316652-5-jinmo44.yang@gmail.com>
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

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c38fbec114e4..6e2e67abf80e 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1269,6 +1269,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0

