Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3C476CC0
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349351; cv=none; b=rzK74w1LSoRe6XFSyn0dscX6YBGY+/yLINW6I8CqswD5CadrubbDStz4DkQ2bJJP+c6E2EmqjS37UaPiCZPYemba+MbbDTCeOQ0rp7Hg5iVmmOmT06LhtN/EBmifNZWQEkEItQn8lCwG/RvtOB+pp5XXYpKgzy0PB91s9X1Aaxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349351; c=relaxed/simple;
	bh=xu8vJkH9oqFCV0kisdLe7YcamRh7Q42iGY9tHGtPQNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m+eU8Ss+t5w4gE8jLWxbI5vqICwtcvTrhv+0PxjBo0uPBfVu6FcJAvcREx3kXpjDX9iOLclr47KHlm1zO2f8ftsZixnldNTbDG0AZX8BGGYzYRhNFHTp8V3/dzO9C6B+SeqNWdxZ8ptRZSoRfh4qznmYZxrccb3i8ERknG5zW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPEvWMde; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPEvWMde"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso6885505e9.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 04:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788349346; x=1788954146; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tuvnGuccAC6s3EK8HFdURGZ5p/3J3nCrEtYN7xV8Cug=;
        b=QPEvWMde8AvU7/I+kMWZX4EeU3Cutlu1TDphhnXKL/N3EmaS6nK3payLZDHqUF9hv6
         lg95FSwFXqcE8mwaZxrhpZChmOVgCk3iLrMsB/9gETwE9L9hb2uWtPZOn3iFZKrdpexk
         bJH6+zVs3cxm2PTp4Ct/2EtcCf3rcGMM9fHdOe1BoQG4w0aYT10C6NzqcxwQwpSfZVJc
         VXkEww0rVrKzwWa3eX9tX0KZCsKQBD/11OIC0CsexBO3ZnjLa3FnbNvRZL+GYrb8JY7M
         cqi+fWhQsdnCu10KailKGgx6VRm49I1XFOxjUE+zZ1EnpCmFRk+rFsmAKP5NqigX1gND
         GkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788349346; x=1788954146;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tuvnGuccAC6s3EK8HFdURGZ5p/3J3nCrEtYN7xV8Cug=;
        b=HHipWrzQaQqJMFmPPIxjeqt7qfA2pNFcZs/atIpn9y0bIXnVGuwadhlCstPV/o7OsH
         3U2Rm/TuZ6uFkHdI78SZ9gfpmJpMU63smidnXp9EhWT0AkFRmIxHDkVjBVylmnZ/ceck
         S5BgJt+iR6OV2zmAfqy+4d298S8KFjCMI8S3Nn0fIrcHr+Np5ChfnB43RlD376+8EfAr
         URvLPcEdY20XgZLI3/rpbK713izTi73oKyLxdvCa4uQ0szGA7Psp2GqOGuwAoTtPakgZ
         Yits06db0lZ7aLfVnhoBs7/OVIf3TDwYn1rjFo4TVwRvfnfErAEjS6VdPCM8I6totuKQ
         dqtg==
X-Forwarded-Encrypted: i=1; AHgh+RoVVJzdaQjJ7V0GKHqv+7V3j7GDvbnCs+nquG39Mf+ZevoOLof24CIRylCqHeaqu8jcVZVEm4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++l+GCXqjViqU83n7If5pLjd0L+IdJqeEDLMVzQy29BgHX6eIbsH
	Az0pNWuVWd20PfGknBDBUQWeic1KF+Gm9hh+mv9Beokb7euA3SljFlwd
X-Gm-Gg: AR+sD11BtgxZGbagfF0i053lbWQV15+od0/FuAQLFE4ibDsqrrZPU7JXkrqHjk4an7O
	3StROJETAvxuwq7ll1+2saDXlxZMbtKYcd4lPq9U3v5o41dvbXLmNEnf3wqipNjz64P5lElJ5Ht
	8sh6burLXe1pZ05aiam0dtUj6yM2135x779KnbeDLx16rhh3jNmSJd1nO8cssoVyBvzFvwxvFyO
	ITZRcgJScGnxumYZJ8waPDVc6iZh88Ohm405zbS8uP0PT/1/oaC7ajRWqPdYBtd68d/BKpq2Djq
	uz+bULpH6If94iceyQI2AOvbL4REnnZsla5HAMirTt1oNDPd99bearDXYCnJVcWkvpRU5t4DZrp
	Gkt31zFC3cnwVWkW/apUXKvHg7eGH88h1I0LXZzDHkQ2OOZ4dumPsc9iCNl/48JfwBYdItgWXIv
	2EA4vc+niD5SFqzl5hpSMjF9JQSg8MTp76r7sMyh9KdJh2I8fx5YuSS2XjEnXnSdilAZ1+x51hg
	iqhEUY6WeEZp7NQaarewV9JuL+p++r9o/eB6/NgHSQs8UXKEdxvQWwlb77Fy5RC0AM2zU6GMg==
