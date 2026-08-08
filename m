Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE661A683A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786153563; cv=none; b=eDtGf0iyaByVErO0yS4SHudNf9Pz1p3xR2bBawVYTp64EnUMKzwY2IMIYxs9VYxGo8FMd+GPivV3OOz4q4xgflywxJDk6p/6SQSEUYiFxZnA+XwY/cYsTC1xrW6RDXL05sR3Lt1b1KGNPFn2etzzi7HLXfk//Js85Zk1cp33wuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786153563; c=relaxed/simple;
	bh=jiYwrHfPMJZupGhgemLkbnAXfR4F0oA1drlrs7PD6eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaMqhIwgMiHcqs27UBve8IUfh0A04tMxfxgX+sY0RJh5DyoiR5ANgwWy+xR960f2xO9DyApPqmsgwfxFUT3EKnjc20jv19QRM54OVkrU7qZV1lGuk2Pg1/IvGnJ8rfJofczJtvAfc69V6p+mk+VXpzK6n5sxym9Q5g0QErzGEW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQFSBdRz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQFSBdRz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so2378136a91.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786153561; x=1786758361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1jzH3wz8al5H3PLnRo3rqNbon9VQ+SF4VfOzTEMOvxE=;
        b=fQFSBdRz45bgahmUZaOTFVnS9vRsJDseTt5dZSzEtEvog5Ek7CMBA0lvjMmGnLmlwy
         hhYJEYYJIugLtgB4dASuet5m0CS7bwgbMDmOW6yDayCy33vtYs7rK6Cl7neYTcHwrZEK
         N4n/pAfvDjY9mtdNl2i0J1ro0uWaVqt9+hHSs/k2LKY2AVgAuVwba3dt5SiBQPK3AVMM
         jHL+R/uzUHg0Iz1m6qd3hjUHQSmltyx7wbd5VxWSeEj99oZo10YzoisSCmgY0QI5WaCu
         97Xm0v4hksI9pFBDetrGK0NZ5XlkoAEUi7xfN3R023VGdVTZ5EWokOLedAjtTx5/s/X1
         aUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786153561; x=1786758361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1jzH3wz8al5H3PLnRo3rqNbon9VQ+SF4VfOzTEMOvxE=;
        b=BcfzNXYsJOnn/Peocpbmv9v28PLz1iN8Jgpqkhz63pzrED2/3tjRCMcqQgd29k+tI8
         icV2QA2qsWwHXvhAPLpM6qAjlNfWstTgImCQJPQlSWhWPLY4Z35IQ4IrGX1MNXyd+Cn1
         AdED/WKMFDumkOC7MAp+SYTYIVICoOOpTMh2GbBxspuHCZ3q+0dZMbM5cJUMI2zqVhaN
         2S/eBaqwXsV9q48pIKmXwfQxHdQawESBpfn2QSm36GiA2WQor1/KdgYNO5cua9JEdNaS
         4Y5Y1qZTgT9X1QAzS25vr+cgpivM0ewUBbfZdLJVYoZox7SwYEa57u550Gtilv5dyeau
         rRUg==
X-Forwarded-Encrypted: i=1; AHgh+Rqw3d4iLt4Jyq2nJg8KiWfb1D/Hlavm7kPTG9JPKJPpkTZ+HB8HIdk52unvl3R0U3KeqgAupBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYM/EKNODU46/cpvP8yhSI4FF5HtYr1RAwv1qZR18iR/an6DF
	o31DYrNYFT9ECbUnYjOMei8uxTnFmmcdV4Exrg/pUQ5AVt90Lauqt62k5bWgp02zOZs=
X-Gm-Gg: AR+sD12IWBS8ELPLC+1fMVZUG+zn6C2RxmQRNJfxL/OjMjRYBxtur8Pxg6zaUS8JBBw
	UW0/7QJTXHRGPT9hzbx9L0S+zhM/JBaEtsiyut1TEm/N3qNLvTFq5YOq/kdtwpVlo9h/WC62ihB
	xe7kEG2ADqC/4c0HTqUIC5rn2i52mMTwtNKjt91xDWxoYHP3e13M/Vj7jbh8aZO0TwmyZssZOcj
	A/qT1iOfZHDYr4EY4EN/FVwG8krtqoQcg5gNCZnfTjRrvgOPkg387io0vTlRJWChMcOi8obkT8r
	t9DcWlxiH1COBVXCY1F3k7micGMyVVmHShNvgZVvEBuGLCJXgMjNx3fktwxaYLucp8aHjn9/qx7
	WIs9oiqWQ02WR8FXiZUej4OyVf4fAJElnXgKmLkvBRRN62y3vRRnGV+sWq7ddIPkYgORwI6Ml/O
	blE4Vo6wjiB6k21/BwLQqJryK6vb/T3mcdgCC3hoh61uB93fvx8VNc8H7cOXXT2t33LGND0tQN4
	fO3l/T5TXDG0Bg2xrDZFq3uz8cedcqA8FFgXUJ39dwZxLSwNXjIIQ==
X-Received: by 2002:a17:90b:3eca:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-392846ac637mr1213667a91.13.1786153561263;
        Fri, 07 Aug 2026 18:46:01 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f5e33fsm6697806a91.14.2026.08.07.18.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 18:45:59 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: ump: Fix corrupted data bytes at MIDI 1.0 SysEx to UMP conversion
Date: Sat,  8 Aug 2026 10:45:54 +0900
Message-ID: <20260808014554.3550153-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cvt_legacy_sysex_to_ump() initialises only the first word of the
output packet and ORs the data bytes into it.  The second word is left
alone, and the conversion context is kept across calls, so it still
carries the previous packet's bytes.  Those stale bits corrupt the new
data.  Any SysEx longer than six data bytes is affected.

A SysEx with the twelve data bytes 01..0c comes out as:

  30160102 03040506
  30260708 0b0e0f0e

The second packet declares six data bytes and four of them are wrong,
inside the declared length.

The sibling cvt_legacy_cmd_to_ump() already clears the second word.  Do
the same here.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 sound/core/ump_convert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index 0fe13d031656..85cc67de6330 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -258,6 +258,7 @@ static int cvt_legacy_sysex_to_ump(struct ump_cvt_to_ump *cvt,
 	else
 		status = UMP_SYSEX_STATUS_CONTINUE;
 	*data = ump_compose(UMP_MSG_TYPE_DATA, group, status, cvt->len);
+	data[1] = 0;
 	offset = 8;
 	for (i = 0; i < cvt->len; i++) {
 		*data |= cvt->buf[i] << offset;
-- 
2.43.0

