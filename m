Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6851C058
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793101; cv=none; b=BagBxa9kzEseOewufrYPlTCihGGX9EJvAdBae081sZco8HXJQCiraWz7SOXBZOHoskzUHVo1GikFZDNzNy0bjyWp24k3fhiA+y8+0cBc+R7ey3tIFkur90sLB61NJxT+di65D0lRs5T+KLigC9RZMYMG/iF/Y85j528IBlTXPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793101; c=relaxed/simple;
	bh=7gYzO9xANaW+GQ0pOVtXr+MstdzOHT2PWbr8BgiB2vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxbT8mONWHjtENzuLlEn42BQrlTTLUOG4SKyYVutoa258wFg+BpeMzOOqY4R5+YpcMaiOIaj+M1M9kO0PAClwSYIwiLrhAv0jTfLPi1gtk+Ydx+QPTbPLf4BZDME2fbQJJVK6aDkffg8o3KeGfkYMgsZzA/OBZQt3EAs4Nzfd1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7ttFna; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7ttFna"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso14782005e9.2
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793098; x=1791397898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNtRQU0kHw7yMy5S6NDAzNgYXNVQererbxMxfyyIy6M=;
        b=CZ7ttFna/inPfqqThTqsgy2uKMDdHNpTPIpauKllPX/KbCWzappzPq6bzEJHt+kDkR
         apVtLRIJ79tWJZF1HbgUyLc3hrj6mYx3LSMHd39KwWXcVckhL5aRkl5gvCWDidjW8wNX
         g6NaL1lZpOeER7AeAfVhJ6ADMXlztr8SSvAo48gukPZ0vlqsJaHTfMU9vPQtNwCF7H3U
         MPFw+N7jYFOk+sMvSLogT9xFkQJRXk+nVO16w19mfgDzigp0K9Cgmso6+Ov0la1dng6u
         QMWeZb2YC8gZ2SoBhCLyBSwlm9iN2M7qwqg16xlbyuihZto8uijBHci398ou+txoW8Ug
         eCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793098; x=1791397898;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yNtRQU0kHw7yMy5S6NDAzNgYXNVQererbxMxfyyIy6M=;
        b=yqB6sCVWEeLeiyetVaXHE5jnx1mGlGbgAXeZbbnH/XO77pzMIxW7zX5Fi+3JuvD6rM
         uB2sFjOvJMD3fOuTngB2jHegCG0vlFU5FthSm4hjcHRU5T3l43tKecCyi5KfarIZKbH5
         0EYLZV+lYIHcDCMIuCVK8jjsVt+DBXydXO9/NOIEwH63DiFefko3fkSarI3roPicdWe4
         gKoQ5qv/b8PsFfmSzvI6kEFjCLKFUVGb/oQlhU9xM5K186R7ifNBc/S2EIU/hFVcdPrb
         EOlW5Pj5gaqPOzxNoDmVXNCJwvSCR6afdrKt6Sct8lBzX/N60u9sd7v9z+TW1YCt6nc8
         FDhw==
X-Forwarded-Encrypted: i=1; AKwUvByohEdAA+/kYan9yFmW7LQCteViu+7ssrI7T0T1JK81Tks2olennIyPo772Ma16F8i+G8y/kN4=@vger.kernel.org
X-Gm-Message-State: AFuF++nf3O0ckzGYcSy0ckK/Pp6iBFdROpQAktn9Os8y0WFj5qqZWfIV
	wycdMK+fuP/iR15YjuK8p2rKwcqGAB0HFMA0OvRQcjzjv+8WBkmk8SKj23G24N1mZ3bmGg==
X-Gm-Gg: AYBFou1xb2tsONK5SYILBA1sUImzZsgOTxbprEMHpwZfxfNKRTEHFWjwQxGo6ac2T80
	UxYPZa+cNESRVprjuRGJ2CgjgezsoajSceG2VS9iOQDrpL+YBmUVHbYcJSsacTHnacGiiQRnD1l
	asMKpoq3JrbANJtrYj7R4cRLMWFFUkTeuJ5Szog9RH0IXeV8rNDHB23m2fKqWj/54CZl6vtBWhj
	t+5ITHeQbJ7xaCdV/Jt4e78p6OM/bgK5ktusErKPGHcsIRgFv/Sv8BhJInakMI3dFhrKonAqMAQ
	E6Xqsfp8XucJSwovLoiw3BpXoEeai9OiyP1C/jDjcFh7yDxXzgEUT+GJryokg98n9DC7spBc4Z9
	0hX+L4CTw7pMIVXKhpGVCJU1bblj1AA3OJHOxxfV5RHCpUyNHvlOpzRjSjDFK04uHy2wXZOBtZq
	fOUCa2GsIjmIf2R8NgQhLgjO09sKL5Al/LsxZL3H+FGcwAfD74FNLqKFiU75GGtv99AhGcGBPZ7
	Y12ANDADOfwZUZvlISCxdLYPQghf52E6vzQGLwCGTdSUaleRTJEf3XuoyR9/JIEdr0INKF5UQ==
X-Received: by 2002:a05:600d:82d0:b0:49e:7c4b:1753 with SMTP id 5b1f17b1804b1-4a01ade8ebdmr47115115e9.12.1790793097909;
        Wed, 30 Sep 2026 11:31:37 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f90cd4esm3294525e9.1.2026.09.30.11.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:31:37 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: andy.shevchenko@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3 0/3] platform/x86: hp-bioscfg: string buffer and password fixes
Date: Wed, 30 Sep 2026 23:30:15 +0500
Message-ID: <20260930183018.49629-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix string parsing in hp_get_string_from_buffer() and make over-length
password writes fail.

Changes in v3:
 - Drop Suggested-by: Andy Shevchenko from patch 2, tidy its includes
   and declarations (Andy)
 - Return -E2BIG instead of -ERANGE in patch 3 (Andy)
 - Drop a blank line in the declarations in patch 1 (Andy)

Changes in v2:
 - Split the hp_get_string_from_buffer() fix in two (Ilpo)
 - Drop the lib/string_helpers patch, use @only of string_escape_mem()
   instead (Andy)
 - Add patch 3

Muhammad Bilal (3):
  platform/x86: hp-bioscfg: fix OOB reads in hp_get_string_from_buffer()
  platform/x86: hp-bioscfg: fix non-ASCII truncation in
    hp_get_string_from_buffer()
  platform/x86: hp-bioscfg: return -E2BIG from validate_password_input()

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  | 79 ++++++-------------
 .../x86/hp/hp-bioscfg/passwdobj-attributes.c  |  7 +-
 2 files changed, 28 insertions(+), 58 deletions(-)

-- 
2.43.0

