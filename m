Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEA51120E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951313; cv=none; b=DVgSu4+PsyiYMZeztDU9ih938msh2CiNLf3cV1TvbY5knsXjLpM08u6oS0B5vi9rNXYhu/Yv8FHC4fnc7ooKcyilNLHcfq8aWzBVKDEmobtbBBTixteAlGwvK4TVcIRBv0nQieYK33+T0TYTEeBI7gqq3OQ4rpCS6nJyP15cw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951313; c=relaxed/simple;
	bh=/lA8Y2n9nuklr94cUBP+KKDEvQuOElU7is+YMK74gRA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mck0GgsOxqY2EePt9Hz4zUfsJqJWdUaKa5CErb930M2hcUwpbI1voRNFYO6eHT/zKt4lFpPyFHKoVjVGyYIZqe33ZbLjFjWRiU12Zy7a0Ukw0mOCOAAcaiJFjwTDUkgHV78aFmpPFUKrkTJcNljaBx/esRRDaagZf6Wgv2KbnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYUZPW0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYUZPW0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D471B1F00A3A;
	Wed,  9 Sep 2026 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951312;
	bh=z2EFZGiHWWnrX/Ir6s1xwyJRLnTYUIF22rk1joww6SY=;
	h=Subject:To:Cc:From:Date;
	b=IYUZPW0Se2svCkOA4v59jpkobg1QRdC4w2e4UNeY+qjGhf9EFN/rOLOcr4AYRLwFS
	 3BG0MoA+7NFylB7c9Del9RYhVotQYncTV9dbYVwNAAPzRNxYfevXkv8D4up+lDRHR7
	 o7l66Xi019fDDL+7iTXI+ggE3cDRkzztWE++dW2g=
Subject: FAILED: patch "[PATCH] media: platform: mtk-mdp3: fix NULL deref on failed SCP" failed to apply to 6.6-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org,moudy.ho@mediatek.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:47:02 +0200
Message-ID: <2026090902-childlike-retreat-8753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 90368323fb244da0504e3da37a182f8e89bcc3b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090902-childlike-retreat-8753@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90368323fb244da0504e3da37a182f8e89bcc3b9 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 6 Jul 2026 08:59:27 +0200
Subject: [PATCH] media: platform: mtk-mdp3: fix NULL deref on failed SCP
 lookup

Add the missing sanity check after looking up the SCP to avoid
dereferencing a NULL-pointer in case its driver has not yet been bound.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Cc: stable@vger.kernel.org	# 6.1
Cc: Moudy Ho <moudy.ho@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 121b1006ffdc..f412aadb5996 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -296,6 +296,11 @@ static int mdp_probe(struct platform_device *pdev)
 		mdp->scp = platform_get_drvdata(mm_pdev);
 	}
 
+	if (!mdp->scp) {
+		ret = -EPROBE_DEFER;
+		goto err_destroy_clock_wq;
+	}
+
 	mdp->rproc_handle = scp_get_rproc(mdp->scp);
 	dev_dbg(&pdev->dev, "MDP rproc_handle: %p", mdp->rproc_handle);
 

