Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4604E01E5
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361031; cv=none; b=h67EW/IorSxM1T0g2G9YH0wuXQtU6a4+AhQvdR+mKT7o/CEIfe8RXaZq9WkLHlNjL/fmUfQkiIgHpUnPq2RVLaititFLUWZ7njQcLKZRFnGpvBhBpzvUUKOfM+NYINYao/KPNqdswa9fdMnN1ZuefRfMBW98jIYtD6XcAZYc7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361031; c=relaxed/simple;
	bh=e8wtLcepGB7m1WkPi16XBbmRmlD4CHncDaB4ghzbtZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwvhzxVGBS+f5stOynnYZtMPfloyec7mF7lLa1goLeH1eC9RDE2hMVW97oIqjJAad59+nZHATD/zwz31gEJLLkoaxMgNHzMvWb4Gh+uY6BO+zcNYX8PWjLgFU+4B9pD+ZAUNCxCGLhzYBI47/jHqUjUhrKLra33OTGH5zHIxueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBBVvWaE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBBVvWaE"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso970851f8f.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361029; x=1792965829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vAVYSc6bOeEhdjTuKd9lteCMjpiUz07VUT/q4gCOyPM=;
        b=NBBVvWaEm8EhWFtYDWlV5avkG/3Wvcifz2oI8e+ZTJFdYBR0PyQfD2pFkENpiEPRad
         PYTs5Xfwp+toItQ3X+n+zKsrQP5GAq9rrtRqfbNCcByv4pXjmuSQ4Ww5foXyLljhycop
         K5OvMlhVlWwxc48fMwhfYX8tjOn+GcURRON6ei48hhMkjg3ZhrY4isXaqnU6oFPbydvA
         caNPaUvakir+uzI2HseXgzwbF6SK4psjGYYDoKnulB1V59fheIfV7Dr4mTF1SViZmBPk
         4UWD82y/0Bi9wjhvltnRr+LCYbmezET+xlZ4Kg807Rj1FM++ZgZ8litOk7rXmWbugzt/
         Pnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361029; x=1792965829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vAVYSc6bOeEhdjTuKd9lteCMjpiUz07VUT/q4gCOyPM=;
        b=rT2Qoki411AhMK9t35paKZnnQzQiekUviw1gIgVqpCmNTOJAYZ1rfa1m+NYfIplz6M
         ldGIlNRAvuSWC8wA0qMGMJFzZBKBy/OcTfPMRe0olAI30/8osjmXCRx0y/Mk91ol8Xfx
         /1pV3NJH6au9gEY7WmJhs35jnevMX+syIjcvlyGryFlAl51d4UZKgo8DXaocOvP6z10i
         5/pXAJuUA7LXUDv2FHjfndTeOAyaKqnI69xpFcy4jFYCuSvklq5CfjhXKb75hVbvA5sQ
         YN+Mk79tHrVfmNx0thZQLR5XAF28/ZUuJq18lnjXzodyvEDz3xrK4+WVV2fdCTOCk208
         MWHA==
X-Forwarded-Encrypted: i=1; AKwUvBwKo7boSgZ3f2dW6Gzq56i/UKZR9sN/EzyvjsMSUHIruqA49P6VJF7Ht2WUTBMRM6a2kijUE9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjgKEpvOX/Hm7ibGu0dFlkDWI2szWLJodwUyajvTaw8BaGwcqy
	7Y7YrWZ/ypeeFfq+auOMHmdC2CMkfjQ2ORY9+PXZ0RsE9VPzy3aZdPg=
X-Gm-Gg: AYBFou1aNaGY8Y10WDMpavza80p4AJENwXnXbCcAaEvGpF+NDfrQIEEVlVUZstVestZ
	xC117zHIirRCLYsWGv9ZUS9bjCwEKrqZodULpDBsTnwFYe1rzudJBb9vyCAh/mTk/lBGEPtcuSq
	QJSZii/itBsuUJeHrNLmFsi5diMMs2/5wLaSsYtkT6xd7DNS6rkaC3jItX4r50zLUyWLidlNFFh
	fV3ApFJ6fyD8AuXf8kkfAVBOyY7U5WWZjBriGrv3dUeKPJsdPSXjBIiJZaKcEnjNLkIKYvYCYAr
	yLk21Opvd4cKF5+wJ4FShsjyOj7CHm/s6MDmZmo6p8UHKvOtwub0WKG8N67ptEMv4GanLQNqSyh
	yStWSQXON0NHAzjWSyDvazJceEL1i2kcp0sM3yDkuYUORL0SoCka5OhqNeHcHWhe1h0sACVoYcC
	QwhIaCzqEF0Un/52XpufUJwVgjTOWbXfQLid6e6wI=
X-Received: by 2002:a05:600c:3f06:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a1d760f7b9mr124413365e9.25.1792361028681;
        Sun, 18 Oct 2026 15:03:48 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:48 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/8] HID: mcp2200: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:39 +0000
Message-ID: <20261018220344.1987142-4-tristmd@gmail.com>
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

mcp2200_raw_event() casts the report data to struct mcp_read_all_resp
and accesses fields up to io_port_val_bmap (offset 10) without
checking the buffer size. A device sending a short report could cause
out-of-bounds memory access because hid-core invokes raw_event before
it validates the report length in hid_report_raw_event().

Add a size check before the struct cast.

Fixes: 740329d7120f ("HID: mcp2200: added driver for GPIOs of MCP2200")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-mcp2200.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a0797..78a08d4d8f0d0 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -299,6 +299,9 @@ static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct mcp2200 *mcp = hid_get_drvdata(hdev);
 	struct mcp_read_all_resp *all_resp;
 
+	if (size < sizeof(struct mcp_read_all_resp))
+		return 0;
+
 	switch (data[0]) {
 	case READ_ALL:
 		all_resp = (struct mcp_read_all_resp *) data;
-- 
2.47.3

