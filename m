Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA52E7390
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437334; cv=none; b=jhwYEutLC/WMQBW94oR1T8e9BStsn2ToMz8CTtiymRvDry2ZNs4iJDWhZ9x6E226dbn2dP92rpFeZj+UbHPI6Qoyi+n4G49cB8tJsoQcIMKU1nxOimLbUrVTmAeKtTLpZf5OEnEkJN6AC1LyOCy/hS2jx40cyB76/mn3rndClX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437334; c=relaxed/simple;
	bh=SImV7x1CZ+YZSzFzbNMVur6qt+AKDbf3BSRwa4So7GE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMPVS7qmO5Th8rA9LJJANiHO4vqzrZEPBZlKo673srgcxzJx5aunCPrcL64ruL5xkO4g0/ElgNETEYPdJcHaOrn92EB9fr3EAVKlYjXEdhkPpuGrvOvYHJzrderBsuJOn++tTjI9CQ1U6bkEolL7ICrDW+N5J5AtYkXOzFz8uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBhC0ffs; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBhC0ffs"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530de452c33so36215621cf.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437332; x=1790042132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lmGs6Nrhth/r9kEqCYRE9v0bMT5Om7otMfWFzjHwusM=;
        b=dBhC0ffsbUKsDCdLRyjDfIcL92CfentN6mI+V1IQcPtqdoYZLLTjkaMf3oCSvyxd9A
         wOiapgW+W95J5l75m9x2+YBnrgVaLZLuZ1PKIByPb+GjwN3S6jCGF41IPQBpQkaj/Tym
         AdY/IShtw8mOScVP3yn7KzVc9vzc8GNUBNsECT556EGvuf4P0IFG0AAbfZcWwicnKcF0
         0ZiIATGR8FyMyRSuXG317SrZjIJm63CqAD8LFtkA8WKjjMYX6scKphURpVk1B6DhNADu
         7mNdMPixtFRkxydmosq30/ExrXE7xH8j5bZ9ZEkH4LytHEfZoW5PJxOd0Ec0tqDj3VIx
         I6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437332; x=1790042132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lmGs6Nrhth/r9kEqCYRE9v0bMT5Om7otMfWFzjHwusM=;
        b=o0QbO5GUb1qolDV1+tv3raeBxE6y0o/R5UdanbSKJLgAZ4ntc4MeIPGKgw5/9OihUe
         Fa2/031JpgGhxDPVls8IEwzJKZH4WHmm0j3QvAlVh8AWRtTT7UHSt9/JF4vOVcJW6X3K
         7usdxBtn+z1LMe3Q49A+sxISFpJiqLoZUXbt1NZLbRSybhv8JeNCXVPEm1DSPQ3OzYBV
         ZFX54Q0qwhu3orL/HUbwRUGE5oIV4NAuOiHbIcQ5IinY7Q46Z9p5HCo7WkmUtqygfHIJ
         4oGEH17C86EF3aDdjeu00pnxudILqemnSV+neAiwN3sLQRi8PWpL8QhAH8B3P0getjYh
         EuNg==
X-Forwarded-Encrypted: i=1; AKwUvBzacq+p3sKrF3YvNX+3V2cIWaaCJk41qNnQ2N9wN8CTECrU7UtnD0DKCjtBdzenTIqFI3NAkk0=@vger.kernel.org
X-Gm-Message-State: AFuF++mwJQ96XyRaxbDfN+8V8i6hS/u9u0Q21I2I/8NsY5I2w3lDXmaR
	h1CzQikrJwaz2PMzdLgFPNkSEisHcjQDKCIRAuOl3/QPHJSa623/8rk=
X-Gm-Gg: AYBFou0WU8ekYINsR7Kn9djEViy23BKiHLfO/lL6XGqgph074QHepjchfEDVSl9f4Xo
	G2YjLJUXvSCHXzxQlIYmHnUObtKfC50REhby/tDRcTX35qrIarp0JF3Qly8jvW7kwBW+KNvSq3n
	Q0pOoZLkfWiR4TpaEBJYtnmcKEMzuTuuVkAvVU679iF85XTkVrCzneoaoYZqH4z2BzPLYueq6TG
	MNjqtLIiap+04PqzU6AkUiCMUpucwy2JiGrNB8auU0dl9zmQvLixok8nPHHXUh5UEmTM2X3tAw8
	/P0mwYaw6GiayBcUzRny/DQoy2L7TlNom3YF2/cpr1bXvUBzRgwgFofShqm0H9hZx6RyNEp1/CR
	P5pcgc5mj8R3vghP79sK5YNraZAVamqOQVnXvdFIzr9A3SSmASEHjQFvXur6uApUPE2wEYW5Mz/
	t4J06tadcL3s3JGRfsS4FJKOI9V46hdRrGMZSq7EnZYPloPck8Nkmcn4H8qaCPCRIy2Y35wdHvY
	PNxjSoNfU0XqsCEit8OO/D20odP3++EYjsVH2MGJKaGNQZQkD5iCRclLn2jAsffsgjLDUudYJV+
	vSgF/wtxRlUVM1R2DUWql5f7THRia/Ufk6lwPyltPw6T2bfCSWr5bHBdIq6qXj9HNCZ9PX1EZ8J
	N0Ewe
X-Received: by 2002:a05:622a:1194:b0:530:62bc:e11d with SMTP id d75a77b69052e-5310cf152d5mr76349151cf.4.1789437326963;
        Mon, 14 Sep 2026 18:55:26 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5ebc79sm109264546d6.48.2026.09.14.18.55.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 18:55:25 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/3] EDAC: Balance PCI device enablement in three Intel drivers
Date: Mon, 14 Sep 2026 21:55:16 -0400
Message-ID: <20260915015519.83833-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers leave PCI enable references held on probe failure or removal.

Use managed PCI enablement for e752x. Keep explicit cleanup for i3000
and x38 because their module initialization can invoke probe outside
PCI driver binding. Each patch is independent.

These issues were identified during our ongoing static-analysis research
while reviewing kernel code.

Assisted-by: LLM

Myeonghun Pak (3):
  EDAC/e752x: Use managed PCI device enablement
  EDAC/i3000: Balance PCI device enablement
  EDAC/x38: Balance PCI device enablement

 drivers/edac/e752x_edac.c | 2 +-
 drivers/edac/i3000_edac.c | 4 ++++
 drivers/edac/x38_edac.c   | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)
