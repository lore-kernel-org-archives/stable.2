Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277242C514
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533520; cv=none; b=UhQGzhAG9ZdWDvdMLKrExHIU4Fg96JyY9pxfe4HttL34VwrsDrqTCCDnOeiOS+kIEbZm79sYuR1yJEDK4nBR43zBdkIIoa0P87hbrnIdz81mFEWjMUvaPkxgDawPqf00OID1UliJD8jB7kFRYqerAXUYEdAL3IKuuJplWacAg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533520; c=relaxed/simple;
	bh=nZfcP7ec20+jJPypMsovWsVU6clTzLe6WpociuNIKE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXhcYyeJl2hK4JKjgrZyLDYCXhCBUQsUH9DtLYQ9f7Y7gbSWcT/shD3urN4GpHbFAXjdf99xFjTgv/9OJ1y/RrCxklOuwbiij8uS+AAOOXW/plxFdqhuLhWJXa6wnNbTlh5OqEbm+eH/3d8FFuhgFQuYAfUhamO5VHhshdODSac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmfrZATF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmfrZATF"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f84023916so683209f8f.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533515; x=1787138315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtyM3i9ZempSiYMa7SjVc3SAfE4udDTSj1TFolVkZK4=;
        b=WmfrZATF/4/HkWDiWE8p2uLGWkeAiN0S/fDhbxsvsYnVNDp5P0Xb4fUstfl1CBce4o
         VY7l3fTa9FGFe+xkCSP11MpeMUZx97pgR/moPYIjnDV5mIKZTMfjfSTMRzzbZwabFjf6
         DS/pHhUSv4KXMBVbPSrnUGTuzNT9c19aspkDEtXTvHWn8+vSIPzQeE381XwomjzRwbRi
         LbKuNKh0wdt6EP2df+YvVD8WO5lKaojgZeSvlSrjtcO0vxyr0KCxAHWh0tMpYmJYgAB+
         U1lW8IphHz1NctDecqNRjMUzLgBwgWtymaAeeiQGFqw3iIeZUarAWfsGNn0GPRokBjOX
         PDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533515; x=1787138315;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MtyM3i9ZempSiYMa7SjVc3SAfE4udDTSj1TFolVkZK4=;
        b=bBK3m2fUkyqdYb/QxMBLhTsKGWvLqU8k4yDkQbuuglD+k4Tdw5nRakxdtyhJDF9/ks
         9DWDest5MYqwjh0UAYxdvZy0UJYRm9eq4Dw0ZVsFauNHcwMr6StnCPCzV4uhmzD8swL6
         r+C8nh5E0bjjphbEt9kwCK7eNjoLtZMTJz//ZgwPXqWkFHTzRXb+lXJmHGjfQngM7guC
         CdTOQMtODpVtn8dU+5Yanmbw63xYSC4DS8mkp5dAlMbijIdJ42dZHZbK3raq8q4DXgeO
         lkuA51/DhL2nuCzsUOv+erRXsCkETef7o217XhvdMzb70VTT36I+FVUlMqMej4S4fKq9
         RtKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1bxJ9+tqwyjqPgLqBS5SNt0IdnhWYaqFVPaQTsHEqId1SV7APRq3dIpfO+mqv3GS/A5f4KDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xuLZaw4bR7xbIDGus/71++QdfP06nGP3rvcb/0+C+inOL+PU
	hqCCPI3nKLsft4cxmGflty+k0HGwjzUSPIUmN8Ir/BtyvAaeqFFjqIjY
X-Gm-Gg: AR+sD11RMQvw5633hBlwAyJjeKMM2TVZfiwICxXQe13A6cQxm9lq9xmrab90GSu5Vja
	7ajeHZN/WwfdmcTVP2PpWCQT40vHg9KUxWZFWqheGnqJ1GTM6RCWU9tyqC5kbLF1dLXfrR1tzW9
	RDD7myeJWlO8YTzWfSsDvxRnRZHy/uTxiamuIdYBUTQBwMd6EkcgkPiJvRTHZOSXZ1+npD3l+2i
	xglGqENqezHneXn1nlvxnHwIsdZvHVskd30qqXyzp/l55/bJc6/+d/tF7J3pPPUnH1S7hqxuo6z
	RocdvJajKtUysdocFTF8Efwf2xnyPr0a99er9BEb+Bl/bx7fIpGA388ClcCFUEKOkUlrmtxsjCv
	CQMNyj0gaeGJWbM/kjhccc+4ydXO+nSAfikXlFTi8MhMjbtKmJiDBbArMkkch0eXkEjFJyczyuH
	yaAA3dpew0NSbdjNbsaF2mWyP16RlABNHSd1Qmd6D+qFaSTP5CB+5XTgDyPi2d6tDf0DsS7GpZn
	a6was1AnmcOVeA+FpCajY0hzVpLIVNnef4NBv7U8g==
