Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E836655C
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363834; cv=none; b=MLWkwyD9j6JE4x1osBHTLd2/PacyDKVsX4PEDkcJKHOKBz8xdbxGyuKjlnqq+j9bapIr6vjWhVL0lLgGheuqvbfsAx/t919mslfeEgfUe7D+HDlr19W3ZVK/aZqZ7uMsAoTmKDsepy0KshRQcuHnyy/GLKbms81NpGQY8r9d6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363834; c=relaxed/simple;
	bh=cx+Qxo7ICqpNTesdr02Y5BPfFrvbALtUCzOZqGDYf10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ove1EI95e9T4CKQsumouDO3NE7dMrOGA1VEQBexup7nqUCRDvahm+mKVnVxhZeH/njJrgKw0J6sgIJl5X6tyZjHaXKBzOcRty1dChBTueofIwip/FdP3EbYu5q0GEtZlIqiaGlPIUbdB0VpjKRwN/mdN22ugMN6/FuTH3/Yqzh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J427zTKm; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J427zTKm"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c57d36d37so3366685a.3
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363830; x=1790968630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVZBghBD2hthXf6SLqJUAS1zp/fiQW6QZMeVDkbpjJg=;
        b=J427zTKmGY3rvXqo3cjJ0HLN+jG9rtNpwcggo1EJQ6hmkMjFumoeXAXSyYrwbpszWU
         cfREcNyarQC4KVuU+17M0t+51ZPr63KxY/mjL0BGvwSu0prlL8TPQnIMM4JvZ3e8vB5h
         aJ0RDd4hXRqK8L9aHlIfZJDDx7x7Z7XbikYaixy5eE8pJ5ShA6m5U/luz1RLXI2Jhxmr
         Bk/Q4FT8//lSBiverkS81uNxhrg2h6SSQiW48LROdf7t0C1X7Xwp6lqg3b342nMngptd
         +mF47j2Bg6lXG748k7hcXN3Nq/rbbMdI/pq1P/Cy4hmNCqDI0eEeWYYSqbczuGr5hvxb
         KCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363830; x=1790968630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AVZBghBD2hthXf6SLqJUAS1zp/fiQW6QZMeVDkbpjJg=;
        b=HK2apPjktlnevTAQXZZATojoagrrsUpEOX2WwZPlFSWVXuTJzKCT/LQYaVZk/Xo1CR
         ScbCTAAYqO3N7rXYqTJrBrOaiwHTAdLFpFAzm9tyIPNSQ/Zmmnoi8jqdwBZxOjUNGiC9
         ucsZW9FRHdxdG8lw0yUzKNq4bdiZvhG4X05hGdl7aDpBYwxMUdwqv1EPqx48y6jRcqyN
         /bvrvGTsAcY5gfWPi6KKNeHj1+fPMbPeZK3zHdcON2dseNL3PG4QDAGsrKSkKaOrMXQV
         Up8x0AIggluPhZR1wL5DTav3vTp3bkqguh0xkFKTX6adAe2gfUriuqQQL50a+Y6ukbos
         GDZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzz2aSZzjWFbWhKWKtuvo9g5UcfkAhEkHzOkg9UcgfEgPDx6BAz/LflIwtAqHWx/yuC17iTBA=@vger.kernel.org
X-Gm-Message-State: AFuF++nAhMiNdoF6a5a5lLJxL2GdL7KVnsrbVjWm5BVZlJsuRfDobBpK
	fknUmES+VNWNuwRsje1wxpGc1oKMUyYD7Hn+UnDtkvdPljAOqz9zHxoQ/rCuuOAL/A==
X-Gm-Gg: AYBFou3EmyS11Fie11wJ2wje6L6G52Wfl0O64bUiCfP0wIghyK9q4nPW8pfCyVYZfCC
	M+/mtP9HRMxIPxz37PBLcuV/E63PySq9SLq3XxYSSPW19Fx/vMDsoTStajdd8rv+KPfoWLKp0Bp
	LCq6sMyrcmViHbzXdFE9sbO/3iP6XJjNWBvvKS3hmWoGp6uMSpF4BTLTywaVK6Yu9ZsOTxlYz8J
	lKEUl9dUYYdHCpZAEU8lOi2iB6NdQMPoWhhk4XNjrAsKYBNAL3cpVyxWI5SYOi3yX62fL+SmPuy
	C/himz7vqWYQN6XM8W1PQULzEcakJvT4B20Nxy5xCsz567q4Z0boVgOOsGwKt5Q/HkBRvAw6A6J
	NZfKmOsFJU0g30FwFbWaqa1Hc6lRy22et2Vx5FjVVwXnaSvfvkutU1OIe/GsO+01+PRr945zBnF
	cty96h2ZqoiD9HY2MHID8kUU0+wctKL5rbp9Lxh0RUdGowNvUPkd0KSbSFG4K8dNtbl+q/Pi7NH
	sVemOd3IeTUo5vVSwlmxNThuxwKrb3zLcMfyfG1K5zXadynNqSDPUsycjxMc/Zv1SJM2LCWmjh5
	rzJgkipwoVwh4Lr/K/wsh/3EMgr0
X-Received: by 2002:a05:620a:a7a0:10b0:93c:56a8:a0a1 with SMTP id af79cd13be357-93c56a8a319mr54053485a.58.1790363830310;
        Fri, 25 Sep 2026 12:17:10 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e09ce4sm23521776d6.28.2026.09.25.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:17:09 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v4 1/2] media: amphion: drain message work before releasing core state
Date: Fri, 25 Sep 2026 15:17:05 -0400
Message-ID: <20260925191706.3144437-2-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925191706.3144437-1-mhun512@gmail.com>
References: <20260925191706.3144437-1-mhun512@gmail.com>
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

