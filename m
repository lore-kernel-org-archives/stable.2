Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A24E0B64
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361032; cv=none; b=lGKK7qaaxcOXbuhuOfcgggdd/g+cSp4FekpoHAUkUWztArvCSjWjGwKeyZ65etlL30+BDYobRmTWjFCdoYzNayp2xk9CLXcgUDMH2zln7ki924a7ia3fJRdf+EC5uoujn6ea0OxaOpzauHpgSzMSUgXoLVgyTf2xW/gYqPCRuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361032; c=relaxed/simple;
	bh=C5OeVmVc9RUqWQx2xLWOpeX88Xt1ishh/7V1x3S2xhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji/t2dr2mT1R+H2jt7qpIqO2XVkiVythMlqrKbb26c2EKBIxTTFNjcNXFYLRnxPm20wIDxMuCdTMc8R7iMr/bAn8b1qJbejUxJdj0/D55zEEbjY7qb/JS7zFMYGr7Ts1+PU60mzMGjqzKEwaDjG5dfvSGqiuoRg08NXkdezOLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jobjO/+G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jobjO/+G"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b042c0759so844410f8f.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361030; x=1792965830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=jobjO/+G0IsfkTz7BTmRQy3Mn76CrBUEAMTfRjBe2ar0213cAzo3p406ByaHDbVP+/
         x6IzTssWYk+2fRy1pSQVxK1j9896FNtvVvLGeisODhIPL3ILz2+VXWiAdvMguRGzCGeM
         Bd6F7+uLzO9KYrR/C6LmoLnhrLQHg5yZ8nlGXSGCGNJBU3d75jra430a4V4icrROL1Ns
         Bptr8JJimpjddVkO2jb+fsrHHABsS4YcFWDqcQ14cgQaCItTtbim1sxUH5cpwO/M2+yd
         ZWDZoyDtQdBGiD0SaKGg2MhOSNAONY+aFaIGt/waD/X1OORkKKbANCI+LnoJuDOXDAMh
         fnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361030; x=1792965830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s+77y3oo4X91iER6HxasZRzsFWRhDOryP02cl98gD8s=;
        b=paAKOVLvrAQPMxZu8dAv1UuZ9TDRAp7mqMuaMyxECA3Az+PSf1xDVACNERp+Xt4jsZ
         KyPzHOzgR35zkzxDbZQMZ4M4jNYzSSl9ZLSj3v6MIrtOU/oE6obuTf8gwKTXjJC8jigu
         a1CinYrEbJj8bA7A7w5TxFcsk82oomK5QTw+lxOGmacmM9XoLL9jQxluUA2WIHPbDBu0
         j9g2ZHNVhLtt84IShDdpWl/d78Gw8LNIwnyI3v5asI216fivbS7jjrDgY0DB2vxV+gnD
         EPU1bYPItFsounpnDtj7eyoOq+RfDSXBcQf4undgoLaqul3O0mjcD2QSDv0v9tv5hXkz
         b0lg==
X-Forwarded-Encrypted: i=1; AKwUvByJ+G1M5DGvlt5bq46h5/PtDWVbdX8hKo6CXI+rdpwUGhZGVbgydJTLEDPXL1wjTOPdD+NoDUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFtQJF17BG/xGU/6GkmPTSafRrIsnX5RhtDKLx6wgx4/1RuatZ
	UN+qQkXXafE3PTTHeaYXhslAiysPexOxEsvK+ywbWEuhnEDr55BXHtk=
X-Gm-Gg: AYBFou2i1zLsU/OQaRDYbb3mDfDaUJvY9Y+jkgjZ4snu2Opvc1USQeQEYfOb02KX7/v
	hdORWlBC/D+JE6btc114XMqyqi0CM3W2dYu8vBkGeVyYzXgburFyfno39woDgvn9UZpAOmX3IwO
	HaJeQOjF74sNO8XGQJ1/hf1n142yAs8NQ2h4pPvek3GJRZD3aO26gG6LpUyCzoAJwMF44/yq9x5
	tDUuM44V72+irtQNhfFlx3/NdWWHFB+gAa5DHWFeqk31zHcrPgt3iXDGOdF9d+TAqVeD84KXyS2
	VocrG1pBbvJN8r9ewuUpccPFOO5IfbuCW2Ihx8E4J5hO6QdDtp2e4iWE6ncxvgAoNo1QDEPRfHo
	gYSfH/mPvqMABD/Wnvu+ovQ1a6ttpBOQk2BN956ZKmWQjWw9P1Vvha2MnwZR645SC6Ow+Iasb5r
	zRCK6YBMGtj5Cm00Fh3DPt84tA9EyB1O3pMv6+gQ0=
X-Received: by 2002:a05:600c:3b17:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a1d7612c55mr121664535e9.25.1792361029581;
        Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/8] HID: cougar: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:40 +0000
Message-ID: <20261018220344.1987142-5-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

cougar_raw_event() accesses data[COUGAR_FIELD_CODE] (offset 1) and
data[COUGAR_FIELD_ACTION] (offset 2) without checking the report
size. A device sending a short report could cause out-of-bounds memory
access because hid-core invokes raw_event before it validates the
report length in hid_report_raw_event().

Add a size check at the start of the function.

Fixes: b8e759b8f6da ("HID: cougar: Add support for the Cougar 500k Gaming Keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cougar.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index ad027c45f1628..2dc135d0fd123 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -267,6 +267,9 @@ static int cougar_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (!cougar->special_intf || !shared)
 		return 0;
 
+	if (size < 3)
+		return 0;
+
 	if (!shared->enabled || !shared->input)
 		return -EPERM;
 
-- 
2.47.3

