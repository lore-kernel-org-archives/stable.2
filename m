Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB73C2774
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900155; cv=none; b=hT8qJVtek6Tt5mh9pSh2ucJvbeXIufr/drTShE8bpCom7Yb0KLD7KfQxPqyOYU2VCBAOneyyM4Kdr4Q3oTbXTQPsTkYEvszW/WStimtPYknDg2qWmzZ1HxVl2x1ltMMUKB9oLfy8Ep3J7VR2jvROHxAeATjZgtYBGpXPmF5Iyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900155; c=relaxed/simple;
	bh=Tawb0P4WHQbChCm0POAm0vP/OT0i3bQuplGTDM9ziFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7V2tbfscKSx73STiasd7UGQXQcDxJRl5tsOlXRQiXymp02KCij3aH23XgRWMCjzMMzR7JKCkDy4xgEyUhrQ15KcUerD875JKwgTQAQGthT7YuvXJACiCz7QUWS4IVdE8VZjCa6gvZODtvrLvQfv4woA1HFh+podgeeYVNAVfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=0wacYjbs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="0wacYjbs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so16231655ad.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791900152; x=1792504952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gpvwGadULPDGCwDez0VhWNS62rM8BYPtekPhIicjGOU=;
        b=0wacYjbslPFBJHaRaCfeH3+kGmnMbBD+0IrKW+MwkiZz50vz+AZN43toDt7RdsEBMK
         RSnkfpVfGYRnBxfodvjknMclg+yeYQYwtHaz82FEUgZw9getGYePqMIJOSD+dUCCtqUu
         rDgX6HeaPyYr+ZH+fhpEa/4y7t1U8OfJFlchcpSnoLcXeIguXdtVjjJpLXdlTjY3as+6
         0aL9KBQ5nsbazSH7MZ25NeG3VRp+0ayFUVVWL5YQdSHIxLicBj/RuTEmJW84Es8Giftr
         q3grA9SL8+QEjS7qthbX4U7eDMor1PTNT9T4n4E4Q4GolQ0t68+4i+T3o7lwYc7NfuTJ
         EHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900152; x=1792504952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gpvwGadULPDGCwDez0VhWNS62rM8BYPtekPhIicjGOU=;
        b=I0+CGJXR9JCtabvSscAQ2PtI4M0QZSyyQ/iBj52tR0D0vKt+FkN2lHS1+4sceFG/yk
         LvgsJUVotuGBj+Invpw86bMlyUqGfmhLpWjM4UXeg/nXUMbDbH6j+icuLQ4CmlfD+6a9
         7FEi4rub4gScOPepupZsqeLk9P44AME0LKFFWZLRYGw6HEzFLOOlsd53kQswBLKkz3Oy
         XEuDCpVB+/0gPtqzAb7E2ThE0MeB7+wOAh02kO7qJjCaXqC5TAmPMNd7103KiXSxBtLr
         D8rqHNIDAAXibEJbrlFQI/JZoCKzUoFY1qezIiGJJJNbS+bJvTxa3xn3e62fwz34eefu
         5upQ==
X-Forwarded-Encrypted: i=1; AKwUvBxetyM4qIIliV0O/AXo8dL91DrBPhUdHkxMcyRjRGTaDf8z8HO/T3o6qWwEsUokT/sAp7/N+kw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpcoewrP5XfNHfxi2pUF5Jh9bPvmGmutSzXUxdWFvg+ksr4J9h
	HhcjGheqLQFNWSgfJBgF9nNRf5hCroQeNa2ohuMLIwN3vKVqnmdVXoj601bUHeywA7U=
X-Gm-Gg: AYBFou2/bfJsoX4ZEIU5fMqxkyRY5k1gNucr0M5mcN6wx4o8f1sCyphllfWcb2+fsB0
	tf7kxj2XOQiJgn22l7mM6nPsaOQTgXpuGhNfE17qcNVIyIfVfFgQ+WNjlGnWqb8GwPvT+ZIT6uF
	hTPXV0DYcl2iNOjv0PDo5XVuovg4LHV6C0Qus5uARHtJrvun53bTXqeODogzr6ztShr6tejhPI9
	XgyBqMAr2mkFcG9h8nl4+N32Jft4o8klNTmghh8Bd5XfDQfcSvNPNRYyf7q+LvHYZirZ/G5LpnY
	/OEbnIkN7Vws5ZjSFpCMDtwbvShapdJmt9dPYKr0Jfj3Z1wpM++YCyMe3bX5TosGTu4MmLTIDDa
	ZJuCAwfgRqpNYYHd8GDxQWgU2mXUwD0BacVXbxdndVUVws7lkqyADNRqNEgvLqmWgKZpkaIWxia
	oqmiv1gILjbs7KHHHT7UQ45wSTvoc2CriWpo05W2S1TgpiB7/18jXCQBbEFyinyQg9Tq4mOR7mV
	1JRaAnM9Ybay9bsd8B1
X-Received: by 2002:a17:902:f54f:b0:2dd:c100:b2c3 with SMTP id d9443c01a7336-2e842ce0ad9mr102000625ad.46.1791900151506;
        Tue, 13 Oct 2026 07:02:31 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a02f85sm56433065ad.10.2026.10.13.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:02:27 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"Martin K . Petersen" <mkp@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH 0/2] scsi: aacraid: bound adapter-declared sense lengths
Date: Tue, 13 Oct 2026 23:02:12 +0900
Message-ID: <20261013140214.3156938-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two spots in aacraid size a sense-data copy by the destination buffer
(SCSI_SENSE_BUFFERSIZE) rather than the source array, so an adapter that
over-reports its sense length makes the copy read past the source and
hand the trailing bytes -- the previous request's scatter-gather list
in the shared FIB area -- to user space.  Bound each copy at the source
array size, as the container sense paths already do.

The two sites have different origins (one is as old as the driver, the
other came with the native HBA path), so they are split for independent
backporting.

Yehyeong Lee (2):
  scsi: aacraid: bound the SRB sense data copy to the source buffer
  scsi: aacraid: bound the HBA sense response copy to the source buffer

 drivers/scsi/aacraid/aachba.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

