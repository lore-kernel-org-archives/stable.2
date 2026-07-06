Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC23BE15D;
	Mon,  6 Jul 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783321204; cv=none; b=UWJE+OQ0NtsXW/RXZPxG0jOjf7wDNAnq4HS9xrB4Z3B3VwcVMVbrcZ0dZl+lpDHWv2zOXETikmyhBLID2NEGtySr1SdQOYhDsX4GbgUPbeJeu2jsfKFcomlRs3RfEnBJCedrCDMvNH7zkTEirEmrTiJbyHXYnfcoyx6LnroOs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783321204; c=relaxed/simple;
	bh=jwL0g5dH7njtzSsEwuD5XFbdRBMtwYqheZmzk9XFmHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krethcX+Isn8rjKo9dqvr4eu44fYlfcDXHCuksfDOyaEVVVzHVM9vkMHZiY0YorHWfH9ZZPQx4i0mJ4rXhjommXsXAIGt2Ywvd4EDjNy0EuiaEq1DIR6LKXzpejc2Yz9m3JdJH+3tHSz2NnpfpjmwwqzrGia7+cPIEDirpEooJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn2OSR+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn2OSR+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688A61F000E9;
	Mon,  6 Jul 2026 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783321196;
	bh=f0esyvSou6XOjJdnHtKHcqUSq5aX2adAFR6jn3DxN+w=;
	h=From:To:Cc:Subject:Date;
	b=cn2OSR+wY+H9AjbL+MoRf7GMKGr0OKdSdK+RmhcSHvidP80vP1BMprRheDi4J0Asv
	 uEtsljRrCMjYbl3ROwchBrWXWP37/+41GV7QGw+EbTjW0x6mt/ccTfia+PUO2VFlSq
	 KwzGdYXOfT/qbU1WrqcW7Eoff/ER2/9K9r1dLN2xn3+fDqbGirxi9z39MgD7/4OEr4
	 Y3uyfn/zYA6O5kIcKb56aMOvJsGxDsgq08l6wSm/MXpvR2D8hxA/e/DcStKO8823r5
	 Rgst78jQYpiVNL8A/Zg6YlLJy04CBngptYjPr2C0xcj4BTxsoZUmW0Hl8K/DNuiZbq
	 F4o2Ts0hqYy+g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgdJ4-00000001dMX-0vbh;
	Mon, 06 Jul 2026 08:59:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH] media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
Date: Mon,  6 Jul 2026 08:59:27 +0200
Message-ID: <20260706065927.389604-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing sanity check after looking up the SCP to avoid
dereferencing a NULL-pointer in case its driver has not yet been bound.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Cc: stable@vger.kernel.org	# 6.1
Cc: Moudy Ho <moudy.ho@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This one applies on top of Guangshuo's fix:

	https://lore.kernel.org/r/20260704173119.254975-1-lgs201920130244@gmail.com

Johan


 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 5 +++++
 1 file changed, 5 insertions(+)

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
 
-- 
2.54.0

