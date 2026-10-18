Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88244DEC08
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361031; cv=none; b=aBC3G7SCX7wKilNst5YwWMImVbzrHTFofmCYm7Y1DqLDZtEtOPQ2519rQ8kD90i9kvTA/OXWw/lFptpu0oQQq7Oc3zccselYU4qb9wJowmRIk3f35OypD87NAd8Y+H3xSBoXfs5UNrSQw7oQCyLe5j7C/OuoOaSpx9qEs7pxNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361031; c=relaxed/simple;
	bh=dW6xBILNqkpo8zXCsLaeG8JRBTf2Q4GSQgKmqSah7q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wytqn7oS9pYDppsWlkMJ2lskjk8xlOFYURN46xK1GU4JFwL+Pw/1NnZpLSWIpxxLoePFCbWlpGLdM95M57twsTpIEnkdfMj8HsmoPr4CjrB/1GvZyCJy2T0A/8nF4s7KftDvea9rLCrbVZr+HjA1KcBdzm1vRu18eyYBdy+29aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXAorKUE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXAorKUE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso17638285e9.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361028; x=1792965828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2fR+1b4kJibeyl2fj356rb4lE4NTLbBxglsbLkbIJM=;
        b=CXAorKUExN1WON/xj0LqHpukowZDd/kNzYnqnkkxW/oygDxygKDPTLCHaAeuRcql6E
         DlwWL3ABD6D5xxu+VcuhCBATBzMsRggbHHWp+klp3lAi2uLcIhQTJnoZ1LMuVddzg+lG
         eJwE5qy2aatWySaOW50ZQpA3LUiYZjTtYi0w4Z5NSbSUYyaTu6qwMo5j4LY/zie8rYNG
         ONw2Q44RYK6+cASQs0YrqTCXSCMb/Y9QDAfcFrc0n0ZpZept+QXX/TOph5noplgPhWZX
         tFvFPK82EnLskv1MW7BBHI/q31moqVfV6l4G+QxqBO3Z5YOTLrqYWHA9JydPs4NgZJYI
         UtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361028; x=1792965828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2fR+1b4kJibeyl2fj356rb4lE4NTLbBxglsbLkbIJM=;
        b=MViiB4f07TUklhgkFbPlQOjtbq/ot+f7rXG1AibxpLpK/V26C6LFU23kcTCz1JRwdT
         OJ2JxFZD/GLoSTBhzdT+Xzo19O56hKAiBPZCB8ujCSpEwfEKIvweQUeTCGMyIFdF1w8z
         yyaqzHypxs6J550eFdl1u9wzYsXkO/8PRQ37Buaw/IAStyCgCoLKD0iTq0UBUj3fZZWq
         8cInZftHwC+53iNGBqy5z60gPlp1+a72hvCa14bu/DWFH8pn26PqSFfBKYrmcKYuYCSP
         MEQjrfeic8thdr0a4z0JoJN2X5ImA/1Gof8nxnasBdVWO/Gg12vtvlBzOv/zjaFEgh4F
         9AXg==
X-Forwarded-Encrypted: i=1; AKwUvByaKfVa+sjMGACslueL9KzwjUqHDaXCQbzhO/xjWAWqfEdGWbfldzboPPw3CmxwQcR676c5EuY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo/YMq+23dL6dISCaV9Da+sEC9030Q5/zv/UveQYe9g/oFA4xM
	QOCLY/MdwY9UsA/pECW9/4816JvMVsDvV1tIDgBEXxtMTqQdBui11GYParKe
X-Gm-Gg: AYBFou1Xox2+6sQyCp6mft7zJQDq+YBeQ66ykc5ixbtJXtWyppmBZu28gvrJxB9cQ+c
	4/2GFnAcGTQKAkqgpczV9RJky+se0BRSPp03nlCzvtQL2Y8ekgYnIbOyaml0thM4lYzLyp0MVVI
	ZuW5mlKMHk1UgFrwfQxC3SllDzT1R24oFMJQHRYPxYwVvc2tiUl1p2PuGIg12Kg472Jps1bTLJs
	wRgySuQwdXc0aJ1a2nPtc+uCrlRpxTG/jwjbAyVtR4osVHvyzR5I3s+WiifV3tkLf10BdUF9x0h
	mmoSwp+1BfXDWjwc0neetPnFN1x35/xqJIRgCq9b0+Mqi1tjmElj4OJURp44tbKDwBN/u62/eQF
	dlL76gr+RUfz4PgOtEf+mD9tr7ekZRPOdaaIOfvcWUSDDtoLudc4Y92U9rYVEWUcLOu+1f51s1u
	sNP+bK5Ez3fTRH+qabEE+P7g0lS++waouhD8N/8Zc=
X-Received: by 2002:a05:600c:3484:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1d7605e04mr127158785e9.14.1792361027726;
        Sun, 18 Oct 2026 15:03:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:46 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/8] HID: alps: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 22:03:38 +0000
Message-ID: <20261018220344.1987142-3-tristmd@gmail.com>
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

t4_raw_event() and u1_raw_event() access report data at various
offsets and cast the buffer to struct t4_input_report without
verifying that the buffer is large enough. Since hid-core invokes
raw_event before validating the report length in
hid_report_raw_event(), each driver callback must check the size
itself.

Add size validation:
 - t4_raw_event: require sizeof(struct t4_input_report)
 - u1_raw_event: require at least 2 bytes before the switch
 - U1_ABSOLUTE_REPORT_ID: require max_fingers * 5 + 3 for the
   per-finger contact array (last byte accessed is contact[7] at
   data[max_fingers * 5 + 2])
 - U1_SP_ABSOLUTE_REPORT_ID: require 6 bytes for the coordinates

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-alps.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 0556cb5645ebb..d984100093f6e 100644
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
+		if (size < hdata->max_fingers * 5 + 3)
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

