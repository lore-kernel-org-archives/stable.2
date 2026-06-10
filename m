Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED834B661
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131370; cv=none; b=b3vjvTdLB2nUWplhA/1S1xz12bFQ5rgyk0ioFkhcHiakZT6iI/+jO/0qkCTLCHb++foyGIO4IN4Yv6/ElOzJF5k3GEC7PTvh5XbCZmNGpWMDK4smhhx6IK+r1TROTC2S7mC6MIek+43UfgWV4QNxEbcwirAAJFBzrPp6Fv7EU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131370; c=relaxed/simple;
	bh=KGb2+RnBGqWGYJWr5yEi7yn5Go85cTY3qJrXW/hZZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQQKpUigTYst+3NZ+9EwuEuW53lzKw8hbUz/A0MyPQlZ0+ugtAAm8P1G1MypCxfaWKs6vPFSYI5GDt++Bi1i8RFHvoT1b5AL+aDJAxILSy9zk0TmlB1WRjoIS5ayiO/oVppzR/JpLGgLLQ6F2YJrErGCY4tIRYdcB0xFm9m23aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sB+HiCCJ; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB+HiCCJ"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-138129a622dso6430013c88.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781131368; x=1781736168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjxMs1UWDXcOR4Ip0bVRp20Hps+s1fUTy1xCBCJP+bE=;
        b=sB+HiCCJ42xJepSa1+Lo8D4DG+GF3uJ0fmFX54ym1FSMnxxjyHQ5iuX3skg5groNMf
         UjbvmV/6SA23UofdGFQkNBERjTfhxZuqc0F7hdmcpzAjunPLFN5UD1qzmSmAtzHWRrVb
         a2MCgwFCT2b5p21iiXjNjmATtMfo2hR1+OtWgEhKPd1RJuXg+iWPOO3z3G53Cn5NpiC8
         48MFr+7A63mCCkf16BvIPE3MY9k70aHcQqHTDv2LNLH/f3ws4DZB2VEC81xsGfpgAW/9
         Om5qPRSb+MI8BfWSQ/hvO89XeUI4WDKitHPLgoEfiAzJ4wobyfUOi5FvHZvaKlyUxX6+
         Hyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131368; x=1781736168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjxMs1UWDXcOR4Ip0bVRp20Hps+s1fUTy1xCBCJP+bE=;
        b=OQ1pvHjCipHakLrn2H/19VuO0W35u+0tBQk2PFqFqkxIdJ8+x+WmXAZbt2CX953LgG
         OrbFoyKxSdp1CBkBTdZsWBrIB+VJ1125gcsx05PjiA54+JR6TBue/Rk2XH276QQVttBc
         79Kpy696u7WPysx0LkQwvVrYG5zZPLyh9vh5ajMQ9lzyCTA0Xo6nypmpkBnjMyMBEe5V
         uXKE2xcWp5p9Sjq0FTwGcim6O1bDwCu7cLOxSa+cIlnI1WWcGhVQR3HNvgxcyRVcLUxT
         E/TxQhR0lKeMbHVnvOb1SwM+zr/UflGqXk3ezuC0lkpzabJ2ezzENfWo2Gasy54aSswJ
         CFBg==
X-Forwarded-Encrypted: i=1; AFNElJ/rA//WeTspetDM50TVuFCf9HV35pA75lkSZUpfTcahkYt0ODgOCWLkLDA44zUXuyJF7Be574g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNa1/AQXLqQKmK7ybvtb6/SHTae8N8TFMWPXYVLtx1kuPMYr7
	slhK05MDmXc+6nXd3OtjMO+Ckn5aaHaIek7m0d1AG/ohEfy/hRSxRWKc
X-Gm-Gg: Acq92OFeNx5FP9gorbA7AjSznLGn7Tqct28MM6+5Gsicp6J/n/gf8eW4mBvU+DqaJxf
	TbVKUIUAwS3FR0gyWyBHwGYV6mx7zbxwo7Z5H+6a/4MZ3VoH2GiZ4+wmMPoNk85vx3aBN4NPiEU
	k4thH3SIWnvfZtAdhUvFqIQykjkMoH8wHDveNMBnIWanL3Cq+skEcdtp//qpeSdy9+faDQqgnWH
	1fuPS35wlcyY7ouiEcB6KzkltGQhNovdx7dq9+LHM9lDqN3BlTEnYc6Q77nCxIjxD7CToicZoCb
	l//XqgCdaGqWF4/LFSGN/RV0lQAo63oH8uqg47bvnKtdVs0ntSKqcJ0G5K4sK/gG/+mN87lNgx5
	oglCEJo/KLeU11s8enrP/rEvarUswm+sCaJC7xPpysiy4edTh9h3Lo8M7WoAK464ouKJGG61ZLL
	C5C+eJH2YL8OosdbqXpNMjHZPMbFmClg4fqBdy3gGxTYT3kfp7euf/9HLSmAONuakVa0bMUjt7W
	btUYiMWVtk9gKanmDjsvEvQ8mFfXS0VTICxAxGlW/lFH5lZF7b9qvlyZH+UeUFiyHvECMLcyWxQ
	tfmN2S4UvSMIgfscLglO5Npz9/PP
X-Received: by 2002:a05:7022:403:b0:138:11a:36f with SMTP id a92af1059eb24-138421600ddmr132935c88.1.1781131368427;
        Wed, 10 Jun 2026 15:42:48 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539432sm23652848c88.9.2026.06.10.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:42:48 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Lukas Timmermann <linux@timmermann.space>,
	linux-leds@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>
Subject: [PATCH] leds: as3668: correct name of config option to match Makefile
Date: Wed, 10 Jun 2026 15:42:43 -0700
Message-ID: <20260610224244.128063-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Makefile for the AS3668 LED driver refers to CONFIG_LEDS_AS3668,
whereas the config file defines CONFIG_LEDS_OSRAM_AMS_AS3668. This
causes the driver to never be compiled. Correct the name in the Kconfig
file to match the Makefile. Doing the opposite would also have worked,
but the name in the Makefile better matches the format of other
drivers' options.

Fixes: c7dd343a3756 ("leds: as3668: Driver for the ams Osram 4-channel i2c LED driver")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/leds/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index f4a0a3c8c870..5ac63cb59469 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -107,7 +107,7 @@ config LEDS_ARIEL
 
 	  Say Y to if your machine is a Dell Wyse 3020 thin client.
 
-config LEDS_OSRAM_AMS_AS3668
+config LEDS_AS3668
 	tristate "LED support for Osram AMS AS3668"
 	depends on LEDS_CLASS
 	depends on I2C
-- 
2.43.0

