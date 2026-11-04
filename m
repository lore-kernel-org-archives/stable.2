Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793754080;
	b=G6HDxoKL28HWPiGPqDVqNU6cf9qknJ7ELVmRxqsK0mtGxSC5LWexrqw1Paf/V/tviy5E
	 r2jOT3Pl6ASoLd2QJCKn1UPCN81M/8HFILNrN6L5yZRLh0vgK8e4lot2jzmNvN9nlTcUr
	 8l4M2VfMJrZqnXe/CK3/IEN1JMZULPSAd995gOmQSvsVW2Sdd5WxqlFuelaXgikdfV2uz
	 eFyT2Q0pn0nsuT4GPRb2uMSK0eNsCKzN2LHAcdpEBVrgxo4CE4Ixcc+7kJ//FetyLiNoh
	 nyBNf7jWg+gdUyDzVlBerrarSGQE8J4s3HH6qaMv7JH2lYFMEhJgLI1M0m2t54IqQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793754080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
	b=5n1KhvS+jlRv99XjmMM4+mgJY0TynQQZoChLu33FUhfRit0Zcal6AMxQ0+WbuA4Xrlui
	 bP1pQsOGegpTQMnlDD2XWy9d8szdTFZkDmymPR4GepDpeNI0R0LpmLMIvYU0Wzd1IHgn8
	 tdff99gf7higBpvRr4AH6L9Cx6J6UtS/65K9gV962dGloVNfY/Edqcp0ieCeJK4eQ5ps+
	 5P4yl2DZCxaz3xymoVBWqbqUfHaGIzU0qk0odborvI+ybg4xNkJe8cSsMq51zpFSnj0IP
	 lpdHqPqoktTOIakB6mtX2i7r2KzNjmBzPvFPZmqY1W/4iiQin+P1nxDUYou2xMvJlJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fxtGkGQ/";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EA606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F7EA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fxtGkGQ/
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so175888b3a.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 17:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793754080; x=1794358880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
        b=fxtGkGQ/e3SEPh5a8AjEoYn26wg1dJ34Ppl3KR1DHLV0CawI/lmAmOqUJAMJOXbeCE
         iCh3OZR1LaoTZ558K+0cxmHH1JHE30gfIoPzUbm8GfRffrICBlNalS7/fAcahhSI83iy
         ubBfE6m8PWU/r+oJ70dp35XIYWx8Vr7yal69hm2X+Z8jeuLQHsfzKXfek+DsNBaBD3D4
         RMHmgrdLgpke4ZWXm50a7XdxsSa0c3XM7P06rMlz6p7izYoOEPhfEL4xIBOq7ln8XTdJ
         eBSG31SVJaGWetGrlgYKk2zzvuU5d1qOAMnf4Sk3Mk2dF+Yyhcgg77kT5c9pn4T6MN0i
         SVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793754080; x=1794358880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7A57ossuBYNZ4mU9iYo4zyOYkXDuvXd5g98niB5F/A=;
        b=fMsSBkhneYQa0PV9SqRbDK/1mXuNDIFtYXgh1/9f8z5SLQeilzN8g/9/sNUtx3cmD5
         4n+a14nIM4bkAOjXaT6DX9KUWSZoMPGD9an2A7rafaw2hjjzeVgvbqg2pseQqRfiL6hQ
         +Dpkeq3xbCqRKrlWHS+uBjG47XCrA/bKDakqz625fs+gupuoQXFNQ9YO2EsY6zJqEAlh
         s3QKSnD19cEj/MSUbKq4vbzAFzz3MIe9O37UAEU7GqXDDvgTf7bnOESebzKb7IntfOfH
         HToXOmlf7GilqIbvuVAZG4xOJG7NnkXbfSDEHk6mAyJ7/RBqXeFichj9GrkM5iWX9qhT
         eZXg==
X-Gm-Message-State: APuU4Z8YqTW2GVx2rPHpZQQIm2rBFdJsn+g+mvkmAocRuXW7Lz/MOrBb
	nkF4r5dyrA5V/imz4Ic64GgoaDz7D2e24ERjy2JGa2S2BhLsf2amukH9
X-Gm-Gg: AYBFou0/4SrtSIVGpN0aNM3Da/k7GXDEQOxpbcxYzVkiKk9SCEB19cQ+5EdJ8hNoQBg
	duLnKp4OZZ+yKsNWlhybz3paRLkb1/qrbJU/DaZe48cEQaRsoKGzSR2jzf25CYwL4bt1LFYkFGG
	L3XKiWv4p4qOC/0zguptyFYTNMsXjxI2zbestf3/xVzKbzbgYRgGDgkGJh4SdVzJc0muMbEbmYt
	EyJbgQjgXdkhvqL1AqIw//kvyQsFG//vzPAfmLxIofkEWlHPz70DIIMEZRgmKdU8wn0eFfVD0bz
	+pebqsP1cbS6L+shQBWEr4a/qSrHYzIEpp3Rdy615hyYBILVT76rNM/b8V1izvTa8uqEx6uouic
	hGWewK0lF7nsmLqgvAfmGhFoHeO28D++Qnb1cymxGwR3odEx1aPPJRLMbFJ2G/GxsvaoLusHNII
	AO2cb+1wW3X5/zHVEchaT1sA7iIhvL8C2CsJkbJ12rVBpmrdUdIFpxtldWDT7Gw2b8nRbyEIYY8
	e5+4TlFuhocXak+R1WF4xnJUKHrR7+DfYcVr988udjgsKv7+9p4fhEUQF1c3CDy0FI5qU4ZfaTr
	YZ4IvCzFdgP6Xskd04ufZLK/Klw=
X-Received: by 2002:a05:6a00:1826:b0:887:1bcc:3c25 with SMTP id d2e1a72fcca58-8a9bfafa034mr11795129b3a.51.1793754079609;
        Tue, 03 Nov 2026 17:01:19 -0800 (PST)
Received: from fedora ([2607:fb92:3002:e79f:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09c028df7sm174967b3a.57.2026.11.03.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:01:17 -0800 (PST)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] HID: wacom: Access shared touch input by rcu_dereference()
Date: Tue,  3 Nov 2026 18:01:08 -0700
Message-ID: <20261104010108.21895-1-ping.cheng@wacom.com>
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

Allow the __rcu-annotated wacom_wac->shared->touch_input to be accessed
inside an RCU read-side critical section by using rcu_dereference().

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/
Fixes: 9183319a5ba4 ("Input: wacom - Setup SW_MUTE_DEVICE according to the order of input registration")
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
The patch is based on for-7.4/wacom branch
---
 drivers/hid/wacom_wac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cf459c16b39a..ef6480338b2c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4414,7 +4414,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case HID_GENERIC:
-		if (wacom_wac->shared) {
+		if (wacom_wac->shared && wacom_wac->has_mute_touch_switch) {
 			/*
 			 * The setup of touch switch capability can only be done
 			 * here for those devices, such as Cintiq Pro 13 and 16,
@@ -4425,11 +4425,12 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 			 * stylus first or touch first. This path covers the touch
 			 * input first case.
 			 */
-			if (wacom_wac->has_mute_touch_switch &&
-			    wacom_wac->shared->touch_input) {
-				input_set_capability(wacom_wac->shared->touch_input,
-				    EV_SW, SW_MUTE_DEVICE);
-			}
+                        struct input_dev *touch_input;
+
+                        guard(rcu)();
+                        touch_input = rcu_dereference(wacom_wac->shared->touch_input);
+			if (touch_input)
+				input_set_capability(touch_input, EV_SW, SW_MUTE_DEVICE);
 		}
 		break;
 
-- 
2.56.0

