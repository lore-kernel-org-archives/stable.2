Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AE2BEC2B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940564; cv=none; b=SrTou3BWeCIUmdy+OJNLKmYLJJZucvLOAvygmVgCVN/DDH53fKz0tBnuAcYXQp89KrBHifiMu7aHq9WyR42e4FxSQk55yo3HoCakwH+pz217OIX36HBGNqRtgFdSucmmB7gBTPLTDjjxaZ98kuZq0EzP0WzqWf1TdwafH/Mem20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940564; c=relaxed/simple;
	bh=MFagdxKbayikzJggDuQHwidUYx5+Wiq1MGiWqy6MxUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=juthzxS3RBOzIjWuRNdIk0yGMSWzatzPFSsInaM7TAlIpfwga+jSWeK78VEWOHyuBwvdNc7li+rjjnGsbhTpLa3r6qid02lD8LUEJtyW2nFNbGFTNN7PMNsJY41cS40+UdCX7nD0JI/BboGSzwttbdcF/93bH4R3g1sv1bWFxJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Ywox/kHZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Ywox/kHZ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so2851288a91.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783940560; x=1784545360; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FRGrF4i2nmK2rkhMiQH5i1w4BrMy8RzeV71NdueHFlU=;
        b=Ywox/kHZyepBV31YUOq18ecHmyHGhdBneG7rmGAYk0EpknxPbr+Mh7UX6BHGeCGyS7
         K428Vzb6BbHL/GNWDgEYVyj4uGLtlv2ZhY7X2Q5PcBXNpJpqqhZLZMalYvNzJ1iJdQlq
         6QRRpMPnWHHbWd1krikjIIljGeFEbpj7ll6FCFMU0Rbz/YkYmiUWdMjUvpFDWSV/RK3k
         KkANY8B5lOQ8EEnMEwAzQK/BTyW+jY8muUly46nX+LbUFlaczPr3z69nRtj+JL3xk2fX
         Tl2kDhwLei/YGT+v1K34R+K1eQnOex7yDluxMjxFoIn2HnWsspNc3hEWgUPVi+W21H3K
         xFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940560; x=1784545360;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FRGrF4i2nmK2rkhMiQH5i1w4BrMy8RzeV71NdueHFlU=;
        b=Nz2kL0KLt0ZNgwYsK8IMWtDNLlIoU46RKV7WjO1FUt+OwWCRNkcyn1uqRtwlfFZJ5y
         XoVjQuI1GKC5QWcOSLKSzlgM9q6RtdRn1Q8BwaIxO2M+TyV0W2/991HcpqxIxeB964hV
         tKy5XDtHFnHmyvgEvnKxEmxIhyhlpFars6d0J02O4NRcYDHud+qJSMWi2XZpUPEAncZO
         M/dxoPurHEmMMqbFh8xwVXJ5el5v7VDWqP1gCd0n7NPKsKrPYOOa+OyV6VghMQX7f23h
         Nr2BUhLH18oqP/9fb0471WGPTrA7EBFrVtfdHyafvoR8Hhd4GdmPAOHv8Fa7bjDMQCjZ
         vJOQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXZ+XjWvrMtPX0bVZNGUAiNB+xTo0Y+I7yu1FaWkO9eRE1znYfudwztNIIwfbERjMQnaWFvSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXCs24zW8Or26f9AhjiDwV/H1TFdt8T7QOlJCCM+Um2/LBS/B
	54U8TjKAuWDqF7VAufQ8i+nyijdYWnquBWxBvAKDIWTejfjGOyELr0RJ15mFB4uFwYr0uRyrFY5
	iitb/C7U=
X-Gm-Gg: AfdE7cm5wCAn7c4kdWVLJ03S1sNQppltdPqV1gfdI5R8LN9pgE+pZKCVOOXSdLkEcTQ
	z/Un3/1JfwCaMlDKgnUcfQTUAQx698BzbFTumwVklX0YeJwYKzUsNiCtJH4PwvjUuinN62Xbw/f
	HpNQLp6+5/RQVEhVEFaPy2jqblpweGTu/175uqDGupIkb7ylqWv4Uouev3i0t7YaGAD6Mn3OgXP
	ciHJLsalJQcr00mb4rjpIujmYDsjp8uE/aWZle+DCpeuX83YzJ9OW5ExzTxc2iOB/VGKGQ04bvC
	+ssWs1gMJ9pBwg+eDr2iyJgjwXS/hRjt03FLzI8p2CnyJFWW+PRPN6Og06U9YxfhstLon7tBYQf
	6GXL1A5A7FIaWCYmyiKIP0/16CERUfAgNLngT9tBZ96E3Ujhghl/K1vbYBko66vqwbwruXi3kAA
	sIBdcCdIXn83H8yo3NyY+KBrn6hGHui2R7LoujvGzDNBTbKdin5zV6gTrJNO1wqwWNusfpVW70j
	FUsv+qLuF2W0Oi6Aw/R28BeCuu/1kGrXYU=
X-Received: by 2002:a17:90b:5108:b0:385:39ac:fe4b with SMTP id 98e67ed59e1d1-38d15c881d0mr15343936a91.17.1783940560178;
        Mon, 13 Jul 2026 04:02:40 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm52249087eec.22.2026.07.13.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:02:39 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Subject: [PATCH 0/2] platform/x86: int1092: Fix two bugs in SAR driver
Date: Mon, 13 Jul 2026 16:32:23 +0530
Message-Id: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/FVGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nj3YKcxJIKCzPdpFSzVCPTRONky5QUJaDqgqLUtMwKsEnRsbW1AJ6
 5R+5ZAAAA
To: Shravan Sudhakar <s.shravan@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.13.0

The patchset includes two fixes for
- a potential memory leak in sar_probe()
- an information leak in parse_package()

Both patches are compile tested only.

v2->v3:
- Converted into a patch set with two patches

Link to v1: https://patchwork.kernel.org/project/platform-driver-x86/patch/20260707070524.953741-1-nihaal@cse.iitm.ac.in/
Link to v2: https://patchwork.kernel.org/project/platform-driver-x86/patch/20260710052806.100107-1-nihaal@cse.iitm.ac.in/

Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Abdun Nihaal (2):
      platform/x86: int1092: Fix potential memory leak in sar_probe()
      platform/x86: int1092: Fix info leak in parse_package()

 drivers/platform/x86/intel/int1092/intel_sar.c | 32 ++++++++------------------
 1 file changed, 10 insertions(+), 22 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260713-platx86-be6e25a3c9dd

Best regards,
-- 
Abdun Nihaal <nihaal@cse.iitm.ac.in>

