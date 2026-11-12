Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482271;
	b=nuUekbBkpLeEjf81mCRLQ+19Ok3fZpJ8aRBVqkIlH01AltfdtbGcR1oueufsrJgafNU/
	 7p3eJShhkX5NO9e7xFwA8xh7ahe6Skx+jD07PkaSEUbQif69VzPqSTAxe5zHMRfliaGr7
	 gyMIHpTGa5/wPnCSNXfiqGI52fYTvjAGf2zZ5/ca3LTr1l7jippAxJZpFe2H+eVH/1YKK
	 NVSK+QolU66UwhZc9Mu6INdgMMsjfV71z53Bi1aer6tdaFmQO6dIgP4MpqVDFq78W9gX7
	 MYf2rnZgCUa7d/qx7xAycVz25H2/8vyxPLkrOFew6lnUEQpMeclypSNHS3AUoUSYKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
	b=tD0Tufq13I8Hn3uJu1kpPdJmlnZMkRjq3AXeHHtLYFrWmypLY+SnAL5/FkRx8WR2f9El
	 iBaU0eY8ovwchFpsw+m5uH2hzuIqsLkiyLvQZiwKDRDTWUcETuSx4ej8Tzxu8A95gZc0a
	 91z3rLerMq7Ki5u7E+q5PA8d//Yn6zYS8+nudpcJt0nwnjO1RHgvgHIT8Z9fXZz5XyxML
	 MbgzT4hAqDAnPvwaL92NntiVmpXZYlvK2mKt437pCP44NPHyHhRDnz086xc0kB03BLJ2n
	 6p+TGEfmIEJL+3Rlx6GqPlsveHQUTqB5eZ+p0h/tZWHoycXAgGtZTttB1548S9JBdmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GPZHYsQn;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53978606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53978606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GPZHYsQn
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f20b304c0so384085385a.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794482269; x=1795087069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
        b=GPZHYsQnIlFOia1laiYlcQuWc76+tu+NFBvZ1ns75K1PPcu6dRv7LfhFgko9dOLLf5
         SON1kfue0V47sPzCBPIKn60Ylres9661af56ioKIc90wQmwD690Vhdfk5dtvlIfcrQg/
         mCSW5cI1hS+0tO8PfqjVupgz26ygMR/GOEvPYCrzcuVyndSjPOkOyl8hwIkXt5z86ZFL
         xfeN1fgWP3vnDczTdrtUpLere4HvHit33PbUMBicCF7VDrFZW20QTm2jiSMBYfSXFif2
         Vz0CrH1p+I1vWQPUScHbHfPmp1il+5/NiuMDjM13usmJY6jIfYlxLPEUIGL/TKdlVlUT
         cVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482269; x=1795087069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
        b=uiT9b2Z8yb/gwzG8VQ5UmGytOvLK+JiUoFpW8Z3eFNTfcazubCt9xeJF/dyLRBRufV
         647DUq8MCJ8e4KQfd9yh63USoP+oKMtNBPUWP9g8tPHSlkngjWM3UI6sLR4vx9laikUt
         38loPUKwDc52ci4vsUDX71sOByzP8GLNyXBn+xVu2QZMFDXWYFYsln8541PEmUcZXbzq
         mP6PPxO6YqSTvBQpUuCk0NEZhFY40fR628ouRwtIrgzAwD9V16oeYZ16MCCFnXZ/BzLz
         9c+fMDNPYZIpPSX/pDRyxFHmRvPgLo2DkR/YyNgdkvYA8f0XimVuKQJjSbndmJLmSpVM
         YByQ==
X-Forwarded-Encrypted: i=1; AL+hErFgG0gfzSVuSOMkomqqNLyQOt9mSXdhNun8Pyv78xtTqCl+sNHiTghiCweV08E15dFp8MwxhKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z97zkJ0AyxCmhnwbK5B8fQrCVyJlozSigeKaMUyXfvl6s7yxbjd
	jvTOOFzgGgo/GRc9WEIVX0shov7LrVYci5Sqkty9Ffc6yxA7tU7+LqQylp9MU21h1A==
X-Gm-Gg: AYBFou30yeFNrwMU40IAqyzA4o+NHV2SSXFpheKVEexSyAFxT1dyTaDSKFGK11zfHvu
	jieoYJzFIwZUAiFubSu7qWXtbr7Wa74CPFwhaYh/VYExk/50b9OdUmuLShBWg3GTSI8IdoDXF6V
	KdfEwk06K2HVs+1S97mw35EDM/rMyDAINF0FDd2lPP4YQoNS9yumfmq53DV754zKnSbuNfYT84o
	2i1USRCandosMsgRSSNp4Yykz35mGW7br5BGcrr1sX1a1QDxg5ciHhrM7w5vhT6b0CQowL7PPX7
	T/GUSmGyubCrnDwDKQyc952wVvJxzKAD+0dgcWILwK3kUWHtgUbl1Qv/JQlfo/O3zWGcja9h6VW
	6zTNFXxn3lh+kFHwy1ltPCxJ7YEbWDeCJnAFjxaxX16vmRaCQHV3qDPsnkNnjmdIe+j7Rp9lnI9
	ft/2EjszGzw8v3gf7pTFyBhbFZN3oINDIEPLTqi0nzees/2aeGboilYASLgYC1BO7x747xsgx3t
	kfl6l2QviumprerSULi7qO18KOjK5rheMOtbD8uGKCeXwOdWqfwQdLvHVZCA6bVyaFMLs1SB9eq
	hzctjSoUxQGNrF6b3XO7+dNSVnCRvzyMwaotfB/J7NecAFM3Ff2j
X-Received: by 2002:a05:620a:4712:b0:93e:c12c:9dd0 with SMTP id af79cd13be357-947b000ce09mr893234785a.80.1794482269108;
        Thu, 12 Nov 2026 03:17:49 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c3ddsm710100585a.15.2026.11.12.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:17:48 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] hfs, hfsplus: do not end readdir early after an unlink
Date: Thu, 12 Nov 2026 06:17:43 -0500
Message-ID: <20261112111745.4094283-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the readdir rework in v7.2, HFS and HFS+ end a directory walk
early when the caller deletes the entries it has read. Both filesystems
got the same change, so the two patches make the same fix.

Tested on hfs for-next with KASAN and lockdep. The reproducers pass and
generic/637 still passes on both filesystems. A run of 30 generic tests
gives the same results with and without the patches on HFS+. On HFS,
fsck finds the test volume inconsistent also without the patches, so I
ran generic/013, 028 and 637 on fresh volumes six times each: 013 fails
and the other two pass, with and without the patches.

Hengyu Liang (2):
  hfs: do not end readdir at i_size after an unlink
  hfsplus: do not end readdir at i_size after an unlink

 fs/hfs/dir.c     | 27 +++++++++++++++++++--------
 fs/hfsplus/dir.c | 27 +++++++++++++++++++--------
 2 files changed, 38 insertions(+), 16 deletions(-)


base-commit: 34ee5f8c2198db9585da6c181c50869d2eb43c3a
-- 
2.53.0

