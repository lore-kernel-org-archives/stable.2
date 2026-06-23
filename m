Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB593D47BD;
	Tue, 23 Jun 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215893; cv=none; b=tH6Pi7CbGyXweXkKFSCINTlaNr5rdsD6Ryq+rB/c/Y2IkfWWIeJktpTUrWwNgHCH+Y6gGt+ZgiSy+AzfEYI24gzAbwmV8usDuCBwSpDT0OKv4tsSzGQpT3WFDIXUZtlloeXEvTl+WH4NpSkrRiGelz+g9kTo49tQkWsv+tfKQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215893; c=relaxed/simple;
	bh=lwmTLKLGBmd5rzYhUjXuVqa8X0+dsB4HsqU5oOyOrPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUEX5vrjX01yQ5EOlzoir6MHUWE3KEEffhr+YVvUvSX2DmZo4rRb8aCaOcYQEGaBVcaHOLLu6xdw2dLXOYKPRKF8ySd81lXVvxxlkW6vBD+6H+azy5jrcVDUGjTj4NypjIQpYE0J7yA5PGLjTDxfjUrpVtVnqibua94Q8Dit1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P6OoiXkL; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P6OoiXkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jy
	qaO8kPsSCsSS6QqHxsmEpq9UNz19yAQVVRi9X8TRg=; b=P6OoiXkLr9gihEQiB4
	tUtBNanoJzvJcaXZ0p8MyTjMR94VKYZLHu/xfWkkqHLr4MkweRWwkp9ZkLbE07rL
	jyfCG5SZXhoLoW7XO3iqbqVvSM5A+MLbjPYQnsL26rhkXrnDmRwp4h25TZpfr22T
	W6BTsvZ4ehEcJsrh6Zpa3SBLI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXvxObdDpqHqw_FQ--.64734S2;
	Tue, 23 Jun 2026 19:57:17 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	kees@kernel.org,
	horms@kernel.org,
	bjarni.jonasson@microchip.com,
	lars.povlsen@microchip.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: sparx5: unregister blocking notifier on init failure
Date: Tue, 23 Jun 2026 19:57:14 +0800
Message-Id: <20260623115714.2192074-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvxObdDpqHqw_FQ--.64734S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry3Gr4rZr13GF13AFWxCrg_yoW8XF43pa
	y5uFykCr18Kr45u3Wjkw18AFyDWw17KrWUur1ft3s0ga45KFZ3Ca4UtFyYqr10k3sruasI
	qayDZa48u3yDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zibdbUUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxR1t22o6dJ2TwAAA3E

sparx5_register_notifier_blocks() registers the switchdev blocking
notifier before allocating the ordered workqueue. If the workqueue
allocation fails, the error path unregisters the switchdev and netdevice
notifiers, but leaves the blocking notifier registered.

Add a separate error label for the workqueue allocation failure path and
unregister the switchdev blocking notifier there.

Fixes: d6fce5141929 ("net: sparx5: add switching support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 644458108dd2..dac4dd833127 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -765,11 +765,13 @@ int sparx5_register_notifier_blocks(struct sparx5 *s5)
 	sparx5_owq = alloc_ordered_workqueue("sparx5_order", 0);
 	if (!sparx5_owq) {
 		err = -ENOMEM;
-		goto err_switchdev_blocking_nb;
+		goto err_alloc_workqueue;
 	}
 
 	return 0;
 
+err_alloc_workqueue:
+	unregister_switchdev_blocking_notifier(&s5->switchdev_blocking_nb);
 err_switchdev_blocking_nb:
 	unregister_switchdev_notifier(&s5->switchdev_nb);
 err_switchdev_nb:
-- 
2.25.1

