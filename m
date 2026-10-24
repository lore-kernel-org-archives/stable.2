Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812655;
	b=o19wSi5zN/FJBAoOEOD7n7soZYbUQHjZSICZIt46T+/fv9Jtp0G+7j8WxlvwiXFlW2zD
	 EA35BcHhVvgj1bpUlOOn2asX2DR4ruF1lq99KTqJz2tm1fnUsrnKxASART9PADIlrOlhB
	 W7XDU5CRMS94LYMN282IZLoHlP3mCxYQstc7jmu8+h9sHtz/T/gZe1Hlpuy0xYgIvDIud
	 7RPoZ3Ga4vj+N3fHduuoohUeiCOMEwbIVKty5KlrA74mngZdq4/Dw1ksK8LhzfHqCPVJo
	 hDZfhtRZognt4V8HPKIWu2Vm6ADMeUtyDG+O4DyD7MgsstJtqWDBjqRMliTeNOnyiXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BBHk/z3NrzrI4byyOl7kQJocwRAO4/8uB3uGu1WhUhk=;
	b=5lba5wZAg6MRl3tU+aHaSRIu8Rr7Ez6ikvSeE456EFezeJduM/H4OB/ZR0uGuefgP9PU
	 56xoibZ+UXqG0+1CyBY3Ku5s0y0PMvoIHwt+i+DrCPftAZoC/MwzLL/44S7JJ0vy085Q0
	 HlQNipBxTJupLIp3Yd34CjU/s5mkUWq8xPDiEbfc+M+6gSMGcN+GpLCkYS2ts9/OTRnO2
	 XR+Bm9RI3lAhEztGWA/fWFmsiRpvZQbQUK87BirxwKW4kd7KFbnGJYhUySCVfUV82luYp
	 ez64kn41/LWXYKdy3z3xuZFebxvCpe83seHyH3dQu3F7MkKWJZ8nmCI+pmcI1KuLqaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bUF2QtZj;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329B606A326
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 03:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F329B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bUF2QtZj
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so2548803eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 20:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792812654; x=1793417454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BBHk/z3NrzrI4byyOl7kQJocwRAO4/8uB3uGu1WhUhk=;
        b=bUF2QtZjFVVulv0Fs9I4f0CSee+ua0c1lVBgpK66TFDjnOeZdGGzvDrW+esNgVE3Df
         VvuNiRHq5Za5vVGI6NHbKouXcvN9pP/7s2O1fL1JLzKWGPQii9jk4VhqIOQU5UQcRrYJ
         jwEhGfRrYWoBdxBGianUjKW78JWcfswZToE4gD8zK4vh4X4zuSAqLKyzAc0lX+xP8KX9
         RJwRG/7aRYG+LlwYZrcyw6Lp4QmqIREGdbYZ53nfsVVvqRmKRN5O3oWzd2m25ObF1+XT
         iOzw+hJ3GWyWW7d6gfFt/I7kEkrNwRqBLU9YNfJf8JIhOQXShGTPYzVOXh2/c520J0rZ
         f9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792812654; x=1793417454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BBHk/z3NrzrI4byyOl7kQJocwRAO4/8uB3uGu1WhUhk=;
        b=Kam+TCXFhjqXIU1dtvhqizuGzM3cVXVEHF24yL8tzmxsVyHLaX3B2F69z9Uyb7APJB
         /fknEzFENBFvM4hCQWbHFerBx0HNKb6KJac7pT5Cs0fYDyTdSgrjhy8ptXctraGwxX78
         98Wg2af9sZoVZZQkhBA67C3Pg1R6Fc3CytJ/kSzGKO7iYdk3uhY2Y+JVdwrO2OZ4wC5Z
         6sfsWrvPVw/+tuTZQUhAoXElwXhSlPgZ7KrKl2UYaJ9Du0n/TUgQS/L9PCZHz8lZUKhw
         WNPbH07Ix5ciGlNX66WHUZXqoakYbR08ehA5JNmUq68B+Te8UCOn6S2yo/wYZvgYrNlu
         yi3g==
X-Forwarded-Encrypted: i=1; AKwUvBxxJOb2kg52bgTgYV+QixvaN6D0WqhXj00x2bj7hsqBktCBV+iuNejXqDOZijgSin+13hWspJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxsqfCiZMuID3wwEvkdbasxNHvHHbxSw4CiGPV6YD0Xepw0TSv
	MD25zWhHkr79eavZsCtlxa9+lVlS0QNzeMAsDoWUPLjWjVi+ij9aarLW
