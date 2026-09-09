Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099E36A340
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974268; cv=none; b=Jw6waDNHhL848w7W5urvfk6HJw+djiOck8n5odu6/YPTgQJai3OAzMa7STVzkYkpKl8MV9rZwCA3Ku85pIb58lDPNbD2/ZuJuYxv/kFpHrgSq5v1UcPbH9SdjsGQfrOoRQ9vJ76c6qBYTwjnp/WYXzdpbZKFLNJIaL0105OtkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974268; c=relaxed/simple;
	bh=TWUC5CZnsK63GKGvFl3JvxBF7iT+Z9dcYdeejZtjw2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHqhHv2Tpf1aZbvHPBzVMB5TUPBpHpTKF3aYA18l1wNJurEukpCS9HFEhdaM4qk5l1n9Mtfd4o25rwT6Cf/3E9J5rKYGSlzo1Lb2VgRJ2si+SQBWhCB6Zc65u+1Qi/yyXxF20mYj9zzZUv2AURAa6dh2Dlr7AzyQkQDeEf+Gzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyGLH8cY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyGLH8cY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E81F00898;
	Wed,  9 Sep 2026 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788974266;
	bh=uuemQNwaWriJRhNsuB/w7kKIm/UYyp3H3dOFV5TxvPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NyGLH8cYAGfnPayvSiG/8D2HM8JeRP7k8SIGy9Zbw9mtBRvrt6oXt/USdyFb6COLQ
	 E8Okt/lznEjVeWCgRw2/vcsf4cgFGrpGI9Uy0+gQW+7xgMhopr9KPuWXKj+pJJ0QUX
	 HOsB9CoQ4QDUCa/1zPWeggGu3br6lSeol1USyOY2lMmgIW7aWGHq6F6TPXvEQxt5VG
	 Pl+pwjqs3D6abITweSBCon2FY5cHe4Zqs4Jt3t2H3Cnezzn2S4K6rHbGhsavcDcKUx
	 6OVlt6pqOEDQP0uUtn/KygNUFqLubPskwSXWev+6X7QY+4xmB1eHboA2+b9LBJsbEx
	 8CpCuKNdaaE7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/7] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed,  9 Sep 2026 13:17:38 -0400
Message-ID: <20260909171743.3248398-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909171743.3248398-1-sashal@kernel.org>
References: <2026090333-magnolia-munchkin-24b0@gregkh>
 <20260909171743.3248398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 6ccc22a5afcbac46d55866d72eaba22f43491c00 ]

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 1cb9663789c5 ("net: ravb: serialize PTP clock teardown")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index bc893fd6eb023..13095421f1e24 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -3012,7 +3012,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3034,7 +3034,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3093,7 +3093,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -3106,8 +3106,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -3115,7 +3115,7 @@ static struct platform_driver ravb_driver = {
 	.remove		= ravb_remove,
 	.driver = {
 		.name	= "ravb",
-		.pm	= &ravb_dev_pm_ops,
+		.pm	= pm_ptr(&ravb_dev_pm_ops),
 		.of_match_table = ravb_match_table,
 	},
 };
-- 
2.53.0

