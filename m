Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564DE4DEC23
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359501; cv=none; b=Mz13SmV25+hkFftRZ6ZHAefWKtmL41erQ4BI3AHwxV80u6FS/RLc6BBN0bmsRqyKFmWWxwQREM9mNppvNBZAqjnK7p8Fw+GQ+YndNI0/orYdY7ocEmUsdRuBTmlzKw3qSgpBG9AyhviIiaUIAZVXEndrn5Ywokl57x0n0PxY1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359501; c=relaxed/simple;
	bh=TEReWKhHAWlGInl30NA0QerMBstlNh4jb6eCUhA0BqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Knrc7r4r2oeJO3mzVHpubwXLSD1TQc6oKv2crLtN4Ogi1FqBY9x/8kExBJvQkrTkDTymwJhtPmeoteLgYOS9UsA9w4HQ/BD6DsKAW7CnWz8/ILKn+gmlLt35vqqA919x21INki6KSq6gjhPqO8C+Za7Nx9GXaWFdCmsIEkt2JKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rPodl2sv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rPodl2sv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1227220f8f.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359499; x=1792964299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=rPodl2svA+RFJUrA8ecxSA01BT5m0uOQu1uVrHUNOsHOFmV9LwzSdXAK0ufgwMClJe
         MNjf/zrm66e7HXlh2uVcYGoEoAKQyF0t+JeRMiS/xKLL3R5sz7hg6Blt/H1D5gukL9Md
         gwc/Qx+WrMhBsqlSm9cm31/d5gSD2Hdkpol5alR1QvHJFaZhMMYvLDmA7jOYoWrgBM+H
         aBHxsdEDhIWG0E8XkHWqmWOW7qh9LZrI1gjYW8CHNLihM3zvGD0X9TaVdTBTosKzZeec
         Zu0Glj8moFANMqvwPq/40ebO2xcqA4UTZZA090dWeMq/iqSpiISDMsTkfYvGmG+KYQC5
         FlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359499; x=1792964299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=00CKpCpmrX76gRvYQcKaQpekfkYb8qjOftGEvuAmUDT8OHTU7cYz0+FsUjBgvd1wXq
         qbA3rjb/86ZynY48bf7KpCvnNbwdt4ZVioUlgMnp3Z5HAWaqhJ/As2JNIatmN40hBEfF
         jEB36n7D8FIRhSThwf9lpWuxWQBpQuRHI6x0uSZFqwmEjFeA8/VxSxGfar7r4X3hHK6e
         Qil8vZ5qHTK/NKR1EUcYL9hybHtqmF4SRY44hFU7rkgnWMe8mO4N57WIvbwWWIaj85sz
         BWzpTm5gCeGxniZDXDt342T0R+qjB5PCs6BdLBsn/nAScNDYHWJ06T9760I9h/yAE4xf
         K6ow==
X-Forwarded-Encrypted: i=1; AKwUvBxp8G52pOL8qxRhsmW7TE51NZn5NgQL5t1VS/VSJbIvUxgGvjAOIm/sX1DX5Af371v9Z4yG8ow=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLRHMV6GacyElKNlMeKMqcr2ZUhnB42ceinldzobiuZQncVJA+
	ucQv7Jcx/VRcUBYYeLUZsgGgMGFPUyoN1hQl+6VcGdOwz7yVGhE7S6Y=
X-Gm-Gg: AYBFou3kShg3Q/WooWG1vTAO8wpAgIdSLk6P7gSiwIpUsqZeijtTSQVlaqXyvXBptqE
	mTimEGwl0z8eteIDGryhjGHb6CM4kIpXkw1onVazzXewry9w0HeAhKL+lMpZh6piE7T003iz4NY
	HBWmI6GsBYh7RkNq0nGSxtUHU7IFOZKzvI9ocMFKoYL4gIN1UKe33pzD7VhteJHxFhDcVFkY6HC
	hFExlB8Hiuj+sO491prWTrjtFWNcMUa14vfjkQJcsVRpIv7h3P2idNP6GagqEps/3pYeKlBFLqs
	iX+dI9mXPjEA+wDdKOHONG8gkOwVZaiyiq2ClIJiGWBMQjOFxE3A+moZ8gR/mD5CfHDth6dBFDA
	IIEOs5Bdb4naC/Q6zNLYU0CHArJ2U2qd9fUdCXumIntv14TC0g6Ik/NKT3QpfHw1MyEKCc76hTD
	lH4OpN0Z8F4OOelZVrmFZ0JYYMOuklmoCUrlTDEq3X
X-Received: by 2002:a05:6000:4021:b0:48e:cd3:b3ec with SMTP id ffacd0b85a97d-48e0cd3b575mr9075304f8f.28.1792359498543;
        Sun, 18 Oct 2026 14:38:18 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:16 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/8] HID: zydacron: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:50 +0000
Message-ID: <20261018213754.1951187-6-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018213754.1951187-1-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

zc_raw_event() accesses data[1] without checking the report size.
A device sending a single-byte report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check before accessing data[1].

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f50..203457398780c 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -116,6 +116,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
+		if (size < 2)
+			return 0;
+
 		/* break keys */
 		for (index = 0; index < 4; index++) {
 			key = zc->last_key[index];
-- 
2.47.3

