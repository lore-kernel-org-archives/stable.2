Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F249EC4B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361029; cv=none; b=hzUk6CAyBgupvGJrnXY+wmk2ymfL8nvMHYCCcC8EUJOx0oipaHpcPXISdklMRVthmKEht5fFGLMzEJ90QQwOMusD4jqujhZqiaSA3FA5TjlONdUmN8MCmEEKBQK6m53dFgHww1xdP/2/A9mD7dHO8Ztb+zxsMFwQRCc12fqNyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361029; c=relaxed/simple;
	bh=fLPb8kE775oBdl47IoHKogj9ZqIRFUWk55lG7MgAYNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohgzbrG+qL0rSFBskV7SropZnelGZRfgOaFPqdIQq2C8NiqkBBn+nzTQf5WO2uCuo4r4+5yToY0UWg9RvWGEVM2+ZJELMYUzlI9tFtJWYol/BN9zapn0de+tY/xbKqd5BjCMHXq4J7vl1fZOgdRoaD11bMFV+M2YKrCGy4x+lIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6fcgFk4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6fcgFk4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so10604085e9.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361027; x=1792965827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=L6fcgFk4wFCecUOMrMRbgJ327e++InffjP308Uf4fLiP+B/9TFmILR9ax9IONtOpOe
         uHSEX5CzSeta/XoYpw8qeBLbz4i2a6x0viIXZzIE8rEYhqmX7yL3rawazThIxJk1EET2
         TEQgZ8D9vQEbSTO3tHJsIBebtQa+7H1mx/RUzeYHFTAPmqpTKoAgOpEDeA/uSCUBG08v
         C1TgtrcVT6W4fzhb9He9KYA3J/dCNVfLxZ43aQpdQ0mEjCR7Skb3LtwKfz1bZjBwFKc6
         mlpZflnUEZog8dx0PpfQ8IRnoMfci+SgOp6TocWix+PupxT41PjRCe9blFmMgh6cV51X
         Fr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361027; x=1792965827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=FH5mNEMk6sNyKgSw57dBrHYP2jwXmAKWS7QP1qs0yVlRicfROEoGSOuM8pBXsrUURE
         z+TcLrb5tTdV3js9PZai8rVHZsShZ2n86myMVuTHG4gILi5qmQbQCp3o41EmXtCDfBqv
         hqkJU/bTiiNg1bxxmh43no3rWguPUQAxnp7fylZZ1BXS/mwna+844Cw4P9ZQYcfL4hDu
         O6Jw7m/96uMS6cxAp2thmS6Zv/jg2Wxf+eJ/VaSZNtVV0nOKLB9i0C2ZQU+yHyP35h6Q
         E+oebg5jfuYPD409pFBfBozUNMYALmgromr275d0o6e8gd1lVhVI7+agi7eajxwyieUK
         2S/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwoydmvg6wGAHOpe3Nxdd+mmvlpxCO+/pkcPYLCMf3wrIE9bMYsNZMj6rJJvU0v3QzIfoxR0VQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYISja3nfjiylz9Zj19cFJcOhjyOxCPF90TXkCIJS4YvsTA/lXbg
	RBTid3naUXnfbC9DztMuUP+xUv1GTEgXwL2EEEna+ERzDFtH8ais+fA=
X-Gm-Gg: AYBFou0zM2L/ScxeoXo4xe1btMlasi8lSgUnbsrEjy/VgpYwZgAb4OAlk8agXcA1DSB
	T8zsjVqZ4qZUkVLEGgxllbfEclXd441AOHtKSJmDbCe3a+LoK7WUEs7RI9CNeoSPx5t5XuoKmLk
	40pD8dlTmnZC4xnQpMQ3865Az420CYUPj9YcbG6IZWg7k4210DeROphCAv0N32hHM8IxZBJl0TC
	YwwTm2aBZHCbp2cjG/Wu/rF1fSAyl/b1BbPk6SyLo4A6s+x2EFUEp+0Cib5T0payiVflHvqqK4q
	PMYoz05w+ca35twVJC+/DYMqZN6tT3i8QNghbTeJfs1aTKcSCqKNA6Nrl7TL0eTueIEq4wkCSRh
	u4OhkjXe51gWw4qvBMsLc0/aXtd1en+edTqh9+Mu1o6HfSUne4LssnZ9s/KEfDEJeo8xBSfdSUn
	jOnvWhZt8ZWLbcP7DCmyz58aXJwynj6FRARdzja3k=
X-Received: by 2002:a05:600c:1c0f:b0:4a1:e489:f89f with SMTP id 5b1f17b1804b1-4a1e489fa4bmr56224815e9.14.1792361026632;
        Sun, 18 Oct 2026 15:03:46 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] HID: pxrc: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:37 +0000
Message-ID: <20261018220344.1987142-2-tristmd@gmail.com>
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

