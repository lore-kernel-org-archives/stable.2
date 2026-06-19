Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D77346A19
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781909303; cv=none; b=ZiCnfGtuuwOgQk5JQ8Prkhs4+Y7b1ekfvWJd0hz/RtHY4CgOmWthNB9KbdI5gQq2Bf3AvSvt51Lry0xOx6zE3S8qFleXrIcAfxnL6EX/ZFlfi5s/0Mj2RrU2WVK4pKMOah9ZpzjtdfLQ+AR9exlfvPM0zWHDpFh36f8YjJbyt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781909303; c=relaxed/simple;
	bh=qYpawD4I0G9Kmk3fSFb5oesMzXolKyIvQ4eHDKMJQSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNuwHvNen55KLWnZDOhZRQBIiVXqjXxMEzChpaEpPrOmBePYXIawQg7ykPWcs+e5cBHrdfSa/3icvzEpPeBV+rJktxxo0VVXSgy1DKT4SgpgI2KE9vU6jGtoyQhUf4L2Zea+M+1NtTdKMqBy0NtY08Fr6JLKSllea6JfzbRLg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=TFXxjYGu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="TFXxjYGu"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49249072f03so1293615e9.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781909300; x=1782514100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TD0jGrdu/kEvTl5sP1bpS7d7xXxB9kQjpHSw8hNZbo=;
        b=TFXxjYGubIEHBIm++zhCBMRo7s8mNJo3UCeZiPv5NW8u77haU+nUUM/WKVAPVQHMO7
         AfPs6NT2NX5On2t3zh0Ilsck3bMg4HO66MhtaodVdmdY6nF26dVZvwR6OhokOA8HWB91
         3BG46W6MGfFDCEwCALnU59+W1NjGHBkyQomwcQlpt4SfVSysFYyyP4ZnowtehBC2jCun
         9URVFbJ3dh6cM6RSsUq2LK0X+n3qunY1Ath2jEMYAEriU23lqhSlPWNnObziy+LXx9AZ
         wIMjUABsjUEbVzIO6qSD/yIUnNpSqNj/T49gRdjXKywlWIIp1TePZg4yV/LR+RuNKvOT
         a2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781909300; x=1782514100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TD0jGrdu/kEvTl5sP1bpS7d7xXxB9kQjpHSw8hNZbo=;
        b=q5eKRRSWsXQtNq/oqcHyp/1pF2rQlgYUjitOO50IRDDYFw9hnOc5PTQRYWc5OtKbBv
         8aBxED/Sa5+iD1gnbFxPCpE18D6+53/eVvLJAdrCp6pHOLAwadyBi7ni+e26py3wSoPX
         FeLb23NS4NrugAUG46hneSLsGGtX4Wjgt8FvuVbTSTgR8BjuFK6m5GgB2IElz1sKA0Ni
         BUWaZuMPvuBUiXeWJBj2WR/5Y55SWQqsJtUFahFlGLjZjGIjuqingTyCbTKLO4I1vaTO
         U/+Fw0Mf/tiPtdDGGMVDb+lMc1bhynlh2fKG7y895IlSnwqswUfXpXj0yoNpfKi3s7bp
         GDdw==
X-Forwarded-Encrypted: i=1; AFNElJ/OcVjSt9vvftO5twgQC1fiOyLAnMXaV+JyzT8LuhPoSTU/5us62aWcTnWzqM4vVRSc65/WyS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbc5Bt6MDwefm6ahhrqrPEZbldA1tcVEnErc5lbfvCFsLJR93F
	IInLUKplyl7Q/7R1/k/xgQQajhmYJdneyrDncemcj4w5djvrjRwdD7QEwAdUrKdSnh9B
X-Gm-Gg: AfdE7cm3yindVimOC/J7OEfwZmJMjWSHa0RSVVlUnG8SzKQUKMUS6Z8iZOeaKLjkF36
	hzvhu6Lfu5kv75IA+0vg8twYdffiQVWDANDd8T2f2gU6TeB5R/5/iowyLOqnK7ng5woOLMpGeIU
	xbV3GLxiVq3RUsJ+U2KMyeWIRn2rAIkSTjZXroBzj/XoD5LAwcB0gPjSmvo0h7e7ksVvOAc5oMU
	glAiX4evRI6sXu//AYi2apF5tpI3iv++j+1uBw6FgKJA8JTqH3MBlRmpp122XPYWej7BJeK80Uu
	aK8aL39WEipniNB9oYEiflxwFTE3oiLr9cba42ex+6jSfQgs5pr2B2D3nXewX7m8I2BTLW2r9Iu
	lLcJMaYmIR2Id5adFcG6e3QJgz1vgKb8ZE5yKH52AufYZE71oDjTT/s8OxnC6KkSylUhuYH9QZo
	gO/7sOKNLdHyG6qSFsVnvIw/81Xx97pUP5FVJpQOHCFpMJkFjbuhjm7IUaMmtx1CHsxJwF9H3OC
	j+nv0DA+IccApVj9INiA1PpQ18okkwE57gSWcpjq3BA7Q==
X-Received: by 2002:a05:600c:628f:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-4923f56c067mr93697755e9.23.1781909300210;
        Fri, 19 Jun 2026 15:48:20 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd33dafsm113045555e9.8.2026.06.19.15.48.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 15:48:19 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Christian Lamparter <chunkeey@googlemail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: carl9170: clamp command response copy to the read buffer size
Date: Sat, 20 Jun 2026 00:48:18 +0200
Message-ID: <20260619224818.90751-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

carl9170_cmd_callback() copies len - 4 bytes from the device command
response into ar->readbuf, which was allocated by the caller with
ar->readlen bytes. When the firmware/device returns a response whose
payload is larger than the requested ar->readlen, the mismatch is only
logged (and the device is restarted via carl9170_restart()); the code
then still performs the full-length memcpy(), writing past the end of
ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
(malicious/compromised) carl9170 USB device.

Clamp the copy to ar->readlen so an over-sized response can never write
past the caller's buffer. A response that fails the length check is
already discarded by the restart, so copying only the buffer-sized
prefix changes nothing for the valid path.

Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
Verified with syzbot via "#syz test" against the public C reproducer
(Tested-by above); I do not have carl9170 hardware locally.

 drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 908c4c8..897e682 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
 	spin_lock(&ar->cmd_lock);
 	if (ar->readbuf) {
 		if (len >= 4)
-			memcpy(ar->readbuf, buffer + 4, len - 4);
+			memcpy(ar->readbuf, buffer + 4,
+			       min_t(unsigned int, len - 4, ar->readlen));
 
 		ar->readbuf = NULL;
 	}
-- 
2.43.0

