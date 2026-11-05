Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855032;
	b=SCYtlzjJDCh6OnjAuv025ZCQckJoocOMNniffZ3b0eX8YxwmuUgm854WcUZ0Xk+Pg3SX
	 LxuSAQttiVGXmc/ByFQyAs6V6w1Yt+vw4jTcBs4DI43IjmooyZXrLpmddiSNUFrU2ub32
	 8SjsBpnCBv4kWzp/WgCA+eglEZxX+fWRKsCt18HbmGdJBvIZN/L/DinzF4XIpQx44RhRo
	 oV7cd2Fqkun7z/u4K+TSmKAR8OtzMSi2bu7y0kG8BG6HVVYnmL4rzm9HmoSMWKMdCc/1G
	 6dmRj0GYXfxmln/ivRmfn6OZD/MP/lsLIEHB0Y3LIbV9iH+ScHraEdUR8FcWEIqSyrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=9/MyriLLIFlAEHMufWPIWBvD7cPvXwMz6qb27EKImvY=;
	b=WZle0IUCiPnFuQ2hfztzbQoFgAhrjG0y46Y9b7WUfMxb26vP1PSRCyAqPhuM1S6sOntI
	 0cNebIY5GSx/kALHv4SK3sLKUkE1+HbKND8HN4Yk7dvv5UbO7GV5KtrhLhLn4qwGPbdmN
	 aI51s31gBpmTpfpSdsezQFQWNnjBkbSiGyu46e958NxpoyhCZrBRnxGEqEMzoSgeGL+4A
	 iQOwKPw0YlNm6+lAo2RBjybKrB3ESvvW1FwTwa4SPjzshLqNCmCovx63KUPhao4GbfgMy
	 Fd9HEfiYuZ+SRbeAIX9azRmdLi9zTPQ7dgbqr5mmY3MLB023yFFSmYRg+AvxFaRPuOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4UPpiE;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB1606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63AB1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eK4UPpiE
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8490a7d6696so921949a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793855031; x=1794459831; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9/MyriLLIFlAEHMufWPIWBvD7cPvXwMz6qb27EKImvY=;
        b=eK4UPpiErrl4l7SqxayZeQBSeqp3a0aHy162SBx8mFLn3ae6nYQqS0pc5V4jrsEc2r
         7HE0+xrI49crfF4O5Nq8OCOEs8/acn00YPGbekFh0OzhyCbdlKFy2FMWYdw/iw9pRy0o
         ODcHSOYabbt6Lmecs5rJwELO3wx/K3s4zvje7jEOWigRTM4OCDjZSpnNLBHJsOlMxhqM
         8cyebKBsIG6Gny7B8TQajdEPwFlM4Lyge36404Zq+eaLQKnX9Deiem+56DFTVPuJCKLf
         hgu6TnJQOGonG5TkncsLTn9THdEb2AQKidAfOlqo2ntcUrJy2ZVHcH91el5wdz8jwVcr
         fXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793855031; x=1794459831;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9/MyriLLIFlAEHMufWPIWBvD7cPvXwMz6qb27EKImvY=;
        b=kGtY5g9rTS0tv3n8epZ+ekHTv11t+zDZURYPiP515sFG4e2HyWtEKrG8iIu8VGspP0
         QY4boay7ByC8d/nN9ksfwOPi+ayZM0mkVDsgLHgKyj6B8H/RVnvCaMNLj6SjS+uACacy
         yGJvXU+M9nzyleiLeP3abFxpq3lGI++WYmgPAQXkMGINrmka9EUmnb3ozxyPtyTI0Mym
         86SsQ7kdluxeCWdyDgbcQhrMLJHV9ZSvY3rmd/6nFJyLBzQ60OX0wEHZZ2/709ebQ9eK
         gqTR/QBx1WUhm/Zfvwj9vTQIB/E41QH8MDqxjaqpoOWwPQ/2qK66ueC10+qIu6LGOzcr
         Mcqw==
X-Forwarded-Encrypted: i=1; AKwUvBxh7bIKn6cq3bCTfghiPg+GAI2S41TbV8se63kelPyLHkzhkAMqO7MqNyICnHFyWKcnF76NSEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/E3Crcp6BSP6bw/RIbKuqDN1eG7GoNGXZZm3ndfyR0yInmvK4+
	JLnQWwnV4dICT5SZxHJeZPvr2TNAMgcmqFlBkOQCToqDeBH8pNkn4e6cpNKm6y5D
