Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DD1373BF8
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525734; cv=none; b=rfWKEEBQxOMneDcqKs7sX47hMR5tcyV4mXTDbYEzxOYuYCy770p1ff14PT2iDuEyasqZlQ04/hFoAJcJZuOJXBh1Dlzt5AHr5AnUB9OxDJaR07XZMKasOLf7/Hv/i51PNkUAWEe8ct15LXtJ8NQSFCHczl+ROSfRqMyi/WxYLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525734; c=relaxed/simple;
	bh=8QbeqJbFf9oi4h55Efl5R8F7Lfx9SdpLOJ/gAAydHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9zbFIr5PXT7c+BdhBq1eSep6uAhm/hauxniH6ErLdxjOrOHINjX8xUTayHvhdtnmgt9Bms2ZQjLbQ752f8P42P2qTdOXHf74ENuH+ucxq2gSf8CP7mq2G/YMGMI0luQdP9hRZ5DVNUx2WKKfSH7ZV4fNQKL9IFomEO4gfzxMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4X7i1fk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4X7i1fk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so1923300a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525731; x=1784130531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8HYyhfh32LFwdBV4eDfTnSyUP2grGJ7M7W0Gn17mFP0=;
        b=E4X7i1fkS3Z40nI7+jpkxdQGzUL+RUBBDZtuVX33IO+WhcUc6C/KD9Mzy9B9nEW/d7
         rK/G5GJ8uNypzkyhf1HUj2ofBuZ9vkusGajBwt0Tj+dMXtSWx7UYRfKHVjbt9lB2Vkeh
         OHdBWkvBHeFDlS8POuLuwaHU9u5GPYneOgBuiMByfWohBqeLZVkV71jEKpi2NiD2YWVw
         PZru7AoXShcvuXzIPCvC1qB3W0qc1h0RRnBhZB/aktOb5hQ3+epwfS3lWKVV7baIy5Ng
         26mNZvc+b8UW3zee69cyJsIFzoS4dveZJbPabW1W5AACU18heUZKgAxxzG3zCRxt2ndZ
         zGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525731; x=1784130531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8HYyhfh32LFwdBV4eDfTnSyUP2grGJ7M7W0Gn17mFP0=;
        b=QP2dMnO+/kNNiAK2eiS4I1bOgFmog6FNH3khS5d0Rs9gJZFpLoQZ6/3LdtjyHBVhcx
         eOH10Md02uj3Ddbf3CDgTa8oo/PqbzFobOw4uMmu+n9MVaYvw4zA8ya4bjZLmYo1SFNf
         Z6GU/WsK05rHNEAsgIW7uy44neU79/qBLldWT1b+YQEezdCyTA3LeNp3Av4gWUaOwRG4
         q2FFJpP9cvbFDvBg6URTgZzgaIxtyS1xQJjDCo/TfyQuRXvqQs9E4Z9MSAs9PUDeT2u0
         umq7H+dSswadyAMwVzB285cCU4GpgcUl6Y1yV+6Y5JoA/kkCxRmw73Hb9lSIAgPfiT22
         EMSw==
X-Gm-Message-State: AOJu0Yzd3QwWRt+oXKSXUzyxliUr9heJVmThmhr2FuVVto6GD9tpVmlV
	5rSvSYV5kaHBFLzTm6epE3cTYPi4TVA/kTnLVM2FJZIpWF3NgzurV2B3
X-Gm-Gg: AfdE7cntnJtmMpgpe7E5qK9RrPNR/B9HrjhX4eVexiJBVcDhVSDB07Usm1wnKujmNn4
	KH8ry8U/We2bmw8W+WeAhwB9sg0vp+/gQ3s+e0CW2wEErM6Mvvyj/OTUA2FW4KszwSebaQszLHD
	h8RhjkjkheFo0uIzP/5vATX1h2jC1aNnxU6AG1AA/89OhkLOxdpJoMrB3ZsX2dmYEFws2nIwu2t
	dRLywpMq8HvOoZFSqUzQIgtqrf+MMKY3gVlso5+9gVBoraaCvQ5GTXqvEoaDfJN9CM/wKoyHuTU
	NDiCxZRYtBB1JUQi7undqDENmCU/56Sm3dSCk5ZM7LpFX3Bt1lQkaL0iFfyJk4cbKDIYRnBEwPx
	NqvJVym10+eJEE6K3Nbm+IIVJ53xXo+M/YFbQ+TEaG6GHivDHu540C2fhfYTBGtlHmSoa7CK7F7
	oLnoIjO5infkHWP6p74s6fZ8ORslQUdZETUcFjNeND6yPXWFNsxVEaa4X18mBuiv8=
