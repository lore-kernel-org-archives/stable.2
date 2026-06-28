Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A22D5C83
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664571; cv=none; b=M1FLirjofl1Z/4tY1M+Xc+jjubbdRGKBmgupWJH5TnIDAqT40TdTRL+0dmP+UD7mWrQW/zL4Z7OrWXdyvQMl4oiWsk6HOTbbmcVA4MQHZLzc9NCZdm4H5KPjiBoSCHDPQ8rBAZKCiEEDws28aMpkiedMgSM1YuCPDvUZNgn26j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664571; c=relaxed/simple;
	bh=7SAk7Fc0yzlHbXtxGBYgum1SrN0nR9Qrn9RNTSJLToY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fccPgaTP6apWR1K7tslMhfnJUWwSPwK1OjCYn6hii/TPaSsQ1l/jPMmQ21W5/UfAxkgwHgI3qMggecOkS7U1neSd4meeUdZfc7fhj0dTt86bh7LzexH9VIOd2Hq5ghEipxdUKjO+937FsA8edBgOAHF9cOohr0tDxhYUu0lqNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9qe9XCp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9qe9XCp"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80f602d8785so1068177b3.1
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664567; x=1783269367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9cHL391eF8wlJWPwE6JxoCaVclgQ3+dLf6rQ/8ShHU=;
        b=E9qe9XCp+HHJWN3Y8fgjLBrS6yXehppIN/VcXW2rs0EtK8zvH4dcCI/T9/B/AKPp7t
         44XzIS2tSm4l8SSab1F5xyrPskQ3tMagM7gyD8/hPyGZKvVHeHyOhWO1mhZSdb9DhUSC
         HnB1z9S77Cu1cpQC2s0HyIDybnrvn/nQDhZhnikKyNjVk68K9/SXelH55YA7dOotXVEF
         nnBkqZST6G9PDjKYe0kN/f6dp+uETmWPgnWokRjjPcWnsMnzqwIndr74tY63EWoysCOl
         MCbyZ4vhETcfgeIcg+/efcAPEeR11HQ57KyO4FIwfrEsVJw+4KtC+gwaxnsSEvAs+95N
         FNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664567; x=1783269367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9cHL391eF8wlJWPwE6JxoCaVclgQ3+dLf6rQ/8ShHU=;
        b=aZJBzUlYxtpEML4H63xssZGX1Wp4z/c2HYRm34Nd+jd3eGYgaOaxuc7PEjdtd52o5E
         ymrp3uzDjnWhxcG8WoAcI9M9hqWuYCN9tZX8kWfB50Ox+JoKOJn5QPzyB2hX4DlH3GTt
         lwh1abFim3Zf80S194giKF+2oCPjXksA+ElndlAY6bvOKdAYcJLGWLGoRyfi2qDbaNwE
         4vmFLZ9PV2cHSdVbsspD+Wk3It36LcUd0MibBBtizqaRGjlCKJKgE4u213RYRYVmFExD
         UNUGouk9FuM8sA9RnPDlVAwdZQN0HV4wr0gy9eL7BcKwyyyXAMjmr/P2W/FOaMt/ebtq
         hP0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro/bIFFnDsGlis16h2pgHiazrxaQWl5KuVV7oMROLPBpGGWWV4OpdW5iLckaPx25eEGHCmmR44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2F1HyrDPktFiihO7wgDMmgtO/RUO8OOSUu1NAxGJVHKELr6/v
	OvwW48Xb4DyZBGLpGEZSLPEYPY0Ji7pVJBzTuIuAzvAKZdsKpzAX3m8L
X-Gm-Gg: AfdE7ck6L35j7OkxSZHme4yH5YXkp0C3foGLwWQ5GsEgeLrnJ5fBGprWUshZYDOFdtS
	7bb5Wn0KvWHaY4B3F10SK0GKbv7tXxWsO8DZfb5JqWlxJPat4ATJRzjTucO+SFUWGKDd8ZNgto0
	7ACQ4f7njjyCEZCTov5VaPDsr9mK8LzIrf3+0hnkVqAH8F98udLm8g1ZTCRKYM5P8uizs5BR3WL
	nG+gLQDX82XZPHT7Jxf6HviEfhzpgQLW4e0c1xX14DNGg9D2F5GPXZF6Gqpw5ETl0byxdpOxij/
	tc8wcSRc9nSqDYyf2dHVPajY002zVXDqW/+qaaDVB7Bx6iYxlOiqeVr19Ov0DDh/WcfNMSUgDdB
	eM+o841ms/WjTca9F51eMgBBIWGA9cT02NVpmSiVznjmwbVhYP4OnPbEeiFYxb/TJ3TXMn2Orkm
	USGbuxQyfFp0DscknDCZRAsbf8HbCgNvRI5zyV
X-Received: by 2002:a05:690c:6703:b0:809:28e1:d50c with SMTP id 00721157ae682-80a6c8781b9mr145384527b3.26.1782664566579;
        Sun, 28 Jun 2026 09:36:06 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80ea903f74fsm6294817b3.21.2026.06.28.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:36:06 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Stefan Achatz <erazor_de@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 1/4] HID: elo: ignore short touch reports
Date: Sun, 28 Jun 2026 18:35:24 +0200
Message-ID: <20260628163527.14279-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

elo_process_data() reads coordinates, flags, and pressure through data[7].
The raw-event callback only checks the packet marker, so a malformed USB
device can submit a one-byte marker report and trigger out-of-bounds
reads from the input buffer.

Only process touch packets that contain all eight protocol bytes.

Fixes: d23efc19478a ("HID: add driver for ELO 4000/4500")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-elo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index b8f5f3eb53a4..1aeec712c67b 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -89,7 +89,7 @@ static int elo_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (report->id) {
 	case 0:
-		if (data[0] == 'T') {	/* Mandatory ELO packet marker */
+		if (size >= 8 && data[0] == 'T') { /* Mandatory ELO packet marker */
 			elo_process_data(hidinput->input, data, size);
 			return 1;
 		}
-- 
2.54.0

