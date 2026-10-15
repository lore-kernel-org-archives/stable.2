Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A273DC4D0
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031285; cv=none; b=gr5sCh/JQTU9n1wzIgFYyolMbvBk07ydOs8Jonkk0zrQoDuK3XwuvT3GA8yTfXBzjddQ621gAerTQO6Pi3YL83qRXhY/c1mijb5WS4ggQjRPCmo7FCb8REuEpzSyGlMQlE3ts1s8VbMEueW07Oxjn6CeqobUVmfV0PXSZuQLBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031285; c=relaxed/simple;
	bh=DvmUcdBGk9Ip3K6aMNLyTsmPzHjEV1WQkSgWvFOcyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrlFgbZxxni67iK7xxEdR6Hru7jxeuPxQz3/KWlI80rQnW98J8zZI7cb5vSudyuOwP/9+w2EQc3EFJIHxBv/I6jxRFuNz4PL/yQnckOYqBtpYz1IdEn7ewrMmckK1fGeSQX+spBm0UBBLTHP9tsPpE97B+KjgadPHcyj/NGPBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=kLawuoei; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="kLawuoei"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so3252692a12.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792031281; x=1792636081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vTCBryNCZePgMXjmqfRG2WB7QhMRd9mrUtZ7pw310o=;
        b=kLawuoeinR4ABznzjO0d0pclVNPlXik1S0VbFxyOJXF6c+k2JanZU078D0O5v3l8k6
         zEioVKftzO++gWuBtJQKMw2/YPbeevTfAlNqvLr4NH3hlhBoTxDFpzyxjEYewLsrB87I
         z9m0BU9gm1hluEHYTuc50lut0Dkp0ng2jMaSN6dRMl+M+2DsCljhmuZx9fK7aR7ZWW1m
         dESuFrObeRdMoOEdUR3PlzDMliOmZtdCfXaG+d4BnIzsI5cRyD6EVJ8ci2f27TQzZ6OG
         YX9+GRW8pbKiLIXag2bIguVKOMWAIbULA7+kMTsu8QFx02kTOX8aTmHTQBSCPRWmOHmP
         TLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031281; x=1792636081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vTCBryNCZePgMXjmqfRG2WB7QhMRd9mrUtZ7pw310o=;
        b=TFBWO9HT5QtZTI2o2716gKH/xNTZftUY/rdeeCEhNFSWVPL8x+AyfYNY3QDvKp1Xzf
         uHgeFvAQM9I4QnlWQ1kiCyi7y59catmiAZ6FGwIxCKTOFHp52fHg7fbxrO7qkYSzIVxe
         +BT0e0bqBlOmFAH27jYMqM2ZSjZ9+gZQ2F+JpI+hffYbp7RfMu6QuN5I6gYAx8jEH69H
         ADOyyVSzFZhCcVliQQ9zP7xIQbfAMYO176DVYMq5s+GVoicLyoyZE6qLTNXWIAptW1uw
         f/UReU02MGPvPZpGPWutSkxTjovN7VRhkQpulcN3vpqeecJkM4fnNAFgAloKqd3/8FUL
         hSww==
X-Forwarded-Encrypted: i=1; AKwUvBzCiK/MqqY0aFS4SxZi2IbZwN/kJhwld0CKmNMrNj65Os6Hk15M74zh2FcjVlKW+u9E2DgxvUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFt9m6zl/DSNLrUDaIONo/LEUsT+QEWYZPtLqyKl9LJ8V/0fKR
	RTOB08M/Lm/sv6F6SjbZyOLOQDiov+g64zMv8wTOv/azHZaGyV9VMlnYJNfvR/D/axQ=
