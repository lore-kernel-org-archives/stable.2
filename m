Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227020;
	b=fxV4TlTMrPl2OaREe8JB2+2/tF85zZHwuHdBgkIgSx9o7X/Jyn1j1fspKDzt6lrQ5dSE
	 MobEJi5jMX/1YcZGQhGmCp2kU2CwhSwW2kLN73tQNOpYIDw+OYLAh77BaMvxCCCAnXP42
	 r0ZlE4SPfoXU7x0vW7c4+4bMC0xwxUmzaKMZwTJDHlXbbsFtGwyFr95RR6xpUzNvbNWNZ
	 Swi9US6K/aET3SLWFwQFw9mGsiA078qusSDo7N5ObTq96fSbJYYZiO9hTv5tmn+9UJRg8
	 j8JwK3BOKe8h5i6voB3MGOMNugUkGQO4yU7GNG4+5Ww5IxwouHDOW5CJ0Uo5Tbvjj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MdOqoOEupQFbfi4QuNxY8pxCO+41UFytiQ7mtp1SJ10=;
	b=5P5MYPfQajDnWFqBvZiBg2F/6uvuSj7uNiCdn4UOip0MQjY7HczaBJOgUTbwG52oUrTP
	 uV/1Njjub57OXv+NVClebsQDxNtYI43mlS2Jg9ogHguyh2tEJ3RvFSD+N9gMRnwFN0ZjG
	 wZrvdLWIwReMbbGEZFJ+pLcwZZ6Qs3BTggV1bGVERqEjztaVlTWtOHxn1+CaQqgQefef3
	 XekfntBTM/mOmpWOH0PWdUvQafrHPn8BTVGvhfjUFX2xOT4yl8hyk84hL5BpNmEkfW3fb
	 kvLoA2FsC8LduGtG70Vu76z8Y+sR9PxQN5V38paJWMKF3X6XKTsYw8qHSMw2ijyn7xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=isslab.korea.ac.kr;
	spf=none smtp.mailfrom=isslab.korea.ac.kr;
	dkim=pass header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=STY0ySgF;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB86082BCF
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74BB86082BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=STY0ySgF
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so256818a12.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 04:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1794227019; x=1794831819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MdOqoOEupQFbfi4QuNxY8pxCO+41UFytiQ7mtp1SJ10=;
        b=STY0ySgFQct71N6fSXFw7gPHNK9fh1uk/HKydCqbkruXIWcuy3S4z/jNdEXBQ4XwfU
         C9aFa47b4YtQtk9chb0ztOYkd4nntbwk2ATEiP33A9H2UR8HKwyg3OSWZfewrhyjS/qB
         QNHHUgkANKW4G+nH+kPJEBG661VnKBnrCLo9oM9MpCsh01oV+V20luewPyAnc/buVSVA
         5GXrWnbP01TX1Z2vxaMlYC6vOY38ICJKs+vELMCLG+G1+PsGj8ru8tVz6ND3gF3f1G9o
         irgKd7nQxwHW8Uqy5uc+ihnMPuQHOS7e/9e9VYBrWiha4meZv/hlmxXlyXiIDBcxVufS
         2JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227019; x=1794831819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MdOqoOEupQFbfi4QuNxY8pxCO+41UFytiQ7mtp1SJ10=;
        b=o/3Pt5Mqan9ACABvcAUbhE8OTb0Nh058mpHCD66dYS5UdGX32FMJ9XoM4ncZ6CSIoD
         DoNLLPDWm9Wr7AMRZ0reGGmh8eCnMSLH/6Am4vgi9gghBUsLJ1zu3mH7zrmZYozx7vSq
         mdY/+QYou8hfwf3yosuoaxAueoE52q+916cdRWgwIB3mDdhUvmba+HwD9hj2cfoSHSU4
         blCGmvY2IpOdyrAuoTzTWwHL7DeH/Ve8o8hLvP6crPCFnOuBmVoF+LJjwPCGw6+dMnpy
         uhqq/elzEw77pOb+DFWcaXBtpO2IJbdtwpW131ki1MBgUuHwikNvivy5WINHqjrvfo1Z
         /Jxg==