X-Received: by 2002:a05:600c:354b:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49ce58180bbmr63253275e9.11.1788349345681;
        Wed, 02 Sep 2026 04:42:25 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5952560sm40390935e9.3.2026.09.02.04.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:42:25 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Subject: [PATCH RFC 0/2] of: property: Make fw_devlink follow GPIO and PWM
 nexus maps
Date: Wed, 02 Sep 2026 13:41:38 +0200
Message-Id: <20260902-fw-devlink-nexus-ready-v1-0-68fe1996e78a@toradex.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHILmGoC/x3MTQ5AMBBA4avIrE0ylfipq4gFOpiQkjaKiLtrL
 L/Few94dsIe6uQBx0G8bDZCpQkMc2cnRjHRkFFWkCaF44mGwyp2QcvX4dFxZ24cqlyXVPSktIE
 Y745Huf5x077vBziobW9oAAAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, 
 Frank Li <Frank.li@oss.nxp.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Leonardo Costa <leonardo.costa@toradex.com>, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This series fixes an fw_devlink supplier-resolution problem reported by
Leonardo Costa while using a Devicetree nexus to describe GPIO and PWM
resources routed through an LVDS connector. Consumers referencing the
nexus could remain deferred because fw_devlink linked them to the nexus
rather than to the providers selected by gpio-map and pwm-map. [1]

GPIO and PWM consumer APIs use of_parse_phandle_with_args_map() to
resolve specifiers through gpio-map and pwm-map properties. The
corresponding fw_devlink parsers use direct phandle parsing instead.
Given a consumer which references a nexus, the consumer API and
fw_devlink therefore resolve the reference to different nodes:

  consumer API:  consumer -> nexus -> mapped provider
  fw_devlink:    consumer -> nexus

A nexus is a translation node rather than the resource provider and need
not have a driver. The link to it can consequently remain unresolved and
defer the consumer even though the mapped provider is available.

Make the fw_devlink GPIO and PWM parsers use the same map-aware resolver
as their consumer APIs. The resolver also handles valid direct
references by returning the original provider when no map is present.
Use dedicated exact-name and suffix declaration macros to opt these
bindings into map-aware parsing without changing unrelated property
parsers. Retain GPIO's existing exclusions and compatibility handling.

The regression tests call the OF add_links operation and verify that a
mapped reference creates exactly one link to the final provider, not to
the nexus. They also cover valid direct references. The GPIO tests
exercise all property spellings recognized by fw_devlink, including the
deprecated singular and unprefixed forms.

Tested with:
  - The new CONFIG_OF_UNITTEST fw_devlink cases under QEMU/x86_64 all
    passed
  - W=1 builds on x86_64 and arm64, including the OF unittest data
  - Toradex Verdin iMX8M Plus hardware using a connector nexus for the
    display GPIO and PWM resources: the display probes successfully

Sending as an RFC because the unittest part can use some polish, but I
wanted to gather feedback on the direction before doing so.

[1] https://lore.kernel.org/all/juuc4af7ndbajcl7gzf4tg5qz2q2j5tt3rvql4jbauradujrre@gc5nbdhhixaf/

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

---
Ernest Van Hoecke (2):
      of: property: fw_devlink: Follow GPIO nexus maps
      of: property: fw_devlink: Follow PWM nexus maps

 drivers/of/property.c                       | 49 +++++++++++++++-----
 drivers/of/unittest-data/tests-phandle.dtsi | 49 ++++++++++++++++++++
 drivers/of/unittest.c                       | 71 +++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 11 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260901-fw-devlink-nexus-ready-c859706b019d

Best regards,
-- 
Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