X-Received: by 2002:a05:6000:2210:b0:481:4f2a:bdb0 with SMTP id ffacd0b85a97d-481528f72fbmr5392560f8f.18.1786533514630;
        Wed, 12 Aug 2026 04:18:34 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 0/9] platform/x86: hp-bioscfg: fix multiple memory safety bugs and parsing errors
Date: Wed, 12 Aug 2026 16:18:20 +0500
Message-ID: <20260812111829.172273-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This series fixes several bugs in the hp-bioscfg driver:

1. Memory safety issues (patches 1-6):
   - Off-by-one NUL terminator write in hp_get_string_from_buffer()
   - Heap OOB read in sk_store()/kek_store() when passing original
     count instead of trimmed length to hp_wmi_perform_query()
   - Heap OOB read on empty password write in validate_password_input()
   - 16-byte heap overflow in hp_calculate_security_buffer() for empty
     authentication tokens
   - Off-by-one heap OOB write in audit_log_entries_show() when more
     than 256 log entries are reported
   - Missing bounds check in the PSWD_ENCODINGS parsing loop

2. Logic bugs (patches 7-8):
   - new_password_store() incorrectly passing is_current=true, causing
     writes to land in current_password instead
   - ORD_LIST_ELEMENTS case using a stale NULL str_value pointer
     instead of converting the current ACPI element directly

3. ACPI package element index tracking (patch 9):
   - Five attribute-type parsers (enum, int, string, order-list,
     passwd) all share the same defect: multi-element array cases
     consume "size" consecutive elements but the outer loop only
     advances by one, causing the next iteration to misread a
     leftover array entry as the next property and abort with -EIO

Tested on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31), kernel 7.2.0-rc5+,
with CONFIG_KASAN_GENERIC=y and CONFIG_SLUB_DEBUG=y.

This series applies on top of:
  commit ea4d8f8ba283 ("platform/x86: hp-bioscfg: fix
  slab-out-of-bounds write in hp_convert_hexstr_to_str")

Changes in v2:
  - Squash patches 9-13 from v1 into a single patch (now patch 9),
    as the fix is identical across all five attribute-type parsers.
    Requested by Ilpo Järvinen.

v1: https://lore.kernel.org/all/20260803143037.93105-1-meatuni001@gmail.com/

Muhammad Bilal (9):
  platform/x86: hp-bioscfg: fix off-by-one write in
    hp_get_string_from_buffer
  platform/x86: hp-bioscfg: fix heap OOB read in sk_store and kek_store
  platform/x86: hp-bioscfg: fix heap OOB read on empty password write
  platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth
    token
  platform/x86: hp-bioscfg: fix off-by-one heap OOB write in
    audit_log_entries_show
  platform/x86: hp-bioscfg: add missing bounds check in PSWD_ENCODINGS
    loop
  platform/x86: hp-bioscfg: fix new_password_store overwriting
    current_password
  platform/x86: hp-bioscfg: fix ORD_LIST_ELEMENTS never being parsed
  platform/x86: hp-bioscfg: advance elem past consumed array elements

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c        |  2 +-
 .../platform/x86/hp/hp-bioscfg/enum-attributes.c    |  4 ++++
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c |  2 ++
 .../x86/hp/hp-bioscfg/order-list-attributes.c       |  6 +++++-
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c        | 13 +++++++++++--
 .../platform/x86/hp/hp-bioscfg/spmobj-attributes.c  |  6 +++---
 .../platform/x86/hp/hp-bioscfg/string-attributes.c  |  2 ++
 .../x86/hp/hp-bioscfg/surestart-attributes.c        |  2 +-
 8 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.55.0

