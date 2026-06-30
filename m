Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B771DDC2B
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782780188; cv=none; b=F2co8dK+CZhqWyz09tBhwgtvY5ivbT1m6p9XKNJvTkFLZNwObVNmMMKAtJ1Tn5TuaYAJaT+gARrz9ASHL+iuDbiZ7hv5S+HELKUXj6SwTAcpv6bERUHn3zgw/wMGZ+oGCj6nyFHdexNNSIhcT28BpQzzAMNg0vWrCwOYbC1uX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782780188; c=relaxed/simple;
	bh=z99q+4jS1qUXEL6QiDspninof00PQ76INtiJ8XzQErA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDbxKUbrE4BuUiCCypCvaLju/K7ZEfBUy67LcAfHNEj7VlsCkfSM0KtvPSle9CWR25XdmTVuRxYj7aF3LfRMJvu0+OyMIRgSqpTwmCIg2Cfmm05lbO3P6xYRoRdMXC7OntJsoWXJwzBebBX262l196gp2LdNjZkzLlUJGHR0MR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI+wfI7J; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI+wfI7J"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47488efcf30so711668f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782780186; x=1783384986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EU/r7lx6aT8TqQKRkjOJMDGUCG2zOVOTTvJBrER2oM=;
        b=SI+wfI7JASa6HrZygwYdZH98jvnkmfI6kz84RxiFMxdJ3ib0vM4KAMC6BvFi8uNySt
         6DO8Y1zAR4YnMFh7zQaxyRbtfNMZ1O7B9n6ny9ANZ/wdoKQTePYWj6d2PWDDSn8rk3iI
         tSya6coVpMdHreA3gdttMLoH3t2gxXmm9m2uiED37KR/prQiECf0QQS2jNsFY1IRCwzn
         7HRONz11BqZ7f3B25rrh4LyEZln3BeWiI3mn+HFu3YxnZTCkN/C8+A6Ga3XoHpwJf/8x
         wGNJaGbvCjdM4I2oGcyL37aXhJc3UY40r10SeWdR9pAWnmM/pgolSWjriCVD4BdDZ+Vb
         QA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782780186; x=1783384986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EU/r7lx6aT8TqQKRkjOJMDGUCG2zOVOTTvJBrER2oM=;
        b=NVsbm9pTHTzlVVvnNmMlpi4A5e0uvBXzyFlcq+DsPIoS9ff4lBRqEFZdMyx35TrERC
         sgnav9VyR3W6afpbAISlHDvXlpxox5qKjFR0koYmgzqBoAo04RaIzF6tdkp8/Bq8V+yz
         jVTfPp8kTciuZsLJnyEDtlMiQ6EhrwGHguXiyPpU7dowziVqcKKaPZZXrmtUyYg/+sy5
         e1hmRgWXI/HLp/SHURPs05swfcoXaC6ymbglPhQuxI0xi832shNQfnpFek5PsZl9vc4f
         zRh+VEaE9FhlNprefA+M8M5xtf2y4mnGHkezzCfOPgBbWj3bMxeQ+ZpRHLN9mGc1ahZN
         xVUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XBoOjy2RJqGdK/WRDsJIZ4JQ0oAfMpawB1RlzMxwFmh6VhkYBvFyMuhtqIgZxzZ4wUCQ6FwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzratRzZ/laT8/S02B0Hh7EOCIA3SdhfEJmK19yIMlTt+hjprgJ
	rLnkB7B1GR12QnTtWoALXUZJj0TseS1dej1eTQ3I0oFIL+wCP8MKkXpx
X-Gm-Gg: AfdE7cnlOMxmDdXvichM0HzGE34ppLluVxo2uOM7MPSRQg+U8RMXCFZsWqVljdhcwHs
	YXsSJyEx05lLqaIJWCDCf1vOK58pqQLKSb0ttgvDhUbl0A112kEjjlcJsZXkMD7Lo0z4zezPSDE
	oVSX49+HmWDvzUIzyy3gnuyU/LBMWMWXo8DeyI/UPhrKttZdH4YQw4QWmzLTuHsmS1WPVumpe5c
	jIawVZdB7Ml5B/dnXdeJtjUmZ1sbh5xYrtPGLokh3ra3z64wXd8zLWMgWCBlsGLmHePxRwBkVWV
	dU5rY4DvM4R39H3rafYBmYIL7U7i7gufaqb7ErOrVLaR5ApZIfVeQNl0LJ8DCsyi2Q52j6Hodxs
	BwO0f6R7ttz4K4VTOUtt+egjl4ApcwD3ldmricwr9D9j/d4mwhRw9PpB2Hu0wJe7VvR6WBd2gDu
	efh2LE0uvxqv+0nbZ9enngHzjuPJ3uBqA8PiTrKRQ/XuSYR/Ak27dRr8AZCyKEGn98BHBFUaWED
	wKri/0qbGDA
X-Received: by 2002:a05:600c:46c9:b0:493:b24e:649b with SMTP id 5b1f17b1804b1-493b827c8ccmr25844095e9.6.1782780185616;
        Mon, 29 Jun 2026 17:43:05 -0700 (PDT)
Received: from snakeroot ([2a05:87c3:2001:7400:25e9:cccc:54ef:5829])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cb0896sm29909195e9.13.2026.06.29.17.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:43:05 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: linux-input@vger.kernel.org
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	linux-kernel@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] HID: corsair-void: Check size of status and firmware events before reading them
Date: Tue, 30 Jun 2026 01:40:01 +0100
Message-ID: <20260630004003.579171-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Malformed status and firmware events could cause an out-of-bounds read since
the size wasn't being checked. Check the size and warn on unexpected values to
avoid this.

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 5e9a5b8f7f16..fdcc4b8cd272 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -92,6 +92,9 @@
 #define CORSAIR_VOID_STATUS_REPORT_ID		0x64
 #define CORSAIR_VOID_FIRMWARE_REPORT_ID		0x66
 
+#define CORSAIR_VOID_STATUS_REPORT_SIZE		5
+#define CORSAIR_VOID_FIRMWARE_REPORT_SIZE	5
+
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST	0x1
 #define CORSAIR_VOID_USB_SIDETONE_REQUEST_TYPE	0x21
 #define CORSAIR_VOID_USB_SIDETONE_VALUE		0x200
@@ -742,6 +745,11 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 
 	/* Description of packets are documented at the top of this file */
 	if (hid_report->id == CORSAIR_VOID_STATUS_REPORT_ID) {
+		if (size != CORSAIR_VOID_STATUS_REPORT_SIZE) {
+			hid_warn(hid_dev, "unexpected status report of size %d", size);
+			return 1;
+		}
+
 		drvdata->mic_up = FIELD_GET(CORSAIR_VOID_MIC_MASK, data[2]);
 		drvdata->connected = (data[3] == CORSAIR_VOID_WIRELESS_CONNECTED) ||
 				     drvdata->is_wired;
@@ -750,6 +758,11 @@ static int corsair_void_raw_event(struct hid_device *hid_dev,
 					      FIELD_GET(CORSAIR_VOID_CAPACITY_MASK, data[2]),
 					      data[3], data[4]);
 	} else if (hid_report->id == CORSAIR_VOID_FIRMWARE_REPORT_ID) {
+		if (size != CORSAIR_VOID_FIRMWARE_REPORT_SIZE) {
+			hid_warn(hid_dev, "unexpected firmware report of size %d", size);
+			return 1;
+		}
+
 		drvdata->fw_receiver_major = data[1];
 		drvdata->fw_receiver_minor = data[2];
 		drvdata->fw_headset_major = data[3];
-- 
2.53.0

