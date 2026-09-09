Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4758314B6E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976563; cv=none; b=a9chG6juBGd1UbpMda+i/rmJzCZVEDRzUbEBjpo6yCcrHADjymUDqZqdMHAKAvNgNexkYFeFXnuAhVzI9MC9J2spRTtqrBSnrotO+PNyWvoHGvkHbuWA3qewE0j+3fRlp+D1p2/cC07oZNVrKEtf6EUQtPFR/OiVLs/D8XZyb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976563; c=relaxed/simple;
	bh=5AR0Kh49ItNEhSfvtl/MCspOp7lmk+zADaU5+j7+WUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx3a620typQkGeiS8EoynFmDbtfYAt1m+coOh7vXVE9uIdZP9mbC5s0t03WUvqVISaTwL2bZJqwbzCdFSWjB8K0jkC+XTFZsjq7/VdQtX289iFdpSpd+1pt4EaRtD6+nMxES4HbwaczqHV61Rr4S2/2qsNmWXkb8DyCZ2BZGwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq9B6kfu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq9B6kfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70E01F000FF;
	Wed,  9 Sep 2026 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976561;
	bh=1nXtm3Gd/10egWibidkJFnTj2vhAMX7hIFu2Bgp9kOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nq9B6kfu9w+J7Ej7V7OxLF9+3I5gE9Qqorh/v0P/VI6tBtU+4/oPn5YAM58NUG9Ut
	 TAhvijUG7cTxq9upypMRQVYetKVk3a1zosOcJwLt1WOvnuZLPbr4iq7T+RLR8gapvQ
	 C3ZsOYS9ud4tTylzWXrSJoCTDMlY42fsqAdVpZ+kod0pel+pNzJr6BEaQeHA4cVvdI
	 PSJEuLR+/f5VNue3R8T4hGEAmwjBSCP1LFtNRLBjTM7bskx0cB0ULj4MNYbj9V/+yY
	 YzLU+EWH9jiBjTEV9ZjrAdkv9KKvRfComk/VVBzZ1sJP7Oq3uK/Rz9Iij7GbQuocIW
	 PEp4QeS8Q+WDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed,  9 Sep 2026 13:55:56 -0400
Message-ID: <20260909175559.3436094-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090334-visor-renewed-f29f@gregkh>
References: <2026090334-visor-renewed-f29f@gregkh>
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
index 3e131788a4a3c..172b05b7f594b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2341,7 +2341,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2360,7 +2360,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2408,7 +2408,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -2421,8 +2421,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -2430,7 +2430,7 @@ static struct platform_driver ravb_driver = {
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

