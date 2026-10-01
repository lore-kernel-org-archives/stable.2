Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FD522695
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877481; cv=none; b=UDf/rTTLR9G+/YppNTxhN0vro8Nr7JpNbWOOwDhcWSxPvMfElo0oKb5419M9dZRhYLavK3kaXVOSAa2cCGV4qlOICEifcpO0cyNr9yBSU5PGOepqc0jP/6qQZEtpu6IYdA4V5NiNr40DP0/gOZ0rPG+X71k9eN0/Wj4kP3MZe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877481; c=relaxed/simple;
	bh=sD614/wHqA+UNZ8ljapcNbYh8hzDq3pRigpRikE5CYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKNjaSN8vudYV9xI+hLZCzroEASLlMs44zOLdVs5t1TWV6d9HEamPw7BpKM0q1SG8tIChkJM84Gjgegzfihqf2Et45LW+IPi15v/YcngmNckLOgDRT9fccROoVajWcYyIUtptUCHOQU33gJF7CalXokHQzP//dw/ynVREbQe0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb5P+2Ih; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb5P+2Ih"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-9179750d44eso12882366d6.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877466; x=1791482266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fL9Q0QFcSoIbKOwsxFEseNsJaSBrJfTVHaNZtRQHhY4=;
        b=hb5P+2Ih+Cnr47HGOR3lT5hWL0tLvegKdaW23npF97InBUCtkscU8qPl1Sb4dAdXu7
         UUSEJq+ec2zaQy7k4zn/w6iQw3twGT+pqshqL6QvNPbM+7wFxwd8c4Y7bOhaOctv2GOf
         R41BjYmqh3YD+I96ZFf4eGrqTmLju0bOgzSqPJwLPLf5Tz8cr4JgLaah5/1hZAKSrvH2
         ZS6+1lo934VGjyhyg/VvJF0PBUYyXWj5dIJkcwID6e51FCGrQEii7kQm0lnRb/MGITiD
         DuXxwHcFAs7O1jacqUbo/jAFkFler8d4I6lCl+npz0O15JOdYExr+PMHrxxrlK/XQydu
         GYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877466; x=1791482266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fL9Q0QFcSoIbKOwsxFEseNsJaSBrJfTVHaNZtRQHhY4=;
        b=mklTHjMVKq2Ukd2t8zlKphKLlMdBG+kBKfax/uKJu4mLpBtYV3tuHVgtkMjOjwwYwl
         jkUc0gNmac6oXWRg/S64jvk4KU4KwCqjr1OVmiuRTfKOxlktWNzfbgSfb5JKowk8bR0H
         Iam1Ivvg5sPwoZW7YWCVFSYEWSh50jYzoFQTutXHP0BlA3fMfDEByV1hhm2FTZm70rLC
         xLzYbKP23RXuGGsQocbH9GNpYk8NXBKyzFFyy5eixlpF/4ok7gyvZsJfBMgZj1HkcS4g
         WOB8xo5vJ2DItp1OQR38+SthYY2Zrb+bRFv+mqVQfThoRef1ctSgnYetPry+sBd8pYpf
         XC+A==
X-Forwarded-Encrypted: i=1; AKwUvByLOcBCuhHlQ9F3DEyAppIDt4BlMY4sBIxRDjMZqBy5TLFxUB01KXm3exqOuxS9nfBXsOMOKlQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnRkHSobaKX+DbhktNH4ND6eEyHkCXrb6KdmLWsLCnb6sBsjnM
	ecK5HZf0WlZ+imvWGv8e2ryRSBjS7yLb35QlN11iOtHU5In3maTvOIc=
X-Gm-Gg: AYBFou2IhmdzrRnRMarwbQNMywaL/IwV+T+gWyqRAJpGN9QokWepGJSRZLcI4LDepzC
	FbHQ+XzQhEP7ebnZiQSwiDdOD11eL94FcLhVswtnDO1lHRjvfiUkdcqgRCA1Rq4XI83Vg3UUHbf
	fMlGeLcMCQwTWwTxZDeMpu9PsXfg3y2QOyH2xjmg72v8hY7ijM2npuENXScZ4kIVgTdQF13779l
	ksl69TOR+POqin9XrDBoRYMTp1BtZiPvNPdxThBemWT4UAMEAuOQjnk66npHzWGs5Y86plUmJZB
	pzA8uXTczrzuI+GaBfIi74IjsQBec7/17YOXGptaZboe4WUdgKmwhuxDbLz+WnHAPB4HOXf5zra
	eoDl2+/uco2lcyADznePHd0JZFC3uCDkDXxXN6tdbLqHOx3var75yljnoWtqYGMcP4cRMnQgxZG
	uaGOGwT1UO6334b3LO0xVcVomHFARymd09QayzLe/hhPvcwOeLtnvc8g+tNmWEDDBYm72kAoP55
	/TdIzNyT6AyFQ+qM/eBoY7GRcBB3xU/fIC+Pthcmuzz7W66qgYUa9itDKxoOcJDYNatb5smQ3Ft
	mMjzLpAR7jpeiGwNUeOI/VvTw51Z
X-Received: by 2002:a05:6214:8593:10b0:912:517b:40e5 with SMTP id 6a1803df08f44-917c01931a7mr3207616d6.44.1790877465165;
        Thu, 01 Oct 2026 10:57:45 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a9800dsm31853976d6.46.2026.10.01.10.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:57:44 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Shijie Qin <shijie.qin@nxp.com>
Subject: [PATCH v5 1/2] media: amphion: drain message work before releasing core state
Date: Thu,  1 Oct 2026 13:57:36 -0400
Message-ID: <20261001175737.4048254-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001175737.4048254-1-mhun512@gmail.com>
References: <20261001175737.4048254-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vpu_core_unregister() frees core->msg_buffer before cancelling the message
workers, although core->msg_fifo still uses the buffer as its backing
storage. A queued worker can read it after it has been freed.

Drain the core and instance message work first, then release core->vpu
and the FIFO buffer. This follows the ordering in vpu_core_suspend().

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 85cc4a14f8ed..a0c58ec97a42 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -299,22 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
 	core->vpu->put_vpu(core->vpu);
 }
 
+static void vpu_core_cancel_work(struct vpu_core *core);
+
 static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
 {
 	list_del_init(&core->list);
 
-	vpu_core_put_vpu(core);
-	core->vpu = NULL;
-	kfree(core->msg_buffer);
-	core->msg_buffer = NULL;
-
 	if (core->workqueue) {
-		cancel_work_sync(&core->msg_work);
-		cancel_delayed_work_sync(&core->msg_delayed_work);
+		vpu_core_cancel_work(core);
 		destroy_workqueue(core->workqueue);
 		core->workqueue = NULL;
 	}
 
+	vpu_core_put_vpu(core);
+	core->vpu = NULL;
+	kfree(core->msg_buffer);
+	core->msg_buffer = NULL;
+
 	return 0;
 }
 
-- 
2.53.0

