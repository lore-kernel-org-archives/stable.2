Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8832B9B5
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783181312; cv=none; b=mzE5/c71buI6CM/oUvGnG0szYD/Zwo8SGqUUmwsgYFBbArbX4iVU63c7+SA2J4CSfdxTiv7W+YboGEJB1B9RvFDIbuHn6Ne9MyFAAdkzJtsyg50V9ZavIPl+ngOyR/pxMS4ryEnZBefKRRyBbNqCeGMfi8Wt/8mKVOxNvBZj5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783181312; c=relaxed/simple;
	bh=XufG0eQZ8fmWPRjC8fo6ZVGZ05g2/hQ5aQ3eg6xYeK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QYMbnVVw0yxwmCmuaDtCFuKX1ECWwrXHkV//SVn6vv2bZxgLH7pWD6ah6xk1UJqaXkj58bSg5pqbpc1hhebdpThA1htn6GDqU6+YBgTv6ZqYqXLxB7GZzkA3ZH5C4kzskfJUmpFwhg864RDAOffXo23aGdnRC7vcLMxqqdyK2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGG3+Nm5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGG3+Nm5"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6983d3dae7aso4004981a12.0
        for <stable@vger.kernel.org>; Sat, 04 Jul 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783181310; x=1783786110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qrg4okzbbX4Q+s6vcJ64+r7iRqbYqBLV4VypMj2S+k=;
        b=WGG3+Nm5FqLYAlHuC/azIEw2ULaf2Ao7nnSHTcCdwhsJ5gDw1QETjA0P3oHbkVevwe
         LIvBx4oxPxaghPMYVC5IXtsJ7t+s5338YZ2LDeiKU3g+snEl1xE/E0ZbsQy0zlaaPjVN
         mLeW6i8z9dDYSPbEcWr/uuB4DxhjaIFutqzV8KDcyBtnOM9syTwfNZMWuXbTGFIgTSHx
         xfb7/LJ+Nn4HFxw3mVyPCSNMr7tvso8IQcgeCfLxGb0uBiEawDO5qdVsdGDcA9YiC/l/
         9U7V3y2g98ki+VqqOfZvBJaT77RsklnJbjmo7iBhh81LaA2rOQCzaQy3GouUFSLaDF5q
         y//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783181310; x=1783786110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Qrg4okzbbX4Q+s6vcJ64+r7iRqbYqBLV4VypMj2S+k=;
        b=HyLaV+2qQR8dxE68xA9n5fycK+zaSMvMhTJO/hD66P1iJao00zgB/m3z99h8yeGf+W
         iJdaT8jHEXVsh38uOqimhtHUUamb5srXFqj73Jg43ri59uiTT+Omdka0XUEYLeJHB/q8
         +QgffkiYyC2oHtDm4QsrXnhdo/roaQWBLJXopXNkwmWvt0YH/Qz9CDLu0H7c2SpZ5SKZ
         RKCUxk/oVKNZg1f43TXMItCuDETtr2FFN12l4UDkOWR8A9RbmwHUjTXLdOsVR+v2+zCG
         oe90OPtLKzhYydcbJWrn+B0gfs0eH4ilaiRa2A6R2AxF81Pj6xcHGxbRQfFaxmMtUIZz
         L/1A==
X-Gm-Message-State: AOJu0Yych1UUfFdnq5JaOCEXRUXSk8OmESYipbwk53/VL9kCl2CLzQ9a
	jliCdILccMqdvL0ZxGoNBxKfiVYsZrJa0LiDQrESWti82pEf7XDaOgKw
X-Gm-Gg: AfdE7ckXrCwmuOqAh/sWUqqSkdMzHGDYv0koshBnOt8O5F+LF833Np49d02P+wH+7rh
	o0Ox1ndVjt598EOKUZuvKVHhDSW1eI+5KTJygkz47uCvgcb7y6n3qAxKoOQ1OcSKfTpW56jNysU
	rYAZYOBh1vvE0cyk49DqPH7zMGhe9+ChywPQtEHgRvziyHlJ67Awd4SknRKSIPPTPuzlTwzGZU+
	owqe7/curDpkk2pERTXQOhDkwzIqkPfUMO4rQNQJicZ7LUjC0OqI176wu4XDdnn1qB48z2vXpr2
	sXgJd0h/6dM97U6uYnQhj5gXkMfvPCOwJaINPhZGWIedV0TnEKkpUmjr+V7rbR2tbdHK7tYJ6TK
	fsqNnlp9S4q9XTe5/PuwzTHkbwViNjqPiNlG2SWT+tgepsvnuoU6kcQeANJtVsFnkf9PmDhKn2u
	QEdTIhiSm2CVK3/rOU2eWbmjB00lK3R7heYgz3NfxLummAw7dIfO110uOj0/MMI+o=
