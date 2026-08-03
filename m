Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFC314D0D
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767467; cv=none; b=U5k9xNHW1lb/uG0EJ8Hb2XEDsfSlfVDogVCi2S6mdoaq8DdfhpS+1iEGAPYrJe6kNfO3SY6YkBAOJsNLRb+PiPHTes9AOIaqFg5XCdSOy23RK2HNjJR/Nj9RoGzx4kF2gYNSsCVF7N0p4Bm6Jp2cD3gQkRjFOAiUwfuaC0MfwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767467; c=relaxed/simple;
	bh=ATKvWl1DnIWOGmblRvXvDZPEp2qoEl7qqfbdLw7wl3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNOxl0T+OSnvEl5sD1BYGyyruZbSYd4xMJX6Y5ey7TyK4HsIj9LrwxsoxcxrowRJl/n7esUP43ZmKN4Q+VDjMr7qrro9EQhFqajHXwJ5O1fGsNokcfq5RqX5sjwM3aKuWQYEu/FaN64fmv4IZQKsZOV4HemCZFcZ/Lwd1RepApo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/kKcjoQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/kKcjoQ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso14536345e9.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767460; x=1786372260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsPuPtlEtpcGKckM/9mBE7kyPjRyXeXRo57w8zpUvug=;
        b=q/kKcjoQurIZJba6iduZ88NlhqYGrmWV436lC2J0r0OgfmhlU7HLHy/ChZnQzH0E+0
         qbxbaWsVedKx0nfbGxpenB1MLHF2P07CU1sowJP/YxrDtrZ71bDRX+naeA7h7EFExxkL
         x3955u55v7nCzXii+GD4Q+ItEoYZnUxeO0lDGv7uPxWhIP6SZN8aRMu1dTN59dd1BN8N
         5pQuOvoyH7wNcCitaOdcwejW+KZcWUFlxUKqHh2DCMwVTcU363/RytNbOgPHRyS+QO1i
         buofXTMeGWKRokWQgOv2mMgp6Kt69XtiwdOch7CwZM284irOTQBB7wq7sRaYLj0AlnyI
         tdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767460; x=1786372260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsPuPtlEtpcGKckM/9mBE7kyPjRyXeXRo57w8zpUvug=;
        b=iSA8KtBNdbIvyH0Wv6bYBi1PWaWLT4EHYIEPTUiCPleUPxCO8ACcfBGMjcn16EYVg4
         852OFHRqQhetB/pVrxaQTMbt8nt8ks/c7fqfqirwI+DSnGDbOnjaGlnqQh/JagaZgbmv
         IGlvYdFeu4D8udmYDy6VdHmCn0fGan59cK0pS6lrTvLhwa6dgBgfgmLGtQjRkeL4lnCH
         r9VOPVwQMT2dYN9v1H6MmGapjkMxY4fVtNZuI242soNbQAuDEDKF7KaZWGHUqMEavQeo
         sMm5XnDtJ7QhOaAMJ10oZ/yEBBoIK2IRKvYUypdji3W+pgDegT2YV2iL255T9Y3loh/r
         qKvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrzcbkYWAqn0i9LgdmbYls+da5S4VvSVM91IzFDJcw4H5vkheCQnybsY9RT8FYk2AtzvYDl8EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXtz+Dw3gzrwPNFBb1fMvOcDbfpaNjjB+0islw/xMmaRWTqvU
	KYQLqVj0A+gOZk4Qtsj/OK5WZsHAsQVYSKStKdwc8GzOsEbm/kzyFF8W
X-Gm-Gg: AR+sD11X+xmEG0Tl6m8mCisKz1hi/ElPjvWFvkH6izjXxZJpsdTeKEdNJQ58V6bTbY5
	TaryJJ089iUmQHqehGb1YCsXrXOndAEL12/ChOIHLeN8uhhGKqCP/hAmeKn6OnPpKNX47dur/et
	ISU4CeyVvF0qjaxQxnDa0Cwp6BKWxbwm2CHf0XiJ85CQvYKNr5n9I7ndMPB6sfOsVdqcDZ1CD87
	rlyAOLn6Cpc4KBh796pE/+v+BKexsMXBrH+d+c97g+5DpNRXevBpzgyXr6PascKBB76gnoWtoQq
	vcX1ZEFyLe6dCVL3V9ZEJtLQaHeZgy7hWgpY1QxnMg39nl6NhtAasEwooyIaKY+GlMEBLCi5b/S
	DYaFASaAjLNjluWk6g/ZO4ddANnOe3nluO4RRNwkwsnsiKZOFsRUwpmJiLdr4UMdKRrxmJCPFu+
	TawbAmGomQ0KwqivaV4lBOMmzYC+FZJCsbF8xtgWiq9bTL54trriDvwU7JIcwtcqMyzM9PqZWZx
	JSOUj2UOydYUEJOAT8YBvyJVNgxGtcM5yAyaXbasQ==
X-Received: by 2002:a05:600c:840f:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4980c5fa29amr206226845e9.0.1785767460389;
        Mon, 03 Aug 2026 07:31:00 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:31:00 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 04/13] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
Date: Mon,  3 Aug 2026 19:30:27 +0500
Message-ID: <20260803143037.93105-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803143037.93105-1-meatuni001@gmail.com>
References: <20260803143037.93105-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
hp_populate_security_buffer() then writes 20 bytes into it, a 16-byte
heap buffer overflow.

The authentication token used here is the current admin/setup
password, which is an empty string by default until one is
configured. Any write to a writable BIOS attribute while no admin
password has been set reaches this path.

Fix by removing the special-case short return for an empty string in
hp_calculate_security_buffer() and letting the normal formula run,
which already accounts for the UTF_PREFIX correctly for the non-empty
case; for an empty string this naturally yields the same 20 bytes
that hp_populate_security_buffer() writes.

Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 4d94e48c1a4c..2d4a3720f80c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -48,7 +48,7 @@ size_t hp_calculate_security_buffer(const char *authentication)
 
 	authlen = strlen(authentication);
 	if (!authlen)
-		return sizeof(u16) * 2;
+		return sizeof(u16) + strlen(UTF_PREFIX) * sizeof(u16);
 
 	size = sizeof(u16) + authlen * sizeof(u16);
 	if (!strstarts(authentication, BEAM_PREFIX))
-- 
2.55.0

