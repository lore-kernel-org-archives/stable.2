Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC651815C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751451; cv=none; b=RHfdGyw8k0tU7khdT5H+L2ZVVO6bQ9rUs12P5rkgJY5xZYtqq811rU8s19OspWo8qkJrHlTW0JzQFX+OTfCddlcBNhzlDYlXxRspC5hdbif2bqK2XrVXt+gqRX7v8PJJqdukOyAu8vL1xtLfHY+H9pP30qepGJnTix51BOl2KBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751451; c=relaxed/simple;
	bh=ucvUi70zYMSNKdpB5M9U4/0JPwWH9o5vYxQ/RxH4z38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDoaynh6GRK5HNJdaoldZ1wfvZ1cwnu0ycN+o9IIdwsk65BRZB/bv2Id/OLbjxcRbIHAFOWsKxzbrLH+n1iPqqhqVbiviHqivvuzlhDqRT+gecguEZRIwfviPVLbi6c7CdKczZrqDQsDNXYZjs/X4Gl364QzMq3oLcsXPFM46ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/3Gfra/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/3Gfra/"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed6d6eso11023705ad.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 10:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789751449; x=1790356249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tVg6kTrkQkmUGuiks//D1y2XA3XKuOl8NQNCerU5SkU=;
        b=X/3Gfra/nivtqCsk6pHkyBPJoOHZb/Q9AOv7S6Hz/RqNjy5ZMpa5/+iO3h7rf4z+Ju
         ZIFrygxxDdPld07CBab3jooOq3WZxvbF+2jNXSn1ARddELHeUEKcQX8tN6VPKr6t2ALx
         PiChhSnA13tlFokZqEf3jAQQXf8/NbAwSyoYRYQ06cutbgmM+elE4ONIem79UpfmvrSs
         Ob+2t24gYN0gj7wpOKRKgtkHDRxBOYIK1Jr3ovEGuHoZzhMyvVMAzlqE+EP9bQ15b6o+
         krVk5SIJwS+TwilOmWhDACDpW0MeJEibgBVhdtksZLGuctSJVwWbymsMmq70yUJ4WZxX
         M6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789751449; x=1790356249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVg6kTrkQkmUGuiks//D1y2XA3XKuOl8NQNCerU5SkU=;
        b=I3XXUZYp6oUB178GrgDi9Pw7VLCXyG+GOtO/C3DhWzxy4dYcQsgcly4eD/aqDvPzwL
         gJMqmEU+a5ohNJJacY0L/EFovWDjSjGjjsRCsUjRWVqkFaExdzlxURZ28AHabDUmHSKq
         IlK6BFuRl04xX1ujKYoirvM1PTrp0HQtY0QslPtiQazLR1+o00XpT8uijxW5SOaLtEK1
         23ay7DfF7hBi26EDdIxun4RqICntbdBhpFyxUaebrWim523qqizCltP+MvB9a3EuBOJO
         zcOlfJZhDPc0U+byCitMQTdvDEQkQ/yq/c9SCmvIVjxfvNIaI4xDNlrfW2zBlYqTi0l7
         ntVA==
X-Forwarded-Encrypted: i=1; AKwUvBzPoXSEj/KzZh+ZpOLr/NMy4CymbjRZvG9gIwNzhlhHX0u3vSKtS5/j9xwSz+hPXLyk861RGNI=@vger.kernel.org
X-Gm-Message-State: AFuF++l+DVkDJisnM+P7J5iH1roGd+/10pwBIxgXZve+DgP4+1L+re7I
	fmgQH3JtGKWI+XZk6gdRDc9I0HU6SuamuBImyDoyvFeXikV26o/GhbRQ
X-Gm-Gg: AYBFou1VYeV2XAey8X/CYK7y6hUYHlm2Cwjl+uHkawyPniEWumFlWhOhljbwFGwNsof
	58bD9hHsqtGn39F+DCRNk9Y4kfuhaOB5Tz/pazFy7HRU6jfHW5NzEZry+nLXyCqQ2maDODxoCUp
	JTl9gv+D6O7qKpvUZjfPXJUa8iT3MqUCK41bMnCt5xrlbKjAMOtkldIVTcUOsFb6T6utX0Myro9
	A0c33zZ9pFMjjjBc01b/MBBOi8XmzWrXOxTuyyi7cIkJjTL7zYd5wPyYiGBvDu3Xt6hLArelhdA
	V1xMPq2IiJ+7iTUXB+Ja20VE3s8ejXwX9uDaaVd1NoniR3pilFd2FwI3frQFeb7/p8LnOLhXuX5
	plRQN3DKXoE5oUsRGy2/f4V0vPZQ/qNPNiBVcYdsi/6y56fi8GqwTIKIvtjwOjqUA7EFnj8TpQt
	WbQAXrjmLXP3xG9lV1IxCqta6UOkomGkdw1/AD4F89gPk270Autio0pw==
X-Received: by 2002:a17:903:1446:b0:2dd:c100:4b7a with SMTP id d9443c01a7336-2ddc1005ecbmr3691105ad.49.1789751448786;
        Fri, 18 Sep 2026 10:10:48 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75b6552sm11775625ad.61.2026.09.18.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:10:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: lasi700: put SCSI host on remove
Date: Sat, 19 Sep 2026 01:10:38 +0800
Message-ID: <20260918171038.3588395-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lasi700_probe() obtains a SCSI host through NCR_700_detect(). The
probe failure path drops the host reference with scsi_host_put(), but
the normal remove path does not perform the corresponding cleanup.

As a result, the SCSI host reference remains allocated after the
driver is removed.

Call scsi_host_put() after all users of the SCSI host have been torn
down to release the reference acquired during probe.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/lasi700.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/lasi700.c b/drivers/scsi/lasi700.c
index 6d1fb55cc3ad..1b4982cde210 100644
--- a/drivers/scsi/lasi700.c
+++ b/drivers/scsi/lasi700.c
@@ -146,6 +146,7 @@ lasi700_driver_remove(struct parisc_device *dev)
 	free_irq(host->irq, host);
 	iounmap(hostdata->base);
 	kfree(hostdata);
+	scsi_host_put(host);
 }
 
 static struct parisc_driver lasi700_driver __refdata = {
-- 
2.43.0

