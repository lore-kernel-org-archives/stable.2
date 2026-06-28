Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C72877DA
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664106; cv=none; b=KpAvpgUeh8XB9UI1KJW6S6Ge5ppJjQ9Cnn47c0sH13kALV9T76bDsyxONDbLlAXNSEmP/wUtxQSWznCrkubnZVN/Q6gxRteEu9SciOwOu40rlQR73tzVeRSU7+mklsER5ufH7tAsIfeE36Js5TG/Vnpf52UGb4OqeyuqjsO7Uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664106; c=relaxed/simple;
	bh=shtM5XCTx4SGM85hK2Tv+8aoAAmj6dlcxkHRo0n8yxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX+CSLmCROJ1CYuEkEjXtUk1ZiX0GNLFPw8Z3/dEdXimMKikbpkOXTPSzNcQuT1uwrHaDa2a5DJWjgkoMa2gA/s/lzKIL2UFBN6pKeoa/U3oIPmH0jIef82UkD+PMQEiLt7uUJKUSKxyWQHaYLm/wgkk0pyiNG5VYY0PND5dBPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o93rYg4c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o93rYg4c"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493a97fad2fso5410345e9.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664102; x=1783268902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1o26rsuYGHIm4JTny2vvEweN2Wwm6Ey6adKNcY+/Ctk=;
        b=o93rYg4cVtjQttUp19UKd9Lcx5rUX1RC5EcI6WV2HIaCpa2NMPSq2+Qczh2cuoqMvD
         TlF+c2eWpzJ2K6Nl3C0X6ge1MvUYlZk/trMlOLpbxd8vkc75X/xynXY5Js+A/xcmjBNz
         QJY5LgSS+H8TtUMuZI4vH3ReP2L9KQ2MmawwSHHMPM+psbXEVPI8MhxYnbE2lFJcniVd
         SwAvaGJ3cocWQiBokGV4WzrsbG2HcXyES8XuosVQS39Yqr80N2VGsywQIyk8ecGrbLZb
         qOf9dgMhz8BoGni5D3KDj2uMNgO5AXF2Yfmb5wR6U/NvcaxLy3SGFbGpCwpXjYr/D2V5
         Td4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664102; x=1783268902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1o26rsuYGHIm4JTny2vvEweN2Wwm6Ey6adKNcY+/Ctk=;
        b=dJiBkszGsWp2s/3khMvhaC3407SoGvlx7ix5LT9bA+XAFp5d0ynP+2XjQOL+RavwEW
         bUfA2JsjEPG8gMN/EWa8NuPoZXiniJVjjwFdeKxCAKfSh4dbPoMB+/Pq9XPhQUkfLjX4
         1AUmHowecf218xpr8myb69qSSqu2FcudjT3XbAme5cTTGLJJw1u27jwoUtjdyf5us/5l
         s7Gb5xY5nvYr3tPk+qjBfcti78pmCmqofAGqEflTvHMQvzATihILYOmvkiqGfltJmadR
         h1e4vzWfisrqsXSnIzkf3nqRUKZEynfMRdXoKf8ZUJ6Oiih8YYdXvoolE/rKLm9vltNl
         nw9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fG+sEQ8e97tc+JJ4ow6zzGdGrOlDtBD+sVxDzLZK8QgnzVzEf+3U7dgg71yVbxdMyaE2Qm4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6nB1JhIt3tGXH7Kn7KqoR8pcx+0CJIYkimIqrSdhxBoByhCw
	uUxUXsHPyq7bLnOxb1jFOPVqxO+8vetLDVnwGLR6z/HSDucgFSDTv9XMkJd9GurPnwHWpg==
X-Gm-Gg: AfdE7ckTn2geax051BUF+rt53K0LdN9wFFH8Gp6NqIAbYSPOaR5HbVPZmFZDmAOn4dr
	2zdC0WX+i4q0hN+n2pgs7Z6nt40PoxrMjP2lWCrXuX/hrbzND2fhsLVMHIQG5BWTIH/cqZztHny
	g2cvthpfoP8LInkLgy/nyw75ruj1TOqtQv64Cnr37wluz/hv8HUTaQgtrluhWpKFdheR4QGELlf
	gbZuT+vGt2bqj6yLb2uCWPP12Uk5kBmpoWBuokyf75W+Fw/5OZcsTBo8FwsHmG7bGXo4in1wFLr
	wzaBS6BQkOSJIifQcF7RmjcN91FO3SLmjJDZUbZdGnQaIWT5oKiUlMXZY4tWZ9CZPRFeVopVdrN
	SQ2vGRB5hxv+LYVTxCCCleEm70zSKASGzO0d1fWpLGcTM+XgBy+NShFj8ogu2uRCl7mf58ofNxu
	EggrMo9NkMeX3WNXtW/nXWb/F85Q==
X-Received: by 2002:a05:600c:a49:b0:492:5bb6:6d4b with SMTP id 5b1f17b1804b1-4926689abd5mr204625455e9.34.1782664102439;
        Sun, 28 Jun 2026 09:28:22 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c278ab2sm140353845e9.1.2026.06.28.09.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:28:22 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] HID: pxrc: reject short input reports
Date: Sun, 28 Jun 2026 18:28:06 +0200
Message-ID: <20260628162806.10675-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pxrc_raw_event() unconditionally reads and writes data[7], although a
malformed USB device can submit a shorter input report. The raw-event
callback runs before the HID core expands short reports to the size from
the report descriptor, so this accesses beyond the received buffer.

Ignore reports that do not contain all eight controller axes.

Fixes: acc3e34613da ("HID: Add driver for PhoenixRC Flight Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 71fe0c06ddcd..e3755d8b85c2 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -55,6 +55,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
 
+	if (size < 8)
+		return 0;
+
 	if (priv->alternate)
 		priv->slider = data[7];
 	else
-- 
2.54.0

