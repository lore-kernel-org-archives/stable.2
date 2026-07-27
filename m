Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B2417D77
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159090; cv=none; b=T/YkcUrgZkH1Sl9I16Sv3LTj/9DbTx74MExienV7di3tA7Kh08J9Y4Hu/v1NqxTshSSHWDsovkIFExItnrlFQJu0hcDuPckY9ihYidOjIrkDrbnjN/IAJd9LNA3FCbBIeUCK7WDBjyh19DJ1H/2tjU6xThFFNE+qx6jIRqtkYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159090; c=relaxed/simple;
	bh=xtUlXK5RSSnL24G54zdHt5QwYG1bY/JKUzw5aKqCNgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX382+ly6hFvj/SP2bsPiEoETmDdXiYQhOI5J59OrMfFoonjLdwLvgT7blQc+UQO5yZRZFKdRdG3Rwm8Z/AnIXxJsL/WXuCIZ0bbCLM+/xOEVYfmhuD2Lk+6zAG5X6US0wgfiHbQIyAGzmoTQKVNe4+AAQ94YQvIwopcGujs+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFepZGkn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFepZGkn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB881F00A3D;
	Mon, 27 Jul 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785159088;
	bh=x1fxnM3aBbCPWSvwLlBVOaznX9Ap1MZnkyN3MS/P0s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bFepZGknVZ+Do4+iJDHJLt4HDBeZ51KTZ+i5CGIdRkVE7MRYx/G7ZjrUw7cD4tv9J
	 DcF5wKTvhsFblC++iNCcGoXQG4xbmzEVcKwsgUOXWwCsIuVLoQbgkShDMtIy2tu2kZ
	 9eMV7cQHxpBNdO9wpavuDPuwujhbHASnc9ewgHjFQzwkT2aI3NsYl5JS0MgVrkghUb
	 evubFWScxrAkeQoaiadfKzokLIlKThWrUGy35gQDDhouqgoEYttZ67sylEjxOSLP6h
	 Dx/P57+1J1JTKdIJMqhXz4K0EdMUG7s0X/xnofQnQyXZtkepy2018TvXNj7Q5AwQ63
	 p4bIF/1a0u2ag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] can: bcm: registration process optimization in bcm_module_init()
Date: Mon, 27 Jul 2026 09:31:25 -0400
Message-ID: <20260727133126.537544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072026-herbs-reliable-9eca@gregkh>
References: <2026072026-herbs-reliable-9eca@gregkh>
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
index 317cd4c415ba28..361e384720cd19 100644
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

