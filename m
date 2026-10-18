Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8449AA4B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359505; cv=none; b=tUeMTBKNWcI6YorqLxUH51ZiZmnfAHjWRPqDLndBCzDR038Cm7qExGVKLz4nDNebagYxyTwjKthVhd01hOt71+mF2KIC5Jgb7ORWa7Wuiw6xNoZGfyUnEl8CCHOw1JNPlo/N5vahj/djBqS/KGKqBtqCVCssa3REe6PH8zoro7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359505; c=relaxed/simple;
	bh=aUzjK8ol795HHRbJphJgtTRR/M0uYgvtIthrbMPir8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APwzuzGGy37hSe6mDDdBK4LQBWBkSpALjfCBe6Phi7VBOwO06u1SJKrlaixw+2mFXciiiNWFsKG6enHt790Zr9xOZ4qzI5new8BhsomAWB2UyeYidEjkKf+5QhMvix4jsDODbvdwopa91NXUWIv8re7CwuzlQHZSYZFQGYsZy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJQ2Wn7m; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJQ2Wn7m"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d870d54so845947f8f.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359502; x=1792964302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=mJQ2Wn7m7bxUaBJu6GJ3NQiYjnIfxuxiiD0/SrTZVF8xffy5pvsEJmjNnMirj1jdLH
         qsMaiTtx4uGOlRtK22gtS4Rb8Q8L61m9aHfG856rf45PXmf14NDChgAlA26FZBTo5nLp
         Uo7l0pF3wHjE4MuwbfdDKhtEHbu9rh0KYmgbT7zyd8CgBjkwzOE65h0HF/A67lNYY3i2
         5z5Bc6OFDab3oGnEpgcZU4829bQxU8Iy9RMY/4KWR2cLgxrWO5gYpo7OCbW3gZUvQKzh
         6L8YUgqEVUKou60Vr7a5urf5er8lhUStOxZXoPgzT/tAFvSD/NduZqD9VZ3woolpuqM7
         5MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359502; x=1792964302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qXhRvFfpFMAeLGmziHDEZsV8hAj7bw06PcLUuNh1ghY=;
        b=gOjYlr4tmh+97D4bZxRfRV0VO0YRgMYRuRwPtV1zoTPz4yCgOfe5QJBSh0GaaaCfrH
         QUKlt6AQrP+XSDVZLkRPMT39dA6HhSKH3seQev8WyI6kSAh2LVHr0JiBn0qvD25kf4Br
         56xF5+PJVTVrWVvYrd+tGZ/AMMOcOvXO0AHksCBfbyn3va9zMIC203fjgpm639ohwpjA
         6udMuEjcluH4XdEfQgXL6XX4Ii2N60woJyPO8y5ox7ZGq9rpoPmtlIePLZAx09zWXu+9
         aVgNvK066JNn8RfFpF+ck6xV+rUFNTQLQGbeRFW0Sj8Dn7yS9Qq0RFqg7VsUtWssyuS8
         q+Vw==
X-Forwarded-Encrypted: i=1; AKwUvByMEKpSvZXy12aDJ1j6/p+KBMBvFJ2KfxmsIiP/IWa3xZR9cCTSLwxYoC2ckP9K4IItrbMnTTs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIMUEj3pTlSuHAmmJiakv49imXXp0+WEcWUIo6fvZ1k55xNfQ7
	jJ+mbfxe3k8UPzEb10p9BEduabOhInppX+W7tvRYTRgjMkVu5q76IV4=
X-Gm-Gg: AYBFou3oaDrMeS7cyvVO0ojgopwh+hFyexXQpm3ZBBB2qvRkN72ZtAeiJshKtoZnG9u
	3U2ddu0ey1KsV5Un1w/6r8QWv6uQe2AQ27qCUiIXeOsDGIs8URsTsiAQaIbWFyyRlIOE/PfLRIo
	qDHaayi4EbzY/tqENe/U9a70Dvj4fVr6XoXZHwiDP7C81MfeTLNlfdjVNh5EaXhh09B1C8ueHAi
	O0ZPltYXBFz6vu/HG8JbqDWD1KOK1AI7JlZAlQn4spoqEs6w7sJDXB4BaridrmJYC0oA4HV/gB4
	WXkEvpJO2P29V9L1KhYIYqZ2h4OMJ7ScrfYILSuZTcpJPUl2fhzVXsT/kIZaNbXU7oe7Jl6AEZJ
	F+XMVIzDQY+INvztVokiEnr7BSjznRFzo70zfE6hdDkBsvbk5kKP6ICoThAJlodZu52bu/n75vS
	GFrBxB3Kr3slcDosYVJY7N60FibUME5xX+hqe+Ma4=
X-Received: by 2002:a05:600c:8b22:b0:4a0:1c17:4fb2 with SMTP id 5b1f17b1804b1-4a1d760d9fcmr129006215e9.31.1792359502191;
        Sun, 18 Oct 2026 14:38:22 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:20 -0700 (PDT)
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
Subject: [PATCH 6/8] HID: oxp: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 21:37:51 +0000
Message-ID: <20261018213754.1951187-7-tristmd@gmail.com>
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

oxp_hid_raw_event_gen_1() and oxp_hid_raw_event_gen_2() cast the
report data to struct oxp_gen_1_rgb_report (11 bytes) and struct
oxp_gen_2_rgb_report (16 bytes) respectively, and access fields at
various offsets without checking the buffer size. A device sending a
short report could cause out-of-bounds memory access because hid-core
invokes raw_event before it validates the report length in
hid_report_raw_event().

Add size checks before the struct casts.

Fixes: 84910c459d65 ("HID: hid-oxp: Add OneXPlayer configuration driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-oxp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 1e691ebc1199e..af9f60d45bf29 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -318,6 +318,9 @@ static int oxp_hid_raw_event_gen_1(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_1_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_1_rgb_report))
+		return 0;
+
 	if (data[1] != OXP_FID_GEN1_RGB_REPLY)
 		return 0;
 
@@ -391,6 +394,9 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	struct led_classdev_mc *led_mc = drvdata.led_mc;
 	struct oxp_gen_2_rgb_report *rgb_rep;
 
+	if (size < sizeof(struct oxp_gen_2_rgb_report))
+		return 0;
+
 	if (data[0] != OXP_FID_GEN2_STATUS_EVENT)
 		return 0;
 
-- 
2.47.3

