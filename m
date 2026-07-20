Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CD429005
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556778; cv=none; b=u7mmk0zmy0pzx0GpXc8OXpUdcMs3BAkO2c08hXvKBsNs69ExdLaVvm166hEa1AwUm7in1BeAuJcoLaA2z8XB02KBnOqdZgQhZCjdlAqsc8gMThcqnAwnT70FcWa7BiqQ9OQt5eK+RmRpjHCsPAvLTiSLRooXsXWMlL8LQ323RVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556778; c=relaxed/simple;
	bh=Ul2KzNBslHLJAIKfIsvaJrSsTrrryi4w9XOFyLKmonM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IveIVR7PIchkwo2wtXLZzTMo6ttmk1Zf6OasFhjo54wvar3G60CPDArKVEfnzM/cMfuJAjg+W2X/enCDYDU6jVKOV6Jks8RE3UjucJG+KeEN9svscaoQ2inlvSd0frTgpnkNzFnxvPFzLI6QZrqpI3teqbxRol1rtxhAVcrAi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfliCbJm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfliCbJm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad4170e8eso139197095ad.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556776; x=1785161576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C7fiBXjtAildm8IwhfbH+uJoTnJQ5uXcULnuq06T9ao=;
        b=QfliCbJmbRQ9aKEIKZngnTNzTOZ0tIopJ0kysZPlDq2HbIirmfHsEGto3cysntXpls
         XIflu6iV498PMnwl/w5T3kjQDncvDC1jsa/SOcaDT9lIXYkIQhQb9I/1dZFlFCbN0+vU
         13iqenFjWPrLf1XxsV7c+hsjJz3TLs3idzd9ty0RdCU/g2rjVi90xaB5dKkgypkUukLJ
         8mD1GQkfvyqjXaI9FMBmqVcrfki+gaqY31ovPKbvmawGZGuKO3TKw/hP7d1vhm+IIK7B
         yBGVbLnZZjAUgRiMOm+wL4RUHI47F1gfcWVO2WnY/fj3MCOCdXWY1miZZ/lDKPyI8f/D
         EYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556776; x=1785161576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C7fiBXjtAildm8IwhfbH+uJoTnJQ5uXcULnuq06T9ao=;
        b=NwNwg5ho24hxiY4j/zHV4DdEZL4SfAi1aDspZd1+uqtjpFqmfHxyXBYpnH0QxkbEq0
         miMQD2q4mmZUgm3+6ezILtYHcgh6vMtCp9W4c4VURUaGNCEBFOzrdl00ODOx9qg7mpxV
         d8iAw6aFiEjZvA9utPOw9bGpf50oO7DmbhaPOATOsaQFrO748m8JvwsSr0s6i4FT9MZ2
         JApdD0kbO5AN5AUdJD+GaKFoJqs1vJ9it27peDJ28y4P4PjzGZ4pJYjlKchUYDgHtHMM
         cnNBnYSe6FmZ07N7N/IjKWeEpYcbfhSIFXnaWe3WM80vnOLI4N9U7RDm8fhyG66xI0Ik
         ke9w==
X-Forwarded-Encrypted: i=1; AHgh+RoI+H+a19Q8zEWv4lH+aDbnywRsG1bHamTgyYZGGqDr7Mo20mD/p12Tzog2krexCDaZX3VwZqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz064oZaby/EpMEQpW7+LSk+e0oFGjO3xNAqSxH2UF6MM+WRIw
	V/nFlhvMI4NVMHHsRcxuz5MQXWMZgfrR0oDHRlSFyv0GdP0Tckk78Bxg
X-Gm-Gg: AR+sD11KAAfWJG74GS+xO//eywhRjN5shfpSsCkdN2GgEAhnVOQlaxczTvFFVd8XIB0
	mZWhYXPC97/FirRfwG/UbfCKrZ7V0eYY6ILMtOnW1BUYSvyqNCfVE8+6S6Bd9Iy5LXJcpo/eUjt
	MXmivWVzs4t3pFDz+8n8eTJbFge+eqDPQj50g6t6bTdXioODyILbBmWxPRLMXf/C5DAiCzCTg+Z
	U38ZGO+Hd9oJ5LjyPnblgiptgQVHjt40C1xtVDeQDq3K9s6UAKNPePD+cCwxY5uKJ5fnC0x7ntx
	nY/EcM0epKf7w/ZUp5ZsXh8LClxNMCy9b4YqedrlczuIAHawlq6zWvCUuh3DEVfR/4zUo40nKpr
	/1ItqitH+NRJURZuy33583Hzv9vh5Ok8kCCFTe36svodqcNzkfRiDSeXeVAU9zKBsA258ybfSeM
	dPsxVA/+/qOMJv6jEicDusmDOZXNIXfWwDcKZm7FXnNyiqm6xiXpqbCTQfPsz1NSRipUo=
X-Received: by 2002:a17:902:e752:b0:2cc:85a7:36ee with SMTP id d9443c01a7336-2cf349910d3mr151274905ad.32.1784556776008;
        Mon, 20 Jul 2026 07:12:56 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm57578155ad.64.2026.07.20.07.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:12:55 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: pratyush@kernel.org,
	mwalle@kernel.org,
	tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: takahiro.kuwano@infineon.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: sfdp: bound two optional parameter tables
Date: Mon, 20 Jul 2026 23:11:02 +0900
Message-ID: <20260720141104.2054417-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two of the optional SFDP parameter table parsers size a buffer from the
table length the flash reports, then index it at fixed offsets without
checking the table is long enough.

  spi_nor_parse_profile1()  reads up to DWORD5,  never checks the length
  spi_nor_parse_sccr()      reads up to DWORD22, never checks the length

The spi_nor_parse_4bait() already guards its table this way, so both
patches apply the same check. The two parsers were added at different
times, so they carry different Fixes tags and get one patch each.

Found by code inspection. I have no xSPI or multi-die part to reproduce
this on, so this is not runtime tested.

changes since v1:
 - reworded both commit messages to be more precise
 - renamed the two constants from _DWORD_MAX to _DWORD_MIN
 - Link to v1: https://lore.kernel.org/linux-mtd/20260719010820.1924739-1-sammiee5311@gmail.com/

HyeongJun An (2):
  mtd: spi-nor: sfdp: check the length of the xSPI Profile 1.0 table
  mtd: spi-nor: sfdp: check the length of the SCCR map

 drivers/mtd/spi-nor/sfdp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.43.0

