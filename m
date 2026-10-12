Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B849636A009
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795726; cv=none; b=D4Ehxcs+ZcitVlFMP3NFgiYItNLCJU1yCoHqCVslbgxrZOoZ3/eYJupjy6ds9vlLdPtS2IEK3S4Oot27mKwv9R+pyOTGfPID+D/Dl9f5laBebG0K3tR9p+mhI/hQDwoodWoM8lJ+JfUEC9m7ECHLd8wvmxDDA3i/T7zKJ3PRzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795726; c=relaxed/simple;
	bh=r5gT4zEbVmLNb848SgDkhWM1kOaJDLLxEYia9+NzsdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siCH/dqyC9lecJETCiujl9IJ/UnPllTKEB21uevHERrxTGXGzQT/1OjNc72njzPKmuUqHQKqsURxSrXzg7NYbHtYf4dlulXM6HcNeEUOkNP9K3KUjKjFA9hRO67fmNrDxH5Z7q+bcPYS+ccvFxpRKWWNNBOBfJRcMUDUueOBug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=0p8Y5qnN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="0p8Y5qnN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e49fbf92aaso8700775ad.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791795724; x=1792400524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KRIZkJTuAFVV6WLPWb+wMz4OO8owKguCsufpDjwvnJQ=;
        b=0p8Y5qnN4Tme46/P3V2sHR+DEPcfl86gtydFLneW2pdjhGqbsumPm+OR2uVXqPnvB3
         B2ndw1RbnoPeh44DUrEosfi16xHTkfIUtfp1AzpaOtbRpe5NCISCC4YFhQ+eN4TwEEaI
         fQUDtiNuWjsl7+3LHStRi21bGvvdjVNCDxlheXNi4/6mWiAMkXNffWHPxxGHSc0dRfOX
         gBmCe0rYYKh68vJALYN+vR0VqK/78Z21Gf0deoeJzg5ZAlWQzC/30HOd3e727w/GCvgW
         kGad04Bitqe5RVBjL98H2qIY64s01wkB8OdjTKjFu1rH/m/+rqbXYJIdGTEuHD2NCo7X
         YMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791795724; x=1792400524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KRIZkJTuAFVV6WLPWb+wMz4OO8owKguCsufpDjwvnJQ=;
        b=WiPbdqirWcsgkhpmDkEEbKkJhMSD1asH0+4ks80fjyGcDDPXUUMzalmMtEyTgmP3d0
         evxzjSNDl+Sh9aVOn+5dlf2gjXHwAaBTqvqrtjuzm0wey0cXS6YvwsbexHHiHiJoMNNb
         03ltQftWMUaUPQiWPbvpvcwY9QNNafBKjtulIhkJH0Y2BJrIw47UASXybP4cXb3KzUtd
         XaR4F2BFNGsrbQ+ekenh1CyQTxl5d+RvRnIzQBx6E1ySsw8WgKRDteHBO91F3LbqO9rp
         /NsEz+AjTtJ/Qs3pYrpBA3ssztooiW6HtyVtR9ap4OOWwTCXwOzxK/F78YrkKcMgceXv
         wQFg==
X-Forwarded-Encrypted: i=1; AKwUvByAA9ap6i+tvJnzsuVO5oIRr4OoB/EunaDeUF722tW5fmr0j2TDuqeJb/AdYovj5G0E1PjXUMk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ89Tk3dTUupTY3dwRSlr6ftk8vHZbA16R/oTgPCFLYtm7QsusI
	T4BpcsPW7jc4C0cCEm4M4Szev4rv8N//QanoFHWdBzLHzlDEVmmnTsqe9Jb6jFlH89HvlocLjUt
	j6Ql6Rvo=
X-Gm-Gg: AYBFou09Vo94GLBXsgM5WkDX32HyHi6DofcRFATOui8G5B39HXe3j4p8DgseNznHpZj
	Bp9+Cgpgp/SLvn6MoQrr0U2AMm44C3IGEYwVvD/ZcsinI+SwSLxFKOEcuP6JaaLpvg97L/1OaS0
	Q2U5LAgT/oK4YwnJjFfkNNkD+C4u0roL53yd8IhbzlLjRgDYuGgIjvJDbFuQd53d5fwDBlKwSKT
	HBBGSdcj/aJhiEcm3oYJfegUJ37rqtn2DHXTTMBkSV28w1jBLJUoFuvtHZTmzdKlSxkGvraRyAC
	RZNdwalmXNj28X8zPYNB4/ZRg03Y9WowPVTsCSej5w865HfWKJZhhy7nH//DZv1gAsg/IAQ0IlL
	I9IG44rNkX5SD2F0SFRIb+uoEzGlrw15gN3zXk4PUXPkOBHfhM4NoYdzm41I8Bje+BXmRjX6Fr7
	2xVL4Z9koXjyhcaJjv1/vmkcMamrZQccSau+SOMGH2UboF4MZ3dwh5b1TGNB01y5fM7GbhWcOaN
	bf4S+RCxdknWPn0
X-Received: by 2002:a17:902:ce07:b0:2dd:ad73:5b6c with SMTP id d9443c01a7336-2e8429ad1d4mr75888675ad.28.1791795723812;
        Mon, 12 Oct 2026 02:02:03 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e4ebfsm41638795ad.78.2026.10.12.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 02:02:03 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 0/3] scsi: arcmsr: bound adapter-supplied completion indices and message lengths
Date: Mon, 12 Oct 2026 18:01:45 +0900
Message-ID: <cover.1791792888.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arcmsr completion and message paths take several values straight
from the DMA area the adapter writes -- a completion slot number, a
type B completion-ring index, and an inbound message length -- and use
them as array subscripts or copy lengths without checking them against
the array or buffer they index.  A malfunctioning or malicious adapter
can therefore drive an out-of-bounds access from the completion
interrupt or an ioctl.

Patch 1 clamps the firmware-supplied message length to the staging
window (heap out-of-bounds write).  Patch 2 rejects a completion slot
the driver never handed out (wild pointer load and dereference on types
E and F).  Patch 3 wraps the type B completion index before it is used
(out-of-bounds read, and an out-of-bounds store when the word read is
non-zero).

Each was reproduced on a KASAN build with a crafted DMA area; the
per-patch changelogs have the reports.  The three are independent and
carry separate Fixes tags.

v1: https://lore.kernel.org/linux-scsi/cover.1791789900.git.yhlee@isslab.korea.ac.kr/

Changes since v1 (patches 1 and 3 unchanged):
 - patch 2: check the completion index against ARCMSR_MAX_FREECCB_NUM
   (the pccb_pool size) rather than acb->maxFreeCCB, which
   arcmsr_get_firmware_spec() can raise above it; and skip a bad entry
   and continue rather than break, so the completion consumer index
   still advances (clearing the entry to 0xffff on type F), instead of
   stalling the queue.

Yehyeong Lee (3):
  scsi: arcmsr: bound the firmware-supplied message length
  scsi: arcmsr: check the completion index the adapter reports
  scsi: arcmsr: wrap the type B completion index before using it

 drivers/scsi/arcmsr/arcmsr_hba.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

-- 
2.43.0

