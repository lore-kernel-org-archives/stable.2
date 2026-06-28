Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78138D
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607281; cv=none; b=Ae9VX5NdakDCsCrhf9u0VcUg7XzThhD/DOIrXqhf61zWLP9Jvl4Zq2r9unU/nbNZE6Yb33j27T38DZsKmdRKein5fEfYvotx3Fie6UJmE9PN+IAOkv/TXQgq7CnkfNV6J++gkPZg3l8usm6L+c3L6t5htYLO8HBht5c3U6jghyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607281; c=relaxed/simple;
	bh=rWjqEsg8y8fWOyDjFJ9raEp1vcQ0MX+Lr9ujI9x9ac0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faB2XohskQCa1WWivCa492O6uP/URMtgyNge1IZytAq4lsjKrDTOEuGwpYcIIppkRbDmmT6KoGDt3duZcB+pTD0QWFno7J59XLHsCQeNknve0p3dV2CGF7ypDdj3ON1s1sqFiSdOXWPHtBGEKqnzQ5o7oYuttJCD8iPWNwHdhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuXv5j2U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuXv5j2U"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a5d32e8cso3786835e9.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607277; x=1783212077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pGgA6WV0tEq+UyEYEyNRruqDa18VnUsaxpJDdI4WVw=;
        b=TuXv5j2UVtuyPRzLIHokGWG9fFK8tS5oXbkZG8Yi3oauUZPsOzO/x30ru3ZE/cLul1
         m2w1/oCsoNnD5Ny6oe2K8QzUrOE0TtUuW+pBwi7F39Psosp47v2A5CeHYghjYlyyVCNm
         Sow7JeUF1GicCASowHeUaIRNrkMs+g9hj35oCl6UDZHmCzhRhLZmBN9Js+HT1d/12S5W
         ulO+Udq319UZE/Il42O/laeO6C7slOyQblcgmCHkgG3WlwfzzuxjSAT9QUpwYim/QXJF
         U0pGjV7H27TnZaTIIyja2pL0jrZTU7lRUT/pR4EXR71CAvPPesMpxk6hcReerv6+ytGt
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607277; x=1783212077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pGgA6WV0tEq+UyEYEyNRruqDa18VnUsaxpJDdI4WVw=;
        b=MH3LPhnRQvHrJQkjThZgiNiLexVKOyEdDaa9FZBxSyu7hZ8AcwG3dzl+pDwShtJBpS
         La3EiGqBDP+eae9XIk66d1ljUV8cVFV/tROB5qXElcD5ehWF8c6el/qaYGomKhkWjSH6
         DSI0XwsEuzd/65bldBV3N0xwsjScVfeE4ylYqd+fbZQdhADzNizByWJRboaHLadpdAT7
         VESzrpFDniEUNDTAtO+yE+wkMgTI4D483vZuW5uLVJ0XsAvrVJf8lk4Yi6rm0G8DeFxY
         CB9YTNxjTtRRZgMdf8tqFnT/yQk4SJldg5mmSNoW6qstcKflceaz5slhTC6YWtkifXJa
         Wiqw==
X-Forwarded-Encrypted: i=1; AFNElJ93xehqm7xKEgtGDj20yXzTAYkFpUhIRMuyY3x5gGnFWpglc1TmdZyuSefdpl3+XP/iRZjCFHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8IaSmdffyJYHyKutE+mfNl7Ks7vPfVOhTZCTp93jS6T4EKn1i
	ZgkMsSJy3zkws8Hx0Q6vg5DHo+LMZF0ta6aOWleAtfrD+GiYmNsOZ0Xm
X-Gm-Gg: AfdE7cmC0atIRFK7Tw9eO+uCbpTOfzxCydMei76Lq6kJZZ3kt49u5IHDvt/tbAWr+OU
	SrqUq1kRG2WtsdZq/eCrHVlQvp0H8WgLw8XURhDZ+DTjpSM39peDCbvqG2uGX2PtGgxK/srpsLq
	rcaHQeRZKxNqr22F/6Py3aUaPS1kz4TJS3eO4Vf6NYN2kuP0FkYGZ3egQ3G11WJ/bWSUrXtgNrl
	Xq2AbIL8UcQ7DwcsnZ8qlI6940gyfSkkWn4vEeWGerD0BcE936FccqZM9VnztwAWgsVLKKF97H1
	tfifwbn7QN6vjdIRzX03DNXYc0WVKBwy6X6kqkFHsM5edFGApf2KIdu8uyuVtUAU1dM0AB0y60I
	1jYvj8XOma1VGHwnuZXQy1IsGX2mBoqDbrTD7zUYpZsToDUFh2OISv/PE1+hfD3VA3HBzBPLUQI
	1HbEHM354uFVwy4HZyXwuavlcmBg==
X-Received: by 2002:a05:600c:4e4c:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49266893338mr175946575e9.27.1782607277184;
        Sat, 27 Jun 2026 17:41:17 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm208373005e9.6.2026.06.27.17.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:41:15 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	stable@vger.kernel.org,
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: steam: reject short serial number reports
Date: Sun, 28 Jun 2026 02:41:06 +0200
Message-ID: <20260628004106.26920-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

steam_recv_report() may return a short positive response and copies
only the bytes actually received. steam_get_serial() nevertheless reads
the full three-byte header and trusts its length without checking that
the serial payload was returned.

A malformed USB device can therefore make the driver read uninitialized
stack bytes. With a complete-looking short header, those bytes can also
be copied into steam->serial_no and printed.

Account for the stripped report ID in the return value and reject replies
that do not contain both the header and its declared payload.

Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-steam.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 197126d6e081..8c8bfb10e8b8 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -454,11 +454,20 @@ static int steam_get_serial(struct steam_device *steam)
 	ret = steam_recv_report(steam, reply, sizeof(reply));
 	if (ret < 0)
 		goto out;
+	/* hid_hw_raw_request() counts the stripped report ID byte. */
+	if (ret < 4) {
+		ret = -EIO;
+		goto out;
+	}
 	if (reply[0] != ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
 	    reply[1] > sizeof(steam->serial_no) || reply[2] != ATTRIB_STR_UNIT_SERIAL) {
 		ret = -EIO;
 		goto out;
 	}
+	if (ret - 1 < 3 + reply[1]) {
+		ret = -EIO;
+		goto out;
+	}
 	reply[3 + STEAM_SERIAL_LEN] = 0;
 	strscpy(steam->serial_no, reply + 3, reply[1]);
 out:
-- 
2.54.0

