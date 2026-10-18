Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889104E01E7
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361033; cv=none; b=m7W+IdG+qkbONY0xH0mVMU0J1GeORmmruSVG9ywdmAXYAbieG5B9bmtE3i0ksC4+iWH1atD7QjhCaeoftseb730ikcGShsLS6KCA47r7aHxXOaBr9A2+gTS0NV085JoOmClj/mg0q6xgrUaLdOXSzzF/HaXIp9Mj5/mBS+qwuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361033; c=relaxed/simple;
	bh=TEReWKhHAWlGInl30NA0QerMBstlNh4jb6eCUhA0BqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAfxOU0WtIHXUfc3C35UXRxJdISEgPdCpPNACsXV5Zw9ursiFYfuZ7md+4JvVDbbf+WdBDUzBciEKNNzH4XwZaXeOjmaKrDmPpTT7VA5QQfyTm4ctYAUbGCKDqKkjQsq4f+WrafTtSQn32kyxnjaBXlcNAkGLhMnKRcMsl05/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn9szMRb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn9szMRb"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so16235655e9.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361031; x=1792965831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=gn9szMRb/S4M1M5s2qrpD4Tkbl5LGY4VIUBFUxy5Ou3ONsFUGgnmTBHvgUv/Gtth0p
         n0GRIAthiopYBxO92SOWt7PPBzuJdLpasB6MOC7S9pXMspJgIgNdGcr+KpscJOYOBCba
         oZYNGkNuB+kZm4xPBR7KKHNMN+T/0tOby1mTG7ICqsaRRJZLTDlXFS7WeqAs5+u94t3Y
         OklqOMSz/7pEegAJJmdggJ9SN28hfaYLghiU/EC3qZeG7LO81YyF+ikti7vxbmTc8dKp
         vmk6eEcV+/dyrbP8OhLFxLiJhB0iQjZqZA8Mi7z10kMg3LMLteiOU9hISM3h7r0dY+9l
         +dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361031; x=1792965831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J8n79Due07oqax9zNrI4fLW7LZxFciWP3oxVoKoGx80=;
        b=kWH0xWBZpt00V+L+JbfKTs3aVmePSrjLGIhODbS98UKHSr7vB9pA8TbR4Wit9+NFEN
         O0teiiWj4c18l0floBdnxFzHTBpzjrh2RSazyyw0E63cchLIni5QDd+iZPxT79w1OBsd
         qk4ZgMXNu/QOff90UC8FeZw5yJXUBpmEmwn8sjgeKFxtA3NdCBVSBfkcUhF+9OBmcOUr
         GmR8ngfmTZHUnJUck2QvJRL/Fo+nPawn22DETlLRemsqZcdCtJWErhyc52m6hxXcScZl
         ZFCoXQ7iy88X0T2y9OsYXOiyPtd6r6JGXikQ3Q1ceJaGEAPa9+9GEkTxYn46z6vhaNFe
         k7iQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEXLr2798pVER729h4LAIDYXivu9Y63B0plnE4ILZIHYq3U9D4Hj/4bCXX2ocymf8cuZTLvJQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4zte0VY8refCItAPjoLiYTvcp4FyaJrouNnala6XWflXxQiVk
	BEDrrTgaPt2t0iKmZwbSHJby5cyYeu+1hET+Nwe6w8yyLra1glO3qRI=
X-Gm-Gg: AYBFou1zxjH6M0K5MZf5bERj3mRCPSqMc9L6VdmRypHemgmK+Bhyt3lLyzBSZZZnBng
	UImS4OCbbg/o2XadrohMVeayRdA7mk/SFO1u+LeOjY1j8CRwic51McEOD/4ut0ZMcFnONlueWn0
	J0mPzVmB1c7ymxOp8rcal/yu4eUaU7p5C0OoqMd+XAvIqEPoT+9HRcujBhHH55+GiDc2ScaTbYT
	we2barjIcVslCmZPHShslBePImvjWO2667lTaSrn8K8PzQkt3AuOjZhPdraILmHXlJvSM96syWd
	uajtMaIBNkePN6C8IMtB1ddKwpzfX4OrvwnBjq83x+Z3/3uCAvJwLNEjAFUy9GAtR/HKzU3zlOh
	Cbsky9FfIgfUGA5peZAkSgyGihvp9LuvNgFSh9Clj7DsM7+fVv3QU9F1hhKd4f1uEK81IW+pob8
	91vHXPF4HSrpQrzneieQ/i1oRGYzmgWYwjsK8MEiQ=
X-Received: by 2002:a05:600c:6215:b0:4a1:d41b:5060 with SMTP id 5b1f17b1804b1-4a1d762b705mr105690375e9.22.1792361030661;
        Sun, 18 Oct 2026 15:03:50 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.49
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
Subject: [PATCH v2 5/8] HID: zydacron: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:41 +0000
Message-ID: <20261018220344.1987142-6-tristmd@gmail.com>
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

