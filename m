Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728161;
	b=U1otLcHOrM8o/3GUGTp1J90SvkEuY7P157wE0Xa909OEMrWE/aofCuNyZSlqYx9YhLlb
	 rsmpti8TnIcz+C65lCUkkfvTm/k/cgcWkdnHN1r1AK3pqsxpbENtfBFgC9/GMSOM9NMKB
	 vyuODJUJBKioLKFyk+Aa31P9dS8MkwjXBdYUdBnryfT7sLPAY8xIKe3D3OtLFgoo78/Rd
	 t3zBUEwhINN3oXe1aMxOZNaJ+5XfxhRNc2dKUG2WjgnEnnbp/LYjdZMUSs0dI22/hlqTo
	 x/hkqZWxG+ec5TuKVOtiIt9hufB6MiDbH5/V3+lbdDcdjjhAab6XAjRnXZBso1UI/kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FgikEYkiQsJy9iETUjpbTLeVR9t9RSzyiZY/EMx6FbU=;
	b=2u6e9DAk35ruhqLUUNSSDmdOqyjIMrgtnamnUi65VqGfuCDRWfgvbuEcSK8NNZJAhyMo
	 7oK7N91Y7LzDe0QkSekP5tzBm7DyFx7wUH5xCYo/MickC4V/lHP4imFs+DPHc29Fax6Cd
	 1AwsWN9oc9hwTl8cl6VgWREpmlVeDQqtT97aqo7R/ZLrXAwMgByYde7ka/XyUvgBQDc8C
	 7tj1sZpj/a9vpHE35FvtbRWfMnaoDTb3rkA1CMJ00/xWMffIIqMBpR3vuLfADzRv95B8b
	 jUr83IX3sCDiYdknmHbdAue0wVHCTUtAgYagj/IqMigu0kibY/y9oUifvUjVH+eZuZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJZc66fg;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E912606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E912606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJZc66fg
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a6b774d12so358179eec.3
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728160; x=1794332960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FgikEYkiQsJy9iETUjpbTLeVR9t9RSzyiZY/EMx6FbU=;
        b=eJZc66fgV7RiNdGmc6O3XIKbRsi8kicehYGWe1f3xOXiMFhruz7iP8Bt+1rwtyb08H
         RBUBpzcbr50kwLRHQveCwqEPKJ0qvDC/NFT+njcF2NHBM4LVaAnWhefUdlYY+50aXKMG
         Sy2gaDDV29T4NZhFiMc1EAmDRPoWRjTb8Jbra8rM/MfKFWTt2Wn9bQF0+gE76a53mTYH
         5LfJDm0IuRRbTrXyZQfCOqS8h489OOp3msN+UMMPCn0mOc7w53AJnVitxKNoN7rGe/IP
         avWsWaC3pBdwOxDmffIOh3LiUDlDk0Hx6PB3mn51vuWilNt18kZxBLyIqnv6r15ZkXy3
         IIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728160; x=1794332960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FgikEYkiQsJy9iETUjpbTLeVR9t9RSzyiZY/EMx6FbU=;
        b=wMPqL2hJK/+LombRVHF3u3YQHKwbGllEJKiy6ZpkL9o+K7jXyBfEAFZDhGKFV4FGlI
         EUrvFtm/9MY6fKo3a2DxXdpooknvaz1nTLe2r3o9j4MzgLiaAnvU9n8IOluZ3X8DxwW0
         0Rn7W819lPlQtyX4jbNR5fbKfZ8FP9CsC9QsSfv/6kgajloRp6fZykKD1j2XndYmn4o8
         VprCJxlstpr42J0IjhYP8yOOaMnUkzIMnllTuG4t1TqPTJKxsn4JBwcEB5oygXrE4xRu
         lWSr/kiu5729BRVfiBQe18qffXYIyoiaPORT364CWqZzWs6AgLWYomnvgnS1UYsYabyF
         6zKA==
X-Forwarded-Encrypted: i=1; AKwUvBx1/PfmplIIEGSEtggeyd+uZTu1Qld5bXrz6bkas5GjIaK3Wm1EQX+w8K7WdbyBhpb+7++ckbQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NVPilREkaYn/rOmIrr8+9uRb+zf6aaW9Uuy/VNdzCbA+o1n5b
	u3Y0e2APbs5oRqRM9PMCCjHUtnULTMoDCUT0lOMWm3cQHmELIF8KCpG/KRmBTS20dAU=
X-Gm-Gg: AYBFou0U6vmqcmWyhbvxSdn2T4wgdGhEg7aaGuP38LoKLtP2nzRzwqR4xkk3wFpwQ4d
	ZJ5cbfUp0U96iAkKkejTdlezu6xBfQieReslrY6AL/xbhvo+HA8zXgoN08k7NHg21D/Bq2lQlYt
	HvZkaAHWrJ8SAb/woKjpSL3jMuEiTNZsMDH39ivYmLaiUCR6LETcewyrkBbRpmd2txyoaWZY8jl
	989zAR2VY90tnasNtlpn9Fq8/b6RyrA7laN29xDP+K0VKncdQdfJax7WLfXDNvMj/oot7r4Lyb+
	QmxB6G7swI90+ft7RSPAYcTGA0oJ/iyjLDLGbr3f0beZ95cVcoOKGuG9uJMUbLsvVaHmcru5jeb
	shyZRc/vK9L8eKAA01yuN6NLA8etHeL179zbNxFAlA58/MdN7oHSPC4nGKPpBevJQuSNq80P+0z
	BMPlY6AfT1yiRFGZrnXH6itl3X9zxBqMYeb9uffPnqvMmg9fHiDbG0Rx0hpmYyiEaH8vHH6lqqC
	iR3zI6jYrjEQDsnmmpGtXPs1M1uT7unV/yhVYWV7U5OYIvcvAZ2wh8r4xYacA+PeKes+p/GnR5l
	x34g+AUwc5RH4skaeBLWwRlZH1e7lf3pwYgeV0o/Gg==
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id 5a478bee46e88-36a4239cc86mr30667708eec.2.1793728159684;
        Tue, 03 Nov 2026 09:49:19 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm47757914eec.6.2026.11.03.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:49:19 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: cancel disable_work synchronously in regulator_unregister()
Date: Wed,  4 Nov 2026 01:49:11 +0800
Message-Id: <20261103174911.1600930-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regulator_unregister() stops rdev->disable_work with
flush_work(&dw->work), which is a no-op for a delayed_work pending on
the timer wheel: flush_work() only waits for a queued or running work
item.  A disable deferred by a consumer's regulator_disable_deferred()
therefore survives the provider's unbind, and regulator_disable_work()
fires after device_unregister() has freed the rdev, dereferencing it
via container_of().  Use-after-free.

The in-tree users are ASoC DAPM regulator widgets with a 20 ms
power-down delay (sound/soc/soc-dapm.c): the window is the entire
deferral period, not a race between adjacent instructions.

Use cancel_delayed_work_sync(), which also dequeues a timer-pending
instance, waits for a running callback and blocks re-arming.

Found by static analysis.

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 6a4008f387..032b7298a5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -6300,7 +6300,7 @@ void regulator_unregister(struct regulator_dev *rdev)
 		regulator_put(rdev->supply);
 	}
 
-	flush_work(&rdev->disable_work.work);
+	cancel_delayed_work_sync(&rdev->disable_work);
 
 	mutex_lock(&regulator_list_mutex);
 
-- 
2.25.1

