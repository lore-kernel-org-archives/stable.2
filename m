Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6B1DFF0
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782605674; cv=none; b=a9KLIeOa5ogn1MkdJ4TXjHR/706dxThTEp1ZZ8bMM2nGdeqEGizrcxRfNoj/zpqJJG82ft5/4RoF2147r4AEoYH3pg4ufpx+B9NhVACUgMv6eDwV6fKrXCYpiouceW9agBpPz0UEv2HsDRAcoknp5qovI2aGbymwDBDOXVXhw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782605674; c=relaxed/simple;
	bh=bn5D81Emdp3F9NQjebzQbfGPoc9F0nldGSqdoQJdmTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuA2R0ixSBx/Ffc+hEsR8vykEVE+EVLx6jBLUJ4Nq39oLCP0k6TmBnTuut3NX4XnJdMUmFuItam822KfaOdr3NOvI4QGQn8ZldhHl6Cg4V7Rp5wYxwl1FWiBoCg/X7px+NDvJ7SrevdYn8Q6sTaKbtWm/04Aku0hCjJbXKcnxYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4vgZsiH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4vgZsiH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so652369f8f.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782605670; x=1783210470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebH+lK9HrTDn4Rg3W7vRRjbwOoSeOQcKiaNHs9OnUKM=;
        b=X4vgZsiHSmrJ+Zl3m9iPFdkxObopOdzVRz4wiU2C9qyJNK7oyhZw2YP5jUWlIX4daa
         reECGgG2pG0DAb8NtJFQG8+mLLxu7BgUg3MKj0hhj5T0rQfmYlswIij+9QA6nqcZ4sSs
         q2r4vfydOAxNAiqQMT0h8QAN/0RUck5LZzbpexLsw0/hd/08xp2G2+YLTF0kmbm26Vp9
         saV4GRu84aMsFoah03+/3gfr8ZN40h+z27o31qh+53UdE2H+5DvTdccYNteEd9D9cVu6
         nmiJEAT6WPOf31reQOGekA0at/mwY9KZBCXTfuwQvClzWgwMZJeisfKeckzPeVUlo7ts
         3N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782605670; x=1783210470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebH+lK9HrTDn4Rg3W7vRRjbwOoSeOQcKiaNHs9OnUKM=;
        b=RQG6Zi1CvbpZZcSPYSu4gkWvIIw7+vJMfrwulM5+X44o0zXpe4z9yQWlIe1yXSM4aH
         4oU5blZvxrERwXNtEWACA6Dwn02hgo+DuazsIhSWlViDsISpAzv7TSwBuz4IwP3J9iGF
         i4mVbg2RIKhK1waAQDlBB6LJDA/uDvg1WSqV5n4G91uf0qKZ4wr2rBP7Ok0VmtJR67zy
         h881Y6kQFBUBVjIJG81BieEg2RD71yBJ8zOQwjpmwBw8IMCmTCtt5UOMNyrXaVi/kKxG
         xQji/U0M3CnZi8pAG3JIqj8lz1lkq6yEpFSvgh5V8+D1ZGIlSa4frHmcVus3kxKa+CrG
         ZZ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ97tEYcLGjNgZ46FabaW3v29iRVPSHfMZQ2LMt6ArI6oNJxFfsvGWvWYSAa8K4p5fpYliI+d20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybgcj5wfGBf/nUoKn6UMRNC/nljn1XlV2bmE6RPni+SJ1m31i6
	dT0GAfW7viXqqb6jFO+Lua1+WdkUDTCfWAzoaiZpC+1JKZ32rEw+zhpm
X-Gm-Gg: AfdE7cmIyT3q+Mqnklsm77nsM48KjQAur9bqj/cIOtkdYE+JVdnh1faY59ArHSOIpvL
	EyJItQveGA6xpruKYZtTOo66H+YOLYt6OPQV2ArKA5TPzvJ37vvFis10XhvzgB+LoXeHpZ+2/wW
	UekLrVo/au0z8OLQ42gYy2k90/vzlSpD3kI9uhpbtKqj7bwFhjMHr+jMKzgjESOxJqY9dDPnuGM
	ZB9sd/NmEyvCzgrxzpATEVBPZX5P0naRQMRmlq+MA7LXOERalLmvHlhry2P+8FZBk+mD62aDrfP
	5TVtVaiAzqioDC4N26ZoGWGwlQPD1a1glAOZRtBMZYqUddKKPlrOQB9SuFMUy1OMxgPP76kAwWm
	+Rrw2jMQc7SQfdX1iYgBKDzFOH4j4htWlzJlC9SgPq1Tan8P7LNcRH4bTnH6QYendN6cKxILFRL
	gjZIbm9x2q3kXtwwgzQbvVfH1Srg==
X-Received: by 2002:a05:600c:3b13:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492668ad60fmr185218005e9.31.1782605670319;
        Sat, 27 Jun 2026 17:14:30 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4939a8279f3sm53101525e9.10.2026.06.27.17.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:14:29 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: ath9k: avoid device access after async firmware request
Date: Sun, 28 Jun 2026 02:13:50 +0200
Message-ID: <20260628001350.20997-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_firmware_nowait() may invoke the callback before the requesting
context resumes. When a firmware lookup fails, the callback starts the
next fallback request. That nested request can exhaust the fallback list,
complete fw_done, and let disconnect free hif_dev before the parent request
returns.

The parent then dereferences hif_dev only to print a successful-request
message. Remove that post-request access so completion cannot leave an
older callback using the freed device state.

Fixes: e904cf6fe230 ("ath9k_htc: introduce support for different fw versions")
Reported-by: syzbot+cb7ed9d85261445a0201@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cb7ed9d85261445a0201
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index 515267f48d80..aaf924cb8860 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1222,9 +1222,6 @@ static int ath9k_hif_request_firmware(struct hif_device_usb *hif_dev,
 		return ret;
 	}
 
-	dev_info(&hif_dev->udev->dev, "ath9k_htc: Firmware %s requested\n",
-		 hif_dev->fw_name);
-
 	return ret;
 }
 
-- 
2.54.0

