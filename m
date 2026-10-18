Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48643B4BF
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359488; cv=none; b=bpgF+mZrbo55wc7PWBhsm8LQXFCXGySNxgyeCh620+h4zWphfdvt49DFa5M3ba6zG1HXvwhBgKtIHPGdyTXP60hsDGY/+w2lQ1CyJnvoBx02voXvecWk0kswCw18KrCwQpMm16n67Sli6EytBFdEfluqsTIENCL4nlIAHCRSIqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359488; c=relaxed/simple;
	bh=xxIAxzAKoAGZ0xP42wqevdh5JDTD+id39hVBevFoMbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HurH/SJJP9L4vzR5e96hKZ1gx6ju0zkOMETZMEMWSGPzP69lNZ9PoAQsZrbbfWkrj4LJWHDU/r6QHCiMR9f/AVAEVVE6oqjcsugmMQkM6ZDxTMEGOGVND+HghCkXet9YWeW0RDvDujDwjaSiSOtvp9xI5qrs84bNh2S5WlfXjKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkzwJ6vb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkzwJ6vb"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1183603f8f.3
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359485; x=1792964285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ND4jY7gR/2id1su0/sUkXoB5vhejImeMWjbtVx0rPoM=;
        b=OkzwJ6vbTgJFTfDbinZh7/8Qg1r7Vah7l9NWAoCMFd/WYHIPa436ahnEZrh1+ZSU17
         VdjCAQvqYasofxi6VK/lBevxsHOHRWMZ069nk0CPmNznTS8lByDCLmPeckZkbX8wzTUH
         LkCaOg8AsXk6afAvVWD3lf8M7fws/bL6WCw2qmED85yBHDebbb/EkvMDxJvpJBUKChoY
         J7a7eQxrGAXtf38SqjaPccVHnLcY+76+j6/oyZpQYK2XYMEjRgPCVKD6pe4ujLTQYtbd
         xN8N4vRamNGnbv6+cXwfRNbT+eLhP58D+r49JMQ3UhOktwSDgUVGDx/Z6neMidydMW69
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359485; x=1792964285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ND4jY7gR/2id1su0/sUkXoB5vhejImeMWjbtVx0rPoM=;
        b=dGKVhupTqTO5udeKQo9N1+MUBm0ggU4dzqJbtBbROk3phv4HygZ34j0cjHxT3Zj6uy
         4iQ69bO1MxQs8kGOQXqoyEwLDau8DxSH6VW5uHcU/6oFp4uvsm0ig/1SXM4rz/E+6gMl
         4n6fNnTygigQEzYh1/2gMa/pp5qGU0RmPgMdQe5HeLvozeBRPGopp2vMZUtWLe7DdZ2u
         oi2fsSB4qyXF+wgJNSQ+WDGhljWMtCKJkeI0p+Mha9VRSvD3UwMrvcD9YtHw40g7m3BS
         UPkp4KKIfKRMhzCA1By8SFXzUH5nrIEjeG6zGKBnfTTnS6jGfo+gNz9dsr5bZrRnkvTC
         zK6g==
X-Forwarded-Encrypted: i=1; AKwUvByGTszbQ+Y7LO0Xbd4DoYVallkDsZ2g9fxhpYkUGOp4nx5s7fRJ62BJvRBez6gHQ/hQby2Vnn8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkUG3s5SlYkU8AL9Cb8qPv0+PkdWeRuiPfGqnNQgxo/dDdemVD
	4i66zNZAFpZ3425693bZm1rQB+tiX5ZZHXMIUQGaxu7rlpyA4mfv0VQ=
X-Gm-Gg: AYBFou1AlTbXS4rHm/lh5Jp1Irdg2iTzXodlrAuqjBIRamfREQirrnFtODUwGQd69/3
	zoo7gHYfjZv6D2MwXn0n5NF5RLlwvmBFBMORcB3GlyDQh5u7fspNNV2XTJBDbddQtG7rWqmMh+Z
	MUxYbKcDcJ7fHruw8zK7RtuHM5P7Ls09n910+Z0XbNPZehyIDK3C610D6Pcv0bPGnISp8dgrfI5
	/mK8uxTGOvpm3CtckZ/lUpFx4Diz0lvSRrBmZpQFZYe/cc1ZecbXCorTkeaM1GXanjP5EuK333V
	udGnpNrpuL7vI7yNns9tTzcKthwgN1dWZiBxGfNJGk3e8di2Hdtq6NNEA+BjCIhuqCA41VSHN3k
	ocwwc8q4opBOQU8TG1PjqB1VX7+N41xfWRx5HH+srXBgDrZwyo8NcAvwqDAfRHrwhdaxz8oOHvf
	O/WffgjrQ/sNCHaH3BB/2O5dh2esh+5gKVSbvWTGg=
X-Received: by 2002:a05:6000:4381:b0:48c:6955:a603 with SMTP id ffacd0b85a97d-48e07bb5a24mr14227188f8f.13.1792359484958;
        Sun, 18 Oct 2026 14:38:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:38:02 -0700 (PDT)
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
Subject: [PATCH 2/8] HID: alps: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 21:37:47 +0000
Message-ID: <20261018213754.1951187-3-tristmd@gmail.com>
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

t4_raw_event() and u1_raw_event() access report data at various
offsets and cast the buffer to struct t4_input_report without
verifying that the buffer is large enough. Since hid-core invokes
raw_event before validating the report length in
hid_report_raw_event(), each driver callback must check the size
itself.

Add size validation:
 - t4_raw_event: require sizeof(struct t4_input_report)
 - u1_raw_event: require at least 2 bytes before the switch
 - U1_ABSOLUTE_REPORT_ID: require max_fingers * 5 + 5 for the
   per-finger contact array
 - U1_SP_ABSOLUTE_REPORT_ID: require 6 bytes for the coordinates

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-alps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 0556cb5645ebb..dee7d44d6f912 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -324,6 +324,10 @@ static int t4_raw_event(struct alps_dev *hdata, u8 *data, int size)
 
 	if (!data)
 		return 0;
+
+	if (size < sizeof(struct t4_input_report))
+		return 0;
+
 	for (i = 0; i < hdata->max_fingers; i++) {
 		x = p_report->contact[i].x_hi << 8 | p_report->contact[i].x_lo;
 		y = p_report->contact[i].y_hi << 8 | p_report->contact[i].y_lo;
@@ -363,6 +367,10 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 
 	if (!data)
 		return 0;
+
+	if (size < 2)
+		return 0;
+
 	switch (data[0]) {
 	case U1_MOUSE_REPORT_ID:
 		break;
@@ -370,6 +378,8 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		break;
 	case U1_ABSOLUTE_REPORT_ID:
 	case U1_ABSOLUTE_REPORT_ID_SECD:
+		if (size < hdata->max_fingers * 5 + 5)
+			return 0;
 		for (i = 0; i < hdata->max_fingers; i++) {
 			u8 *contact = &data[i * 5];
 
@@ -407,6 +417,8 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		return 1;
 
 	case U1_SP_ABSOLUTE_REPORT_ID:
+		if (size < 6)
+			return 0;
 		if (!hdata->input2)
 			return 0;
 		sp_x = get_unaligned_le16(data+2);
-- 
2.47.3