X-Received: by 2002:a05:6402:50ca:b0:698:ec2f:d6c9 with SMTP id 4fb4d7f45d1cf-69ab3c16be8mr1547585a12.14.1783525731269;
        Wed, 08 Jul 2026 08:48:51 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm945125a12.23.2026.07.08.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:48:50 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4 0/4] platform/x86: hp-bioscfg: fix ACPI package handling on HP EliteBook 840 G2
Date: Wed,  8 Jul 2026 20:48:41 +0500
Message-ID: <20260708154846.12356-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes attribute enumeration failures on the HP EliteBook 840
G2 (BIOS M71 Ver. 01.31), whose BIOS returns shorter ACPI WMI packages
than hp_init_bios_package_attribute() currently accepts, plus occasional
type-mismatched elements after a failed WMI query.

Patches 1 and 2 are prerequisites: they make each per-type parser bound
itself on the real, validated package count instead of an incorrect value
derived from the NAME string's length. Both are no-ops today, since
every package the driver currently handles already meets the old
minimum size. They matter because patch 3 depends on them: once the
minimum size check is relaxed, the elements array can genuinely be
smaller than a parser's fixed per-type count, and without patches 1 and
2 this would result in an out-of-bounds heap read.

Patch 3 relaxes that minimum size check to accept packages missing
optional type-specific fields, as long as the common fields (NAME
through SECURITY_LEVEL) are present.

Patch 4 changes a type mismatch on one element from aborting the whole
attribute to warning and skipping the offending element, matching the
existing handling of unsupported element types.

Patches 1 through 3 are intended to be applied together, as patch 3
depends on the preparatory fixes in patches 1 and 2.

v3: https://lore.kernel.org/all/20260707202111.35414-1-meatuni001@gmail.com/

Changes since v3:
- Patch 1: dropped the Fixes: tag (the patch does not fix anything on
  its own; Cc: stable is enough for stable to pull it in as a series
  dependency) and reworded the forward reference from "a later patch"
  to "an upcoming change". (Ilpo)
- Patch 2: dropped the Fixes: tag and reworded the forward reference as
  in patch 1, plus dropped the redundant sentence describing the
  out-of-bounds read. (Ilpo)
- No code changes; commit-message wording only.

Changes since v2:
- Split the single "pass validated count and bound ordered list
  parsing" patch into two: patch 1 fixes the count value passed to
  each wrapper, patch 2 adds the missing elem < count bound to the
  ordered list parser. (Ilpo)
- Rewrote patch 1's commit message to lead with the bug instead of
  quoting code, and to state up front that a later patch depends on
  it. (Ilpo)
- Reworded "thread the count down" and "guess at it" phrasing. (Ilpo)

Muhammad Bilal (4):
  platform/x86: hp-bioscfg: pass validated element count to package
    parsers
  platform/x86: hp-bioscfg: bound ordered-list parsing by the package
    count
  platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP
    BIOS
  platform/x86: hp-bioscfg: warn on element type mismatch instead of
    failing

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c     | 16 +++++++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h     |  8 ++++++++
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c | 10 ++++++----
 .../platform/x86/hp/hp-bioscfg/int-attributes.c  |  3 ++-
 .../x86/hp/hp-bioscfg/order-list-attributes.c    |  7 ++++---
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c     |  5 +++--
 .../x86/hp/hp-bioscfg/string-attributes.c        |  3 ++-
 7 files changed, 38 insertions(+), 14 deletions(-)

-- 
2.55.0

