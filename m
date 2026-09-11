Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3650457E69
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127364; cv=none; b=WiBi9rQcXd+z6WsFUNd7NElqAC3VUN65hOi59TBe7/3f5XGpo1Kmj6BkbRwgoStbGpG5B8x0VS7T9fFhSFLQFxY+I5xhfCn6qA138frFFiNGcbCkLIYKJ9yqTeaQFO2ccmJjN+F7XUnGUa5Uvxh8XuZlAIgbR3WfyY7mWbmaaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127364; c=relaxed/simple;
	bh=HRli4f9k/DR0ONWSzBleLcDa/2HAPDrgmL6oSfjS37s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX/iscB1ZBkq6uoUlO3pvuOX939mARnK2U9OjOBd020BUCHFVw5fCbNj4SeHM4Vjnmz9TdNz6NMDPJCQHT83VsHkR9bo/ilwKx9nXaNrONRXZX2Uz9Fl0QKeS4bV6l9JJm0CNbvTd7L3SsTqnRfHNWHSmXsQcXJlru4cIrJE9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYrtg0wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYrtg0wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B05D1F000FF;
	Fri, 11 Sep 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789127362;
	bh=CzZNePHH+sYs+hbXdr2aV2vo8xcDXlwPyb8lH9AdXzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYrtg0wk/GimB3iejMeMaoOrDBDZZ6hnhbKONDwCBw6OsBEi+Z1M6IE9dm62W4yRS
	 YzxRijSk12bjwbOyXRtLRBxECpgTEeAyiKqR9QDY8kKiT3U3UJT0t12WLUse1Y+6pM
	 naV4P6Cq4DqR6QQSUmfKDN1QUac2vFyALbUs+NBnvqvBocH5uK4M3zVcyZF44/iQx8
	 ayXUR6+OLk5H1A3s1kKZL2DEQW10iVPt6XYoNSKeH7uBJ+2DwEAJQhoxvYfVGFdtDA
	 x4SCk3AEOFS7ravFlcmN8qM/3/5EGp7Gh7aLhpJNQ94X6u7PPKNZcukqRSHoCcwK6H
	 L7FNArA7Qxxfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Moudy Ho <moudy.ho@mediatek.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: platform: mtk-mdp3: fix NULL deref on failed SCP lookup
Date: Fri, 11 Sep 2026 07:49:20 -0400
Message-ID: <20260911114920.461269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090902-childlike-retreat-8753@gregkh>
References: <2026090902-childlike-retreat-8753@gregkh>
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
index cc44be10fdb77..50d1458339343 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -215,6 +215,11 @@ static int mdp_probe(struct platform_device *pdev)
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