X-Gm-Gg: AYBFou1l1oVD+dzENslUisqiBNvbSTd7ekQi0b4axKEEKPJlaEjxhtj/MWHa4sE3WmF
	1Wr4Dp4tB+FI3meUB3/pTTS76jzoi5Rd9572jZFzSk6aTQ/aDpgmU0IhdZG23JU7dVw+1rxRcmC
	ixfOQElMwVFUxNAPEFFIqhWwkLxSzm26ufYWRXsQspLsuodZ21zOxsP8OXhXEzOdTt1gND6i+nZ
	0byDU/+tfHyOli+qmhMDLQulXInAXPoszhKZsPFKlGQT25H2wMHmf7ErzEXXmF4YkmOVvCVubKk
	MwsARb433B6pjMjSoz4//wFZ/0rohTepE6a6XmcWwqLFZmNDN1TZC51Saim6NiVnbqVBpnc6Fp6
	rDenGgTglcX8uKJW7pQ8zEioKjwnHDj2rGnYtL0J8sLmT2+bo1Sk6FLY6MvU9akhrWofgSVhDiy
	OzbAnG2/mYOfU6t0JYgViuLxMkGVu2/Zd/7vmxsTXntZUOuObI7Tsx03sVyRI1yXLAxbDinMnSa
	sV9RCGNRgBkDXESWsdefcp1iZq26wm29OaYLqirnbxK/+E+VwXrdTB5TA/xwmBGDsAsgOQiffIT
	GcXsOPd/WZnO5JEG5FlI2hBjmeyGZw==
X-Received: by 2002:a05:693c:8392:10b0:35f:ef9e:f846 with SMTP id 5a478bee46e88-369e8315eeemr1809228eec.3.1792812653959;
        Fri, 23 Oct 2026 20:30:53 -0700 (PDT)
Received: from jmoon.tail8e743c.ts.net ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ecf087sm2827283eec.27.2026.10.23.20.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 20:30:53 -0700 (PDT)
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
Subject: [PATCH v4 3/6] HID: wacom: add NULL input guards to wacom_intuos_irq() and its helpers
Date: Sat, 24 Oct 2026 12:30:37 +0900
Message-ID: <20261024033040.316652-4-jinmo44.yang@gmail.com>
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

wacom_intuos_irq() assigns pen_input to a local variable and
dereferences it in a dev_dbg() before any NULL check.  Its helpers
wacom_intuos_inout() and wacom_intuos_general() also dereference
pen_input unconditionally.  Add a pen_input NULL guard at the top of
wacom_intuos_irq() to protect them all.

wacom_intuos_pad() uses pad_input throughout, but pad_input can be NULL
when wacom_setup_pad_input_capabilities() returns -ENODEV during a
successful probe.  Add a NULL guard after the report-ID check.

Adopt the same return convention as wacom_intuos_inout() and
wacom_intuos_general(): return 1 for "handled, don't sync" and 2 for
"handled, sync".  Update wacom_intuos_irq() to apply the matching
"result - 1" transform so that the NULL-guard path (return 1) suppresses
the spurious input_sync() that the old "return 1" would have triggered
via wacom_wac_irq().

Fixes: 10059cdc0ad0 ("Input: wacom - split out the pad device for Intuos/Cintiq")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
---
 drivers/hid/wacom_wac.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bec8dbec5bc3..c38fbec114e4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -581,6 +581,12 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 	      data[0] == WACOM_REPORT_CINTIQPAD))
 		return 0;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pad_input is NULL\n", __func__);
+		return 1; /* handled; the -1 in wacom_intuos_irq() suppresses sync */
+	}
+
 	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 		buttons = (data[3] << 1) | (data[2] & 0x01);
 		ring1 = data[1];
@@ -716,7 +722,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 
 	input_event(input, EV_MSC, MSC_SERIAL, 0xffffffff);
 
-	return 1;
+	return 2;
 }
 
 static int wacom_intuos_id_mangle(int tool_id)
@@ -1073,6 +1079,12 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->pen_input;
 	int result;
 
+	if (!input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: pen_input is NULL\n", __func__);
+		return 0;
+	}
+
 	if (data[0] != WACOM_REPORT_PENABLED &&
 	    data[0] != WACOM_REPORT_INTUOS_ID1 &&
 	    data[0] != WACOM_REPORT_INTUOS_ID2 &&
@@ -1089,7 +1101,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	/* process pad events */
 	result = wacom_intuos_pad(wacom);
 	if (result)
-		return result;
+		return result - 1;
 
 	/* process in/out prox events */
 	result = wacom_intuos_inout(wacom);
-- 
2.53.0

