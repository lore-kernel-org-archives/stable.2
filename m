Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618083B3C10
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237064; cv=none; b=cntv8M44RLKA+dvpdmve8iujYUdxjLATdYvfk5lS7OlXHPiXvt3T35FYEFOIsDB275Ob2CQRpWOl5bK1rh2eznO/OlvnCpGuznHV1Ptod2IdosiIRvVdPc9AaqbMU4Mi5a9OcLFfCCLmPtgP6oq26fv2GAfUnA5LRo3tjsp4dFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237064; c=relaxed/simple;
	bh=gB3IJPb41ILYd1ANxuKa+w2aDpu+3BOtrBUYsA0T0dY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pSQmGKCXC/ppjgVWE6zbJcFemYCgKjtR+FMJqA2Fk0NknubGJs/Rf/fd9wO01BcapdEmWsK2Z0o/8BhLcrbFBLysqPk+SaCXSQWT3gLujhg9NpRyxPQrc1vh9F0uXFe3xcb6ozCf07JI0kFY2a0MXpLYVvAHbix3alwTYJ2SVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRIegguk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRIegguk"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-87f4e914a45so19159087b3.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789237061; x=1789841861; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gMFdBSy0/cG28Pemkxb5ONj7tl7XaonyzdcIq1lfkGw=;
        b=bRIegguk6ivvwGiytmO5S+VXB4VZgMtwbHQ44NIDd40vbCM+qsIrMCRsLTdkREQPKp
         2xSceL5UbDRIbRsvshq7WfdGnKlNmuHvDRAsrQCkKxdBCpCutEQSNZz5lQG4vNG+HCSA
         B+fGjbuVfjqt0hEt7upwx5C3lqWTJxvoJ1O857x1e/w60b7OIno+vaPe3SjuuuNaYKun
         WtzctRddB2GLIEy7vmmPd77P6dWjaUDVhkpfG9rTlGPv/FaCjayYHfbwnmOdpeWv0bak
         M+OA7wpR1BgwoaOzHoQfpG2SOm+NiqGGn9+hTi51b0dKn1m5RmWg/1b+2plOhU7D+D94
         X+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789237061; x=1789841861;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gMFdBSy0/cG28Pemkxb5ONj7tl7XaonyzdcIq1lfkGw=;
        b=X+qSiGbc1OvqMxLDTe5Nr7DEyhqwaZ7/sJMYxu70y+xZ1TmfHC/Qfbv+XwAi2lJQa9
         K4sIJevU8EraevrGMqGT5axjQ0+gpeQpnjCIAn8QjZVFXP6bnxA3w9fkG/M60ynqH82W
         zPF2fzJuMMF9Bi/WOH/xOuh+9O3DDgQovfman2CNPJypujALZScQFubULUpL6tJIJMI4
         1kGZMrwPWY+O5CR3JIc7qD9S2D6WfAvhsm3QF7WKmS8QFuj8IMRXE4CbGX2HH7JujXfP
         fnRfo/CCAAzFP452apq4RZnNGiqv1Tl2bQrRsgFod9ICYpbH4ArucGMtHw1bW6y79qQM
         lmcw==
X-Forwarded-Encrypted: i=1; AKwUvBx3hPzNx0+08Of07Hip0yc3RThykfGQv2t9a3OJnTW+LqOp87vgQRqsIkfGaV8dvqB/dK8Ryow=@vger.kernel.org
X-Gm-Message-State: AFuF++ksjKpMb4aNnA2VELK0VD+7gVypMn/waOuKKgD66MG12Z3sNPy0
	kckgmZ6Az3mJVAtQMAPCEL1VlTDZBaj7IEV9WlnlOeREa+RnTOAIaEIz
