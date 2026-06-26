Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C739DBDB
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442739; cv=none; b=bQYsyJ3KSM/ng0p/jfnColxPvnCRZl3fFilvhjVLtdVM4q06hYIIinzYIHVyve13bB84kN7nKgGcES3zJf5aSPrf4fiftOBmGqzMGh0HmuxuRM09D1r+LpDW0yXQ0u0VQWzIqRWlU5YvuoYKZgl4g9HNZaSscYMxZGNxz5tSYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442739; c=relaxed/simple;
	bh=aG0d86+VStYCLhrRw4TkiqCfZ90Xd/Y/zoM5y23rOFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVMO5tA4Rf1b/+jvqd6WM6TpH9dBoHieZjGLE3h8k2LQ3LmtTmeJmCI0+wqT8LXX7BgsOzzv6YgN4iPMoGHZWU2Z/s96SpdlhcUC57SQAr3oSgBx2vD2h0ZDJrYsBp1YY50pRMWPP4AzHAC5n7HWTnWHunp6gjqHlzJ93nWnHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwLo9oBx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwLo9oBx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c6be9cd89bso2182945ad.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442738; x=1783047538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=XwLo9oBxqluE6pY0EON2hm6P7RuqqkUhGaRoqB+qQT5sCROnn/EKsDa0JezXNCdsIO
         XBZsR5PrTVIvqw36QBbjIDYv80YGL/OAVa1t/PB7i7LLjtMkeEY+Osb2wmAwfULyYYej
         lazycJAdzx399o7Av+7nBvX/EYAgp07eEqPAPVAjYlXPXkVmW7Gwbr7Io4ilQoae401p
         sAs46jPo/Xsf7dvq39oDzJeepzFRHlfki7jtbyOaPkaxT/Uo0ChGoaRTDdQkJqjT4/vR
         L6Fc/O+JlBKluZHSrI/9Levry6nCa3UjRe31VPjj9ZSq2koRAgmXJAB/lZs2f9TV63E9
         fksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442738; x=1783047538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVsjU9yKl2cJB/WfxCzz06jvF+n5PC9ZLu0AFLXamVs=;
        b=V42YhvouuvyzuuO9npBSls5NdweYKDbwU2dwqbkfUwuj8gRA0CPxuvl2uXP4ErLSLh
         /M6eye0kOBJ1XoHyLnQUtPbE6puMXz7+7puTa/jKtiWC72npjWHaTmqhvZcc3hXJ1VbR
         wBkmI+nN8r0hf5/DLGTzQZdl4sPSIlPo7Bws/5ciFEYo8Lz/X6dZp8SrDD0gMX4KCvpz
         5uJ8jLqriEqVy+Pl/G9Pf8mCkXfKz5oJJw6FN4iftMBXOmH1FU0gcHtUpwRPaoFG3E6o
         G5eWhQFkZf2/inUUBdlNjBccajk+ug+hQSnbGW9/pl2D2OnNKiSKWN8Vx5tnKKkplcaO
         9jjA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ4q9ucGiL27pANFLCeCV/ghvjAyboJ/wxwNdovvSJTqlxzXg6e/IAVIQQ3lC5K/k5JcORn+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+RneAbL8BcyKkUICyatNpbRSZc6GMACGfsRdvjXYEUkaL0ea
	FXez1Dp5PzC85l8YULsXccvMuYOCONmp/m3LcuoA3nX2UGCuLLabuIcV
X-Gm-Gg: AfdE7cl1Tgf1xkdWTAQ3KCLIxcQsEzOLTZQjPbLJ2CJXU633h3GT2JHe6rFHxrrvCB7
	Oc9vc/M3QQqefGmGLjStkTg6yVpuMUBL0SF2vq97YAqoNtTfN7qVAO1qmd5dfMbnoNDtW9eI/Ej
	skz55zYRXLOMVrMNFuaR8dQx60Su8q9MejjqMS1vsNjFMC16P4QgE7+elxtHIJig/NMbr0e50+w
	hsz1Pifkzvx9+oA72+uOLMXtAWca6CuK6Mw0O3qcoeCv7ZUFD5/IB32Pm7o73xJV172R6GzWzpn
	S57pp/RS456xOjZIAuJZqcGOIxvSOeFhYEZNq3BCqa0nfZyEMhZ8dXWmZbHtRE+EwzqTK0PpFzI
	fUQhY6WC7FI+rIig5HRKd8gdWllAlabuGI0NWvE35+j1rzST6hLDNXsZaSeTrfpUuGotMGrzl80
	ZNs+vrqt7qSHU=
X-Received: by 2002:a17:903:46c8:b0:2c7:d071:3ef1 with SMTP id d9443c01a7336-2c7fca19129mr53387105ad.19.1782442737717;
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:58:57 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v3 0/2] Fix slave mode corner issues
Date: Fri, 26 Jun 2026 10:58:44 +0800
Message-Id: <20260626025846.106157-1-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aj1UR5ddawsdMbZC@SMW015318>
References: <aj1UR5ddawsdMbZC@SMW015318>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two issues in the i2c-imx slave mode.

Patch 1 clears the slave pointer on registration failure to allow
subsequent re-registration.

Patch 2 cancels the hrtimer before clearing the slave pointer during
unregistration, preventing a potential use-after-free / NULL pointer
dereference.

Changes in v3:
- Split the original patch into two separate patches as suggested by
  Frank Li.
- v2: https://lore.kernel.org/imx/
  20260625160219.55116-1-liem16213@gmail.com/

Liem (2):
  i2c: imx: Clear slave pointer on registration error
  i2c: imx: Cancel hrtimer before clearing slave pointer

 drivers/i2c/busses/i2c-imx.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

