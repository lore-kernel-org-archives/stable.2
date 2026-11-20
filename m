Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196132;
	b=yeV/jYgzADPQSwmhaBzlvgintGl+2fn07cGeeeQVsDZmprO65wB1AU7sTWHr7V+iJavL
	 EbQ2ILWpPhEvbkuk/1DiczOMWx9KtaIHhHcibTbQ60No9DI2t1FHHy8EpNbcD0lZ99AXn
	 SbwrHVT7EpR28tCyCF5Dpv4EUfRI5ezIEdMRdryjp/WLqpQJ2oGrddkMZPuB/RxqTTfhp
	 /5rUPrmEBesUEhwYLTMVzePRc7sKLIJvhTH6Lni0nMS1dcdJ7c0PzUp7siMl1BYDAkuPJ
	 HWrp0Xs0NjIYsZd1oBtVgJHPr1iPuAtAb1cJBUacJ3QtbO2R+/+bXpg2u47EGK5kKwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196132;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=uLVpSuyKWVNg7AnaQCyELsWUGJ9GnFCAO+1Zv1LKfEM=;
	b=CG0X8eXvyeiSq9BmwX6gjy1Crhdcy2g35pQCD8Y4ywDJ5Xjp3G1w81Y+ENgaD89au0ZL
	 lEBuVEr4IBGqbiTR0wFexQOHkAtg7MqsHYfntpgMcb/VghasYb2EwYT6SY23rCUg1IafH
	 ySp1NVNgT3UmDto2GoCKEWEdQza82VkMD2qehoE0IEfbgMwQmgsqTULc/376vy9zdksBG
	 bbj7v530hpUOzVmCdZzDZljPdkSrMWrHWY/mtQB9HZmeBVB3N5EKYarMp4e7Oms37ettA
	 4o4saBP280lUTEB12766Ng1lgsQchnnKMsJGErCLQfZojgFjoCFsvE6b8teqwDge6Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=YVgDLhVL;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36660A260B;
	Fri, 20 Nov 2026 17:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A36660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=YVgDLhVL
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5573c0abe;
	Sat, 21 Nov 2026 01:35:28 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Thorsten Scherer <t.scherer@eckelmann.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] siox: Fix potential polling thread leak on master unregister
Date: Sat, 21 Nov 2026 01:35:25 +0800
Message-ID: <20261120173527.3924010-1-liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1fa070ce403a1kunmcafc11f0238b98
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSh4aVkpKGB5MGk8fTR0dH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=YVgDLhVLvOKf5BMK54x7pJQP/bpA2hZ0SYIstn2b5RKVJ8Z0b2eS004B89ysJyUWYslXZRKAND/0DJhEgK+7se/AcIER5iFXOOfTjEL0SBteDH+SS+ez0ZyJyKPC+rpOqaotvxKq8gpxNak9I0f3Hmhu2vzZHuqw7sGBxp1XO0g=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=uLVpSuyKWVNg7AnaQCyELsWUGJ9GnFCAO+1Zv1LKfEM=;
	h=date:mime-version:subject:message-id:from;

siox_master_unregister() stops transfers but leaves the polling thread
running. The thread retains its reference to the master and prevents
the master from being released.

Stop the thread after dropping the master lock, which the thread also
takes, and before dropping the registration reference.

This issue was found by our static analysis tool under development.

Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/siox/siox-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 3e8f3b6a4555..8db233ce7683 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -791,6 +791,7 @@ void siox_master_unregister(struct siox_master *smaster)
 
 	siox_master_unlock(smaster);
 
+	kthread_stop(smaster->poll_thread);
 	put_device(&smaster->dev);
 }
 EXPORT_SYMBOL_GPL(siox_master_unregister);

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
