Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CE4C1502
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359483; cv=none; b=jpORagQjIeEFMGPWR6Fc5WffDbUgDz1pxpvwFWWD/k/TJqSY+hiBB/zwv0myikGUfCfsiimSqJ1tGeFjyC+kLQTsNidwOQZYNUabEeTbJkfjuIZSjYTozFImId20nrIpuH3DC5cbm9Czd6b8vs06tsocF70gmAFcXwp2m6gDLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359483; c=relaxed/simple;
	bh=fLPb8kE775oBdl47IoHKogj9ZqIRFUWk55lG7MgAYNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6vD/aaQrGVoGcwjxZxfUViwbligZ+s3bEN8p9pyteFarV444sVWKfXJTFTUsFJ4GBjaqB0qsrY2IiyVroPwfz43+wO6SM0xwAkved/UIJzplfxMkrZyU/mrXpbj4KH3FuGWh+QxJvYftew7X4Nz0WNVXFqHX1uutNlVNjZQJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4G7kmMr; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4G7kmMr"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso810344f8f.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359480; x=1792964280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=B4G7kmMrzrdgVQnsXgMc/uyqWK1pbfHXDESTxnvgsXwJgZf05wu4eQHPVM0Kib3vX6
         rw+j+fa2qAqxfAqT8PUiUI1gQKNoBmt7d3MVh8SDWdU52dt5cRk6uYmlI2rDDcRxjjqV
         M/rtbHDXfB68TlZCaC6dgd4Nkj9zXYm4VEAZLqydEuwUmZAY3wj1c39wusmyy92umFpQ
         UPJNYAjId2XRl1dwfgtUFzR0YVddbUJQNoRmV7D7oXvwD3ibF42mc4mi7A9rXU8xD27E
         glyTtZlkUD8Py8dw6Bvh26ZRk/1Jk9Twhw2LRhkFiYrRGM4k0bHf7uC1C7HuNVMux2cw
         7WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359480; x=1792964280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=IwbttmWqzAl9eVMFC0opdbSyJUSgyQdb85PSJnvMgLqB7FN/etnZVoRHoqaQrkyx8W
         U+9M5dtU0XN5Jl0z3nLrAElzEVCKioPXpmyXl1ccgtSJ4IDgwzLVzoTk8tyu7m1nsC9G
         7xEuPzvDWiiVM2KTg1ezAPX5isDKCkm/iZ1axpsg8nayVHJ5v4/aVbfGI73HTQb5JWPL
         FexnVwvd4vfDdPlOG/wiASohgrrRfFkwWYEEfxWa0BOFwc4XcyPhPeeD2aNL+A9RAtVz
         IwJZh5SlJjDU8DEClzlhqUdkclwa36VAz3b2SAkl28ua2hCWKCkqdirfzvPZJgLQWl7J
         0mdQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/yU31ZjbKhBmjTH4HD/EGmY2QNIxRdoiudYww8gizyDxdiyEGjrLkrazFS+1nE/sDzSb4Oc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLeKLYJK7t9RNJUuKgbksidN9CDfr0hwvXRTbXdqVBLGdu3xlpM
	MdDYHv4MS2Vz6f143daMP3H9Z85f3icj4psGfYlfxCJhruBxSkMeYkA=
X-Gm-Gg: AYBFou3RkL6I4PZIzKCtMjmRpRTZ+jVHxKkJKKZQhZzbgY9pTavXT20cYnRSrHlI0NZ
	erS8iI3BOz3vBywgiamTww20eenJYP15JmFpDVJ5qVF3J7emRBOVnPmRNM2zNRkLJbUnSsW6A3N
	QNj4VsZ3b9trVTWhnKar8ZRxPbZFy1j0nmVL2wI0Nl7fp3x+SBRZw92PDVuxLsf4yAyoUq1erDm
	ICr8DMA07bk3byHG/UIwu5I1qhNmaZ7Ivp6PU8b5H4lNBYOGbC0vYVisdoExtCAHBixFVsC4FEO
	+IH0WLsfRlZMUYxq7gLcsQZMQ/UscKrzJAuIoz66wNa3hTpd4T/QpwY8jzb7B7r3Jfnei7YbTDL
	24V/Bkt4/txU2Fyp3NH8wFoa+Sdwr2uZmTvDpKGVritQsmsx9GKDx8IMLc/z7dB9ZNPNMvOzOCj
	pNCOw8TELdDq+C0wwsEh055Y2BklX4stXKR1pXPuM=
X-Received: by 2002:a05:6000:611:b0:48d:f56d:be56 with SMTP id ffacd0b85a97d-48e07bbd245mr13566293f8f.13.1792359480031;
        Sun, 18 Oct 2026 14:38:00 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:37:59 -0700 (PDT)
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
Subject: [PATCH 1/8] HID: pxrc: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:46 +0000
Message-ID: <20261018213754.1951187-2-tristmd@gmail.com>
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

pxrc_raw_event() reads and writes data[1] and data[7] without
checking that the report buffer is large enough. A device sending a
short report could cause out-of-bounds memory access because
hid-core invokes raw_event before it validates the report length in
hid_report_raw_event().

Add a size check at the start of the function.

Fixes: acc3e34613da ("HID: Add driver for PhoenixRC Flight Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 71fe0c06ddcdf..e3755d8b85c22 100644
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
2.47.3

