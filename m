Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624AE4756CD
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490537; cv=none; b=V+CCRObbH9xIo3dimIcBLdfezKfiQ1LBPfvCI0SAcKIxXnNtXHoUcCYIZ65Uu/WrnsNqQqWVWrd2Fm4+N+mcvEnabzdQeHJD3/WNsC9zykJUgCuOEjM1qdZvVTibN4ltJ6wtWdKc4InZLSBo/aNZX2khUYktSvBhn1zbR262hkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490537; c=relaxed/simple;
	bh=DLqDv4L3+uHnbPE4PzwdZOeh+cIonxgog0eao2hxoIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogMJU/KnveYmk/hR3+kzN/XZF6OtpTM0i96jkE5tD8EvPVhTbsF9bCeY6WZs6MwyEifefmBPvvoQadvthDKQrtq8qOn+yio1tQNLxn/CanaVtzDlintHudZgWXMMGc2ChOYfDTih7Z4gFErkBh8Fx03Y5qnLQhWuoaK3DG7RCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUsPssO5; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUsPssO5"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so3333252b3a.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789490535; x=1790095335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/Pvtp06R2zm1FquGnmOniD1kp0250IPS76W8PSHqFY=;
        b=KUsPssO55aXnjDi9DAOxbYuxN52nKm5gJeBp5oQOfKSHtzUf6RBqqsRzULKLlWGwjH
         EFrZRYJkJ39u4TAxhOY5ZeNKNUnMCRqpWazqbLX0kF4b1tf0d/zb0oFRl09U+XujodMj
         yX6CSreNOLp7h5T/+3mFJrixsPLPDH7TrKioT9tztrIY23qg6n2mjGVJOYBVYcMV8WsR
         EBM24g5zq0jZM9vhgdQUuR9nPxHQmuCqKObC9zWSqmsuCWoP5W6qwlKmFtEtG/jCuf6S
         G9gqr+7gWWI5uKAug23bzsnv+5/zdVW09WmRNmlbTGyi3OUHgld9OqUzJ+KlDhBXM2O1
         NelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789490535; x=1790095335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/Pvtp06R2zm1FquGnmOniD1kp0250IPS76W8PSHqFY=;
        b=aGzGB9oDBs14aqkzwDselhVFPLTR1+jcdIMea2GgCunUxZZ6hu6vc8VtBjjjQMuGVc
         asOrxjX1xk2e6hlCGI6jT1q7gFzZPMT5oQglgOrGPt4fK7ke9pWaWGi0lmLquMRWQpUD
         OU4YmXh4ho6etO0h2xbh/Ofhg5Zdyy4vXzFLthWuKo94ctie8NOW45OGUaWLLTd0TqdL
         vXYELXRnAlTdtq7Vy65mMGRi33x52zYkIiBV/TCfiPnIsVL5Bqbj5hWWb6HPTER92g4X
         4UiLJ+iHrxH4wc5zRHrOm6KzAZseiwQ1vkpK7wF5etKp2aKcisKStSmxBcAlZuA41XGf
         7w5g==
X-Gm-Message-State: AFuF++kRjtWutzcS7V4rQmC/yYD1DeFNvz6D5lVI3vrMylFG1N7bGi7I
	YlCXPnRph0UdYhdhFYQgmGILMiVzIrCcv06pHeNktQwgCFOMP+bA0o/f7S5H/aZM
X-Gm-Gg: AYBFou3dRjzCgnlY1KC32d2NN3O0WxypFY8S+w/CpJrBeC7oUSYiwh75ujVceJuKe8V
	DnjiNFE4WdW1vZUSS/d0iJYwXywUjYoVVOZo3MJirNqq+cFiXBYFPB8hw1P2sXVKLQ9bTLQfVdU
	euu9Z7T/TjzIHD2VNx2iOhNFbtCCUzmBTTbOjnYk3XRaVhqaM5ZM19oA+b4cd6/nJUWla89R1Bj
	IgQgTuEre7z9Gphg98goUa2WJdkCE3/c5GQXqntkcAgtWoFNzjX7yYEW5OU+T1FE264NP0Aqheu
	A+FG9HICe1CrvC8IScaBF/nh5sgu0sKdEIWMYLwGkm1NJxRD67WCnKNmmTiwMKgyTAaTzwLizDP
	PlSW+AXQeRAVCAeaFgxBU20YKXMHUEEHaZYS2AtnX0KjG6A4R/SW3H/SDaNarzmuXoXb3wdrpLe
	U3UvQ8JPK/u6E3FX3LOu79i/v5JcRYT9hRqWxkHUpdpQ5m21H5FXTmcQ==
X-Received: by 2002:a05:6a00:438f:b0:857:726d:2e99 with SMTP id d2e1a72fcca58-86f85beb5acmr15304470b3a.22.1789490534563;
        Tue, 15 Sep 2026 09:42:14 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab8ae01sm214501a12.18.2026.09.15.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:42:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rosen Penev <rosenp@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sean MacLennan <smaclennan@pikatech.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mtd: rawnand: ndfc: fix I/O mapping leak on remove
Date: Wed, 16 Sep 2026 00:42:04 +0800
Message-ID: <20260915164204.2492099-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ndfc_probe() maps the controller registers with of_iomap(), but the
remove path does not call the matching iounmap() before the driver is
removed.

If ndfc_chip_init() fails, the probe error path correctly unmaps
ndfc->ndfcbase. However, after a successful probe, the mapping remains
active for the lifetime of the device and ndfc_remove() never releases
it, leaking the I/O mapping on driver unbind.

Call iounmap() in ndfc_remove() after the NAND device cleanup to release
the controller register mapping.

This issue was found by manual code inspection.

Fixes: a808ad3b0d28 ("[MTD] [NAND] ndfc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mtd/nand/raw/ndfc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index a48274297d3b..0091b335b651 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -252,6 +252,7 @@ static void ndfc_remove(struct platform_device *ofdev)
 	WARN_ON(ret);
 	nand_cleanup(chip);
 	kfree(mtd->name);
+	iounmap(ndfc->ndfcbase);
 }
 
 static const struct of_device_id ndfc_match[] = {
-- 
2.43.0