X-Received: by 2002:a17:907:c518:b0:c12:b0b7:def with SMTP id a640c23a62f3a-c12c9d6bae4mr379868066b.14.1783181309628;
        Sat, 04 Jul 2026 09:08:29 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm438586266b.9.2026.07.04.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 09:08:29 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	Thomas.Weissschuh@linutronix.de,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 0/3] hp-bioscfg: fix attribute enumeration on older HP BIOS
Date: Sat,  4 Jul 2026 21:07:56 +0500
Message-ID: <20260704160759.236249-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hp_bioscfg driver fails to enumerate BIOS attributes on
HP EliteBook 840 G2 (and potentially other older HP models) because:

  1. hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
     contains fewer elements than the per-type expected count (11 < 13),
     even though only the first 10 common elements are required to
     register an attribute.

  2. hp_populate_enumeration_elements_from_package() returns -EIO and
     discards the entire attribute when any single element has an
     unexpected ACPI object type - typically after a BIOS AML error
     returns malformed data.

Hardware affected:
  HP EliteBook 840 G2 (DMI: Hewlett-Packard HP EliteBook 840 G2/2216)
  BIOS: M71 Ver. 01.31 (02/24/2020)

How to reproduce:
  1. Boot a kernel with CONFIG_HP_BIOSCFG=m on an HP EliteBook 840 G2
  2. modprobe hp_bioscfg
  3. Observe dmesg:
       hp_bioscfg: ACPI-package does not have enough elements: 11 < 13
       Error expected type 2 for elem 13, but got type 1 instead

Changes since v1:
  Patch 1/3 is new. Relaxing the element-count gate in patch 2/3 (v1's
  patch 1/2) lets packages shorter than the per-type ELEM_CNT constant
  reach hp_populate_*_elements_from_package(). Those loops don't bound
  themselves against the real package size - each one re-derives a
  "count" by reading ->package.count off elements[0], which is always
  a string (NAME) object, so it's actually reading ->string.length
  through the union. That was harmless while the old hard min_elements
  gate guaranteed a full ELEM_CNT-sized package on every call, but once
  patch 2/3 allows a shorter package through, the fixed ELEM_CNT loop
  bound walks past the end of the real elements[] array - a heap
  out-of-bounds read, on the exact EliteBook 840 G2 hardware this
  series targets.

  Patch 1/3 fixes this by threading the real, already-validated
  obj->package.count down into every hp_populate_*_package_data()
  wrapper instead of letting each one guess at it, and bounds
  hp_populate_ordered_list_elements_from_package()'s main loop (which
  previously ignored the count entirely) the same way. It's a no-op
  for any package that already meets today's ELEM_CNT minimums, and
  patch 2/3 is only safe to apply on top of it.

  Patches 2/3 and 3/3 are otherwise unchanged from v1.

  Thanks to Mario for the v1 Reviewed-by, carried forward on 2/3 and
  3/3 since those are unmodified. Armin's point about migrating to the
  buffer-based WMI API for correct marshaling is well taken as the
  longer-term fix; this series is meant as a minimal, backportable fix
  for the immediate enumeration failure and the OOB read it would
  otherwise reintroduce, not a replacement for that migration.

Testing notes:
  Tested on HP EliteBook 840 G2 running Arch Linux kernel 7.0.13-arch1-1.
  After patches, hp_bioscfg loads successfully and enumerates available
  BIOS attributes. Attributes with shortened packages are partially
  populated and accessible via sysfs. No regressions on systems that
  return full ELEM_CNT-element packages (patch 1/3 only changes
  behavior once patch 2/3's relaxed gate can hand it a shorter one).

Relevant dmesg (before fix):
  [   11.xxx] hp_bioscfg: ACPI-package does not have enough elements:
              11 < 13
  [   11.xxx] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT,
              Index (0x000000032) is beyond end of object (length 0x32)
  [   11.xxx] ACPI Error: Aborting method \_SB.WMID.WQBE
  [   11.xxx] Error expected type 2 for elem 13, got type 1
  [   11.xxx] hp_bioscfg: Returned error 0x3


Muhammad Bilal (3):
  platform/x86: hp-bioscfg: pass validated element count to package
    parsers
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

