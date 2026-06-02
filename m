Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBF314A60
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431090; cv=none; b=W1WUe9QZtj3WEWDWG4vAgV1isrowfssCVm3rqYlZWnX/ov7pVCQzkcvYGUDK1LgQ2VISYHapXXVhfX3YbLM3fntsf0W048AjJxpS+0/StWPctptVnofDrB673UilXcW9a/jxfkGFIPXCTvsnHHV8GxnirG78yPSekXI668vGAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431090; c=relaxed/simple;
	bh=JpJeYt8CPFXs7iKWCxjxwFiPHMP6ttb3FtJ3/R0zazM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W3wfwM/0EEz4a7ecBdlhvfaYPs4VFKZJQCkDuS29j+LcR6xjvCi5cs9pdYLz3NbeRHbLfAoY+e1TS3mLPUtkw98uVqmacJCJNKQ87EbBFzjEw7MyK05KIeGmT8wo+ie0jYRAGP6gMrd4OoJW0uIcLWC4UAuMSgHXJ2akT2P/CVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=patAeva8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="patAeva8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso112813345e9.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431086; x=1781035886; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwB5AwEt0+uqJie/WPe87PYNvCtAvGN+x0GejEGwijs=;
        b=patAeva8ubPqYatxl/5yEtbGT5UuYmIu0QhuOdRNwr61QXr1R61BcjuZv839mBivSa
         gUg70aE/3ZTqab1XsXbQ5j3cct4FHUSWldHEJcYlie3GcwdnZyPNXp0RcU2dFV/ZIq3h
         YiVBMIZieXYjR8AwBge0tK/psdBJnUoxuL4GRS1kh9nkIvQRt/7AL5yP9jl2J822fSqt
         fKihYMGLi4MsSG+P8+xbEopJ6yw8BvdxmnfWZ+jRgiazaUG3oKoPaa6ykNC23nSJV0K8
         XykHmhZ548tn/i0g8M67ULftbQy1Phj6gel2CeQL3SVc956TSdbtNW0qbl6I9YHvM+YH
         4+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431086; x=1781035886;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwB5AwEt0+uqJie/WPe87PYNvCtAvGN+x0GejEGwijs=;
        b=JMhqhxooNxtKa/HjBzfEf1SltBP0AV6YlOPPQ0OttFuNNNorvm4r9cPEwiiM8TmOu0
         W/rDD+5uszWw5rC74PN2PvmKUDCfc7WH01Z0+x2GnggDwrk0OnkFlO+t4tFqw/b9o0Ii
         S7GkODjfZzHlu1OxYE491lnzQCgzfQg0J9WFJoi3k+a5kojGu/oDmbW/NkNUs3H6tzpi
         V9uRvXgtTChEyw5hoOi+Z2iW6H/gUiqhr3Zx0KyZ0A5r5i86vq026L/SWpgpc2Ranrj6
         0uhtizCqX+7Jc2PwukQk76VU/hv66hHI0euhb6sYRrqC1LTWpSXq50p/P616pvuhOSf0
         eGtA==
X-Forwarded-Encrypted: i=1; AFNElJ/QaRli746PyDM8NPuSV9u4OBG6uYFSE3kK3uPCMW8w1lZ9dng16i2EJOTF3f6iVbHDYhOBERA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMelt0+vPIossyaH36AUNcpheTUBS89ZhS7Y1c3SaPEJU++2bB
	2SXK21fLmVAjjv1AlvRM6yySi9RvrWX9/FIMSIm4zA6q6Y6O0E4+yVVsfnaEdLXznZQ=
X-Gm-Gg: Acq92OGXy3T4k2s5Q1UIZnbA16JdurPdRwMWLKdRxj6E1tIbY/2dHo3Fu/vKFrE5Ltn
	vmQ/cC5VLi+AVp8tl2NP3LEAH7tZ2wY4Ui6E+A1+sWBSSgm8XVjcNis05CWoBvWsB55sV1d1Bbo
	+Kf0q1Jx1O+HMBh/kCF0bK/EpqPucR6RlHakzbaAmPfob541+hX6fp5YuKAeNghptLGH7sQwrCk
	O71+p+zZElkFDOXrMgk1tTxq/kf+srVIs6fvVgvsvSyJNu9NA/v3/n2BKk1L3B9RD0ueCoCuJZp
	hgTx3xoncuFmlLuR920aCTF7wLoiZ/UBot7RMxavz/v7whxc2K4dzTFhAsQ7kIBgTBwIqqyPlqO
	qertRqTF7BzR/quEAMG8f317D80PKLJVffZJvq8migURdm5fsJZJT/VWdauVwcSz2fNcEkK3yNQ
	BinX8tbl+0Rb0py955djfhcK1XBVofcaeod3Kuv1syGdjW9Y0hWbo9cjt9wdZrDw==
