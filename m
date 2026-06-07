Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7B28469F
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780812720; cv=none; b=qN8Zkxjrt1WzdL4BnbqPa04VW6nGtYPZltjDQqjyn/FXxtAjFpSw/L33KwsD3xKYp8DefJAub5lkbG22NKbYJ3b1ABo0kerrycK0VEzPs0AAGr//FxI/PQOjhK0NhQZ3qpB/5Fo71MgeBkrpnaIEYkPOmkz8umNJFmEnlUW1M5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780812720; c=relaxed/simple;
	bh=sD96oirqm4ckkhaWc1fQu9F2uL78837hDwpVhGdgQ3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qx2EaGxtTjX3xaK1s8Kg+ldr+jpP5fQGqQidSy1xVbFEzD9CaHok1YK5cCGT39f2XELdWGds/FpuUE4Nr/xTIZ8G8TPIc8q9DgJUzOCrW96mUyUjzbGlxnxVr2KNOoG4Q7uxEc7uRGt2ApGk6I7nKRsKS0N7eXy/lUyIAAJlgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A++5Q4WK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A++5Q4WK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf114b0cf9so28281915ad.2
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 23:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780812718; x=1781417518; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4CzgW3/VXNfJs9yhqU/zZT2TtJnYVsjAwImG97RFLc=;
        b=A++5Q4WKAaID793h8me4/CjKVacqzTgYKtBb/4NlArBFITk9TtbGqZZ5tnRQbNN02k
         Rz3MMhbohDwYs/lBJQ5yk5PnVNPxjfOjgh0SgPGaqrzjLOK+XB8YyPEsdU01EpNrD3YH
         VsDfQBfJXuVZQMQNosUZ9XqVzvW4J2LG5N6GQNrKajV2Dg3Fl/z+7+NnZflFXf17Kc/b
         JJnPH1DHgMk/nqfhq0ZO5Z8MINlrHU5QOVNz+S4ZG0XtQl+3lFMuTjCTWHhiT7s+OGut
         H6lrmsFfNZi3Fkbc1b6T3O1uHUiEkLeduXCwijVI9TJLfCqf5hFovn+QL8cC/HVr8/Fz
         7BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780812718; x=1781417518;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4CzgW3/VXNfJs9yhqU/zZT2TtJnYVsjAwImG97RFLc=;
        b=oyv13iwnWrHD03MII6wHh9uo2mGB7qkHCHAjNemoUGSxnNMdFm6ktF0nS14i45teeM
         /W6/hbkFqqO8tyPa3ivbmkuSjyM/zHI9/nsmRAJiYrpf+27rf78hYj0pNlFRmTK7WIUJ
         AaDO/MWnh3ZkZqJMrXYXqo2bHTMY35EQpfB8wPx6aDJ6thgn+6JguD4hrCNI1Ur84R8p
         i4hoovpBqBLbRcBf5H5MtcvTYqx8G2mlEK5datj5aSNuVWBuN0ZYItbWCVc02fBQfnrC
         A0j07u03wp8IjIwUgIS+/Y22Jl7fVrcRonOvMRon5MvAf6vMEy+0RPSqSFfMX60jhe/J
         NpBQ==
X-Forwarded-Encrypted: i=1; AFNElJ996tuRgz2XyTWRc1JLX/cDfX76zRtg+j7V5EzAXqDGH30y/Z9c993xtcRPkMLeMvy7qHGdEpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza9loNT1zuJ7eWrKpZ6gMAOIeWLIvFW0dFDLHDbja8awkQaTTi
	2NIHfxGMUNG/9m3RUHZaNuwYrlOTUe2qJdp4aepje6HCILJJDLlqfTRU
X-Gm-Gg: Acq92OGlqhlIJLDF4Bj6wcfqgtHx5T1qZauWyTK4MMGeoL9G36oumJNTx7NBwpyhLWL
	CiMT2ylhV+tII7Pr8SyMemUvH+D+ijQUvZhCwfvTTK1ZvxPOgWFXIgjt/l51zUhGuwMXonwEC9N
	EGzht+NQCSLVOJWce8jS9AF4w6+gnVJx81TyLtZmpUuJlbxV7lYGATNrDshQdMptrd/j05DGbzS
	hs0HV11dkq5bR4+QysWYM5ZRuCWnyMG44IgIGIBcASNFaEYmFEXQDYxHVpA0BIE2c2xznGccQfV
	PTpyyHTYpcxsF2iL6f42bpFGt8Ps4ZkVxe8lmAFH+68n1wVSanqh8aPb2DbeCWFNMRZ/8SkO1SB
	XBJmknr2nVNvm1ugKhLlJVLYJ/6+aRU1hTuctCNTP0iGQlK60WlKicgVJDPXYINF8z3tZD53hp2
	N9EG89afrNicJ9WAIFPAfmFUmJc8Dl7FtyFjIh
X-Received: by 2002:a05:6a21:134b:b0:3b4:b216:2b1f with SMTP id adf61e73a8af0-3b4ccf80159mr13680216637.28.1780812717650;
        Sat, 06 Jun 2026 23:11:57 -0700 (PDT)
