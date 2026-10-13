Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DF52CCC2
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929396; cv=none; b=oA7dAl4kX5uN4v+7cgH+h56iaLecC9Z0qVL3z8o2BwD4M2XLUmNxkrmk6Q1ScJZRPItClS7u8MRap9bX34/qs6j8oCSliU/4UYdEjjf2pzCkKeJf2U5yT8SBnl7xEIxCHQtwJcEDOKnzTgNP3siWvUifI4DNC4k/UwCiJpaJrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929396; c=relaxed/simple;
	bh=A+I/86KdVa8jIDGYt6ApDmQiXDBusJSa5kMa1fb0xTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fc7D5wp9G1fUvuv8JYAb6XUxwUcnhCoK6qywzQHknG1O/cgiq76Kc0BULYn81mxmifY0x/Gpgl4dk1EONDi6OTd3sGl9xKZcOY/XsJfVDFU0t0dPD6y08QfEfPKnVi5yK3Mh3+ywbSQ+NIdP2+t+N+lCJ2qL8z3wsGi2mXJkyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG+uurgr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG+uurgr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so29895815e9.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791929393; x=1792534193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfkApeXinHFIr0p8vXlFlLyypuKINDLCCxfSgft0shY=;
        b=PG+uurgrSEY8V8KPX304bb97Q1o9WiXm8z6rFAs2Gbq/vov7r4+Yma3SAorp1/5mMC
         gP2/wOaV5Qh65+TOlUAabF0VVu9I3PgpgZ5rMz7i+LJuz90EKnFScCg2WjPhbY9lUdr6
         xDAFcCjh22wVwWfaCXhTSin9B5yiyzWYukAqDA/hR7mCDlGisDQLUIZzZ2BOx7e3Um1f
         RdInzVYtYieM5Hf2MLnAR6Mc9WsbT0XhmCd1Lmj+mHT3oUCJ/PuWIAc0fvPCGlsGTUmt
         6jeRhl79NlCYj/26iSZ/+utWLf8zegUbRs1gLH8m4Yi+jNOfiyWISEFwhPkIuHfsTM98
         Ef8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929393; x=1792534193;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SfkApeXinHFIr0p8vXlFlLyypuKINDLCCxfSgft0shY=;
        b=gHNW9pNa+7nUacw+G7DFHfpJziZ0GcyXYGjxa1E/7wj4uFA17wm/KJA5mhN0DD4Iu8
         NZQe06/q+Jy7HAHlQeoOLCSJXpitCH7w5empWQxTNnhQgDjByakADhdw0fvM9//Vp9D8
         B3Ygh4q08yCVrmwHNcRORC4D6OVu+UVETSZVOTbmgH9vLPUZPdjj0E6Zhu+omJXRhfx5
         jgQJUtQodKU3GPqjzRnWbLlCYBEr8kBMB6yzxmf11O7AumdwQAzYiodJD3PIYD6ToMr9
         zUCWC5Z8jSapCDq3pHijIEZzoX8UdwZb5ZBrZ+WfoKF4T146GHeXuJ/3rQkLA3tPIjMb
         vYNA==
X-Gm-Message-State: AFq9FYJNxwlXOW+kweXrtBQHLzVAXm46Hqtmn9YN8i1pZ10eaTMFzpkx
	aA2rC6mVTuN0vA9IkVASIhMJzjzjfbGRK60GS337FTDgHb/xg76yW5fAEcZBOA==
X-Gm-Gg: AYBFou2JassMScT3/DU7cuqs6fcLuUIwfZXeSsX7UbWpcTyeUiVohqo0PAl4aqJZSKo
	7vTWQLPwFIc/ns4tHnxSMwKEnpXpfd5U7XY76w/9hF6UGGlfADjuI179Sw1z13ym7Qnhn7mUo0J
	xkn3ZTd1GCXPLWDv5s/gi5FiJqrFZEGuMpB/86Ys0WUOIZd1s+r3qWTWwbindTyQElbpR1ATCg5
	Jsp7sz3kbqa3lTN8uG2Ehjs//9zs26i+Kqz44QPABiGxu/HMFaZRT/rxN4Chf6qPiPVGUfhSGr3
	bjilHhKEo5bPCD/boYWqtzRM4mlTKbaxeWjagxqIRntzQ8IPDbrICcvG4CWjws4xFbEFkZJFIIS
	u7ZjO5pyZC5NHo3IoEJRw5vDn6BoqMGIydHxUA9QmcTYrMpY1DWvzee/UY1Xh0We48LBr6+P//i
	UUkChduqw+alOqk87Q85jIU8fgzy4pSgc2fkRTybOWvtIu0S3uKb6NDW++OZWny4T5wcbWhCg7R
	qslQVmHP4oThLuHmqfwZ42k2vd3OWqTA0y+bsXaFWkLED/wSEwNhHHsQslaAyXQ73+sRXGyVfAn
	F1lDHTfnh9/LNEfuK/fdIyKhY7DpZwD7rpnPf9HM35aeV5mbGDwz2mVkNn2rVGNmaCVkGH/T1Tv
	kDUEyRN4LVuybE8lgRuU31lZMsVkx0IX6CztpCEeFJLPmhgRpzKq+GBP3Ylu2Ykdrdu1nPNHC9N
	cDJpopKKsLgwgy6A==
X-Received: by 2002:a05:600c:3494:b0:4a0:bc9:28c6 with SMTP id 5b1f17b1804b1-4a18e4fb31emr282819135e9.34.1791929393347;
        Tue, 13 Oct 2026 15:09:53 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:412d:e9fb:680d:a947:4b50:d9e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4b8a184sm3916595e9.2.2026.10.13.15.09.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 15:09:52 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: olivier.kaloudoff@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] usb: uas: validate status URB length before parsing the IU
Date: Wed, 14 Oct 2026 00:09:51 +0200
Message-ID: <20261013220951.37119-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uas_stat_cmplt() dereferences iu->tag without verifying that the
status URB actually carried a full IU header.  The transfer buffer is
a freshly-zeroed sense_iu, so a status URB that completes
successfully but with a short or empty actual_length — observed in
the wild during link-level upsets (Thunderbolt-chain xhci blips) and
on a wedging bridge — reads back as iu_id=0/tag=0 and produces the
misleading

  stat urb: no pending cmd for uas-tag 0

log spam seen e.g. on an ASMT135x enclosure and a Samsung T7, right
before the affected commands time out into the error handler.

Beyond the noise, a short packet that happens to carry a
plausible-looking header could be matched to an inflight command and
drive the state machine off garbage.  Bail out on anything shorter
than a full struct iu.

Cc: stable@vger.kernel.org
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
 drivers/usb/storage/uas.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 265162981269..88fed50c262b 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -315,6 +315,13 @@ static void uas_stat_cmplt(struct urb *urb)
 		goto bail;
 	}
 
+	if (urb->actual_length < sizeof(struct iu)) {
+		dev_err(&urb->dev->dev,
+			"stat urb: short transfer (%u bytes)\n",
+			urb->actual_length);
+		goto bail;
+	}
+
 	idx = be16_to_cpup(&iu->tag) - 1;
 
 	spin_lock_irqsave(&devinfo->lock, flags);
-- 
2.47.3

