Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4112E2286
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790723; cv=none; b=ppVLbo8wzKTZeSs0ES+MxSvy94y/C4jhV1EDKctQzKZV2FbZmx1Ckke6kc4TqoGMYdBgca0Zfam264B1X6XiWSmNsvWD4bWijITcO03Js8BIMIxu22py7SClUw4F4CZGwSGugs7d3gCZ8EzEVFU+uFYscC75+By8Vi+p96iLzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790723; c=relaxed/simple;
	bh=k/Ste6K7riK4U4H/eng95jFc4SxOT/Gqt0qm28BCbg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BbfBpP5IHAe1kuXeELwrXwQp8G8wqUr0W7+hiiqBOjfoSxFON+nJ8qMN4kft4xc2/2x6p4E+5xq4M0TLJGnSN0h+VbPXMoI3c+Z3OCXsbhh0imvSbma+9FWtXX/OguLriWPKCFNPmyHxz5nphPGswB3YEpzWuZJS9Jdvclv5C6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=T+wbXCxG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="T+wbXCxG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89a595332c7so546568b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 00:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791790719; x=1792395519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vZUQvIk4esipOPh6JhqFb4csORQpQ+ynl//reiEHu0Y=;
        b=T+wbXCxGgTnhphpkonj48h6xs/SlKTARDJ10qxiN8638nCpw67LWa+ufKrcYric90e
         /8wHA14wcNI024sOrpaOM7x4Pqg50paB9TabW0TBkbNjKtDGnPVSwXYuM2bfZp7IFSAc
         tF2hkKFKxnprZQAh2Q5EZWd/fUtRgBAvEItrbXuULtGAwpG0oX7O3ePZeWAUZhrs9C4u
         agyFFcoWMr8UBzMXgajbDG778uYizcTZ4g7vz5Td9NqwdxV3/9MfpEM5imHl9HLdN6EK
         J45O9By9FHSLCB53WWTZd0GF2ruoVUTdGcd81WDcMIRe0OwRzwaJQlJFXYkBN8xCPoqH
         msSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791790719; x=1792395519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vZUQvIk4esipOPh6JhqFb4csORQpQ+ynl//reiEHu0Y=;
        b=MVgcOspBlH5TAZdc3un2dM5Vt9VnYivRG+9Qfv9GCx6dooaqSCiMyxZb8jLcnk5zn+
         7sX78kPXjsN5bt5OETFGKyavfEjq+WtBpJXYCNJsQxewbuIWiFxLryGFksMgGtGNX6oh
         iaBakU3UTgmDRKVI7RcLDVTZ2j1AFmralh+w6AJaput9S979SxhS6quvIkr1uUtMRQQG
         dggdm9/hN3Ksru2e1/Xgc1PW4Uau+srR+oqzXMYy1R97WGd/9NzbG4oTvRjree7sMvHt
         n7dXyu5XSLYnJtq47zuBErHaLUteSTxfgnPVVCso7WIJcatTKH29JNR/lAwTKjUXbTj6
         wwaQ==
X-Forwarded-Encrypted: i=1; AKwUvByNXyo1vOyJFHjSk14MAGrsah1ijta4vSrgF5JVpINh1TY1kyQ43RI39QY91iNmLNuJcT/e9To=@vger.kernel.org
X-Gm-Message-State: AFq9FYJclcMi67fnxDkC8jBBwCbszDlcERtwrQGeYFWhAI5QGkJXLkEK
	6vJmaJlS7sOVIBfqvoWzTy43veLOf+COAyUyJ29z6412ULsh/LKt/CdHtIPHFyJgyQU=
X-Gm-Gg: AYBFou21goqjcbrD1qL0NRbByGMps9g5zWvoBLzLqG9eLkI4J8/7ypKQ6txSdNPePXJ
	s3UENH04CVUeHXRc9fuO+tCh9mZG+d6rf/Voc3+nT2pADNqjg+erG0rremoIjZSZeuh18w9Tl8M
	yIY52bKcafkhVPDsnBp3sgwlqdDRM4MGU7b6oM1vDUxo9g+PlJS475nDiTBEuxmNBXk6pPRGum3
	qzfUecnA/cDPD06Y1S8oinX6EB0GSU+bsBnepDKgkpJA3UpnkSdYnFvP8Xn/WCe6HyJ9bb88jK/
	aj943fouDayDl+hF+pUdvVTojKmJvNU1xkETsntfVVgsPzUblM0+05OKZnjpm0BQ1gzLQg3Az4W
	pnhMkmRygJjNOzd6heGW5YySrKK8xvXcJHvqlZKJElmKMwHXI86RoRgOVyoxM2XURM/FFwX0X9j
	sMRrhsmMeMyblMVFjsvQmGvo7z9pDnCqJSgP6OGzhTSIQMKgJi1ecafq44z/ojs8TqmVO+8o9HB
	3g93g==
X-Received: by 2002:a05:6a20:430c:b0:3e0:c961:b5b1 with SMTP id adf61e73a8af0-3e16be576acmr6010134637.45.1791790719022;
        Mon, 12 Oct 2026 00:38:39 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-898c9ee8bc5sm2148780b3a.60.2026.10.12.00.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 00:38:38 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: ching2048@areca.com.tw,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	thenzl@redhat.com,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH 0/3] scsi: arcmsr: bound adapter-supplied completion indices and message lengths
Date: Mon, 12 Oct 2026 16:38:25 +0900
Message-ID: <cover.1791789900.git.yhlee@isslab.korea.ac.kr>
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

Yehyeong Lee (3):
  scsi: arcmsr: bound the firmware-supplied message length
  scsi: arcmsr: check the completion index the adapter reports
  scsi: arcmsr: wrap the type B completion index before using it

 drivers/scsi/arcmsr/arcmsr_hba.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.43.0

