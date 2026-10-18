Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B754DDB49
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359508; cv=none; b=Y6mJYXo8O7N4Lf/Uh71Y8yim6k6bmjTHdiHwVUsnTT9Un6iiybfvJbWAxuy3CokTy9tO6Wcbo7Vlj1rS5fpueedekk7PAXWTJQ7c5rz2e5o572+6DVmskxZKw0XTwPkH5HZM4OHqmROKts2bAZgkaaf4H0jrREuTp9G4fkgrAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359508; c=relaxed/simple;
	bh=mDZyU+7/YB0JlQIRAEywPgCEGsycCredHJmQMQnsn4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evcdC3OsY44T4uMAQB0ZMtM2iVIg+rPsjecKFRv5xZ3oz9V2p8CUiWgQYt87nV9ufqTuQMfFGjIjTx1Q2Fwdpv7Jk2XK87RCra9chPcvSvkrwHtUa+JjCeJB6yVWJTzgPahB13sR+0xD5uNXM8sbATOFh9jvGyV59jnaZZMRonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZa20WuQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZa20WuQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso746919f8f.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359505; x=1792964305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=XZa20WuQ/e7QgTDshBkEU5sIqgGI6rziLlaCIrwiZFF5GfCLceDyuya3mMzzvRUB0D
         7PpnNnuIiH8KULsj3qkpfJqL74yDVeqlS7+FdcHElPe8S3Cy8RBo6QlJbqG3k7eAG/Qj
         +e7+BoGen8jQk/tuBsQzu+BXQh/LeGyBXU9e0LwmRxpobXpZhTqP8uBAukkxVPRM1Vdn
         zTqE5vh5vm35cJSAUc8GqIr147hCUUfatj7KABnOPgiPeM9dooSTYAATGeXU/4vkLhQz
         kxMhfczIPNEg/qfG8RMsh5e26M7S+qWqg3rTCsO48JrWpqLh+Qka5qfv9ABI4Ls3vJ3T
         S/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359505; x=1792964305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=kPAv48zBd07qu6XiB4McvylXnMrUuA6X3mcOgfEHEepEianszvuj4xXMqF9R7UKBDu
         sN5GnmUch+2dEeyqSXV04FyHa4UAJJBLAMsrmgG1N8XNRbIVshaHmFld9MqolBhEFEb3
         RBY0wj8vbIUWVbuFM6D7OZhJxXyG+w0lcPKOCtRL+syKnCR5FWa7ND2OknJgw3tRollA
         FCHqOMkKzgxnUSvtgTBDNhI8CF5ZW904QhkkXVKTSM5d9vQNfMoyFE4jDceK7qG9EPUM
         dvvJPsvsAnnlrjFRc70czrtQGKU6p8Wwr7tC2ro3pfhDiZaXWvzgrbjaXHl50VgM1DJK
         2EHA==
X-Forwarded-Encrypted: i=1; AKwUvBz0z+iauOalOpu1wy99OL8mUEES2dk8RDXtex+HwSp9RV3YIdlDvQnyluUYYtuU0/STGFJvFDw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsqwVhVg2luDsRcvDpO2CEEMo59uTmdRsM3DZmffgzo/vzk5K3
	eWBUWu3paSdnQkJIRVsvStfkX4v+uFUxJo3TNo4SoChNk+awsEqTmi8=
X-Gm-Gg: AYBFou2ZT2IMo64Nr0QhojfUsFDum2d1c0QkEnTNY1DkG8qazHarPD2IJJHWgof1rD+
	yYtZ7wruGL169P1Hn6Z+2+T4Bfxwi11xa4sUpaFIYtaUa8Tmb+sAW0yGs5rYdZz6Sdp+Y+tPsUr
	K3Wo6y2WHdISAA/y1EsH3sZGrRz1jhDyI9tXSjcAeSZ6y6M5V6LYKXSTrvf4KrCONLNGv6gYOqi
	iCZ6uHBe3UBMVoTp0My6Kddg/9EVJfkcgo4JRjqqxjPSy9cMyM/FkKE0iFme+EnLtyYJ4/vBA0t
	7O75IIf1WlfZcpp0lZzeQv8of79L1P+6t1msy8Gt8+DY2bYVz4uzrjehOqrUKBHd1hO5IrSxUI6
	pySWjM2sU3c+FAgxXaRD4hKdca8T0hmycwu0IEtTCnBrSDrlMCM91I0MDPCYwr1VBrnEpiFWp8K
	qhoW6veiuFw/2Ky67IHIo3CVMaiIf4y71th8i6W18=
X-Received: by 2002:a5d:5e06:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e17d11718mr218201f8f.40.1792359505274;
        Sun, 18 Oct 2026 14:38:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:23 -0700 (PDT)
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
Subject: [PATCH 7/8] HID: cp2112: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 21:37:52 +0000
Message-ID: <20261018213754.1951187-8-tristmd@gmail.com>
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

cp2112_raw_event() processes incoming HID reports without validating
the report size against the data it accesses. Since hid-core calls the
driver's raw_event callback before it validates the report size in
hid_report_raw_event(), the driver must perform its own bounds checking.

For CP2112_TRANSFER_STATUS_RESPONSE, the code casts data to struct
cp2112_xfer_status_report (7 bytes) and accesses fields at offsets 1-6.

For CP2112_DATA_READ_RESPONSE, the code reads data[1], data[2], and
then copies data[2] bytes (capped to 61) starting from data[3]. If the
report is shorter than 3 + read_length bytes, the memcpy reads beyond
the buffer boundary.

Add size validation for both report types:
 - Transfer status: require sizeof(struct cp2112_xfer_status_report)
 - Data read: require at least 3 bytes for the header, then cap the
   copy length to what is actually available in the buffer

Fixes: e932d817866770d4 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-cp2112.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571b..2508c8ea8b693 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,10 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(struct cp2112_xfer_status_report)) {
+			hid_err(hdev, "short transfer status report\n");
+			return 0;
+		}
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,11 +1467,17 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3) {
+			hid_err(hdev, "short data read response\n");
+			return 0;
+		}
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
 		if (dev->read_length > sizeof(dev->read_data))
 			dev->read_length = sizeof(dev->read_data);
+		if (dev->read_length > size - 3)
+			dev->read_length = size - 3;
 
 		memcpy(dev->read_data, &data[3], dev->read_length);
 		atomic_set(&dev->read_avail, 1);
-- 
2.47.3

