Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2741930C
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159571; cv=none; b=ZoKLF5v8bhwEcDfdTdSW5tuOHvZk/kVcPons9eo4u7yvK9g7U+/mpaKHu1ipCxGl+AWoaMWcwDt0Fjx46PwuCUXy/aedVUWqMEswWDxZRmqqBChlmVN1SCOtdXop2PE632dXj9MWE/M9bH0O/Q6EuYAdzQBMxftvf1Vfa+gU4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159571; c=relaxed/simple;
	bh=ICE+y5LbhhUTte56qMb+Xl9yN7qiUpNeu1BIZG9lyFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XF0xfS/17RLzme0fwqFFMyUexk94cxhS8Cn1RXkKbGbjz9rd0NDVEla42ZqYy1/CakXQNeTE5/jZytrKCy46xYmO27fnxZzEKD/FIV+rlqpNhyGT7lFEvFKOVKPR1hidu7Nn7m6aQ2FzsHOew0WWdmNnuvVeR33/eubYFfJ2UxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDy3felx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDy3felx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3F11F00A3A;
	Mon, 27 Jul 2026 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159570;
	bh=+qaIAjLMrCbycL2Ty/FnBWxMWCGfg/kNcYjpJqqFf40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDy3felxfavsCe7tINNmSwb/bEYffk+iKsw514z2wc5o+6PkU4I5tCrKDxV/vQxYr
	 zv+Pa3jgvnCaiYBhv9FoWUqa9G8R9pAaUJZlwztUWkyRCllR3lLVZwJpi+0GSkXn5j
	 LNaKkuxPvwPe9alSDK8oUrZQ/nKx+FtDIeUhV2WLIRZhwdOKWfDy0tkVzjMZcr9IVn
	 nc0m6RYlgzc17r4tPkTZNr/Ph1KqwY69+3zzFbnTqFbdboHqcTmbKUCQorZk+k6ta+
	 Zo5mxGZeHeU88F0I10+DLifUzlR7c9+ddRxYLcQX7x/no7UKOSmuX2mOa5yysSzzYN
	 xj0IP5X5aJyjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] can: bcm: registration process optimization in bcm_module_init()
Date: Mon, 27 Jul 2026 09:39:27 -0400
Message-ID: <20260727133928.582256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072027-showroom-maggot-c452@gregkh>
References: <2026072027-showroom-maggot-c452@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ Upstream commit edd1a7e42f1d2d09c5f79ecef05ae19dc669bf34 ]

Now, register_netdevice_notifier() and register_pernet_subsys() are both
after can_proto_register(). It can create CAN_BCM socket and process socket
once can_proto_register() successfully, so it is possible missing notifier
event or proc node creation because notifier or bcm proc directory is not
registered or created yet. Although this is a low probability scenario, it
is not impossible.

Move register_pernet_subsys() and register_netdevice_notifier() to the
front of can_proto_register(). In addition, register_pernet_subsys() and
register_netdevice_notifier() may fail, check their results are necessary.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Link: https://lore.kernel.org/all/823cff0ebec33fa9389eeaf8b8ded3217c32cb38.1663206163.git.william.xuanziyang@huawei.com
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: 68973f9db761 ("can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/bcm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 06ee3bfe87c99d..334a5105a4532c 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1832,15 +1832,27 @@ static int __init bcm_module_init(void)
 
 	pr_info("can: broadcast manager protocol\n");
 
+	err = register_pernet_subsys(&canbcm_pernet_ops);
+	if (err)
+		return err;
+
+	err = register_netdevice_notifier(&canbcm_notifier);
+	if (err)
+		goto register_notifier_failed;
+
 	err = can_proto_register(&bcm_can_proto);
 	if (err < 0) {
 		printk(KERN_ERR "can: registration of bcm protocol failed\n");
-		return err;
+		goto register_proto_failed;
 	}
 
-	register_pernet_subsys(&canbcm_pernet_ops);
-	register_netdevice_notifier(&canbcm_notifier);
 	return 0;
+
+register_proto_failed:
+	unregister_netdevice_notifier(&canbcm_notifier);
+register_notifier_failed:
+	unregister_pernet_subsys(&canbcm_pernet_ops);
+	return err;
 }
 
 static void __exit bcm_module_exit(void)
-- 
2.53.0

