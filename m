Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602877;
	b=S5vzE7HI1SIZEXBidVbisiumhVab311QJQc0Db4fI0NkiUzq2lXzW3Z4iF4iolhLi88S
	 BY36wiQM2oAJ42Gj80tObA4GRvgGfWsRoGY07+F8+gGeQEobSioZizSyRuPNy5VdYEuh9
	 uHwhqJxrMmRttNLCy4bCUshHr1BYEOp30I4o8a77b29OKEza54rE5PE+OUHlvky9sC84d
	 3+tVJ4kVzLukBlfiPjbGJscpey1NfzoQOTFukKws5kgs7tvYNVMQvB+rDtydPbVfiAVOy
	 aOl15jNrRGUjx419UaYW/e3wd5j0QzHCM5SIDWzEGa5RrT5pbAEbXJeTtyYSReENnoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602877;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y2F1uftM4opemuLNm5Zyt7LNYiG48YhyBNgkU+4i9A4=;
	b=2zkYjQYKllHpUporGVRzwdf8fHDG7Loo/zc8TguP6R7Xges3C6j+ZfWWAoJoEAveEGib
	 aUppcp7+uP8RQmX+pt+VZFsFPuuEvetw+Mg04il6g9oJQSJKaOjEfC3iM1WN0H9/zbgbZ
	 /OhCfAlmJXu4xh4o6yCevz3vgttuwZZxcJV4ASXt2ruZdwp0YWsSd7NngVXPBmRkaFuh7
	 9fiQSp2vJv8zsa3jeKXJ6hPdg5cg28F2RCTk1hmw6LpE8bNspmJ9usUFybOD9EJO8RMJc
	 +offePAYVCo3O0fjlMtas6c402Zg0whpZLHgXQ9DIJb11EmbnuCutIKhLCa2e+FO2HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KiWqgiOl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0F60A2613
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KiWqgiOl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6E21F0093E;
	Wed, 25 Nov 2026 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602876;
	bh=y2F1uftM4opemuLNm5Zyt7LNYiG48YhyBNgkU+4i9A4=;
	h=Subject:To:Cc:From:Date;
	b=KiWqgiOln2XaiHdSusfPigj0Nja4/2BosNswqNApNT030uX/3Ww10ciQ0DY5l1uCR
	 RKY+oKBgTQVtVuYudHgi1YLSHBx/p1ycFske6nfnN4szs4zC1R2HRfIaNSf4zFMrdE
	 VNaXEpc4OW1HYTobyUJBMSRkMhf3cXQSNZU/dzAA=
Subject: FAILED: patch "[PATCH] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init" failed to apply to 6.18-stable tree
To: prabhakar.mahadev-lad.rj@bp.renesas.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:15:42 +0100
Message-ID: <2026112542-lushness-factor-b18f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f00afd5d8d5dc03994cb67246543d5c70571ebbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112542-lushness-factor-b18f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f00afd5d8d5dc03994cb67246543d5c70571ebbe Mon Sep 17 00:00:00 2001
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 1 Oct 2026 17:51:58 +0100
Subject: [PATCH] watchdog: rzv2h: Drop runtime PM handling from WDTDCR init

WDTDCR is located in the CPG region, outside the watchdog module, and is
accessible regardless of the watchdog's clocks and reset state.

Drop the unnecessary runtime PM handling from WDTDCR initialization and
access the register directly.

Fixes: f6febd0a30b6e ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20261001165201.763882-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 27ea0ad7e91c..c1c01ee7432c 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -257,20 +257,12 @@ static const struct watchdog_ops rzv2h_wdt_ops = {
 static int rzt2h_wdt_wdtdcr_init(struct platform_device *pdev,
 				 struct rzv2h_wdt_priv *priv)
 {
-	int ret;
-
 	priv->wdtdcr = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->wdtdcr))
 		return PTR_ERR(priv->wdtdcr);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret)
-		return ret;
-
 	rzt2h_wdt_wdtdcr_count_stop(priv);
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	return 0;
 }
 

