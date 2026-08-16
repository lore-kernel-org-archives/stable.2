Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141F22C11DF
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 04:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786855528; cv=none; b=uigkSruw+9DeWy9ch5DOtS5DCppYcqGQ0z46IIp2Nz2fvlYQCmJfUB6/FCzit72TE0b/b/LjBdef1yMV57AKORogNz9gze+wvJIHE48xnSOulZ2wHSvYrEn2aAtxGYO8PzXyIm7ejB6JPhWadQRk21eMGdzb2zDhN5aPfTWITXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786855528; c=relaxed/simple;
	bh=VPZwRSomxevHO7ok/WVEp7eMxLHx3jbGcDllWYjpIk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KafSCPnbluSJ5x8xUy6gLPSmmmSz6ONZgTI6Y7m6DQi4Q1kCt4j51nysYRe7gNlbh5ZxGJxEWT5sEhcG8RkjOpNnrUL8mpyo8gp0a7ij6hrDOhFJmgZHWWWgS67dt3Cu5SnBCyosT/ZG774ixV4ztI384hdEc//PpsQCpXDgF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRSqVadc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRSqVadc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90a80860d35so20365646d6.2
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 21:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786855525; x=1787460325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aXQqM4Uz+B7ErOlECxSpCZ++Y8mo3D64bY4QdYcgNwo=;
        b=qRSqVadcpAn7biNDanCxu8O7iykcNgRAO46rIZbwxWbcqrfJi1z8kuY6jf8fVar0Z/
         KnIGj4FQ4P7SNjpQyZ0XbVMhhFW0mGzYBxWTeh3fUNjhRulGYflWZZ3Dqm3FkCB7Po8W
         i27/poacJt16rvPraNr7ytlrZNtJHVilbk88ln1RlWSVJjeqxdAVxaowgmPJDZT9tk8g
         6QwdeKcEGTl74Jod0yHiWcHjnfhXfJY1uxxpJKrtrI+sticqhZgGGdpUMmaxVzsSd9Y9
         xofZMHB0+NTx/HapRBbOHXQpaaQyG00r7UVLNLKcR5KWqvOL/4RJsJeM7pUbU2Ad6WzZ
         WUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786855525; x=1787460325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aXQqM4Uz+B7ErOlECxSpCZ++Y8mo3D64bY4QdYcgNwo=;
        b=eqdSlDrxZ8lndYp5Dbzk9YrZvP4TtK/nJM1AvP5ptIKhs9ts+P6q9jH7pKzNFT9Jc4
         BIdokO1lgWuYs4T3LBcYA//BTip6Fh+4+h1x6wyWbjlL5bQ2rQYJJF4n9PMDUeaWqP3e
         wCILpFATyOo7CLIqxHJ+rvq/JBuzZGW+8ACBYoQFJJ5LSZmRVm5kDJOGlM8tyBxZ2fcT
         xX5SLRCORYS3ylAHxJ1Xh28NDwY4nbaoGL5hsHbiitOrSCYqje3SU6fd5696xZI85KgH
         FpRuCpVXiQa3f83CvyzituJRn3MwO1oD7QGKAReFjMqg1iPk09XwO+/c0XQW8rKoZpLK
         PotQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqmmph3AL8vDZ6MHyP9VjQMbALWd8QOQTQtsYv/zR1EwjakW6YhqmEDjT/Duclo6YK5g2A5niI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTBN88KYz3KBQXqkBS4cmX2dJRfKnTQ4oNHRJkBQ3Qv55DF0F
	KghRn3eUGusi/zO+B+Ejo8SkiQQvNbSZRxZXef/rdmPHcBLnbThAWq9T
X-Gm-Gg: AR+sD10R9gc8VihIDgBM6xZ//Z1F7Tf8W5vbWqMq9AK+saBZCWjTakFOBjEQlT4v8+S
	59KtxDNZe/5A0Ce0ClJEYQzHhVBojOexBHCJ+s/G/hM0/sSSySeuV7ajHdnUnoWhtkO2XlbCbBT
	XScRJwUB8XXNWdbLWz8pYmdH5aiqbMnKYFcXoTcLXP4Le8x+TOO7MAIeYH823Tj0Ew4WskZvrgf
	UG2gg+Z+iSdtXuEYndQP7ACmtSS28iPMdXGsQb5GiSe+0ABDLVfApxxNiwv/hWvkmrLrE59ovoC
	2X1pGZL83jAM8ZPf3oUbRoYd0MZqkoMF2EiZvWEkQAVR+DLwxj10XkUYAf7imH4OYjwhVxVHLtm
	YGC5UxJ4iEPZmVEjMZD2twb6x+8diaknobedwTYGmISFPLPak5wB1b5vi29IiqVIMxrvb+XQvhA
	FK2NJcW+0conwwfR7ZmhWpoQt62nyavA8S+UUgnyBaAslh+kw+WG5DX3hMqGNhFxzDeZh6OdgPh
	oblMmeySAeOvMBM7w==
X-Received: by 2002:a05:620a:a293:b0:934:970a:beb2 with SMTP id af79cd13be357-936d22ce4d1mr1589429185a.26.1786855524958;
        Sat, 15 Aug 2026 21:45:24 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce1ea6cfsm687105385a.27.2026.08.15.21.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 21:45:24 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: yishaih@nvidia.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] IB/mlx4: Fix use-after-free on pkey sysfs registration failure
Date: Sun, 16 Aug 2026 00:45:10 -0400
Message-ID: <20260816044510.3848996-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_pkey_tree() ignores errors from register_one_pkey_tree() and
continues registering the remaining slaves. The per-slave error path has
already released the pkey parent kobjects, but their pointers remain
stored in the device. A later device cleanup therefore passes the stale
pointers to kobject_put(), causing a use-after-free.

Clear the parent pointers after releasing a failed slave tree and skip
unregistered trees during device cleanup. This preserves the existing
best-effort registration behavior while preventing a second cleanup of
the failed tree.

Fixes: c1e7e466120b ("IB/mlx4: Add iov directory in sysfs under the ib device")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/infiniband/hw/mlx4/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index e688ad66a895..5438224bf325 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -751,11 +751,13 @@ static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
 		kobject_put(p);
 	}
 	kobject_put(dev->dev_ports_parent[slave]);
+	dev->dev_ports_parent[slave] = NULL;
 
 err_ports:
 	kobject_put(dev->pkeys.device_parent[slave]);
 	/* extra put for the device_parent create_and_add */
 	kobject_put(dev->pkeys.device_parent[slave]);
+	dev->pkeys.device_parent[slave] = NULL;
 
 fail_dev:
 	kobject_put(dev->iov_parent);
@@ -785,6 +787,8 @@ static void unregister_pkey_tree(struct mlx4_ib_dev *device)
 		return;
 
 	for (slave = device->dev->persist->num_vfs; slave >= 0; --slave) {
+		if (!device->pkeys.device_parent[slave])
+			continue;
 		list_for_each_entry_safe(p, t,
 					 &device->pkeys.pkey_port_list[slave],
 					 entry) {
-- 
2.43.0