X-Received: by 2002:a05:600c:1f86:b0:490:b58b:a8ca with SMTP id 5b1f17b1804b1-490b60fdf28mr3992635e9.27.1780431086210;
        Tue, 02 Jun 2026 13:11:26 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:25 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v7 0/7] Add support for the TI BQ25792 battery charger
Date: Wed, 03 Jun 2026 00:10:48 +0400
Message-Id: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOQW7EIAwF0KuMWJcKbHBIV71H1UUIpoNUZTJkF
 LUa5e4l2YSK5bf8vv0UC+fEi3i7PEXmNS3pNpXQvVzEeB2mL5YplCxAASlUKP0dbNeDVBphGB0
 5Q0GU7TlzTD9H08dnyde0PG759yhe9T5tO1YtlWRiy0ohGuve43eaZ86vEz/E3rJCLemU5QFJt
 rdg+kBMsZVYSa1OiUUqiI4BIRD6Vppa6lOaIjvQaLQNPfPYSltJMKe0+80B2Fs3Rq1DK6mSWN2
 k49vORT8gsu//y23b/gAPBobHwgEAAA==
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342; i=alchark@flipper.net;
 h=from:subject:message-id; bh=JpJeYt8CPFXs7iKWCxjxwFiPHMP6ttb3FtJ3/R0zazM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJW9ydveHph+xDE3cFF3WJ7Dwy2XzPy11dOSUPeHlXx
 tnkVF5O6JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqd6ow/K/K7jL5sM5xkdi/5rViewJuZjLwXIr/nvDjbePW62c/Vcgz/K/33fS
 QyXf2rxKVWl7eHqf8ogDTrRvPrp30t8s5MnWWLRsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v7:
- Rebase onto recent -next and dropped patches already applied by Mark and Lee
- Enable the Input Current Optimizer to improve reliability with unrecognized chargers
- Explicitly program the battery cell count at init time to alleviate transient glitches
  with the charger going into spurious battery overvoltage state due to misdetected
  battery cell count
- Handle return values of all regmap writes in the init function
- Link to v6: https://lore.kernel.org/r/20260331-bq25792-v6-0-0278fba33eb9@flipper.net

Changes in v6:
- Changed -EINVAL to -ENODEV for non-match cases in the MFD driver, to stay
  in line with what other drivers do in similar situations (Lee Jones)
- Link to v5: https://lore.kernel.org/r/20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net

Changes in v5:
- Added non-OF match data and switched to i2c_get_match_data() to support
  non-OF platforms (Lee Jones)
- Shifted the types in the enum to start at 1 to avoid confusion with
  zero-initialized data and non-match cases (Lee Jones)
- Reinstated the const qualifier on the MFD cell array (Lee Jones)
- Link to v4: https://lore.kernel.org/r/20260311-bq25792-v4-0-7213415d9eec@flipper.net

Changes in v4:
- Avoid additional data structures and pass 'type' within the existing
  struct bq257xx_device instead (Lee Jones)
- Move comments for new struct fields to the patches where those fields
  are added (Sebastian Reichel)
- Collect tags from Sebastian Reichel (thanks!)
- Link to v3: https://lore.kernel.org/r/20260310-bq25792-v3-0-02f8e232d63b@flipper.net

Changes in v3:
- Move MFD cell definitions back out of the probe function (Lee Jones)
- Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (thanks!)
- Enable ship FET functionality at init for BQ25792
- Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6f@flipper.net

Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

---
Alexey Charkov (7):
      regulator: bq257xx: Drop the regulator_dev from the driver data
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip attribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
      regulator: bq257xx: Add support for BQ25792
      power: supply: bq257xx: Add support for BQ25792

 drivers/power/supply/bq257xx_charger.c | 580 ++++++++++++++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c  | 106 +++++-
 include/linux/mfd/bq257xx.h            |  14 +
 3 files changed, 681 insertions(+), 19 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260303-bq25792-0132ac86846d

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

