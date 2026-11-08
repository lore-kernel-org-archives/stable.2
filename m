Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096748;
	b=KzYWVT/IZtfa5H9tlF0lo27hwnf98xMFe71KcZoPvUVbvaguSve3IjUKVINFcNdD6oQ2
	 Hkoo6FIMGsaleBnCHm/azwt1KYssWStHEgn9POCL7NIublLO17o4tMHO6hQymMk/Fb4yz
	 6rrpQ7+cUzytmA2rgmYkQ+zCsY1hqzB2kuVw6CxbWUEzs7qcThYGWCY6XfBk8ptRbxIfD
	 c0TNKknEzd3mrNRdRc38qLET+wRxa/4tWuCiIqUsEZy3KADPEWeyp2Inuds5WkIzXiiv0
	 TkqVX1J6VuNQqFfVrsQpb3mZzzKRV4UPaRbf3VKXauz6/kj+YCXQUkJLOJr/JCFnkAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
	b=FKpLpbWmMKNYb9twdS4yDN0PX58MWszBVcxR7jCCDpLlj2+rxxxC+74QsMrTVkBTV+Dk
	 ks0HCxLzGolQMfKI61vn2jlcBMcjK/QKpRBuFGzuNKLuTRjADjwk2GHBHc2rETc30GbPq
	 3rZr7Yr1bi7hFz+1n8Kd1pnvwh8QcoJVQhR1PuIhUT0dHrirKEalWatyD6UP+moXIcauu
	 JHtUuZQGUoXupC/kpW/ir4FniCxvcQF7Ds+Mslux/sLi+xdMTJQTHBu2MQTKPiQox59mL
	 t6pXDDvQfpAuS9hWDp9n91JwWXUBKFTYCs/wN8Jg6hFW61956AoDLVpxs5NbHGWxLpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P48FoCU2;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF64606A326
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 00:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EF64606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P48FoCU2
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso399945ad.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794096748; x=1794701548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
        b=P48FoCU2wJLuOW0KvMaQuorD4bSsAXGz0958TAY4PSp1uQZOn2l2Zl98oZ08R42vL5
         XqpiwXtmXaOPqg2GomlOeekqpRjWYs/24dJ9uKCF3FRL0BECVCZjRkRWDh0HWto71KxC
         h8CJLG9PwqIr8MU4A0BtRMwxxKswSUr0vYKF9SCjhG+MfFw7QCyqwkE9L3Vp+Kg32W69
         uTtyTgpY7ij5PCuiwHjWLxvvsViLr0BJn3E7ssYSp01C5a7qqvvZJZay1eD1AdPN77OF
         EPrnk2Hk2QGwjEI+CBlU2zPqyLH+0MLDJn9cTsfCdun/TMWwe7whJc/ki9yUrWfV3+66
         nM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794096748; x=1794701548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ijw1U2kb1kzZv7aGgFzZ0Z47dFymm7tkHOWXjQdf5qQ=;
        b=SZfYe4A+mM8kAhTTzGpjWYlQnDzAt7JbUy6gX8AZEBAFSgMo0E9DXoxKztOplXuFOi
         INTq6g9SbJqe0DjHKq67MQjdKW/3b6fP77Tmxg+M+ew7K65RMc/nZZSBENF+efbDGit6
         Les0O6vusm771mD28liv43Ztr/Rrmy+5/hlRTguZO/u5iqUs7lQ8k+oLdGMgc8T10ZDn
         Jg2VZX7miPuc73wZfM3oLbUbhlw2F+avUmT3t3EjagA8b3EslzqctfCB6wmlgYXuqkZ1
         uD4Kn7k4B/llMDYGm04M9Q4B73Jt0MkQAhZTL0RN06eKmv2qJuI3ElyY5keeR9IlvKKn
         b+dA==
X-Forwarded-Encrypted: i=1; AL+hErGeIsexNDGpZt49LV5aWw9GY2BjHvUw71VCXWV6sLHQv7hC/BEgcfPnV3aUu7GSl+i1Y5k2DEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ec4jB1PsIj489i/ENNBh7yUaL7ZoW8Q2JYHZ11dCdr69j0SKe
	kmYgV6qIh5UnnuEgGzapw8l+pOFDWK8cijoiihvhlnl8uv+RfnFh9EVx
