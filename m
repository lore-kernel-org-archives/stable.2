Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B8396B73
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451091; cv=none; b=nsQ6pu2bJwryTguOKiNu5NJJH38z6i6TL55gn33EmfCtubcoJgLl0uT11rgxSxGnJOgtWyZuGlHE6R5zRJhCoJtRvTJLRJ9kBN9JF/GcOjFGCvCxlF+aK8aCqRj0n6IPKCbbBn9mZTYyb0R88I6Pjb1PymA2Fnvslatrvvs1zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451091; c=relaxed/simple;
	bh=xzeEhHEyQCRH9yR9joDMads1uaHmYunLiX/nHJEP0QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVP8wjyZhNpNFKh3QwwFrfVvXHif+iRPgCk6rx7cN1HXN72kI8r4YJThoyHTenDWK5y8cwrwQ/EsvKm6dIeM1FtAiGRBgp+tUJxBANKnmGEX4jBHK8/HZL0HHpxixN84t/MWM+AtNwG27bzWDS6UvebdjhPOoc9Es7KP4UatsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFQHoXli; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFQHoXli"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bc871ecdfso785139eec.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451089; x=1783055889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfyMoOrj1XhKeMiEVwgSjYoIFZP5QHNbRipRhkiiuRo=;
        b=AFQHoXli454V7cZcl+BG6hB+QvAWSTuMjcAEgTu+sjHXG+YKGVjC7s5ixKGwN3O2FZ
         /buHdbFyq/9aPzJjfGUgLzYghaIY0mU6766TgUSkUZWRLh8CJGYmj2so50ieAlg3t0hr
         0apV+X80Gyu7hOgU7NFSpmlZe18UDZwVBi8sumLFdCcaGAcTRdZUHVkvQbJnhyuJ80EQ
         g9CmG5ohCw2G0w7se8J72fuiRdlXbqaJb/BZ3PFGt402mwRXSdyMItKwyb1MN3zp5KlG
         +IeC8BP2MIvvQBM/e+5CZhNOejeNpqzt7EB287Ht0bTN9ZfFIrsMhWxtnh37W1/3zEHK
         X2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451089; x=1783055889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfyMoOrj1XhKeMiEVwgSjYoIFZP5QHNbRipRhkiiuRo=;
        b=qcTuCTWUQNlHUktfeq3aoOAQL2mpXH7Ml2E6+F16oYunflCoyNDPPdH3KyXAOFG+fw
         /rnP1Xwkr41dfK7pon1ZFv21jINVqXlihNg31K9s1Jx/V8b6wDfR8EiWdaPgGAIOJj3R
         UHxAW/vGKEZw2G3jLFKqMLFIaw5++MZH/EKyZShXGGvwwYFdqIde925CNL96LEUqldLH
         K3cr47ke6y6y3fgK1OHB793UICltl3OZWbflY8IiGXTDSNiyJIBAWY0AYZnzkLxhXA36
         9/+cjKQEmTIE5GaSLg9IKt7tbe33FYV3BCUjRj/M6G6X92cA7zI/o7VsDd4lLqbehZva
         ba9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpTIlpNgreP7Q+lZ1iqrLSZWYlFDFHyY9Zvbri/jIc3ls03WB24dQUpphZlZmlsdUkvHY0O9RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx371FFFiqT2lyvIe/bxn35NNyoGLjo1hfmTwkVCBeOVJZQka2X
	Tj1P6SBAUzO8otn2060QD+U6KSMRbDKZ+hnRpgcflHIXxWN76GwM5l9G
X-Gm-Gg: AfdE7cnheT9gqKAp3ATc85IJpTL605Mq9fy5GKyz5BD+9i4r3glFMLWE/1TKiE8Z8Cs
	fHuiwQg+cOA81qL5Ysxw0cATsRghCTsvjOoWWQOSBJDHlhr2HOq1F5j6c9SEXKrLJjPeeCHCHdB
	apgngMZ/s0hlKctQMa/+Fkt9JanKSO3RoXDRf5mShNjJdZOOqMbqF2vAqsIBDJ7YWLZ/XL+U+gq
	VP5W24L5ROqh4bt4DxSJGmJLaKgeGexwYgezUzzrioojwuMDPNcm80N90jorBpus2soEhQNCT5X
	1cB2OULBZ3FSmvyjtANHAM3TwCb2XTFPxOFtPYAn68PyeHhxsUPcu/IdX7apPA/hTy6YcJ5BF1y
	AnaTHD666XPphI/OJhbjUOPfyrISoPLNup3Drr8SA1vntVJu4zcAlJmw+HooWg7oKuqy+3DjdID
	pinZpPoU+DTLt70610H0Gjto7Gg78uy6beiEzL0dlNMTNkhIJ5BhBhgpqtUDi3RRTPLQcTb6Rjl
	V6sNrvirMPX+n0=
X-Received: by 2002:a05:7300:7246:b0:30c:5a5:df4f with SMTP id 5a478bee46e88-30c84eb9cf8mr6385940eec.16.1782451089397;
        Thu, 25 Jun 2026 22:18:09 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:08 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/10] Input: synaptics-rmi4 - bound the F54 report size to the allocated buffer
Date: Thu, 25 Jun 2026 22:17:52 -0700
Message-ID: <20260626051802.4033172-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

rmi_f54_work() reads a diagnostics report from the device into
f54->report_data, sizing the transfer with rmi_f54_get_report_size():

	report_size = rmi_f54_get_report_size(f54);
	...
	for (i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
		int size = min(F54_REPORT_DATA_SIZE, report_size - i);
		...
		rmi_read_block(.., f54->report_data + i, size);
	}

report_data is allocated once at probe from F54's own electrode counts
(array3_size(f54->num_tx_electrodes, f54->num_rx_electrodes, sizeof(u16))),
but rmi_f54_get_report_size() computes the size from
drv_data->num_*_electrodes when those are set, i.e. from the F55
function's electrode counts. Both counts come straight from device
queries (F54 and F55 each report up to 255 electrodes) and nothing
constrains the F55 counts to the F54 ones.

A malicious or malfunctioning RMI4 device that reports larger F55
electrode counts than its F54 counts makes report_size exceed the
allocation, so the read loop writes past report_data (and the V4L2
dequeue memcpy() then reads past it). On conforming hardware the F55
configured electrodes are a subset of the F54 physical electrodes, so
report_size never exceeds the buffer and well-behaved devices are
unaffected.

Record the allocation size and reject a report that does not fit,
mirroring the existing zero-size check.

Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 8eac320c43e3..75839a54656b 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -104,6 +104,7 @@ struct f54_data {
 
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
+	size_t max_report_size;
 	int report_size;
 
 	bool is_busy;
@@ -548,6 +549,13 @@ static void rmi_f54_work(struct work_struct *work)
 		goto out;     /* retry won't help */
 	}
 
+	if (report_size > f54->max_report_size) {
+		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+			report_size, f54->max_report_size);
+		error = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.
@@ -678,8 +686,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
 	rx = f54->num_rx_electrodes;
 	tx = f54->num_tx_electrodes;
-	f54->report_data = devm_kzalloc(&fn->dev,
-					array3_size(tx, rx, sizeof(u16)),
+	f54->max_report_size = array3_size(tx, rx, sizeof(u16));
+	f54->report_data = devm_kzalloc(&fn->dev, f54->max_report_size,
 					GFP_KERNEL);
 	if (f54->report_data == NULL)
 		return -ENOMEM;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

