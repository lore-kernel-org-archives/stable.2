Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097508;
	b=xdRB24xkwyPOgfE3UOXuaOr3Ioq+na7F6EJ+5MFEweFYEWJYviEQ5OwoR+zcbwAa2rUV
	 ZwfvdzDoTKiyNTLaongYfnM82m6vWLwF7y31oJRw1rZzjq9PtHoJ9AyDg5qlIzDCbas44
	 FUvnUcYfvAfj/LIW7YYmtiJT80Pb/OCJTgxHQ6LD7yx01HzjA8xaiWa4pSETm9pqi4J8Y
	 qs8TzjGvJ4xjoYjGf+yTV+O2YwRLPoVPlRbM9lzOF0vjPu7NTZouP16U4MmKeatOz09Y2
	 0/Mnmk5H0M54Y1KJCxLjJyffcANp6wbwFuO0qnkU3l54YW9W4lq76mrvDd++Ppmykew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=C3VO9NPx3/E/rIdxFTBZKn/RU6zkWP4meAZHmerhPjA=;
	b=u9TIy+axc7Ghz+vHtVS49WDrSfR4qHrAtzMM6SRQKXCMsoZr5zFcooZwINMFAsBoCZ44
	 9woD1Ypisa465uzO1xp7lAx8zQ2xWuFosZpnR8lnq/7atq/qSFyV0KzHy8QZehjlaGsYF
	 SFjmc1hnwdIpXi+GXAswPR/TAvD9I/jDkzxfiNtFCF533lVjwlswufiz2JuZ0nI7dBFb0
	 XLWuZeOrqDAC7xfYDOshj2gvIXiTA1ZMmP8wUHH+CqfjL/igrKZiJERVhfqVWg2CnPCk+
	 2lvwdLdnmhtGeUUXgWYj3HByFsw1WKwQtq6hwdqP40N650qoNlq5nEau5EzHykjCjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmM+0VJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE2606A31F;
	Tue, 27 Oct 2026 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmM+0VJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A464D1F01828;
	Tue, 27 Oct 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097508;
	bh=C3VO9NPx3/E/rIdxFTBZKn/RU6zkWP4meAZHmerhPjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmM+0VJpDfIS58ptbirphpWN8wGyDC5murEJP88D6+Y9p6K35PLJzKIeZGGlDWlSz
	 ZAfg4XALpN3N6jtbtnvX7r+5M9rU3tGnTcI2ag18He8QkSFcsnnovZkGZtGlDBq5Zk
	 P+Po1a4xTxRSddhhB3S6YevC81xSJI8G5tngOXK8QcCsWDN1tUn4V59b8AU6QFPtAI
	 un3NV+QaO7k1OGEm4U1XqkOxoYjSAKrM4D+wAsCYy/a7JFlvUDo90n2zsqmOKr8QyZ
	 ZZSUzv4i3RhQIutqWk6SmB9mQCcyzGI53Ty8LJnZeDsCahBNkjMFdGKnOb+5vzpaeL
	 Uh+URw4rgzWKQ==
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
Subject: [PATCH v2 22/27] mfd: ab8500-core: Register sysfs attribute groups via devm_device_add_group()
Date: Tue, 27 Oct 2026 09:30:51 +0000
Message-ID: <20261027093306.2812695-23-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
Reviewed-by: Linus Walleij <linusw@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