X-Gm-Gg: AYBFou1WkDmFx+/JUUVo6nyy7R9B05e449D/bfNWsGnPI4lniDRKSZKVuzPM/td2/6J
	tVKPcIQyh9Ksrib05/qpjuwuab8PoxRCaNymFkZQ/vS5xR9bL6CGnzt1t4XjZcPdTTIg6auOEG8
	m2nh9KSkDHk0e7/OWW2AQisNds22Dmm0m869LDg0wyO5axxjeudICwSpVrAijUMeZs/cHwu6T78
	+OWxGoOYRkGVj4LBNmyG1sM1yIK1mW8hOyNYG+G0GyNE4KSCqv6F/3AQFZwT0L//lBsY/deKeTe
	yHXg+6CLS8tpLwYJ0ii/eQc2lJHL5oZO9Kx9yXGygQLZdUFnNDVxn3KgiiOuf5aFCC4rTzHcdKY
	PIETtUIOjKD57oNPu0/MDWTo8TFWARJzlhShP67Sx4suofWe05DMcTM/kqHiPUmaq5E0H+C3IZ/
	jGXPPV9wnpJWgrioSdC8obBlj1gVQiLIdwYeQEab7A/yrISbf8rtKCCD5V98iez02xJlqPJaE=
X-Received: by 2002:a05:690c:60c7:b0:877:6e47:19ab with SMTP id 00721157ae682-884b08b7101mr33301167b3.30.1789237056468;
        Sat, 12 Sep 2026 11:17:36 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea993asm22097277b3.33.2026.09.12.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:17:35 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 12 Sep 2026 14:17:35 -0400
Subject: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G6i1KPoV8dDaqEGp0qKI4t8N7
 mlnYPeBRJEpQZs9EOnkxFsQKPIMhtmGiZC9MGilK9UUGp1Bd4Sbd6nrNiyJb8KRL6xLSV1Z540
 Cme+RRP/XXf++H2DreYJqAAAA
X-Change-ID: 20260912-b4-bunzip2-blocksize-fix-7333376abd40
To: Andrew Morton <akpm@linux-foundation.org>, 
 "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=gB3IJPb41ILYd1ANxuKa+w2aDpu+3BOtrBUYsA0T0dY=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKWTrcTNypftINnzhSV+elxt37cYfXP39McvpKR4+aaD
 Qc+KL2L7/jIwiDGxTBTTJElbr0iy6y2HUt9Tkv/gpnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DIEMHaN4iJweg0ZmcXFpapFuWkGRQ15+SWJJZn5esV5+QWpeQXqBXlpmWklGRn5RcSrQCL281BJ
 TV0c3I0MDE0tHCzMnC0dTE2dnJ0MnN0dHZ1cnI0tzEwNnS0cTV0tzBi5OAZhrYooYGS6f7rTInm
 zMdtVG70fLHZ7VnSdLq6daKq8XlHd75Xv6zAeG/+4f/Xn/5AmUXpvXn2UQwLylV3XvAcsC/3NTw
 6d2Hk5ZwwUA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

The run-length path rejects a block when dbufCount+t equals dbufSize,
but the loop that follows writes exactly t bytes starting at dbufCount,
so a block that fills the buffer exactly is legal. bzip2 allows it too:
its decompressor bounds a block at 100000 * blockSize100k and checks
that limit per byte appended. Use > instead of >=.

bzip2's encoder stops filling a block 19 bytes early, so nothing it
produces ever reaches the limit and the bug stays hidden. Compressors
that use the full block size do reach it: an lbzip2 -9 image whose block
ends on a run fails to decode, and a self-extracting kernel built that
way does not boot.

This code came from busybox, which fixed the same line in 2013 in commit
932e233a491b ("bunzip2: fix off-by-one check").

Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
lib/decompress_bunzip2: fix off-by-one in run-length bounds check
---
 lib/decompress_bunzip2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 1288f146661f..aaa75404250e 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -439,7 +439,7 @@ static int INIT get_next_block(struct bunzip_data *bd)
 		   array.) */
 		if (runPos) {
 			runPos = 0;
-			if (dbufCount+t >= dbufSize)
+			if (dbufCount+t > dbufSize)
 				return RETVAL_DATA_ERROR;
 
 			uc = symToByte[mtfSymbol[0]];

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260912-b4-bunzip2-blocksize-fix-7333376abd40

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

