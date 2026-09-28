Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E114ED1A8
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625813; cv=none; b=QysHGsIX5eqV/L3eS5AYlfhs5kHzc7RIfknKn9sIDxgJ/v7Je2KyAGpCysK8+BldCV6j2vHya5v7fJt/AsryGKBFsWQKA5nfd0efXI3CATK28YzYmmAnpw4Re88D7ma3NHhkqy/zY+jyQNq0YPH7dqZWdSm1g7Vd1dXCvD0qZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625813; c=relaxed/simple;
	bh=e79APqvYPYxLoCGsyadc7ocTHlw1rax0P3YjVlJP9aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hu1yyeO2eoopmzd7XA2H4RHBWHhT9SYBk9UaPCeqgMMgb3V6E1drtOfFv5rLoCb8Kq/hUvc84Zt+c75WGSxXh/20qG47JaMc8wjMrF8BfUf8lmnMZ3BCpR5UNDT6LmWmlJnIVGeOqRmhLP/exYVTvRcRv+X83dBFUuOUQf0UiR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhwxdpee; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhwxdpee"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so17749875e9.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625810; x=1791230610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CViBSPtF4LBYd0VEUs46UXkR40K1KrpVeCYIgI+4SRY=;
        b=JhwxdpeejmUWvh3medXcyG14siz1WJ5edbK23U5KTXeIQLhj1cmVqsM5u51jnMUPdK
         I/haRMc+kvuL68gOabf8rKM/zpq4ZVF+pmYY3jHWHbfFIhFKcYbKagvbVfwquGrZLsCY
         JBk54NpC/EEH7ELoZYjQT5lq4CAJQkYjKu7ijETpHzk3oUkbBTJjNdYg/qNaHwboV6Fb
         f5Jo9CgLsc8yJ7dAbOsWJuegC72DG6Tm0L8KdqmnFYYQB8gdPcaq+dI6kar5BJ9rOgg0
         zJdrY0MdG+MyNzq6sYuXtuRmhdkWL8K4K3wVQwIB7+G/gAs4AZ2bsMAcUN8xPVFEfaBC
         gUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625810; x=1791230610;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CViBSPtF4LBYd0VEUs46UXkR40K1KrpVeCYIgI+4SRY=;
        b=wmyICIgeLBei+PmF5X6piYUrJRjm0ZXJsHOiJusRq83VuoRX6QfJujXmnwOzErGT19
         q6Ql/+SPRET2DHoTZdf5B3L1gyu61ks68lh3Jv4HDhaDkh9oe87wS79GNWy9v1Zu+X/L
         uTsivmattzpDiUrbgweVN6EHm/u4LheNVnwW4dvxeCVZBenEcycuCYe/PcgT2lmL+XMh
         /nBp1J0LWzEKpXjaMfiT0HlOr4cr+7vYdaKEI1mioeSkn6M8IhpImgG9+N7JnfG9FXIf
         LZx26mWLxJRGyl+FCT9FSRfV2us1HfxmDjHOW6Snar8GwrTZCzV8usqhSLul3iQIUu0K
         bjVQ==
X-Forwarded-Encrypted: i=1; AKwUvBydRyuHSib4hui4suuC6MO4by4VjkAsMiHHxU7g1TV5qVdV3TyH1VNyOFtJ0ZA2l6Nf9/5YYJc=@vger.kernel.org
X-Gm-Message-State: AFuF++m4N4GDev12JLETp1GPALy7BeAaUmv+0LlZzud9ZmDcp0ypqDbd
	dd+SylJQpNasYo5j9I53KY42UXHFSya1vhqJyzMaYwIlHAw6kHGfFEXd
X-Gm-Gg: AYBFou3vCjqqMaYOZpQowqaZijt+hQFfdjhY2i9clBgd9w7Fk6DyltrsAoqIob48k0C
	Eosl88cYRTjMMWxUjYM2Gahy0YIgkWXn4RTLz7DyCZFC46NevqR3MaFlmlNNSPxWQpjeMvUqmpP
	TSYozbgDKZD/UBrSJEHOdxeYhwbh1dTfTwh2fUAGr67vrqC3nwGzdULVUjayQfUA1R/rOCZCCVq
	nE2PgVggu+o3Cmuh1+cQTtAdxTkros8OS9LPaA+AOn/zB4ns5MQ928TKzgBwd9w9n0/INwtWKP3
	uKbPYEHc1H12U3+U6ruCUEwn/rOvhtvFj8QqaS/81LbwrPSm/e/Irkq4Uhhr/Znlnxz0tdS+BXa
	lmK/AwbKyyemEucGDSICqUtRX/262D6a/Q0T3XUhdweKmIH5Ig14/X9tm+MPr8k2/J3CmNdCsHp
	GCkCU5jQP+42MzHU4TQzDphy0r7YRT4IZkZrll0McZICrAJmHzPgdJ5FD3RNFPFjLo9eI8yS6BP
	NaGqD/E42buIQR4dLEqg+MmYdwMd/Wgj8SU5ZgblAy8CqCp6uKk
X-Received: by 2002:a05:600c:1389:b0:49f:dcc8:c735 with SMTP id 5b1f17b1804b1-49fe66f4c7dmr234761645e9.18.1790625809613;
        Mon, 28 Sep 2026 13:03:29 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm26506625e9.0.2026.09.28.13.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:03:29 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 0/3] platform/x86: hp-bioscfg: string buffer and password fixes
Date: Tue, 29 Sep 2026 01:03:15 +0500
Message-ID: <20260928200318.63383-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses string buffer issues and password validation
in the hp-bioscfg driver.

Patch 1 fixes bounds checking, prescan OOB read, and character count
accounting in hp_get_string_from_buffer().

Patch 2 replaces the truncating manual conversion loop with a two-stage
conversion: utf16s_to_utf8s() into a scratch buffer followed by
string_escape_mem().

Patch 3 fixes validate_password_input() returning positive
INVALID_BIOS_AUTH (0x0E), which caused userspace writes of
out-of-range passwords to appear successful.

All patches tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).

Changes in v2:
 - Split hp_get_string_from_buffer() fixes into two logical patches
   (bounds/OOB reads and UTF-8 conversion rewrite), as reviewed by
   Ilpo Järvinen.
 - Dropped lib/string_helpers patch: pass "\\\r\n\t" to string_escape_mem()
   with existing flags (ESCAPE_SPACE | ESCAPE_SPECIAL) to escape the four
   characters without altering quotes, as reviewed by Andy Shevchenko.
 - Added password validation errno fix as patch 3/3.

Muhammad Bilal (3):
  platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
  platform/x86: hp-bioscfg: fix non-ASCII truncation in
    hp_get_string_from_buffer()
  platform/x86: hp-bioscfg: return -ERANGE from
    validate_password_input()

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 77 ++++++-------------
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  6 +-
 2 files changed, 27 insertions(+), 56 deletions(-)

-- 
2.55.0