X-Gm-Gg: AYBFou3+jWIvT0+kEcivCQYdQOotx7jied9G8JM3v0vHK9Q4O/ODNJ/oM7Pxv/jNgyj
	lO05GMOQ9O6mVMV015BgzyaiYZbqrO8sZU6GIoctDJlRhM9jKFIk//R4XmsJulnYaDmr1/lB9bG
	T9CBlPYDRdICT6JMCXGjpwsP9EpCIj2vUU3iE+NNBQsa68BwPkdmFARGX4xK20V2DtW7Vb49Bqy
	1WGLj2dudG7mgLWcFDufMhAO1sIl2uxZEZOc1ntQdoC+sROhE36KLJCm77FEKZhiH7iEXmzFp3P
	7VwL15jA4NtFgR4wVnNY9irxL4J/rpFnhTu3Ll9vE+lCFTqVmpH+9Z8nBts8VNzprzlmwJM2PAd
	jUduWI/oVVRHI7eYykJvbJInCq9MGNb214BdF9jjttfbemFGEjTwiMbvxxMPfiLmSdeIRc6V5+G
	4kEizA7Ufw1VUDAtWXVqgNvLJregicxVSYyI8m4a/ekmYwTreVK4KBs8nezaeRAujB+UE+b/8T4
	izCJ4Y3cLo0ySM1ZYhRmEHMtziX/Z8GnZRyUoX5UyOW5jD1DvVy5A0BFB1h97c11BjW4NieqEL7
	Ud/KlKHLZWDsGN+dtzbLoHu5daRHuLO7RpfEa5rTTEEU7ttVSQ5AdStX79XmJK9RWfZ2Tvm33NE
	oWWMLtsh/E8LltpT82Fsweaxc65UPz4ICgfdP1WCyzKZUQEcxjJ+rL1B54VVdaTbadHABOBks41
	6QQDcg4ssE7dBBpYZByCrPRnl+ZCI3+pquFbYQnAYxAKheq2bL0sE=
X-Received: by 2002:a05:6808:191f:b0:556:82f5:5aaf with SMTP id 5614622812f47-5640ddca454mr13902714b6e.49.1793855031069;
        Wed, 04 Nov 2026 21:03:51 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm3256982b6e.15.2026.11.04.21.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:03:50 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 22:03:38 -0700
Subject: [PATCH] mtd: core: skip empty read and write requests
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-submit-mtd-empty-io-v1-v1-1-3f6bcf474e2a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5FMBBA0V+RWZukgzTyfkUs0MFIirQlRPy7P
 pZnce8Fnp2wh19ygeNdvCxzBKUJdGMzD4xioiFTmSZSBfqttRLQBoNs13CiLLgT6kZp05a6oJw
 gxqvjXo53XNWfYzlxF/43uO8HzgQKvnoAAAA=
X-Change-ID: 20261104-submit-mtd-empty-io-v1-6a06db864131
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Converting mtd_read() and mtd_write() to wrappers around the OOB helpers
removed their zero-length checks. Neither mtd_read_oob() nor
mtd_write_oob() stops an empty request from reaching the driver.

For example, the raw NAND read paths select a target and can read a page
or its OOB area before checking the remaining length. An empty request
at the end of the device can therefore select a target past the last
available one.

Return success from the common helpers when both lengths are zero,
after mtd_check_oob_ops() has normalized lengths for absent buffers.
Keep the existing range, write-protection and operation-support checks,
and clear the per-request read statistics before returning. Both return
lengths have already been initialized to zero.

Fixes: 2431c4f5b46c ("mtd: Implement mtd_{read,write}() as wrappers around mtd_{read,write}_oob()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/sashiko-outbox-198544@kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 491a27d0315f..93e7ff3ba8a0 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1805,6 +1805,9 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 	if (ops->stats)
 		memset(ops->stats, 0, sizeof(*ops->stats));
 
+	if (!ops->len && !ops->ooblen)
+		return 0;
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ret_code = mtd_io_emulated_slc(mtd, from, true, ops);
 	else
@@ -1849,6 +1852,9 @@ int mtd_write_oob(struct mtd_info *mtd, loff_t to,
 	if (!master->_write_oob && (!master->_write || ops->oobbuf))
 		return -EOPNOTSUPP;
 
+	if (!ops->len && !ops->ooblen)
+		return 0;
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		return mtd_io_emulated_slc(mtd, to, false, ops);
 

---
base-commit: 1c1a342aceec79528b3ba51f376eca2be5928fe7
change-id: 20261104-submit-mtd-empty-io-v1-6a06db864131

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

