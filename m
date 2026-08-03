Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047A313531
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767465; cv=none; b=aN9fi+PvJMUm8voeSnyU06PekyzO21FZu153sJ7bvdVmItdZ4+a67gVOnx4eOGsrTzm9jQfaepVnXxFJx1pRYyr5TVOH80trHw3eeO0nj++ggKs98P1ftB+Y8eLWiYLsM176ndvJQwfZDiAeycNYewDrh4BVT0ydlXh2SmBzQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767465; c=relaxed/simple;
	bh=r6Cbjl4OVGNVNoYln0kbEziovWGUtHxY0z02La/a0yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Na6BgZLyZ0fZg6vSq/axG39U9pmxMZObUy+ZENm/E2ESJggKE9wyDTJCb2GkWVLgrZIxYbKpNNadY+kJ96oIiUF1HOqa1WDq1bJiUITAJYJ3K+ldjEdcKKVV67Ax6wpsXeXaswSMTRmMwKuE2F/ExiF+LaDatzzryAisXLOMM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWayDztU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWayDztU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4955158f26aso14974275e9.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767458; x=1786372258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdRDhdZcnRfVrf9wRzs0djvfPZrw61+L7S7NLduJJu4=;
        b=QWayDztU8it3Z5kTxP2qIecS6McYqBN5ZIAauyqoelfQPiwQ5IgtzqJWwFtCa/aPkU
         tqeS3AyD80t3lz60mJqFqOBLMSO9VPNUgnpvcfQGIgatmokTPf0pHJG179hbmDZELOjC
         NGXaFqKU5surkpjguKyxyXSgiYiX/AGK2Zpn7lSmBdogkgCliHxRwmTOTaGeGlL85IoN
         zrm+H5rVta6yvf9JmqzQkugYhvFg2m65cDkbkIH92x6TJ/4sQie7XNqqLxbIy9lMD5YR
         Y5oPq7F77fOtxQqw1oA4Hkfp4Gyxw3boiDAe3Sz5vzCNieDadPPtrc2Kd3C5bMm+PBq4
         0L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767458; x=1786372258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdRDhdZcnRfVrf9wRzs0djvfPZrw61+L7S7NLduJJu4=;
        b=hJYYy8NPu8EcN5afOFImEFZkpEBiiO6NRoYruibRkr55EVRWFIYcvk/ZcBoxH6qtT/
         6/K0UEHaiuosxhvIw3dr+pu49W5HNZGdqUkzLGKWbqqYctlORRcGp/HFvO8CDh9tOrwk
         dQAByUhlDvS/jaeTuFSHBV5po7u6dEtprjMqcpAlW7gblFmyF5R3pufB/P5dQuHxqZS4
         IcpIFeyE7kmY2VznDBqoLmpDMyTrHgJLxU6/7TSpyBE/DsRHUYlvBpDvVLMGbOfAynaF
         u5BTS+adk83nv4IDQq83ovxBkeCL59L1RS+c9FZmIk+mU7bi7DAjz5UmldZaq6fE067e
         ILrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsClf5/eYag7BXaRrg/wb/W/SF2TiPgSHdI/NA5Y1epAUnsQKdY6ad7a6ZikFJG6SYvXjNzmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0werxpZYlwoQi3nzVyhh17Y5hvMflfNwk03c3RF1erNHPgUG
	PecfVY8puakC3pRvCJdKazypl6W1mSoPN8ddIN8Ko2iNxwlPwpYY7tz6mDZeU3jqgQA=
X-Gm-Gg: AR+sD11wIRUfehPgiu4g5bBYOU7lcjbsEf4VIrcn4HKkRDEIgBsJI51nvirCgym3YkC
	eZkabIdYHzqhcrN+QgZRFxSKdew8i8HmvOiJ9VfGu7KxXdG6I96XW2ER+fcnZLQzEtKD9PFtbu2
	QwAOrfpBE6Hrz76BmWhvjP72IbKq1XGBQuKJFxczbj2wsesE5CBkL4D6KZhcQ7AuKgoAov1R7k/
	VAYEFMfCFU9h6ypXKdVhEtCSjXIvlEN9jgd0mFl7ZsAi+A04/T76Z85b2bkcKGRDMzTrv12dcl/
	EQoD0hpWx03XB5t9zniHxxErFt16bjkAEVG86bRoyWQ39VxLFNOmrONwACFg34XolBX1RNhI/65
	zQkB2sOIlnHSBlb/OvFJYrXcVVL9BDbF9sTQNNUFeSgf4zLrKbGIGEpO04YwD3crhyqqjGDDx2D
	6XtJwh4wypcERFXIAeryN/5LyIDd/lXgP5t0fNqRVBnhsOoPMuKu6ShUZMevVB+wRX4lEGGU3qM
	0gX0VxCe7C8rmfbaMCRDgJBpn7up9OH4md0U/XoLQ==
X-Received: by 2002:a05:600d:8489:10b0:495:69eb:27fe with SMTP id 5b1f17b1804b1-4980c674ef9mr180887235e9.11.1785767457599;
        Mon, 03 Aug 2026 07:30:57 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm236575295e9.12.2026.08.03.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:30:57 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	meatuni001@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH 03/13] platform/x86: hp-bioscfg: fix heap OOB read on empty password write
Date: Mon,  3 Aug 2026 19:30:26 +0500
Message-ID: <20260803143037.93105-4-meatuni001@gmail.com>
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

validate_password_input() computes length = strlen(buf) and then
checks buf[length - 1] to strip a trailing newline, without checking
that length is nonzero first. Writing an empty string (a bare '\n')
to current_password or new_password gives length == 0, and
buf[length - 1] reads buf[-1], one byte before the heap allocation
holding the copied input.

KASAN confirms this directly:

  BUG: KASAN: slab-out-of-bounds in store_password_instance.constprop.0+0x223/0x2a0 [hp_bioscfg]
  Read of size 1 at addr ffff88811bd8da9f by task sh/13740
  ...
  store_password_instance.constprop.0+0x223/0x2a0 [hp_bioscfg]
  current_password_store+0x14/0x20 [hp_bioscfg]
  ...
  The buggy address is located 23 bytes to the right of
  allocated 8-byte region [ffff88811bd8da80, ffff88811bd8da88)

Reproduced identically via new_password_store. Execution continues
past the bad read (the garbage byte only affects whether "length" is
decremented by one), so the write completes and returns success; this
is a pure information read past the buffer, not a crash, but it is
still an out-of-bounds access KASAN correctly flags.

Fix by only checking buf[length - 1] when length is nonzero.

Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 4d79eb8056a5..86fa03a5ee9a 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -66,7 +66,7 @@ static int validate_password_input(int instance_id, const char *buf)
 	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
 
 	length = strlen(buf);
-	if (buf[length - 1] == '\n')
+	if (length > 0 && buf[length - 1] == '\n')
 		length--;
 
 	if (length > MAX_PASSWD_SIZE)
-- 
2.55.0

