Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0830435AAB
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533529; cv=none; b=RfVP02Oit+/7dCXrJhiOb8FAw1jhj5ZPJ7132jnnl08LcCiXoxtKZL/iHCto7NRgnueiuGPWmWVLN9+oQjUELDm12Y3P4IGq1tuNmD/GhTfE8Oh3/a17Hiol9dJ6h7lpWPvCE1C6cFE5I3s1F7dRMFhgHYxWsJKqZtjO3kiItZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533529; c=relaxed/simple;
	bh=ATKvWl1DnIWOGmblRvXvDZPEp2qoEl7qqfbdLw7wl3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egzDvCflUzwl3YJoTVd8Q9JjXhSnXKtcm/vzs315e8rVzJDZVplmsEZAzk+HesKBUMQojTX4cyJsBzth71SNOu79xVYB/MkShG+glabr/q6TrV4bYM+7UQVHbXDhBVsJ5Dxr1rR5RpRiUcFoo8ilmZ35XVeexYdmlo1DIwCtAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPoC98/8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPoC98/8"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-480001972b8so296271f8f.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533525; x=1787138325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsPuPtlEtpcGKckM/9mBE7kyPjRyXeXRo57w8zpUvug=;
        b=UPoC98/8UNWIKkpjNwtvUiOxBBvc4dwZSjOxGo02t+ZvsUrufig+2dJGuYtqljphic
         LwpkDLlXJIZTnlPwuA7MnKUm/+ZCbZw7XcSwlkqCqEEeVZHp/o2LDXqtqTXAfd2eauYj
         IZw8UCvL0oF+Qa1rNY9DYvxqnuZXQIjocG2Bz2Rs3tfFKyGHMO4KQjwU7AZOxERacwHn
         zwB9D16yxn7sfDybvIgNZXPL5UWgafQfBJOJlgW0CiMxK9+8VChVO2sOkiv4AhP4DlUx
         0JEBThkNVcmkk6OpTawx0RQ/J19ccdm7tw6Sde/gHojH1BAnDTK+3A504aDg2Lmcm1ct
         D26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533525; x=1787138325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsPuPtlEtpcGKckM/9mBE7kyPjRyXeXRo57w8zpUvug=;
        b=lq4KGCLJbp56M+Mv841U3sK98iWLG27V8ZOB2iOdbl0kS/0DV9UqvNNBYd5oRZ5YgI
         vCNhddKEp+KB5fVRwtzleMJA2twnkTFsGcW1h1XorgpYzCn9tg3acSjkkVd5lx3qOMLK
         wkgM1e23RNFwBzIJ4Tn3QpFQu9lw+TqtmiWfSqwBgNiSe2psTKlMKzfdO6lks0TZCl7n
         naMWs67YgLme0ztcE81zXicjpi0n+BcGY8wbUTHLCk7luNxk8pjl3RlIjElT4zc1A4P1
         Tu8+ibdhWviu24LPhaU0PJpMiRoUiny/v9q3zf1uhwdbZn6r5gMzST04BZ1ZLbbdcaMg
         lUgQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBJfyheCHemHoz3uRGe8rIKOuXjXvVkgZAcaaPv/ThmxszE9oGWOhMOLDc17Y4g2R7RmWh8qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxky7MofDRSjgaLYLOg+RJpIePbdVqaBVU/rMsN1wy5DdgBFn1
	Xg29Re2TCuecV3zwthPcp5F1/U6P7Zqp/rj0LJGBTNb1RJB0Yb4s/LfS
X-Gm-Gg: AR+sD13fYiTeAgXSUHD3HUY0kuYmn5r32C4YJ31GVcWx1mc6t98/oPqavCmGxkOBI+B
	CLAivCmO9P4pd+fRcYiXKlV9LNa+fxRcu/6I1sXJMPYsfhmUgTp3/mEfSL+HypEHa2rS5g7zGwr
	5dPpeOOxMoPr4yp4wJigCnCzff3wearCc3lB6lgCqk8K8aFpVPpFCSGK3/m29RvgD1PByOeAJDc
	+aH9isrlBIVbpbWFxU78wXjyX8oz9lxWwNoJ46pJE3DGUlS+90/S6SFhiIakQmCzL1lDSIzL2GB
	7byYGFR6skeDHE3+79WsX8Ippdr/J7VlUdMdmzkuYnKljAuVuLk5Pjdx8pGdNEaSdNkQ7uhFjn+
	RqXnGtF4CQXEK3mdBYfB9GEcfQUvo/e+u7es3YjPKP7F3iHVJuT84LJvPNbzhscpCik6HpJ7LYO
	aY/0WYQ5LWzcb0CAwbPThtzalFCMj/gzOkDQD/Kg5tDQMNCp0U3e4Oa+xd8cCstxPxdqfgTPLL/
	RA4vF13m7uzwCiCHUI4uJeM6lF2thr8Ld6VpodFqQ==
X-Received: by 2002:a05:6000:2a89:b0:47f:e729:c588 with SMTP id ffacd0b85a97d-481528d77cbmr4832014f8f.14.1786533524857;
        Wed, 12 Aug 2026 04:18:44 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d702c9sm6670072f8f.34.2026.08.12.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:18:44 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2 4/9] platform/x86: hp-bioscfg: fix 16-byte heap overflow for empty auth token
Date: Wed, 12 Aug 2026 16:18:24 +0500
Message-ID: <20260812111829.172273-5-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812111829.172273-1-meatuni001@gmail.com>
References: <20260812111829.172273-1-meatuni001@gmail.com>
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

