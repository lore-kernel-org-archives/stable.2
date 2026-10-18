Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D9414A1F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361038; cv=none; b=Ru8o2VjPIp0CZTu1z2RAtc/QklevloUSD3+D4HLePOrUxoxP1+7PkX7khmgFP8AHeGBvh1qj+wLnnFuZ0X2OEPiI/5hGqsOut6kPaNEyumsw44SiM6ytGG68xKkZbzallE2Oo0ws4r/nI4vAFH43zamsH/Ia7XBrPkYjma3V+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361038; c=relaxed/simple;
	bh=8bHmYASogem4UkImv9USP3WHnLyATHC1Hy5IMe6WNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEV1sp0xEzX1VFi1LKvPtESrML0vrnaWH/X2oMT7KZXeVykaUDE6zY+GkRJ/Ap70OOBLTSCnHX/pWy6BkDQRGBm8AqqXa3a0rW5f/Lg4UtdllYbCkh8wG6sfxV30Cn2vSr9hb4JP8WCQoPgFvKfBoX1C3w/E8TELUx/IucfTPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUgK/eC7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUgK/eC7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48bbb06e746so628253f8f.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361036; x=1792965836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbJN8CvA2HEjblO9LmvSpdf6N0XOweTOQoH+n7JOTxI=;
        b=WUgK/eC7u70BKGzluYiFXMKcsiXpqaC0dKDn+8RE+3SzQ+IA87C5pAKltt5rZwisEa
         7Ldzza1tPYVjqVsR9ItmF/neqwOJ2xf2Ilu9MbjTDhycZo8lzSZKLxEDT0ztMA1/T9Ok
         7olgxht60OFn27URmGEN4ayCGa9RRJusN+9uMbP6m6Il6lZcDg1q+Oj+5KdDQtqCLGg3
         /5HbzsibrCwLplkWSGiBiOAbOBDElqsdcrndPyPzlXL006eM2X63JlhNXQ2VGR9SuHDy
         Ow5Fogp0tSZQjCYCR7++KBAW+pEjjCyJfnDxiZygU8zyiE3NOtEcneQUnvMAZYGVdMww
         HKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361036; x=1792965836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbJN8CvA2HEjblO9LmvSpdf6N0XOweTOQoH+n7JOTxI=;
        b=tXhXTggGYGlxzIUeikh/yAEJq9gl//MEHQYXThATeQ2ZClDkvYNr9jExpUEZYZx7BN
         T8nm6rrceUczaA+2Cs5nbAcfMv1G3aIDBvkSHAP7VhFzSWehcS3NnTx3dFjBL6hfg1Fw
         6H+Dm/Jx3UW23LkzKlNPj+wiIaRbIXdGvdwkTsc67NCycETXQ4Zu8/BVrh6V+yItGc8r
         rGrxj/H9yJ76uvqAPT6luMJ7IgTWOjnw5/sC1TJHoXBOoaDOTDszyGWNo6KrG8ZSA4og
         ANIxy6vw+pHoyoHz56tan/sCWYprq4YQzHLDJ999T/FiSoFTqjHiw6gGTJi3YII9y8Lm
         X0lw==
X-Forwarded-Encrypted: i=1; AKwUvBziSMgYbveSUH8Yw6jOhFocEjjnOzmy4ZlGKaGugXnvbwQO45/xwobplW2dmr16ZIvXpwLz/rI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKalGeoboDi/nCYss5ePT/NAvrCcKLXHzyeHrNIa+b7siI9YiI
	e6OnwjnExCEWv+ZXPMwXUQ4Pah/amVEVSMQuNwi3uf5M9nkryhDzZqY=
X-Gm-Gg: AYBFou2ci7QLcU6/86yA+1z+Auyt6Q6pP6CaoS8ijOjrjq7oCcoZZxeCtkkwrNDFfFU
	9QhYWeNSxhf5QzqmU7JxI3Ehb6kgHNJCve/OkOmWsi3hv2RO2tdoflmFz1JOuaRkhhOd3Td7i5w
	qEeDLkhYHZS57EHF4ZEk86xEK7bDExqWF0CwW5eOlIRAjgHfp1aukz245zEHO2+S7S3LAySX/uP
	0U1rOQuNQrinD8c/u6CK8E4GxDnvn2pJxZoR2TT7ZSS3/zB60Z2QZoS8JTGpczSYvYc/uIonihM
	1iNQNnlsk32IeXU98AiNlZHicjc34gHsDDXcSZpl0cZIIFqxpq5Je9sf6W3XiEh4/Srm1wE4JUJ
	a87b1WEM/5f+VPfydqkU8xBDFe+TOp1DGyfm7NwB+9slJjVMG89QI3CFGkyPLcIPobv2qRQODMr
	lsyiXLeU1MDuScMNRdPENbppnHS1q7PPAD4e0vVglF
X-Received: by 2002:a05:600c:628e:b0:4a1:df70:b4a5 with SMTP id 5b1f17b1804b1-4a1df70b5c0mr94000825e9.7.1792361035900;
        Sun, 18 Oct 2026 15:03:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 8/8] HID: prodikeys: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:44 +0000
Message-ID: <20261018220344.1987142-9-tristmd@gmail.com>
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

pcmidi_handle_report1() and pcmidi_handle_report4() read a 24-bit
bitmask from data[1..3] without verifying the report buffer is large
enough. Since hid-core invokes raw_event before validating the report
length in hid_report_raw_event(), the driver must check the buffer size
itself.

Add minimum size checks before calling pcmidi_handle_report1() and
pcmidi_handle_report4(). pcmidi_handle_report3() already handles
variable-length reports via its own size parameter and needs no
additional guard.

Fixes: 3a370ca1dcf8c ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index fba01e4fcab1c..925ca70f9cd4a 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -491,12 +491,16 @@ static int pcmidi_handle_report(
 
 	switch (report_id) {
 	case 0x01: /* midi keys (qwerty)*/
+		if (size < 4)
+			break;
 		ret = pcmidi_handle_report1(pm, data);
 		break;
 	case 0x03: /* midi keyboard (musical)*/
 		ret = pcmidi_handle_report3(pm, data, size);
 		break;
 	case 0x04: /* multimedia/midi keys (qwerty)*/
+		if (size < 4)
+			break;
 		ret = pcmidi_handle_report4(pm, data);
 		break;
 	}
-- 
2.47.3