X-Gm-Gg: AYBFou1JPMUBzzgGgSbFWJj3kURVhinLpWlIMf77TGhGp4FkE0+d+H5l1+ClcM3WJpA
	p85Y1uP1hl1eygHaK7tAuO3JJoBsSSLCUsJF8YCPSJnhyeQzHBKTLjYHW8KNGLfnMebwu6gWHiG
	ijjZXnjpuvRexwfaBFaGyh8mgzJ7cxHwdR/DynynJSeqe8VPtn149M7tnEa9mCtBZq3aKe8cM0W
	ogotyPeKrHU4tj55mPhtSDsNq1IE+zd9BK6FrMLVhtV4OAh6IKt71CJBD4Rfw8kqQJyxnR8C3xs
	AtHG6ao1SGBqjHzP6DlpNVADBY6XZ8sD0gqNC/ZNBgmyHAd3a7jlr9MDih/FqVGYM7b525GeqQF
	bNsAWyLC56mIZSM2PmxAC42REAsNM4dD2X1/zVdorgJ+csjaNLUuuvLprbHcbiMeKTSGeAXnXQd
	TQgqSrTM2i/gtS2FBWmwmqLpmoI2K+4IM/zUYejJAHDhaC9wiN9lm1kSsjU5qchKhw9zkJPlVbG
	bSuYg==
X-Received: by 2002:a17:90b:4e8b:b0:3ab:be66:ddd3 with SMTP id 98e67ed59e1d1-3abbe66dfa9mr7610333a91.32.1792031281033;
        Wed, 14 Oct 2026 19:28:01 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94375f3fsm1997383a91.4.2026.10.14.19.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:28:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: "Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH v8 8/8] scsi: mvumi: stamp a consumed outbound list entry out of range
Date: Thu, 15 Oct 2026 11:27:28 +0900
Message-ID: <20261015022728.3936714-9-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
References: <20261015022728.3936714-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mvumi_receive_ob_list_entry() copies a completion out of the outbound
list and then writes 0xff over the tag, so that the entry is rejected if
the firmware's copy pointer brings the driver back to it.  The comment
right above the checks says why that can happen: "Copy pointer may point
to entry in outbound list before entry has valid data".

Nothing ever compares a tag against 0xff.  The only test for a usable
entry is

	tag >= mhba->tag_pool.size

and tag_pool.size is mhba->max_io, which the firmware supplies in the u16
max_io_support.  As soon as the firmware asks for more than 255 commands,
0xff is a tag in range and tag_cmd[255] can hold a live command, so a
stale consumed entry is no longer turned away by its tag.

What happens next depends on the controller.  Where request_id_enabled is
set, mvumi_check_ob_frame() still compares the request_id left in the
entry and rejects the frame.  Where it is not set, and the MV9580 case in
mvumi_init_fw() never sets it, that comparison is skipped, so the entry
passes, is copied, and completes whichever command owns tag 255 with the
bytes of an older completion.

The tag field is a u16 and tag_pool.size is an unsigned short, so 0xffff
is >= every value the bound can take and is never a valid tag.  Stamp
that instead.  The store is the same width it was.

Fixes: f0c568a478f0 ("[SCSI] mvumi: Add Marvell UMI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/scsi/mvumi.c | 2 +-
 drivers/scsi/mvumi.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index bd1a8c1d54aeb..67a6bb6536950 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -571,7 +571,7 @@ static void mvumi_receive_ob_list_entry(struct mvumi_hba *mhba)
 		}
 
 		memcpy(ob_data->data, p_outb_frame, mhba->ob_max_size);
-		p_outb_frame->tag = 0xff;
+		p_outb_frame->tag = MVUMI_TAG_CONSUMED;
 
 		list_add_tail(&ob_data->list, &mhba->free_ob_list);
 	}
diff --git a/drivers/scsi/mvumi.h b/drivers/scsi/mvumi.h
index d20eea2b61a31..f69a0807100c3 100644
--- a/drivers/scsi/mvumi.h
+++ b/drivers/scsi/mvumi.h
@@ -133,6 +133,12 @@ enum {
  */
 #define MVUMI_MAX_TARGET_ID		255
 
+/*
+ * Stamped into a consumed outbound list entry.  A valid tag is below
+ * tag_pool.size, which is a u16, so the largest u16 is never one.
+ */
+#define MVUMI_TAG_CONSUMED		0xffff
+
 #define DEVICE_OFFLINE	0
 #define DEVICE_ONLINE	1
 
-- 
2.43.0

