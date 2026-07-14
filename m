Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81E3EC2F6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013716; cv=none; b=BYdpYPXtZRshKIm7VzOyUnVQcN92WA8LIZc7cXDD7K4Bpb0z8ySzF/HGIf52+nWkcK95gU0baCw4DpmRjJsEKNmk7yQ4/n5SwYPUquSI4l8ZjQRD5Kxpoy993X/jNUFIHL4OGkECXGrGwYD5HbeCyWwmtxOfrMG6Se+nUaQK8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013716; c=relaxed/simple;
	bh=VV6RH/yKbbXGqbCZVlFLWMvC2IkSZjVrbZxP+GH89A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlrnILbdO57pH5KPf2qwe8DDugfwu18Jqb6UEfOFPXTGmwC8qE7F2pVYPlw16uk1OivsxWdk6RCap95wRpuE0+DRQBrFLEgBx38kh84EHr9E6bDx9MlOtr78WCy2EIBo0QbPYcNiCHkEMlYywMGnIRs6asBcBZYgCyIvcGLWVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeDbW3bZ; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeDbW3bZ"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-38109499830so2345215a91.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784013715; x=1784618515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=GeDbW3bZK+jZaUhg8w1w6lia/JrRhBKRBaedZHrRA4y4oE3+GQmTDnvGnGyqI47Z/H
         HGMtyIWPqJvjjCUpLSJ8yS2sq9JaoxiBVHyg8hhBY3HRabDaqNM3rNFwD/xGK+3rsNsg
         nEKPB24o/qg8awGguUkDr0PyTOGUI2JdhOb+WMNQgu6lgF0s6mKFEWKF+UyqLk3e7fyM
         AlggOa3P1phIsX/ey+yy7cHRzW9r2R31RlMl00SOlBdFCpakXtSkSretNk5Piif6CWHs
         LtZUTMKCBooFhV8zDocNHYNLG3Um4lEJL+94zXurvQ9APigs2BQEQ0PKl+LvU8LWm3wr
         qYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013715; x=1784618515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UL4JsWWFy5+1VcD51BCzcQnL+AOhOLYxnY1WLoSce4c=;
        b=SueSoEJYjdaYVsw/JnFLP+f9j6qsslz6yfKMrGIrMJ4eJPub1w55YSCAi8+FsraFDJ
         mF6lvVwaebbYjW35vJ9OtQY8AuoA9ur/r3oliKiZS2ocY0r9nxwIdzPfL6g624+somH3
         yUimQ5Fd+OYDX6j+icjeG+y/01Yw3oWmzZydN7GSOqup50vXgilvmGL2uveJ3u6t8uzZ
         /mArdna74qEbb9eIE3H5g2IWtw7ajTdQM/NedoCm+6fbOSgrnwjZM4Xo6+J2urmGh+PG
         8vtGBcPMYkX9vNNf28rnk4LkO4U5Ub8nifkTShvEDeElg11SqDK95VDq0xP+BCI5cd5K
         QXtQ==
X-Gm-Message-State: AOJu0YymH6YQ7BDrKvuu0jsHdnF+zSp17VvM0Nb5JkAclFdeLyOMF4Sm
	e0itg4ECh5XXxJ5+ha1KKIAt/4AssHFHf4b2n/UBzHze6rATCXGzPD4D
X-Gm-Gg: AfdE7cno07ErIIMl1nkV4zd0mt6BN8H0CyzZyNmSQEGUJQ0TxGbeXm/qsL8xDaHSv+w
	2KgJ0cibUXJ3ggZZLxawiw9c92wjn3G1Sp4WfGFBlhy2zs6Am9dKdGgsYl7qNe8WIBdpv1yMKgA
	dF58F40+xmZFjG6iTTf7/RyU9CRcJjPAPGB5V5ZRiQQVVMXcMd/HKQl6zf6jAoKNlOISbWgrxP5
	sbNnp5HWSQWD3BdHc7hEw7earrGetW5gpzlEMD9b3Cd510MQYVOAtk0/925eEVCW7ZVyS4kQpSK
	f+gm/6dW80PPrpRuFiDXYdkJUfuTF1Syb3EGAELVerf6prLMZh+rK56bX9ekFdTBhOQIloIwBeO
	sU4XVBlYAzyh+JgxREKdTwK2I1xhBMTbWhGzSsC3EGI0vOIxPhRmU2/tPng8j8VQxfQfdm8yWzD
	++SQlMYfSTKMR9LPpND9mIBT9BvXpHoTFCoyfWG5/IWHoQ
X-Received: by 2002:a05:6a21:9d48:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3c1108c2d4fmr12576651637.36.1784013714528;
        Tue, 14 Jul 2026 00:21:54 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([2409:8a55:94d0:4771:cc5f:41a5:d797:4728])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm9365742a12.19.2026.07.14.00.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:21:53 -0700 (PDT)
From: Shihuang Liu <shlomojune6@gmail.com>
To: shlomojune6@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] amt: fix use-after-free in AMT delayed works
Date: Tue, 14 Jul 2026 15:21:42 +0800
Message-ID: <20260714072142.128870-1-shlomojune6@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an AMT device is removed, pending delayed works can still access
the freed amt_dev structure, which may result in kernel crashes or
memory corruption.

amt_dev_stop() cancels req_wq and discovery_wq with
cancel_delayed_work_sync(), but these works can be scheduled again
from event_wq after the cancellation. This allows delayed works to
access the freed amt_dev structure after the netdev has been released.

The following is a simple race scenario:

CPU0                         CPU1

amt_dev_stop()
cancel_delayed_work_sync()
                             amt_event_work()
                             mod_delayed_work(req_wq)
free netdev
                             req_wq accesses freed amt_dev

Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
discovery_wq from being queued again and wait for running work items
to complete.

The delayed works are disabled after initialization in
amt_newlink() and enabled only when the device is successfully opened.
This keeps the delayed work lifecycle synchronized with the lifetime
of the AMT device.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
---
 drivers/net/amt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 951dd10e192b..7eb871b9b7e1 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2995,9 +2995,15 @@ static int amt_dev_open(struct net_device *dev)
 	amt->event_idx = 0;
 	amt->nr_events = 0;
 
+	enable_delayed_work(&amt->discovery_wq);
+	enable_delayed_work(&amt->req_wq);
+
 	err = amt_socket_create(amt);
-	if (err)
+	if (err) {
+		disable_delayed_work(&amt->req_wq);
+		disable_delayed_work(&amt->discovery_wq);
 		return err;
+	}
 
 	amt->req_cnt = 0;
 	amt->remote_ip = 0;
@@ -3023,8 +3029,8 @@ static int amt_dev_stop(struct net_device *dev)
 	struct sock *sk;
 	int i;
 
-	cancel_delayed_work_sync(&amt->req_wq);
-	cancel_delayed_work_sync(&amt->discovery_wq);
+	disable_delayed_work_sync(&amt->req_wq);
+	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
 	/* shutdown */
@@ -3278,6 +3284,8 @@ static int amt_newlink(struct net_device *dev,
 	INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
 	INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
 	INIT_WORK(&amt->event_wq, amt_event_work);
+	disable_delayed_work(&amt->req_wq);
+	disable_delayed_work(&amt->discovery_wq);
 	INIT_LIST_HEAD(&amt->tunnel_list);
 	return 0;
 err:
-- 
2.43.0

