Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCBD3126BF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616349; cv=none; b=jj6K53trkmgBlzYLJnVRLgZr7NN+kjywCD09JcVgz6BKdN9Di9Re3ORGJRf80IcXZ+NlDSMbsfJ8GdldpLYJHy3TreCtEICdsqlfq32eeY1RRWSeAihouUe4gO/clKP5Rbtzc3KjYR+ckwYBg/+LF1weQjPfXfof1qQvLQL/rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616349; c=relaxed/simple;
	bh=k53K0dGYW6Pb3pIUktGIXVCEU3Cc2tu3h7vVqnQbdyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aFHOO3psR/9tn72pCIb3ssrrUYtxW717/8KvKk4yzmVAWd4iu57/ujcnTjFz3F8WwZyHU86UofaZr3/R9VORuZ3W9GF5dFr5dBffymx8HeO3MbpMmSCatSvBNc/K7y9tMvz0YB4HoH1IElbPf/pqbiitPhnyU74HeqMa0FGuTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqxWw0x0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqxWw0x0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso228036a12.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783616347; x=1784221147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xt6DhrngYbZFM9YuEunJlGx98mys1Ug0XoEi11S0kAY=;
        b=iqxWw0x0SByY/UqbtUPlG59WUICweiV27gkzyryhIEmgLPYCIDvS8lTRqcfK4xF5Qp
         Vs/krr/RaSunLICmnxic9kfS/PHIGeh87YdgifoyVFpyTOmAK+TI5lxVxVbcGfrcGvXX
         2cGDCWZBxLsj8Smp1TIV869K1O2Tqwt0dTPMUALxexIH5LIWNfbM2cHBIkZZbg2vw26L
         eR8irfGGcnaIVMKq4kMV3XDd5VXiyOZk7QSfkqi3813kP7zqzxz9TRBOEAWNrz2qqjXk
         0Knj/HTRjB8ys2o1k3L2Fknd/1uirldZDtcoiTL1anXCy4bX9O+/natzFBMuLH5wz5qK
         i4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616347; x=1784221147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xt6DhrngYbZFM9YuEunJlGx98mys1Ug0XoEi11S0kAY=;
        b=G7GM1dzy8tE6vG6XLbb2re0NlzUj6Z3J7iiJ7oRDclo0ecypQtFZvmbjQqXPQFnrBQ
         ZNZiKn2K8NwAzDvaYgGEdWmUnYAH92N5EFLTUa93INCqixiDkN/w3i9UHDrt7wIsp8ZR
         pbd/gcvxx6mr0qHiOARvwl/iUDdz/sfZLgV31yQaPGNJyaT4d5qKixN8r0IptOEbF9cg
         Rth1h+M9NaNrs8Qb+hKW2TOGzDXez5xoUhnx5z2CKChbo0fAdbEf5i+KjM8jq7WRmaCJ
         cpbT9RWV0kJqE4MW2+8pVp6w/oqmkv/wpI5gdbA6dyI0Orzq1auPqmsILafA4pykPVHt
         2Wgg==
X-Gm-Message-State: AOJu0Yxh35xDuzYDXk8DEea3RUU8qkhVSCZQXm+RhjSSKDaeLg93VTkz
	aAMrd/Ez/uqx7vnlHAO8hXYK5CBmhOzrKVNkCMZ5zkOCB2dnyGph24oG
X-Gm-Gg: AfdE7ckGyU77+GOJDTCkgoi3PWCXdTgNRlU+vprd7+FkPasOjf41KYfIOZZSuJDlSTk
	/MKWSzKO/jwTsF0YEBvsNmxGcex8wL9jpvkMCvEYWZhMHkFrJ4KmBG0j62gPDqSypf+SmOsBsyX
	JLIUT5kkxH/Cka5Ox+vu8bI6erPV+sj5AjsI7NLS+wG00n9qqJeywjt8hKLKZ6FLFEleGWxxV2k
	Z2CBQOOj/eYIoariGrwE3mPTBFsF/dhPOkE+sDpr66jqecYFhtsueSZ7sk0nMNOfnpzTk++OvKK
	x3m9tjRawdPdjxUR023FCdBLmlpB4vm4GpJ2EbGiTPCQn3VQ7IFRvPwApzICKKFwNMJvg6FlxFj
	Cbp9kPLSVpCKy6ILw7GpWkAMI4wpU2/mfAuzspgHekY1tAdDW+KAfpsabnWbrdwCCLXrwywaEX8
	9MncLgUjbIROi62KEPuaH+vDgjzWU6ZoqhIsaKV5+q2fx2SRCydTv4NQwJPoCPBK8=
X-Received: by 2002:a17:907:a2cd:b0:c12:6280:33c9 with SMTP id a640c23a62f3a-c15fe8eba70mr3124066b.28.1783616346420;
        Thu, 09 Jul 2026 09:59:06 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15c79f2a3fsm329902666b.49.2026.07.09.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:59:06 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jorge Lopez <jorge.lopez2@hp.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v5 0/4] platform/x86: hp-bioscfg: fix ACPI package handling on HP EliteBook 840 G2
Date: Thu,  9 Jul 2026 21:58:55 +0500
Message-ID: <20260709165900.30615-1-meatuni001@gmail.com>
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

v4: https://lore.kernel.org/all/20260708154846.12356-1-meatuni001@gmail.com/

Changes since v4:
- Patch 1: added missing kerneldoc @foo_count entries for the five new
  parameters. (Ilpo)
- No other code changes.

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
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c | 11 +++++++----
 .../platform/x86/hp/hp-bioscfg/int-attributes.c  |  4 +++-
 .../x86/hp/hp-bioscfg/order-list-attributes.c    |  8 +++++---
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c     |  6 ++++--
 .../x86/hp/hp-bioscfg/string-attributes.c        |  4 +++-
 7 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.55.0

