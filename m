Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C391457E74
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128312; cv=none; b=heGXOxOFZuh8WUg24fXTKmJMYkVEazHIR3Ngwsd8axa++EncTAJPrIPC9YKzShlRsje6CVqNv8Y/7ezE6gPbTeTIwh4Z+cemq5HbRnEOp5kGEzk/RTv07ym+FVP882W7lbLbGv01ka0PlwWfeI947scgQBRymSPLCAnQ1OGH3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128312; c=relaxed/simple;
	bh=Mfmt7iIgpaUWeQ3dl4lL4mRRA/8qOEP4qbEkgWt2tiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o935hdLarXt15okAMfwovhfGI9a62gHiX3yUb0VOAh1JlXur+6gSE82T8w9wBot5NXaL45ho3Mb5ciizao8KTkpZWhnlOunsyG/sjh3B7oqVrwpDh380ME+L2dYpY4s315UZOZqF2lZteZTOIhdlonDXi6Yq2VgnMJv2AmY/41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYnEtk+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYnEtk+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DDA1F00893;
	Fri, 11 Sep 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128306;
	bh=WDncLsunaB/9GNxMKUA1DKo4/bag7pnCdp172/oiVCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYnEtk+FfgUECvIcgOHfP9nnufeHbpMBgc40K8DFg0ARBX7J009E/6NCaCxoGbGIP
	 ZeFe/0eikYheMTGFCl37T0AF4qTypUl3Lp8TTrwzxsa9JnzNx5SduItDkFquQQHGAI
	 FhKgAWgH6w8aMwhmrPriLv8eed7JpaEoypcpg3FufGRb/cojYvd8HX/iC8gE4OzaLu
	 +fwK5BnCq5YFx3tvLSxnnnjX+FySA88p0xte0xLZRginY9YCdBRSoTqK90ciOSmm45
	 Q4St/2vmqonSJABJO1qTRDWSPv785f0L4umaAKsmL835ATvf+YtFQYDod05va9hVIc
	 /XR6CSPWXfTkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
Date: Fri, 11 Sep 2026 08:05:04 -0400
Message-ID: <20260911120504.489672-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-unify-stoppage-ec5d@gregkh>
References: <2026090902-unify-stoppage-ec5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 90368323fb244da0504e3da37a182f8e89bcc3b9 ]

Add the missing sanity check after looking up the SCP to avoid
dereferencing a NULL-pointer in case its driver has not yet been bound.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Cc: stable@vger.kernel.org	# 6.1
Cc: Moudy Ho <moudy.ho@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ Adapted NULL-check placement to the older direct platform_get_drvdata() lookup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 97edcd9d1c817..9a11064ecfa95 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -241,6 +241,11 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_destroy_clock_wq;
 	}
 	mdp->scp = platform_get_drvdata(mm_pdev);
+	if (!mdp->scp) {
+		ret = -EPROBE_DEFER;
+		goto err_destroy_clock_wq;
+	}
+
 	mdp->rproc_handle = scp_get_rproc(mdp->scp);
 	dev_dbg(&pdev->dev, "MDP rproc_handle: %pK", mdp->rproc_handle);
 
-- 
2.53.0