X-Forwarded-Encrypted: i=1; AL+hErFKQ4ov7MkOroiQkfLqB/SkjQ8USxCLZrAXStwpOn6vVjuqyyEYY7LXf/djcj37jmMp8s/j5Do=@vger.kernel.org
X-Gm-Message-State: APuU4Z+urD68P+zayJnwHXn7mawhDOu8dl2goJM5S7vBtWHekcq34kkx
	M2QWBBA7VQK1dxI5qhyjaEYkygKhrqG1BerivrKovZcwTE2/o+r5X1sEmqL2K/tZr1zilcJPllg
	OMIv77dA=
X-Gm-Gg: AYBFou0FXISSL66CjQw3D7x21qZ+VyVPPL2mSrygd8ofF8JPT50L43OD7255CWyubl2
	acBJ3u0Hms4gVwfvkYQrqZz+S8W+QDSuHxdMvEVz78WBszT66p3JPr35BBbNrWloZTWIW2wJzU4
	+w9PzEkgH9xqb+AHWCcX+rE4qHAUqA4k5Zbq0U35ncu+PWFaOCxx6aew1OzhJe5SL62zClwPb7D
	ryixTh6p9Pt6BmWA5d0U/GKA38klZDONjqTAiFzue9RXAu4w3J2UBAt51aPL6gU0/726rJmDRyP
	PgLVqDaCk+jpG65NgbxhS+W0Ju2tqzbEI6NRLg4C7K2uxHqYFZJrf3IvXswYIXFB33GyvlAm/l7
	uO6pPzCPcTdHFgQWri/efRqGh6ShTnJU7FQhoBzQonFdwL1QLtlJhSOGE8Y24hiRHzjMOQnp5f3
	OfKMiNQjznsLqr+MnyNpO/ZKd32garrV6b5pbl8osfS6y6KonxtCW69/2W5oZmqduNWU98FD6QM
	ugv+MNVs+QQZ4B44HRAxd1CKbS9fo6aa4t2PGFuCUiICvXDjkyjosGmAWnzuPk7n2Aoh5g6iPgo
	yUCPOZKWX4YAw7rZ8PcZqxGlQz6Jdg/3rWu8civHaNaMqeyz900/mTBLp9zEUmg8BngOKzJtl3Y
	BZ6TLLfzkIhOMEqDizhe2Zw/gMVHS/ZhAwr2upQ==
X-Received: by 2002:a17:90b:2547:b0:3ac:8af9:4a77 with SMTP id 98e67ed59e1d1-3b12d4204e3mr3448890a91.10.1794227018821;
        Mon, 09 Nov 2026 04:23:38 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:3d70:1891:1a66:b169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127912d62sm6836905a91.11.2026.11.09.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:23:38 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org
Cc: oleksandr_tyshchenko@epam.com,
	boris.ostrovsky@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] xen/pvcalls: destroy the per-socket workqueue on release
Date: Mon,  9 Nov 2026 21:23:24 +0900
Message-ID: <20261109122324.30134-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr>
References: <20261109122324.30134-1-yhlee@isslab.korea.ac.kr>
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

pvcalls_new_active_socket() gives every active socket its own ordered
workqueue:

	map->ioworker.wq = alloc_ordered_workqueue("pvcalls_io", 0);

and nothing ever destroys it.  pvcalls_back_release_active() flushes
map->ioworker.register_work and frees map, but the workqueue and its
pool_workqueues stay allocated, so a frontend leaks a workqueue per socket
it connects and releases - a loop a guest can run as long as it likes.

Destroy it after the IRQ is unbound, so no new work can be queued, and
before map is freed.  pvcalls_back_ioworker() takes no locks, in
particular not fedata->socket_lock, which the backend_disconnect() caller
holds here, so draining it from this point is safe; the flush_work() just
above already has the same requirement.

Fixes: 5db4d286a8ef ("xen/pvcalls: implement connect command")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/xen/pvcalls-back.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index dcefa91a40cd05..27aa06289a7b92 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -456,6 +456,7 @@ static int pvcalls_back_release_active(struct xenbus_device *dev,
 	xenbus_unmap_ring_vfree(dev, map->bytes);
 	xenbus_unmap_ring_vfree(dev, (void *)map->ring);
 	unbind_from_irqhandler(map->irq, map);
+	destroy_workqueue(map->ioworker.wq);
 
 	sock_release(map->sock);
 	kfree(map);
-- 
2.43.0

