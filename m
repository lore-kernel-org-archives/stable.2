Received: from mail-wr2-f37.google.com (mail-wr2-f37.google.com [74.125.225.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A68360EF9
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789797659; cv=none; b=N/ycw6PNb97PNDGKq+VEZCegosDHosreFS++BgGiVK5Jmtc4ZXzXXVSGOURO2OrjXmQLRB4RXGrUZJ9eOdRz5qKeNz05X6qCvni0W1nrMyB4v680/5Ix1NT2xsfmKu1TzQYIzsfkQOuwFTulYf47++aH54tWVac66iie+0L1YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789797659; c=relaxed/simple;
	bh=Jy5TaLrwRqkwt1UO+ssRNusHMelPmB+dJLFY0YgEd2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqZ+LfatvEocwYHQGJkD5Yr+vYZPMtIqFX9lzoAOQkVeds+zN80vhKoi02Ez1s66ybNFFtjSG+8ZvQvHZbsTTQq+OV2iw61/x5TZ1jFqxNewuX6sDFPo+L6QcZrtb3OQJXmD0BtUexh6dp5gDj3lpUrTThFW74wzdjuRhhk4u98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1xGSEwq; arc=none smtp.client-ip=74.125.225.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1xGSEwq"
Received: by mail-wr2-f37.google.com with SMTP id ffacd0b85a97d-482f6356f6bso1123304f8f.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 23:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789797655; x=1790402455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pMviqo4XEkPwNRzdFDIqATmDkxn/o8ifOVjJBWoYCzQ=;
        b=R1xGSEwq2VEZ8A9e+m6LrHHkVkkR0ZsdGuZZ/jOQNKibDBXBKT1rKQhXfBJuTgHp3R
         IyWmj9+fsRzTaoMjeLY1Sfpjjsz7hztfvgGPjHiIBvPD9IuMRiiZchgWz6xp/vEspDZN
         B/+JGvJYBPiFsxhVqPNZLJwRHHVAe1ZiItrRGCQIBPC/bPOZm8/ctaSYrtKa0COk9fPQ
         3lJN7i6KFuDnmQYWhWXiRGwxcBgg48Suh2kLK6t5PZZVi1qrRptQXNueRJ1KyHFGTScJ
         Bt7Klo5Jq8Bnf/mATPeGQzutF6OIuWox/oI8YWzKyylKtYUHnKwyiCyCgHPd5O41txyL
         MZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789797655; x=1790402455;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMviqo4XEkPwNRzdFDIqATmDkxn/o8ifOVjJBWoYCzQ=;
        b=adhvrevnoeAMX2uUlzV14FkGxZCrQvYODj2AZFPYtEfNMAdVUOu6KFQLDKFmknYYwg
         HVPMjoAaGN1P2qbrSUF56elbKKlz49oEmtrT2s24aVp77kmVoDLhFDj6KSCWSdZ/wTfW
         EmLWdHVp9QTQPDzKkCLJh9VvijBPGezmmSZVRqgVjTPB9tIL2HmHCB/gX+pJNYDaIJAg
         eWl2tjepclz4yi9HquT4F0xV3AWO9vW1Flz4lHYerGJMAvHG/f0bHeBhfBQdFImDb7ff
         U6VxVdl/ZhaV8llohIxf2O6/5hXm6eCSBDT5YqGTBHdhiooRDa5r/KUF/Y0M/kBz02RY
         5Ghg==
X-Forwarded-Encrypted: i=1; AKwUvBxXfi7L/R4YjTP0GFZQVZS8Zbtsd8g+Wjrs7wpNkEDmwqEWaosLzg4jwOnzrL7mvW4CwP5DEZA=@vger.kernel.org
X-Gm-Message-State: AFuF++kMWwVKMM/0TOlDtnBSfnGC0n1u7Z/eX5bNzaLiC9Sx5pS0jWdE
	5NWVElVm2/uAeGYQUwILfSOOUTKaj8Y+NzGK0+tNVymqO8W+icW4ZrVJ
X-Gm-Gg: AYBFou3wURswkq9u000Lb16/SbrMCVXD0ai9gpwOm9O6oLlYwEaq2IOWz2ZMWOkuG6g
	mN/nogSyRRCXittWNwFs9ejktpGu4cuq4gnthZfm+pLe+pdIaGHFXxiTP4lNnf86etx2ri49tl2
	U53w+dS44LU1A1Haa+6jDk5grG0f8gl20So2HEOL4syjkMbcrWuzVorExjwleaCEfjrq8Qb9x6E
	jFjcGQFCmGJ/wnHjXp3SZLJsC43Z/BLYpM0TIw6R1juuo9D+xVG9FnS25hy6IRRy//dx1/Gwkrl
	CQ7PdwyqkiMSpa0o7M6GPc+9U4MOeNqlXKzkgo0YwQpAi8gUaHHWddlBSOjH6FMiqAPjtlsTKcU
	YK817Q2hPGUrom6qAEfGAJFLHEOqEFeT1XeJAKxRUVekXXIvWq9bRfO+sxewNjAXkqrBeiOAylf
	HohcDgs9neDVipwIUN9jYmAEkJV9JAsIYRoeUzJi6T2+HH1LMcgrZcXtnQfkmbTxFwIeqhWshcK
	JwPF3GgcBssOioMS8+qonOuJT4/MbROZj5JaaRYQK/Ibd8oUBc=
X-Received: by 2002:a05:6000:2010:b0:487:27f9:82b with SMTP id ffacd0b85a97d-48727f90b71mr525893f8f.32.1789797655106;
        Fri, 18 Sep 2026 23:00:55 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456301dsm4891022f8f.18.2026.09.18.23.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 23:00:54 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	Josh Snyder <josh@code406.com>
Subject: [PATCH v4] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
Date: Sat, 19 Sep 2026 11:00:37 +0500
Message-ID: <20260919060037.84602-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <9d60ef62-a53c-bb13-ff6a-0a195cf2f6f3@linux.intel.com>
References: <9d60ef62-a53c-bb13-ff6a-0a195cf2f6f3@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

hp_calculate_security_buffer() special-cases an empty authentication
string and returns a fixed 4 bytes (sizeof(u16) * 2). But
hp_populate_security_buffer() does not special-case that same input:
for any authentication string that does not start with BEAM_PREFIX,
including the empty string, it always builds "UTF_PREFIX +
authentication" and converts the result to UTF-16, writing a 2-byte
length header plus 2 bytes per character of "<utf-16/>" (9 characters),
20 bytes total, regardless of how long "authentication" itself is.

The caller, hp_set_attribute(), sizes its kmalloc() buffer using
hp_calculate_security_buffer()'s return value, so for an empty
authentication token it allocates 4 bytes for the security area but
hp_populate_security_buffer() then writes 20 bytes into it, causing a
16-byte heap buffer overflow.

The authentication token used here is the current admin/setup
password, which is an empty string by default until one is
configured. Any write to a writable BIOS attribute while no admin
password has been set reaches this path.

Fix by removing the special-case early return for an empty string in
hp_calculate_security_buffer(). The generic calculation that follows
already accounts for the UTF_PREFIX correctly, which naturally yields
the same 20 bytes that hp_populate_security_buffer() writes for an empty
string, avoiding duplicate logic for special cases.

Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
Reported-by: Josh Snyder <josh@code406.com>
Closes: https://lore.kernel.org/platform-driver-x86/20260402-hp-bioscfg-overflow-v1-1-6985f8c9e67c@code406.com/
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v4:
  - Straight re-generation against current mainline: v3 was written
    against a tree state that had a duplicate "authlen = strlen(...)"
    assignment (one copy meant to be removed, one meant to survive),
    which current mainline does not have. That mismatch is why Ilpo
    needed "special trickery" to apply v3, and why the manually-applied
    result ended up with no authlen assignment at all (reported by
    kernel test robot). The v3 diff itself was fine, as Ilpo confirmed
    ("authlen is not uninitialized, so only the early return should be
    dropped"); this is that same one change, regenerated from scratch
    against the actual current tree so it applies cleanly without manual
    intervention.

Changes in v3:
  - Remove the special-case return entirely instead of adjusting its
    formula, avoiding code duplication as suggested by Ilpo Järvinen.
  - Credit Josh Snyder who previously noted this approach.

Changes in v2:
  - None for this patch; resubmitted as part of the v2 series.

Link: https://lore.kernel.org/r/20260803143037.93105-1-meatuni001@gmail.com [v1]
Link: https://lore.kernel.org/r/20260812111829.172273-1-meatuni001@gmail.com [v2]
Link: https://lore.kernel.org/r/20260818191120.38556-2-meatuni001@gmail.com [v3]
---
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 4d94e48..abf8ce2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -47,9 +47,6 @@ size_t hp_calculate_security_buffer(const char *authentication)
 		return sizeof(u16) * 2;
 
 	authlen = strlen(authentication);
-	if (!authlen)
-		return sizeof(u16) * 2;
-
 	size = sizeof(u16) + authlen * sizeof(u16);
 	if (!strstarts(authentication, BEAM_PREFIX))
 		size += strlen(UTF_PREFIX) * sizeof(u16);
-- 
2.43.0