X-Gm-Gg: AYBFou1loW3eTlOUPqkWfDK55v+eMA1AoXMJktXwv9Tw6GrBgQ8CoOzj+bEKmhzPHxa
	X9eEnJhCDwRI3sdjGNvU0EnK/V2tlrZTmiIXT/mjKx+3o3xkHk0C4IWc+4TUO6/yZOmvZjls1tD
	Md869og/2tcdACjBOuHDy3+LBgI9HfHQX1CxqzeBoJ3WG9SV/9Q8vh6uyiM9C3Vvz1Zl1LC8hNM
	VUhg9Cj2JLo5ruxvzKvesJmJjVuko7A8JZNIsnGR4abClKWVZhO2TVHsTy317ewEGYuW8UW/lvM
	bizPHPRp+YvPFhp1p5h/eRt0bqgSbkDGUxZkc2AubcYrnlUXYFKpBn30l+RpJ2NlCxISOnX1XAz
	UJxYiUl7y7TUxVCsVr2Ei4UMlyfQA3w7rfbchefnohbfBjeZF11Ab/QbD6/QWYXLX7mlQiqUQe4
	VOVarQpgwGxvadz++D686zrfreLgwDzgZ2Ye/B74veIQy0mQkRRA9tyv+l7nlKWGnYszZiO6G7Y
	F4DB+/lcxjIRPyd+QRzJs8a11PylvqlzI1g0qI9KE0DDqWstca5JrVuOtg6CcQ6bQhudrVn9YcS
	2phOfLIamO+J6P8hSHiYakXCculZHschrNmLPwJf/QG/Dezdqlk+Tkkd2Mywd9TMMR0uW/pqlNK
	cI/XNCGSs1ZZpIWsulHuTIKlPGYNG2DKn9drpmA/9QV09eEjnnbB9cI6wjba6YN9u
X-Received: by 2002:a17:902:f612:b0:2ed:18cc:d3a4 with SMTP id d9443c01a7336-2ed83784326mr1769335ad.46.1794096747574;
        Sat, 07 Nov 2026 16:12:27 -0800 (PST)
Received: from sanjays-pc.govzhome.govindz.co.nz ([203.94.55.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81712282sm614905ad.50.2026.11.07.16.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 16:12:25 -0800 (PST)
From: Sanjay Govind <sanjay.govind9@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rosalie Wanders <rosalie@mailbox.org>,
	Brenton Simpson <appsforartists@google.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: sony: fix sleeping in atomic context in RB3 Pro raw event handler
Date: Sun,  8 Nov 2026 13:10:58 +1300
Message-ID: <20261108001057.29776-2-sanjay.govind9@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Rock Band 3 Pro instruments only send navigation reports until they
receive a magic SET_REPORT feature request. When such a report is seen,
rb3_pro_instrument_raw_event() sends that request directly through
rb3_pro_instrument_enable_full_report(), which does a GFP_KERNEL
allocation and a synchronous hid_hw_raw_request().

The raw event handler is called from the URB completion handler in
softirq context, and on USB hid_hw_raw_request() ends up in
usb_control_msg(), which sleeps. Plugging in an RB3 Pro instrument
therefore triggers:

  BUG: scheduling while atomic
  ...
  softirq: huh, entered softirq 0 HI ... preempt_count 101, exited with 0

This was reported on a Mustang guitar (12ba:2430).

Move the request to process context by registering
rb3_pro_instrument_enable_full_report() as the send_output_report
callback of the existing state worker. The raw event handler now only
schedules the work, keeping the 8 second rate limit. The state worker
is already cancelled by sony_cleanup() on remove and on probe failure,
and sony_schedule_work() is a no-op once cancellation has started, so
no new teardown is needed.

Fixes: 7245b0017d12 ("HID: sony: add support for more instruments")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
---

Notes:
    Reproduced and tested with a Santroller device emulating a 12ba:2430
    guitar: without the fix, 'BUG: scheduling while atomic' is logged every
    8 seconds; with the fix no more warnings are logged.
    
    The fix and changelog were written with the help of an AI coding
    assistant (Claude Opus 5.5).

 drivers/hid/hid-sony.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 50f5ad6bbeb4..9ee175f9e58d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -630,7 +630,7 @@ static int ghl_init_urb(struct sony_sc *sc, struct usb_device *usbdev,
  * Sending HID_REQ_SET_REPORT enables the full report. Without this
  * Rock Band 3 Pro instruments only report navigation events
  */
-static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
+static void rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
 {
 	struct hid_device *hdev = sc->hdev;
 	static const u8 report[] = { 0x00, 0xE9, 0x00, 0x89, 0x1B,
@@ -647,14 +647,14 @@ static int rb3_pro_instrument_enable_full_report(struct sony_sc *sc)
 
 	buf = kmemdup(report, sizeof(report), GFP_KERNEL);
 	if (!buf)
-		return -ENOMEM;
+		return;
 
 	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(report),
 				  HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0)
+		hid_dbg(hdev, "failed to enable full report: %d\n", ret);
 
 	kfree(buf);
-
-	return ret;
 }
 
 static int djh_turntable_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -1098,10 +1098,10 @@ static int rb3_pro_instrument_raw_event(struct sony_sc *sc, u8 *rd, int size)
 	if (size < 25 || rd[24] != 0x02)
 		return 0;
 
-	/* Only attempt to enable full report every 8 seconds */
+	/* Only attempt to enable full report every 8 seconds, from the worker */
 	if (time_after(jiffies, sc->rb3_pro_poke_jiffies)) {
 		sc->rb3_pro_poke_jiffies = jiffies + secs_to_jiffies(8);
-		rb3_pro_instrument_enable_full_report(sc);
+		sony_schedule_work(sc);
 	}
 
 	return 0;
@@ -2217,6 +2217,7 @@ static int sony_input_configured(struct hid_device *hdev,
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 
 		sony_init_raw_event_handler(sc, rb3_pro_instrument_raw_event);
+		sony_init_output_report(sc, rb3_pro_instrument_enable_full_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
-- 
2.56.0

