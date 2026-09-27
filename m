Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB13B6C15
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482318; cv=none; b=gPF5rNIeIbABJ5DpJtnmJsV9b/U5V1EBbffzXpwfpDkrCoTu6+6Gs8sfOwm4lo3wkH/3oNRt1Bh/bEPflzp/ugL40/ZXZ4M/jpFkftQDhZ7XJNbm6T9gs/z8nmLEiFVXV5F1g7C6q9LvZ5MweA6e6AZorzzTPOzlinGfNQKRtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482318; c=relaxed/simple;
	bh=XP7iG8EjgZLn+YNGiqj8MkFgY6hRv4lb2REbNzeeOYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4DN0DdDpq5OcAqwi9tiY1VIzvSgsPrq6KtRVQybCY1WJq6FyBFcpbXIxQtR5INkKCVFBxl+AyRzHUjRB1yzIEfk9h+1HHWOLAFWP7saPL2P3rOFB1icdRNQg3elCbcwv+wZqSjZ2BODcNONH/xPX3+2gMqAPiNroWYjXOIKsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIjRGOcN; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIjRGOcN"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b6200eb0so1535282a91.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482316; x=1791087116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/F1JXfrPVlqflPqgZEKNxiSPZblFhEIoBm8x0QNmPw=;
        b=UIjRGOcN5b4oFzREBkAN3rVbVAllQ3RLX+LKxr2gWRR964NCVK4m2TJQAVpuArNO3X
         +nwddducL9FlNJysomff2MkDGVdy4JPUSCGJi7k+d6uU+60JCju3Gr4XSEyxJe9zgNVG
         Q3/l3RQ42sTSjZWdZfN+Kuszvj9g0K1FZgTATgZkX0O0eiivUoNWcj4nFJ1dwkrU68/h
         9jHfKiIJrLF26Uim5IbhJY90p/3C8lL7LHGu/a5oLi0scljxZF5nn3wgpdNw+1POK80D
         6wJ9RhIhLoQ2JQDJ1Ex26k7Zi77m8ri3Zw2A7eGhn0QKmznjppucAYZxXRDz3gcOonnH
         IuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482316; x=1791087116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T/F1JXfrPVlqflPqgZEKNxiSPZblFhEIoBm8x0QNmPw=;
        b=h7QHmt9o6rXGliEIceY4DkFcP+avNP6O9q7AywoOn5aj4FpHR972CRStAARfGOXIQ9
         kUzBma5/z6Y/KP5G2xhUbfDMRwjMVav7pc+SB09zU3SHjHkOVn9xML4KobXA5j5QzDVe
         wgSsg5ZrLRSo4j8thNgnKZSoEc5MwwS+FcJYBhkUlMqS1tLEYneyrBvwM43AasP9Y+gW
         nvoTXSt4xZf29UIkHgQPotbBWYGGPHsQxdg1fZYoPPCOF2b/u+mWa/YVWWIqQhv8pwI7
         kbNBElBPtA/6r/XK/9fAGRsUhrPQEFg6oJMHlzw4pd+9wHzBt/PWgF80Hoy84Beo8xen
         sZ+Q==
X-Forwarded-Encrypted: i=1; AKwUvBw/EbRatT8fWD5E2ReOPo57qnna2kjC8DvSmSG05L6HXvNw7kNmX2JL3NBAz23nXx6A8xmxRWQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwy3HCQxZILLo3JUyof2Y7Gy5va7nsd+flrTA9Z3gSlrC2C7ao
	DEkDGL+jKMMMLqJCF+FhDgNe61OaFsiURFJWp/RZAAI2XMflokx8ymIW
X-Gm-Gg: AYBFou0vP8wSl32g9LlSAIwo4sUHhj/obtWW9gamar1fgeVlkziCnLoTJPTF0r05pTU
	eOY65So61AI9y/ydKqcUAUZqv7reFIK92IgR0+vUYCuYRmiWMmzdXJ6QWW1X+b4MX6DVrf76Qb+
	KUywrHtVIC8tUH0nlQYQu9Ai7Z4gOrvihjtkFUgCRKYeO7ShEFxbOPHfz7DfwM1cQrFzTk/PUMT
	KWz0ZxP2ySs6xrOIQtm4jQX2DQ8xRK7a+95NcRrY3OUv4iUrNy0rLRgMdceSFbQrEmahPictijc
	395HKLVFvHcy331NPAscnZZ+CCBqbS6oUNzW3ZNuxqFWrI/QMRpa7KRvIAO65/OvdG8T18J+aIM
	ElOMj8CZfx+p7N7GLQ/xm9MfQFR0TBb5t6BFj2spEy23dXO2ms9jJHd+lSTxjnX8mP0P8YdmBcl
	E+7lS7xyvWfdC3lUpFBL1bFxnmmrqkFXmwJmrz2o9eBz+ix0dcDq5+CgpoGE7Oe2zR6qjNU5BHP
	KFcg/WBcYO3mbZFGWlyGmg=
X-Received: by 2002:a17:90b:274e:b0:39e:4546:fb13 with SMTP id 98e67ed59e1d1-3a0bb5788femr5079408a91.19.1790482316276;
        Sat, 26 Sep 2026 21:11:56 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm5542732a91.1.2026.09.26.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:11:55 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] HID: wacom: check the input device in wacom_intuos_bt_irq()
Date: Sun, 27 Sep 2026 13:11:37 +0900
Message-ID: <20260927041138.4112920-5-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_intuos_bt_irq() reaches for wacom->pen_input three ways without
checking it: two dev_warn() calls on the short-report paths, a dev_dbg()
on the unknown-report path, and input_sync(wacom->pen_input) inside
wacom_intuos_bt_process_data(), which is called only from here. That last
one is the odd one out, because the pad_input sync two lines below it is
guarded:

	input_sync(wacom->pen_input);
	if (wacom->pad_input)
		input_sync(wacom->pad_input);

An interface that declares no pen leaves the pointer NULL on a fully
successful probe, as described in "HID: wacom: check the input device in
the shared report helpers".

Reproduced on linux-next 20260925 (x86_64, KASAN) with bus BUS_BLUETOOTH,
vendor 0x056a product 0x00BD (INTUOS4WL):

  BUG: KASAN: null-ptr-deref in range [0x258-0x25f]
  RIP: 0010:wacom_wac_irq.cold+0x8f/0x16a
   wacom_raw_event+0x68f/0xb60
   __hid_input_report+0x398/0x4d0
   uhid_char_write+0xa99/0xfc0

One check at function entry covers all of them. It is safe to bail out
there: this handler only runs for INTUOS4WL, and
wacom_setup_device_quirks() only adds WACOM_DEVICETYPE_PAD for that
range of types when WACOM_DEVICETYPE_PEN is already set, so a NULL
pen_input implies a NULL pad_input and there is nothing the function can
report. Every path that reaches the battery notification passes through
wacom_intuos_bt_process_data() first, so no reachable work is lost.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 48a58a6672c2..11544adb74f5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1237,6 +1237,9 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input)
+		return 0;
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.53.0