Received: from [127.0.1.1] ([223.122.38.120])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c85df0a4afdsm14265308a12.19.2026.06.06.23.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 23:11:57 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Sun, 07 Jun 2026 14:10:58 +0800
Subject: [PATCH v2] nvme-apple: Prevent shared tags across queues on Apple
 A11
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-prevent-tag-collision-t8015-v2-1-dc4ef4fb42bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2gEFX3sOwqMMAkwA1tCEa0
 rs7cgIzq/fz/5sdIq/CEW7FDitvEiUsCu5UAI1+GRilUwZn3MXo4UtbvCRMfkAK03QsMDXG1mi
 p8d2zdGXVMahBu728D/ujVR4lprB+jmeb/aX/eTeLBq8lUV8x+bo292H2Mp0pzNDmnL9xWMvex
 gAAAA==
X-Change-ID: 20260606-prevent-tag-collision-t8015-1c8adb3234de
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=sD96oirqm4ckkhaWc1fQu9F2uL78837hDwpVhGdgQ3s=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBqJQuj5X7yX0st4BSLbvwlG4Y23Krqmjcv8kUJK
 eJmcCRztTuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaiULowAKCRABygi3psUI
 JAj2D/9pVvXx4a209XoxNjr9ggO6sjnN9gdaSZUU6WD/bPUTGFUyk2mhMNzxfWJ2wIQQ89SnX6W
 pJGIZH55vvdXeN3NI6t9RwdBoS98XmqHS9nGZFb9Wqb7dFhkxTGMVVOuSEn9661DibNck167UDu
 boT1wYaIcB+T8RCR2QkqfaKq603iB1OizXUU+OQEqVCkIH5MigRf2S5/+AwzcqHYDh/epJyCk3Z
 B6PSTSWNm7puzXwLDXdH3+o5WP8VWoPisatGyzTt70KMTs3wrFNIqK4aQ3rq06GXPC5f5RCWS+D
 d6XVaiIIHuB60G7mJXVaETbfMIyhJZ/rEJb2BChuQXl9jv7O0vduj1977TUgaAG5LIHqY0EVDRD
 SbIgcxt4EIYW6+JZJC2l6EFajmHi1wicQq9199JbTkLav7ZS1dTbuQDeEl6pLLqjI8Av16OoIkw
 G3F1xlvBUoEEFi4h2cEFa4EqWFOmE6bNVqCpou1qHZq6zfovkqiRlmNi85ZcHg1+h66Tq+LZpZ1
 BgdcHV89lsGc1vpmhWbRhnCD2CfWnKgiWdqU1u3rXXcNOD4IJeCFV3ejOk+xxfl9b9KhmbH36PQ
 Ev6rU6o2iuHBvAzxFinW4zH3znRlCBPoZ6FYiClWNy1EbJUYGMiR2J9GK6PiFvOD/7x+D2eVKcp
 Fa8BpKVdI21En8g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

On Apple A11, tags of pending commands must be unique across the admin
and IO queues, else the firmware crashes with
"duplicate tag error for tag N", with N being the tag.

Apply the existing workaround for M1 of reserving two tags for the admin
queue to A11.

Cc: stable@vger.kernel.org
Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Complete rewrite to use the existing workaround for M1.
- Link to v1: https://lore.kernel.org/r/20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com
---
 drivers/nvme/host/apple.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c692fc73babf..da6e983e2005 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -225,7 +225,7 @@ static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
-	if (q->is_adminq && anv->hw->has_lsq_nvmmu)
+	if (q->is_adminq)
 		return APPLE_NVME_AQ_DEPTH;
 
 	return anv->hw->max_queue_depth;
@@ -303,7 +303,7 @@ static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
 			cmd, sizeof(*cmd));
 
-	if (++q->sq_tail == anv->hw->max_queue_depth)
+	if (++q->sq_tail == apple_nvme_queue_depth(q))
 		q->sq_tail = 0;
 
 	writel(q->sq_tail, q->sq_db);
@@ -1139,10 +1139,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 	}
 
 	/* Setup the admin queue */
-	if (anv->hw->has_lsq_nvmmu)
-		aqa = APPLE_NVME_AQ_DEPTH - 1;
-	else
-		aqa = anv->hw->max_queue_depth - 1;
+	aqa = APPLE_NVME_AQ_DEPTH - 1;
 	aqa |= aqa << 16;
 	writel(aqa, anv->mmio_nvme + NVME_REG_AQA);
 	writeq(anv->adminq.sq_dma_addr, anv->mmio_nvme + NVME_REG_ASQ);
@@ -1325,8 +1322,7 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * both queues. The admin queue gets the first APPLE_NVME_AQ_DEPTH which
 	 * must be marked as reserved in the IO queue.
 	 */
-	if (anv->hw->has_lsq_nvmmu)
-		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
+	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
 	anv->tagset.queue_depth = anv->hw->max_queue_depth - 1;
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260606-prevent-tag-collision-t8015-1c8adb3234de

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

