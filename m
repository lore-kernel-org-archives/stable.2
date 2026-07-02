Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1E2772D
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958917; cv=none; b=JqwLplZbXs0YCkMjj7pgdEW1Pk114u+WaWzFZT098JtlC3S6MmvBA8LKUCBWxo1EDYnqaZDw3f+SSDOfAd34+lmKrrMfNyq8y33Z++C1opsyXuyRNhoGDZPnlPnPfp9sFQXlUEqz9l0ripr5SlnoYXfqp4pV1N7rZawIjz8GOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958917; c=relaxed/simple;
	bh=Y6jjRTAvZjwDwBkf81vJR+VNp2apPsRYiYLGDeH2FXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEf6Yw9lGU2/efWkVXjp/EcPSRiR+yn2G63q0xGBewsrXd799D8DUXRKss6a28QiRnR9hu0VcFbUEfc70B4XBTDaX5usHLmkQuCsm9C4NnsAorkqCK8Z5KY/GCgaNDiUwpeN7o6kRbZZunl84m8tR1SKdk5/7TbeoZjalRIPhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odlpsMaK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odlpsMaK"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c9b19bbaefso11087595ad.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 19:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782958916; x=1783563716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9h5YwF6Ov71FIffCR/uSYv3hmUYhtMq0eI0sDB9+mE=;
        b=odlpsMaKlOjlZZLeqv2WMGI8H60HdZnMjFHBG+XjceHRFP8kFpHnmziLw9kzLbr5r3
         WEP1PaC9trf5QZKACAjznAhc7LCGmPyuha1ylay3ISf03uweDsViv5rFg/+IFp9SkWw1
         sQyINTZf9hokkbNv8LbuYC7eTDdup5nBk1teSY3jj0ZMngPZgmEeEVUZRWZ0Lw9HWnM6
         tVRPNrDbqcW/vSTWoPokH6btle+iH+UKkXELiOZQmx0daQlw3TNLnTVbABqWZswTpiUN
         HTNmKQXMl2FwirX0bUFJb9msP0ekWRRrTEMZI6S2ULxM8nCB2tQtwafiJMr9OrsyPd5o
         UGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782958916; x=1783563716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9h5YwF6Ov71FIffCR/uSYv3hmUYhtMq0eI0sDB9+mE=;
        b=ki7hWaz7KelJoAih8D/uC6yXGU7Do2mGVAed+NNd0FZG3z5VvttQIxcEEhT54OQ831
         DPcjDtL3ggx337qzS2Fy+w1q3Tko1kWvdVMB6bJNHTz+Am5yCuCk3UGYHD4z0vnUxjsx
         N5EGI3XjKF155gWcONgacuklNxnijSrBhBTXqGBBbKdsKCUytyoaULO92zy2LKNyqb6c
         3KfOmTazhx4qWWYSvIZfUwJVK36Kioz7BPEuSLv4BpM0orS8PUfdPhX0c1GV04zUqmw9
         zzG+vCTmrJbr5Kr+2lOXGwvU7UX4wS1a4A/d5aVVsDIQbQR3Mhc0V+V1p0F7HTgudb75
         HoYw==
X-Gm-Message-State: AOJu0Yw5O6/3gP4rnyxyKdaH/hf8mnAmGalhn8/QmxF+escjlMJmOBY1
	kOsWfvm7LY6jB2zPLbUPGzKujX1xPXjXrdBahlgFeH1dZehOMqzM57oW
X-Gm-Gg: AfdE7cnahof+He4k24lfCk6qrydE7L7tpWrmI8J+L3MXu0l12jezO8Beaa2rC8kt4ke
	rOBDjyPn6ooS0lKPfTtXeoGNiyYy4LnSv3GmtKCVHHT70Rc8I1AdFlJ0tSFPunbHr49XbxSvFAb
	p9In+551WKexdfEPzNyXyFPmTwYdHHU47MBc4IiZNUDyfgeNOAJ0EK84gS0dVuujybdk9hIDxw6
	Q4CXJGG1YsxwY/Gugb5dPQi/7Q9yRJF68uBXkarkYAmggJ1Y1eklLFBnOqo1NKS1E0EMOx5BTx8
	ZnjXOn0JqNI/2D5CCjeZ91hejl9KAP+tPIGADfijPCv/n1OJTR6CIrTaZtEDa3xiYedL/yaPzim
	/m5+6yRqINw5b2W8VnWEAzMlEMHacZ414pLkE3/D0uQPFwoiAzoq+6YOrzqQUA75E030JeRsk/d
	3ZscVQ6HD3jfuetx8FKuJpza4QuyZUwp1quyr5PR9FGCFJtg==
X-Received: by 2002:a17:902:e807:b0:2c9:97a7:71ac with SMTP id d9443c01a7336-2ca7e91c1a5mr43734365ad.39.1782958915539;
        Wed, 01 Jul 2026 19:21:55 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8da8aasm6154135ad.8.2026.07.01.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 19:21:55 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id DDBB34163B72;
	Thu,  2 Jul 2026 10:21:52 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.6.y v2 0/2] mtd: spi-nor: macronix: backport Quad Input Page Program fixups
Date: Thu,  2 Jul 2026 10:18:40 +0800
Message-Id: <20260702021842.2771498-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

This is a backport of two upstream commits to 6.6.y:

  commit 798aafeffb36 ("mtd: spi-nor: macronix: Add post_sfdp fixups
  for Quad Input Page Program")
  commit 797bbaa7531f ("mtd: spi-nor: macronix: add support for
  mx66{l2, u1}g45g")

Neither commit was tagged for -stable when merged. 6.6.y also predates
commit 09e5a29fa3ad ("mtd: spi-nor: macronix: convert flash_info to new
format"), which landed in v6.10, so drivers/mtd/spi-nor/macronix.c is
still in the old INFO()/NO_SFDP_FLAGS()/FIXUP_FLAGS() macro-based
format. Both patches have been adapted to that format with no other
functional change; patch 2 depends on the macronix_qpp4b_fixups hook
introduced by patch 1.

Changes in v2:
- Patch 2: added .name for the mx66l2g45g/mx66u1g45g entries. v1 left
  them anonymous like the upstream (new-format) entries, but on 6.6.y
  drivers/mtd/spi-nor/core.c:spi_nor_match_name() does
  strcmp(name, manufacturers[i]->parts[j].name) while walking every
  manufacturer's part table to resolve a flash by name. A NULL .name
  makes that strcmp() dereference NULL as soon as the scan reaches
  either entry, i.e. an oops on any name-based spi-nor probe on the
  system, not just when probing these two parts.

Cheng Ming Lin (2):
  mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page
    Program
  mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g

 drivers/mtd/spi-nor/macronix.c | 37 +++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

-- 
2.25.1

