Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584986;
	b=Or2yjOV3FHjxk4BYHOzjZ7eH81xxgAnqejWS0w6nz41lsqlfJKt2IvFWI2gsaP9ZTVLt
	 CEyNiMlXb3p+Wt4M/83iuN3+TVTV+az6vjod/+/b/M92mM5jS8m/0SqhBEASkALAtP3pw
	 iCydcZ7QFBjmM2lcWABfMlwYiINiTSM0PTpSnNzFbwkh9RhzcoA00hZb25ACbfQjktMK3
	 HZInNJROgmfbCxve9UMXRz/ZUaTvghwNYQmxtc8qd2PFqyIG772VezjEwV+MhcrxMKYqR
	 lxhQMF7T+ZHuhRkBZViB+etylA6JtixN0nyqIKVctKkB1kUEYW42fOd8kgdGXep0BaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M1n1hBWFrb7+3IcENFJ0R4sSlfudB755zznR4XrxZXc=;
	b=CtvNGBac++68T8wfU1n/pB28O1NHVVR1c/8bc8D3N+COgfbmvnq2Nxhol2yB5Rvrcnuu
	 PWL8cvVxtzzFtx++wCAKnlhNgKaB4uVMPgORrqWBPB2PbSHKgRJhP0fnW+o0TPlmhsVHe
	 ruh+OICewOyLEOZ9s1dGVgM8Zchr61OA1OMSJu+e6Wu3HwTgqBlcSItq5s+4nTucbJyeG
	 VhD/qjNwuZGeJ48v6nt/JRsCE+SRZXhzrNEt1ZwFUUdGRk5E53MxOpTGVL0m5/j0l/sBo
	 RsZY/X+1k7U4yaPKr155ngP+V7Zh+eY38D50QGsyeDCXIM9h5g+WHd8h4igFgGWoOhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU8cB6vn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24260A5BD0;
	Wed, 21 Oct 2026 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LU8cB6vn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94E81F000C4;
	Wed, 21 Oct 2026 12:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584985;
	bh=M1n1hBWFrb7+3IcENFJ0R4sSlfudB755zznR4XrxZXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LU8cB6vne4L6Qq8Oej/VmD3BuW0L+pIt+q5mkY8vUOpDTS0Q9Hptwta18nA5MivL/
	 8yg30K55p4JIjEgUvHh1xCY+wmXU08M17tag6LFiBMvqbG6Maltu8FV+8Vt6BZOWhb
	 10gPGk6rM6UFB2u20yZo+pTx+PjKS8JjFWTbm6ezdMWu2OOh+/o0VHTxp/ag4d/2qA
	 mYsrTR4yz6kZXz31SPJuC/tSev5QPq1LonDxBM19fb+Q7EOcz0rZS8loZbMCLnz/3W
	 t4jyjo97Zz23Ve0R5fEMnpfsLGdya+Ksge7l6SFZWNcFWBPAV0jK+06PBBt5JqyIw9
	 /yXPuuEf27LTA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 23/28] mfd: ab8500-core: Register sysfs attribute groups via devm_device_add_group()
Date: Wed, 21 Oct 2026 12:09:45 +0000
Message-ID: <20261021121245.3111563-23-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
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

ab8500_probe() registers up to two sysfs attribute groups with
sysfs_create_group().  On AB8505 and AB9540 (cut 2.0 and later), the
second sysfs_create_group() call unconditionally overwrites the return
value of the first, and if the second call fails, ab8500_probe() returns
an error without removing the first group.  Because the driver context
is freed and driver data is cleared on probe failure, reading any leaked
sysfs attribute dereferences a NULL ab8500 pointer in
get_register_interruptible().

Register the attribute groups via devm_device_add_group() and only
register the second group when the first succeeds so that devres
automatically cleans up registered sysfs attributes on probe failure.

Fixes: 93ff722e8853 ("ab8500-fg: Add power cut feature for ab8505 and ab8540")
Closes: https://sashiko.dev/#/bug/linux-a9ac1a9d-5a97-4ad3-b4c5-c7775c24a333
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ab8500-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 86fa99022cb3..408bad2f577a 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1232,16 +1232,13 @@ static int ab8500_probe(struct platform_device *pdev)
 
 	if (((is_ab8505(ab8500) || is_ab9540(ab8500)) &&
 			ab8500->chip_id >= AB8500_CUT2P0) || is_ab8540(ab8500))
-		ret = sysfs_create_group(&ab8500->dev->kobj,
-					&ab9540_attr_group);
+		ret = devm_device_add_group(ab8500->dev, &ab9540_attr_group);
 	else
-		ret = sysfs_create_group(&ab8500->dev->kobj,
-					&ab8500_attr_group);
+		ret = devm_device_add_group(ab8500->dev, &ab8500_attr_group);
 
 	if ((is_ab8505(ab8500) || is_ab9540(ab8500)) &&
-			ab8500->chip_id >= AB8500_CUT2P0)
-		ret = sysfs_create_group(&ab8500->dev->kobj,
-					 &ab8505_attr_group);
+			ab8500->chip_id >= AB8500_CUT2P0 && !ret)
+		ret = devm_device_add_group(ab8500->dev, &ab8505_attr_group);
 
 	if (ret)
 		dev_err(ab8500->dev, "error creating sysfs entries\n");
-- 
2.56.0.218.g1ec904b173-goog

