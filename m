Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8387414A1F
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361037; cv=none; b=rbuxJs776wAUNBresKXUB0vgfqUWVFtrAzWEiNtDIO0E2pgRHq6lUXnCy5QSm3Zsc7uG8qmYVuTaZVwcXVnyVzD8k5vyt9PXCZPt3NwQ4QibySB1ST/FBPevNZK+GZS2hWijgQR7MXx664YKx1sIZ9bzR4R9UHRDmmg/11uHZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361037; c=relaxed/simple;
	bh=mDZyU+7/YB0JlQIRAEywPgCEGsycCredHJmQMQnsn4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt7uFMh+kT4n3Gq/z2aZFPawdEsZjujsw1aO/oiNX3qMs7+WNzSWVglYfHRNZ1rvDIohEcRAq/Wt7hkvc9HUdsN9hgLxh/JpiWtUJNaMShACDbrtTHuEBbK5JfhTxwDy67i7BlijLKnhl2FWBwRxNEpWGCK193IP2clX9mmgpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNWczaNW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNWczaNW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1cef0439aso15760065e9.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361034; x=1792965834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=fNWczaNWPq+wspNxMiQh0BTjpibMILCgj9S6CWAa1IaHiiqzIfk4RZ5+EHAqvEN1C1
         JAqb6bXB0wLlbrQwHuTk3LKdw5YXcj+Pbdei40/lvT2tTuv6+wddaSEn+L4CEFxq37hq
         pMqWOFkRZfPhWDem4WsZN/VvFS5aoGNex0IVTf1o2mV1S8cZdTT6jmlyaLJsSaDnSXli
         oewAbLDV315L3TIULGe1peAdPM7xH8gLKU2/lWaPNdvP6T3fcMYVh38aTC4HxKe1oDpK
         4G2tq+SUl/hufG00GjXExm81xxBaPFCpCeP35p1t85ZNS3gN4ewoUtLzzrDhDPpYLp9o
         Ab0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361034; x=1792965834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgux2BSkdpCe0yAd96caJdE5ThN2ey9owMjfge1g0T0=;
        b=QjeMJTRrjdRvqFeao3IB2jJi4n7TnjxHCD8+/2J7ISWJPAVGWMLT/uSYwVRPqVvL3P
         aYe24AFYY5sXpfo9uwMih8N2eNeUhBg1ZuDx2UfSwjapEzQj+taxgNk+VYlW9XvgyEDE
         L1oDd+wljQ9y7tJ+kLI2NjBVVYiMuLOeDk8ZFuPxwa3LLX2flPg3Kb7t7HUn0uhu8nLw
         9c3PHBzmBtM0gwfpVK/OPK3FnVEdGJLcPl6HfegNt8TS2Q9DtFdj4QrddvnwItNYlMor
         hVgateadhUx4CR+XC+cJPbISmvfpKUk54cnrMt7AstiL438UvEckDtATZeP2Qf0z7q3d
         yBUA==
X-Forwarded-Encrypted: i=1; AKwUvBwZoiTpHg0izqnxnazj+01R8CdrF1kokDXYQKz8HYlaAjlAmeEIeOvz7bbPqaNcazETocbwQA4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlRhBEdJYSrv8oPm135w6G+qYD3Pn4bW91or5CVZlUgcxPsl/5
	jRnSgxryt3uJZ29nJRfusnBuzC38u9pHnA9dpNl0OnEfLE0721z62kY=
X-Gm-Gg: AYBFou3V+PtpFSg2cXOxnZYqJXoU8b1ezWyss4oxVQogPj7Jix0L3AGde/RVT5Zyyv8
	y/QnsMWHogT7tenNGF29795fyg5t198b37wxbT7kuG9m35sKukJcMgf0RduMy16HOzgr4NN/q9o
	uY8HI8/NitwglOzTEO/U2SR+V9srVZTQBoOC+0V1aFKfrqmBCX5S+/ZRVx8pRUYRWBCuc9K3CZc
	ycFc6LQQRPEOSmRlqsI3UWUSUSzc+kVzowDptqARxpJi9Nz9ZyE5k3KSYeweaJ4nC5z52OQnX0+
	e9/BYbfPZQtLAcZBmuukuCHhDvItSAhntCsLPY2LDyMaqY6iMzQikqSe9hK/0X7qH9Oq4IBeEo2
	xr3ZdbWHDeLU2TMwFd7zlnMhUPTr2eydPYZvqJwL0JWREfnsWYPz1KS1x3NLqQGi2bjKotlK0Tn
	S0qUNsQnp+XFcrkUetBNiSgr12OsEFXymY07VJa/M=
X-Received: by 2002:a05:600c:a085:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-4a1d762ba65mr117228185e9.33.1792361033877;
        Sun, 18 Oct 2026 15:03:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 7/8] HID: cp2112: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:43 +0000
Message-ID: <20261018220344.1987142-8-tristmd@gmail.com>
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

