Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5133E345
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319857; cv=none; b=fTzcB6IpwXt6vuadEwFRwzAsohaVZ333w5EA+D/7KIH/9Hp01X3kII7CdMs7ibPoAFVyTMC/ts5IaFFY3jJux1h11U2pzLnAauPMv7VZjkIFPnkhoqTuBep5UEnOkA+vjI5eT3O6G0AuAOm7qGL8Ai7nqrk/5xSib16hXaK6x2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319857; c=relaxed/simple;
	bh=VIGO6DGsEkOu/UJJxuvGP6NIDvkxqmeSyOcYk+gkWo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnN9OF+Ddri8P+2+wIRQlucSN9PVL0d7vtCeZGnLVwIgrVeHoIHixKAb2V4d4EFXFa+yZQFsK04A8bLIN1TV97R8y+ueFIITqsh5RGu3m0GD0SisIQfOre/kHi++lQaQQ9waFNlMxhBUnuq6Lf1MckwGBvVec7HXwiEbvV/x7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j97+QvCy; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j97+QvCy"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97bf90f4b41so277376241.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 20:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788319854; x=1788924654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXNFQ3gLjer5xNcb0OpQhe/yIgTct7Qu/iF0tp3Lcek=;
        b=j97+QvCy4Ynm01tJsd4qoMEqbYCu30/kQkcT6ttBSmsOe8CjvucMvI0tAwufParX+P
         87AtlizOD4pTspb4xlbeFbd7+M25p7Vx5BvsrXfI1f4hM9gkZ5U75b8mxXFQcMKv+nUo
         aQQOIjQueVgs24m3ak5vaT/kY90XhT9C16h/Ur/BuHc3+yyWdK2O01BRZ7elAvsr0ZXY
         qAPOnjRU9N+wNBoYmprfnOjZm0dSkxzlT6GDBc+c9HTguzEky7hBeP1nHpj51EsL6nVX
         TcITm5/uQPsk49DmlL6CM6nuc7Nab/tfOR7rxX6BAgvoPOygHQlJZoYyYt5QFeWAw2Hy
         +m6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788319854; x=1788924654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXNFQ3gLjer5xNcb0OpQhe/yIgTct7Qu/iF0tp3Lcek=;
        b=JZp2RsooziFUJ7gqykDql+gDkT8wAzuuKi9RGGXdVRzJaqioS9MnDj6VPP80yO4w34
         rdoz54LE9pGJRN4XLNrSGeG03T/chlkqq+PUOEXu0TgDI6hFIutcmBXMpUT+dsyWXu1T
         l7Hzm+q4bMQv08nYODpTAXQsccN2aMd9ADVlLriTrPOTya4llmMbXIXK6KMHAjMBPx+x
         1MTJvOokLM4d7OXumTtm9SRc/gGGxwn1oV9+5JXJqc/FLj3nu9yzOyAg28VyVqRM3S1+
         z9AEV58pK4fIPftCjDDtkXdz0AGXpqGUqaaI1XWoSVwRQKcdQRtid1Eccxm95x8p/eBf
         dZ+A==
X-Forwarded-Encrypted: i=1; AKwUvByjaulZCvzWaFQTwffWoE18xiOdA+xx0lSEub6c9Qq4avLx0KFH4Tas8ErChOiY9KEv3TDG+xA=@vger.kernel.org
X-Gm-Message-State: AFuF++nSnf711z/bvXkCr0SEG8NCDFT5sgSIn6HQF/ncIBzibD1g5L7b
	yCX5yAXiKaQ2qKobiS9o46kDnitJUf5ugxYs4Hj4KXpCkOL0XbVfhCAC
X-Gm-Gg: AYBFou2JE7exAg/ltxWtx2H/EsUlPWyaoZ7B0wxg+sKyEnChXoK3lC9GzK2WqAX0dZw
	HxTcZ9J03ctOzQRUiIW1tCK9q9pVfnEZJQBy7P7Nbgcj7apaeJ2y9JTASfCTaV10Kfp/icDLpLk
	TVJIBCDvIiseKd5TLEvNJL74opviwtOVR9vTgR3M9NygJKDTpilWqic+ASGHNzExIu/o2r1SSqN
	G/m2aCZ1E2Hh+OTs0WFbOimhObctfevkLKxTzD/rk50008IQo7LtdNhBodgDFZb90g8wwrAHpwO
	4fu3a0pWYLl1QIlQfDJGPLuG9Y5q7VnwbQnukTC7x+ZsBakB3Q2qAJ/KjDbDqRtuPLLK1FcqtU9
	0noIIV7RKfRMZ5hOxIm1ZAXslwfUQjX5Iayudc50AjWzTX/rkAcWvl6ChzO9u1QnM7KPqjDerJE
	5eSH70hB6sf+GgeSk4oeuoY5Y7Cw+iAaTdH417EIse+j5pEoBIDvFQ
X-Received: by 2002:a05:6102:570c:b0:785:10ea:be93 with SMTP id ada2fe7eead31-78a1f230b0emr760581137.4.1788319854364;
        Tue, 01 Sep 2026 20:30:54 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980672f9fc1sm1384076241.7.2026.09.01.20.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:30:53 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: johan@kernel.org
Cc: elder@kernel.org,
	gregkh@linuxfoundation.org,
	greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] greybus: operation: fix out-of-bounds write in message allocation
Date: Tue,  1 Sep 2026 23:30:16 -0400
Message-ID: <20260902033017.40290-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The incoming message size from the device header (header.size) is
trusted without checking that it is at least the size of the message
header itself, but a value smaller than sizeof(struct gb_operation_msg_hdr)
underflows request_size in gb_operation_create_incoming(), wraps around
in gb_operation_message_alloc(), and results in a tiny buffer that is
then written past its end in gb_operation_message_init().

Reject undersized messages before parsing the message header.

Fixes: d37b1db13f8b ("greybus: refactor gb_connection_recv()")
Reported-by: syzbot+2fd6aefc361af86911d5@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=2fd6aefc361af86911d5
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/greybus/operation.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index 7e12ffb2dd..df6daee4fb 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -1047,6 +1047,14 @@ void gb_connection_recv(struct gb_connection *connection,
 	/* Use memcpy as data may be unaligned */
 	memcpy(&header, data, sizeof(header));
 	msg_size = le16_to_cpu(header.size);
+	if (msg_size < sizeof(header)) {
+		dev_err_ratelimited(dev,
+				    "%s: malformed message 0x%04x of type 0x%02x received (%zu < %zu)\n",
+				    connection->name,
+				    le16_to_cpu(header.operation_id),
+				    header.type, msg_size, sizeof(header));
+		return;
+	}
 	if (size < msg_size) {
 		dev_err_ratelimited(dev,
 				    "%s: incomplete message 0x%04x of type 0x%02x received (%zu < %zu)\n",
-- 
2.51.0

