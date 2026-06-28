Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339172D46A1
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664575; cv=none; b=kFZHnOaMTrRHBtCUlXcReMHkQfiy5J3a12VERhwMVafxAeMXqIri8peSqpFHO3W1GJW1pVQ81nnUcVclZ7Z4G5k6e5QxAkye9QCbPxdR8QN25nQBffrLJ8PzUrLNhf/XX0s6hjI3LuyPUXYTWvzyQ4ehtDnSz0o+sdqrnQGE3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664575; c=relaxed/simple;
	bh=BNwN1Nj8dybsZAvcjPKnwuKZ8iq6jeSsMk9qriP/fVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upWNQ2nCzJDh2Pd7wGljSWyjJBSwkvePQhMW2+BYR4rdLyRIteagE1dADCKXN20VfMTsWhm37pHhKXN1F3Pvjc8ZyT2u00NRRQlWQZ23ZDW1KyJIx+JzJ0KRaKgPU8bPysMTmBBy6DPopx6rEr8yczElKLAbYJL++5JXd7sEZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqvFxo3r; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvFxo3r"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-80bb578d58bso19993247b3.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664572; x=1783269372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoukpSn0XidsboLVp1WFiGbHVvRe/31Qvf7l3Vt/lN4=;
        b=cqvFxo3rzry1BhkRKKgLkAoD3xSI+LTAcIfLjRq/hATkA6XiqXBkhThmYW7XzcZC2w
         Thj3cRkp+700a9fnfxldYEs4JfQNN0MkAvofMzPAvV0ZgPrshixS1nHDrD/TP3UCgYgI
         MnuFg6CWQ4bJpyWY16Ej2Mawq3Dc02j4rXg4gNws5B4F/Zl5PqNNA2AT4tdlvjNdq0N0
         JLFqTDKaCqFuNQU+T+m1l6/zPYij6KI1EobqeHL6MyIuXlsobZRkm6A7cZKBpwKiCICZ
         rAYqwlgiuPAbdoBflKqZF+/EOr4f3/P0sYV8DK4l/9aikZRg80WtbX5uynW048OE51wx
         DD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664572; x=1783269372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoukpSn0XidsboLVp1WFiGbHVvRe/31Qvf7l3Vt/lN4=;
        b=SFfqel55wcd1A7C3Cd/09Urg5JNvIK1cezVpptecutZXK/AQJhVaWtTl9ob0eOOxnm
         bDFRMZXr/4xG9icXnjRtGeOCe5HhpI5zWMoluhg8Fatpp/sJy3ThMAQwAHfNLNMB4bCB
         W9TsXv5vVJA9lKvLymbFw2M7z5yPCjLaFcam37wXs4OlPumekx9qZsVUvhVsqvPI2hl2
         GttHb7PgSSp2FLp+3vs/wpFkNMl12e0g63DyFn4Y2zvg8xL/tvFa6TZFmKy+W3Tj9rGC
         LyTjxiyGUxDv7L+oZw/mWpNLJGTsq8xvl5lkIHcAPPBy8h752SytIF/yGuv0ZL0ICMn/
         0bYA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7dStwTiihHTuM9wrJAhApCG4gR4KaD1V9tRX8/W7IyLSOx0zjj58iJ0ly+BXuRCT3JRnzqWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihILkelzfOdBFcVOv90jYofVx4IM7GcIWhwHOLppTHwCUFg9D
	8497a5i8SvUD4dVqEeyMJ8WvAKSzeJw/QLAadbRfw95K1uP+E+/Kpurv
X-Gm-Gg: AfdE7cmNWMB3PEwylLqi4nsZgbkAKzhJTWUc/1SYrJuRx+nONb4XroDapMuCP5/LhFg
	PvqL0eGfyt5oTU0g+AfK7xAHFVHSd0Yls27Zqyg0UvuyBHNKMFMQ4MAeGn5ryZRhl2ycov9L5f6
	OCZ0vzpqznkRz9JEq5EIoOdv4jKtNi5yRs0n/VES/zcMb9CSTxceTzPbiONLkbZ9NdeM/csjw+r
	UbHkyMH7jc6lePJa/uUCN77t1xgW2pZLJhFfEaUka5z1YypxeLCBlYoDYBSo6JNzuJFoRl0Twid
	XrLDVdAzMTuD2BtI3aOmMC4f8Jgwzk9KUxrOxXK/+7ZauOS8iPrF1OgUeJI7d8L+t5Wnn3ucEeB
	svvau2jCEqKpznEqFdlCeCdX4OvVC3auu81dQCAvOBpapk50xMJnnkU0aIl5FfEGTuKT2xuwA2S
	u6GmKFh+t8ODJkX/FdZnQf2UeD/A==
X-Received: by 2002:a05:690c:7243:b0:80c:85b6:7644 with SMTP id 00721157ae682-80c85b699a3mr74070797b3.57.1782664571895;
        Sun, 28 Jun 2026 09:36:11 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:11 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 3/4] HID: zydacron: reject short key reports
Date: Sun, 28 Jun 2026 18:35:26 +0200
Message-ID: <20260628163527.14279-3-alhouseenyousef@gmail.com>
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

The raw-event handler reads data[1] for report IDs 2 and 3 without
checking that the report includes a payload byte. A malformed USB device
can submit a report containing only the report ID and trigger an
out-of-bounds read.

Ignore the key value when the payload byte is missing.

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f5..b882d2a0ba1a 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -129,6 +129,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 		switch (report->id) {
 		case 0x02:
 		case 0x03:
+			if (size < 2)
+				break;
+
 			switch (data[1]) {
 			case 0x10:
 				key = KEY_MODE;
-- 
2.54.0

