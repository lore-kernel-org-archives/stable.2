Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6552D8390
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664573; cv=none; b=C6ZA5TXI0qTE/+dTFCVgHrNWX9ij1j6eK1ldbJrNysiLclKjFLx0/LLlM+aXoWpllydO1vqrutVh1gqwma6QuQ8MWj35ljEv6ggJ4EW4qDHPgq0f+sSdmzxKFNznXejklNlKj6bh7ZOV3EbXf+OqvoohMxwv4ROWMk8bDsg6xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664573; c=relaxed/simple;
	bh=yQ8R9XastH+8pcsnk+pfrf9crWGnkt0cSrwN5AmkL1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4R2vW3JtB44xKcr3mxabkSKb8SIpA4lztAwEesSRWoyLhABjI6vid3S9aRPcMA2rEpphmSXgMDLDLk1weBvqoG/jCMkvdKMho00XOs0tc2gIPQsZoPiuPK4PstOoTScioWxyO59asVbSsyrpZKiRB4vy8HimklMkLtjo+dSwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyK8zvFU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyK8zvFU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-806449d108aso31871607b3.2
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664569; x=1783269369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e219h/uwYCvJXbihsmOl9SQTRnIhmov8xkiDNn7Zm2s=;
        b=DyK8zvFU5jX4iQL5uV88gpzHuSvHoio1f+QfsRWDdMQyAVaUc6RhQ4K8pwXvdr1Ezc
         ZANEDjtLn6kkm6YhneytxNS1hy4i0jSq1BvaArQsQTc+upZVwoCeQoQl8L8nvQMxZ1E1
         3ZqrmQlxsgbceMdS9sN/ymT4M2cwv2m6IrSIkVVy0ODI+uz3swpnvJsCwCN7lUm3nBIU
         VqfZ47nPK2gWFwvLN4yAvadTwIGcczLZjYob2BXjFIZaYxzdd40IHgNPZUFqSUB/eFbs
         ufEk785sZtgQ7Gin4OzdysfM9ZPxeHg0EYvrb0SvaZmlYXod8V92DchLD4k7pgZXI4mv
         meiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664569; x=1783269369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e219h/uwYCvJXbihsmOl9SQTRnIhmov8xkiDNn7Zm2s=;
        b=Om7stwCJviMD+woEzg26HBeYkvIeSb2tbBimmtb4veIELHEL512tg6DJ6NQX4CACrL
         THtcENEyHylmex42/GCb8dJ+qpiI73kyVDH+PAyUgJOlqx3V4nQ9HBrZsyDSAuCfmayq
         0itIHiokJE1lOOWWepPrQY3V498GzFU6guVgDTvcmFxMI1iL65Cp/BBbwOiHSI9H+7Nh
         r7pEoJxrDLTj7zPrAfgmnLuoejRGTNPnWN3xxCwohipQAIgC6Qle+fyErnmFD3sA77pl
         pl2hSyHEmDrgVtTUzzWvk0bfqt0x6evPNt2Y8RoIbXFhAvyL8fJS/tJXSercoVWiQjLi
         48/Q==
X-Forwarded-Encrypted: i=1; AHgh+RpVQH90LMLNjROpUqixfqR9vGyEIexDfT6jgimSFxYPw7U/il4WlbKKgNeMCXn0AOzBC9iXgZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQLv2Ik//KEyuRZt16o8HMxu4aV2W8D3lvtC6RpSKXXDGDjhf
	dzfatKp/fieJ1B8/fT7/G4PNNOkRp8OZXueEwjG0+34jILaEmMv+SHMI
X-Gm-Gg: AfdE7cnl2xVbRP0Q6otjqj6KWQfXMLnqNWsprpb0lw/dH4IHnFp1gZP3gyWN/0NzOGp
	9ZwW7pxgjLoOM3zs2PwMmApseyDE7l2yT+X4MdkfJL8kvGv+Sxj1a5Eg196Qn/3s7ldUKJ6HV0+
	V8QDX5BvLh5r12lou8x88aZabX8u5ZVI+EwCknDeHFfwgZzJ4eo+a+W+ExQY1vyHm/HDNzm6To9
	DgLsIvEZUa14L/+xsu+3IUVBZV7RZVtrkn2G4WIRxeFLGY6RobNZbsP8yO+H89HA1D75QjcGzPj
	tPQ9q/AENx+lyR6rkBfw0Sh3JlGA7iaCodvHZgH2kcO8/pef+HGViEWcRnlJE282PoX6wHH7Dpl
	roFjxvgYPyU2g6fBI/DDll4zViqxC5nSjZlP7768ovtQ6qS9MbJyDD6JBJ5tHpMAR/zLSMwcX4Y
	f6O1DD1sKHXCGrS0HfistjfwvFzg==
X-Received: by 2002:a05:690c:c4e6:b0:80d:f376:5bc5 with SMTP id 00721157ae682-80df3765e93mr37710887b3.0.1782664569174;
        Sun, 28 Jun 2026 09:36:09 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:08 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 2/4] HID: cougar: reject short vendor reports
Date: Sun, 28 Jun 2026 18:35:25 +0200
Message-ID: <20260628163527.14279-2-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628163527.14279-1-alhouseenyousef@gmail.com>
References: <20260628163527.14279-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cougar_raw_event() reads the key code and action from bytes one and two
of every enabled vendor-interface report. A malformed USB device can
send a shorter report and make both accesses run beyond the received
buffer.

Consume short vendor reports without parsing them.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f162..7156658166f5 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -270,6 +270,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
+	if (size <= COUGAR_FIELD_ACTION)
+		return -EPERM;
+
 	code = data[COUGAR_FIELD_CODE];
 	action = data[COUGAR_FIELD_ACTION];
 	for (i = 0; cougar_mapping[i][0]; i++) {
-- 
2.54.0

